%文件名:plotcorr_coef.m
%程序员:郭迟
%编写时间:2003.10.7
%函数功能:这是一个绘制检测水印的相关性图的函数
%输入格式举例:[corr_Wcoef,corr_Dcoef]=plotcorr_coef('girlwsvd.png','girl.jpg',60,'db6',2,0.1,0.99)

%参数说明:
%test为待测图像
%original为原始图像
%testMAXseed为实验使用的最大随机数种子
%wavelet为使用的小波函数
%level为小波分解的尺度
%alpha为水印强度
%ratio为算法中d/n的比例
%corr_Wcoef,corr_Dcoef分别为利用不同种子检测出的相关系数的集合
function  [corr_Wcoef,corr_Dcoef]=plotcorr_coef(test,original,testMAXseed,wavelet,level,alpha,ratio)
corr_Wcoef=zeros(testMAXseed,1);
corr_Dcoef=zeros(testMAXseed,1);
s=1;
for i=1:testMAXseed
  [corr_coef,corr_DCTcoef]=wavedetect(test,original,i,wavelet,level,alpha,ratio);
  corr_Wcoef(s)=corr_coef;
  corr_Dcoef(s)=corr_DCTcoef;
  s=s+1;
end
subplot(211);plot(abs(corr_Wcoef));
title('小波系数阈值分析');
xlabel('种子');
ylabel('相关值');
subplot(212);plot(abs(corr_Dcoef));
title('DCT变换后小波系数阈值分析');
xlabel('种子');
ylabel('相关值');
