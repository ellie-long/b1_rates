import numpy as np
import scipy as sp
import matplotlib.pyplot as plt


# This code will estimate the time requirements for running a DNP experiment at JLab

# For the b1 experiment proposal, there were 720 total PAC hours requested 
# Split up for the SHMS:
#       20% @ x=0.15
#       30% @ x=0.3
#       50% @ x=0.495
#
# The HMS had all 100% of its time at x=0.55.

# For the Azz experiment proposal, there were 816 total PAC hours separated by beam energy.
#       3%    @ 2.2 GeV
#       23.5% @ 6.6 GeV
#       73.5% @ 8.8 GeV

# Overhead:
# vvvv Annealing vvvv
#   For annealing, the dose between anneals should be approximately 4e15 to 5e15 e/cm^2. 
#   This is approximately what was used in P.M. McKee, NIM A 526, 60 (2004).
#
#   In order to determine how often anneals occur in time, we need some information.

I = 85 # nA = beam current
r = 1.5 # cm = target cup radius
#d = 5e15 # e/cm^2 = dose between anneals
d = 4e15 # e/cm^2 = dose between anneals
A = np.pi*r**2 #cm^2 = area of face of target cup
e = d*A # e/anneal = # of electrons between anneals
eps = 1.602e-10 # nA = current of 1 e/s
t_s = e*eps/I # s = time per anneal in seconds @ 100% efficiency
t_h = t_s/(60*60) # h = time per anneal in hours @ 100% efficiency

print('Time Between Anneals:',round(t_h,2),'hours')
print('Time required for target material change:','4','hours')

# ^^^^ Annealing ^^^^

# vvvv Vector Pol. Cycles vvvv
# From Feb.-Mar. 2023 Hall B ND3 data, the spin-up time constant is approximately 2643 s = 44.05 min = 0.7342 hr. 
# This is an average of three online spin-up fits, giving time constants of 3998.5 s, 2796.5 s, and 1161.2 s.

# Assuming we wait for 4 time constants (98% of max pol.) before running beam, 
# this would come out to about 3 hours of polarizing before starting the next
# vector Pz run cycle. A more conservative estimate might be 3-8 hours between
# cycles, assuming a way of 4 to 10 time constants (98% - 99.995%).
# During the 3 spin-ups in Hall B in Feb/March 2023, they waited 7, 8, and 3 hours.

print('Time required for vector pol. spin-ups:','3-8', 'hours')
print('Time required for target TE measurements:','4','hours')
print('Time required for packing fraction/dilution runs:','1','hour')
# ^^^^ Vector Pol. Cycles ^^^^

# vvvv Beam Overhead vvvv
print('Time required for BCM calibration:','2','hours')
print('Time required for each Optics run:','4','hours')
print('Time required for each Linac change:','8','hours')
print('Time required for each Momentum/angle change:','2','hours')
# ^^^^ Beam Overhead ^^^^

# vvvv Tensor Pol. Cycle vvvv
# According to Dustin's 2/1/23 email, 
# "It's just a second or so to go from tensor enhanced to vector only (tensor =0).  
# It's also just a second to go from tensor=0 to tensor =! 0.  But optimizing the 
# tensor-enhanced state takes on the order of 20 seconds or so.  Depending on what 
# the overall area of the signal is, the FOM will change greatly even if it's 
# optimized simple because of the values of the polarization which are never great 
# for ND3 after a particular dose has accumulated.
# As an example, if you're at around 25% vector polarized and you want to go from 
# tensor=0 to tensor enhanced, you might be better off not depleting the pedestal 
# because it takes more time to build back up than the peak.  If one were to cycle 
# too fast without giving time for the overall Boltzmann area to build the FOM 
# drops over time. 

t_to_0 = 10 # seconds
t_to_Pzz = 30 # seconds

