function array = find_max(image, count)
[m,n] = size(image);
array = zeros(1, count);
flag = 0;
for i = 1:m
    for j = 1:n
        if image(i,j)> flag
            array = insert_max(array, image(i,j));
            flag = image(i,j);
        end
    end
end
array = sort(array,'descend');
end
function new_array = insert_max(array, max)
    %[row, col] = size(array);
    new_array = array;
    min_loc = find(array==min(min(array)));
    new_array(min_loc(1)) = max;
end