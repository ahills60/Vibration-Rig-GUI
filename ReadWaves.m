function ReadWaves(filepath, outfilename)
%READWAVES(PATH, FILENAME)
%
% The readwaves function reads wave (*.wav) files located within the PATH
% folder and creates a variables that are stored in FILENAME.
%
%  Author: Andrew Hills (a.hills@sheffield.ac.uk)
% Version: 1.0 (19/01/2015)

if nargin == 0
    error('Not enough inputs. Specify file path and output filename.')
elseif nargin == 1 || nargin == 2
    % Split the filepath and see if a file was given
    [p, f, e] = fileparts(filepath);
    
    if nargin == 1
        % Try to come up with an output filename based on the path
        if isempty(f) || strcmp(f, '*')
            % Base on path
            splits = strsplit(p, filesep);
            if isempty(splits{end})
                error('Unable to extract destination filename from path.')
            end
            outfilename = splits{end};
        else
            % base on filename
            outfilename = f;
        end
    end
else
    error('Invalid number of inputs. Expected two: file path and output filename')
end
    
% By this point, we should have a valid output filename. Now issue a dir command
% to determine how many files need to be converted.
if isempty(e) && isempty(f)
    filepath = [filepath filesep '*.wav'];
end
    
filelist = dir(filepath);

outvar = struct;

initialFs = 0;
initialBR = 0;

for idx = 1:length(filelist)
    currFilename = filelist(idx).name;
    currFilepath = [p filesep currFilename];
    
    varname = matlab.lang.makeValidName(currFilename);
    
    % Now check to see if this field already exists
    if isfield(outvar, varname)
        warning(sprintf('Unable to add %s as variable name %s already exists.', currFilename, varname));
        continue;
    end
    
    % Read the wave file, taking the waveform, sampling frequency and bit rate
    [wav, s] = audioread(currFilepath);
    wavinfo = audioinfo(currFilepath);
    b = wavinfo.BitsPerSample;
    
    % Save the sample frequency and bit rate if it hasn't been done already
    if initialFs == 0 && initialBR == 0
        initialFs = s;
        initialBR = b;
    else
        if initialFs ~= s || initialBR ~= b
            warning(sprintf('Unable to add %s due to mismatch with the sample rate and/or bitrate.', currFilename));
            continue;
        end
    end
    
    outvar = setfield(outvar, varname, wav);
end

% Now quickly create the Config variable and add to the output variable struct
Config.SampleRate = initialFs;
Config.BitRate = initialBR;

outvar.Config = Config;

% Save all variables to the destination file
save(outfilename, '-struct', 'outvar')