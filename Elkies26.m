/*
objective : auxiliary file in HighRankSimpleJacobianExamples.m
reference : Noam Elkies. Curves of genus 2 with many rational points via K3 surfaces. 2008. 
            ACM Communications in Computer Algebra.
*/


name := "Elkies 26";
_<x> := PolynomialRing(Rationals());
f := 80878009*x^6 - 236558406*x^5 - 1018244179*x^4
     + 4436648480*x^3 + 6445563464*x^2 - 13620761544*x + 68406^2;

C := HyperellipticCurve(f);
Ps := RationalPoints(C:Bound:=500);
Qs := [Ps[i]-Ps[1] : i in [2..#Ps]];
 
