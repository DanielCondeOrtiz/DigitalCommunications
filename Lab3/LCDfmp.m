function     [f,C]  =LCDfmp(X)    %C: Centro
C= unique(X);
[N,C] =hist(X,C);


f= N/ length(X);