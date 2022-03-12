function fx=LCDnormal(x,m,v)
fx=(1/(sqrt(2*pi*v)))*exp(-((x-m).^2)/(2*v));