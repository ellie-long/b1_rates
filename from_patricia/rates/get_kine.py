import math

print "Use GeV for E and GeV^2 for Q^2"

ein = input('E = ')
xin = input('x = ')
q2in = input('Q^2 = ')



nu = q2in/(2*0.938*xin)
ep = ein - nu
th = 2*math.asin(math.sqrt(q2in/(4*ein*ep)))*180/3.14159

print "nu = %.2f" % nu
print "E' = %.2f" % ep
print "th = %.2f" % th


