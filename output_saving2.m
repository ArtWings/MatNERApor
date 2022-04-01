%---------------------- Script description --------------------------------
% The script to save .txt file with output summary and .mat files with general and supplementary output
%--------------------------------------------------------------------------

fullname_spectra_file = strcat(pathToOutput, 'spectra.txt');

general_output{1} = cell_of_a;
general_output{2} = cell_of_v;
general_output{3} = cell_of_d;
general_output{4} = cell_of_s;
general_output{5} = cell_of_e;
save(strcat(dir_output, ProfileFname(1:length(ProfileFname)-4), '\general_output.mat'), 'general_output', '-mat');

sup_output{1} = Sa_Node;
sup_output{2} = Sv_Node;
sup_output{3} = Sd_Node;
sup_output{4} = av_Sa_Node;
sup_output{5} = av_Sv_Node;
sup_output{6} = av_Sd_Node;
sup_output{7} = av_A_max_Node;
sup_output{8} = max_av_Sa_Node;
sup_output{9} = max_av_Sv_Node;
sup_output{10} = max_av_Sd_Node;
sup_output{11} = T_max_av_Sa_Node;
save(strcat(dir_output, ProfileFname(1:length(ProfileFname)-4), '\sup_output.mat'), 'sup_output', '-mat');


output_comparison = struct('Period', T, 'Sa_bot', Sa_bot, 'Sa_surf', Sa_surf,...
    'Sv_bot', Sv_bot, 'Sv_surf', Sv_surf, 'Sd_bot', Sd_bot, 'Sd_surf',...
    Sd_surf, 'k_Sa', k_Sa, 'k_Sv', k_Sv, 'k_Sd', k_Sd);

q1 = length(Sa_surf);
F = fopen(fullname_spectra_file, 'w');
fprintf(F, '%-17s %-17s %-17s %-17s %-17s %-17s %-17s %-17s %-17s %-17s\n', 'Period(s)', 'Sa(surf,g)', 'Sa(bot,g)',...
    'k(Sa)', 'Sv(surf,cm/s)', 'Sv(bot,cm/s)', 'k(Sv)', 'Sd(surf,cm)', 'Sd(bot,cm)', 'k(Sd)');
for i = 1:1:q1
    fprintf(F, '%-17d %-17d %-17d %-17d %-17d %-17d %-17d %-17d %-17d %-17d\n',...
        output_comparison.Period(i), output_comparison.Sa_surf(i)/9.8/100, output_comparison.Sa_bot(i)/9.8/100,...
        output_comparison.k_Sa(i), output_comparison.Sv_surf(i), output_comparison.Sv_bot(i), output_comparison.k_Sv(i),...
        output_comparison.Sd_surf(i), output_comparison.Sd_bot(i), output_comparison.k_Sd(i));
end
fclose(F);

Fsum = fopen(fullname_summary, 'a');
if MainLoop == 3
    fprintf(Fsum, '%-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s', 'Profiles', 'Amax(average)', 'Vmax(average)', 'Dmax(average)',...
            'SaAvMax(surf,g)', 'T(SaAvMax)', 'SvAvMax(surf,cm/s)', 'SdAvMax(surf,cm)', 'kSAavMax', 'T(kSAavMax)', 'kSVavMax', 'kSDavMax');
end
fprintf(Fsum, '\r\n%-20s %-20d %-20d %-20d %-20d %-20d %-20d %-20d %-20d %-20d %-20d %-20d', strcat('Profile', ProfileFname(13:length(ProfileFname)-4)),...
    output_layer_Surf.Amax_average, output_layer_Surf.Vmax_average,...
                output_layer_Surf.Dmax_average, max(Sa_surf/9.8/100), T_Sa_surf_max, max(Sv_surf), max(Sd_surf), max(k_Sa), T_k_Sa_max, max(k_Sv), max(k_Sd));
fclose(Fsum);