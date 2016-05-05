function [t, y] = stone_air_flight(r,m,x,y,v,th,x_term)
   % Calculate trajectory in time and space of a flying sphere, given
   % its initial location, velocity, and heading, and accounting for
   % air resistance
   
   % air properties (from wikipedia)
   rho = 1.225 ; % [kg/m^3]
   mu = 1.983e-5 ; % [Pa*s] 
   A = pi*r^2 ; % [m^2] frontal area
   
   % system dynamics
   f = @(t,x) [x(3) ; x(4) ; ...
            -0.5*rho*x(3)^2*dragCoeff(reynolds(rho,sqrt(x(3)+x(4)^2),2*r,mu))*A/m ;
            -0.5*rho*x(4)^2*dragCoeff(reynolds(rho,sqrt(x(3)+x(4)^2),2*r,mu))*A/m - 9.81 ;
            1/(1+(x(4)/x(3))^2)] ;
        
   
   % simulation setup
   y0 = [x;y;v*cos(th);v*sin(th);th] ;
   tspan = [0,5] ;
   options = odeset('Events',@events);
    
    
   % simulate
   [t,y] = ode45(@(t,x) f(t,x), tspan, y0, options) ;

   % event handler helper
   function [value, isterminal, direction] = events(~,z)
       isterminal = 1 ;
       value = z(1) - x_term ;
       direction = 1 ;
   end
end