load "utils.m";
load "GlueFullTorsion.m";
load "Elkies15.m";
load "DujellaPeral2014.m";


f := DivisionPolynomial(E1,2) div 4;
g := DivisionPolynomial(E2,2) div 4;
Qm := BaseRing(g);
roots_f := [Qm ! rr[1] : rr in Roots(f)];
roots_g := [rr[1] : rr in Roots(g)];
h := glue_full_torsion(g,f,roots_g,roots_f);
print "(Elkies 5) x (Elkies 15) is a family of rank 20.";
print "The degree of the genus-2 curve is: ",Max([Degree(hi) : hi in Coefficients(h)]);
print "The binary size of the genus-2 curve is: ",Max([PolySize(hi) : hi in Coefficients(h)]);

load "Kihara6.m";
f := DivisionPolynomial(E1,2) div 4;
g := DivisionPolynomial(E2,2) div 4;
Qm := BaseRing(g);
roots_f := [Qm ! rr[1] : rr in Roots(f)];
roots_g := [rr[1] : rr in Roots(g)];
h := glue_full_torsion(g,f,roots_g,roots_f);
print "(Kihara 6) x (Elkies 15) is a family of rank 21.";
print "The degree of the genus-2 curve is: ",Max([Degree(hi) : hi in Coefficients(h)]);
print "The binary size of the genus-2 curve is: ",Max([PolySize(hi) : hi in Coefficients(h)]);
