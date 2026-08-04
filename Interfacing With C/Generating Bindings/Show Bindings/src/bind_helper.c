/*  Stands in for a third-party C library you did not write and cannot change.
 *
 *  Its header would be:
 *
 *      extern int bind_scale;
 *      int bind_add (int a, int b);
 *
 *  and `gcc -c -fdump-ada-spec -C bind_helper.h` turns that header into an Ada spec.
 */

int bind_scale = 1;

int bind_add (int a, int b)
{
    return (a + b) * bind_scale;
}
