%�����ʽ����:[watermarkimagergb,watermarkimage,waterCA,watermark,S_sigma,S_C]=wavemarksvd('girl.jpg','embed.png',1983,'db6',2,0.1)
function [watermarkimagergb,watermarkimage,waterCA,watermark,S_sigma,S_C,S_S] = wavemarksvd(input,goal,seed,wavelet,level,alpha)
data=imread(input);
data=double(data)/255;
datared=data(:,:,1);
%------------------------------��ԭʼͼ����е�svd����
[row,list]=size(datared);
[C,S]=wavedec2(datared,level,wavelet);
CA=appcoef2(C,S,wavelet,level);
[M,N]=size(CA);
%--------------------------��Ƶϵ����һ��
CAmin=min(min(CA));
CAmax=max(max(CA));
CA=(1/(CAmax-CAmin))*(CA-CAmin);
d=max(size(CA));
[U,sigma,V]=svd(CA);
%---------------------------R����Ϊˮӡͼ��
mark = imread('9999.jpg');
mark = double(mark)/255;
mark_R = mark(:,:,1);
%---------------------------��ˮӡͼ���ֵ��
mark_R =  round(mark_R);
[height,width] = size(mark_R);
%---------------------------������Ƶ��ϵ��
times = row*list / (height*width);
%---------------------------��ˮӡͼ��ת��һά����Ƶ
for i = 1:height
    for j = 1:width
        for k=1:times
			S_mark((i-1)*width*times + (j-1)*times + k)= mark_R(i,j);
        end
    end
end
%-----------------------����������У�����m���У�
rand('seed',seed);
sz = size(S_mark,2);
m_sequence = rand(1,sz);
%-----------------------������ж�ֵ��
for i=1:sz
    if m_sequence(i)>=0.5
        m_sequence(i)=1;
    else
        m_sequence(i)=0;
    end
end
%-----------------------------------�������õ�gold��
goldcode=xor(S_mark,m_sequence); 
%-----------------------------------��ԭ��2ά
spread_mark = reshape(goldcode,[row,list]);
% for i=1:row
%     for j=1:list
%         spread_cache(i,j)=spread_mark2(1,(i-1)*384+j);
%     end
% end
% spread_mark=spread_cache;
%-----------------------------------����Ƶ���ˮӡͼ�����svd����
[S_C,S_S]=wavedec2(spread_mark,level,wavelet);
S_CA=appcoef2(S_C,S_S,wavelet,level);
[M2,N2]=size(S_CA);
CAmin2=min(min(S_CA));
CAmax2=max(max(S_CA));
S_CA=(1/(CAmax2-CAmin2))*(S_CA-CAmin2);
d=max(size(S_CA));
[S_U,S_sigma,S_V]=svd(S_CA);
V2=S_V;
U2=S_U;
sigma_tilda=alpha*flipud(sort(rand(d,1)));
%-------------------------------------------����Ƕ��ˮӡͼ���滻u��v.


S_CA = S_U*S_sigma*S_V';
S_CA=reshape(S_CA,1,S_S(1,1)*S_S(1,2));
S_C(1,1:S_S(1,1)*S_S(1,2))=S_CA;
spread_mark3 = waverec2(S_C,S_S,wavelet);
spread_mark3 = round(abs(spread_mark3));
goldcode = reshape(spread_mark3,[1,row*list])
%-----------------------------------�������õ���Ƶ�ź�
S_mark=xor(goldcode,m_sequence);
sz = size(S_mark,2);
n = 0
flag = 0
for i = 1:sz
    flag = flag + 1;
    if flag == 9
        n = n + 1;
        flag = 0;
        mark(n) = S_mark(i);
    end
end
sz2 = size(mark,2);
for i=1:128
    for j=1:128
        spread_cache(i,j)=mark((i-1)*128+j);
    end
end
figure(2)
mark(:,:,1) = spread_cache*255
imshow(spread_cache)




watermark=U2*diag(sigma_tilda,0)*V2';
%-------------------------------------------�ع�����ˮӡ����״������ֱ����ʶ������������
watermark2=reshape(watermark,1,S_S(1,1)*S_S(1,2));
waterC=S_C;
waterC(1,1:S_S(1,1)*S_S(1,2))=watermark2;
watermark2=waverec2(waterC,S_S,wavelet);
%-------------------------------------------����Ƕ��ˮӡ���ͼ��
CA_tilda=watermark+CA;
%--------------------------------------------ϵ��������������ϵ���븺������
over1=find(CA_tilda>1);
below0=find(CA_tilda<0);
CA_tilda(over1)=1;
CA_tilda(below0)=0;
%--------------------------------------------ϵ����ԭ����һ��ǰ��Χ
CA_tilda=(CAmax-CAmin)*CA_tilda+CAmin;
%--------------------------------------------��¼����ˮӡ�ĵ�Ƶϵ���������棩
waterCA=CA_tilda;
%--------------------------------------------�ع�
CA_tilda=reshape(CA_tilda,1,S(1,1)*S(1,2));
C(1,1:S(1,1)*S(1,2))=CA_tilda;
watermarkimage=waverec2(C,S,wavelet);
watermarkimagergb=data;
watermarkimagergb(:,:,1)=watermarkimage;
imwrite(watermarkimagergb,goal,'BitDepth',16);
watermarkimagergb2=imread(goal);
%-------------------------------------------ͼƬչʾ
% mark(:,:,1) = mark_R*255;
figure(1);
subplot(321),imshow(watermark2*255);title('ˮӡ��̬ͼ');
subplot(322),imshow(mark);title('ˮӡͼ��');
subplot(323),imshow(data);title('ԭʼͼ��');
subplot(324),imshow(watermarkimagergb2);title('Ƕ��ˮӡ���rgbͼ��');
subplot(325),imshow(datared);title('R��ͼ��');
subplot(326),imshow(watermarkimage);title('Ƕ��ˮӡ���R��ͼ��');
