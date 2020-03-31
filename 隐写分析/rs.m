%�����ʽ�� rate=rs('rand.bmp')
%��������
function rate=rs(input) 
cover=imread(input);
cover=double(cover);
cover=cover(:)';
[m,n] = size(cover);
cover1=cover;
k = n/4;

R = zeros(2, 4); %�����洢����RS���ĸ�ֵ
M = [1;0;0;1]; %����ʵ���漴��ת
bloc = zeros(4, 1);
for j = 1 : k        %���Ǹ��ͷ�����ת���ټ��������
    bloc=cover1((j-1)*4+1:j*4);  %ÿ�ĸ����ط���һ��
    summ(1) = f(bloc);
    summ(2) = f(posturn(bloc,M));
    summ(3) = f(negturn(bloc,M));
    if summ(2) > summ(1)  %Rm
        R(1,1) = R(1,1) + 1;
    end
    if summ(2) < summ(1)  %Sm
        R(1,2) = R(1,2) + 1;
    end
    if summ(3) > summ(1)  %R_m
        R(1,3) = R(1,3) + 1; 
    end
    if summ(3) < summ(1)  %S_m
        R(1,4) = R(1,4) + 1;
    end
end

cover2 = posturn(cover1, ones(n, 1));  %�ȶ�����ȫ������ת���������Ǹ��ͷ�����ת���ټ��������
for j = 1 : k        
    bloc=cover2((j-1)*4+1:j*4);  
    summ(1) = f(bloc);
    summ(2) = f(posturn(bloc,M));
    summ(3) = f(negturn(bloc,M));
    if summ(2) > summ(1)  %Rm
        R(2,1) = R(2,1) + 1;
    end
    if summ(2) < summ(1)  %Sm
        R(2,2) = R(2,2) + 1;
    end
    if summ(3) > summ(1)  %R_m
        R(2,3) = R(2,3) + 1; 
    end
    if summ(3) < summ(1)  %S_m
        R(2,4) = R(2,4) + 1;
    end
end
R = R/k;
dpz = R(1,1) - R(1,2); dpo = R(2,1) - R(2,2);
dnz = R(1,3) - R(1,4); dno = R(2,3) - R(2,4);
C = [2 * (dpo + dpz), (dnz - dno - dpo - 3 * dpz), (dpz - dnz)];
r = roots(C);
p = r./(r - 0.5);
rate=p(2);

end


%����������
% ������ظ��Ӷ�
function y = f(x)  
n = length(x);
y = sum(abs(x(1:n-1) - x(2:n)));
end

%�Ǹ���ת,F1�任��F0�任
function y = posturn(x, M)  
M=M';
y = x + (1 - 2 * mod(x, 2)) .* M;
end

% ������ת��F-1�任��F0�任
function y = negturn(x, M) 
M=M';
y = x + (2 * mod(x, 2) - 1) .* M;
end