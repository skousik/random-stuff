% Baseball travel with drag as a function of angle and speed

% baseball properties (from wikipedia)
r = 72.66/2000 ; % [m] radius
m = (141.75+148.83)/2 ; % [g] mass
A = pi*r^2 ; % [m^2]

% air properties (from wikipedia)
rho = 1.225 ; % [kg/m^3]
mu = 1.983e-5 ; % [Pa*s] 

% initial conditions
x = 0 ; % [m]
y = 1.5 ; % [m]
v = 40 ; % [m/s] (ball exit speed from bat, in [40, 44] m/s)
         % from: pocketradar.com/blog/wp.../Hitting_Instruction_Slides.pdf
th = degtorad(65) ; % [rad] velocity angle wrt ground

% system dynamics
f = @(t,x) [x(3) ; x(4) ; ...
            -0.5*rho*x(3)^2*dragCoeff(reynolds(rho,sqrt(x(3)+x(4)^2),2*r,mu))*A/m ;
            -0.5*rho*x(4)^2*dragCoeff(reynolds(rho,sqrt(x(3)+x(4)^2),2*r,mu))*A/m - 9.81 ;
            1/(1+(x(4)/x(3))^2)] ;

% solution
N = 5 ;
th = linspace(pi/12,5*pi/12,N) ;

figure
hold on

for i = 1:N
    Y0 = [x;y;v*cos(th(i));v*sin(th(i));th(i)] ;
    TSPAN = [0,10] ;
    [TOUT,YOUT] = ode45(@(t,x) f(t,x), TSPAN, Y0) ;
    YOUT = YOUT((YOUT(:,2) >= 0),:) ;
    plot(YOUT(:,1),YOUT(:,2))
end

plot([90,90,160],[0,3,30])
