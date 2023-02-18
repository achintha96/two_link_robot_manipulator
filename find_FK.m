function [X1,Y1,X2,Y2] = find_FK(THETA1,THETA2,L1,L2)

X1 = L1*cos(THETA1);
Y1 = L1*sin(THETA1);

X2 = X1+(L2*cos(THETA2+THETA1));
Y2 = Y1+(L2*sin(THETA2+THETA1));

end

