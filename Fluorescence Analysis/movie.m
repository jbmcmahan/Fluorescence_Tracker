classdef movie < handle
    %MOVIE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fileName;
        movieInfo;
        matrix;
        bits;
        frameCount;
        channelCount;
        timeCount;
        xPixels;
        yPixels;
    end
    
    methods
        function obj = movie(channelCount)
            [f_name,p_name] = uigetfile({'*.tif';'*.TIF';'*.tiff';'*.TIFF'},'Select your image file');           
            obj.fileName = fullfile(p_name,f_name);
            obj.movieInfo = imfinfo(obj.fileName);
            obj.frameCount = size(obj.movieInfo,1);
            obj.xPixels = obj.movieInfo(1).Width;
            obj.yPixels = obj.movieInfo(1).Height;
            obj.channelCount = channelCount;
            obj.timeCount = obj.frameCount/obj.channelCount;
            obj.bits = obj.movieInfo(1).BitsPerSample;
        end

            %%% storing movie as matrix %%%
        function storeMatrix(obj)
            if obj.bits == 8
                obj.matrix = uint8(zeros(obj.yPixels,obj.xPixels,obj.frameCount));
            elseif obj.bits == 32
                obj.matrix = uint16(zeros(obj.yPixels,obj.xPixels,obj.frameCount));
            else
                obj.matrix = uint16(zeros(obj.yPixels,obj.xPixels,obj.frameCount));
            end
            x = 1;
            for i = 1:obj.frameCount
                obj.matrix(:,:,x)=imread(obj.fileName,i);
                x = x+1;
            end
        end
        

        
    end
end

