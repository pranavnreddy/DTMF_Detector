function [filtered_signal, b, err] = remez_highpass1(z,fs)

% Filter specifications
Fs = fs;             % Sampling frequency
stopband_freq = 950;    % Stopband frequency in Hz
N = 22;                % Filter order

% Normalized frequencies
normalized_stopband_freq = stopband_freq / (Fs / 2);

% Frequency vector for the filter design
Frequencies = [0, normalized_stopband_freq, normalized_stopband_freq + 0.1, 1];

% Desired amplitude response
Amplitudes = [0, 1, 1, 1];

% Weights for the filter design
Weights = [1, 5];

% Filter design using Remez algorithm
[b, err] = remez(N, Frequencies, Amplitudes, Weights);

filtered_signal = filter(b, 1, z);

% Plot the frequency response
%freqz(b_highpass, 1, 1024, Fs);
% title('Frequency Response of Remez FIR Highpass Filter');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% grid on;

end