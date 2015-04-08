function VibrationPlayer_timerCall
%%VIBRATIONPLAYER_TIMERCALL function updates the time on the vibration GUI.

try
    handles = evalin('base', 'FH');
    currSample = evalin('base', 'SoundPlayer.CurrentSample');
    sampleRate = evalin('base', 'SoundPlayer.SampleRate');
catch exception
    % Variable likely doesn't exist, so just return.
    return
end

% Evaluate the time:
theTime = currSample / sampleRate;
nomins = floor(theTime / 60);
nosecs = theTime - (nomins * 60);
timeStr = sprintf('%02u:%05.2f', nomins, nosecs);
set(handles.TheTime, 'String', timeStr);