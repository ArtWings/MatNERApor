%---------------------- Function description ------------------------------
% The script to calculate curves of shear and tangential shear moduli and shear resistance
%------------------------------- Input ------------------------------------
% e1 - vector with strain [%]
% G1 - vector with G/Gmax
%------------------------------ Output ------------------------------------
% H - vector with normalized tangential shear modulus
% R - vector with shear resistance
%--------------------------------------------------------------------------

function [H,R] = compSoilCurvesParams(e1,G1)

H(1) = G1(1);
[d1, d2] = size(G1);
H(d1) = 0;

for i = 2:(d1-1)
    H(i) = abs((G1(i+1)*e1(i+1) - G1(i)*e1(i))/(e1(i+1) - e1(i)));
end

for i = 1:d1
    R(i) = G1(i)*e1(i);
end

H = H';
R = R';

