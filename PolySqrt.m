/*
Purpose: helper that computes the polynomial part Q of a square root expansion.
Paper location: helper file used by exploratory searches.
Usage: load "PolySqrt.m";
Output: defines PolySqrt(P), with deg(P - Q^2) small.
Reference: the idea goes back to Mestre; see Leopoldo Kulesz,
Courbes algébriques de genre >= 2 possédant de nombreux points rationnels,
Acta Arithmetica, 1998.
*/

function PolySqrt(P)
    Qx := Parent(P);
    Q := BaseRing(Qx);
    R<X> := LaurentSeriesRing(Q);
    x := Generator(Qx);
    PP := R ! Evaluate(P,1/X);
    P2_ := Sqrt(PP);
    Qx<x> := PolynomialRing(Q);
    P2 := Qx ! Reverse(Eltseq(P2_+O(X)));
    return P2;
end function;
