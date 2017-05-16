function [eventsignal] = eventgen(eventdata, duration)
%EVENTGEN generate different types of events
%   There are two types of event impulse and sinusoidal
    samplerate = 272 * 1000;
    
    if strcmp(eventdata.type, 'cosine')
        t = 1/samplerate:1/samplerate:eventdata.duration;
        signal = eventdata.amplitude * cos(2 * pi * t * eventdata.freq);
    elseif strcmp(eventdata.type, 'pulse')
        signal = eventdata.amplitude * ones(1, eventdata.duration*samplerate);
    elseif strcmp(eventdata.type, 'whitenoise')
        signal = wgn(1, eventdata.duration*samplerate, 10 * log10(eventdata.amplitude));
    elseif strcmp(eventdata.type, 'external')
        signal = (eventdata.amplitude * resample(eventdata.exty, samplerate, eventdata.extfs))'; %%%
    end
    
    % Windowing %
    
    % Create delays
    before = zeros(1, eventdata.delay * samplerate);
    after = zeros(1, (duration *samplerate) - length(before) - length(signal));
    eventsignal = [before signal after];
end