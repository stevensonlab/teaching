
%% 5.1 Plot single-sided amplitude spectrum

load('ec014_639_samp.mat')

Fs = 256;                     % Sampling frequency
T = 1/Fs;                     % Sample time
t = (0:(size(lfp,1)-1))*T;    % Time vector

y = lfp(:,1);   % signal
NFFT = 2^nextpow2(length(y)); % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2); % get frequency axis from zero up to Nyquist limit
Y = fft(y,NFFT);

% use code from Lab 4
figure(1)
L = Fs*10;
plot(t(1:L),y(1:L))
xlabel('time (s)')

figure(2)
semilogy(f,abs(Y(1:NFFT/2)))
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


%% 5.2 Filter the data and compare to original

% some filter options...
[b,a] = butter(5,[7 9]/(256/2),'bandpass');
% [b,a] = cheby1(???);
% [b,a] = fir1(???);

% or a more detailed design
% d = designfilt(???);
% e.g. d = designfilt('bandpassfir', 'StopbandFrequency1', 6, 'PassbandFrequency1', 7, 'PassbandFrequency2', 9, 'StopbandFrequency2', 10, 'StopbandAttenuation1', 60, 'PassbandRipple', 0.1, 'StopbandAttenuation2', 60, 'SampleRate', 256);
% b = d.Coefficients; a=1;

yfilt = filtfilt(b,a,y);
Yfilt = fft(yfilt,NFFT);

% Plot the original and filtered singal...
figure(1)
L = Fs*10;
plot(t(1:L),y(1:L),t(1:L),yfilt(1:L))
xlabel('time (s)')

% Plot the original and filtered spectrum...
figure(2)
semilogy(f,abs(Y(1:NFFT/2)),f,abs(Yfilt(1:NFFT/2)))
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% Examine the filter properties
figure(3)
plot(b)

figure(4)
freqz(b,a)

%% 5.3 Wavelet Transform...

coefs = cwt(y(1:L),1:32,'morl'); % use Morlet wavelet basis with scales 1:32

figure(5)
subplot(2,1,1)
plot(y(1:L))
axis tight;
subplot(2,1,2)
imagesc(abs(coefs))
xlabel('Time')
ylabel('Scale')

%% 5.4 Plot the position alongside the cwt...

trange = (Fs*180):(Fs*300);
taxis = trange/Fs;
coefs = cwt(y(trange),1:32,'morl'); % use Morlet wavelet basis with scales 1:32

figure(6)
subplot(2,1,1)
plot(taxis,pos(trange))
axis tight;
subplot(2,1,2)
imagesc(taxis,abs(coefs))
xlabel('Time')
ylabel('Scale')
