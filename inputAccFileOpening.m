%---------------------- Script description --------------------------------
% The script to open and read the file with input set of accelerograms
%--------------------------------------------------------------------------

str_num = [];

acc_cell = struct2cell(load(fullname_input_acc));
acc_matrix = acc_cell{1};   
[s1, s2] = size(acc_matrix);

number_of_files = s2;

for i = 1:1:s2
    str_num = [str_num; i];
    str = num2str(str_num);
end

acc_current = cell2mat(acc_matrix(1,1));
acc_current = acc_current/100/9.8;
acc_current = acc_current';

for i = 1:1:s2
    acc_cur = cell2mat(acc_matrix(1,i));
    acc_cur = acc_cur/100/9.8;
    cell_of_matrix{i} = acc_cur';
end