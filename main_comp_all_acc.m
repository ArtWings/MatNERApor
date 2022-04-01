%---------------------- Script description --------------------------------
% The script to calculate site response for particular input profile 
%--------------------------------------------------------------------------
acc = acc_current;
units = 'g';

for i = 1:1:number_of_files
    acc = cell_of_matrix{i};
     [a1,v1,d1,e1,s1,Ab1,Vb1,Db1,t1,Vc1,dts1,b1,z1,dz1] = compAVDES(acc,dt,units,h,nh,ro,uo,nMo,cM,subnodes_number);
     
     [dim1, dim2] = size(a1);
     
     a1 = a1/9.8;
     v1 = v1*100;
     d1 = d1*100;
     
     cell_of_t{i} = t1;
     cell_of_a{i} = a1;
     cell_of_v{i} = v1;
     cell_of_d{i} = d1;
     
     cell_of_s{i} = s1;
     cell_of_e{i} = e1;
     
     for j = 1:1:dim1
         a1_max(i,j) = max(abs(a1(j,:)));
         v1_max(i,j) = max(abs(v1(j,:)));
         d1_max(i,j) = max(abs(d1(j,:)));
     end
end

for j = 1:1:dim1
    a1_max_sum(j) = 0;
    v1_max_sum(j) = 0;
    d1_max_sum(j) = 0;
end

for j = 1:1:dim1
    for i = 1:1:number_of_files
        a1_max_sum(j) = a1_max_sum(j) +a1_max(i,j);
        v1_max_sum(j) = v1_max_sum(j) +v1_max(i,j);
        d1_max_sum(j) = d1_max_sum(j) +d1_max(i,j);
    end
    a1_max_av(j) = a1_max_sum(j)/number_of_files;
    v1_max_av(j) = v1_max_sum(j)/number_of_files;
    d1_max_av(j) = d1_max_sum(j)/number_of_files;  
end