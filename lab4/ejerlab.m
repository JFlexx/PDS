clear all, close all 

%1)------------------filtro 1
a= [1 -0.95];%y
b= [0.05];%x
%sist_dif(b,a)

%2)------------------filtro 2

a= [1];%y
b= [0.25  -0.5  0.25];%x
%sist_dif(b,a)

%3)----------------filtro muesca
a=[1 -1.84 0.94];%y
b= [0.97 -1.84 0.97];%x
sist_dif(b,a)