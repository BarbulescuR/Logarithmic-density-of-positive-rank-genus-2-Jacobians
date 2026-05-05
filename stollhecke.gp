/* stollhecke.gp */
/* written by Aurel Page aurel.page@inria.fr */
/* The script is unused but it illustrates how to use Stoll's work to compute the L-function */
/* of a curve of the form y^2=x^5+a */


/* The program is based on:
Stoll, Michael
On the arithmetic of the curves y^2=x^l+A. II.
J. Number Theory 93, No. 2, 183-206 (2002). 
https://zbmath.org/1004.11038

assumptions :
ell odd prime
A 2*ell-free integer not divisible by ell

characters notation: section 3.1 p.9
eta_A(pr): section 3.3 p.15
CM type: section 3.3 p.15
conductor: Prop 3.3 p.18
*/

eqn(A,ell) = x^ell + A;

chip(x,p,g,ell) =
{
  my(dl);
  x=Mod(x,p);
  if(x,
    dl = znlog(x^((p-1)\ell),g,ell);
    exp(-2*I*Pi*dl/ell)
  , \\else
    0
  );
};

\\pr of degree 1
charvalue(A,ell,K,pr,j=1) =
{
  my(modpr,p,g,ch,J);
  modpr = nfmodprinit(K,pr);
  p = pr.p;
  g = nfmodpr(K,x,modpr);
  if(znorder(g)!=ell, error("wrong order(g)"));
  ch = chip(4*A,p,g,ell)^j;
  J = -sum(a=2,p-1,chip(a,p,g,ell)^j*chip(1-a,p,g,ell)^j);
  kronecker(A,p) * ch * J;
};

heckechar(A,ell,verb=0,check=0) =
{
  my(K,ootyp,Lchioo,eq,cond,e,B,f2,fell,lambda,faB,dec2,gc,Psi,pq,Lpr,Lchipr,
    bnr,H,L,err,Bpart);
  if(verb,print("ell=",ell));
  if(verb,print("A=",A));
  K = bnfinit(polcyclo(ell),1);
  if(verb,print("pol=", K.pol));
  lambda = idealprimedec(K,ell)[1];
  ootyp = Set(vector((ell-1)\2, j, Mod(-j,ell)^-1));
  ootyp = vector(K.r2, j, if(setsearch(ootyp,
    Mod(round(ell/(2*Pi)*arg(nfeltembed(K,x,j))),ell)
    ),1,-1));
  \\ootyp = vector(K.r2,i,if(imag(nfeltembed(K,x,i))>0,1,-1)); 
  \\ /!\ not sure if I understood correctly the infinity type from the paper
  \\ootyp = [1,-1]; \\seems to work for ell=5
  Lchioo = vector(K.r2,i,[-ootyp[i],I*1/2]);
  if(verb,print("ootyp=", ootyp));
  eq = eqn(A,ell);
  if(verb,print("eq=",eq));
  e = valuation(A,2);
  B = A\2^e;
  if(e%2,
    f2 = 3
  ,B%4==3, \\e even
    f2 = 2
  ,e<2*ell-2, \\B=1 mod 4 and e even 
    f2 = 1
  , \\else e=2*ell-2 and B=1 mod 4
    f2 = 0
  );
  if(verb,print("f2=", f2));
  fell = if(((A^(ell-1)-1)\ell)%ell, 2, 1);
  if(verb,print("fell=", fell));
  faB = factor(B);
  faB[,1] = apply(p -> idealprimedec(K,p), faB[,1]);
  dec2 = idealprimedec(K,2);
  if(B>1,
    Bpart = concat(vector(#faB~,i,apply(pr->[pr,pr.e*faB[i,2]],faB[i,1])))~;
  ,\\else
    Bpart = [];
  );
  cond = matconcat([
  Mat(apply(pr->[pr,pr.e*f2],dec2)~);
  Mat([lambda,fell]);
  Mat(Bpart)
  ]);
  cond = matreduce(cond);
  if(verb,print("cond="); printp(cond));
  gc = gcharinit(K,cond);
  Lpr = List(); Lchipr = List();
  bnr = bnrinit(K,cond);
  H = matdiagonal(bnr.cyc);
  if(verb,print("H="); printp(H));
  bnd = ceil(5*log(abs(K.disc)^2*idealnorm(K,idealfactorback(K,cond)))^2);
  if(verb,print("bnd=", bnd));
  while(H!=1,
    my(p,pr,v,Hv,val);
    p = randomprime(bnd,ell);
    if(p==ell || p==2 || B%p==0, next);
    pr = idealprimedec(K,p)[1];
    v = bnrisprincipal(bnr,pr,0);
    Hv = mathnfmodid(matconcat([v,H]), bnr.cyc);
    if(Hv==H, next);
    H = Hv;
    if(verb,print("\npr = ", pr));
    listput(~Lpr, pr);
    val = log(charvalue(A,ell,K,pr))/(2*I*Pi);
    listput(~Lchipr, val);
    if(verb,print("H="); printp(H));
    if(check,
      my(cp,cp2);
      cp = hyperellcharpoly(Mod(eq,p));
      cp2 = prod(j=1,ell-1, x - charvalue(A,ell,K,pr,j));
      print("      cp =",cp);
      print("round cp2=",round(cp2));
      print("cp2=",cp2);
      if(cp!=round(cp2), error("wrong charvalue!"));
    );
  );
  Lpr = Vec(Lpr); Lchipr = Vec(Lchipr);
  Psi = gcharidentify(gc, concat([1..K.r2],Lpr), concat(Lchioo,Lchipr));
  Psi = round(2*Psi,&err)/2;
  if(verb,print("err=",err));
  if(verb,print("Psi=",Psi));
  if(verb,print("Lchioo=", Lchioo));
  if(verb,print("Psi_oo=", vector(K.r2,i,gcharlocal(gc,Psi,i))));
  if(check,
    if(!gcharisalgebraic(gc,Psi,&pq), error("Psi not algebraic!"));
    if(Set(concat(pq))!=[0,1] || Set(apply(vecsum,pq))!=[1],
      error("wrong type Psi (not {0,1})!"));
  );
  L = lfuncreate([gc,Psi]);

  if(check,
    foreach(Lpr,pr,
      my(p=pr.p, cp = hyperellcharpoly(Mod(eq,p)));
      if(round(polrecip(1/lfuneuler(L,p))) != cp,
        print("cp=", cp);
        print("cp(L): ", polrecip(1/lfuneuler(L,p)));
        print("charvalue=", charvalue(A,ell,K,pr));
        print("Psi(pr):", gchareval(gc,Psi,pr));
        error("wrong euler factor at p=", pr.p)
      );
    );
    forprime(p=5,1000,
      if(A%p==0 || p==ell, next);
      my(cp = hyperellcharpoly(Mod(eq,p)));
      if(round(polrecip(1/lfuneuler(L,p))) != cp,
        print("cp=", cp);
        print("cp(L): ", polrecip(1/lfuneuler(L,p)));
        error("wrong euler factor at p=", pr.p)
      );
    );
  );
  [eq,K,cond,gc,Psi,L]
};


computeL(A)={
eq_K_cond_gc_Psi_L = heckechar(A,5);
L = eq_K_cond_gc_Psi_L[6];
L
}

rk(A)={
eq_K_cond_gc_Psi_L = heckechar(A,5);
L = eq_K_cond_gc_Psi_L[6];
r = lfunorderzero(L);
r
}

rootnumber(A)={
eq_K_cond_gc_Psi_L = heckechar(A,5);
L = eq_K_cond_gc_Psi_L[6];
eps = lfunrootres(L)[3];
eps
}


evnum(A)={
eq_K_cond_gc_Psi_L = heckechar(A,5);
L = eq_K_cond_gc_Psi_L[6];
r1 = lfun(L,1);
r2 = lfun(L,1,1);
[r1,r2]
}



lan(A)={
eq_K_cond_gc_Psi_L = heckechar(A,5);
L = eq_K_cond_gc_Psi_L[6];
Lan = lfunan(L,100);
Lan
}

\\t1=gettime();foreach([1..100],i,computeL(1234567));t2=gettime();print(t2-t1)

\\ example : computeL(2)
