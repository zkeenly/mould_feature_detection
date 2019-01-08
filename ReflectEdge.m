function newI = ReflectEdge(I,d)
    if size(I,3) == 1
        newI = ReflectEdgeGray(I,d);
    elseif size(I,3) == 3
        newI = RefectEdgeColor(I,d);
    else 
        error('Icorrect image size');
    end
end

function newI = ReflectEdgeGray(I,d)
    [m n] = size(I);
    newI = zeros(m+2*d,n+2*d);
    newI(d+1:d+m,d+1:d+n) = I; % ͼ�м䲿��
    newI(1:d,d+1:d+n) = I(d:-1:1,:); % ����ϰ벿�֣��������.
    newI(end-d:end,d+1:d+n) = I(end:-1:end-d,:); % �°벿��
    newI(:,1:d) = newI(:,2*d:-1:d+1);  
    newI(:,n+d+1:n+2*d) = newI(:,n+d:-1:n+1); % �Ұ벿�� 
end


