%---------------------- Script description --------------------------------
% The script to calculate parameters of porous saturated soil for given velocity profile of 
% the Kik-net site 
%------------------------------- Input ------------------------------------
% Kik-net site profile format:
% KSRH10 site (clayey soils)
% No Thickness   Depth    Vp       Vs
%        (m)       (m)    (m/s)    (m/s)                
%  1,    1.00,    1.00,  220.00,   90.00                       
%  2,    4.00,    5.00,  590.00,  130.00                       
%  3,   11.00,   16.00, 1500.00,  210.00    
%  4,   20.00,   36.00, 1500.00,  300.00                       
%  5,   44.00,   80.00, 3100.00, 1400.00                        
%  6,  112.00,  192.00, 4100.00, 2000.00                       
%  7,   44.00,  236.00, 3100.00, 1500.00                       
%  8,   -----,   -----, 3800.00, 1700.00                       

%=> 
Vp_kiknet = [220; 590; 1500; 1500; 3100; 4100; 3100; 3800];
Vs_kiknet = [90; 130; 210; 300; 1400; 2000; 1500; 1700];
soil_type = 'cohesive'; % 'cohesive' for clays, mud; 'non-cohesive' for sands, gravel, rock
ro_particle = 2710;   % density of soil particles. Can be 2710 for clay; 2660 for sand (Presnov, 2012) or other

%------------------------------ Output ------------------------------------
% ro_bulk       - bulk density [kg/m3]
% ro_dry        - dry density [kg/m3]
% w_moist       - moisture [fracrion]
% fi            - porosity [fracrion]
%--------------------------------------------------------------------------

ro_bulk = zeros(length(Vp_kiknet),1);       % bulk density
ro_dry = zeros(length(Vp_kiknet),1);        % dry density
w_moist = zeros(length(Vp_kiknet),1);       % moisture
fi = zeros(length(Vp_kiknet),1);            % porosity

for i = 1:1:length(Vp_kiknet)
    if strcmp(soil_type, 'non-cohesive') == 1
        ro_bulk(i) = 1000*0.23*(Vp_kiknet(i)*3.28)^0.25;      % Gardner, 1974
    elseif strcmp(soil_type, 'cohesive') == 1
        ro_bulk(i) = 1000*0.412*Vs_kiknet(i)^0.262;           % Anbazhagan, 2016    
    end
    
    ro_dry(i) = 1000*0.523*Vs_kiknet(i)^0.193;        % Anbazhagan, 2016
    w_moist(i) = ro_bulk(i)/ro_dry(i) - 1;       
    fi(i) = 1-ro_dry(i)/ro_particle;        
end
