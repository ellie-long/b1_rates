#!/usr/bin/perl -w

use strict;

use lib ("$ENV{GEMC}/database_io");
use geo;
use geo qw($pi);

my $DetectorName = 'CLEO_SIDIS_mrpc';

my $envelope = "solid_$DetectorName";
my $file     = "solid_$DetectorName.txt";

my $rmin      = 1;
my $rmax      = 1000000;

my %detector = ();    # hash (map) that defines the gemc detector
$detector{"rmin"} = $rmin;
$detector{"rmax"} = $rmax;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

# MRPC structure
# 0.8mm PCB + 4.2mm glass + 1.6mm PCB + 4.2mm glass + 0.8mm PCB

sub make_mrpc
{ 
 my $z=400;

 my $Nlayer = 5;
 my @layer_thickness = (0.08,0.42,0.16,0.42,0.08);
 my @material = ("PCBoardM","G4_GLASS_PLATE","PCBoardM","G4_GLASS_PLATE");
 my $color="ff0000";

    $detector{"name"}        = "$DetectorName\_$n";
    $detector{"mother"}      = "$DetectorMother" ;
    $detector{"description"} = $detector{"name"};
    $detector{"pos"}        = "0*cm 0*cm $z*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "111111";
    $detector{"type"}       = "Tube";
    my $Rmin = 96;
    my $Rmax = 207;
    my $Dz   = 1.16/2; # total thickness
    $detector{"dimensions"}  = "$Rmin*cm $Rmax*cm $Dz*cm 0*deg 360*deg";
    $detector{"material"}   = "Vacuum";
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 0;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "";
    $detector{"identifiers"} = "";
    print_det(\%detector, $file);

    for(my $i=1; $i<=$Nlayer; $i++)
    {
	my $layerZ = -$Dz;
	for(my $k=1; $k<=$i-1; $k++)
	{	
	   $layerZ = $layerZ+$layer_thickness[$k-1];
	}
	$layerZ = $layerZ+$layer_thickness[$i-1]/2;
	
	my $DlayerZ=$layer_thickness[$i-1]/2;

	$detector{"name"}        = "$DetectorName\_$i";
	$detector{"mother"}      = "$DetectorName";
	$detector{"description"} = $detector{"name"};
	$detector{"pos"}        = "0*cm 0*cm $layerZ*mm";
	$detector{"rotation"}   = "0*deg 0*deg 0*deg";
	$detector{"color"}      = "$color";
	$detector{"type"}       = "Tube";
	$detector{"dimensions"} = "$Rmin*cm $Rmax*cm $DlayerZ*mm 0*deg 360*deg";
	$detector{"material"}   = "$material[$i-1]";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	if ($i==2 || $i==4){
	  $detector{"sensitivity"} = "FLUX";
	  $detector{"hit_type"}    = "FLUX";
	  $detector{"identifiers"} = "id manual $id";
	}
	else{
	  $detector{"sensitivity"} = "no";
	  $detector{"hit_type"}    = "";
	  $detector{"identifiers"} = "";
	}
	print_det(\%detector, $file);
    }
 }
}
make_mrpc();