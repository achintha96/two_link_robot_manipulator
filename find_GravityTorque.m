function [grv1,grv2] = find_GravityTorque(theta1,theta2,omega1,omega2,L_1,L_2,M_1,M_2)
g=9.8;
grv1 = (0.5*M_1*g*L_1*cos(theta1))+M_2*g*(L_1*cos(theta1)+0.5*L_2*cos(theta1+theta2));
grv2 = 0.5*M_2*g*L_2*cos(theta1+theta2);

end

