%%% Fluorescence Analysis %%%
%%% Jeff McMahan %%%
%%% Syed Lab %%%

clear all; %rid memory of all variables
close all; %close windows

movie1 = movie(18);
movie1.storeMatrix();
frame1_1 = frame(movie1,1,1);
frame1_1.showFrame();