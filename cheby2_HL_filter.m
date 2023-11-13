function [filtered_signal, b, a] = cheby2_HL_filter(z, fs, n, passband_edge, stopband_edge, passband_ripple, stopband_attenuation)
wp =  passband_edge / (fs/2);  % convert to radians per second
ws =  stopband_edge / (fs/2);  % convert to radians per second

[b, a] = cheby2(n, stopband_attenuation, [wp ws], 'bandpass');


filtered_signal = filter(b, a, z);
end