#include <iomanip>
#include <iostream>
using namespace std;

void root2hit(string input_filename){
  
///======== process hits from root file into a txt file ===============

char output_filename[80];
// sprintf (output_filename, "%s_fluxT.txt",path);
// sprintf (output_filename, "%s.txt",path);
sprintf(output_filename, "%s.txt",input_filename.substr(0,input_filename.rfind(".")).c_str());
ofstream output(output_filename);

// char input_filename[80]
// sprintf (input_filename, "%s.root",path);
// sprintf (filename, "%s/out.%i.root",path,k);
for(int k=0;k<1;k++){

  TFile *file=new TFile(input_filename.c_str());
    if (file->IsZombie()) {
       cout << "Error opening file" << input_filename << endl;
       continue;
//        exit(-1);
    }
    else cout << "open file " << input_filename << endl;


// TTree *Tgen = (TTree*) file_electron->Get("genT");
// Int_t gen_evn,gen_ngen,gen_id;
// Float_t gen_px,gen_py,gen_pz,gen_p,gen_phi,gen_theta,gen_vx,gen_vy,gen_vz;
// Tgen->SetBranchAddress("evn",&gen_evn);
// Tgen->SetBranchAddress("ngen",&gen_ngen);
// Tgen->SetBranchAddress("id",&gen_id);
// Tgen->SetBranchAddress("px",&gen_px);
// Tgen->SetBranchAddress("py",&gen_py);
// Tgen->SetBranchAddress("pz",&gen_pz);
// Tgen->SetBranchAddress("p",&gen_p);
// Tgen->SetBranchAddress("phi",&gen_phi);
// Tgen->SetBranchAddress("theta",&gen_theta);
// Tgen->SetBranchAddress("vx",&gen_vx);
// Tgen->SetBranchAddress("vy",&gen_vy);
// Tgen->SetBranchAddress("vz",&gen_vz);

TTree *Tflux = (TTree*) file->Get("fluxT");
Int_t flux_evn,flux_nfluxhit;
Int_t flux_ID_array[9999],*flux_pid_array[9999],*flux_mpid_array[9999];
Int_t *flux_ID=flux_ID_array,*flux_pid=flux_pid_array,*flux_mpid=flux_mpid_array;
Float_t flux_Edep_array[9999],flux_E_array[9999],flux_x_array[9999],flux_y_array[9999],flux_z_array[9999],flux_lx_array[9999],flux_ly_array[9999],flux_lz_array[9999],flux_t_array[9999],flux_px_array[9999],flux_py_array[9999],flux_pz_array[9999],flux_vx_array[9999],flux_vy_array[9999],flux_vz_array[9999],flux_mvx_array[9999],flux_mvy_array[9999],flux_mvz_array[9999];
Float_t *flux_Edep=flux_Edep_array,*flux_E=flux_E_array,*flux_x=flux_x_array,*flux_y=flux_y_array,*flux_z=flux_z_array,*flux_lx=flux_lx_array,*flux_ly=flux_ly_array,*flux_lz=flux_lz_array,*flux_t=flux_t_array,*flux_px=flux_px_array,*flux_py=flux_py_array,*flux_pz=flux_pz_array,*flux_vx=flux_vx_array,*flux_vy=flux_vy_array,*flux_vz=flux_vz_array,*flux_mvx=flux_mvx_array,*flux_mvy=flux_mvy_array,*flux_mvz=flux_mvz_array;
Tflux->SetBranchAddress("evn",&flux_evn);
Tflux->SetBranchAddress("nfluxhit",&flux_nfluxhit);
Tflux->SetBranchAddress("ID",flux_ID);
Tflux->SetBranchAddress("Edep",flux_Edep);
Tflux->SetBranchAddress("E",flux_E);
Tflux->SetBranchAddress("x",flux_x);
Tflux->SetBranchAddress("y",flux_y);
Tflux->SetBranchAddress("z",flux_z);
Tflux->SetBranchAddress("lx",flux_lx);
Tflux->SetBranchAddress("ly",flux_ly);
Tflux->SetBranchAddress("lz",flux_lz);
Tflux->SetBranchAddress("t",flux_t);
Tflux->SetBranchAddress("pid",flux_pid);
Tflux->SetBranchAddress("mpid",flux_mpid);
Tflux->SetBranchAddress("px",flux_px);
Tflux->SetBranchAddress("py",flux_py);
Tflux->SetBranchAddress("pz",flux_pz);
Tflux->SetBranchAddress("vx",flux_vx);
Tflux->SetBranchAddress("vy",flux_vy);
Tflux->SetBranchAddress("vz",flux_vz);
Tflux->SetBranchAddress("mvx",flux_mvx);
Tflux->SetBranchAddress("mvy",flux_mvy);
Tflux->SetBranchAddress("mvz",flux_mvz);

// Int_t nevent = (Int_t)Tgen->GetEntries();
Int_t nevent = (Int_t)Tflux->GetEntries();
Int_t nselected = 0;
cout << nevent << endl;

for (Int_t i=0;i<nevent;i++) {
  cout << i << "\r";
  
//       if (i==3483533 || i==14267810 || i==14974234 || i== 17797556) continue;
      //3487436
  //   Tgen->GetEntry(i);
  Tflux->GetEntry(i);
  
    for (Int_t j=0;j<flux_nfluxhit;j++) {
     
      output << flux_evn<< " " << flux_nfluxhit << " " << *(flux_ID+j) << " " << *(flux_pid+j) << " " << *(flux_mpid+j) << " " <<  *(flux_Edep+j) << " " << *(flux_E+j) << " " << *(flux_x+j) << " " << *(flux_y+j) << " " << *(flux_z+j) << " " << *(flux_vx+j) << " " << *(flux_vy+j) << " " << *(flux_vz+j)  << " " << *(flux_px+j) << " " << *(flux_py+j) << " " << *(flux_pz+j) << endl;
      
//          cout << flux_evn<< " " << flux_nfluxhit << " " << *(flux_ID+j) << " " << *(flux_pid+j) << " " << *(flux_mpid+j) << " " <<  *(flux_Edep+j) << " " << *(flux_E+j) << " " << *(flux_x+j) << " " << *(flux_y+j) << " " << *(flux_z+j) << " " << *(flux_vx+j) << " " << *(flux_vy+j) << " " << *(flux_vz+j)  << " " << *(flux_px+j) << " " << *(flux_py+j) << " " << *(flux_pz+j) << endl;
      
//           if ( *(flux_ID+j)<11 || *(flux_ID+j) >16) {cout << "wrong flux_ID " << *(flux_ID+j) << " " << flux_evn << endl; continue;}      

    }
}

file->Close();
}

output.close();

}