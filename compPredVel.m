%---------------------- Function description ------------------------------
% The function to calculate predicted velocity
%------------------------------- Input ------------------------------------
% N  - total number of nodes
% w  - predicted node velocity for previous time step, in m/s
% s  - sublayer stress for previous time step, in Pa
% V  - velocity in bedrock for previous time step, in m/s
% dz - sublayer thickness, in m
% r  - sublayer density, in kg/m/m/m
% u  - sublayer velocity, in m/s
% dt - time step, in sec
%------------------------------ Output ------------------------------------
% w1 - predicted node velocity for next time step, in m/s
%--------------------------------------------------------------------------

function w1 = compPredVel(N,w,s,V,dz,r,u,dt)

dt2 = 2*dt;
    
    % calculate for N-node first
    w1(N) = (w(N)*(dz(N-1) - u(N)*dt) + 4*u(N)*V*dt - ...
             dt2*s(N-1)/r(N))/(dz(N-1) + u(N)*dt);
    
    % calculate for 2,...,N-1 nodes
for i = 2:N-1
    w1(i) = w(i) + dt2*(s(i)-s(i-1))/(dz(i) + dz(i-1))/r(i);
end

    % calculate for 1-node
    w1(1) = w(1) + dt2*s(1)/dz(1)/r(1);

w1 = w1';       % transpond w1 to column
