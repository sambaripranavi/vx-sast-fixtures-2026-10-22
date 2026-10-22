/* Known-vulnerable benchmark cases. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* FX-BEGIN C-V01 */
void copy_name(const char *input) {
    char buf[16];
    strcpy(buf, input);
    puts(buf);
}
/* FX-END C-V01 */

/* FX-BEGIN C-V02 */
void format_greeting(const char *input) {
    char buf[32];
    sprintf(buf, "Hello %s", input);
    puts(buf);
}
/* FX-END C-V02 */

/* FX-BEGIN C-V03 */
void read_line(void) {
    char buf[64];
    gets(buf);
    puts(buf);
}
/* FX-END C-V03 */

/* FX-BEGIN C-V04 */
void log_message(const char *input) {
    printf(input);
}
/* FX-END C-V04 */

/* FX-BEGIN C-V05 */
void ping_host(const char *host) {
    char cmd[128];
    snprintf(cmd, sizeof cmd, "ping -c 1 %s", host);
    system(cmd);
}
/* FX-END C-V05 */

/* FX-BEGIN C-V06 */
FILE *open_temp(void) {
    char *name = tmpnam(NULL);
    return fopen(name, "w");
}
/* FX-END C-V06 */

/* FX-BEGIN C-V07 */
unsigned int session_token(void) {
    return (unsigned int)rand();
}
/* FX-END C-V07 */

int main(int argc, char **argv) {
    if (argc > 1) {
        copy_name(argv[1]);
        format_greeting(argv[1]);
        log_message(argv[1]);
        ping_host(argv[1]);
    }
    read_line();
    open_temp();
    return (int)session_token() & 0;
}
