function result= md52num(md5code)
%%��md5��ת��������

result=0;
for i=1:32
    result=result+ tablec(md5code(i))*i;
end
end

