% �����ʽ����:  F=compare('9999.jpg','9999test.bmp')
% ����˵��:
% original ��ԭʼ����ͼ��
% hided �����غ��ͼ�� 
% F �ǲ�ֵ����
function  F=compare(original,hided) % ��ȡԭʼ����ͼ�����
W=imread(original) ;
W=double(W)/255; 
% ��ȡ���غ�ͼ�����
E=imread(hided) ;
E=double(E)/255;
% ����ͼ��������, ��ʾЧ�� 
F=E-W; 
% ע��, MATLAB �о������ֻ֧�� double ��
imshow(mat2gray(F)) 