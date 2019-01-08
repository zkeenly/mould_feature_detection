function resultI = BilateralFilt2(I,d,sigma)
    %%%
    % I,image
    % d,边缘扩展
    % sigma,系数
    I = double(I);
    if size(I,3) == 1
        resultI = BilateralFiltGray(I,d,sigma);
    elseif size(I,3) == 3
        resultI = BilateralFiltColor(I,d,sigma); 
    else
        error('Incorrect image size');
    end
end

function resultI = BilateralFiltGray(I,d,sigma)
    [m n] = size(I);
    newI = ReflectEdge(I,d); % 对输入图像0填充边界
    resultI = zeros(m,n);
    width = 2*d+1; % 定义滤波大小
    %Distence
    D = fspecial('gaussian',[width,width],sigma(1));  
    S = zeros(width,width);
    h = waitbar(0,'Applying bilateral filter...');
    set(h,'Name','Bilateral Filter Progress');
    for i = 1+d:m+d % 步长为1，卷积。
        for j = 1+d:n+d
            pixValue = newI(i-d:i+d,j-d:j+d); % 图像中的一个2d+1 * 2d+1 的方块
            subValue = pixValue-newI(i,j); % 当前区域中每个点与中心点的差值.
            S = exp(-subValue.^2/(2*sigma(2)^2)); % 权重计算，与中心值的差值越小，占比越大。
            % S = exp(-subValue.^2);
            H = S.*D; % S权重与高斯滤波（高斯滤波是越靠近中心，值越大）点乘，得到与图像数据有关的新滤波。
            resultI(i-d,j-d) = sum(pixValue(:).*H(:))/sum(H(:)); % 计算最终(i-d,j-d)位置的像素值。
        end
        waitbar(i/m);
    end
    close(h);
end

