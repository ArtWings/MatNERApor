%---------------------- Script description --------------------------------
% The script to calculate damping curve for given M/Mmax (M*/Mmax*) curve
%------------------------------- Input ------------------------------------

M_Mmax_curve = M_Mmax_curve2sand;         % matrix with M/Mmax(M*/Mmax*) curve (column 1 - strain [percentage], column 2 - M/Mmax [fraction])

%------------------------------ Output ------------------------------------
% VertDampingCurve - vertical damping curve (column 1 - strain [percentage], column 2 -  damping)
%--------------------------------------------------------------------------

D = (4*(1 + (M_Mmax_curve(:,2)./(1 - M_Mmax_curve(:,2))).*log(M_Mmax_curve(:,2))))./(3.14*(1 - M_Mmax_curve(:,2))) - 2/3.14;

for i = 1:1:length(M_Mmax_curve(:,2))
    if M_Mmax_curve(i,2) == 1
        D(i) = 0;
    end
end

VertDampingCurve = [M_Mmax_curve(:,1), D];