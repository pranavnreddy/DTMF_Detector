function [filtered_signal, b, err] = remez_lowpass2(z,fs)

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
<<<<<<< HEAD
[b, err] = firpm(N, Frequencies, Amplitudes, Weights);
=======
b = remez(N, Frequencies, Amplitudes, Weights);
>>>>>>> d715817ca27f1c64c3f3b8f964518b4ea5a7df24

filtered_signal = filter(b,1,z);

% Plot the frequency response
%freqz(b, 1, 1024, Fs);
<<<<<<< HEAD
% title('Frequency Response of Remez FIR Lowpass Filter');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% grid on;
=======
title('Frequency Response of Remez FIR Lowpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
>>>>>>> d715817ca27f1c64c3f3b8f964518b4ea5a7df24

end
