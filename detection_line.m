% filepath = 'image/failed/3/18-0731-1636.BMP';
% detection(filepath);

%% ȫ�ֺ�������
function detection_line(filepath)
filter_file = 'filter_square.bmp';
image = imread(filepath);
image = rgb2gray(image);
%figure,imshow(image);
%% �����˲�����
resultI = imguidedfilter(image);

%% ��Ե��ȡ�㷨�˲�����
image = resultI;
%[m, n] = size(image);
%figure, imshow(Y);
img_canny=edge(image,'canny'); %��Sobel���ӽ��б�Ե���
%img_log=edge(image,'log'); %��Sobel���ӽ��б�Ե���
%figure, imshow(img_log);title('log');

%% ��ʴͼ��
% se = strel('line',1,0);  %���ŵ�2��Ԫ�ظ�ʴ��
% img_canny=imerode(img_canny,se);
% figure,imshow(img_canny);

%% �Ա�Եͼ����о��125�ȽǶ����㡣����սǵ������
filter = imread(filter_file);
filter = double(filter);
img_canny = double(img_canny);
border_canny = expand_border(img_canny,filter);  % ������չ��image
%conv_result = zeros(size(img_canny)-size(filter));
conv_result = zeros(size(img_canny)); % ������ԭͼ��Сһ�µĽ��ͼ��
[conv_result_row,conv_result_col]=size(conv_result);
tic;
for i = 240:conv_result_row
    % �����������������1�Ļ�������ֹ���С�
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
% �ҵ�����ʵĹյ����꣨����������������ѡ��ϵģ�
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
%% �����±�Ե�ı��λ��
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

%% �������±�Ե�ı�Ǻ��ߡ�
figure, imshow(img_canny);title('canny');
figure,imshow(image);title('gray image');
% �����ϱ߽�
draw_line(max_x,max_y);
% �����±߽�
draw_line(bottom_x, bottom_y);
%% �����ࣨ����֮�
fprintf('���Ϊ��%d \n',bottom_y - max_y);
end 


