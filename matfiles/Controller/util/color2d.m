function color2d(x,y,data)
    x = x(:)';
    y = y(:)';
    data = data(:)';
    
    z = zeros(size(data));
    col = data;
    a = [x;x];
    b = [y;y];
    c = [z;z];
    d = [col;col];
    surface(a,b,c,d,...
            'facecol','no',...
            'edgecol','interp',...
            'linew',2);
    colorbar;
    colormap jet;
    axis equal;
end

