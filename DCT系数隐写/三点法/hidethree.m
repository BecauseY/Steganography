%�������ܣ�����������DCT�����Ϣ����
%�����ʽ������[count,msg,data]=hidethree('girl.jpg','embed3.jpg','secret.txt',2019,1);
%����˵����
%imageΪ����ͼ��
%imagegoalΪ����������Ϣ�����壬����������
%msgΪ�����ص���Ϣ
%keyΪ��Կ�������������ѡ��
%alphaΪ��������������֤�������ȷ��
%countΪ��������Ϣ�ĳ���
%resultΪ���ؽ��
function [count,msg,result]=hidethree(image,imagegoal,msg,key,d)
%��λ��ȡ������Ϣ
frr=fopen(msg,'r');
[msg,count]=fread(frr,'ubit1');
fclose(frr);
data0=imread(image);
%��ͼ�����תΪdouble��
data0=double(data0)/255;
%ȡͼ���һ��������
data=data0(:,:,1);
%��ͼ��ֿ�
T=dctmtx(8);
%�Էֿ�ͼ����DCT�任
DCTrgb=blkproc(data,[8 8],'P1*x*P2',T,T');
DCTrgb0=DCTrgb;
%��������Ŀ�ѡ��,ȷ��ͼ�����׵�ַ
[row,col]=size(DCTrgb);
row=floor(row/8);
col=floor(col/8);
a=zeros([row col]);
[k1,k2]=randinterval(a,count,key);
for i=1:count
    k1(1,i)=(k1(1,i)-1)*8+1;
    k2(1,i)=(k2(1,i)-1)*8+1;
end
%��ϢǶ��
%1,2,3�ֱ�Ϊ(2,3)(3,1)(4,1)
temp=0;
var1=DCTrgb(k1(i)+2,k2(i)+3);
var2=DCTrgb(k1(i)+3,k2(i)+1);
var3=DCTrgb(k1(i)+4,k2(i)+1);
for i=1:count
   if msg(i,1)==1
         if var3>var1
            temp=var3;
            var3=var1; 
            var1=temp; 
         end
         if var3>var2
            temp=var3;
            var3=var2; 
            var2=temp; 
         end
     
   %Ƕ��0
   else
          if var3<var1
            temp=var3;
            var3=var1; 
            var1=temp;  
          end
          if var3>var2
            temp=var3;
            var3=var2; 
            var2=temp; 
          end
   end  
  if var3>var1 && var3>var2
      var3=var3+d;%��ԭ��С��ϵ�������ø�С
  elseif var3<var1 && var3<var2
      var3=var3-d;
  end    
end
%��Ϣд�ر��� 
DCTrgb(k1(i)+2,k2(i)+3)=var1;
DCTrgb(k1(i)+3,k2(i)+1)=var2;
DCTrgb(k1(i)+4,k2(i)+1)=var3;
 DCTrgb1=DCTrgb;
 data=blkproc(DCTrgb,[8 8],'P1*x*P2',T',T);
 result=data0;
 result(:,:,1)=data;
 imwrite(result,imagegoal);
 