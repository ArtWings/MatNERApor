%---------------------- Script description --------------------------------
% The script to calculate bulk density of porous saturated soil for chosen case
%------------------------------- Input ------------------------------------
% Choose:
% Case_1: Soil consists of soil grains and porous water
% Case_2: Soil consists of soil grains, porous water and gas
% Case_3: Soil consists of soil grains, porous water, ice and gas (or gas mixture)

your_case = 'Case_1';   % indicate your case

% set input parameters of porous soil for your case
if strcmp(your_case, 'Case_1') == 1
    Fi = 0.52;              % porosity
    Ro_particle = 2710;     % density of soil particles [kg/m3]. Can be 2710 for clay; 2660 for sand (Presnov, 2012) or other
    Ro_liq = 1000;          % density of soil pore fluid [kg/m3]. Can be 1000 for water or other
elseif strcmp(your_case, 'Case_2') == 1
    Fi = 0.52;              % porosity
    Ro_particle = 2710;     % density of soil particles [kg/m3]. Can be 2710 for clay; 2660 for sand (Presnov, 2012) or other
    Ro_gas = 0.657;         % densuty of soil pore gas [kg/m3]. Can be 1.28 for air or 0.66 for methane or other 
    Ro_liq = 1000;          % density of soil pore fluid [kg/m3]. Can be 1000 for water or other
    S_gas = 0.1;            % gas volume fracture in pores
elseif strcmp(your_case, 'Case_3') == 1
    Fi = 0.52;              % porosity
    Ro_particle = 2710;     % density of soil particles [kg/m3]. Can be 2710 for clay; 2660 for sand (Presnov, 2012) or other
    Ro_ice = 917;           % density of soil pore ice [kg/m3]. Can be 917 or other
    Ro_gas = 0.657;         % densuty of soil pore gas [kg/m3]. Can be 1.28 for air or 0.66 for methane or other 
    Ro_liq = 1000;          % density of soil pore fluid [kg/m3]. Can be 1000 for water or other
    S_ice = 0.2;            % ice volume fracture in pores
    S_gas = 0.1;            % gas volume fracture in pores
end

%------------------------------ Output ------------------------------------
% Ro_bulk   - bulk density [kg/m3]
%--------------------------------------------------------------------------

if strcmp(your_case, 'Case_1') == 1
    Ro_bulk = (1 - Fi)*Ro_particle + Fi*Ro_liq;
elseif strcmp(your_case, 'Case_2') == 1
    Ro_bulk = (1 - Fi)*Ro_particle + Fi*S_gas*Ro_gas + Fi*(1 - S_gas)*Ro_liq;
elseif strcmp(your_case, 'Case_3') == 1
    Ro_bulk = (1 - Fi)*Ro_particle + Fi*S_ice*Ro_ice * Fi*S_gas*Ro_gas + Fi*(1 - S_ice - S_gas)*Ro_liq;
end

%--------------------------------------------------------------------------
