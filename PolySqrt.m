
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

