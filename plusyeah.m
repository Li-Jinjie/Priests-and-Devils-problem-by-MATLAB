function [N,j] = plusyeah(K,a,num_boat)
%函数功能：生成子状态，去除掉与父节点相同的状态和吃人状态
%输入：结构体序列，要扩展的状态标号
%输出：生成的子状态序列N，子状态序列个数j，如果没有子状态j=0

   j=0; %表示生成的子节点数目 N为获取的新状态
   %%
   B_total=0;
   for i=1:num_boat  %船上总人数i
       for k=0:i    %传道士的数量k
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
       if j == 0    %表示不属于左岸，计算右岸；若左岸已有，则不算右岸
           for i=1:B_total
           [Nt,j1] = plusjudge(K,a,B(:,i));
               if j1==1
                    j=j+1;N(:,:,j)=Nt;
               end
           end
       end
   end
   if j==0   %没有生成的子节点，返回空矩阵
           N=zeros(3,2);
   end
end