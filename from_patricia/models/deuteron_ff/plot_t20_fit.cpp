#include <cstring>
#include <TGraphAsymmErrors.h>
#include <cstdio>
#include <cstdlib>
#include <TMultiGraph.h>
#include <TFormula.h>
#include <TCanvas.h>
#include <iostream>
#include <TStyle.h>
#include <TLine.h>
#include <TFrame.h>
#include <TLegend.h>
#include <TMarker.h>
#include <TF1.h>
#include <TSystem.h>
#include "HallA_style.cxx"
#include "halla_plotting.h"

const char* psfile = "plot_t20_fit";

using namespace std;

datafile_t datafiles[] = {
//{ "data file.dat", "Data Name", "Q", "t20", "Error Up", "Error Down", ?, ?, Shape, Color}
//	{ "data_t20/all_data.dat", 		"", 				"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,1,10 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed", 		"[0]", "[1]", "[2]*sqrt(2)", "[2]*sqrt(2)", 0,0,20,6 },
//	{ "data_t20/Schulze.dat", 		"Schulze, PRL 8, 597 (1984)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,23,1 },
//	{ "data_t20/Dmitriev.dat", 		"Dmitriev, PLB 157, 143 (1985)", 		"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,20,1 },
//	{ "data_t20/Voitsekhovskii.dat","Voitsekhovsky, JETP Lett. 43, 733 (1986)", 	"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,21,1 },
//	{ "data_t20/Ferro-Luzzi.dat", 	"Ferro-Luzzi, PRL 77, 2630 (1996)", 		"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,22,1 },
//	{ "data_t20/Bowhuis.dat", 		"Bouwhuis, PRL 82, 3755 (1999)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,24,1 },
//	{ "data_t20/Gilman.dat", 		"Gilmani, PRL 65, 1733 (1990)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,25,1 },
//	{ "data_t20/Boden.dat", 		"Boden, Z Phys C, 49, 175 (1991)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,26,1 },
//	{ "data_t20/Garcon.dat", 		"Garcon, PRC 49, 2516 (1994)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,27,1 },
//	{ "data_t20/Abbott.dat", 		"Abbott, PRL 84, 5053 (2000)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,28,1 },
//	{ "data_t20/Nikolenko.dat", 	"Nikolenko, PRL 90, 07501 (2003)", 		"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,29,1 },
//	{ "data_t20/Zhang.dat", 		"Zhang, PRL 107, 252501 (2011)", 			"([0]*0.197)^2", "[1]", "[2]", "[2]", 0,0,30,1 },

	{ "data_t20/all_data.dat", 		"", 				"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,1,10 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed", 		"[0]", "[1]", "[2]*sqrt(2)", "[2]*sqrt(2)", 0,0,20,6 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed", 		"[0]", "[1]", "[2]/0.458", "[2]/0.458", 0,0,20,6 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed All", 	"[0]", "[1]", "sqrt(([2]/0.458)^2+([3]/0.458)^2+[4]^2+[5]^2)","sqrt(([2]/0.458)^2+([3]/0.458)^2+[4]^2+[5]^2)", 0,0,20,6 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed All", 	"[0]", "[1]", "sqrt(([3]/0.458)^2+[4]^2+[5]^2)","sqrt(([3]/0.458)^2+[4]^2+[5]^2)", 0,0,20,6 },
//	{ "data_t20/Long-Prelim-Optimistic.dat",	"Proposed All", 	"[0]", "[1]", "sqrt(([3]/0.458)^2+[4]^2+[5]^2)","sqrt(([3]/0.458)^2+[4]^2+[5]^2)", 0,0,20,6 },
//	{ "data_t20/Long-Prelim-SHMS-10deg.dat",	"Proposed All", 	"[0]", "[1]", "sqrt(([2]/0.458)^2+([3]/0.458)^2+[4]^2+[5]^2)","sqrt(([2]/0.458)^2+([3]/0.458)^2+[4]^2+[5]^2)", 0,0,20,6 },
	{ "data_t20/Long-Prelim-SHMS-10deg.dat",	"Proposed Stat", 	"[0]", "[1]", "[2]/0.458","[2]/0.458", 0,0,20,6 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed Stat", 	"[0]", "[1]", "[2]/0.458","[2]/0.458", 0,0,20,7 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed All", 	"[0]", "[1]", "sqrt([4]^2+[5]^2)","sqrt(([3]/0.458)^2)", 0,0,20,6 },
	{ "data_t20/Schulze.dat", 		"Schulze (Bates, 1984)", 		"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,20,1 },
	{ "data_t20/Dmitriev.dat", 		"Dmitriev (VEPP-2, 1985)", 		"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,21,1 },
	{ "data_t20/Voitsekhovskii.dat","Voitsekhovsky (VEPP-2, 1986)", "([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,22,1 },
	{ "data_t20/Gilman.dat", 		"Gilman (VEPP-3, 1990)", 		"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,23,1 },
	{ "data_t20/Boden.dat", 		"Boden (Bonn, 1991)", 			"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,24,1 },
	{ "data_t20/Garcon.dat", 		"Garcon (Bates, 1994)", 		"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,25,1 },
	{ "data_t20/Ferro-Luzzi.dat", 	"Ferro-Luzzi (NIKHEF, 1996)", 	"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,26,1 },
	{ "data_t20/Bouwhuis.dat", 		"Bouwhuis (NIKHEF, 1999)", 	"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,27,1 },
	{ "data_t20/Abbott.dat", 		"Abbott (Hall C, 2000)", 		"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,28,1 },
	{ "data_t20/Nikolenko.dat", 	"Nikolenko (VEPP-3, 2003)", 	"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,29,1 },
	{ "data_t20/Zhang.dat", 		"Zhang (Bates, 2011)", 			"([0]*0.197327)^2", "[1]", "[2]", "[2]", 0,0,30,1 },
//	{ "data_t21/abbott.dat", 		"T21 - Abbott (Hall C, 2000)", 		"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,28,2 },
//	{ "data_t21/garcon.dat", 		"T21 - Garcon (Bates, 1994)", 		"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,25,2 },
//	{ "data_t22/abbott.dat", 		"T22 - Abbott (Hall C, 2000)", 		"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,28,3 },
//	{ "data_t22/ferroluzzi.dat", 	"T22 - Ferro-Luzzi (NIKHEF, 1996)", 	"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,26,3 },
//	{ "data_t22/garcon.dat", 		"T22 - Garcon (Bates, 1994)", 		"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,25,3 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed", 		"[0]", "[1]", "sqrt([2]^2+[3]^2)", "sqrt([2]^2+[3]^2)", 0,0,20,6 },
//	{ "data_t20/Long-Prelim.dat",	"Proposed", 		"[0]", "[1]", "[2]", "[2]", 0,0,20,6 },
	{ "theory_t20/imii.dat", "IMII", "[0]", "[1]", "0", "0", 0, 0, 2, 3 },
	{ "theory_t20/imii+me.dat", "IM+E II", "[0]", "[1]", "0", "0", 0, 0, 2, 1 },
	{ "theory_t20/rpg0.dat", "\\rho\\pi\\gamma f/g=0", "[0]", "[1]", "0", "0", 0, 0, 2, 2 },
	{ "theory_t20/rpg6.dat", "\\rho\\pi\\gamma f/g=6.1", "[0]", "[1]", "0", "0", 0, 0, 2, 4 },
	{ NULL }
};	

datafile_t theoryfiles1[] = {
//{ "theory file.txt", "Data Name", "Q2 (Include range in theory file)", "Ay", "Error Up", "Error Down", ?, ?, 2, 3 },
	{ NULL }
};

void plot_t20_fit() {
	gROOT->SetStyle("HALLA");
	TCanvas *cn = new TCanvas("cn","cn",800,600);
	cn->Draw();
	cn->UseCurrentStyle();
	TH1F *frm = new TH1F("frm","",100,0.0,2.);
//	gPad->SetLogy();
	frm->GetXaxis()->SetTitle("Q^{2} (GeV^{2})");
//	frm->GetYaxis()->SetTitle("t_{20}(70^{\\circ})");
	frm->GetYaxis()->SetTitle("T_{20}");
//	frm->SetMinimum(-1.75);
	frm->SetMinimum(-2);
	frm->SetMaximum(1.0);
	frm->UseCurrentStyle();
	frm->SetStats(false);
	frm->Draw();
	frm->SetAxisRange(0.,7.0,"X");

	
	TMultiGraph* mgrDta = new TMultiGraph("Data","t_{20} Data");
	TLegend *legDta = new TLegend(.56,.13,.95,.55,"","brNDC");

	TMultiGraph* wgr = mgrDta;
	TLegend *wlg = legDta;

	 // the data
	legDta->SetBorderSize(0); // turn off border
	legDta->SetFillStyle(0);
	
	datafile_t *f = datafiles;
	TGraph* gr=0;
	TF1 *theFit = new TF1("theFit","[0]+[1]*x+[2]*x^2+[3]*x^3+[4]*x^4+[5]*x^5+[6]*x^6",0,7);
	while ( f && f->filename ) {
	cout << "f: " << f->filename << endl;
		gr=OneGraph(f);
	if (gr) {
		if (f->lnpt) {
			mgrDta->Add(gr,f->lnpt);
			legDta->AddEntry(gr,f->label,f->lnpt);
		 	 }
		else if (f->filename=="data_t20/all_data.dat") {
			gr->SetMarkerSize(0);
			gr->SetLineWidth(1);
			mgrDta->Add(gr,"p");
			legDta->AddEntry(gr,f->label,"p");
//			gr->Fit(theFit);
		 	}	
		 	else if (gr->GetMarkerStyle()>=20) {
			mgrDta->Add(gr,"p");
			legDta->AddEntry(gr,f->label,"p");
		 	}	
				else {
			mgrDta->Add(gr,"l");
			legDta->AddEntry(gr,f->label,"l");
				}
		}
		f++;
	}
		

	mgrDta->Draw("p");
	legDta->Draw();
//	theFit->Draw("same");	
	TMultiGraph* mgrThry = new TMultiGraph("Theory","t_{20} Theory");
	TLegend *legThry = new TLegend(.54,.3,.875,.6,"","brNDC");

	wgr = mgrThry;
	wlg = legThry;

	// the theory
	wlg->SetBorderSize(0); // turn off border
	wlg->SetFillStyle(0);
	
	f = theoryfiles1;
	gr=0;
	while ( f && f->filename ) {
		gr=OneGraph(f);
		if (gr) {
			TGraphAsymmErrors *egr = dynamic_cast<TGraphAsymmErrors*>(gr);
			if (egr && egr->GetN()>1 && egr->GetEYhigh() && egr->GetEYhigh()[1]>0) {
	gr = toerror_band(egr);
	gr->SetFillStyle(3000+f->style);
			}
			if (f->lnpt) {
	wgr->Add(gr,f->lnpt);
	wlg->AddEntry(gr,f->label,f->lnpt);
			}
			else if (gr->GetMarkerStyle()>=20) {
	wgr->Add(gr,"p");
	wlg->AddEntry(gr,f->label,"p");
			}	
			else {
	wgr->Add(gr,"l");
	wlg->AddEntry(gr,f->label,"l");
			}
		}
		f++;
	}

	cout << "Am I here?" << endl;	
//	mgrThry->Draw("c");
	wgr->Draw("c");
	legThry->Draw();
	legDta->Draw();
	// draw a line at 1
	cn->Modified();

	cn->Update();
	cn->SaveAs(Form("eps/%s.eps",psfile));
	cn->SaveAs(Form("png/%s.png",psfile));
	cn->SaveAs(Form("root/%s.root",psfile));
	gSystem->Exec(Form("./replace_symbols.pl eps/%s.eps",psfile));

	return;	// LEAVING HERE

	// now an overlay, hopefully matching dimensions

	// remove everything but the graph
	cn->Update();
	TList *clist = cn->GetListOfPrimitives();
	TFrame* frame = cn->GetFrame();
	for (int i=0; i<clist->GetSize(); ) {
		if (clist->At(i) != frame) {
			clist->RemoveAt(i);
		} else i++;
	}
	// draw markers in the corners
	TMarker *mkr = new TMarker(frame->GetX1(),frame->GetY1(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX2(),frame->GetY1(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX1(),frame->GetY2(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX2(),frame->GetY2(),2);
	mkr->Draw();
	frame->SetLineColor(10);
	cn->Update();

}
