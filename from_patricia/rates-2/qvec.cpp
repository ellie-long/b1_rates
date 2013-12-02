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
#include "carToSph.h"
#include "rotation.h"
using namespace std;

int main()
{

	const int nl = 1000;
	const int ne = 6;
	int i, k, ix, iq;
	double E0_pass, th_pass, Ep_pass;
	double rr1, rr2, phiStar, thStar, xnu;
	double angle[nl][ne];
	double angle_r, pi, mp;
	double x2, Q2, nu, W2, W, thRad, th, th_min, cosQVec;
	double W2_GeV, sin2;
//	double xval[5] = {0.15, 0.25, 0.35, 0.45, 0.55};
//	double thval[5] = {12.5, 9.5, 13.16, 10.32, 12.5};
	double xval[5] = {0.1, 0.5, 1.0, 0.3, 0.75};
	double thval[5] = {0, 0, 0, 0, 0};

// Heads up: VPLRZ contains E0_pass, th_pass, and Ep_pass;

	pi = acos(-1);
	mp = 938.272;		// MeV
	E0_pass = 11000;	// MeV

	cout << "	  x	   Q2	   W	   Ep	Th0	   Thq	 cos(q)	" << endl;

	for (int ix=0; ix<5; ix++)
	{
		x2 = xval[ix];
		th_pass = thval[ix];
		thRad = th_pass*pi/180;
		sin2 = pow((sin(thRad/2)),2);
		Q2 = (4*pow(E0_pass,2)*sin2)/(1+(4.0*E0_pass*sin2/2/mp/x2));
		W2 = mp*mp + Q2/x2 - Q2;
		W2_GeV = W2*1e-6;
		if (W2_GeV > 0)
		{
			W = sqrt(W2);
			Ep_pass = E0_pass - Q2/2/mp/x2;

			rr1 = 0.0;
			rr2 = 180;
//			cout << "Before rotation(), thStar=" << thStar << endl;
			rotation(rr1, rr2, phiStar, thStar, E0_pass, Ep_pass, th_pass);
//			cout << "After rotation(), thStar=" << thStar << endl;
			k = 1;
			i = 1;
			angle[k][i] = 180-thStar;
			angle_r = angle[k][i]*pi/180;
			cosQVec = cos(angle_r);
			cout << "	" << xval[ix] << "	" << Q2*1e-6 << "	" << W*1e-3 << "	" << Ep_pass*1e-3 << "	" << th_pass << "	" << angle[k][i] << "	" << cosQVec << endl;
		}
	}
		
	return 0;
}


