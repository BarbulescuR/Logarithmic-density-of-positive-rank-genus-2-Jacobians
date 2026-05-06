/*
objective : make statistics for the genus tzo curves of eauqtion C_a: y^2=x^5+a. Each line is of the form (a,r)
            where r is the rank of Jac(C_a). Since an early abort strategy is used, only some of the values of a
			are written, mostly corresponding with the large values of r.
			It uses and illustrates Section 3.2.1 in the article.
reference : Matthew Bisatt, Root number of the Jacobian of y2= x^p+ a, Journal de th ́eorie des nombresde Bordeaux
               34 (2022), no. 2, 575–582.
*/

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

