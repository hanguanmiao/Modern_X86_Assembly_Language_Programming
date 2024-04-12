#include <iostream>
#include <iomanip>

using std::cout;
using std::endl;

extern "C" int IntegerMulDiv_(int a, int b, int* prod, int* quo, int* rem);

int main(int argc, char *argv[]) {
	int a = 21, b = 9;
	int prod = 0, quo = 0, rem = 0;
	int rc;

	rc = IntegerMulDiv_(a, b, &prod, &quo, &rem);
	cout << " Input1 - a:  " << std::right << std::setw(4) << a   << "  b:   " 
		<< std::right << std::setw(4) << b << endl;
	cout << "Output1 - rc: " << std::right << std::setw(4) << rc  << "  prod:" 
		<< std::right << std::setw(4) << prod << endl;
	cout << "          quo:" << std::right << std::setw(4) << quo << "  rem: "
		<< std::right << std::setw(4) << rem << endl << endl;

	a=-29;
	prod = quo = rem = 0;
	rc = IntegerMulDiv_(a, b, &prod, &quo, &rem);
	cout << " Input1 - a:  " << std::right << std::setw(4) << a << "  b:   "
		<< std::right << std::setw(4) << b << endl;
	cout << "Output1 - rc: " << std::right << std::setw(4) << rc << "  prod:"
		<< std::right << std::setw(4) << prod << endl;
	cout << "          quo:" << std::right << std::setw(4) << quo << "  rem: "
		<< std::right << std::setw(4) << rem << endl << endl;

	b=0;
	prod = quo = rem = 0;
	rc = IntegerMulDiv_(a, b, &prod, &quo, &rem);
	cout << " Input1 - a:  " << std::right << std::setw(4) << a << "  b:   "
		<< std::right << std::setw(4) << b << endl;
	cout << "Output1 - rc: " << std::right << std::setw(4) << rc << "  prod:"
		<< std::right << std::setw(4) << prod << endl;
	cout << "          quo:" << std::right << std::setw(4) << quo << "  rem: "
		<< std::right << std::setw(4) << rem << endl << endl;

	return 0;
}