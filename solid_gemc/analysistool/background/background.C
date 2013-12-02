#include <iostream> 
#include <fstream>
#include <cmath> 
#include <math.h> 
#include <TCanvas.h>
#include <TFile.h>
#include <TTree.h>
#include <TChain.h>
#include <TH1.h>
#include <TH2.h>
#include <TF1.h>
#include <TLorentzVector.h>
#include <TROOT.h>
#include <TStyle.h>
#include <TMinuit.h>
#include <TPaveText.h>
#include <TText.h>
#include <TSystem.h>
#include "../niel/niel_fun.h"

using namespace std;

///read hits from a txt file produced by roo2hit.C
void background(string input_filename,int Nevent){
gROOT->Reset();
gStyle->SetPalette(1);
gStyle->SetOptStat(111111);

const double DEG=180./3.1415926;

char output_filename[80];
sprintf(output_filename, "%s_output.root",input_filename.substr(0,input_filename.rfind(".")).c_str());
TFile *outputfile=new TFile(output_filename, "recreate");

const int n=18; // number of detector
const int m=11; //number of particles

char *label[m]={"photon+electron+positron","photon","electron+positron","neutron","proton","pip","pim","Kp","Km","Kl","other"};

TH2F *hhits[n][m],*hvertex[n][m];
TH1F *hfluxR[n][m],*hEflux[n][m];
TH1F *hPlog[n][m],*hElog[n][m],*hEklog[n][m];
TH1F *hEdeplog[n][m];
TH1F *hfluxEklog_cut[n][m],*hfluxEklog_cut_niel[n][m];
TH2F *hElog_R[n][m];
TH2F *hEklog_R[n][m];
TH2F *hEklog_R_cut[n][m];

for(int k=0;k<n;k++){
  for(int l=0;l<m;l++){
   char hstname[100];
   sprintf(hstname,"hits_%i_%i",k,l);
   hhits[k][l]=new TH2F(hstname,hstname,120,-300,300,120,-300,300);
   sprintf(hstname,"vertex_%i_%i",k,l);
   hvertex[k][l]=new TH2F(hstname,hstname,5000,-500,500,400,-400,400);
   sprintf(hstname,"fluxR_%i_%i",k,l);
   hfluxR[k][l]=new TH1F(hstname,hstname,60,0,300);
   hfluxR[k][l]->SetTitle(";R (cm);flux (kHz/mm2)");
   sprintf(hstname,"Eflux_%i_%i",k,l);
   hEflux[k][l]=new TH1F(hstname,hstname,60,0,300);
   hEflux[k][l]->SetTitle(";R (cm);Eflux (GeV/10cm2/s)");

    sprintf(hstname,"Plog_%i_%i",k,l);
    hPlog[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hPlog[k][l]->SetTitle(";log(P) GeV;counts");        
    sprintf(hstname,"Elog_%i_%i",k,l);
    hElog[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hElog[k][l]->SetTitle(";log(E) GeV;counts");    
    sprintf(hstname,"Eklog_%i_%i",k,l);
    hEklog[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hEklog[k][l]->SetTitle(";log(Ek) GeV;counts");    
    sprintf(hstname,"Edeplog_%i_%i",k,l);
    hEdeplog[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hEdeplog[k][l]->SetTitle(";log(Edep) GeV;counts");    
    
    sprintf(hstname,"fluxEklog_cut_%i_%i",k,l);
    hfluxEklog_cut[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hfluxEklog_cut[k][l]->SetTitle("at 10cm most inner part;log(Ek) MeV;flux (kHz/cm2)");    
    sprintf(hstname,"fluxEklog_cut_niel_%i_%i",k,l);
    hfluxEklog_cut_niel[k][l]=new TH1F(hstname,hstname,50,-6,1.3);
    hfluxEklog_cut_niel[k][l]->SetTitle("with 1MeV neutron fluence equivalent NIEL at 10cm most inner part;log(Ek) MeV;flux (kHz/cm2)*niel");
 
    sprintf(hstname,"Elog_R_%i_%i",k,l);
    hElog_R[k][l]=new TH2F(hstname,hstname,300, 0, 300, 50,-6,1.3);
    hElog_R[k][l]->SetTitle(";R (cm);log(Ek) (GeV)");    
    sprintf(hstname,"Eklog_R_%i_%i",k,l);
    hEklog_R[k][l] = new TH2F(hstname, hstname, 300, 0, 300, 50,-6,1.3);    
    hEklog_R[k][l]->SetTitle(";R (cm);log(Ek) (GeV)");
    sprintf(hstname,"Eklog_R_cut_%i_%i",k,l);
    hEklog_R_cut[k][l] = new TH2F(hstname, hstname, 300, 0, 300, 50,-6,1.3); 
    hEklog_R_cut[k][l]->SetTitle("with cut E < 100MeV;R (cm);log(Ek) (GeV)");
 } 
}
TH1F *hpid=new TH1F("pid","pid",21,-10.5,10.5);

TH1F *hactualphotonpid=new TH1F("actualphotonpid","actualphotonpid",21,-10.5,10.5);
TH1F *hactualothermass=new TH1F("actualothermass","actualothermass",1000,0.,10.);

ifstream input(input_filename.c_str());
if (!input.good()) {cout << "can't open file " << endl; return;}

// double Nevent;
// if (input_filename.find(".",0) != string::npos){
//   Nevent=atoi(input_filename.substr(input_filename.find(".")-3,3).c_str());
// //   cout << input_filename.substr(input_filename.find(".",0)-3,3) << endl;
//     cout << Nevent << endl;
//   
// }
  
double current;
if (input_filename.find("PVDIS",0) != string::npos){
  current=50e-6/1.6e-19;  //50uA
  cout << " PVDIS " << current << " " << Nevent <<  endl;  
}
else if (input_filename.find("SIDIS_3he",0) != string::npos){
  current=15e-6/1.6e-19;   //15uA
  cout << " SIDIS_3he " << current << " " << Nevent <<  endl;  
}
else if (input_filename.find("SIDIS_proton",0) != string::npos){
  current=100e-9/1.6e-19;   //100nA
  cout << " SIDIS_proton " << current << " " << Nevent <<  endl;  
}
else if (input_filename.find("JPsi",0) != string::npos){
  current=3e-6/1.6e-19;   //3uA
  cout << " JPsi " << current << " " << Nevent <<  endl;  
}
else {cout << "not PVDIS or SIDIS or JPsi " << endl; return;}

char rate_filename[100];
TFile *ratefile;
TTree *T;
bool Is_eDIS=false;
double rate,theta,pf,W,Q2;
bool Is_other=false;
if (input_filename.find("other",0) != string::npos) {
  Is_other=true;

  if (input_filename.find("_eDIS_",0) != string::npos) {
    sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_eDIS_1e6.root");
    Is_eDIS=true;
  }
  if (input_filename.find("_pip_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_pip_1e6.root");
  if (input_filename.find("_pim_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_pim_1e6.root");
  if (input_filename.find("_pi0_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_pi0_1e6.root");
  if (input_filename.find("_eES_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_eES_1e6.root");
  if (input_filename.find("_Kp_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_Kp_1e6.root");
  if (input_filename.find("_Km_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_Km_1e6.root");
  if (input_filename.find("_Ks_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_Ks_1e6.root");
  if (input_filename.find("_Kl_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_Kl_1e6.root");
  if (input_filename.find("_p_",0) != string::npos) sprintf(rate_filename,"../../../evgen/eicRate_20101102/output/SIDIS_He3/rate_solid_SIDIS_3he_p_1e6.root");

  ratefile=new TFile(rate_filename);  
  if (ratefile->IsZombie()) {
    cout << "Error opening ratefile" << rate_filename << endl;
    exit(-1);
  }
  else cout << "open file " << rate_filename << endl;

  T = (TTree*) ratefile->Get("T");
  T->SetBranchAddress("rate",&rate);
  T->SetBranchAddress("theta",&theta);  
  T->SetBranchAddress("pf",&pf);  
  T->SetBranchAddress("W",&W);  
  T->SetBranchAddress("Q2",&Q2);    

  cout << " other background " <<  endl;  
}
else cout << "EM background " <<  endl;

int evncounter=0;
int yescounter=0,Ek_nocounter=0,rate_nocounter=0;
int ratecounter=0;
int backscat_counter=0;
int counter_actualphoton=0,counter_acutalother=0;
int counter_hit[n]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

Int_t flux_evn_pre,flux_ID_pre,flux_pid_pre,flux_E_pre;

  int count_SC_front=0,count_SC=0,count_SC_back=0;
  int count_SC_act=0,count_SC_inact=0;
  
Int_t flux_evn,flux_nfluxhit,flux_ID,flux_pid,flux_mpid;
Float_t flux_Edep,flux_E,flux_x,flux_y,flux_z,flux_vx,flux_vy,flux_vz,flux_px,flux_py,flux_pz;
while (!input.eof()){
  input >> flux_evn>> flux_nfluxhit >> flux_ID >> flux_pid >> flux_mpid >>  flux_Edep >> flux_E >> flux_x >> flux_y >> flux_z >> flux_vx >> flux_vy >> flux_vz  >> flux_px >> flux_py >> flux_pz;
  
//   if (flux_nfluxhit>300) {cout << flux_evn << endl; break;}
//     if (!(flux_pid == 22 && fabs(flux_E-0.510999)<0.00001) ) {nocounter++; continue;}
  
//   if (flux_evn_pre != flux_evn) {
//       if (count_SC_front == 1 && count_SC_back ==1 && count_SC==1) count_SC_inact++;
//       if (count_SC_front == 2 && count_SC_back ==2 && count_SC==2) count_SC_inact=count_SC_inact+2;      
//       if (count_SC_front > 0 && count_SC_back>count_SC_front && count_SC>count_SC_front) count_SC_act=count_SC_act+count_SC_front;
//       
//        count_SC_front=0;
//        count_SC=0;
//        count_SC_back=0;
//   }  
//    if (flux_ID==1 && flux_pid==22) count_SC_front++;
//    if (flux_ID==3) count_SC_front++;
//    if (flux_ID==2) count_SC_back++;
  
//    if (flux_ID==4100000 && flux_pid==22 && flux_Edep !=0)  cout << " " <<  flux_evn<< " " <<  flux_nfluxhit << " " <<  flux_ID << " " <<  flux_pid << " " <<  flux_mpid << " " <<   flux_Edep << " " <<  flux_E << " " <<  flux_x << " " <<  flux_y << " " <<  flux_z << " " <<  flux_vx << " " <<  flux_vy << " " <<  flux_vz  << " " <<  flux_px << " " <<  flux_py << " " <<  flux_pz << endl;
  
    if (flux_ID_pre==flux_ID && flux_pid_pre==flux_pid && fabs(flux_E_pre-flux_E)<1e-3)  cout << " " <<  flux_evn<< " " <<  flux_nfluxhit << " " <<  flux_ID << " " <<  flux_pid << " " <<  flux_mpid << " " <<   flux_Edep << " " <<  flux_E << " " <<  flux_x << " " <<  flux_y << " " <<  flux_z << " " <<  flux_vx << " " <<  flux_vy << " " <<  flux_vz  << " " <<  flux_px << " " <<  flux_py << " " <<  flux_pz << endl;
    else {flux_ID_pre=flux_ID,flux_pid_pre=flux_pid,flux_E_pre=flux_E;}
  
      switch (flux_pid){
      case 22:     hpid->Fill(0); break;
      case 11:     hpid->Fill(1); break;
      case -11:     hpid->Fill(-1); break;
      case 12:     hpid->Fill(2); break;
      case 14:     hpid->Fill(2); break;      
      case 16:     hpid->Fill(2); break;
      case -12:     hpid->Fill(-2); break;
      case -14:     hpid->Fill(-2); break;      
      case -16:     hpid->Fill(-2); break;
      case 13:     hpid->Fill(3); break;
      case -13:     hpid->Fill(3); break; 
      case 211:     hpid->Fill(4); break;
      case -211:     hpid->Fill(-4); break; 
      case 111:     hpid->Fill(5); break;       
      case -111:     hpid->Fill(-5); break;      
      case 321:     hpid->Fill(6); break;
      case -321:     hpid->Fill(-6); break;
      case 130:     hpid->Fill(7); break; 
      case -130:     hpid->Fill(-7); break;       
      case 2212:     hpid->Fill(8); break;
      case -2212:     hpid->Fill(-8); break;       
      case 2112:     hpid->Fill(9); break; 
      case -2112:     hpid->Fill(-9); break;       
      default:      hpid->Fill(10); break;      
    }
    
//     int detector_ID=*(flux_ID+j)/1000000;
//     int subdetector_ID=(*(flux_ID+j)%1000000)/100000;
//     int subsubchannel_ID=((*(flux_ID+j)%1000000)%100000)/10000;
// //     cout << Detector_ID << " " << SubDetector_ID << " "  << channel_ID << endl;
// 
//     
//         int hit_id;
//      switch (detector_ID){
// 	case 1:     
// 		    switch (subdetector_ID){
// 			case 1: hit_id=0; break;
// 			case 2: hit_id=1; break;
// 			case 3: hit_id=2; break;
// 			case 4: hit_id=3; break;
// 			case 5: hit_id=4; break;
// 			case 6: hit_id=5; break;
// 			default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 		    }
// 		    break;
// 	case 2:      
// 		    switch (subdetector_ID){
// 			case 1: hit_id=6; break;
// 			case 2: hit_id=7; break;
// 		      default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 		    }
// 		    break;
// 	case 3:     
// 		    switch (subdetector_ID){
// 			case 1:   
// 				  switch (subsubdetector_ID){
// 				    case 1: hit_id=8; break;
// 				    case 2: hit_id=9; break;
// 				    case 3: hit_id=10; break;
// 				    case 4: hit_id=11; break;
// 				    default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 				  }
// 				  break;
// 			case 2:
// 				  switch (subsubdetector_ID){
// 				    case 1: hit_id=12; break;
// 				    case 2: hit_id=13; break;
// 				    case 3: hit_id=14; break;
// 				    case 4: hit_id=15; break;
// 				    default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 				  }
// 				  break;
// 			default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 		    }
// 		    break;
// 	case 4:     
// 		    switch (subdetector_ID){
// 			case 1:   
// 				  switch (subsubdetector_ID){
// 				    case 1: hit_id=16; break;
// 				    case 0: hit_id=17; break;
// 				    default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 				  }
// 				  break;
// 			default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
// 		    }
// 		    break;
// 	default: cout << "wrong flux_ID " << *(flux_ID+j) << endl; break;
//       }   
      
//     cout << flux_ID << endl;    
    int detector_ID=flux_ID/100000;
    if ( (detector_ID<11 || detector_ID >16) && detector_ID !=31 && detector_ID !=32 && detector_ID!=21 && detector_ID!=22 && detector_ID!=41)    
    {
      cout << "wrong flux_ID "  << flux_evn  << " " << flux_nfluxhit << " " << flux_ID << endl;
      continue;
    }
    
    int subdetector_ID=flux_ID/10000; 

    int hit_id;
     switch (detector_ID){
	case 11:     hit_id=0; break;
	case 12:     hit_id=1; break;
	case 13:     hit_id=2; break;
	case 14:     hit_id=3; break;
	case 15:     hit_id=4; break;    
	case 16:     hit_id=5; break;
	case 21:     hit_id=6; break;
	case 22:     hit_id=7; break;	
	case 31:     if (subdetector_ID==311) hit_id=8;
		     else if (subdetector_ID==312) hit_id=9;
		     else if (subdetector_ID==313) hit_id=10;
		     else if (subdetector_ID==314) hit_id=11;  
		     else cout << "wrong flux_ID " << flux_ID << endl;		      
		     break;
	case 32:     if (subdetector_ID==321) hit_id=12;
		     else if (subdetector_ID==322) hit_id=13;
		     else if (subdetector_ID==323) hit_id=14;
		     else if (subdetector_ID==324) hit_id=15;		     
		     else cout << "wrong flux_ID " << flux_ID << endl;		      
		     break;
	case 41:     if (subdetector_ID==411) hit_id=16;
		     else if (subdetector_ID==410) hit_id=17;
		     else cout << "wrong flux_ID " << flux_ID << endl;		      
		     break;
	default:     cout << "wrong flux_ID " << flux_ID <<  endl; break;
      }    

      
    int par;
    if(flux_pid==22) par=1;  //photon    
    else if (abs(flux_pid)==11) par=2; //electron or positron
    else if(flux_pid==2112) par=3;  //neutron
    else if(flux_pid==2212) par=4;  //proton    
    else if(flux_pid==211)  par=5;  //pip
    else if(flux_pid==-211) par=6;  //pim
    else if(flux_pid==321)  par=7;  //Kp    
    else if(flux_pid==-321)  par=8;  //Km
    else if(flux_pid==130)  par=9;  //Kl    
    else par=10;  //all other
    
//   if (flux_vz<2000) {  
// if (flux_vz<-3700 || -3300<flux_vz) continue;
    
//       if ( 12<=abs(flux_pid) && abs(flux_pid) <=16 ) continue; ///cut away muon and neutrino

//       if ( flux_pid != 22 && abs(flux_pid) !=11 ) continue; ///anything except photon and electron/position

//       if ( flux_pid != 22 && abs(flux_pid) !=11 && flux_pid !=2112 ) { continue;} ///cut anything except photon and electron and neutron


      double hit_phi=fabs(atan(flux_y/flux_x)/3.1416*180);
      if (flux_x > 0 && flux_y > 0) hit_phi=hit_phi;
      else if (flux_x < 0 && flux_y > 0) hit_phi=180-hit_phi;
      else if (flux_x < 0 && flux_y < 0) hit_phi=180+hit_phi;    
      else if (flux_x > 0 && flux_y < 0) hit_phi=360-hit_phi;
      else cout << " flux wrong? " << flux_x << " " <<  flux_y << endl; 
      
      double arearatio_cutStraightPhoton=1;
      bool cutStraightPhoton=false;   //cut away straight photon due to PVDIS baffle problem
      if(input_filename.find("PVDIS",0) != string::npos){ 
	  if (par==1){
	    arearatio_cutStraightPhoton=1./2.;  //cut 180 degree away in total, 1/2 of azimuth left
	    for(int i=0;i<30;i++){
	      if(fabs(hit_phi-(4.5+i*12))<3) cutStraightPhoton=true;
	    }
	  }
      }      
      if (cutStraightPhoton) continue;

    double r=sqrt(pow(flux_x,2)+pow(flux_y,2));    
    double P=sqrt(pow(flux_px,2)+pow(flux_py,2)+pow(flux_pz,2));
//     double M;
//     if (par==1) M=0;
//     else if (par==2) M=0.511;
//     else M=sqrt(pow(flux_E,2)-pow(P,2));
//     double Ek=flux_E-M;
    double Ek;
    if (fabs(flux_E - P)<1) Ek=flux_E;
    else Ek=flux_E-sqrt(pow(flux_E,2)-pow(P,2));
    
    ///geant4 or gemc problem, misidentify photon and electron
//       if(par!=1){
// 	if( TMath::IsNaN(M)){ //photon misidentified as other
// 	par=1;
// 	hactualphotonpid->Fill(flux_pid);
// // 	cout << "actualphoton " << flux_ID << " " << flux_pid << " " << flux_E << " " << P << " " << M << endl;
// 	counter_actualphoton++;
// 	}
//       }
//       if(par==1){	 //electron or positron misidentified as photon
// 	if(TMath::IsNaN(M)){}
// 	else{
// 	hactualothermass->Fill(M);
// // 	  if(0.51<=M && M<=0.52){
// // 	    par=2;
// // 	    cout << "acutalother "  << flux_ID << " " << flux_pid << " " << flux_E << " " << P << " " << M << endl;
// // 	    counter_acutalother++;
// // 	  }
// 	}
//       }
      
    if ( TMath::IsNaN(Ek) || isinf(Ek) ) {
//     if ( TMath::IsNaN(Ek)) {  
      cout << Ek << " " << flux_E << " " << P << " " <<  flux_px << " " <<  flux_py << " " <<  flux_pz << endl;
       cout << " " <<  flux_evn<< " " <<  flux_nfluxhit << " " <<  flux_ID << " " <<  flux_pid << " " <<  flux_mpid << " " <<   flux_Edep << " " <<  flux_E << " " <<  flux_x << " " <<  flux_y << " " <<  flux_z << " " <<  flux_vx << " " <<  flux_vy << " " <<  flux_vz  << " " <<  flux_px << " " <<  flux_py << " " <<  flux_pz << endl;     
	  Ek_nocounter++; continue;
    } 

        yescounter++; 
	
    //100MeV cut used for photon in later calorimeter simulation    
    
//     if(1<flux_E && flux_E<100 ) {    
//       if(flux_E<100 ) {  
//     if(1<flux_E ) {      
  if (true){
//   if ( !Is_other || (Is_other && P > 100) ){
//     cout << flux_pid << " " << par << endl;
      hhits[hit_id][par]->Fill(flux_x/10.,flux_y/10.);
      if (par==1 || par==2) hhits[hit_id][0]->Fill(flux_x/10.,flux_y/10.);      
      hvertex[hit_id][par]->Fill(flux_vz/10.,flux_vy/10.);
      if (par==1 || par==2) hvertex[hit_id][0]->Fill(flux_vz/10.,flux_vy/10.);     
      
      if ((hit_id==8 && flux_vz/10. > 402) || (hit_id==12 && flux_vz/10. > -66.9)) {backscat_counter++; continue;}
      
      double area=2*3.1415926*r*10.*arearatio_cutStraightPhoton; // in mm2, every bin in R is 1cm
      double kHz=1e-3;    
      double weight;
      
      if (Is_other) {
	T->GetEntry(flux_evn); 
	weight=rate*kHz/area;
	
	if (Is_eDIS && (W<2 || Q2 <1)){  /// cut for eDIS
// 	if (theta/3.1415926*180 <5 || pf <0.5 ) {
// 	  cout << "rate " << rate << " theta " << theta/3.1415926*180 << " pf " << pf << endl;
// 	cout << " " <<  flux_evn<< " " <<  flux_nfluxhit << " " <<  flux_ID << " " <<  flux_pid << " " <<  flux_mpid << " " <<   flux_Edep << " " <<  flux_E << " " <<  flux_x << " " <<  flux_y << " " <<  flux_z << " " <<  flux_vx << " " <<  flux_vy << " " <<  flux_vz  << " " <<  flux_px << " " <<  flux_py << " " <<  flux_pz << endl;  
	
	  rate_nocounter++;  
	  continue;
	}	  
	
	if (rate > 0) {if (flux_evn != flux_evn_pre) ratecounter++;}
      }
      else weight=(current/Nevent)*kHz/area;

      if (par==1 || par==2) {
	hPlog[hit_id][0]->Fill(log10(P/1e3),weight);
	hElog[hit_id][0]->Fill(log10(flux_E/1e3),weight);
	hEklog[hit_id][0]->Fill(log10(Ek/1e3),weight);
	hEdeplog[hit_id][0]->Fill(log10(flux_Edep/1e3),weight);      
	hElog_R[hit_id][0]->Fill(log10(flux_E/1e3),r/10.,weight);
	hEklog_R[hit_id][0]->Fill(log10(Ek/1e3),r/10.,weight);
	if(Ek<100) hEklog_R_cut[hit_id][0]->Fill(r/10,log10(Ek/1e3));      
      }
      hPlog[hit_id][par]->Fill(log10(P/1e3),weight);
      hElog[hit_id][par]->Fill(log10(flux_E/1e3),weight);
      hEklog[hit_id][par]->Fill(log10(Ek/1e3),weight);
      hEdeplog[hit_id][par]->Fill(log10(flux_Edep/1e3),weight);          
      hElog_R[hit_id][par]->Fill(r/10.,log10(flux_E/1e3),weight);
      hEklog_R[hit_id][par]->Fill(r/10.,log10(Ek/1e3),weight);
      if(Ek<100) hEklog_R_cut[hit_id][par]->Fill(r/10,log10(Ek/1e3));
              
	if (hit_id<6 || hit_id==17){
// 	  if (flux_Edep>0) { //gem and mrpc required non-zero energy deposit
	  if (flux_Edep>26e-6) { //gem and mrpc required non-zero energy deposit
	    hfluxR[hit_id][par]->Fill(r/10.,weight/5.);   ///for rate in 5cm bin
	    if (par==1 || par==2) hfluxR[hit_id][0]->Fill(r/10.,weight/5.);
	  }
	}
	else { //other just counting
	  hfluxR[hit_id][par]->Fill(r/10.,weight/5.);  ///for rate in 5cm bin
	  if (par==1 || par==2) hfluxR[hit_id][0]->Fill(r/10.,weight/5.);
	}
	
/*    double rcut;  //in cm
    if ((input_filename.find("SIDIS",0) != string::npos) || (input_filename.find("JPsi",0) != string::npos) ){
      if(subdetector_ID==311 || subdetector_ID==312 || subdetector_ID==314) rcut=100+10;
      else if (subdetector_ID==321 || subdetector_ID==322) rcut=75+10;
      else rcut=0;          
    }
    else if (input_filename.find("PVDIS",0) != string::npos){
      if(subdetector_ID==311 || subdetector_ID==312 || subdetector_ID==314) rcut=118+10;
      else rcut=0;
    }  
    else {cout << "not PVDIS or SIDIS or JPsi " << endl; return;} */   
    
//     if (r/10<rcut){
//      hfluxEklog_cut[hit_id][par]->Fill(log10(Ek),weight);       
//      if (par==1 || par==2) hfluxEklog_cut[hit_id][0]->Fill(log10(Ek),weight);  
//     }

     hfluxEklog_cut[hit_id][par]->Fill(log10(Ek),(current/Nevent)*kHz/(3.1416*(pow(261.,2.)-pow(118.,2.))));
     if (par==1 || par==2) hfluxEklog_cut[hit_id][0]->Fill(log10(Ek),(current/Nevent)*kHz/(3.1416*(pow(261.,2.)-pow(118.,2.))));

	area=area/10/100;  //in 10cm2
  //       weight = (current/Nevent)*(flux_E/1e3)/area;
// 	weight = (current/Nevent)*(P/1e3)/area;

      if (Is_other) {
	T->GetEntry(flux_evn); 
	weight=rate*(Ek/1e3)/area;
// 	cout << "rate " << rate << endl;	
      }
      else weight=(current/Nevent)*(Ek/1e3)/area;

      	if (par==1 || par==2) hEflux[hit_id][0]->Fill(r/10.,weight);
	hEflux[hit_id][par]->Fill(r/10.,weight);

    }
    
    flux_evn_pre = flux_evn;
//      if (yescounter >100) break;
}

cout << "count_SC_act " << count_SC_act << " count_SC_inact " << count_SC_inact << endl;

cout << "yescounter " << yescounter << " Ek_nocounter " << Ek_nocounter << " rate_nocounter " << rate_nocounter << endl;
cout << "counter_actualphoton " << counter_actualphoton << " counter_acutalother " << counter_acutalother << endl;
cout << "ratecounter " << ratecounter << endl;
cout << "backscat_counter " << backscat_counter << endl;
      
TCanvas *c_pid = new TCanvas("pid","pid",900,900);
gPad->SetLogy(1);
hpid->Draw();

TCanvas *c_mispid = new TCanvas("mispid","mispid",1200,900);
c_mispid->Divide(2,1);
c_mispid->cd(1);
hactualphotonpid->Draw();
c_mispid->cd(2);
hactualothermass->Draw();

TCanvas *c_hits = new TCanvas("hits","hits",1800,900);
c_hits->Divide(n,m);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_hits->cd(l*n+k+1);    
  hhits[k][l]->Draw("colz");
}
}

TCanvas *c_vertex = new TCanvas("vertex","vertex",1800,900);
c_vertex->Divide(n,m);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  gPad->SetLogz(1);  
  c_vertex->cd(l*n+k+1);    
  hvertex[k][l]->Draw("colz");
}
}


TCanvas *c_fluxR = new TCanvas("fluxR","fluxR",1800,900);
c_fluxR->Divide(n,m);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_fluxR->cd(l*n+k+1);    
  hfluxR[k][l]->Draw();
}
}

TCanvas *c_Plog = new TCanvas("Plog","Plog",1800,900);
c_Plog->Divide(n,m);
gPad->SetLogy(1);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_Plog->cd(l*n+k+1);    
  hPlog[k][l]->Draw(); 
}
}

TCanvas *c_Elog = new TCanvas("Elog","Elog",1800,900);
c_Elog->Divide(n,m);
gPad->SetLogy(1);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_Elog->cd(l*n+k+1);
  hElog[k][l]->Draw();  
}
}

TCanvas *c_Eklog = new TCanvas("Eklog","Eklog",1800,900);
c_Eklog->Divide(n,m);
gPad->SetLogy(1);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_Eklog->cd(l*n+k+1);
  hEklog[k][l]->Draw();  
}
}

TCanvas *c_Edeplog = new TCanvas("Edeplog","Edeplog",1800,900);
c_Edeplog->Divide(n,m);
gPad->SetLogy(1);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_Edeplog->cd(l*n+k+1);
  hEdeplog[k][l]->Draw();  
}
}

TCanvas *c_Eklog_R = new TCanvas("Eklog_R","Eklog_R",1800,900);
c_Eklog_R->Divide(n,m);
gPad->SetLogx(1);
gPad->SetLogy(1);
for(int l=0;l<m;l++){
for(int k=0;k<n;k++){
  c_Eklog_R->cd(l*n+k+1);
  hEklog_R[k][l]->Draw("colz");
}
}

// gStyle->SetOptStat(0);

TCanvas *c_fluxR_gem = new TCanvas("fluxR_gem","fluxR_gem",900,900);
int color[6]={2,1,3,4,7,6};
gPad->SetLogy(1);  
for(int k=0;k<6;k++){
  hfluxR[k][0]->SetLineColor(color[k]);
  hfluxR[k][0]->SetMarkerColor(color[k]);  
  hfluxR[k][0]->SetMaximum(100);
  hfluxR[k][0]->SetMinimum(0.01);  
  if (k==0) hfluxR[k][0]->Draw();
  else hfluxR[k][0]->Draw("same");
}

TCanvas *c_fluxR_cherenkov = new TCanvas("fluxR_cherenkov","fluxR_cherenkov",1200,600);
c_fluxR_cherenkov->Divide(2,1);
for(int k=6;k<8;k++){
  c_fluxR_cherenkov->cd(k-5);  
  for(int l=0;l<m;l++){
    hfluxR[k][l]->SetLineColor(l+1);
    if (l==0) hfluxR[k][l]->Draw();
    else hfluxR[k][l]->Draw("same");
  }
}

TCanvas *c_fluxR_mrpc = new TCanvas("fluxR_mrpc","fluxR_mrpc",1200,600);
c_fluxR_mrpc->Divide(2,1);
for(int k=16;k<18;k++){
  c_fluxR_mrpc->cd(k-15);    
  gPad->SetLogy(1);  
  for(int l=0;l<m;l++){
    hfluxR[k][l]->SetLineColor(l+1);
    if (l==0) hfluxR[k][l]->Draw();
    else hfluxR[k][l]->Draw("same");
  }
}
// //add text
// TPaveText *pt = new TPaveText(0.6,0.6,0.95,0.9,"brNDC");
// pt->SetFillColor(17);
// pt->SetTextAlign(12);
// pt->Draw();
// for(int i=0;i<m;i++){
// TText *text=pt->AddText(label[i]);
// text->SetTextColor(i+1);
// text->SetTextSize(0.024);
// }

TCanvas *c_Eklog_mrpc = new TCanvas("Eklog_mrpc","Eklog_mrpc",1200,600);
c_Eklog_mrpc->Divide(2,1);
for(int k=16;k<18;k++){
  c_Eklog_mrpc->cd(k-15);    
  gPad->SetLogy(1);    
  for(int l=0;l<m;l++){
    hEklog[k][l]->SetLineColor(l+1);
    if (l==0) hEklog[k][l]->Draw();
    else hEklog[k][l]->Draw("same");
  }
}


TCanvas *c_Eklog_R_mrpc = new TCanvas("Eklog_R_mrpc","Eklog_R_mrpc",300,900);
c_Eklog_R_mrpc->Divide(2,m);
for(int k=16;k<18;k++){
for(int l=0;l<m;l++){
  c_Eklog_R_mrpc->cd(l*2+(k-15));
  hEklog_R[k][l]->Draw("colz");
}
}

TCanvas *c_fluxR_ec = new TCanvas("fluxR_ec","fluxR_ec",1600,900);
c_fluxR_ec->Divide(4,2);
for(int k=8;k<16;k++){
  c_fluxR_ec->cd(k-7);
  gPad->SetLogy(1);  
  for(int l=0;l<m;l++){
    hfluxR[k][l]->SetMinimum(1e-7);
    hfluxR[k][l]->SetMaximum(1e7);    
    hfluxR[k][l]->SetLineColor(l+1);
    if (l==0) hfluxR[k][l]->Draw();
    else hfluxR[k][l]->Draw("same");
  }
}
// add text
TPaveText *pt1 = new TPaveText(0.6,0.6,0.95,0.9,"brNDC");
pt1->SetFillColor(17);
pt1->SetTextAlign(12);
pt1->Draw();
for(int i=0;i<m;i++){
TText *text=pt1->AddText(label[i]);
text->SetTextColor(i+1);
text->SetTextSize(0.024);
}

TCanvas *c_Eflux_ec = new TCanvas("Eflux_ec","Eflux_ec",1600,900);
c_Eflux_ec->Divide(4,2);
for(int k=8;k<16;k++){
  c_Eflux_ec->cd(k-7);
  gPad->SetLogy(1);
  for(int l=0;l<m;l++){
    hEflux[k][l]->SetMinimum(1e0);
    hEflux[k][l]->SetMaximum(1e8);
    hEflux[k][l]->SetLineColor(l+1);
    if (l==0) hEflux[k][l]->Draw();
    else hEflux[k][l]->Draw("same");
  }
}

gSystem->Load("../niel/niel_fun_lib.so"); 
//   TNiel niel_proton("niel/niel_proton.txt");
//   TNiel niel_electron("niel/niel_electron.txt");
//   TNiel niel_pions("niel/niel_pions.txt");
TNiel niel_neutron("../niel/niel_neutron.txt");
TH1F *hniel_neutron=new TH1F("niel_neutron","niel_neutron",50, -6,1.3);
for(int i=0;i<420;i++) hniel_neutron->SetBinContent(i+1,niel_neutron.GetNielFactor(pow(10,(i*(14./420.)-10))));
TCanvas *c_niel_neutron = new TCanvas("niel_neutron","niel_neutron",600,600);
gPad->SetLogy(1);
hniel_neutron->Draw();

hfluxEklog_cut_niel[8][3]->Multiply(hfluxEklog_cut[8][3],hniel_neutron);
hfluxEklog_cut_niel[11][3]->Multiply(hfluxEklog_cut[11][3],hniel_neutron);
hfluxEklog_cut_niel[12][3]->Multiply(hfluxEklog_cut[12][3],hniel_neutron);
hfluxEklog_cut_niel[15][3]->Multiply(hfluxEklog_cut[15][3],hniel_neutron);

cout << hfluxEklog_cut_niel[8][3]->Integral() << endl;
cout << hfluxEklog_cut_niel[11][3]->Integral() << endl;
cout << hfluxEklog_cut_niel[12][3]->Integral() << endl;
cout << hfluxEklog_cut_niel[15][3]->Integral() << endl;

TCanvas *c_neutron_ec = new TCanvas("neutron_ec","neutron_ec",1600,900);
c_neutron_ec->Divide(4,2);
c_neutron_ec->cd(1);
gPad->SetLogy(1);
// hfluxR[8][3]->SetLineColor(1);
hfluxR[8][3]->Draw();
// hfluxR[11][3]->SetLineColor(2);
hfluxR[11][3]->Draw("same");
c_neutron_ec->cd(2);
gPad->SetLogy(1);
// hEklog[8][3]->SetLineColor(1);
hEklog[8][3]->Draw();
// hEklog[11][3]->SetLineColor(2);
hEklog[11][3]->Draw("same");
c_neutron_ec->cd(3);
gPad->SetLogy(1);
hfluxEklog_cut[8][3]->SetLineColor(1);
hfluxEklog_cut[8][3]->Draw();
hfluxEklog_cut[11][3]->SetLineColor(2);
hfluxEklog_cut[11][3]->Draw("same");
c_neutron_ec->cd(4);
gPad->SetLogy(1);
hfluxEklog_cut_niel[8][3]->SetLineColor(1);
hfluxEklog_cut_niel[8][3]->Draw();
hfluxEklog_cut_niel[11][3]->SetLineColor(2);
hfluxEklog_cut_niel[11][3]->Draw("same");
c_neutron_ec->cd(5);
gPad->SetLogy(1);
// hfluxR[12][3]->SetLineColor(1);
hfluxR[12][3]->Draw();
// hfluxR[15][3]->SetLineColor(2);
hfluxR[15][3]->Draw("same");
c_neutron_ec->cd(6);
gPad->SetLogy(1);
// hEklog[12][3]->SetLineColor(1);
hEklog[12][3]->Draw();
// hEklog[15][3]->SetLineColor(2);
hEklog[15][3]->Draw("same");
c_neutron_ec->cd(7);
gPad->SetLogy(1);
hfluxEklog_cut[12][3]->SetLineColor(1);
hfluxEklog_cut[12][3]->Draw();
hfluxEklog_cut[15][3]->SetLineColor(2);
hfluxEklog_cut[15][3]->Draw("same");
c_neutron_ec->cd(8);
gPad->SetLogy(1);
hfluxEklog_cut_niel[12][3]->SetLineColor(1);
hfluxEklog_cut_niel[12][3]->Draw();
hfluxEklog_cut_niel[15][3]->SetLineColor(2);
hfluxEklog_cut_niel[15][3]->Draw("same");

outputfile->Write();
outputfile->Flush();
}
