{  
// double d=245;    //(300-65)/cos(16.28/180*3.1415926)=255cm   TCS LA
double d=750;       //(350+405)/cos(7.5/180*3.1415926)=770cm  SIDIS FA
  
const double M_pi=0.140,M_k=0.494,M_p=0.938;
TF1 *ppi=new TF1("ppi","[2]/30./(x/sqrt(x*x+[0]*[0]))-[2]/30./(x/sqrt(x*x+[1]*[1]))",0,10);
ppi->SetParameters(M_p,M_pi,d);
TF1 *pk=new TF1("kp","[2]/30./(x/sqrt(x*x+[0]*[0]))-[2]/30./(x/sqrt(x*x+[1]*[1]))",0,10);
pk->SetParameters(M_p,M_k,d);
TF1 *kpi=new TF1("kpi","[2]/30./(x/sqrt(x*x+[0]*[0]))-[2]/30./(x/sqrt(x*x+[1]*[1]))",0,10);
kpi->SetParameters(M_k,M_pi,d);
ppi->SetMaximum(1);
ppi->SetMinimum(0);
ppi->SetTitle("TOF PID;Mom (GeV/c);Time Diff (ns)");
ppi->SetLineStyle(1);
ppi->Draw();
pk->SetLineStyle(9);
pk->Draw("same");
kpi->SetLineStyle(7);
kpi->Draw("same");

//assume 5sigma and 80ps resolution
TF1 *line=new TF1("line","0.4",0,10);
line->SetLineColor(kRed);
line->Draw("same");

      TLine *lh;
      TLatex  t;
      t.SetTextAlign(32);
      t.SetTextSize(0.07);   
      lh = new TLine(3,0.9,3.4,0.9);
      lh->SetLineStyle(1);
      t.DrawLatex(4.8,0.9,"#Delta t (p-#pi)");
      lh->Draw();
      lh = new TLine(3,0.8,3.4,0.8);
      lh->SetLineStyle(9);
      t.DrawLatex(4.8,0.8,"#Delta t (p-K)");
      lh->Draw();      
      lh = new TLine(3,0.7,3.4,0.7);
      lh->SetLineStyle(7);
      t.DrawLatex(4.8,0.7,"#Delta t (K-#pi)");
      lh->Draw();      
      
}