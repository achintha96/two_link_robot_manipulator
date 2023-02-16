function [theta1,theta2] = find_IK(xPos,yPos,L1,L2)

theta2 = acos((xPos^2 + yPos^2 - L1^2 - L2^2)/(2*L1*L2));
theta1 = atan2(yPos,xPos) - atan2((L2*sin(theta2)),(L1 + L2*cos(theta2)));

%JointAngles = [theta1 theta2]; 

end

