function [Nt,j] = plusjudge(K,a,B)
%函数功能：判断是否是先辈节点，判断是否野人会吃掉传教士
%输入：结构体序列K，要扩展的状态标号a，船的状态B
%输出：子状态（若有，没有为0矩阵）Nt，子状态个数（1或0）

j=0;

if K(a).State(1,1)>=B(1) && K(a).State(2,1)>=B(2) && K(a).State(3,1)==1 %left to right
   Nt=K(a).State;
   Nt(:,1)=Nt(:,1)-B;Nt(:,2)=Nt(:,2)+B;
   if (Nt(1,1)>=Nt(2,1)||Nt(1,1)==0) && (Nt(1,2)>=Nt(2,2)||Nt(1,2)==0)  %左岸传教士大于等于野人，右岸同,或者传教士人数为0
       if K(a).Ptr==0   %没有先辈节点
            j=1;
       else if isequal(K(K(a).Ptr).State,Nt)~=1 %与先辈节点不同
               j=1;
           end
       end
   end

else if K(a).State(1,2)>=B(1) && K(a).State(2,2)>=B(2) && K(a).State(3,2)==1  %right to left
   Nt=K(a).State;
   Nt(:,1)=Nt(:,1)+B;Nt(:,2)=Nt(:,2)-B;
   if (Nt(1,1)>=Nt(2,1)||Nt(1,1)==0) && (Nt(1,2)>=Nt(2,2)||Nt(1,2)==0)  %左岸传教士大于等于野人，右岸同,或者传教士人数为0
           if K(a).Ptr==0   %没有先辈节点
                j=1;
           else if isequal(K(K(a).Ptr).State,Nt)~=1 %与先辈节点不同
                   j=1;
               end
           end
   end
    else
        Nt=zeros(3,2);
    end
end
end