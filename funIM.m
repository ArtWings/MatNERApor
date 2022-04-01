%---------------------- Function description ------------------------------
% The function to calculate stress-strain curves of IM model [Iwan & Mroz, 1967]
%------------------------------- Input ------------------------------------
% s2  - output stress value [1,1], in Pa
% a   - back stress array, [n,1], in Pa
%------------------------------ Output ------------------------------------
% s1  - given stress value [1,1], in Pa 
% de  - given strain increment [1,1], dimensionless
% M   - MAT model [e,G/Gmax,H/Gmax,R/Gmax], [n,4], in Pa
% Gm  - layer shear modulus [1,1], in Pa
% a   - back stress array, [n,1], in Pa
%--------------------------------------------------------------------------

function  [s2, a] = funIM(s1, de, M, Gm, a)

n = size(M,1);      % n   - number of curve points (G/Gmax-e) in given MAT model M 
H = Gm*M(:,3);      R = Gm*M(:,4);

dx = de;       st = s1;             % new variables

if de > 0;   x = 1;    else  x = -1;   end  % loading or unloading

    for i = 1:n
        ds = H(i)*dx;               % trial stress increment
            
            if abs(st + ds - a(i)) <= R(i)  % stress inside slider i
                st = st + ds;
                break
            end
    
        ds = a(i) + x*R(i) - st;    % correct stress increment
        st = st + ds;               % update stress
        dx = dx - ds/H(i);          % left over strain increment
    end

if i > n;       i = n;      end     % avoid n+1

if  abs(st - a(i)) < R(i) || i == n
    i = i - 1;      end        % stress is strictly inside slider i

    for j = 1:i
        a(j) = st - x*R(j);         % update back stress a(j)
    end
    
s2 = st;
