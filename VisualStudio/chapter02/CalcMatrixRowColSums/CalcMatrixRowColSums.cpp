#include <cstdio>
#include <cstdlib>


// The function PrintResults is defined in CalcMatrixRowColSumsMisc.cpp
static void PrintResults(const int* x, int nrows, int ncols, int* row_sums, int* col_sums);
extern "C" int CalcMatrixRowColSums_(const int* x, int nrows, int ncols, int* row_sums, int* col_sums);

void CalcMatrixRowColSumsCpp(const int* x, int nrows, int ncols, int* row_sums, int* col_sums)
{
    for (int j = 0; j < ncols; j++)
        col_sums[j] = 0;

    for (int i = 0; i < nrows; i++)
    {
        row_sums[i] = 0;
        int k = i * ncols;

        for (int j = 0; j < ncols; j++)
        {
            int temp = x[k + j];
            row_sums[i] += temp;
            col_sums[j] += temp;
        }
    }
}

int main(int argc, char* argv[])
{
    const int nrows = 7, ncols = 5;
    int x[nrows][ncols];

    // Initialize the test matrix
    srand(13);
    for (int i = 0; i < nrows; i++)
    {
        for (int j = 0; j < ncols; j++)
            x[i][j] = rand() % 100;
    }

    // Calculate the row and column sums
    int row_sums1[nrows], col_sums1[ncols];
    int row_sums2[nrows], col_sums2[ncols];

    CalcMatrixRowColSumsCpp((const int*)x, nrows, ncols, row_sums1, col_sums1);
    printf("\nResults using CalcMatrixRowColSumsCpp()\n");
    PrintResults((const int*)x, nrows, ncols, row_sums1, col_sums1);

    CalcMatrixRowColSums_((const int*)x, nrows, ncols, row_sums2, col_sums2);
    printf("\nResults using CalcMatrixRowColSums_()\n");
    PrintResults((const int*)x, nrows, ncols, row_sums2, col_sums2);

    return 0;
}


static void PrintResults(const int* x, int nrows, int ncols, int* row_sums, int* col_sums)
{
    for (int i = 0; i < nrows; i++)
    {
        for (int j = 0; j < ncols; j++)
            printf("%5d ", x[i * ncols + j]);
        printf(" -- %5d\n", row_sums[i]);
    }
    printf("\n");

    for (int i = 0; i < ncols; i++)
        printf("%5d ", col_sums[i]);
    printf("\n");
}