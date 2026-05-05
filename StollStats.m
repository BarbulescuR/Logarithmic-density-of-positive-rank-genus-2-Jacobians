load "RootNumber.m";

print("usage: magma \"m:=3\" StollStats.m");
print("the time needed is approximately 10 seconds per value of m");

SetClassGroupBounds("GRH");

m := StringToInteger(m);


_<x> := PolynomialRing(Rationals());


squarefree  := [ a : a in [(m-1)*1000+1..1000*m] | IsSquarefree(a) ];

function pts(a)
    C := HyperellipticCurve(x^5+a);
    J := Jacobian(C);
    return RationalPoints(J:Bound:=500);
end function;

admissible := [ a : a in squarefree | #pts(a) ge 3];

gd := Open("stoll-" cat Sprint(m) cat ".log","w");

for a in admissible do
	if RootNumber(a) eq (-1)^(#pts(a)+1) then
                C := HyperellipticCurve(x^5+a);
                J := Jacobian(C);
		r :=  #[g : g in Generators(MordellWeilGroup(J)) | Order(g) eq 0 ];

    		fprintf gd,"%o %o\n",a,r;
	end if;
end for;

