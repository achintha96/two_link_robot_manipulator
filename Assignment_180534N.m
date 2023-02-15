close all
clear all
clc
a = [1 4 0];
b = [10 15 0];

[p,v] = generate_trajectory(a,b);

figure
subplot (3 ,2 ,1)
plot(p(1,:))

subplot (3 ,2 ,3)
plot(p(2,:))

subplot (3 ,2 ,5)
plot(p(3,:))

subplot (3 ,2 ,2)
plot(v(1,:))

subplot (3 ,2 ,4)
plot(v(2,:))

subplot (3 ,2 ,6)
plot(v(3,:))