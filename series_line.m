%% 计算array 中是否有连续的number个数据
function flag = series_line(array, number)
    sum =0;
    flag= 0;
    for i = 1:length(array)
        if array(i) == 0
            sum = 0;
        end
        sum = sum + array(i);
        if sum == number
            flag = 1;
            return;
        end
    end
end