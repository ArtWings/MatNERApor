%---------------------- Script description --------------------------------
% The script to calculate damping curve for given G/Gmax curve
%------------------------------- Input ------------------------------------

G_Gmax_curve = G_GmaxSand;         % matrix with G/Gmax curve (column 1 - strain [percentage], column 2 - G/Gmax [fraction])

%------------------------------ Output ------------------------------------
% HorDampingCurve - horizontal damping curve (column 1 - strain [percentage], column 2 -  damping)
%--------------------------------------------------------------------------
  
y = G_Gmax_curve(:,1);
G = G_Gmax_curve(:,2);
e(1) = 0;
A(1) = 0;
for i = 2:1:length(y)
    subsum = 0;
    for j = 2:1:i
        subsum = subsum + (G(j)*y(j) + G(j-1)*y(j-1))*(y(j) - y(j-1)); 
     end

     A(i) = 0.5*subsum;
     e(i) = 2*(2*A(i)/G(i)/((y(i))^2) - 1)/3.14;
      if e(i) < 0
         e(i) = 0;
      end
end
A = A';
e = e';
    
HorDampingCurve = [y, e];

