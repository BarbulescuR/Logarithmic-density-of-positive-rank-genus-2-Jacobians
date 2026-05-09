/*
Purpose: optional search/statistics for C_a : y^2 = x^5 + a, used in Section 3.2.1.
Usage: magma "m:=3" StollStats.m
Optional variables:
  m           block number; block m searches a in [(m-1)*1000+1, 1000*m]
  OUTPUT_FILE output log; default stoll-<m>.log
Output: lines "a r", where r is Magma's computed Mordell-Weil rank for selected candidates.
*/

load "RootNumber.m";

if not assigned m then
    m := 1;
end if;

if Type(m) eq MonStgElt then
    m := StringToInteger(m);
end if;

if not assigned OUTPUT_FILE then
    OUTPUT_FILE := "stoll-" cat Sprint(m) cat ".log";
end if;

print "Running Stoll/Bisatt-style optional search for C_a : y^2 = x^5 + a.";
print "Block m =", m;
print "Writing selected candidates to", OUTPUT_FILE;

SetClassGroupBounds("GRH");

_<x> := PolynomialRing(Rationals());


squarefree  := [ a : a in [(m-1)*1000+1..1000*m] | IsSquarefree(a) ];

function pts(a)
    C := HyperellipticCurve(x^5+a);
    J := Jacobian(C);
    return RationalPoints(J:Bound:=500);
end function;

admissible := [ a : a in squarefree | #pts(a) ge 3];

gd := Open(OUTPUT_FILE, "w");

for a in admissible do
	if RootNumber(a) eq (-1)^(#pts(a)+1) then
                C := HyperellipticCurve(x^5+a);
                J := Jacobian(C);
		r :=  #[g : g in Generators(MordellWeilGroup(J)) | Order(g) eq 0 ];

    		fprintf gd,"%o %o\n",a,r;
	end if;
end for;

print "Finished Stoll/Bisatt-style optional search.";
