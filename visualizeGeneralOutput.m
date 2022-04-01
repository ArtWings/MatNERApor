%---------------------- Script description --------------------------------
% The script to visualize general output: acceleration, velocity, displacement time
% histories or stress-strain plot for particular number of input accelerogram
% and number of sublayer
%--------------------------------------------------------------------------
clear all
%------------------------------- Input ------------------------------------

general_output_path = 'output\ProfileClayeySoilOnFlysh\general_output.mat';  % path to general_output.out file
num_of_input_acc = 1;   % number of input accelerogram
num_of_sublayer = 1;    % number of sublayer
Fs = 100;   % sample rate
what_to_vis = 'acc';    % choose what to visualize: 
% 'acc' -   accelerogation time history
% 'vel' -   velocity time history
% 'dis' -   dosplacement time history
% 'stress-strain' - strain-stress plot

%------------------------------ Output ------------------------------------
% if what_to_vis = 'acc' than output: acc_to_vis - acceleration time
% history, t - time vector, dt - time step;
%
% if what_to_vis = 'vel' than output: vel_to_vis - velocity time
% history, t - time vector, dt - time step;
%
% if what_to_vis = 'dis' than output: dis_to_vis - displacement time
% history, t - time vector, dt - time step;
%
% if what_to_vis = 'stress-strain' than output: stress_to_vis - stress vector, strain_to_vis - strain vector;
%--------------------------------------------------------------------------

general_output_cell = struct2cell(load(general_output_path));
general_output_matrix = general_output_cell{1};   

acc_cell = general_output_matrix{1}; 
vel_cell = general_output_matrix{2};
dis_cell = general_output_matrix{3};
stress_cell = general_output_matrix{4};
strain_cell = general_output_matrix{5};

if strcmp(what_to_vis, 'acc') == 1 
    acc_to_vis = acc_cell{1,num_of_input_acc}(num_of_sublayer,:);
    dt = 1/Fs;
    t = (1:1:length(acc_to_vis))*dt;
    plot(t, acc_to_vis, 'k')
    set(gca, 'FontSize', 10);
    xlabel('Time, s');
    ylabel('Acceleration, [g]');
    title(strcat('Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'vel') == 1 
    vel_to_vis = vel_cell{1,num_of_input_acc}(num_of_sublayer,:);
    dt = 1/Fs;
    t = (1:1:length(vel_to_vis))*dt;
    plot(t, vel_to_vis, 'b')
    set(gca, 'FontSize', 10);
    xlabel('Time, s');
    ylabel('Velocity, [cm/s]');
    title(strcat('Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'dis') == 1 
    dis_to_vis = dis_cell{1,num_of_input_acc}(num_of_sublayer,:);
    dt = 1/Fs;
    t = (1:1:length(dis_to_vis))*dt;
    plot(t, dis_to_vis, 'g')
    set(gca, 'FontSize', 10);
    xlabel('Time, s');
    ylabel('Displacement, [cm]');
    title(strcat('Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
elseif strcmp(what_to_vis, 'stress-strain') == 1 
    stress_to_vis = stress_cell{1,num_of_input_acc}(num_of_sublayer,:);
    strain_to_vis = strain_cell{1,num_of_input_acc}(num_of_sublayer,:);
    dt = 1/Fs;
    plot(strain_to_vis, stress_to_vis, 'r')
    set(gca, 'FontSize', 10);
    xlabel('Strain, [%]');
    ylabel('Stress, Pa');
    title(strcat('Number of input acc - ', num2str(num_of_input_acc), ', Number of sublayer - ', num2str(num_of_sublayer)));
    set(gca,'FontAngle', 'italic');
    set(gcf,'Color','w');
end