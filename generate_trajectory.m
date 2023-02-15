function [position_vector,velocity_vector] = generate_trajectory(initial_pos,final_pos)
% delta_pos = final_pos - initial_pos;
% displacement = sqrt(sum(delta_pos.*delta_pos))
% max_velocity = displacement/time;

%% Trajectory generation
clc
error=0;

x_1 = initial_pos(1,1); %x coordinate of begining in millimeters
y_1 = initial_pos(1,2); %y coordinate of begining in millimeters
z_1 = initial_pos(1,3); %z coordinate of begining in millimeters

x_2 = final_pos(1,1); %x coordinate of destination in millimeters
y_2 = final_pos(1,2); %y coordinate of destination in millimeters
z_2 = final_pos(1,3); %z coordinate of destination in millimeters

delta_x=(x_2-x_1); %difference between x coordinates
delta_y=(y_2-y_1); %difference between y coordinates
delta_z=(z_2-z_1); %difference between z coordinates

displacement = round(((delta_x^2)+(delta_y^2)+(delta_z^2))^0.5,2); % displacement between two points accurate to 2 decimal points in millimeters

acc_max = 10^(-4); % 100 mm/S^2 =10^-4 mm/mS^2
dcc_max = -1*acc_max; % always deffine a negative value
min_dist_top_vel = 2.50; %minimum distance required to gain maximum velocity in millimeters
top_vel= (2*acc_max*min_dist_top_vel)^0.5; % in millimeters per millisecond
%top_vel = 20; %mm/sec

current_vel=0; %temporary variable to store velocity
current_feedrate = 0.005; %default 0.01
terminal_vel = 0.00;
if (current_feedrate>top_vel)
    error=1
end

if (error==0)
    min_acc_dist = round(((current_feedrate^2)-(terminal_vel^2))/(2*acc_max),2);
    min_dcc_dist = round(((terminal_vel^2)-(current_feedrate^2))/(2*dcc_max),2);
    current_vel = terminal_vel;
    if (min_acc_dist>=0 && min_dcc_dist>=0)
        acc_dist = min_acc_dist+min_dcc_dist;
        if( acc_dist < displacement )
            uni_vel_dist = displacement-acc_dist;
            uni_vel_time = round(uni_vel_dist/current_feedrate,5);
            uni_vel_time = floor(uni_vel_time);
            uni_vel_dist = round(current_feedrate*uni_vel_time,2);
            dcc_time = round((-2*min_dcc_dist/dcc_max)^0.5,1);
            dcc_time = ceil(dcc_time);
            if (dcc_time==0)
                dcc=0;
            else
                dcc = -1*(current_feedrate-terminal_vel)/dcc_time;
                %dcc = (-2*min_dcc_dist)/(dcc_time^2);
            end
            dcc_dist = round(-0.5*dcc*(dcc_time^2),2);
            acc_dist = displacement-uni_vel_dist-dcc_dist;
            acc_time = round((2*acc_dist/acc_max)^0.5,1);
            acc_time = ceil(acc_time);
            if (acc_time==0)
                acc=0;
                %current_vel=current_feedrate;
            else
                acc = (current_feedrate-terminal_vel)/acc_time;
                %acc = (2*acc_dist)/(acc_time^2);
            end
            total_time = acc_time + uni_vel_time + dcc_time;
            temp_velocity_profile = zeros(1,total_time+1);
            time_vector = 0:total_time; %time vector
            for t=1:acc_time+1
                temp_velocity_profile(t)=current_vel;
                current_vel=current_vel+acc;
            end
            current_vel=current_vel-acc;
            temp_velocity_profile(acc_time+2:total_time+1-dcc_time)=current_vel; %unifrom velocity
            %current_vel
            %t
            for t=total_time+1-dcc_time:total_time+1 %decelation generating loop
                temp_velocity_profile(t)=current_vel;
                current_vel=current_vel+dcc;
            end
            current_vel=current_vel-dcc;
        else
            %when acceleration distance is not available
            current_feedrate = ((((acc_max*(terminal_vel^2))-(dcc_max*(terminal_vel^2))-(2*acc_max*dcc_max*displacement))/(acc_max-dcc_max))^0.5)*100;
            current_feedrate = floor(current_feedrate)/100;
            min_dcc_dist = ((terminal_vel^2)-(current_feedrate^2))/(2*dcc_max);
            min_dcc_dist = round(min_dcc_dist,2);
            dcc_time = round((-2*min_dcc_dist/dcc_max)^0.5,1);
            dcc_time = ceil(dcc_time);
            if (dcc_time==0)
                dcc=0;
            else
                dcc = -1*(current_feedrate-terminal_vel)/dcc_time;
            end
            dcc_dist = round(-0.5*dcc*(dcc_time^2),2);
            acc_dist = displacement-dcc_dist;
            acc_time = round((2*acc_dist/acc_max)^0.5,1);
            acc_time = ceil(acc_time);
            if (acc_time==0)
                acc=0;
                %current_vel=current_feedrate;
            else
                acc = (current_feedrate-terminal_vel)/acc_time;
            end
            total_time = acc_time + dcc_time;
            temp_velocity_profile = zeros(1,total_time+1);
            time_vector = 0:total_time; %time vector
            for t=1:acc_time+1;
                temp_velocity_profile(t)=current_vel;
                current_vel=current_vel+acc;
            end
            current_vel=current_vel-acc;
            %current_vel
            %t
            for t=total_time+1-dcc_time:total_time+1 %decelation generating loop
                temp_velocity_profile(t)=current_vel;
                current_vel=current_vel+dcc;
            end
            current_vel=current_vel-dcc;
        end
    else
        error=2;
    end
else
    error %#ok<NOPTS>
end

%% Generating vectors

position_vector=zeros(3,total_time+1);
current=0;
for t=1:total_time+1
   current=current+temp_velocity_profile(t);
   distance=current/displacement;
   position_vector(1,t)=x_1+distance*delta_x;
   position_vector(2,t)=y_1+distance*delta_y;
   position_vector(3,t)=z_1+distance*delta_z;
end


%% generating velocity profile
p = position_vector;
c = [x_1; y_1; z_1];
d = [x_2; y_2; z_2];
b = [c p];
p = [p d];
velocity_vector = p-b;
velocity_vector = velocity_vector(:,1:total_time+1);
end

