syms t

N=1024;
Fs=2*2500;
Ts=1/Fs;
t=(0: N-1)*Ts;

%Señal Moduladora 1 
M1=0.5;
F_mod1=60;
A_mod1=1;
S_mod1=A_mod1*cos(2*pi*F_mod1*t);
figure(1)
subplot(2,1,1); 
plot(t, S_mod1)
title("Señal Moduladora 1");

%Señal Portadora 1
%A_port=A_mod/M;
A_port1=1;
F_port1=1000;
S_port1=A_port1*cos(2*pi*F_port1*t);
figure(1)
subplot(2,1,2); 
plot(t, S_port1)
title("Señal Portadora 1");

%Modulación AM 1 
AM1=ammod(S_mod1, F_port1, Fs, 0, A_port1);
figure(2)
plot(t, AM1)
title("Señal Modulada 1")

%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Primera señal modulada AM en el tiempo y espectro. 

%Señal Moduladora 2 
M2=0.5;
F_mod2=100;
A_mod2=1;
S_mod2=A_mod2*cos(2*pi*F_mod2*t);
figure(3)
subplot(2,1,1); 
plot(t, S_mod2)
title("Señal Moduladora 2");

%Señal Portadora 2
%A_port=A_mod/M;
A_port2=1;
F_port2=2000;
S_port2=A_port2*cos(2*pi*F_port2*t);
figure(3)
subplot(2,1,2); 
plot(t, S_port2)
title("Señal Portadora 2");

%Modulación AM 2 
AM2=ammod(S_mod2, F_port2, Fs, 0, A_port2);
figure(4)
plot(t, AM2)
title("Señal Modulada 2")

%MULTIPLEXACIÓN DE SEÑALES
Suma=AM1+AM2+7*cos(2*pi*100*t);
figure(5)
plot(t,Suma)
title("Señal Sumada AM")



%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(6)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")


%Espectro
Y=fft(Suma);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of Suma(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Filtrado de señal media
Wpass=[800 1500];
FiltradoBP=bandpass(Suma,Wpass,Fs);
Y=fft(FiltradoBP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(8)
plot(f,P1) 
title("Filtrado despues de paso banda")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(9)
plot(t,FiltradoBP);
title("Señal media filtrada en el tiempo")
demod_BP=amdemod(FiltradoBP,1000,Fs);%Demudulado señal media
figure(12)
plot(t,demod_BP)
title("SEÑAL BP DEMODULADA DESPUES DE FILTRO")
Y=fft(demod_BP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(13)
plot(f,P1) 
title("ESPECTRO DEMODULADA PB")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Filtrado de señal baja
FiltradoLP=lowpass(Suma,750,Fs);
Y=fft(FiltradoLP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(10)
plot(f,P1) 
title("Filtrado despues de paso bajo")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(11)

plot(t,FiltradoLP);
title("Señal baja filtrada en el tiempo")

%Filtrado de señal alta
FiltradoHP=highpass(Suma,1500,Fs);
Y=fft(FiltradoHP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(10)
plot(f,P1) 
title("Filtrado despues de paso alto")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(11)

plot(t,FiltradoHP);
title("Señal alta filtrada en el tiempo")
%--------------Modulacion FM----------------------

% m = Suma; %mensaje a modular
% 
% fDev = 50;
% 
% fc_fm = 10000;
% Fs=2*fc_fm;
% mi=2;
% %t = (0:1/Fs:0.01);
% 
% s_fm = fmmod(m,fc_fm,Fs,fDev);
% 
% figure(8)
% plot(t,m,'c',t,s_fm,'b--')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('Original Signal','Modulated Signal')
% 
% 
% fm_demod = fmdemod(s_fm,fc_fm,Fs,fDev);
% 
% 
% 
% 
% %Espectro Señal demodulada FM
% Y=fft(fm_demod);
% P2 = abs(Y/N);
% P1 = P2(1:N/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(N/2))/N;
% figure(10)
% plot(f,P1) 
% title("Single-Sided Amplitude Spectrum of señal FM demodulada")
% xlabel("f (Hz)")
% ylabel("|P1(f)|")
% 
% figure(11)
% plot(t,m,'c',t,fm_demod,'b--')
% xlabel('Time (s)')
% ylabel('Amplitude')
% legend('Moduladora','Demodulacion FM')
