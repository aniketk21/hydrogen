/************************************************************************
    Hydrogen: A bare-bones kernel.
    Copyright (C) 2016  Aniket Kulkarni kaniket21@gmail.com
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*************************************************************************/

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
