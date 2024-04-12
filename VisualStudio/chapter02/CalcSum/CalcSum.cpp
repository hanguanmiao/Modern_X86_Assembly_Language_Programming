#include <iostream>

extern "C" int CalcSum_(int a, int b, int c);

int main(int argc, char* argv[])
{
    int a = 17, b = 11, c = 14;
    int sum = CalcSum_(a, b, c);

    std::cout << "a:  " << a << std::endl;
    std::cout << "b:  " << b << std::endl;
    std::cout << "c:  " << c << std::endl;
    std::cout << "sum:  " << sum << std::endl;

    return 0;
}

