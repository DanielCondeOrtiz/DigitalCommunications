clear all
close all

% Obtención de los parámetros de la simulación

Nb =        input('Nº de bits a transmitir ......................: ');
Eb =        input('Energia media transmitida ....................: ');
M  =        input('Valor de M para la modulación M-aria .........: ');
p  =        input('Pulso básico para transmisión ................:  ');
L  =        input('Nº de muestras por bit .......................: ');
Rb =        input('Tasa de transmision en bps ...................: ');
NumVeces = input('Número de veces que debemos promediar ........: ');

% Nb=1e4;
% Eb = 4;
% M = 16;
% L  = 4;
% Rb = 100;
% NumVeces=10;

% Forcemos que el nº de muestras por bit sea par
L = ceil(L/2)*2;

% Pulso con el código de Manchester
p = [ones(1,L/2) -ones(1,L/2)];

% Pulso sinusoidal
%p=sin(pi*(0:L-1)/L);

Tb = 1/Rb;
Ts = Tb*log2(M);
Ns = Nb/log2(M);

Tm = Ts/L;
Fm = 1/Tm;

S=zeros(1,Ns*L);     % Inicialicemos 

% Calculemos el PSD  de la señal transmitida
for i=1:NumVeces
    [Xn]=transmisorpam(randi(2,1,Nb)-1, Eb,M,p,L);
    S = S+(1/(Ns*L))*abs(fftshift(fft(Xn))).^2;
end

% El promedio de los PSD calculados
Sx = S/NumVeces;
ff = linspace(-Fm/2,Fm/2,length(Sx));

% El espectro densidad de potencia ideal del código de Manchester
Sx_ideal= Eb*(sin(pi*ff*Ts/2).^2).*(sinc(ff*Ts/2).^2);

% El espectro densidad de potencia ideal de código sinusoidal
%Sx_ideal=log2(M)*Eb*(2*sqrt(2)/pi)^2*((cos(pi*Ts*ff))./(1-(2*Ts*ff).^2)).^2;


    Sx_idealdbm=10*log10(10^3*Sx_ideal);
    subplot(211); h=plot(ff,Sx_idealdbm);
    set(h,'linewidth', 1.0);
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sx_idealdbm) max(Sx_idealdbm)+10]);
    grid on
    title('Espectro densidad de potencia ideal','FontWeight','bold',...
        'FontName','Times');
        
% El espectro densidad de potencia simulado    
Sdbm=10*log10(10^3*Sx);
    subplot(212); h=plot(ff,Sdbm,'r');
    set(h,'linewidth', 'default');
    xlabel('f [Hz]','FontSize',12,'FontName','Times');
    ylabel('S_X(f)[dBm]','FontSize',12,'FontName','Times');
    axis([-Fm/2 Fm/2 -max(Sdbm) max(Sdbm)+10]);
    grid on;
    title('Espectro densidad de potencia simualdo','FontWeight','bold',...
    'FontName','Times');
