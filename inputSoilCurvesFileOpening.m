%---------------------- Script description --------------------------------
% The script to open and read the file with soil moduli curves
%--------------------------------------------------------------------------
cM1 = struct2cell(load(fullname_RreductionCurvesFile));
cM = cM1{1};