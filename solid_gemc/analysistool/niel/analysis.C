{
  int pid,mpid,Event_N;
  double ETot,x,y,z,lx,ly,lz,t,px,py,pz,vx,vy,vz,E,mvx,mvy,mvz;
  gStyle->SetOptStat(1);
  gStyle->SetPalette(1) ;
  gSystem->Load("Niel/niel_fun_cc.so"); 
  TNiel niel_proton("Niel/niel_proton.txt");
  TNiel niel_electron("Niel/niel_electron.txt");
  TNiel niel_pions("Niel/niel_pions.txt");
  TNiel niel_neutron("Niel/niel_neutron.txt");

  double PlateZ[4]  = {1575.,1855.,3060.,3210.};  
  double Rin[4]  = {55,65,105,115};
  double Rout[4] = {115,140,200,215};
  int bingem[4] = {230,280,400,430};
  double Dz   = 5.;
  
  char Title[60];
  char Title2[60];

  TH2F * gem_niel_cm[4];
  TH2F * gem_niel_cm_nosh[4];
  for (int i=0; i<4; i++) {
    sprintf(Title,"niel_cm%i",i);
    sprintf(Title2,"NIEL 1MeVeq Neutron/(cm^{2} e-) Gem n.%i ;x(cm);y(cm)",(i+1));
    gem_niel_cm[i] = new TH2F(Title,Title2,bingem[i],-Rout[i],Rout[i],bingem[i],-Rout[i],Rout[i]);  
    sprintf(Title,"gem_niel_cm_nosh%i",i);
    sprintf(Title2,"NIEL 1MeVeq Neutron/(cm^{2} e-) Gem n.%i ;x(cm);y(cm)",(i+1));
    gem_niel_cm_nosh[i] = new TH2F(Title,Title2,bingem[i],-Rout[i],Rout[i],bingem[i],-Rout[i],Rout[i]);  
    
 }

  TChain input_chain("FLUX");
  input_chain.Add("d2_*.root");
  
  input_chain.SetBranchAddress("Event_N",&Event_N);
  input_chain.SetBranchAddress("ETot",&ETot);
  input_chain.SetBranchAddress("x",&x);
  input_chain.SetBranchAddress("y",&y);
  input_chain.SetBranchAddress("z",&z);
  input_chain.SetBranchAddress("lx",&lx);
  input_chain.SetBranchAddress("ly",&ly);
  input_chain.SetBranchAddress("lz",&lz);
  input_chain.SetBranchAddress("vx",&vx);
  input_chain.SetBranchAddress("vy",&vy);
  input_chain.SetBranchAddress("vz",&vz);
  input_chain.SetBranchAddress("t",&t);
  input_chain.SetBranchAddress("pid",&pid);
  input_chain.SetBranchAddress("px",&px);
  input_chain.SetBranchAddress("py",&py);
  input_chain.SetBranchAddress("pz",&pz);
  input_chain.SetBranchAddress("E",&E);
  input_chain.SetBranchAddress("mpid",&mpid);
  input_chain.SetBranchAddress("mvx",&mvx);
  input_chain.SetBranchAddress("mvy",&mvy);
  input_chain.SetBranchAddress("mvz",&mvz);


  TChain input_chain_nosh("FLUX");
  input_chain_nosh.Add("nosh_d2_*.root");
  
  input_chain_nosh.SetBranchAddress("Event_N",&Event_N);
  input_chain_nosh.SetBranchAddress("ETot",&ETot);
  input_chain_nosh.SetBranchAddress("x",&x);
  input_chain_nosh.SetBranchAddress("y",&y);
  input_chain_nosh.SetBranchAddress("z",&z);
  input_chain_nosh.SetBranchAddress("lx",&lx);
  input_chain_nosh.SetBranchAddress("ly",&ly);
  input_chain_nosh.SetBranchAddress("lz",&lz);
  input_chain_nosh.SetBranchAddress("vx",&vx);
  input_chain_nosh.SetBranchAddress("vy",&vy);
  input_chain_nosh.SetBranchAddress("vz",&vz);
  input_chain_nosh.SetBranchAddress("t",&t);
  input_chain_nosh.SetBranchAddress("pid",&pid);
  input_chain_nosh.SetBranchAddress("px",&px);
  input_chain_nosh.SetBranchAddress("py",&py);
  input_chain_nosh.SetBranchAddress("pz",&pz);
  input_chain_nosh.SetBranchAddress("E",&E);
  input_chain_nosh.SetBranchAddress("mpid",&mpid);
  input_chain_nosh.SetBranchAddress("mvx",&mvx);
  input_chain_nosh.SetBranchAddress("mvy",&mvy);
  input_chain_nosh.SetBranchAddress("mvz",&mvz);

  int n_events = 99.0e+6;
  int n_events_nosh = 88.0e+6;
  int n_bins = 200;
  int n_bins2 = 75;
  int n_bins3 = 200;
  TH2F * Hxy_neutron[6];
  TH2F * Hxy_neutron_norm[6];
  TH1F * Hx_neutron[6];
  TH1F * Hy_neutron[6];
  
  TH1F * Energy_n_part2MeV[11];
  TH1F * Energy_n_part20MeV[11];
  TH1F * Energy_n_part200MeV[11];
    

  
  TCanvas *c1 = new TCanvas("c1","neutron xy",1100,800);
  double baf_z_l[6] = {355.,635.,915.,1195.,1475.,1755.} ; // baffle start in mm
  TString name[11] = {"target","baffle1","baffle2","baffle3","baffle4","baffle5","baffle6","magnet","back_magnet","nose","Calorimeter"};
  Color_t color_v[11] = {"kBlack","kRed","kPink+6","kPink+3","kOrange","kOrange+7","kYellow-6","kGreen","kCyan","kBlue","kOrange-4"};
  for (int i=0; i<11; i++) {
    sprintf(Title,"en_neutr2MeV_%s",name[i].Data());
    sprintf(Title2,"Probablity of Energy for Neutrons from %s that radiates in gems;E(MeV)",name[i].Data());
    Energy_n_part2MeV[i] = new  TH1F(Title,Title2,20,0.,2.);
    Energy_n_part2MeV[i]->SetLineColor(i+1);
    if (i==4) Energy_n_part2MeV[i]->SetLineColor(kPink);
    if (i==9) Energy_n_part2MeV[i]->SetLineColor(kOrange); 
    if (i==10) Energy_n_part2MeV[i]->SetLineColor(kOrange-4); 
    sprintf(Title,"en_neutr20MeV_%s",name[i].Data());
    sprintf(Title2,"Probablity of Energy for Neutrons from %s that radiates in gems;E(MeV)",name[i].Data());
    Energy_n_part20MeV[i] = new  TH1F(Title,Title2,20,0.,20.);
    Energy_n_part20MeV[i]->SetLineColor(i+1);
    if (i==4) Energy_n_part20MeV[i]->SetLineColor(kPink);
    if (i==9) Energy_n_part20MeV[i]->SetLineColor(kOrange); 
    if (i==10) Energy_n_part20MeV[i]->SetLineColor(kOrange-4); 
    sprintf(Title,"en_neutr200MeV_%s",name[i].Data());
    sprintf(Title2,"Probablity of Energy for Neutrons from %s that radiates in gems;E(MeV)",name[i].Data());
    Energy_n_part200MeV[i] = new  TH1F(Title,Title2,20,0.,200.);
    Energy_n_part200MeV[i]->SetLineColor(i+1);
    if (i==4) Energy_n_part200MeV[i]->SetLineColor(kPink);
    if (i==9) Energy_n_part200MeV[i]->SetLineColor(kOrange); 
    if (i==10) Energy_n_part200MeV[i]->SetLineColor(kOrange-4); 
  }

  for (int i=0; i<6; i++) {
    sprintf(Title,"bafflexy%i",i);
    sprintf(Title2,"Neutron vertex at baffle %i;X(mm);Y(mm)",i+1);
    Hxy_neutron[i] = new TH2F(Title,Title2,n_bins3,-1440.,1440.,n_bins3,-1440.,1440.);
    sprintf(Title,"bafflexy%i_norm",i);
    sprintf(Title2,"Neutron vertex at baffle %i;X(cm);Y(cm)",i+1);
    Hxy_neutron_norm[i] = new TH2F(Title,Title2,n_bins3,-144.,144.,n_bins3,-144.,144.);
  }
  TH2F *Hrz_neutron = new  TH2F("Hzr_neutron","Vertex Z neutron;Z(mm);R(mm)",n_bins,-2500.,5500.,n_bins2,0.,3000.);
  TH2F *Hrz_neutron_test = new  TH2F("Hzr_neutron_test","Magnet Vertex Z neutron;Z(mm);R(mm)",n_bins,-2500.,5500.,n_bins2,0.,3000.);
  TH1F *Hz_neutron = new TH1F("Hz_neutron","Vertex Z neutron;Z(mm);N",n_bins,-2500.,5500.);
  TH1F *Hz_neutron_norm = new TH1F("Hz_neutron_norm","Vertex Z neutron;Z(cm);N/e-",n_bins,-250.,550.);
  TH2F *Hrz_neutron_norm = new  TH2F("Hzr_neutron_norm","Vertex Z neutron;Z(cm);R(cm)",n_bins,-250.,550.,n_bins2,0.,300.);
  TH2F *Hrz_neutron_norm_test = new  TH2F("Hzr_neutron_norm_test","Magnet Vertex Z neutron;Z(cm);R(cm)",n_bins,-250.,550.,n_bins2,0.,300.);
  TH2F *Hrz_neutron_nosh = new  TH2F("Hzr_neutron_nosh","Vertex Z neutron;Z(mm);R(mm)",n_bins,-2500.,5500.,n_bins2,0.,3000.);
  TH1F *Hz_neutron_nosh = new TH1F("Hz_neutron_nosh","Vertex Z neutron;Z(mm);N",n_bins,-2500.,5500.);
  TH1F *Hz_neutron_nosh_norm = new TH1F("Hz_neutron_nosh_norm","Vertex Z neutron;Z(cm);N/e-",n_bins,-250.,550.);
  TH2F *Hrz_neutron_nosh_norm = new  TH2F("Hzr_neutron_nosh_norm","Vertex Z neutron;Z(cm);R(cm)",n_bins,-250.,550.,n_bins2,0.,300.);
  TH1F * Energy_neutron= new TH1F("Energy_neutron","Energy neutron;E(MeV)",600,0.,600.);
  TH1F * Energy_pions= new TH1F("Energy_pions","Energy pions;E(MeV)",600,0.,600.);
  Int_t nentries = (Int_t)input_chain.GetEntries();
  int n_neutrons = 0;
  double vr;
  double vz_cm, vr_cm;
  double tot_niel_n=0;
  double tot_niel_el=0;
  double tot_niel_pr=0;
  double tot_niel_pi=0;
  double sh_tot_niel_n=0;
  double sh_tot_niel_el=0;
  double sh_tot_niel_pr=0;
  double sh_tot_niel_pi=0;
  double weight;
  for (int i=0; i<nentries ; i++) {
    input_chain.GetEntry(i);
    if(i % 100000 == 0 ){
      printf("Analyzed %09d events of total %09d \n",i,nentries);
    }
    if (pid==2112) {
      sh_tot_niel_n = sh_tot_niel_n + niel_neutron.GetNielFactor(E-939.565);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_neutron.GetNielFactor(E-939.565) / double(n_events);
	  gem_niel_cm[j]->Fill(x/10,y/10,weight);
	}
      }
      n_neutrons++;
      Hz_neutron->Fill(vz);
      vr=pow( (pow(vx,2) + pow(vy,2)) , 0.5);
      Hrz_neutron->Fill(vz,vr);
      Energy_neutron->Fill(E-939.565);
      vz_cm = vz / 10.;
      vr_cm = vr / 10. ;
      if (vz>=-100. && vz<=300. && vr<50) {
	Energy_n_part2MeV[0]->Fill(E-939.565); // Target
	Energy_n_part20MeV[0]->Fill(E-939.565); // Target
	Energy_n_part200MeV[0]->Fill(E-939.565); // Target
      }
      else if (vz>=baf_z_l[0] && vz<=(baf_z_l[0]+90.) && vr<1420.) {
	Energy_n_part2MeV[1]->Fill(E-939.565); // Baffle 1
	Energy_n_part20MeV[1]->Fill(E-939.565); // Baffle 1
	Energy_n_part200MeV[1]->Fill(E-939.565); // Baffle 1
      }
      else if (vz>=baf_z_l[1] && vz<=(baf_z_l[1]+90.) && vr<1420.) { 
	Energy_n_part2MeV[2]->Fill(E-939.565); // Baffle 2
	Energy_n_part20MeV[2]->Fill(E-939.565); // Baffle 1
	Energy_n_part200MeV[2]->Fill(E-939.565); // Baffle 1
      }
      else if (vz>=baf_z_l[2] && vz<=(baf_z_l[2]+90.) && vr<1420.) {
	Energy_n_part2MeV[3]->Fill(E-939.565); // Baffle 3
	Energy_n_part20MeV[3]->Fill(E-939.565); // Baffle 3
	Energy_n_part200MeV[3]->Fill(E-939.565); // Baffle 3
      }
      else if (vz>=baf_z_l[3] && vz<=(baf_z_l[3]+90.) && vr<1420.) {
	Energy_n_part2MeV[4]->Fill(E-939.565); // Baffle 4
	Energy_n_part20MeV[4]->Fill(E-939.565); // Baffle 4
	Energy_n_part200MeV[4]->Fill(E-939.565); // Baffle 4
      }
      else if ( (vz>=baf_z_l[4] && vz<1502.6 && vr<1420.) ||  (vz>=1502.6 && vz<=(baf_z_l[4]+90.) && vr<1420. && vr>(430.9+(vz-1502.6)*(1100-430.9)/(4202.6-1502.6)) ) ) {
	Energy_n_part2MeV[5]->Fill(E-939.565); // Baffle 5
	Energy_n_part20MeV[5]->Fill(E-939.565); // Baffle 5
	Energy_n_part200MeV[5]->Fill(E-939.565); // Baffle 5
      }
      else if (vz>=baf_z_l[5] && vz<=(baf_z_l[5]+90.) && vr<1420. && vr>(430.9+(vz-1502.6)*(1100-430.9)/(4202.6-1502.6)) ) {
	Energy_n_part2MeV[6]->Fill(E-939.565); // Baffle 6
	Energy_n_part20MeV[6]->Fill(E-939.565); // Baffle 6
	Energy_n_part200MeV[6]->Fill(E-939.565); // Baffle 6
      }
      else if ( vz>=3200. && vz<3800. && vr>1060. && vr < 2800) {
	Energy_n_part2MeV[10]->Fill(E-939.565); // Baffle 6
	Energy_n_part20MeV[10]->Fill(E-939.565); // Baffle 6
	Energy_n_part200MeV[10]->Fill(E-939.565); // Baffle 6
      }
      else  {
	Energy_n_part2MeV[7]->Fill(E-939.565); // Magnet
	Energy_n_part20MeV[7]->Fill(E-939.565); // Magnet
	Energy_n_part200MeV[7]->Fill(E-939.565); // Magnet
	if ( (E-939.565) < 10. ) {
	  Hrz_neutron_test->Fill(vz,vr);
	}
      }
      if (vz>=4202.6 ) {
	Energy_n_part2MeV[8]->Fill(E-939.565); // Back Magnet
	Energy_n_part20MeV[8]->Fill(E-939.565); // Back Magnet
	Energy_n_part200MeV[8]->Fill(E-939.565); // Back Magnet
      }
      else if ( vz>=1502.6 && vz< 4202.6 && vr<= (430.9+(vz-1502.6)*(1100-430.9)/(4202.6-1502.6)) ) {
	Energy_n_part2MeV[9]->Fill(E-939.565); //Nose
	Energy_n_part20MeV[9]->Fill(E-939.565); //Nose
	Energy_n_part200MeV[9]->Fill(E-939.565); //Nose
      }
      for (int k=0; k<6; k++) {
	if (vz>=baf_z_l[k] && vz<=(baf_z_l[k]+90.) ) Hxy_neutron[k]->Fill(vx,vy);
      }
    }
    else if (pid==11) {
      sh_tot_niel_el = sh_tot_niel_el + niel_electron.GetNielFactor(E-0.510);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_electron.GetNielFactor(E-0.510)/ double(n_events);
	  gem_niel_cm[j]->Fill(x/10,y/10,weight);
	}
      }
    }
    else if (pid==2212) {
      sh_tot_niel_pr = sh_tot_niel_pr + niel_proton.GetNielFactor(E-938.272);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_proton.GetNielFactor(E-938.272) / double(n_events);
	  gem_niel_cm[j]->Fill(x/10,y/10,weight);
	}
      }
    }
    else if (pid==211 || pid==-211) {
      sh_tot_niel_pi = sh_tot_niel_pi + niel_pions.GetNielFactor(E-139.570);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_pions.GetNielFactor(E-139.570) / double(n_events);
	  gem_niel_cm[j]->Fill(x/10,y/10,weight);
	}
      }
    }
    else if (pid==111) {
      sh_tot_niel_pi = sh_tot_niel_pi + niel_pions.GetNielFactor(E-134.976);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_pions.GetNielFactor(E-134.976)/ double(n_events);
	  gem_niel_cm[j]->Fill(x/10,y/10,weight);
	}
      }
    }
      //  if (pid!=22 && pid!=2112) cout << pid << endl;
  }
  // Hz_neutron->SetNormFactor(double(n_neutrons)/double(n_events));
  // Hrz_neutron->SetNormFactor(double(n_neutrons)/double(n_events));
  for (int j=1; j<=n_bins; j++) {
    Hz_neutron_norm->SetBinContent(j,(Hz_neutron->GetBinContent(j)/n_events));
    for (int k=1; k<=n_bins2; k++) {
      Hrz_neutron_norm->SetBinContent(j,k,(Hrz_neutron->GetBinContent(j,k)/n_events));
      Hrz_neutron_norm_test->SetBinContent(j,k,(Hrz_neutron_test->GetBinContent(j,k)/n_events));
    }
  }
  
  for (int j=1; j<=n_bins3; j++) {
    for (int k=1; k<=n_bins3; k++) {
      for (int i=0; i<6; i++) {
	Hxy_neutron_norm[i]->SetBinContent(j,k,(Hxy_neutron[i]->GetBinContent(j,k)/n_events));
      }
    }
  }

  for (int i=0; i<6; i++) {
  Hxy_neutron_norm[i]->Draw("COLZ");
  sprintf(Title,"pictures/shield_baffle_xy%i.pdf",i+1);
  c1->Print(Title);
  sprintf(Title,"pictures/shield_baffle_xy%i.gif",i+1);
  c1->Print(Title);
  }

  sprintf(Title,"pictures/shield_zvertex.pdf"); 
  Hz_neutron_norm->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_zvertex.gif"); 
  c1->Print(Title);

  sprintf(Title,"pictures/shield_rzvertex.pdf"); 
  Hrz_neutron_norm->Draw("COLZ");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_rzvertex.gif"); 
  c1->Print(Title);

  c1->SetLogy();
  sprintf(Title,"pictures/shield_energy_n_2MeVtot.pdf"); 
  Energy_n_part2MeV[0]->SetNormFactor(Energy_n_part2MeV[0]->GetEntries()/double(n_events));
  Energy_n_part2MeV[0]->DrawNormalized(); 
  TLegend *leg = new TLegend(0.55,0.55,0.9,0.9);
  leg->AddEntry( Energy_n_part2MeV[0],name[0].Data(),"l");
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part2MeV[i]->SetNormFactor(Energy_n_part2MeV[i]->GetEntries()/double(n_events));
    Energy_n_part2MeV[i]->DrawNormalized("SAME");
    leg->AddEntry( Energy_n_part2MeV[i],name[i].Data(),"l");
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_n_2MeVtot.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_n_20MeVtot.pdf");  
  Energy_n_part20MeV[0]->SetNormFactor(Energy_n_part20MeV[0]->GetEntries()/double(n_events));
  Energy_n_part20MeV[0]->DrawNormalized(); 
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part20MeV[i]->SetNormFactor(Energy_n_part20MeV[i]->GetEntries()/double(n_events));
    Energy_n_part20MeV[i]->DrawNormalized("SAME");
 
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_n_20MeVtot.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_n_200MeVtot.pdf");  
  Energy_n_part200MeV[0]->SetNormFactor(Energy_n_part200MeV[0]->GetEntries()/double(n_events));
  Energy_n_part200MeV[0]->DrawNormalized(); 
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part200MeV[i]->SetNormFactor(Energy_n_part200MeV[i]->GetEntries()/double(n_events));
    Energy_n_part200MeV[i]->DrawNormalized("SAME");
 
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_n_200MeVtot.gif");
  c1->Print(Title);


  sprintf(Title,"pictures/shield_energy_2MeVtot.pdf"); 
  Energy_n_part2MeV[0]->SetTitle("Energy from Neutrons in gems");
  Energy_n_part2MeV[0]->Draw(); 
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part2MeV[i]->Draw("SAME");
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_2MeVtot.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_20MeVtot.pdf");  
   Energy_n_part20MeV[0]->SetTitle("Energy from Neutrons in gems");
  Energy_n_part20MeV[0]->Draw(); 
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part20MeV[i]->Draw("SAME");
 
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_20MeVtot.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_200MeVtot.pdf");     
  Energy_n_part200MeV[0]->SetTitle("Energy from Neutrons in gems");
  Energy_n_part200MeV[0]->Draw(); 
  for (int i=1; i<11; i++) {
    // sprintf(Title,"pictures/shield_energy_n_%s.pdf",name[i].Data());
    Energy_n_part200MeV[i]->Draw("SAME");
 
  }
  leg->Draw();
  c1->Print(Title);
  sprintf(Title,"pictures/shield_energy_200MeVtot.gif");
  c1->Print(Title);

  Int_t nentries = (Int_t)input_chain_nosh.GetEntries();
  int n_neutrons = 0;
  double vr;
  for (int i=0; i<nentries ; i++) {
    input_chain_nosh.GetEntry(i);
    if(i % 100000 == 0 ){
      printf("Analyzed %09d events of total %09d \n",i,nentries);
    }
    if (pid==2112) {
      tot_niel_n = tot_niel_n + niel_neutron.GetNielFactor(E-939.565);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_neutron.GetNielFactor(E-939.565)/ double(n_events_nosh);
	  gem_niel_cm_nosh[j]->Fill(x/10,y/10,weight);
	}
      }
      n_neutrons++;
      Hz_neutron_nosh->Fill(vz);
      vr=pow( (pow(vx,2) + pow(vy,2)) , 0.5);
      Hrz_neutron_nosh->Fill(vz,vr);
    }
    else if (pid==11){
      tot_niel_el = tot_niel_el + niel_electron.GetNielFactor(E-0.510);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_electron.GetNielFactor(E-0.510)/ double(n_events_nosh);
	  gem_niel_cm_nosh[j]->Fill(x/10,y/10,weight);
	}
      }
    }
    else if (pid==2212) {
      tot_niel_pr = tot_niel_pr + niel_proton.GetNielFactor(E-938.272);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_proton.GetNielFactor(E-938.272)/ double(n_events_nosh);
	  gem_niel_cm_nosh[j]->Fill(x/10,y/10,weight);
	}
      }
    }    
    else if (pid==211 || pid==-211) {
      tot_niel_pi = tot_niel_pi + niel_pions.GetNielFactor(E-139.570);
      Energy_pions->Fill(E-139.570);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_pions.GetNielFactor(E-139.570)/ double(n_events_nosh);
	  gem_niel_cm_nosh[j]->Fill(x/10,y/10,weight);
	}
      }
    }
    else if (pid==111) {
      tot_niel_pi = tot_niel_pi + niel_pions.GetNielFactor(E-134.976);
      Energy_pions->Fill(E-134.976);
      for (int j=0; j<4; j++) {
	if (z>(PlateZ[j]-Dz*2) && z<(PlateZ[j]+Dz*2) ) {
	  weight = niel_pions.GetNielFactor(E-134.976)/ double(n_events_nosh);
	  gem_niel_cm_nosh[j]->Fill(x/10,y/10,weight);
	}
      }
    }
  }


  for (int j=1; j<=n_bins; j++) {
    Hz_neutron_nosh_norm->SetBinContent(j,(Hz_neutron_nosh->GetBinContent(j)/n_events_nosh));
    for (int k=1; k<=n_bins2; k++) {
      Hrz_neutron_nosh_norm->SetBinContent(j,k,(Hrz_neutron_nosh->GetBinContent(j,k)/n_events_nosh));
    }
  }
  Hz_neutron_norm->SetLineColor(2);
  Hz_neutron_nosh_norm->Draw();
  Hz_neutron_norm->Draw("SAME");
  sprintf(Title,"pictures/shield_comp_z_log.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_comp_z_log.pdf");
  c1->Print(Title);

  c1->SetLogy(0);
  Hz_neutron_nosh_norm->Draw();
  Hz_neutron_norm->Draw("SAME");
  sprintf(Title,"pictures/shield_comp_z.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/shield_comp_z.pdf");
  c1->Print(Title);

  Hrz_neutron_nosh_norm->Draw("COLZ");
  sprintf(Title,"pictures/rz_vertex.gif");
  c1->Print(Title);
  sprintf(Title,"pictures/rz_vertex.pdf");
  c1->Print(Title);


  tot_niel_n=tot_niel_n/double(n_events_nosh);
  tot_niel_el=tot_niel_el/double(n_events_nosh);
  tot_niel_pr=tot_niel_pr/double(n_events_nosh);
  tot_niel_pi=tot_niel_pi/double(n_events_nosh);
  sh_tot_niel_n=sh_tot_niel_n/double(n_events);
  sh_tot_niel_el=sh_tot_niel_el/double(n_events);
  sh_tot_niel_pr=sh_tot_niel_pr/double(n_events);
  sh_tot_niel_pi=sh_tot_niel_pi/double(n_events);

}
