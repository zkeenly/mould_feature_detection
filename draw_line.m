%% »æÍ¼º¯Êý
function draw_line(loc_x, loc_y)
px = loc_x;
py = loc_y;
step = 300;
x1 = px ;
x2 = px + step;
y1 = py;
%    x1 = px - step;
%    x2 = px + step;
%    y1 = py - step;
%    y2 = py + step;
hold on;
rectx = [x1 x2 ];
recty = [y1 y1 ];
% rectx = [x1 x2 x2 x1 x1];
% recty = [y1 y1 y2 y2 y1];
plot(rectx, recty, 'linewidth',1.5);
hold off;
end