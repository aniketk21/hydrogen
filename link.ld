/* 
 * This  is a  linker _template_  file.
 */
ENTRY(asm_start)
OUTPUT_FORMAT("elf32-i386")
OUTPUT(hydrogen)
SEARCH_DIR(/home/aniketk/hydrogen/)
MEMORY
  {
     oscode  (rx) : ORIGIN = 0x100000,  l = 1M
     osdata  (rx) : ORIGIN = 0x200000,  l = 1M
     osstack (rx) : ORIGIN = 0x300000,  l = 1M
  }
