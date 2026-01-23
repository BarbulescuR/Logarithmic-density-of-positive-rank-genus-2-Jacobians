t1=gettime();
for(i=1,1000,L = lfungenus2([x^5-(123456789012345678901+i),0]))
\\[r,R,w] = lfunrootres(L));
t2=gettime();
print(t2-t1);
quit
