#include <iomanip>
#include <iostream>
using namespace std;

void copytree_genT_fluxT(char *input_filename="out.root")
{
// gSystem->Load("$ROOTSYS/test/libEvent");

   //Get old file, old tree and set top branch address
   TFile *oldfile = new TFile(input_filename);
   TTree *oldtree_genT = (TTree*)oldfile->Get("genT");
   TTree *oldtree_fluxT = (TTree*)oldfile->Get("fluxT");   
//    TTree *oldtree_genT = (TTree*)oldfile->Get("genT");
//    Event *event   = new Event();
//    oldtree->SetBranchAddress("event",&event);
//    oldtree->SetBranchStatus("*",0);
//    oldtree->SetBranchStatus("event",1);
//    oldtree->SetBranchStatus("fNtrack",1);
//    oldtree->SetBranchStatus("fNseg",1);
//    oldtree->SetBranchStatus("fH",1);

   //Create a new file + a clone of old tree in new file
   TFile *newfile = new TFile("out_genT_fluxT.root","recreate");
   TTree *newtree_genT = oldtree_genT->CloneTree();   
   TTree *newtree_fluxT = oldtree_fluxT->CloneTree();

//    newtree->Print();
   newfile->Write();
   delete oldfile;
   delete newfile;
}