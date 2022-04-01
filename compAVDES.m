%---------------------- Function description ------------------------------
% The function to calculate iterations for acceleration (a), velocity (v),
% displacement (d), strain(e), stress (s) in soil, bedrock motion
% (Ab,Vb,Db), bedrock velocity for time increments, sublayer parameters 
%------------------------------- Input ------------------------------------
% acc       - input acceleration vector, in 'units'
% dt        - time step [s]
% units     - units for input acc [a]: 'g' or 'cm/s/s'
% h         - depth to the top boundary of layer [m,1], in m
% nh        - number of sublayers in each layer [m-1,1] 
% ro        - layer density [m,1], in kg/m/m/m
% uo        - layer shear velocity [m,1], in m/s
% nMo       - layer MAT model number [m,1]
% cM        - cell array of various MAT models
% nT        - given number of time increments between time steps [1,1]
%------------------------------ Output ------------------------------------
% a         - acceleration vectors for all N nodes [m/s^2]
% v         - velocity vectors for all N nodes [m/s]
% d         - displacement vectors for all N nodes [m]
% e         - strain vectors for all N nodes
% s         - stress vectors for all N nodes [Pa]
% Ab        - acceleration vectors for bedrock [m/s^2]
% Vb        - velocity vectors for bedrock [m/s]
% Db        - displacement vectors for bedrock [m]
% t         - time vector [s]
% Vc        - velocity vectors for bedrock with time step dts=dt/nT (obtained by linear interpolation) [m/s]
% dts       - decreased time step dts=dt/nT (obtained by linear interpolation)
% b         - array with residual back-stress for all N-1 nodes
% z         - depth vectors for all N nodes [m]
% dz        - depth increment [m]
%--------------------------------------------------------------------------

function [a,v,d,e,s,Ab,Vb,Db,t,Vc,dts,b,z,dz] = compAVDES(acc,dt,...
    units,h,nh,ro,uo,nMo,cM,nT)
% Calculate iterations for acceleration (a), velocity (v),
% displacement (d), strain(e), stress (s) in soil
    % Calculate bedrock motion (Ab,Vb,Db)
[Ab, Vb, Db, t]   = compInputAVD(acc, dt, units);
L = numel(t);       nT1 = nT + 1;
    % Calculate bedrock velocity for time increments dts=dt/nT
dts = dt/nT;        k = (1:nT)';       Vc = Vb(1);
    for i = 2:L
        dV = (Vb(i)-Vb(i-1))/nT;  Vc = [Vc; Vb(i-1) + k*dV];
    end;    Vc = Vc/2;
    % Calculate sublayer parameters for NERA
[N,z,dz,r,u,nM,Gm] = compLayerPars(h,nh,ro,uo,nMo); N1 = N - 1; 
    % Initialize back-stress array b
for i=1:N1;    b{i}=zeros(1,size(cM{nM(i)},1));    end;    b=b';
    % Preallocate size for output arrays
a = zeros(N, L);     v = zeros(N, L);     d = zeros(N,L);
e = zeros(N1,L);     s = zeros(N1,L);     w = zeros(N,1);
    % Preallocate size for temporal arrays
E = zeros(N1,nT);       S = zeros(N1,nT);
D = zeros(N, nT1);      W = zeros(N, nT1);

    % Start step-by-step iterations for n = 1,2,...,L-1
for n = 1:L-1
    nc = (n - 1)*nT;         n1 = n + 1;
    % Calculate arrays for n = 1
    if n == 1
            ee = e(:,1);            ss = s(:,1);       
        W(:,1) = compPredVel(N, w, ss, Vc(1), dz, r, u, dts);
        D(:,1) = d(:,1) + W(:,1)*dts;
        a(:,1) = W(:,1)/dts;    v(:,1) = W(:,1)/2;
    end
    % Calculate for nT increments between n and n+1 time steps
    [A,V,D,E,S,W,b] = compAVDESWb(N,nT,nM,nc,...
                      Vc,dts,ee,ss,D,E,S,W,dz,r,u,cM,Gm,b);
    % Assign correct values for output and temporal arrays     
a(:,n1) = A;              v(:,n1) = V;
e(:,n1) = E(:,end);       s(:,n1) = S(:,end);
d(:,n1) = D(:,end-1);
D(:,1)  = D(:,end);       W(:,1)  = W(:,end);
     ee = E(:,end);            ss = S(:,end);
end
s = [s; r(N)*u(N)*(Vb - v(N,:))];
e = [e; s(N,:)/Gm(N)];
