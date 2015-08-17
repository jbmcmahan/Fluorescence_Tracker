classdef frame
    %FRAME Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time;
        channel;
        matrix;
    end
    
    methods
        function obj = frame(movie,time,channel)
            slide = time*(movie.timeCount-1)+channel;
            obj.matrix = movie.matrix(:,:,slide);
            obj.time = time;
            obj.channel = channel;
        end
        
        function showFrame(obj)
            adjust = double(obj.matrix);
            adjust = adjust - min(min(adjust));
            adjust = adjust / max(max(adjust));
            figure;
            imshow(adjust);
            str = sprintf('Time %i, Channel %i',obj.time,obj.channel)
            title(str);
        end
    end
end

