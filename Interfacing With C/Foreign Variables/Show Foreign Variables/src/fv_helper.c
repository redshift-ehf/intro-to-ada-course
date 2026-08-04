/*  A C global, and a function that changes it. */

int fv_call_count = 0;

int fv_my_func (int a)
{
    fv_call_count++;
    return a * 2;
}

/*  Declared here, defined in Ada: a variable this time rather than a function. */
extern int fv_from_ada;

void fv_bump_ada (void)
{
    fv_from_ada += 100;
}
