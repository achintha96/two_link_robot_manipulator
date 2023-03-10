% Author - Achintha Rathnayake
% Index - 180534N
% Purpose - EN4563 Assignment
%%
close all
clear all
clc

L_1 = 10;
L_2 = 10;

linear_density = 1;
M_1 = linear_density * L_1;
M_2 = linear_density * L_2;

start_pt = [20 0 0]; %end effector location at the beginning
path = [ [17 1 0]; [10 15 0]; [3 1 0]; [5 5 0]; [15 5 0] ]; %Gcodes (end points of lines)
no_pts = length(path); 

%array to store centripetal torque  values
centripetal_torque_1 = [0]; 
centripetal_torque_2 = [0];

%array to store coriolis torque  values
coriolis_torque_1 = [0];
coriolis_torque_2 = [0];

%array to store gravity torque values
gravity_torque_1 = [0];
gravity_torque_2 = [0];

%array to store inertial torque values
inertial_torque_1 = [0];
inertial_torque_2 = [0];

%variable to store previous angular velocity
prev_omega_1 = 0;
prev_omega_2 = 0;

hold on
grid on
for i=1:no_pts %looping over Gcodes
    end_pt = path(i,:);
    [p,v] = generate_trajectory(start_pt, end_pt); %generating trajectory between two intermediate points
    
    for j=1:length(p) %looping over trajectory
        %current end effector pos
        current_pt = p(:,j);
        x = current_pt(1,1);
        y = current_pt(2,1);
        
        %current end effector velocity
        current_v = v(:,j);
        v_x = current_v(1,1);
        v_y = current_v(2,1);
        
        %current end effector theta
        [theta_1, theta_2] = find_IK(x, y, L_1, L_2);
        
        %current position of links / Forward kinematics
        [X1, Y1, X2, Y2] = find_FK(theta_1, theta_2, L_1, L_2);
        
        %current angular velocity
        [omega_1, omega_2] = find_AngularVelocity(theta_1, theta_2, v_x, v_y, L_1, L_2);
        
        %curretn angular acceleration
        ang_acc_1 = omega_1 - prev_omega_1;
        ang_acc_2 = omega_2 - prev_omega_2;
        
        %calculating and storing centrepetal torque values
        [centripetal_1, centripetal_2] = find_CentripetalTorque(theta_1,theta_2,omega_1,omega_2,L_1,L_2,M_1,M_2);
        centripetal_torque_1 = [centripetal_torque_1 centripetal_1];
        centripetal_torque_2 = [centripetal_torque_2 centripetal_2];
        
        %calculating and storing coriolis torque values
        [coriolis_1, coriolis_2] = find_CoriolisTorque(theta_1,theta_2,omega_1,omega_2,L_1,L_2,M_1,M_2);
        coriolis_torque_1 = [coriolis_torque_1 coriolis_1];
        coriolis_torque_2 = [coriolis_torque_2 coriolis_2];
        
        %calculating and storing gravity torque values
        [gravity_1, gravity_2] = find_GravityTorque(theta_1,theta_2,omega_1,omega_2,L_1,L_2,M_1,M_2);
        gravity_torque_1 = [gravity_torque_1 gravity_1];
        gravity_torque_2 = [gravity_torque_2 gravity_2];
        
        %calculating and storing inertial torque values
        [inertia_1, inertia_2] = find_InertialTorque(theta_1,theta_2,ang_acc_1,ang_acc_2,L_1,L_2,M_1,M_2);
        inertial_torque_1 = [inertial_torque_1 inertia_1];
        inertial_torque_2 = [inertial_torque_2 inertia_2];
        
        %plotting the animation of links
        axis_lim = L_1+L_2+1; %limiting to dexterous
        axis([-axis_lim axis_lim -axis_lim axis_lim])
        link1 = line([0 X1], [0 Y1], 'linewidth', 2, 'Color', 'green');
        link2 = line([X1 X2], [Y1 Y2], 'linewidth', 2, 'Color', 'blue');
        if i>1
            plot(X2,Y2,'d','MarkerFaceColor','red','MarkerEdgeColor','red')
            
        end
        pause(0.00001)
        delete(link1)
        delete(link2)
        prev_omega_1 = omega_1;
        prev_omega_2 = omega_2;
    end
    %at the end
    start_pt = path(i,:);
end

%% plotting centrpetal torque
figure
subplot (2 ,1 ,1)
plot(centripetal_torque_1);
title ("Centrepetal Torque - Link 1")
grid on

subplot (2 ,1 ,2)
plot(centripetal_torque_2);
title ("Centrepetal Torque - Link 2")
grid on

%% plotting coriolis torque
figure
subplot (2 ,1 ,1)
plot(coriolis_torque_1);
title ("Coriolis Torque - Link 1")
grid on

subplot (2 ,1 ,2)
plot(coriolis_torque_2);
title ("Coriolis Torque - Link 2")
grid on

%% plotting gravity torque
figure
subplot (2 ,1 ,1)
plot(gravity_torque_1);
title ("Gravity Torque - Link 1")
grid on

subplot (2 ,1 ,2)
plot(gravity_torque_2);
title ("Gravity Torque - Link 2")
grid on

%% plotting inertial torque
figure
subplot (2 ,1 ,1)
plot(inertial_torque_1);
title ("Inertial Torque - Link 1")
grid on

subplot (2 ,1 ,2)
plot(inertial_torque_2);
title ("Inertial Torque - Link 2")
grid on

%% plotting joint torque
joint_torque_1 = centripetal_torque_1+coriolis_torque_1+gravity_torque_1+inertial_torque_1;
joint_torque_2 = centripetal_torque_2+coriolis_torque_2+gravity_torque_2+inertial_torque_2;

figure
subplot (2 ,1 ,1)
plot(joint_torque_1);
title ("Joint Torque - Link 1")
grid on

subplot (2 ,1 ,2)
plot(joint_torque_2);
title ("Joint Torque - Link 2")
grid on

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

