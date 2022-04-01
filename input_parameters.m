%---------------------- Script description --------------------------------
% The script to set global input parametes and paths with input files
%------------------------------- Input ------------------------------------
addpath('.\input');     % adding path to the input folder
addpath('.\output');    % adding path to the output folder

% Fullname of file with input set of accelerograms:  
fullname_input_acc = 'input\Acc\M60R10.mat'; 
% Fullname of file with input set of soil moduli curves:  
fullname_RreductionCurvesFile = 'input\ModuliCurves\ModuliCurvesSandClayRock.mat';
% Path to directory with files with input soil profiles:  
pathToDirWithProfiles = 'input\Profiles\';

% Time step [s]:
dt = 0.01; 
% Number of subnodes for each sublayer:
subnodes_number = 30;
% Damping [fraction]:
b = 0.05;
% Fullname of file with input spectral periods vector (for response spectra
% calculation):
fullname_SpectralPeriods = 'input\SpectralPeriodsForRS.mat';

% Path to directory with output:  
dir_output = 'output\';
% Fullname of file with summary output .txt file:  
fullname_summary = 'output\Summary.txt';