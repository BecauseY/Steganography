%�ļ���:plotcorr_coef.m
%����Ա:����
%��дʱ��:2003.10.7
%��������:����һ�����Ƽ��ˮӡ�������ͼ�ĺ���
%�����ʽ����:corr_Wcoef=plotcorr_coef2('girlcell.jpg','jpg','girl.jpg','jpg',3,0.1,60)

%����˵��:
%testΪ����ͼ��
%originalΪԭʼͼ��
%testMAXseedΪʵ��ʹ�õ�������������
%waveletΪʹ�õ�С������
%levelΪС���ֽ�ĳ߶�
%alphaΪˮӡǿ��
%ratioΪ�㷨��d/n�ı���
%corr_Wcoef,corr_Dcoef�ֱ�Ϊ���ò�ͬ���Ӽ��������ϵ���ļ���
function  [corr_Wcoef,corr_Dcoef]=plotcorr_coef2(test,permission1,original,permission2,do_num,alpha,testMAXseed)
corr_Wcoef=zeros(testMAXseed,1);
corr_Dcoef=zeros(testMAXseed,1);
s=1;
for i=1:testMAXseed
  corr_coef=wavedetect2(test,permission1,original,permission2,i,do_num,alpha);
  corr_Wcoef(s)=corr_coef;
  s=s+1;
end
subplot(111);plot(abs(corr_Wcoef));
title('ˮӡ�����ֵ����');
xlabel('����');
ylabel('���ֵ');

