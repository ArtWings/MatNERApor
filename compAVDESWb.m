%---------------------- Function description ------------------------------
% The function to calculate motion for nT increments between n and n+1 time steps
%------------------------------- Input ------------------------------------
% N   - total number of nodes [1,1]
% nT  - given number of time increments between time steps [1,1]
% nM  - sublayer MAT model number [N,1]
% nc  - nc=(n-1)*nT [1,1], current start point for Vc array
% Vc  - bedrock velocity for time step dts (see: compInputAVD), m/s
% dts - dts=dt/nT, time step fot given nT time increments, in sec
% W   - predicted velocity [N,nT+2], in m/s:
%       input:  for time step n   (plus 1 extra prediction for dts)
% D   - displacement [N,nT+2], in m; the same explanation as for W
% E   - strain [N-1,nT+1], dimesionless:
%       input:  for time step n   (no extra points)
% S   - stress [N-1,nT+1], in Pa; the same explanation as for E
% dz  - sublayer thickness [N-1,1], in m
% r   - sublayer density [N,1], in kg/m/m/m
% u   - sublayer shear velocity [N,1], in m/s
% cM  - cell array of various MAT models
% Gm  - sublayer shear modulus [N,1], in Pa
% b   - back stress array, [k(nM),1], in Pa
%------------------------------ Output ------------------------------------
% A   - acceleration for n+1 time step, in m/s/s
% V   - velocity for for n+1 time step, in m/s 
% D   - displacement [N,nT+2], in m; the same explanation as for W
% W   - predicted velocity [N,nT+2], in m/s:
%               output: for time step n+1 (plus 1 extra prediction for dts)
% E   - strain [N-1,nT+1], dimesionless:
%               output: for time step n+1 (no extra points)
% S   - stress [N-1,nT+1], in Pa; the same explanation as for E
% b   - back stress array, [k(nM),1], in Pa
%--------------------------------------------------------------------------

function [A,V,D,E,S,W,b] = compAVDESWb(N,nT,nM,nc,...
                           Vc,dts,ee,ss,D,E,S,W,dz,r,u,cM,Gm,b)

for j = 1:nT
    jm = j - 1;     jp = j + 1;
    E(:,j)  = (D(2:end,j) - D(1:end-1,j))./dz(1:end);
    
        if j > 1
              dE  =  E(:,j) - E(:,jm);    s0 = S(:,jm); 
        else  dE  =  E(:,j) - ee;         s0 = ss;
        end

    for i = 1:N-1
       [S(i,j), b{i}] = funIM(s0(i), dE(i), cM{nM(i)}, Gm(i), b{i});
    end
    
    W(:,jp) = compPredVel(N, W(:,j), S(:,j), Vc(nc+jp),dz,r,u,dts);
    D(:,jp) = D(:,j)  + W(:,jp)*dts;
end

    A  = (W(:,jp) - W(:,j))/dts;
    V  = (W(:,jp) + W(:,j))/2;
