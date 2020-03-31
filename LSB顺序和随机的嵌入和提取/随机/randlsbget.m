% �����ʽ����:  result = randlsbget('9999testrand.bmp' ,128, 'secretrand.txt' , 2001) 
% ����˵��:
% output ����Ϣ���غ��ͼ�� 
% len_total ��������Ϣ�ĳ��� 
% goalfile ����ȡ����������Ϣ�ļ�
% key ����������������Կ 
% result ����ȡ����Ϣ
function result = randlsbget( output, len_total, goalfile, key)
ste_cover = imread( output) ;
ste_cover = double( ste_cover) ;
% �ж�Ƕ����Ϣ���Ƿ����
[m,n] = size( ste_cover) ; 
frr = fopen( goalfile, 'a' ) ; 
% p ��Ϊ��ϢǶ��λ��������, ����Ϣ����д���ı��ļ�
p =1;
% ��������������ѡȡ���ص�
[ row, col] = randinterval( ste_cover, len_total, key) ; 
for i = 1:len_total
    if bitand( ste_cover( row( i) , col( i) ) , 1) == 1    
        result( p,1) = 1;
    else
        result( p,1) = 0;
    end
    if p == len_total
        break;
    end
    p = p +1;
end
fwrite(frr,result,'ubit1');
fclose( frr) ; 