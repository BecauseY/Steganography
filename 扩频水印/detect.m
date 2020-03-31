%�ļ���:wavedetect.m
%����Ա:����
%��дʱ��:2003.10.7
%��������:�����������W-svdģ��������ˮӡ�ļ��
%�����ʽ����:[corr_coef,corr_DCTcoef]=detect('embed.png','girl.jpg',1983,'db6',2,0.1)
%����˵��:
%inputΪ����ԭʼͼ��
%seedΪ���������
%waveletΪʹ�õ�С������
%levelΪС���ֽ�ĳ߶�
%alphaΪˮӡǿ��
%ratioΪ�㷨��d/n�ı���
%corr_coef,corr_DCTcoef�ֱ�Ϊ��ͬ�����¼��������ϵ��
function [corr_coef,corr_DCTcoef]=detect(test,original,seed,wavelet,level,alpha)
%function realCA=wavedetect(test,original,seed,wavelet,level,alpha,ratio)
dataoriginal=imread(original);
datatest=imread(test);
dataoriginal=double(dataoriginal)/255;
datatest=double(datatest)/65535;
dataoriginal=dataoriginal(:,:,1);
datatest=datatest(:,:,1);
%��ȡ����ˮӡ��ͼ���С����Ƶϵ��
[watermarkimagergb,watermarkimage,waterCA,watermark2,S_sigma,S_C,S_S]=wavemarksvd(original,'temp.png',seed,wavelet,level,alpha);
%��ȡ����ͼ���С����Ƶϵ��
[row,list]=size(datatest);
[C,S]=wavedec2(datatest,level,wavelet);
CA_test=appcoef2(C,S,wavelet,level);
%��ȡԭʼͼ���С����Ƶϵ��
[C,S]=wavedec2(dataoriginal,level,wavelet);
realCA=appcoef2(C,S,wavelet,level);
%��������ˮӡ
realwatermark=waterCA-realCA;
testwatermark=CA_test-realCA;

%���������
corr_coef=trace(realwatermark'*testwatermark)/(norm(realwatermark,'fro')*norm(testwatermark,'fro'));
%DCT ϵ���Ƚ�
DCTrealwatermark=dct2(waterCA-realCA);
DCTtestwatermark=dct2(CA_test-realCA);
DCTrealwatermark=DCTrealwatermark(1:min(32,max(size(DCTrealwatermark))),1:min(32,max(size(DCTrealwatermark))));
DCTtestwatermark=DCTtestwatermark(1:min(32,max(size(DCTtestwatermark))),1:min(32,max(size(DCTtestwatermark))));
DCTrealwatermark(1,1)=0;
DCTtestwatermark(1,1)=0;
corr_DCTcoef=trace(DCTrealwatermark'*DCTtestwatermark)/(norm(DCTrealwatermark,'fro')*norm(DCTtestwatermark,'fro'));

%-----------------------����Ƶ�źţ�ˮӡ����ԭ��խ���ź�
[S_U,S_sigma,S_V] = svd(testwatermark);
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
imshow(spread_cache)

