
format long
x = zeros(1,1000) ;
ep = 0.000001 ;
for N = 2:1000
    x(N) = x(N-1)^2 + 1/4 + ep ;
end

v = find(x > 2,1)