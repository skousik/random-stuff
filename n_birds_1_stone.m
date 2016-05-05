% How many birds can you kill with one stone?
%
% Assumptions:
%   - spherical stone of radius r, constant density
%   - air resistance applies
%   - ballistics/penetration calculation for meat of some density
%   - normal Earth gravity
%   - a bird is 'killed' when the stone penetrates it and either lodges
%     inside or passes through
%   - a bird is composed of homogeneous tissue

clear
clc

% Stone properties
r_s = 0.005 ; % [m] radius
rho_s = 1800 ; % [kg/m^3] density
m = rho_s*pi*(4/3)*r_s^3 ; % [kg] stone mass

% Stone initial conditions
x = 0.0 ; % [m]
y = 5.5 ; % [m] average height of powerline
v = 100  ; % [m/s] starting speed
th = degtorad(1) ; % [rad] velocity angle wrt ground

% Bird properties
d_b = 0.04 ; % [m] length of bird that the stone must pass through
rho_b = 41.3 ; % [kg/m^3] density of chicken with bones

% Bird initial conditions:
n_b = 20    ; % number of birds
x_b = 0.25 ; % [m] x-spacing of birds
y_b = 5.5  ; % [m] y-height of birds (on a powerline)

% First method: using Newton's approximate for penetration depth, and
% assuming that stone velocity decreases linearly through the bird
D = d_b*rho_b/rho_s ; % [m] impact depth
v_scale = d_b / D ; % scaling factor for velocity after each bird impact

% simulate stone until it hits the first bird
[t, z] = stone_air_flight(r_s,m,x,y,v,-th,x_b) ;
plot(z(:,1),z(:,2),'r')
hold on

idx = 1 ;
go_flag = true ;
while idx < n_b && go_flag
    % determine current stone speed
    v = v_scale*sqrt(z(end,3)^2 + z(end,4)^2)
    
    if v < 213 % arbitrarily chosen speed
        go_flag = false ;
    end
    % determine new coordinates after passing through bird
    x = z(end,1) + d_b ;
    y = z(end,2) + d_b*atan(z(end,5)) ;
    
    % plot linear path through bird
    plot([z(end,1),x],[z(end,2),y],'bx')
    
    % simulate stone until it hits next bird
    if idx == n_b
        x_term = 1000 ;
    else
        x_term = x+x_b ;
    end
    
    [t, z] = stone_air_flight(r_s,m,x,y,v,-th,x_term) ;
    plot(z(:,1),z(:,2),'r')
    
    idx = idx + 1 ;
end

disp(idx)

% SOURCES
% Chicken density: http://go.key.net/rs/key/images/Bulk%20Density%20Averages%20100630.pdf