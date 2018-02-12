
%% 4.1 Plot time series

load('chb_sample.mat')

% y = ???;

Fs = 256;                     % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(y);                % Length of signal
t = (0:L-1)*T;                % Time vector

% Plot singal...
figure(1)
% plot(???)
title('EEG')
xlabel('Time [s]')

%% 4.2 Compute and plot Fourier Transform

% NFFT = ???;
Y = fft(y,NFFT);
f = Fs/2*linspace(0,1,NFFT/2); % get frequency axis from zero up to Nyquist limit

% Plot single-sided amplitude spectrum.
figure(2)
% plot(???)
ylabel('Amplitude')
xlabel('Frequency [Hz]')

% note: instead of fft many labs prefer pwelch or pmtm

%% 4.3 Compute and plot a Spectrogram

figure(3)
% [S,f,t] = spectrogram(???);
% imagesc(???)
axis xy
xlabel('Time [s]'); ylabel('Frequency [Hz]')


%% 4.4 Compare Wide vs Narrow-band Spectrograms...

