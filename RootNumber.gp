/*
objective : make statistics of the rank of Jac(C_a) where C_a:y^2=x^5+a
            It uses a naive method to be compared to stollhecke.gp
reference : B. Allombert. Defining L-functions in GP. 2018. Available online
            at https://pari.math.u-bordeaux.fr/Events/PARI2018/talks/lfun.pdf
*/

t1=gettime();
for(i=1,1000,L = lfungenus2([x^5-(123456789012345678901+i),0]))
\\[r,R,w] = lfunrootres(L));
t2=gettime();
print(t2-t1);
quit
