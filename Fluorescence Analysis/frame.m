classdef frame
    %FRAME: a single image from a movie
    %   methods:    showFrame(obj) - shows frame as image with adjusted contrast
    %               
    
    properties
        time;
        channel;
        matrix;
    end
    
    methods
        %%% initializes frame - adjust the 'slide' equation for different experiment setups
        function obj = frame(movie,time,channel)
            slide = time*(movie.timeCount)+channel;
            obj.matrix = movie.matrix(:,:,slide);
            obj.time = time;
            obj.channel = channel;
        end
        
        %%% shows frame as image
        function showFrame(obj)
            adjust = double(obj.matrix);
            adjust = adjust - min(min(adjust));
            adjust = adjust / max(max(adjust));
            figure;
            imshow(adjust);
            str = sprintf('Time %i, Channel %i',obj.time,obj.channel);
            title(str);
        end
        
        %%% returns mask - type refers to 'nucleus', 'cell', 'background'
        function mask = createMask(obj,type)
            adjust = double(obj.matrix);
            adjust = adjust - min(min(adjust));
            adjust = adjust / max(max(adjust));
            str = sprintf('Define the %s for Channel %i, Time %i',type,obj.channel,obj.time);
            figure('Name',str);
            mask = double(roipoly(adjust));
            close all;
        end
    end
end
