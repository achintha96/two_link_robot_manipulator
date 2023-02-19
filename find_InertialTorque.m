function [inertia1,inertia2] = find_InertialTorque(theta1,theta2,acc1,acc2,L_1,L_2,M_1,M_2)
% 43rd equation of note, page 12
M = [[ (M_1*L_1*L_1/3) + M_2*((L_1*L_1)+(L_2*L_2/3)+(L_1*L_2*cos(theta2))) M_2*((L_2*L_2/3)+(L_1*L_2*cos(theta2)/2))];
     [  M_2*((L_2*L_2/3)+(L_1*L_2*cos(theta2)/2))                            (M_2*L_2*L_2/3)]];

 I = M*[acc1; acc2];
 
 inertia1 = I(1,1);
 inertia2 = I(2,1);

end

