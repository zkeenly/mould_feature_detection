folder = 'image/test/';
filepaths = dir(folder);
fprintf('total of :%d \n',length(filepaths));
for i = 3:length(filepaths)          % �����ṹ��Ϳ���һһ����ͼƬ��
    %fprintf('%s ',[folder filepaths(i).name]);
    sub_folder = [folder filepaths(i).name '/'];
    sub_filepaths = dir(sub_folder);
    for j = 3:length(sub_filepaths)
        fprintf('%s \n',[sub_folder sub_filepaths(j).name]);
        tic;
        detection_line([sub_folder sub_filepaths(j).name])
        toc;
    end
end