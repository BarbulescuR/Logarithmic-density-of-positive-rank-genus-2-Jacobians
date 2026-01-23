/*
Noam Elkies, Simple genus-2 Jacobian of rank at least 29,
Message to the NMBRTHRY list. 2015. Available online at 
https://listserv.nodak.edu/cgi-bin/wa.exe?A2=ind1501&L=NMBRTHRY&P=R2
*/

name := "Elkies 29 genus2";
_<x> := PolynomialRing(Rationals());
f := 60516*x^6 + 1680225324*x^5 + 200663873413*x^4
     - 1021197439562*x^3 - 290505889943111*x^2
     + 316071770416320*x + 123355813282790400;

xs := [-98, -30, 7, 20, 44, 56, 241, -85/2, -104/3, -80/3, 65/3, 661/3,
      99/4, 44/5, 272/5, -185/6, 25/6, 95/6, 667/6, 865/6, -159/7,
      144/7, -889/8, -333/10, -648/11, 365/11, -92/13, -926/25];
	
