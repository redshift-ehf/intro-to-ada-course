/*  The C half of the Foreign Subprograms lesson. */

int fs_twice (int a)
{
    return a * 2;
}

int fs_clamp (int value, int low, int high)
{
    if (value < low)  return low;
    if (value > high) return high;
    return value;
}
