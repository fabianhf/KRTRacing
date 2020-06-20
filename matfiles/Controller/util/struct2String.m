function s = struct2String(in,varname,fileName)
%STRUCTTOSTRING Summary of this function goes here
%   Detailed explanation goes 

    s = [varname ' = struct(); '];
    fnames = fieldnames(in);
    
    for i=1:length(fnames)
        try
            s = [s varname '.' fnames{i} ' = ' sprintf('reshape(%s, %s); ', mat2str(in.(fnames{i})(:)), mat2str(size(in.(fnames{i}))))];
        catch
        end
    end
    
    fid = fopen(fileName,'wt');
    fprintf(fid, s);
    fclose(fid);   
end

