function [N,j] = plusyeah(K,a,num_boat)
%�������ܣ�������״̬��ȥ�����븸�ڵ���ͬ��״̬�ͳ���״̬
%���룺�ṹ�����У�Ҫ��չ��״̬���
%��������ɵ���״̬����N����״̬���и���j�����û����״̬j=0

   j=0; %��ʾ���ɵ��ӽڵ���Ŀ NΪ��ȡ����״̬
   %%
   B_total=0;
   for i=1:num_boat  %����������i
       for k=0:i    %����ʿ������k
           if k>=(i-k) || k==0 
           B_total=B_total+1;
           B(:,B_total)=[k;i-k;1];
           end
       end
   end
   
   
   if K(a).State(3,1) == 1
   %left to right
        for i=1:B_total
           [Nt,j1] = plusjudge(K,a,B(:,i));
           if j1==1
                j=j+1;N(:,:,j)=Nt;
           end
        end
   end
   %%
   if K(a).State(3,1) == 0
           % right to left
       if j == 0    %��ʾ�������󰶣������Ұ����������У������Ұ�
           for i=1:B_total
           [Nt,j1] = plusjudge(K,a,B(:,i));
               if j1==1
                    j=j+1;N(:,:,j)=Nt;
               end
           end
       end
   end
   if j==0   %û�����ɵ��ӽڵ㣬���ؿվ���
           N=zeros(3,2);
   end
end