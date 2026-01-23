
/*
xs := [-12, -11, -9, -7, -6, -5, -2, 2, 3, 6, 7, 9, 16, 17];
P := &*[(x-xi) : xi in xs];
A:= x^7-4*x^6-288*x^5+198*x^4+19641*x^3+6090*x^2-340154*x-227164;
B := -(P-A^2); 
B1 := XsToBs(xs);
for xi in xs do
    assert Evaluate(B,xi) eq Evaluate(A,xi)^2;
end for;

xs := [-12, -11, -10, -9, -8, -4, -1, 1, 5, 8, 9, 10, 14, 18];
B2 := XsToBs(xs);

*/
function XsToBs(xs)
    _<x> := PolynomialRing(Rationals());
    P := &*[(x-xi) : xi in xs];
    A := PolySqrt(P);
    B := -(P-A^2);
    return A,B; 
end function;
