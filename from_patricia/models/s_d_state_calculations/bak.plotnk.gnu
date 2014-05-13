set title "Deuteron momentum distribution, various V_{NN}"
set xlabel "k (MeV/c)"
set ylabel	"n(k)"
set logscale y
kf = 240	# some nucleus
a = 2.
C = 4./3.*pi*kf**3
R = 1./(1. -kf/4)
# for k < kf
#g(x) = 1/C*(1-6.*(kf*a/pi)**2)	
#for k > kf < 4 GeV/c
#h(x) = 1./C*(2.*R*(kf*a/pi)**2. * (kf/x)**4.)
# from pickup reactions, see BruecknerFrancisPhysRev.98.1445
alpha = sqrt(1*2.*938)		# should be 18 not 1	
f(x) = alpha/pi**2. * (1/((x**2. + alpha**2)**2.))
plot [0:1000][1e-05:1.e4]'mom_dist_bonn_mevc.data' u 1:4 w lines lw 2 ti " Bonn",\
 '' u 1:2 w lines lw 2 ti " Bonn S-state",\
 '' u 1:3 w lines lw 2 ti " Bonn D-state",\
'mom_dist_cdbonn_mevc.data' u 1:4 w lines lw 2 ti " CD Bonn",\
 '' u 1:2 w lines lw 2 ti " CDBonn S-state",\
 '' u 1:3 w lines lw 2 ti " CDBonn D-state",\
'mom_dist_paris_mevc.data' u 1:4 w lines lw 2 ti " Paris",\
 '' u 1:2 w lines lw 2 ti " Paris S-state",\
 '' u 1:3 w lines lw 2 ti " Paris D-state",\
 'mom_dist_v18_mevc.data' u 1:4 w lines lw 2 ti " V18",\
  '' u 1:2 w lines lw 2 ti " V18 S-state",\
  '' u 1:3 w lines lw 2 ti " V18 D-state"
#,\ f(x)*1.e9 with lines lw 2 ti "other"
