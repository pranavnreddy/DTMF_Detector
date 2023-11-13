% Set parameters

function [t_total, wave] = generate_wave(input, fs, duration, gap)
    keys = ["1","2","3","A","4","5","6","B","7","8","9","C","*","0","#","D"];
    low_freqs = [697,697,697,697,770,770,770,770,852,852,852,852,941,941,941,941];
    high_freqs = [1209,1336,1477,1633,1209,1336,1477,1633,1209,1336,1477,1633,1209,1336,1477,1633];
    
    key_low = dictionary(keys,low_freqs);
    key_high = dictionary(keys,high_freqs);
    
    % input = ["1","5","9","D"];
    
    % sampling_rate = 8000; % Hz
    % duration = 0.1; % seconds
    % gap = 0.1; % seconds
    total_duration = length(input) * (duration + gap - 1);
    
    % Initialize concatenated wave
    wave = zeros(1, round(total_duration * fs));
    
    % Generate and concatenate sine waves
    start_index = 1;
    for i = 1:length(input)
        t = 0:1/fs:duration;
        sine_wave = sin(2*pi*key_low(input(i))*t) + sin(2*pi*key_high(input(i))*t);
    
        % Add sine wave to the concatenated wave
        end_index = start_index + length(sine_wave) - 1;
        wave(start_index:end_index) = sine_wave;
    
        % Update start index for the next iteration with a gap
        start_index = end_index + 1 + round(gap * fs);
    end
    
    % Plot the concatenated wave
    t_total = (0:length(wave)-1) / fs;
end
