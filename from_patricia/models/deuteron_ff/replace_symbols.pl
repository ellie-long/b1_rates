#!/usr/bin/perl

# look through the file for the definition of markers m2, m3, and m5
# and replace, in the definition, the sequence " s}" by " 10 lw s 3 lw}"

if ($#ARGV <0) {
    print "Must specify filename(s)\n";
    exit;
}

$m32="";
while ( $file = pop @ARGV ) {
#$file = $ARGV[0];
    open(INPUT, $file) || die "Can't open $file : $!\n";
    $fileo = $file;
    $fileo =~ s/\.eps$/_RPL.eps/;
#    print "input file is $file, output file is $fileo\n";
    open(OUT, ">".$fileo) || die "Can't open $fileo for output : $!\n";
    
    while ( <INPUT> ) {
	if ( /\/m2 / || /\/m3 / || /\/m4 / ) {
	    $outl = s/ s\}/ 10 lw s 3 lw\}/;
	}
	if ( /\/m27 / ) { #save it to use for m32
	    $m32 = $_;
	    $m32 =~ s/\/m27 /\/m32 /;
	    $m32 =~ s/ s\}/ f\}/;
	    print OUT $m32;
	}
	s/ m31/ m32/g;
	print OUT $_;
    }
    
    close INPUT;
    close OUT;
    rename $fileo, $file;
}
