clear all, close all
load AB_5; % Cargamos coefs A y B 
fvtool(B,A,'fs', 20000);% llamamos a fvtool 
% show_h()