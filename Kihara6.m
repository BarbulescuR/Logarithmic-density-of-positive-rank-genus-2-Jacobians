// Shoichi Kihara. On the rank of elliptic curves with three rational points of order 2. (III) (2004)


Rt<t> := PolynomialRing(Rationals());
Qt<t> := FieldOfFractions(Rt);

s := (t^2 - 4*t + 1)/(t^2 - 1);
x := (t + 1)*(2*t^8 - 14*t^7 + 146*t^6 - 473*t^5 + 674*t^4 - 473*t^3 + 146*t^2 - 14*t + 2);
y := (t - 2)*(2*t^8 - 2*t^7 + 104*t^6 - 221*t^5 + 149*t^4 - 35*t^3 - 7*t^2 + 16*t - 4);
z := (2*t - 1)*(4*t^8 - 16*t^7 + 7*t^6 + 35*t^5 - 149*t^4+ 221*t^3 - 104*t^2 + 2*t - 2);
p := 2*t^9 + 18*t^8 - 144*t^7 + 411*t^6 - 477*t^5 + 225*t^4 - 75*t^3 + 72*t^2 - 36*t + 2;
q := (t - 2)^3*(t + 1)^3*(2*t - 1)^3;
r := 2*t^9 - 36*t^8 + 72*t^7 - 75*t^6 + 225*t^5 - 477*t^4 + 411*t^3 - 144*t^2 + 18*t + 2;
a := (x^4 + y^4 + z^4)/(x^2*y^2 + y^2*z^2 + z^2*x^2);

QtX<X> := PolynomialRing(Qt);
f := X*(X - 4*a - 8)*(X - 4*a^2 - 4*a + 8);
B := -( (4*a + 8) + (4*a^2 + 4*a - 8));
C := (4*a + 8)*(4*a^2 + 4*a - 8);
E2 := EllipticCurve(X*(X^2+X*B+C)); 

//print "Degree(B),PolySize(B)",PolySize(B);
//print "Degree(C),PolySize(C)",PolySize(C);

// Degree(B),PolySize(B) 72 67.3736754654471622040206472595
// Degree(C),PolySize(C) 108 103.001803366946424824967352250


