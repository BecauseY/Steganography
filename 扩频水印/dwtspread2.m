function [watermarkimagergb,watermarkimage,waterCA,watermark]=dwtspread2(input,goal,seed,wavelet,level,alpha)
%��ȡԭʼͼ��
data=imread(input);
data=double(data)/255;
datared=data(:,:,1);%��R���ˮӡ
%��ԭʼͼ���R�����С���ֽ��¼ԭʼ��С,�����䲹������
[C,Sreal]=wavedec2(datared,level,wavelet);
[row,list]=size(datared);
standard1=max(row,list);
new=zeros(standard1,standard1);
if row<=list
   new(1:row,:)=datared;
else
   new(:,1:list)=datared;
end   
%��ʽ���Ǽ�ˮӡ
%С���ֽ�,��ȡ��Ƶϵ��
[C,S]=wavedec2(new,level,wavelet);
CA=appcoef2(C,S,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
[M,N]=size(CA);
CAmin=min(min(CA));
CAmax=max(max(CA));
CA=(1/(CAmax-CAmin))*(CA-CAmin);
d=max(size(CA));
%�Ե�Ƶ��ϵ����ֵ�ֽ�
[U,sigma,V]=svd(CA);

%��ȡˮӡͼ��
logobmp_ori=imread('logo.bmp')
logobmp=double(logobmp_ori)/255;
%logobmp=round(logobmp);
logobmp=logobmp(:);
[logoh,logol]=size(logobmp);
%��Ƶ��ԭʼͼ��R��������һ����
n=row*list/logoh;
for i=1:logoh
    for j=2:n
        logobmp(i,j)=logobmp(i,1);
    end
end
 logobmp=logobmp(:)';
[logoh,logol]=size(logobmp);
%m����(������������ж�ֵ������)
rand('seed',seed);
mesquence=rand(1,logol);
for i=1:logoh
    if mesquence(i)>0.5
        mesquence(i)=1;
    else
        mesquence(i)=0;
    end
end
%gold��
spread_mark=xor(logobmp,mesquence);

%��Ϊ��ԭʼͼ��R��ȴ�Ķ�ά����
item=1;
for i=1:row
    for j=1:list
        spread_mark2(i,j)=spread_mark(item);
        item=item+1;
    end
end
spread_mark=spread_mark2;

%����dwt+svd����
[C1,S1]=wavedec2(spread_mark,level,wavelet);
CA1=appcoef2(C1,S1,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
[M1,N1]=size(CA1);
CAmin1=min(min(CA1));
CAmax1=max(max(CA1));
CA1=(1/(CAmax-CAmin))*(CA1-CAmin);
d1=max(size(CA1));
%�Ե�Ƶ��ϵ����ֵ�ֽ�
[U1,sigma1,V1]=svd(CA1);

sigma_tilda=alpha*flipud(sort(rand(d,1)));
watermark=CA+U1*diag(sigma_tilda,0)*V1';
%�ع�����ˮӡ����״,����ֱ����ʶ,����������
watermark2=reshape(watermark,1,S(1,1)*S(1,2));
waterC=C1;
waterC(1,1:S(1,1)*S(1,2))=watermark2;
watermark2=waverec2(waterC,S,wavelet);
%����ϵ������Ƕ��ˮӡ���ͼƬ
CA_tilda=watermark;
over1=find(CA_tilda>1);
below0=find(CA_tilda<0);
CA_tilda(over1)=1;
CA_tilda(below0)=0;%ϵ������,�������븽������

CA_tilda=(CAmax-CAmin)*CA_tilda+CAmin;%ϵ����ԭ����һ����ǰ�ķ�Χ
%��¼����ˮӡ�ĵ�Ƶϵ��
waterCA=CA_tilda;
if row<=list
   waterCA=waterCA(1:Sreal(1,1),:);
else
   waterCA=waterCA(:,1:Sreal(1,2));
end   
%�ع�
CA_tilda=reshape(CA_tilda,1,S(1,1)*S(1,2));
C(1,1:S(1,1)*S(1,2))=CA_tilda;
watermarkimage=waverec2(C,S,wavelet);
%��ǰ�油�ϵı�Եȥ��
if row<=list
  watermarkimage=watermarkimage(1:row,:);
else
   watermarkimage=watermarkimage(:,1:list);
end   
watermarkimagergb=data;
watermarkimagergb(:,:,1)=watermarkimage;
imwrite(watermarkimagergb,goal,'BitDepth',16);%ͨ��д����������ϵ��
watermarkimagergb2=imread(goal);