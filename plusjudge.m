function [Nt,j] = plusjudge(K,a,B)
%�������ܣ��ж��Ƿ����ȱ��ڵ㣬�ж��Ƿ�Ұ�˻�Ե�����ʿ
%���룺�ṹ������K��Ҫ��չ��״̬���a������״̬B
%�������״̬�����У�û��Ϊ0����Nt����״̬������1��0��

j=0;

if K(a).State(1,1)>=B(1) && K(a).State(2,1)>=B(2) && K(a).State(3,1)==1 %left to right
   Nt=K(a).State;
   Nt(:,1)=Nt(:,1)-B;Nt(:,2)=Nt(:,2)+B;
   if (Nt(1,1)>=Nt(2,1)||Nt(1,1)==0) && (Nt(1,2)>=Nt(2,2)||Nt(1,2)==0)  %�󰶴���ʿ���ڵ���Ұ�ˣ��Ұ�ͬ,���ߴ���ʿ����Ϊ0
       if K(a).Ptr==0   %û���ȱ��ڵ�
            j=1;
       else if isequal(K(K(a).Ptr).State,Nt)~=1 %���ȱ��ڵ㲻ͬ
               j=1;
           end
       end
   end

else if K(a).State(1,2)>=B(1) && K(a).State(2,2)>=B(2) && K(a).State(3,2)==1  %right to left
   Nt=K(a).State;
   Nt(:,1)=Nt(:,1)+B;Nt(:,2)=Nt(:,2)-B;
   if (Nt(1,1)>=Nt(2,1)||Nt(1,1)==0) && (Nt(1,2)>=Nt(2,2)||Nt(1,2)==0)  %�󰶴���ʿ���ڵ���Ұ�ˣ��Ұ�ͬ,���ߴ���ʿ����Ϊ0
           if K(a).Ptr==0   %û���ȱ��ڵ�
                j=1;
           else if isequal(K(K(a).Ptr).State,Nt)~=1 %���ȱ��ڵ㲻ͬ
                   j=1;
               end
           end
   end
    else
        Nt=zeros(3,2);
    end
end
end