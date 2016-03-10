% Data correlation for drag coefficient of a smooth sphere
%
% F. A. Morrison, An Introduction to Fluid Mechanics, (Cambridge
% University Press, New York, 2013). This correlation appears in Figure
% 8.13 on page 625. 

function C_D = dragCoeff(Re)
    C_D = (24/Re) + ((2.6*Re)/(5*(1+(Re/5)^(1.52)))) + ...
          0.411*((Re/263000)^(-7.94))/(1 + (Re/263000)^(-8)) + ...
          (Re^(0.8))/461000 ;
end