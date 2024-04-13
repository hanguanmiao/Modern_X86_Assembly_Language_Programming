// CallingConvention.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>

extern "C" void CalculateSums_(int a, int b, int c, int* s1, int* s2, int* s3);

int main(int argc, char *argv[])
{
	int a = 3, b = 5, c = 8;
	int s1a, s2a, s3a;

	CalculateSums_(a, b, c, &s1a, &s2a, &s3a);

	int s1b = a + b + c;
	int s2b = a * a + b * b + c * c;
	int s3b = a * a * a + b * b * b + c * c * c;

	std::cout << "Input:  a:  " << std::right << std::setw(4) << a <<   "  b:  " << std::right << std::setw(4) << b <<   "  c:" << std::right << std::setw(4) << c << std::endl;
	std::cout << "Output: s1a:" << std::right << std::setw(4) << s1a << "  s2a:" << std::right << std::setw(4) << s2a << "  s3a:" << std::right << std::setw(4) << s3a << std::endl;
	std::cout << "        s1b:" << std::right << std::setw(4) << s1b << "  s2b:" << std::right << std::setw(4) << s2b << "  s3b:" << std::right << std::setw(4) << s3b << std::endl;

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
