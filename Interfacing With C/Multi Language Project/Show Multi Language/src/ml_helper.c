/*  An ordinary C file, sitting in a task's src/ directory beside the Ada.
 *
 *  gprbuild compiles it because course.gpr says `for Languages use ("Ada", "C")`. Nothing else
 *  is needed: no separate build step, no makefile, no linker flags.
 */

int ml_double (int x)
{
    return x * 2;
}

double ml_half (double x)
{
    return x / 2.0;
}
