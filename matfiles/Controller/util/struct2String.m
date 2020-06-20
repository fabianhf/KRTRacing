function s = struct2String(in)
%STRUCTTOSTRING Summary of this function goes here
%   Detailed explanation goes 

    s = 'precomputedLine = struct(); ';
    fnames = fieldnames(in);
    
    for i=1:length(fnames)
        try
            s = [s 'precomputedLine.' fnames{i} ' = ' mat2str(in.(fnames{i})) '; '];
        catch
        end
    end
    
    fid = fopen('precomputedLine.txt','wt');
    fprintf(fid, s);
    fclose(fid);
    
end

