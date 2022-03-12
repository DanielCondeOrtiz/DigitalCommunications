function[f, C] = LCDfdp (X, Nbins)

[N, C] =hist(X, Nbins);
f = N/length(X)/(C(2)-C(1));