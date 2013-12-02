#ifndef _TNiel_
#define _TNiel_


#include <iostream>
#include <fstream>
#include <stdio.h>
#include <iomanip>
#include "TSystem.h"
#include "TString.h"
using namespace std;

class TNiel{


 private:


  TString fInFile;
  
  double nielfactor[1710]; // the longer file is the one for neutron with 1708 values
  double E_nielfactor[1710];
  int niel_N;
  

 public:
  
  TNiel(Char_t* FileName); 
  double GetNielFactor(double EMeV);

};
#endif
