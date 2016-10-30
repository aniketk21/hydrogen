#!/bin/bash

# Directory structure ... same as in the top level Makefile.
SOSTOP=$(pwd)
SRCDIR=${SOSTOP}/src
BINDIR=${SOSTOP}/bin
INCDIR=${SOSTOP}/include
LIBDIR=${SOSTOP}/lib
BLDDIR=${SOSTOP}/build
DOCDIR=${SOSTOP}/doc

FLOPPYIMAGE=${SOSTOP}/references/grub.img

#
# Pretty print. Prints (some) arguments nicely.
#
function pp ()
{
    local top="$@"
    local st=$(echo ${SOSTOP} | sed -e "s/\//\\\\\\//g")
    local ans=$(echo $top | sed -e "s/${st}/\\\${SOSTOP}/")

    [ "$top" == "$SOSTOP" ]   && ans=$SOSTOP

    printf "%s" "${ans}"
}

function usage ()
{
    local n=$(basename $1)

    printf "Usage: %s %s %s\n"  $n "<Path to kernel binary>" "<Path to grub image to be made>"
}

function sanity_checks ()
{
    [ "$(id -u)" != "0" ]                                   && \
	printf "NOT ROOT. Run as: \"sudo %s %s\"\n" $0 "$*" && \
	/bin/false
    
    [ ! -s ${KERNELBINPATHNAME} ]                                    && \
	printf "KERNEL NOT FOUND ... Cannot build BOOT image ... \n" && \	
	/bin/false
}

function print_setup ()
{
    local k=$(basename $KERNELBINPATHNAME)
    local g=$(basename $GRUBBINPATHNAME)
    local kd=$(dirname $KERNELBINPATHNAME)
    local gd=$(dirname $GRUBBINPATHNAME)
    local kt=$(cat ${SRCDIR}/setup.ld        | \
    	       grep -i output_format         | \
    	       sed -e "s/OUTPUT_FORMAT(//"   | \
    	       sed -e "s/)//"                | \
    	       awk '{printf ("%s ", $0)}')

    printf "%-35s\n"      "~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    printf "%-35s : %s\n" "~ Kernel build type"           "$kt"
    printf "%-35s : %s\n" "~ Kernel name"                 $k
    printf "%-35s : %s\n" "~ Grub boot file name"         $g
    printf "%-35s : %s\n" "~ Kernel directory"            $(pp $kd)
    printf "%-35s : %s\n" "~ Grub boot file directory"    $(pp $gd)
    printf "%-35s : %s\n" "~ Full Kernel name"            $(pp $KERNELBINPATHNAME)
    printf "%-35s : %s\n" "~ Full Grub boot file name"    $(pp $GRUBBINPATHNAME)
    printf "%-35s\n"      "~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

function buildbootimage ()
{
    local k=$1
    local g=$2
    local bk=$(basename $k)
    local pk=$(pp $k)
    local bag=$(basename $g)
    local pb=$(pp $g)
    local d=$(dirname $k)
    local md=/mnt/sos
    local l=/dev/loop0
    local r=${d}/ROS

    printf "================ Building BOOT system ================\n"
    printf "%-35s : %s\n" "Creating boot image"  $bag
    printf "%-35s : %s\n" "Using kernel"         $bk
    printf "%-35s : %s\n" "SOSTOP"               $SOSTOP

    [ ! -s ${g} ]                                                              && \
	printf "   %-32s : %s " "Copying a prebuilt boot image" ${FLOPPYIMAGE} && \
	cp -f ${FLOPPYIMAGE} ${g}                                              && \
	printf "Done.\n"                                                       || \
	printf "   %-32s : %s\n" "Found a prebuilt boot image" "$(pp ${g})"

    printf "   %-32s : %s\n" "Preparing loop device" $l            && \
	losetup ${l} ${g}                                          && \
	printf "   %-32s : %s\n" "Checking mount point" ${md}      && \
	[ ! -d ${md} ] && mkdir ${md} || mount ${l} ${md}          && \
	printf "   %-32s : %s\n" "Copying kernel" "${pk}"          && \
	printf "   %-32s : %s\n" "To" "${md}"                      && \
	cp ${k} ${md}                                              && \
	sync                                                       && \
	printf "   %-32s : %s\n" "Unmounting loop device" ${l}     && \
	umount ${l}                                                && \
	printf "   %-32s : %s\n" "Decomissioning loop device" $l   && \
	losetup -d ${l}                                            && \
	printf "   %-32s : %s\n" "Setting file ownership of" ${pb} && \
	chown aniketk ${g}                                         && \
	print_setup                                                && \
	printf "All done.\n"                                       || \
	( printf "ERROR building boot image.  See the log file.\n" ; /bin/false; )
}

[ "$#" == "2" ]                                        && \
    KERNELBINPATHNAME=$1                               && \
    GRUBBINPATHNAME=$2                                 || \
    ( usage $0 && exit )

# Ok do the main job ... ;-)
buildbootimage $KERNELBINPATHNAME $GRUBBINPATHNAME
