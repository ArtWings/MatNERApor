%---------------------- Function description ------------------------------
% The script to calculate response spectra [Nigam and Jennings, BSSA, 1969]
%------------------------------- Input ------------------------------------
% W     -   acceleration time history [cm/s^2]
% dt    -   time step [s]
% T     -   spectral periods vector [s]
% B     -   damping [fraction]
%------------------------------ Output ------------------------------------
% SA - response spectrum (acceleration)
% SV - response spectrum (velocity)
% SD - response spectrum (displacement)
%--------------------------------------------------------------------------

function [SA,SV,SD] = compResponseSpectra(W,dt,T,B)

nt = length(W)-1;      nT = length(T);
nb = length(B);        Q  = 2*pi./T;
SD = zeros(nT,nb);     SV = zeros(nT,nb);     SA = zeros(nT,nb);
dv(1:2,1) = [0; 0];    z  = zeros(nt,1);

for i = 1:nb
    b  = B(i);   bb = b*b;   s = sqrt(1-bb);
    sb = 1/s;    bs = b/s;
    
    for j = 1:nT
        q = Q(j);   qq = q*q;   q1 = 1/q;   q2 = 1/qq;
        p = q1/dt;  qp = q*s*dt;
        
        e  = exp(-b*q*dt);  ms = sin(qp);     mc = cos(qp);
        r1 = bs*ms;         r2 = sb*ms;
        a11= e*(r1+mc);     a12= q1*e*r2;
        a21=-q*e*r2;        a22= e*(mc-r1);
        A = [a11 a12; a21 a22];
        
        u1 = p*(2*bb-1);     u2 = p*2*b;
        v1 = b+u1;           v2 = 1+u2;
        w1 = mc-r1;          w2 = s*ms+b*mc;
        b11= q2*( e*(v1*r2 + v2*mc) - u2);
        b12= q2*(-e*(u1*r2 + u2*mc) + u2 - 1);
        b21= q1*( e*(v1*w1 - v2*w2) + p);
        b22= q1*(-e*(u1*w1 - u2*w2) - p);
        B = [b11 b12; b21 b22];
        
        bq=2*b*q;
        
            for k = 2:nt
                x = dv(:,k-1);
                y = [W(k-1); W(k)];
                x1 = A*x;    y1 = B*y;
                w = x1+y1;
                dv(:,k) = w;
                z(k) = -(qq*w(1) + bq*w(2));
            end
        
        SD(j,i) = max(abs(dv(1,:)));
        SV(j,i) = max(abs(dv(2,:)));
        SA(j,i) = max(abs(z));
    
    end
    
end
