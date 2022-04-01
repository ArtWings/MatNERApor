%---------------------- Function description ------------------------------
% The function to calculate sublayer parameters
%------------------------------- Input ------------------------------------
% h   - depth to the top boundary of layer [m,1], in m
% nh  - number of sublayers in each layer [m-1,1] 
% ro  - layer density [m,1], in kg/m/m/m
% uo  - layer shear velocity [m,1], in m/s
% nMo - layer MAT model number [m,1]
%------------------------------ Output ------------------------------------
% N   - total number of nodes [1,1] (number of sublayers + 1)
% z   - node depth [N,1], in m
% dz  - sublayer thickness [N-1,1], in m
% r   - sublayer density [N,1], in kg/m/m/m
% u   - sublayer shear velocity [N,1], in m/s
% nM  - sublayer MAT model number [N,1]
% Gm  - sublayer shear modulus [N,1], in Pa
%--------------------------------------------------------------------------

function [N,z,dz,r,u,nM,Gm] = compLayerPars(h,nh,ro,uo,nMo)

m  = numel(h);                      % total number of layers
N  = sum(nh);                       % total number of nodes
dh = h(2:end) - h(1:end-1);         % layer thickness, i=1,...,m-1

z = zeros(N,1);    nM = zeros(N,1);     % array size preallocation
r = zeros(N,1);    u  = zeros(N,1);     % array size preallocation

k = 0;
for i = 1:m-1
      dl = dh(i)/nh(i);             % sublayer thickness
    for j = 1:nh(i)
        k = k + 1;
        z(k) = h(i) + (j-1)*dl;     % depth to the k-node
        r(k) = ro(i);               % density beneath k-node
        u(k) = uo(i);               % velocity beneath k-node
        nM(k)= nMo(i);              % MAT number beneath k-node
    end
end

z(end) = h(end);                    % depth to bedrock (N-node)
dz = z(2:end) - z(1:end-1);         % sublayer thickness
r(end) = ro(end);                   % bedrock density
u(end) = uo(end);                   % bedrock shear velocity
nM(end)= nMo(end);                  % bedrock MAT model number
Gm = r.*u.^2;                       % sublayer shear modulus
