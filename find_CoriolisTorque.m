function [crls1,crls2] = find_CoriolisTorque(theta1,theta2,omega1,omega2,L_1,L_2,M_1,M_2)
%45th equation of note, page 13
crls1 = -M_2*L_1*L_2*sin(theta2)*omega1*omega2;
crls2 = 0;

end

