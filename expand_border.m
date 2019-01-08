function expend_image = expand_border(image, filter)
    [m ,n] = size(image);
    expend_image = zeros(size(image) + size(filter));
    expend_image(100:m+99,100:n+99) = image;    
end