function [ctpl1,ctpl2] = find_CentripetalTorque(theta1,theta2,omega1,omega2,L_1,L_2,M_1,M_2)

c221 = -0.5*M_2*L_1*L_2*sin(theta2);

C = [[0 c221];[0 0]]*[omega1; omega2];

ctpl1 = C(1,1);
ctpl2 = C(2,1);

end

