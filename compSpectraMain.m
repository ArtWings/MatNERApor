%---------------------- Script description --------------------------------
% The script to calculate average and single response spectra for all layers and all
% input accelerograms
%--------------------------------------------------------------------------

sp_per = struct2cell(load(fullname_SpectralPeriods));
spectra_periods = sp_per{1};

%//////////////////////////////////////////////////////////////////////////

cell_of_Sa_surf_1 = {};
cell_of_Sv_surf_1 = {};
cell_of_Sd_surf_1 = {};
cell_of_Sa_bot_1 = {};
cell_of_Sv_bot_1 = {};
cell_of_Sd_bot_1 = {};
    
if spectra_periods ~= 0
    T = spectra_periods;
end

[dd1, dd2] = size(cell_of_a);

for i = 1:dd2
    a_input = cell_of_a{i}; 
    a_input_surf = a_input(1,:);
    a_input_bot = a_input(end,:);
    [Sa_surf_1,Sv_surf_1,Sd_surf_1] = compResponseSpectra(a_input_surf*9.8*100,dt,T,b);
    cell_of_Sa_surf_1{i} = Sa_surf_1';
    cell_of_Sv_surf_1{i} = Sv_surf_1';
    cell_of_Sd_surf_1{i} = Sd_surf_1';
    [Sa_bot_1,Sv_bot_1,Sd_bot_1] = compResponseSpectra(a_input_bot*9.8*100,dt,T,b);
    cell_of_Sa_bot_1{i} = Sa_bot_1';
    cell_of_Sv_bot_1{i} = Sv_bot_1';
    cell_of_Sd_bot_1{i} = Sd_bot_1';
end

%//////////////////////////////////////////////////////////////////////////
for i = 1:dd2 % асс set
    a_input = cell_of_a{i};
    [dada1,dada2] = size(a_input);
    for j = 1:dada1 % extra nodes
        a_input_Node{j} = a_input(j,:);
        a_input_Node_max{i,j} = max(abs(a_input_Node{j}));
        [Sa_Node{i,j},Sv_Node{i,j},Sd_Node{i,j}] = compResponseSpectra(a_input_Node{j}*9.8*100,dt,T,b);
    end    
end

for j = 1:1:dada1
    mat_for_Sa_av = [];
    mat_for_Sv_av = [];
    mat_for_Sd_av = [];
    mat_for_A_max_av = [];
    for i = 1:1:dd2
        mat_for_Sa_av = [mat_for_Sa_av Sa_Node{i,j}];
        mat_for_Sv_av = [mat_for_Sv_av Sv_Node{i,j}];
        mat_for_Sd_av = [mat_for_Sd_av Sd_Node{i,j}];
        mat_for_A_max_av = [mat_for_A_max_av a_input_Node_max{i,j}];
        
        av_Sa_Node{j} = mean(mat_for_Sa_av,2);
        av_Sv_Node{j} = mean(mat_for_Sv_av,2);
        av_Sd_Node{j} = mean(mat_for_Sd_av,2);
        av_A_max_Node{j} = mean(mat_for_A_max_av,2);
    end
    
    max_av_Sa_Node{j} = max(av_Sa_Node{j});
    max_av_Sv_Node{j} = max(av_Sv_Node{j});
    max_av_Sd_Node{j} = max(av_Sd_Node{j});
    
    for i = 1:1:length(av_Sa_Node{j})
        if av_Sa_Node{j}(i) == max_av_Sa_Node{j}
             T_max_av_Sa_Node{j} = T(i);
        end
    end
end

%//////////////////////////////////////////////////////////////////////////

[ddd1, ddd2] = size(cell_of_Sa_surf_1);
[x1, x2] = size(cell_of_Sa_surf_1{1});

for i = 1:x2
    summSa = 0;
    summSv = 0;
    summSd = 0;
    for j = 1:ddd2
        x = cell_of_Sa_surf_1{j};
        xx = x(i);
        summSa = summSa + xx;
        y = cell_of_Sv_surf_1{j};
        yy = y(i);
        summSv = summSv + yy;
        z = cell_of_Sd_surf_1{j};
        zz = z(i);
        summSd = summSd + zz;
    end
    average_Sa_surf_1(i) = summSa/ddd2;
    average_Sv_surf_1(i) = summSv/ddd2;
    average_Sd_surf_1(i) = summSd/ddd2;
end

for i = 1:x2
    summSa = 0;
    summSv = 0;
    summSd = 0;
    for j = 1:ddd2
        x = cell_of_Sa_bot_1{j};
        xx = x(i);
        summSa = summSa + xx;
        y = cell_of_Sv_bot_1{j};
        yy = y(i);
        summSv = summSv + yy;
        z = cell_of_Sd_bot_1{j};
        zz = z(i);
        summSd = summSd + zz;
    end
    average_Sa_bot_1(i) = summSa/ddd2;
    average_Sv_bot_1(i) = summSv/ddd2;
    average_Sd_bot_1(i) = summSd/ddd2;
end

Sa_surf = average_Sa_surf_1;
Sv_surf = average_Sv_surf_1;
Sd_surf = average_Sd_surf_1;
Sa_bot = average_Sa_bot_1;
Sv_bot = average_Sv_bot_1;
Sd_bot = average_Sd_bot_1;

Sa_surf_max = 0;
T_Sa_surf_max = 0;
for i = 1:1:length(Sa_surf)
    if Sa_surf(i)>Sa_surf_max
        Sa_surf_max = Sa_surf(i);
        T_Sa_surf_max = T(i);
    end
end

for i = 1:x2
    k_Sa(i) = Sa_surf(i)/Sa_bot(i);
    k_Sv(i) = Sv_surf(i)/Sv_bot(i);
    k_Sd(i) = Sd_surf(i)/Sd_bot(i);
end

k_Sa_max = 0;
k_Sv_max = 0;
k_Sd_max = 0;
T_k_Sa_max = 0;
T_k_Sv_max = 0;
T_k_Sd_max = 0;
for i = 1:x2
    if k_Sa(i)>k_Sa_max
        k_Sa_max = k_Sa(i);
        T_k_Sa_max = T(i);
    end
    if k_Sv(i)>k_Sv_max
        k_Sv_max = k_Sv(i);
        T_k_Sv_max = T(i);
    end
    if k_Sd(i)>k_Sd_max
        k_Sd_max = k_Sd(i);
        T_k_Sd_max = T(i);
    end
end