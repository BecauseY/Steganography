
%�����ʽ����:waveextract('girlwsvd.png','girl.jpg',52,'db6',2,0.1)
%����˵��:
%inputΪ����ԭʼͼ��
%seedΪ���������
%waveletΪʹ�õ�С������
%levelΪС���ֽ�ĳ߶�
%alphaΪˮӡǿ��

function waveextract(test,original,seed,wavelet,level,alpha)

%��ȡԭʼͼ��
data=imread(original);
data=double(data)/255;
datared=data(:,:,1);%��R���ˮӡ
%С���ֽ�,��ȡ��Ƶϵ��
[C,S]=wavedec2(datared,level,wavelet);
CA=appcoef2(C,S,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
[M,N]=size(CA);
CAmin=min(min(CA));
CAmax=max(max(CA));
CA=(1/(CAmax-CAmin))*(CA-CAmin);
d=max(size(CA));
%�Ե�Ƶ��ϵ����ֵ�ֽ�
[U,sigma,V]=svd(CA);


%��ȡ����ˮӡ��ͼ��
datatest=imread(test);
datatest=double(datatest)/255;
datatestred=datatest(:,:,1);%��R���ˮӡ
%С���ֽ�,��ȡ��Ƶϵ��
[C1,S1]=wavedec2(datatestred,level,wavelet);
CA1=appcoef2(C1,S1,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
[M1,N1]=size(CA1);
CAmin1=min(min(CA1));
CAmax1=max(max(CA1));
CA1=(1/(CAmax1-CAmin1))*(CA1-CAmin1);
d1=max(size(CA1));
CA1=(CA1-CAmin)/(CAmax-CAmin);

watermark=(CA1-CA)*10;

%�ع�����ˮӡ����״
watermark2=reshape(watermark,1,S(1,1)*S(1,2));
waterC=C1;
waterC(1,1:S(1,1)*S(1,2))=watermark2;
watermark2=waverec2(waterC,S,wavelet);

watermark2=watermark2(:)';
[logoh,logol]=size(watermark2);
%m����(������������ж�ֵ������)
rand('seed',seed);
mesquence=rand(1,logol);
for i=1:logol
    if mesquence(i)>0.5
        mesquence(i)=1;
    else
        mesquence(i)=0;
    end
end

spread_mark=xor(watermark2,mesquence);









