%---------------------- Script description --------------------------------
% The script to open and read the file with soil profile
%--------------------------------------------------------------------------
ProfilePname = pathToDirWithProfiles;
ProfileFname = list(MainLoop).name;

table_layers = struct2cell(load(strcat(ProfilePname, ProfileFname)));
layers_data = table_layers{1,1};
h = layers_data(:,1);
nh = layers_data(:,2);
ro = layers_data(:,3);
uo = layers_data(:,4);
nMo = layers_data(:,5);