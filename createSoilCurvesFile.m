%---------------------- Script description --------------------------------
% The script to create file with the curves of shear and tangential shear moduli and shear resistance  
%------------------------------- Input ------------------------------------
G_Gmax_curve_cell = G_Gmax_cell1;         % cell array with G/Gmax(e) curves (strain - percentage, G/Gmax - fraction)
SoilCurvesOutputFile = 'SoilCurvesOutput.mat';  % name of file with output
%--------------------------------------------------------------------------

H_cell = cell(1,length(G_Gmax_curve_cell));     % tangential shear modulus
R_cell = cell(1,length(G_Gmax_curve_cell));     % shear resistance
SoilCurvesOutput = cell(1,length(G_Gmax_curve_cell));

for i = 1:1:length(G_Gmax_curve_cell)
    [H_cell{i},R_cell{i}] = compSoilCurvesParams(G_Gmax_curve_cell{i}(:,1),G_Gmax_curve_cell{i}(:,2));
    SoilCurvesOutput{i} = [G_Gmax_curve_cell{i}(:,1)*100, G_Gmax_curve_cell{i}(:,2), H_cell{i}, R_cell{i}];    
end

save(SoilCurvesOutputFile, 'SoilCurvesOutput', '-mat');

clearvars

%--------------------------------------------------------------------------