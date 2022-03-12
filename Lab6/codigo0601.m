% Dado un conjunto de par�metros, se genera la secuencia de informaci�n 
% digital, se representa la constelaci�n de las se�ales transmitidas,  
% se obtiene la probabilidad de error te�rica y la experimental y se  
% representan ambas. Llama a transmisorpam para generar la secuencia.

% Nb = N� de bits a transmitir
% Bn = Secuencia de d�gitos binarios
% Eb = Energ�a media transmitida en Julios
% L =  N� de puntos que vamos a utilizar para transmitir un bit

clear all
close all

L=4;
Nb=1e6;
Eb=9;
M=2;

Bn=randi(2,1,Nb)-1;

% Definici�n del pulso b�sico. 
p=ones(1,L);

% Obtiene la secuencia transmitida y el pulso normalizado
[Xn,Bn,An,phi,alfabeto]=transmisorpam(Bn,Eb,M,p,L);

% Actualiza el valor de Nb
Nb=length(Bn);

% Respuesta impulsiva del filtro adaptado
hr = fliplr(phi);

% Salida del filtro adaptado
yn = conv(hr,Xn);

% El resultado de muestrear la se�al anterior
sn=yn(L:L:Nb*L);          

% La secuencia a la salida en el caso de utilizar un demodulador 
% de correlaci�n
sn=phi*reshape(Xn,L,Nb); 

% Obtiene valores �nicos
sx=unique(sn);
xmax=max(sx)+max(sx)/10+0.5;
xmin=-(abs(min(sx))+abs(min(sx))/10)-0.5;

% Pinta los ejes
figure(1)
plot([xmin,xmax],[0,0],'b-');
hold on

% Representa la constelaci�n
plot(sx,zeros(1,length(sx)), 'r*')
grid on

% Distancia m�nima de la constelaci�n
dmin = abs(sx(1)-sx(2));

% Definamos la relaci�n se�al ruido en dB
SNRdb = 0:1:12;

% Inicializaci�n
correctos=zeros(1,Nb);
errorsimulado=zeros(size(SNRdb));

for ii=1:length(SNRdb)
    SNR = 10^(SNRdb(ii)/10); % relaci�n se�al ruido en unidades naturales
    varzn = Eb/(2*SNR);
    
    % El ruido a la entrada del detector
    zn = sqrt(varzn)*randn(size(sn));
    
    % El vector de observaci�n a la entrada del detector
    rn = sn + zn;

    % El umbral est� situado en sx(1)+sx(2))/2
    correctos = rn>(sx(1)+sx(2))/2==Bn;
    conterror = Nb-sum(correctos);
    errorsimulado(ii)=conterror/Nb;
    
end    

% La representaci�n del error
SNRdb2 = 0:0.1:12;
errorteorico=zeros(size(SNRdb2));

for ii=1:length(SNRdb2),
   % Relaci�n se�al ruido en unidades naturales
   SNR = 10^(SNRdb2(ii)/10);
   
   % Error te�rico de la constelaci�n antipodal
   errorteorico(ii)=Qfunct(sqrt(2*SNR));

end

% Representaci�n de la probabilidad de error
figure(2)
semilogy(SNRdb,errorsimulado,'r*');
hold on
semilogy(SNRdb2,errorteorico,'k-');
axis([0 12 10^(-7) 0.1])

grid on
xlabel('Relaci�n se�al/Ruido E_b/N_0 (dB)'), ...
    ylabel('Probabilidad de error de bit (P_b)')

% Crea la leyenda
legend({'Simulado','Te�rico'},'Location','Best');
