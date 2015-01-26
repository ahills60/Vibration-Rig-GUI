# Vibration Rig Tools

This package includes a GUI for opening waveforms for playback and a function for converting waves to MATLAB variables. This document outlines the developed functions and how to use them.

## WAV to MATLAB conversion
Wave files can be converted using the `ReadWaves` function. The function is capable of converting sound wave (`*.wav`) files either in batch or as single files. Its usage is as follows:

```matlab
ReadWaves(path, filename)
```

The `path` is used to declare the path to the wave files (a directory or a single file) and `filename` can be used to denote the output file. Only the `path` is required as the filename can be computed based on the last folder/directory in the path. For instance:

```matlab
ReadWaves('/path/to/lots/of/wave_files/')
```
will generate the MATLAB file `wave_files.mat` containing the converted waves within the path `/path/to/lots/of/wave_files/`.

The MATLAB file will contain variables inherit the same (or similar in the event of illegal characters) name as the file. Additionally, a `Config` variable is created giving the sampling frequency and bit rate of all enclosed waves.

> Note that this function requires that all files have the same sampling frequency and bit rate for them to be included within the same MATLAB save file. Functionality for different bit rates or sampling frequencies has yet to be implemented.

## Vibration Player GUI
Saved MATLAB files can be loaded into the Vibration Player GUI for playback. To load and play back an audio sample, browse for the MATLAB file you wish to import, then click on the open button. The list box is then populated with the variable names contained within the selected MATLAB save file. Selecting a variable and clicking load will automatically scale and display within the figure's axis. Playing the selected sound sample can be achieved using the playback buttons.