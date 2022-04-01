%---------------------- Function description ------------------------------
% The function to calculate ACC, VEL and DIS in bedrock from input acc [a],
% remove linear trend in [a], compute V (bedrock velocity) and
% D (bedrock displacement), and convert to required units
%------------------------------- Input ------------------------------------
% dt - time step, in sec
% a  - input acceleration array [a], in 'units'
% units - units for input acc [a]: 'g' or 'cm/s/s'
%------------------------------ Output ------------------------------------
% A  - acceleration in bedrock (detrended), in m/s/s
% V  - velocity in bedrock, in m/s
% D  - displacement in bedrock, in m
% t  - time array, in sec
%--------------------------------------------------------------------------

function [A, V, D, t] = compInputAVD(a, dt, units)

k = 1;
while a(k) == 0;    k = k + 1;    end
k = k - 1;

if k > 0
    a = a(k:end);                % remove initial zeros from [a]
end

t = (0:dt:(numel(a)-1)*dt)';     % time array, in sec

if strcmp(units,'g')          % if [a] is given in units of g,
    a = 9.80655*a;            % then convert [a] to m/s/s
elseif strcmp(units,'cm/s')   % if [a] is given in units of cm/s/s
    a = a/100;                % then convert [a] to m/s/s
end                              

A = detrend(a);                  % remove linear trend in [a]
                                 % A - in m/s/s

V = dt*cumtrapz(A);              % compute VEL (velocity)
                                 % V - in m/s

D = dt*cumtrapz(V);              % compute DIS (displacement)
                                 % D - in m
