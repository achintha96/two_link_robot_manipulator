function [ctpl1,ctpl2] = find_CentripetalTorque(theta1,theta2,omega1,omega2,L_1,L_2,M_1,M_2)
%45th equation of note, page 13
c221 = -0.5*M_2*L_1*L_2*sin(theta2);

C = [[0 c221];[0 0]]*[omega1^2; omega2^2];

ctpl1 = C(1,1);
ctpl2 = C(2,1);

end

