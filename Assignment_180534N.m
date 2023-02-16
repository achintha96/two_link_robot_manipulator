close all
clear all
clc

L1 = 10;
L2 = 10;

start_pt = [20 0 0];
path = [ [17 1 0]; [10 15 0]; [3 1 0]; [5 5 0]; [15 5 0] ];
no_pts = length(path);
x_array = [start_pt(1,1)];
y_array = [start_pt(1,2)];
hold on
for i=1:no_pts
    end_pt = path(i,:);
    [p,v] = generate_trajectory(start_pt, end_pt);
    %x_array = [x_array p(1,:)];
    %y_array = [y_array p(2,:)];
    
    for j=1:length(p)
        current_pt = p(:,j);
        x = current_pt(1,1);
        y = current_pt(2,1);
        
        joint_angles = find_IK(x,y,L1,L2);
        axis([-0.1 20 -0.1 20])
        plot(x,y,'d','MarkerFaceColor','red','MarkerEdgeColor','red')
        pause(0.001)
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

