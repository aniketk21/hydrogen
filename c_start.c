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

int c_start() {
    int i, j;
    char *hello = "Hello, World!";
    char *buffer = (char *)0xB8000;
    i = 0;
    while(i < 80 * 25 * 2) {
        buffer[i] = ' '; /* Empty char */
        buffer[i + 1] = 0x00; /* Black */
        i += 2;
    }
    i = 0;
    j = 0;
    while(hello[i] != '\0') {
        buffer[j] = hello[i];
        buffer[j+1] = 0x04; /* Red  */
        i++;
        j += 2;
    }
    return 0;
}
