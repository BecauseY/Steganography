clc;
clear; 
%��ȡͼƬ
img1=imread('C:\Users\12943\Desktop\��Ϣ����\ͼƬ\1085.jpg')
%RGBͼ��ֲ�
img1R=img1(:,:,1)
img1G=img1(:,:,2)
img1B=img1(:,:,3)
%RGBͼ��ϲ�
img2=cat(3,img1R,img1G,img1B)

%��ʾͼ��
subplot(321),imshow(img1),title('ԭʼͼ��')
subplot(322),imshow(img2),title('ƴ��ͼ��')

%ת���Ҷ�ͼ��Ͷ�ֵͼ��
img3=rgb2gray(img1)
imwrite(img3, 'gray.bmp') 
img4=im2bw(img1,0.3)
subplot(323),imshow(img3),title('�Ҷ�ͼ��')
subplot(324),imshow(img4),title('��ֵͼ��')

%��С
[row,col]=size(img1)

%����
%t=0:0.01*pi:2*pi
%plot(t,sin(t));
%title('0��2�ǵ���������','FontSize',16);
%xlabel('t=0��2 ��');
%ylabel('sin(t)');
%text(pi,sin(pi),'\leftarrow sin(t)=0');

img5=dct2(img1R)
subplot(325),imshow(img5),title('���任ͼ��')
img6=idct2(img1G)
subplot(326),imshow(img6),title('��任ͼ��')