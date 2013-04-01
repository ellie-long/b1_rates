:Evaluate:	InitAlphaS::usage="The function InitAlphaS[IORD,FR2,MUR,ASMUR,MC,MB,MT] initialises the AlphaS function at perturbative order set to IORD (0=LO, 1=NLO, 2=NNLO), with the ratio of mu_f^2 to mu_r^2 set to FR2, input mu_r in GeV set to MUR, input value of alpha_s at mu_r = MUR set to ASMUR, with flavour transitions when the factorisation scale equals the heavy quark pole masses MC, MB and MT."
:Evaluate:	AlphaS::usage="The function AlphaS[MUR] returns the value of the running strong coupling at a renormalisation scale in GeV of MUR.  A call to InitAlphaS should previously have been made."

:Begin:
:Function:      InitAlphaS
:Pattern:       InitAlphaS[IORD_Integer, FR2_Real, MUR_Real, ASMUR_Real, MC_Real, MB_Real, MT_Real]
:Arguments:     {IORD, FR2, MUR, ASMUR, MC, MB, MT}
:ArgumentTypes: {Integer, Real, Real, Real, Real, Real, Real}
:ReturnType:    Null
:End:

:Begin:
:Function:      AlphaS
:Pattern:       AlphaS[MUR_Real]
:Arguments:     {MUR}
:ArgumentTypes: {Real}
:ReturnType:    Real
:End:
