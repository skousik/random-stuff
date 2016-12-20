x = linspace(-2,2,1000) ;
y = linspace(-2i,2i,1000) ;
[X,Y] = meshgrid(x,y) ;
C = X + Y ;
[Z,N] = mandelbrotEvaluate(C,100) ;
S = abs(Z) ;
S(S==Inf) = NaN ;
S = S./max(S(:)) ;
contour(N)