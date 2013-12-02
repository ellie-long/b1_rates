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

int rotation(double &phit, double &thet, double &phi, double &thr, double E0, double Ep, double th)
{
	double pi;
//	double phit, thet, phi, thr;
	double csp, snp, cst, snt, cosThs, qVec;
//	double E0, th, Ep;
	double csThEq, snThEq, rr;
	double x[3];

	pi = acos(-1);

//	cout << "thet = " << thet << endl;
	csp = cos(phit*pi/180);
	snp = sin(phit*pi/180);
	cst = cos(thet*pi/180);
	snt = sin(thet*pi/180);
	cosThs = cos(th*pi/180);
	qVec = sqrt(E0*E0+Ep*Ep-2*E0*Ep*cosThs);

//	cout << "qVec = " << qVec << ", E0 = " << E0 << ", Ep = " << Ep << ", cosThs = " << cosThs << endl;

	if (abs(th-180)<1e-6)
	{
		csThEq = 1.0;
		snThEq = 0.0;
	}
	else
	{
		csThEq = (E0-Ep*cosThs)/qVec;
		snThEq = sqrt(1-pow(csThEq,2));
	}

//	cout << "snp = " << snp << ", csp = " << csp << ", snt = " << snt << ", cst << " << cst << ", snThEq = " << snThEq << ", csThEq = " << csThEq << endl;
//	cout << "x[0] = " << x[0] << ", x[1] = " << x[1] << ", x[2] = " << x[2] << endl;
	x[0] = snt*csp*csThEq + cst*snThEq;
	x[1] = snt*snp;
	x[2] = -snt*csp*snThEq + cst*csThEq;

//	cout << "x[0] = " << x[0] << ", x[1] = " << x[1] << ", x[2] = " << x[2] << endl;
//	cout << "Before carToSph(), thr = " << thr << endl;
	carToSph(x, rr, thr, phi);
//	cout << "After carToSph(), thr = " << thr << endl;

	if (abs(rr-1)>1e-6) {cout << "ERROR?? rr" << endl; return 0;}

	thr = thr*180/pi;
	phi=phi*180/pi;
}





