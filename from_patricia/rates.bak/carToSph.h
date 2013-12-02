// **********************************************
//
// qvec.cpp
//
// Determines variables that will be input into 
// ptrates to find the rates for b1.
//
// Adapted from qvec.f by Karl Slifer
//
// Elena Long
// 2013-03-28
//
// **********************************************

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <cmath>
using namespace std;


// Translate from cartesian to spherical coordinates
int carToSph(double x[], double &r, double &th, double &phi)
{
	double pi = acos(-1);
	double r1 = x[0]*x[0] + x[1]*x[1];
	r = sqrt(r1+x[2]*x[2]);
	r1 = sqrt(r1);

	if (r < 1e-12)
	{
		th = 0;
		phi = 0;
		return 0;
	}
	else 
	{
		if (r == 0)
		{
			phi = 0;
			th = 0;
			if (x[2] < 0) {th=pi;}
			return 0;
		}
		else
		{
//			cout << "th = " << th << endl;
//			cout << "x[2] = " << x[2] << endl;
//			cout << "r = " << r << endl;
			th = acos(x[2]/r);
//			cout << "th = " << th << endl;
			phi = atan2(x[1],x[0]);
//			cout << "Spin 3: x[2] = " << x[2] << ", r = " << r << ", th = " << th << endl;
			return 0;
		}
	}
	
	return 0;
}


