function [theta1,theta2] = find_IK(XE,YE,L_1,L_2)
%calculating angles for given cartesian coordinate

theta2 = acos((XE^2 + YE^2 - L_1^2 - L_2^2)/(2*L_1*L_2));
theta1 = atan2(YE,XE) - atan2((L_2*sin(theta2)),(L_1 + L_2*cos(theta2)));


%JointAngles = [theta1 theta2]; 
%% matlab method
%theta1 = 2*atan2((2*L_1*YE + (- L_1^4 + 2*L_1^2*L_2^2 + 2*L_1^2*XE^2 + 2*L_1^2*YE^2 - L_2^4 + 2*L_2^2*XE^2 + 2*L_2^2*YE^2 - XE^4 - 2*XE^2*YE^2 - YE^4)^(1/2)),(L_1^2 + 2*L_1*XE - L_2^2 + XE^2 + YE^2));
%theta1 = 2*atan((2*L_1*YE - (- L_1^4 + 2*L_1^2*L_2^2 + 2*L_1^2*XE^2 + 2*L_1^2*YE^2 - L_2^4 + 2*L_2^2*XE^2 + 2*L_2^2*YE^2 - XE^4 - 2*XE^2*YE^2 - YE^4)^(1/2))/(L_1^2 + 2*L_1*XE - L_2^2 + XE^2 + YE^2));

%theta2 = -2*atan2(((- L_1^2 + 2*L_1*L_2 - L_2^2 + XE^2 + YE^2)*(L_1^2 + 2*L_1*L_2 + L_2^2 - XE^2 - YE^2))^(1/2),(- L_1^2 + 2*L_1*L_2 - L_2^2 + XE^2 + YE^2));
%theta2 =  2*atan(((- L_1^2 + 2*L_1*L_2 - L_2^2 + XE^2 + YE^2)*(L_1^2 + 2*L_1*L_2 + L_2^2 - XE^2 - YE^2))^(1/2)/(- L_1^2 + 2*L_1*L_2 - L_2^2 + XE^2 + YE^2));

end

