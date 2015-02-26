#ifndef HALLA_PLOTTING_H
#define HALLA_PLOTTING_H

#include <TLatex.h>
#include <TGraphAsymmErrors.h>
#include <TStyle.h>
#include <iostream>
#include <TROOT.h>
#include <TList.h>
#include <TH1.h>
#include <TMath.h>

// helpful header to make plotting easier
// Author: Robert Feuerbach  18-Nov-2004

//enum Ecolors { kBlack=1, kRed=2, kGreen, kBlue, kYellow, kMagenta, kLtBlue, kGreen2 };

typedef struct {
  const char* filename;
  const char* label;
  const char* Xf;
  const char* Yf;
  const char* eYlf;
  const char* eYhf;
  const char* eXlf;
  const char* eXhf;
  int style;
  int color;
  const char* lnpt;
} datafile_t;

int def_yaxis_pos=1;

// handle the marker and line-types
Style_t mtypes[] = { 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 0 };
Style_t ltypes[] = { 1, 2, 3, 4, 0 };
Style_t ctypes[] = { 1, 2, 3, 4, 6, 7, 8, 9, 0 };

int mind=0, lind=0; // indices to the marker/line types
int cind=0;

TGraphAsymmErrors* OneGraph(datafile_t* f);
TGraph* toerror_band(TGraphAsymmErrors* gr);
TMultiGraph* BuildGraphs( const char* name, const char* title, datafile_t *df, int forcept=0 );
void positionLegend(TLegend *leg, Double_t ensz, int align=1);


TGraphAsymmErrors* OneGraph(const char* filename,
		       int color=1, int style=0,
		       const char* label="data",
		       const char* xf="[0]", const char* yf="[1]",
		       const char* eyl="[2]", const char* eyh=0,
		       const char* exl="0", const char* exh=0) {
  //  Creates and returns a TGraph with y-error-bars.
  //
  // Input:
  //  filename       Name of the file with the data ordered by columns;
  //                 the columns are separated by only whitespace.
  //                 The format is described more completely below.
  //
  // Optional
  //  color          Color for the datapoints/lines (see TAttMarker/TAttLine)
  //  style          Style for the datapoints/lines (see TAttMarker/TAttLine)
  //                  or the 'reference sheet'
  //
  //  label          a name to assign to this dataset.
  //
  //  xf,yf          expressions for the x,y, and negative/positive uncertainties
  //  eyl,eyh        on y. These are made into formulas, where the columns of
  //  exl,exh        a given row are read in as parameters.
  //                 To make it easier for the symmetric case, if exh=0 or 
  //                 eyh=0 and the corresponding 'low' limit (exl or eyl)
  //                 is given, the same expression will be used.
  //
  // Output:
  //   returns a pointer to a TGraphAsymmErrors.
  //
  // Simple example: first column is 'x', second column is 'y',
  //                 third column is the error on y (symmetric):
  //
  //  TGraphAsymmErrors *gr = OneGraph("mydata.dat",kBlack,0,"datafile",
  //                          "[0]","[1]","[2]");
  //
  // In the datafile 'filename', lines beginning with a '#' are skipped,
  // as are blank lines. The columns are separated by white space only.
  //
  
  datafile_t f = { filename, label, xf, yf, eyl, eyh, exl, exh, style, color };
  TGraphAsymmErrors *gr = OneGraph(&f);
  return gr;
}

TGraphAsymmErrors* OneGraph(datafile_t* f) {
  // open the file, parse it line-by-line
  // 
  // assuming at most 20 columns in the datafile (will break someday),

  Double_t parms[20];
  int warned=0;
  memset(parms,0,20*sizeof(parms[0]));
  FILE *fp = fopen(f->filename,"r");
  if (!fp) {
    std::cerr << "Cannot open " << f->filename << std::endl; 
    return 0;
  }
  int MAXLLEN=600;
  char *line = new char[MAXLLEN];
  TFormula *fx=0, *fy=0, *feyl=0, *feyh=0, *fexl=0, *fexh=0;
  if (!f->Xf || !f->Yf) {
    std::cerr << "Must specify x and y at least!" << std::endl;
  }
  fx = new TFormula("fx",f->Xf);
  fy = new TFormula("fy",f->Yf);
  if (f->eYlf) feyl = new TFormula("feyl",f->eYlf);
  if (f->eYhf) feyh = new TFormula("feyh",f->eYhf);
  else if (feyl) {
    feyh = new TFormula(*feyl);
    feyh->SetName("feyh");
  }
  if (f->eXlf) fexl = new TFormula("fexl",f->eXlf);
  if (f->eXhf) fexh = new TFormula("fexh",f->eXhf);
  else if (fexl) {
    fexh = new TFormula(*fexl);
    fexh->SetName("fexh");
  }
  
  TFormula *formulas[6] = { fx, fy, feyl, feyh, fexl, fexh };
  TGraphAsymmErrors *gr = new TGraphAsymmErrors;
  gr->SetName(f->label);
  int cnt=0;
  while ( fgets(line,MAXLLEN,fp) && !feof(fp) ) {
    int pos=0;
    int linelength = strlen(line);
    if (linelength<1) continue;
    if (line[0]=='#') continue;
    int ip=0;
    //    std::cout << "read line " << line << "   length is " << linelength << std::endl;
    char *ptr = line;
    while ((ptr)<=(line+linelength) && ip<20) {
      sscanf(ptr,"%lg%n",&parms[ip],&pos);
      if (pos==0) break;
      //      std::cout << " found " << parms[ip] << " pos = " << pos << ";" << std::flush;
      ptr+=pos;
      ip++;
    }
    if (ip==0) continue;
    // sanity check
    for (int i=0; i<6; i++) {
      if (!formulas[i]) continue;
      if (!warned && formulas[i]->GetNpar()>ip) {
	std::cerr << "Warning: Mismatch between function and file for " << f->filename << std::endl;
	std::cerr << "  formula " << formulas[i]->GetName() << " requires "
	     << formulas[i]->GetNpar() << " entries but line contained " << ip << std::endl;
	std::cerr << "line is :" << line << std::endl;
	warned=1;
      }
      formulas[i]->SetParameters(parms);
    }
    gr->SetPoint(cnt,fx->Eval(0.),fy->Eval(0.));
    gr->SetPointError(cnt,
		      (fexl ? fexl->Eval(0.) : 0.), (fexh ? fexh->Eval(0.) : 0.),
		      (feyl ? feyl->Eval(0.) : 0.), (feyh ? feyh->Eval(0.) : 0.) );
    cnt++;
  }
  fclose(fp);
  delete [] line;
  int mtyp = f->style;
  int ltyp = f->style;
  int color = f->color;
  if (f->lnpt) {
    if (strchr(f->lnpt,'p')) { // if it is a polymarker, set the linetype to sensible
      ltyp=1;
    }
  }
  
  if (color==0 && mtyp<=30) {
    if (ctypes[cind]==0) cind=0;
    color = ctypes[cind];
    cind++;
  }
  
  if (mtyp==0) {
    if (mtypes[mind]==0) mind=0;
    mtyp = mtypes[mind];
    mind++;
  }
  if (ltyp==0) {
    if (ltypes[lind]==0) lind=0;
    ltyp = ltypes[lind];
    lind++;
  }
  while (mtyp>30) {
    mtyp-=11;
    if (f->color == 0)
      color++;
  }
  gr->SetMarkerStyle(mtyp);
  gr->SetMarkerColor(color);
  gr->SetLineColor(color);
  gr->SetLineStyle(ltyp);

  for (int i=0; i<6; i++) {
    if (formulas[i]) delete formulas[i];
    formulas[i] = 0;
  }
  return gr;
}
  
TGraph* toerror_band(TGraphAsymmErrors* gr) {
  // from a graph containing errors, contruct another that goes around the edges
  // of the points such that it can be shown filled
  Int_t oldn = gr->GetN();
  if (oldn<=1) return new TGraphAsymmErrors(*gr);
  Int_t n = 2*oldn+1;
  Double_t *x = new Double_t[n];
  Double_t *y = new Double_t[n];
  Double_t *ey = 0, *ex = 0;
  // run around the graph, hoping the points are in order along X
  int pt = 0;
  int dir=1;
  for (int i=0; i<n-1; i++, pt+=dir ) {
    x[i] = gr->GetX()[pt];
    y[i] = gr->GetY()[pt] + dir*(dir>0 ? gr->GetEYhigh()[pt] : gr->GetEYlow()[pt]);
    if (i==0) {
      // close the curve
      x[n-1] = x[i];
      y[n-1] = y[i];
    }
    if (pt==(oldn-1) && dir>0) {
      pt = oldn;
      dir=-1;
    }
  }
  TGraph *ngr = new TGraph(n,x,y);
  ngr->SetTitle(gr->GetTitle());

  TString name = gr->GetName();
  gr->TAttLine::Copy(*ngr);
  gr->TAttMarker::Copy(*ngr);
  gr->TAttFill::Copy(*ngr);
  ngr->SetLineStyle(1);
  
  name += "_band";
  ngr->SetName(name.Data());
  delete [] x;
  delete [] y;
  return ngr;
}
  
TMultiGraph* BuildGraphs( const char* name, const char* title, datafile_t *df, int forcept ) {
  TMultiGraph *dgr = new TMultiGraph(name,title);
  datafile_t *f = df;
  TGraphAsymmErrors *gr;
  while ( f && f->filename ) {
    gr = OneGraph(f);
    if (gr) {
      if (forcept || gr->GetMarkerStyle()>=20) {
	dgr->Add(gr,"p");
      }
      else
	dgr->Add(gr,"l");
    }
    f++;
  }
  return dgr;
}

void positionLegend(TLegend *leg, Double_t ensz, int align)
{
  // find a position for the legend, wanting each entry to be ensz % of the pad size
  // the y-corner is given by yc
  // align = 1 (lower), 2 (center) 3 (upper)
  int nentries = leg->GetListOfPrimitives()->GetSize();
  Double_t ytotsz = ensz*nentries;
  //  std::cout << "getting a total size of " << ytotsz << std::endl;
  int yalign = (align%10)-2;
  Double_t yc = 0.;
  leg->ConvertNDCtoPad();
  if (yalign==-1) yc = leg->GetY1NDC();
  else if (yalign==0) yc = .5*(leg->GetY1NDC()+leg->GetY2NDC());
  else if (yalign==1) yc = leg->GetY2NDC();
  Double_t ycl = yc - .5*ytotsz*(yalign+1);
  Double_t ych = ycl+ytotsz;
  leg->SetY1NDC(ycl);
  leg->SetY2NDC(ych);
}

#endif
