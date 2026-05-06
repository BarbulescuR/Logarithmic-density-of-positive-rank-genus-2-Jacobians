/*
 objective : auxiliary file used by HighRankSimpleJacobianExamples.m
 reference : Roland Dreier. Examples of Genus 2 Curves over Q with Jacobians of High Mordell-Weil Rank. 1997.
              International Mathematics Research Notices.   
*/


name := "Dreier 25";
_<x> := PolynomialRing(Rationals());
f := 4037229*x^6 + 34187102*x^5 - 724533076*x^4 - 4944866082*x^3 + 57659086152*x^2 + 241518308040*x + 313383220164;


C := HyperellipticCurve(f);
Ps := RationalPoints(C:Bound:=1500);
Qs := [Ps[i]-Ps[1] : i in [2..#Ps]];

//xs := [-42, -22, -18, -15, -9, -8, -3, 3, 4, 5, 7, 9, 15, 16, 1147, -1/2,\
 177/2, -102/7, 108/7, -22/9, -9/11, 151/13, -88/17, -2811/22, 249/22];


