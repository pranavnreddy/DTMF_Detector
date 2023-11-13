
function [filtered_signal_array_low, filtered_signal_array_high] = remez_filter_DTMF(fs, duration, gap, keys_pressed)
% Constants
% fs = 8000;  % Sampling frequency
% duration = 0.1;  % Duration of each key press (100 ms)
% gap = 0.1;  % 100 ms delay between keys

[~, z] = generate_wave(keys_pressed, fs, duration, gap);

filtered_signal_p1 = remez_lowpass1(z,fs);
downsampled_signal_p1 = downsample(filtered_signal_p1, 2);

filtered_signal_low = remez_lowpass2(downsampled_signal_p1,fs/2);

filtered_signal_high = remez_highpass1(downsampled_signal_p1,fs/2);

% Downsample the filtered signal by 2-to-1

downsampled_signal_low = downsample(filtered_signal_low, 2);
downsampled_signal_high = downsample(filtered_signal_high, 2);

% Assign values to the array
filtered_signal_array_low_1 = remez_band_filter(downsampled_signal_low,fs/4,677,717);
filtered_signal_array_low_2 = remez_band_filter_special(downsampled_signal_low,fs/4,750,790);
filtered_signal_array_low_3 = remez_band_filter_special(downsampled_signal_low,fs/4,832,872);
filtered_signal_array_low_4 = remez_band_filter(downsampled_signal_low,fs/4,921,961);
filtered_signal_array_low=[filtered_signal_array_low_1;filtered_signal_array_low_2;filtered_signal_array_low_3;filtered_signal_array_low_4];

filtered_signal_array_high_1 = remez_band_filter_special(downsampled_signal_high,fs/4,770,810);
filtered_signal_array_high_2 = remez_band_filter_special(downsampled_signal_high,fs/4,645,685);
filtered_signal_array_high_3 = remez_band_filter_special(downsampled_signal_high,fs/4,505,545);
filtered_signal_array_high_4 = remez_band_filter_special(downsampled_signal_high,fs/4,350,390);
filtered_signal_array_high=[filtered_signal_array_high_1;filtered_signal_array_high_2;filtered_signal_array_high_3;filtered_signal_array_high_4];

end