// MemoryAddressing.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>

extern "C" int NumFibVals_;
extern "C" int MemoryAddressing_(int i, int* v1, int* v2, int* v3, int* v4);

int main(int argc, char *argv[])
{
	for (int i = -1; i < NumFibVals_+1; ++i) {
		int v1 = -1, v2 = -1, v3 = -1, v4 = -1;
		int rc = MemoryAddressing_(i, &v1, &v2, &v3, &v4);

		std::cout << "i: " << std::right << std::setw(2) << i << "  rc: " << std::right << std::setw(2) << rc
			<< "  v1: " << std::right << std::setw(4) << v1 << "  v2: " << std::right << std::setw(4) << v2 
			<< "  v3: " << std::right << std::setw(4) << v3 << "  v4: " << std::right << std::setw(4) << v4 << std::endl;
	}

	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
