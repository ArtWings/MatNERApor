%---------------------- Script description --------------------------------
% The script to calculate constrained modulus reduction curves and other moduli for chosen case
%------------------------------- Input ------------------------------------
% Choose:
% Case_1: above water table
% Case_2: below water table or offshore

your_case = 'Case_2';   % indicate your case

% set input parameters of porous soil for your case
if strcmp(your_case, 'Case_1') == 1     % above water table
    G_Gmax_curve = G_GmaxRock;         % matrix with G/Gmax curve (column 1 - strain [percentage], column 2 - G/Gmax [fraction])
    Ro_bulk = 1373.76;     % bulk density of porous soil;
    Fi = 0.52;          % porosity
    Vp = 200;          % compression wave velocity
    Vs = 100;            % shear wave velocity
elseif strcmp(your_case, 'Case_2') == 1     % below water table or offshore    
    G_Gmax_curve = G_GmaxRock;         % matrix with G/Gmax curve (column 1 - strain [percentage], column 2 - G/Gmax [fraction])
    Ro_bulk = 2178.92;     % bulk density of porous soil;
    Fi = 0.33;          % porosity
    Vp = 1600;          % compression wave velocity
    Vs = 580;            % shear wave velocity
    Kf = 2150000000;    % bulk modulus of fluid
end

%------------------------------ Output ------------------------------------
% Gmax      - maximum shear modulus (Lame's second parameter)
% Lambda    - Lame's first parameter
% E         - Young's modulus 
% nu        - Poisson ratio
% M_Mmax_curve - normalized constrained modulus curve (column 1 - strain [percentage], column 2 - M_Mmax  [fraction])
%--------------------------------------------------------------------------

Gmax = Ro_bulk*Vs^2;                            
Lambda = Ro_bulk*(Vp^2 - 2*Vs^2);              
E = Gmax*(3*Lambda + 2*Gmax)/(Lambda + Gmax);   
nu = Lambda/(2*(Lambda + Gmax));                

y = G_Gmax_curve(:,1);
G = Gmax*G_Gmax_curve(:,2);
if strcmp(your_case, 'Case_1') == 1
    M = 2*G*(1-nu)/(1-2*nu);
elseif strcmp(your_case, 'Case_2') == 1
    M = 2*G*(1-nu)/(1-2*nu) + Kf/Fi;
end
Mmax = max(M);
M_Mmax = M/Mmax;
M_Mmax_curve = [y M_Mmax];