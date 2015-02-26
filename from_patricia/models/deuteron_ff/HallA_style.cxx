#include "TStyle.h"

void HallA_style() {
// void styling() {
  TStyle* hallaStyle = new TStyle("HALLA","Hall A suggested style");

  hallaStyle->SetPaperSize(TStyle::kUSLetter);
  hallaStyle->SetPaperSize(18,22);
  hallaStyle->SetPalette(1);      // pretty-pallete

  // black and white pad default
  hallaStyle->SetFrameBorderMode(0);
  hallaStyle->SetCanvasBorderMode(0);
  hallaStyle->SetPadBorderMode(0);
  hallaStyle->SetPadColor(0);
  hallaStyle->SetCanvasColor(0);
  hallaStyle->SetStatColor(0);
  hallaStyle->SetFrameFillColor(kWhite);
  // CHANGEME
//  hallaStyle->SetFillColor(0);

  hallaStyle->SetPadTopMargin(.05);
  hallaStyle->SetPadLeftMargin(.15);
  hallaStyle->SetPadRightMargin(.1);
  hallaStyle->SetPadBottomMargin(.15);
  hallaStyle->SetTitleYOffset(1.2);

  hallaStyle->SetLabelFont(42,"X");
  hallaStyle->SetLabelFont(42,"Y");
  hallaStyle->SetLabelFont(42,"Z");
  hallaStyle->SetLabelSize(0.045,"X");
  hallaStyle->SetLabelSize(0.045,"Y");
  hallaStyle->SetLabelSize(0.045,"Z");

  hallaStyle->SetTitleFont(62,"X");
  hallaStyle->SetTitleFont(62,"Y");
  hallaStyle->SetTitleFont(62,"Z");
  hallaStyle->SetTitleSize(0.06,"X");
  hallaStyle->SetTitleSize(0.06,"Y");
  hallaStyle->SetTitleSize(0.06,"Z");

  hallaStyle->SetTextFont(42);
  hallaStyle->SetTextSize(0.8);

  hallaStyle->SetNdivisions(505,"X");
  hallaStyle->SetNdivisions(505,"Y");
  hallaStyle->SetNdivisions(505,"Z");

  hallaStyle->SetMarkerStyle(1);
  hallaStyle->SetHistLineWidth(1.5);
  hallaStyle->SetFuncWidth(2);
  hallaStyle->SetFuncColor(2);
  hallaStyle->SetPadTickX(1);
  hallaStyle->SetPadTickY(1);

  // prepare hallaStyle to be useful
  //   1 = solid
  //   2 = long dash (30 10)
  //   3 = dotted (4 8)
  //   4 = dash-dot (15 12 4 12)
  //   5 = short dash ( 15 15 )
  //   6 = dash-dot-dot 
  hallaStyle->SetLineStyleString(1,"[]");
  hallaStyle->SetLineStyleString(2,"[30 10]");
  hallaStyle->SetLineStyleString(3,"[4 8]");
  hallaStyle->SetLineStyleString(4,"[15 12 4 12]");
  hallaStyle->SetLineStyleString(5,"[15 15]");
  hallaStyle->SetLineStyleString(6,"[15 12 4 12 4 12]");

  // default plot features. Keep fit parameters visible
  // The title can be later as can the raw statistics
  hallaStyle->SetOptDate(0);
  hallaStyle->SetDateY(.98);
  hallaStyle->SetOptFit(1111);
  hallaStyle->SetOptStat(0);
  hallaStyle->SetOptTitle(0);

  hallaStyle->SetStripDecimals(kFALSE);

  //  gROOT->SetStyle("HALLA");
}
