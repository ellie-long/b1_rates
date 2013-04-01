#include "mathlink.h"

void InitAlphaS(int IORD, double FR2, double MUR, double ASMUR,
		double MC, double MB, double MT) {
  void initalphas_(int *IORD, double *FR2, double *MUR, double *ASMUR,
		   double *MC, double *MB, double *MT);
  initalphas_(&IORD, &FR2, &MUR, &ASMUR, &MC, &MB, &MT);
}

double AlphaS(double MUR) {
  double alphas_(double *MUR);
  return alphas_(&MUR);
}

int main(int argc, char *argv[]) {
  return MLMain(argc, argv);
}
