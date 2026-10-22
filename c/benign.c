/* Benign lookalikes: same functions as vulnerable.c, used safely. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* FX-BEGIN C-B01 */
void copy_label(void) {
    char buf[32];
    strcpy(buf, "fixed label");
    puts(buf);
}
/* FX-END C-B01 */

/* FX-BEGIN C-B02 */
void format_greeting(const char *input) {
    char buf[32];
    snprintf(buf, sizeof buf, "Hello %s", input);
    puts(buf);
}
/* FX-END C-B02 */

/* FX-BEGIN C-B03 */
void read_line(void) {
    char buf[64];
    if (fgets(buf, sizeof buf, stdin) != NULL) {
        puts(buf);
    }
}
/* FX-END C-B03 */

/* FX-BEGIN C-B04 */
void log_message(const char *input) {
    printf("%s\n", input);
}
/* FX-END C-B04 */

/* FX-BEGIN C-B05 */
void copy_bytes(const unsigned char *src, size_t len) {
    unsigned char dst[64];
    if (len > sizeof dst) {
        return;
    }
    memcpy(dst, src, len);
}
/* FX-END C-B05 */

int main(int argc, char **argv) {
    copy_label();
    read_line();
    if (argc > 1) {
        format_greeting(argv[1]);
        log_message(argv[1]);
        copy_bytes((const unsigned char *)argv[1], strlen(argv[1]));
    }
    return 0;
}
