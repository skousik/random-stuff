function [clim, Nlim] = mandelbrotEvaluate(c,N)
    clim = zeros(size(c)) ;
    Nlim = zeros(size(c)) ;
    for idx = 1:N
        clim = clim.^2 + c ;
        Nlim(clim > 2) = N ;
%         clim(clim > 2) = 0 ;
    end
end