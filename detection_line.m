% filepath = 'image/failed/3/18-0731-1636.BMP';
% detection(filepath);

%% 全局函数处理
function detection_line(filepath)
filter_file = 'filter_square.bmp';
image = imread(filepath);
image = rgb2gray(image);
%figure,imshow(image);
%% 引导滤波处理
resultI = imguidedfilter(image);

%% 边缘提取算法滤波处理
image = resultI;
%[m, n] = size(image);
%figure, imshow(Y);
img_canny=edge(image,'canny'); %用Sobel算子进行边缘检测
%img_log=edge(image,'log'); %用Sobel算子进行边缘检测
%figure, imshow(img_log);title('log');

%% 腐蚀图像
% se = strel('line',1,0);  %竖着的2个元素腐蚀掉
% img_canny=imerode(img_canny,se);
% figure,imshow(img_canny);

%% 对边缘图像进行卷积125度角度运算。计算拐角点的坐标
filter = imread(filter_file);
filter = double(filter);
img_canny = double(img_canny);
border_canny = expand_border(img_canny,filter);  % 生成扩展的image
%conv_result = zeros(size(img_canny)-size(filter));
conv_result = zeros(size(img_canny)); % 生成与原图大小一致的结果图像。
[conv_result_row,conv_result_col]=size(conv_result);
tic;
for i = 240:conv_result_row
    % 如果不存在连续三个1的话，就终止本行。
%     if series_line(img_canny(1:320,i-1), 15) == 0
%         continue;
%     end
    %fprintf('%d \n',i);
    for j = 1:conv_result_col-320
        value = border_canny(i:i+199,j:j+199).*filter;
        sum_value = sum(value(:));
        conv_result(i,j) = sum_value;
    end
end
toc;
% 找到最合适的拐点坐标（如果有两个最大，则挑选最靠上的）
max_array = find_max(conv_result,2);
if (max_array(1) - max_array(2)) < max_array(1)/10
    [max_y_1,max_x_1] = find(conv_result==max_array(1));
    [max_y_2,max_x_2] = find(conv_result==max_array(2));
    if max_y_1 > max_y_2
        max_y = max_y_2;
        max_x = max_x_2;
    else
        max_y = max_y_1;
        max_x = max_x_1;
    end
else
%[max_y,max_x] = find(conv_result==max(max(conv_result)));
[max_y,max_x] = find(conv_result==max_array(1));
end
%% 计算下边缘的标记位置
[img_canny_row,img_canny_col]=size(img_canny);
less_len = 8;
bottom_x = 0;
bottom_y = 0;
for i = max_y+less_len:img_canny_row
    line_sum = 0;
    % fprintf('%d \n',i);
    for j = max_x:img_canny_col-2
        %line_sum = line_sum + img_canny(i,j);
        if img_canny(i,j) == img_canny(i,j+1) && img_canny(i,j+1) == img_canny(i,j+2) && img_canny(i,j+2) == double(1)
            line_sum = line_sum + img_canny(i,j);
        end
    end
    % fprintf('%d \n',line_sum);
    if line_sum > (img_canny_col-max_x)/10
        bottom_x = max_x;
        bottom_y = i;
        break;
    end
end

%% 绘制上下边缘的标记横线。
figure, imshow(img_canny);title('canny');
figure,imshow(image);title('gray image');
% 绘制上边界
draw_line(max_x,max_y);
% 绘制下边界
draw_line(bottom_x, bottom_y);
%% 计算间距（像素之差）
fprintf('间距为：%d \n',bottom_y - max_y);
end 


