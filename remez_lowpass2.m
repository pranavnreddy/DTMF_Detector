function [filtered_signal] = remez_lowpass2(z,fs)

% Filter specifications
Fs = fs;             % Sampling frequency
Fc = 950;              % Cutoff frequency in Hz
N = 22;                % Filter order

% Normalized frequencies
normalizedFc = Fc / (Fs / 2);

% Frequency vector for the filter design
Frequencies = [0, normalizedFc, normalizedFc+0.1, 1];

% Desired amplitude response
Amplitudes = [1, 1, 0, 0];

% Weights for the filter design
Weights = [1, 5];

% Filter design using Remez algorithm
b = remez(N, Frequencies, Amplitudes, Weights);

filtered_signal = filter(b,1,z);

% Plot the frequency response
%freqz(b, 1, 1024, Fs);
title('Frequency Response of Remez FIR Lowpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

end
