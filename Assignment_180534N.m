close all
clear all
clc

L_1 = 10;
L_2 = 10;

start_pt = [20 0 0];
path = [ [17 1 0]; [10 15 0]; [3 1 0]; [5 5 0]; [15 5 0] ];
no_pts = length(path);
x_array = [start_pt(1,1)];
y_array = [start_pt(1,2)];
hold on
grid on
for i=1:no_pts
    end_pt = path(i,:)
    [p,v] = generate_trajectory(start_pt, end_pt);
    %x_array = [x_array p(1,:)];
    %y_array = [y_array p(2,:)];
    
    for j=1:length(p)
        current_pt = p(:,j);
        x = current_pt(1,1);
        y = current_pt(2,1);
        
        [theta_1,theta_2] = find_IK(x,y,L_1,L_2);
        %theta_1 = joint_angles(1,1)
        %theta_2 = joint_angles(1,2)
        
        [X1,Y1,X2,Y2] = find_FK(theta_1,theta_2,L_1,L_2);
        
        axis_lim = L_1+L_2+1;
        axis([-axis_lim axis_lim -axis_lim axis_lim])
        link1 = line([0 X1], [0 Y1]);
        link2 = line([X1 X2], [Y1 Y2]);
        if i>1
            plot(X2,Y2,'d','MarkerFaceColor','red','MarkerEdgeColor','red')
            
        end
        pause(0.0001)
        delete(link1)
        delete(link2)
    end
    %at the end
    start_pt = path(i,:);
end
%plot(x_array,y_array)
% a = [1 14 0];
% b = [10 5 0];
% 
% [p,v] = generate_trajectory(a,b);

% figure
% subplot (3 ,2 ,1)
% plot(p(1,:))
% 
% subplot (3 ,2 ,3)
% plot(p(2,:))
% 
% subplot (3 ,2 ,5)
% plot(p(3,:))
% 
% subplot (3 ,2 ,2)
% plot(v(1,:))
% 
% subplot (3 ,2 ,4)
% plot(v(2,:))
% 
% subplot (3 ,2 ,6)
% plot(v(3,:))

