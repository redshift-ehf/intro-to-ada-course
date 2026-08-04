/*  C that calls Ada. Neither name below is defined here -- both come from c_statistics.ads,
 *  which Exports them under exactly these spellings.
 */

extern int ada_mean (int a, int b);
extern int ada_call_count;

int summarise (int a, int b)
{
    ada_call_count++;
    return ada_mean (a, b);
}

int summarise_three (int a, int b, int c)
{
    return summarise (summarise (a, b), c);
}
