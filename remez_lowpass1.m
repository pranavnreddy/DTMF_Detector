function [filtered_signal, b, err] = remez_lowpass1(z,fs)
% Filter specifications
Fs = fs;             % Sampling frequency
Fc = 1650;              % Cutoff frequency in Hz
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
[b, err] = firpm(N, Frequencies, Amplitudes, Weights);
filtered_signal = filter(b,1,z);


end
