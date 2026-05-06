
_<x> := PolynomialRing(Rationals());
f := 60516*x^6 + 1680225324*x^5 + 200663873413*x^4
     - 1021197439562*x^3 - 290505889943111*x^2
     + 316071770416320*x + 123355813282790400;

C := HyperellipticCurve(f);


 xs := [-98, -30, 7, 20, 44, 56, 241, -85/2, -104/3, -80/3, 65/3, 661/3,
      99/4, 44/5, 272/5, -185/6, 25/6, 95/6, 667/6, 865/6, -159/7,
      144/7, -889/8, -333/10, -648/11, 365/11, -92/13, -926/25];


function QSqrt(r)
    p := Integers() ! Numerator(r);
    q := Integers() ! Denominator(r);
    ip := Sqrt(p);
    iq := Sqrt(q);
    return ip/iq:
end function;


for xi in xs do
    yi := QSqrt(xi);
    Pi := C ! [xi,yi];
    
    

