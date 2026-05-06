/*
objective : auxiliary file used in HighRankSplitJacobianExamples.m
reference : Andrej Dujella and Juan Peral. High rank elliptic curves induced by rational diophantine triples.
               Glasnik Matematicki. vol 55(75). 2020. 237-252
            attributed to Julian Aguirre, Andrej Dujella and Juan Peral. On the rank of elliptic curves coming from
            rational Diophantine triples. The Rocky Mountain journal of mathematics, 2012
*/

Qm<m> := PolynomialRing(Rationals());
Qm<m> := FieldOfFractions(Qm);

t1 := -4*(m^2+m+1)^2*(m^2-1)^4*(m^2+4*m+1)^2;
t2 := 16*(m^2+m+1)^2*(2*m+1)^2*(m^2-1)^2*(m^2+2*m)^2;
t3 := m^2*(2*m+1)^2*(m+2)^2*(5*m^2+8*m+5)^2*(m^2+1)^2; 

a := 2*t1*(1+t1*t2*(1+t2*t3))/((-1+t1*t2*t3)*(1+t1*t2*t3));
b := 2*t2*(1+t2*t3*(1+t3*t1))/((-1+t1*t2*t3)*(1+t1*t2*t3));
c := 2*t3*(1+t3*t1*(1+t1*t2))/((-1+t1*t2*t3)*(1+t1*t2*t3));

Qmx<x> := PolynomialRing(Qm);
f := (x+a*b)*(x+b*c)*(x+c*a);

a6,a4,a2,_ := Explode(Coefficients(f));
E2 := EllipticCurve([0,a2,0,a4,a6]);

x1 := 0;
bool1,y1 := IsSquare(Evaluate(f,x1)); 
P1 := E2 ! [x1,y1];

x2 := 1;
bool2,y2 := IsSquare(Evaluate(f,x2)); 
P2 := E2 ! [x2,y2];

x3 := -a*b+b*(c-b)/(t2*t3);
bool3,y3 := IsSquare(Evaluate(f,x3));
P3 := E2 ! [x3,y3];

x4 := -b*c+c*(a-c)/(t3*t1);
bool4,y4 := IsSquare(Evaluate(f,x4));
P4 := E2 ! [x4,y4];

x5 := -c*a+a*(b-a)/(t1*t2);
bool5,y5 := IsSquare(Evaluate(f,x5));
P5 := E2 ! [x5,y5];

//print "Verification passed.";


