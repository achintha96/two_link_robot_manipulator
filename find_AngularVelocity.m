function [w1,w2] = find_AngularVelocity(t_1,t_2,v_x,v_y,L_1,L_2)
%calculating angular velocities of links 
jacobian = [[-(L_1*sin(t_1))-(L_2*sin(t_1+t_2)), -(L_2*sin(t_1+t_2))];
            [ (L_1*cos(t_1))+(L_2*cos(t_1+t_2)),  (L_2*cos(t_1+t_2))]];
w = pinv(jacobian)*[v_x; v_y];

w1 = w(1,1);
w2 = w(2,1); 

end

