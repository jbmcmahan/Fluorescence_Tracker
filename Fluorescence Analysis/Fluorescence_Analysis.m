%%% Fluorescence Analysis %%%
%%% Jeff McMahan %%%
%%% Syed Lab %%%

clear all; %rid memory of all variables
close all; %close windows

movie1 = movie(18);
movie1.storeMatrix();

%%% create fluorescent matrices
background = zeros(movie1.channelCount, movie1.timeCount, 'double');
cell = zeros(movie1.channelCount, movie1.timeCount, 'double');
nucleus = zeros(movie1.channelCount, movie1.timeCount, 'double');
cytoplasm = zeros(movie1.channelCount, movie1.timeCount, 'double');

for i = 1:movie1.channelCount;
    time_mid = ceil(movie1.timeCount/2);
    frame_mid = frame(movie1,time_mid,i);
    mask_background = frame_mid.createMask('background');
    mask_cell = frame_mid.createMask('cell');
    mask_nucleus = frame_mid.createMask('nucleus');
    mask_cytoplasm = mask_cell-mask_nucleus;
    area_background = sum(sum(mask_background));
    area_cell = sum(sum(mask_cell));
    area_nucleus = sum(sum(mask_nucleus));
    area_cytoplasm = sum(sum(mask_cytoplasm));
    for j = 1:movie1.timeCount;
        temp1 = frame(movie1,j,i);
        temp = double(temp1.matrix);
        background(i,j)=(sum(sum(temp.*mask_background)))/area_background;
        cell(i,j)=((sum(sum(temp.*mask_cell)))/area_cell)-background(i,j);
        nucleus(i,j)=((sum(sum(temp.*mask_nucleus)))/area_nucleus)-background(i,j);
        cytoplasm(i,j)=((sum(sum(temp.*mask_cytoplasm)))/area_cytoplasm)-background(i,j);
    end
end

cell(find(cell<0)) = 0.0;
nucleus(find(nucleus<0)) = 0.0;
cytoplasm(find(cytoplasm<0)) = 0.0;
