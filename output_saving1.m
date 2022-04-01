%---------------------- Script description --------------------------------
% The script to save .txt file for top and bottom layers general output
%--------------------------------------------------------------------------
for j = 1:1:number_of_files

        mkdir(dir_output, ProfileFname(1:length(ProfileFname)-4));
        pathToOutput = strcat(dir_output, ProfileFname(1:length(ProfileFname)-4), '\');
        
        dd = [];
        vv = [];
        aa = [];
        tt = [];

        num_of_sublayer = 1;  % FOR TOP LAYER
        number_of_acc = j; 

        dd = cell_of_d{number_of_acc};
        vv = cell_of_v{number_of_acc};
        aa = cell_of_a{number_of_acc};
        tt = cell_of_t{number_of_acc};

        [dim11, dim22] = size(aa);

        for i = 1:1:dim22
             table_time(i)  = tt(i);
             table_d(i) = dd(num_of_sublayer,i);
             table_v(i) = vv(num_of_sublayer,i);
             table_a(i) = aa(num_of_sublayer,i);
        end

        output_layer_Surf = struct('Time', table_time, 'A', table_a, 'V', table_v, 'D', table_d,...
            'Amax_current', a1_max(number_of_acc, num_of_sublayer), 'Vmax_current', v1_max(number_of_acc, num_of_sublayer),...
            'Dmax_current', d1_max(number_of_acc, num_of_sublayer), 'Amax_average', a1_max_av(num_of_sublayer),...
            'Vmax_average', v1_max_av(num_of_sublayer), 'Dmax_average', d1_max_av(num_of_sublayer));

        fullname = strcat(pathToOutput,...
            'acc ', num2str(number_of_acc), ' sublayer ', num2str(num_of_sublayer), '.txt');

        F = fopen(fullname, 'w');
        fprintf(F, '%-17s %-17s %-17s %-17s %-17s %-17s\n', 'Amax(current)', 'Vmax(current)', 'Dmax(current)', 'Amax(average)',...
            'Vmax(average)', 'Dmax(average)');

        fprintf(F, '%-17d %-17d %-17d %-17d %-17d %-17d\n\n\n', output_layer_Surf.Amax_current, output_layer_Surf.Vmax_current,...
                output_layer_Surf.Dmax_current, output_layer_Surf.Amax_average, output_layer_Surf.Vmax_average,...
                output_layer_Surf.Dmax_average);

        fprintf(F, '%-17s %-17s %-17s %-17s\n', 'Time(s)', 'A(g)', 'V(cm/s)',...
            'D(cm)');

        for i = 1:1:length(table_a)
            fprintf(F, '%-17d %-17d %-17d %-17d\n',...
                output_layer_Surf.Time(i), output_layer_Surf.A(i), output_layer_Surf.V(i),...
                output_layer_Surf.D(i)); 
        end

        fclose(F);
             
        %//////////////////////////////////////////////////////////////////
        
        dd = [];
        vv = [];
        aa = [];
        tt = [];

        num_of_sublayer = dim1; % FOR BOTTOM LAYER
        number_of_acc = j; 

        dd = cell_of_d{number_of_acc};
        vv = cell_of_v{number_of_acc};
        aa = cell_of_a{number_of_acc};
        tt = cell_of_t{number_of_acc};

        [dim11, dim22] = size(aa);

        for i = 1:1:dim22
             table_time(i)  = tt(i);
             table_d(i) = dd(num_of_sublayer,i);
             table_v(i) = vv(num_of_sublayer,i);
             table_a(i) = aa(num_of_sublayer,i);
        end

        output_layer_Bot = struct('Time', table_time, 'A', table_a, 'V', table_v, 'D', table_d,...
            'Amax_current', a1_max(number_of_acc, num_of_sublayer), 'Vmax_current', v1_max(number_of_acc, num_of_sublayer),...
            'Dmax_current', d1_max(number_of_acc, num_of_sublayer), 'Amax_average', a1_max_av(num_of_sublayer),...
            'Vmax_average', v1_max_av(num_of_sublayer), 'Dmax_average', d1_max_av(num_of_sublayer));

        fullname = strcat(pathToOutput,...
            'acc ', num2str(number_of_acc), ' sublayer ', num2str(num_of_sublayer), '.txt');

        F = fopen(fullname, 'w');
        fprintf(F, '%-17s %-17s %-17s %-17s %-17s %-17s\n', 'Amax(current)', 'Vmax(current)', 'Dmax(current)', 'Amax(average)',...
            'Vmax(average)', 'Dmax(average)');

        fprintf(F, '%-17d %-17d %-17d %-17d %-17d %-17d\n\n\n', output_layer_Bot.Amax_current, output_layer_Bot.Vmax_current,...
                output_layer_Bot.Dmax_current, output_layer_Bot.Amax_average, output_layer_Bot.Vmax_average,...
                output_layer_Bot.Dmax_average);

        fprintf(F, '%-17s %-17s %-17s %-17s\n', 'Time(s)', 'A(g)', 'V(cm/s)',...
            'D(cm)');

        for i = 1:1:length(table_a)
            fprintf(F, '%-17d %-17d %-17d %-17d\n',...
                output_layer_Bot.Time(i), output_layer_Bot.A(i), output_layer_Bot.V(i),...
                output_layer_Bot.D(i)); 
        end

        fclose(F);

end