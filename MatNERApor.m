%---------------------- Script description --------------------------------
% The main script to run the calculation of site response
%--------------------------------------------------------------------------

clear all

time_start = tic; 

input_parameters;

list = dir(pathToDirWithProfiles);
for MainLoop = 3:length(list)
    if list(MainLoop).isdir() == 0

        %------------------------------------------------------------------

        inputAccFileOpening;    % Open and read the file with input set of accelerograms

        %------------------------------------------------------------------

        inputSoilCurvesFileOpening;     % Open and read the file with soil moduli curves

        %------------------------------------------------------------------

        inputProfileFileOpening;        % Open and read the file with soil profile

        %------------------------------------------------------------------

        main_comp_all_acc;      % Calculate site response for particular input profile

        %------------------------------------------------------------------
        
        output_saving1;     % Save .txt file for top and bottom layers general output
        
        %------------------------------------------------------------------

        compSpectraMain;       % Calculate averege and single response spectra for all layers and all
                               % input accelerograms

        %------------------------------------------------------------------
        
        output_saving2;     % Save .txt file with output summary and .mat files with general and supplementary output
        
        %------------------------------------------------------------------

        

        clearvars -except dt subnodes_number b pathToDirWithProfiles...
            fullname_summary fullname_input_acc fullname_RreductionCurvesFile...
            dir_output fullname_SpectralPeriods MainLoop list time_start

    end
end

time_elapsed = toc(time_start)
