function h = get_h(S,Sg,set)
%�������ܣ�������ۺ���
%���룺����״̬S��Ŀ��״̬Sg
%���������ֵh
    method=set.method;
    if method == 1
    %���۷���1����һ���ĸ���
    A=S-Sg;
    A(A~=0)=1;
    h=sum(sum(A));
    else if method ==2
            %���۷���2����һ���������������;���ֵ
            A=S-Sg;
            A=abs(A);
            h=sum(sum(A));
        else if method ==3
            %���۷���3���Ƴ�����
            h=ceil((2*(S(1,1)+S(2,1))-(set.boat+1)*S(3,1))/(set.boat-1));
            else
                A=S(1:2,:)-Sg(1:2,:);
                A=abs(A);
                h=sum(sum(A));
            end
        end
    end
end
