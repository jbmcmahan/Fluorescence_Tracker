%%% Fluorescence Analysis %%%
%%% Jeff McMahan %%%
%%% Syed Lab %%%

clear all; %deletes all variables
close all; %closes all windows

movie1 = movie(18); %initializes movie from file
movie1.storeMatrix(); %stores movie as matrix

    %creates fluorescent matrices
background = zeros(movie1.timeCount, movie1.channelCount, 'double');
wholeCell = zeros(movie1.timeCount, movie1.channelCount, 'double');
nucleus = zeros(movie1.timeCount, movie1.channelCount, 'double');
cytoplasm = zeros(movie1.timeCount, movie1.channelCount, 'double');

    %gets average intensity values for each frame and stores in matrices
for i = 1:movie1.channelCount;
    time_mid = ceil(movie1.timeCount/2); 
    frame_mid = frame(movie1,time_mid,i);
        %creates masks for each channel
    mask_background = frame_mid.createMask('background');
    mask_cell = frame_mid.createMask('cell');
    mask_nucleus = frame_mid.createMask('nucleus');
    mask_cytoplasm = mask_cell-mask_nucleus;
        %calculates area of the masks
    area_background = sum(sum(mask_background));
    area_cell = sum(sum(mask_cell));
    area_nucleus = sum(sum(mask_nucleus));
    area_cytoplasm = sum(sum(mask_cytoplasm));
    for j = 1:movie1.timeCount; %runs through each time for the specified channel
        temp1 = frame(movie1,j,i);
        temp = double(temp1.matrix);
        background(j,i)=(sum(sum(temp.*mask_background)))/area_background;
        wholeCell(j,i)=((sum(sum(temp.*mask_cell)))/area_cell)-background(i,j);
        nucleus(j,i)=((sum(sum(temp.*mask_nucleus)))/area_nucleus)-background(i,j);
        cytoplasm(j,i)=((sum(sum(temp.*mask_cytoplasm)))/area_cytoplasm)-background(i,j);
    end
end

    %replaces negative values with zero
wholeCell(find(WholeCell<0)) = 0.0;
nucleus(find(nucleus<0)) = 0.0;
cytoplasm(find(cytoplasm<0)) = 0.0;
