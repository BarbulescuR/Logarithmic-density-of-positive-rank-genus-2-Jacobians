/*
Purpose: reproduce the split-Jacobian examples used in Appendix A.2 / Lemma A.1.
Usage: magma HighRankSplitJacobianExamples.m
Output: prints the rank statement, degree, and binary-size estimate for the glued genus-2 curve.
*/

load "utils.m";
load "GlueFullTorsion.m";
load "Elkies15.m";
load "DujellaPeral2014.m";

print "Running Appendix A.2 split-Jacobian examples.";
print "First example: Dujella-Peral family glued with Elkies rank-15 elliptic curve.";

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
print "Second example: Kihara family glued with Elkies rank-15 elliptic curve.";
f := DivisionPolynomial(E1,2) div 4;
g := DivisionPolynomial(E2,2) div 4;
Qm := BaseRing(g);
roots_f := [Qm ! rr[1] : rr in Roots(f)];
roots_g := [rr[1] : rr in Roots(g)];
h := glue_full_torsion(g,f,roots_g,roots_f);
print "(Kihara 6) x (Elkies 15) is a family of rank 21.";
print "The degree of the genus-2 curve is: ",Max([Degree(hi) : hi in Coefficients(h)]);
print "The binary size of the genus-2 curve is: ",Max([PolySize(hi) : hi in Coefficients(h)]);
