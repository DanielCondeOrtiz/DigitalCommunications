 close all
 clear all
 clc
 
 %En vez de hacerlo con la figura de la practica, lo hacemos con la del ejercicio que nos han dado
 
 Nb=1e6;
 Bn=randi([0,1],1,Nb);
 L=4;
 M=4;
 Eb=((2^2)*15)/(12*log2(4));
 s=[ones(1,L/2),zeros(1,L/2)]*sqrt(2)/2;
 [Xn,Bn,phi,alfabeto]=transmisorpam(Bn,Eb,M,s,L);
 
 
 %Demodulador por proyeccion
 L1=length(phi);
 Ns=length(Bn)/log2(length(alfabeto));
 sn=phi*reshape(Xn,L,Ns);
 
 sx=unique(single(sn)); %el single no hace falta

 
%xmax=max(sn1)+max(sn1)/10+0.5; 
%xmin=-(abs(min(sn1))+abs(min(sn1))/10)-0.5;

%plot([xmin,xmax],[0,0],'b--');
%hold on


% o plot(sx,0,'r*')
for ii=1:length(sx)
  plot(sx(ii),0,'r*')
  hold on
  end  

  grid on
  hold off
  
  %tambien se podria hacer con demodulador por filtro, que es con flipr y eso, deberia salir lo mismo
  
  %%Punto 4
  
  %añadir ruido a sn
  SNRdb=[0:1:7];
  figure
  for k=1:length(SNRdb)
    snr=10^(SNRdb(k)/10);
    N0=Eb/snr;
    zn=randn(size(sn))*sqrt(N0);
    rn=sn+zn;
    [fr,cr]LCDfdp(rn,50);
    subplot(3,3,k);
    plot(cr,fr)
    end