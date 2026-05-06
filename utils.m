/*
objective : verify the rank of the genus-2 curves in Appendix A.
            It is used as auxiliary file in HighRankSimpleJacobianExamples.m
			HighRankSplitJacobianExamples.m
*/

/*	
EXAMPLE :
gd := Open("Families-list.log","w");
load "Stahlke16.m";
CurveToRankAndHeight("Stahlke 16",f,[],gd:Qs:=Qs);
*/	
procedure CurveToRankAndHeight(name,f,xs,gd:Qs:=[])
    function iSqrt(r)
       p := Numerator(r); 
       q := Denominator(r); 
       sp := Rationals() ! (Integers() ! Sqrt(p));
       sq := Rationals() ! (Integers() ! Sqrt(q));
       return sp/sq;
    end function;


    C := HyperellipticCurve(f);
    J := Jacobian(C);


    if Qs eq [] then
        Ps := [];
        x0 := xs[1];
        P0 := C ! [x0,iSqrt(Evaluate(f,x0))];
        for i in [2..#xs] do
            xi := xs[i];
            P := C ! [xi,iSqrt(Evaluate(f,xi))];
            Q := P-P0;
    	Append(~Ps,P);
            Append(~Qs,Q);
        end for;
    end if;

    B:=ReducedBasis(Qs);

    M := HeightPairingMatrix(B);
    r := Rank(M);
    h := Maximum([CanonicalHeight(b): b in B]);
    fprintf gd,"The %o curve has rank %o and canonical height %o.\n",name,r,h;

end procedure;

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



function XsToBs(xs)
    _<x> := PolynomialRing(Rationals());
    P := &*[(x-xi) : xi in xs];
    A := PolySqrt(P);
    B := P-A^2;
    return B; 
end function;



function FractionNorm(A)
    Qx := Parent(A);
    //x := Generator(Qx);
    Q := BaseRing(Qx);
    NA:= Numerator(A);
    //print Degree(NA);
    DA:= Denominator(A);
    //print Degree(DA);
    function size(NA)
	return Max([0] cat [Abs(ee) : ee in Coefficients(NA)]);
    end function;
    n := Log(2,Max(size(NA),size(DA)));
    d := Max(Degree(NA),Degree(DA));
    return d,n;
end function;

function Size(A)
    if A eq 0 then
        return 1;
    end if;
    NA := Numerator(A);
    DA := Denominator(A);
    n := Log(2,Max(Abs(NA),Abs(DA)));
    return n; 
end function;


function PolySize(A)
    if A eq 0 then
        return 1;
    end if;
    NA := Numerator(A);
    DA := Denominator(A);
    mN := Max([Size(Ai) : Ai in Coefficients(NA)]);
    mD := Max([Size(Ai) : Ai in Coefficients(DA)]);
    n := Max(mN,mD);
    return n; 
end function;
