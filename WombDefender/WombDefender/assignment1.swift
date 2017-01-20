#include <stdio.h>
#include <iostream>

using namespace std;

int main() {
    double x;
    double y;
    double average;
    
    cin >> x;
    cin >> y;
    
    average = (x+y)/2;
    
    cout << "Average of " << x << " and " << y << " is " << average << endl;
    
    return 0;
}
