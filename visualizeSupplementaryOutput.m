%---------------------- Script description --------------------------------
% The script to visualize supplementary output: average or single response spectra 
%--------------------------------------------------------------------------
clear all
%------------------------------- Input ------------------------------------

sup_output_path = 'output\ProfileClayeySoilOnFlysh\sup_output.mat';  % path to sup_output.out file
fullname_SpectralPeriods = 'input\SpectralPeriodsForRS.mat';     % path to spectral periods vector file
num_of_input_acc = 2;   % number of input accelerogram
num_of_sublayer = 3;    % number of sublayer
what_to_vis = 'SAav_surf_bot';    % choose what to visualize: 
% 'SAav_surf_bot' - comparison of the average response spectra
% (acceleration) for surface and bottom layers
% 'SVav_surf_bot' - comparison of the average response spectra
% (velocity) for surface and bottom layers
% 'SDav_surf_bot' - comparison of the average response spectra
% (displacement) for surface and bottom layers
% 'SA' - response spectrum (acceleration) for particular input accelerogram and sublayer 
% 'SV' - response spectrum (velocity) for particular input accelerogram and sublayer
% 'SD' - response spectrum (displacement) for particular input accelerogram and sublayer
% 'SAav' - average response spectrum (acceleration) for particular sublayer
% 'SVav' - average response spectrum (velocity) for particular sublayer
% 'SDav' - average response spectrum (displacement) for particular sublayer

%------------------------------ Output ------------------------------------
% if what_to_vis = 'SAav_surf_bot' than output: SAav_surf - average
% response spectrum (acceleration) for surface, SAav_bot - average
% response spectrum (acceleration) for bottom;
%
% if what_to_vis = 'SVav_surf_bot' than output: SVav_surf - average
% response spectrum (velocity) for surface, SVav_bot - average
% response spectrum (velocity) for bottom;
%
% if what_to_vis = 'SDav_surf_bot' than output: SDav_surf - average
% response spectrum (displacement) for surface, SDVav_bot - average
% response spectrum (displacement) for bottom;
%
% if what_to_vis = 'SA' than output: SA_to_vis - response spectrum (acceleration) for particular input accelerogram and sublayer;
%
% if what_to_vis = 'SV' than output: SV_to_vis - response spectrum (velocity) for particular input accelerogram and sublayer;
%
% if what_to_vis = 'SD' than output: SD_to_vis - response spectrum (displacement) for particular input accelerogram and sublayer;
%
% if what_to_vis = 'SAav' than output: SAav_to_vis - average response spectrum (acceleration) for particular sublayer;
%
% if what_to_vis = 'SVav' than output: SVav_to_vis - average response spectrum (velocity) for particular sublayer;
%
% if what_to_vis = 'SDav' than output: SDav_to_vis - average response spectrum (displacement) for particular sublayer;
%--------------------------------------------------------------------------

sup_output_cell = struct2cell(load(sup_output_path));
sup_output_matrix = sup_output_cell{1};   

sp_per = struct2cell(load(fullname_SpectralPeriods));
spectra_periods = sp_per{1};

SA_cell = sup_output_matrix{1}; 
SV_cell = sup_output_matrix{2};
SD_cell = sup_output_matrix{3};
SAav_cell = sup_output_matrix{4};
SVav_cell = sup_output_matrix{5};
SDav_cell = sup_output_matrix{6};
Amax_av_cell = sup_output_matrix{7};
max_SAav_cell = sup_output_matrix{8};
max_SVav_cell = sup_output_matrix{9};
max_SDav_cell = sup_output_matrix{10};
max_T_SAav_cell = sup_output_matrix{11};

if strcmp(what_to_vis, 'SAav_surf_bot') == 1 
    SAav_surf = SAav_cell{1,1};
    SAav_bot = SAav_cell{1,length(SAav_cell)};
    semilogx(spectra_periods, SAav_surf, 'r', spectra_periods, SAav_bot, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SA, [cm/s^2]');
    title('Average response spectra (acceleration) for surface and bottom layers');
    legend('surface layer', 'bottom layer');
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SVav_surf_bot') == 1
    SVav_surf = SVav_cell{1,1};
    SVav_bot = SVav_cell{1,length(SVav_cell)};
    semilogx(spectra_periods, SVav_surf, 'r', spectra_periods, SVav_bot, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SV, [cm/s]');
    title('Average response spectra (velocity) for surface and bottom layers');
    legend('surface layer', 'bottom layer', 'Location', 'northwest');
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SDav_surf_bot') == 1
    SDav_surf = SDav_cell{1,1};
    SDav_bot = SDav_cell{1,length(SDav_cell)};
    semilogx(spectra_periods, SDav_surf, 'r', spectra_periods, SDav_bot, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SD, [cm]');
    title('Average response spectra (displacement) for surface and bottom layers');
    legend('surface layer', 'bottom layer', 'Location', 'northwest');
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SA') == 1
    SA_to_vis = SA_cell{num_of_input_acc,num_of_sublayer};
    semilogx(spectra_periods, SA_to_vis, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SA, [cm/s^2]');
    title(strcat('Response spectrum (acceleration), Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SV') == 1
    SV_to_vis = SV_cell{num_of_input_acc,num_of_sublayer};
    semilogx(spectra_periods, SV_to_vis, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SV, [cm/s]');
    title(strcat('Response spectrum (velocity), Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SD') == 1
    SD_to_vis = SD_cell{num_of_input_acc,num_of_sublayer};
    semilogx(spectra_periods, SD_to_vis, 'b', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SD, [cm]');
    title(strcat('Response spectrum (displacement), Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SAav') == 1
    SAav_to_vis = SAav_cell{1,num_of_sublayer};
    semilogx(spectra_periods, SAav_to_vis, 'r', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SA, [cm/s^2]');
    title(strcat('Average response spectrum (acceleration), Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SVav') == 1
    SVav_to_vis = SVav_cell{1,num_of_sublayer};
    semilogx(spectra_periods, SVav_to_vis, 'r', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SV, [cm/s]');
    title(strcat('Average response spectrum (velocity), Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'SDav') == 1
    SDav_to_vis = SDav_cell{1,num_of_sublayer};
    semilogx(spectra_periods, SDav_to_vis, 'r', 'LineWidth', 3)
    set(gca, 'FontSize', 10);
    xlabel('Period, s');
    ylabel('SD, [cm]');
    title(strcat('Average response spectrum (displacement), Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
end



