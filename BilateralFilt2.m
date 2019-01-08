function resultI = BilateralFilt2(I,d,sigma)
    %%%
    % I,image
    % d,��Ե��չ
    % sigma,ϵ��
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
    newI = ReflectEdge(I,d); % ������ͼ��0���߽�
    resultI = zeros(m,n);
    width = 2*d+1; % �����˲���С
    %Distence
    D = fspecial('gaussian',[width,width],sigma(1));  
    S = zeros(width,width);
    h = waitbar(0,'Applying bilateral filter...');
    set(h,'Name','Bilateral Filter Progress');
    for i = 1+d:m+d % ����Ϊ1�������
        for j = 1+d:n+d
            pixValue = newI(i-d:i+d,j-d:j+d); % ͼ���е�һ��2d+1 * 2d+1 �ķ���
            subValue = pixValue-newI(i,j); % ��ǰ������ÿ���������ĵ�Ĳ�ֵ.
            S = exp(-subValue.^2/(2*sigma(2)^2)); % Ȩ�ؼ��㣬������ֵ�Ĳ�ֵԽС��ռ��Խ��
            % S = exp(-subValue.^2);
            H = S.*D; % SȨ�����˹�˲�����˹�˲���Խ�������ģ�ֵԽ�󣩵�ˣ��õ���ͼ�������йص����˲���
            resultI(i-d,j-d) = sum(pixValue(:).*H(:))/sum(H(:)); % ��������(i-d,j-d)λ�õ�����ֵ��
        end
        waitbar(i/m);
    end
    close(h);
end

