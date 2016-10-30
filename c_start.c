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
