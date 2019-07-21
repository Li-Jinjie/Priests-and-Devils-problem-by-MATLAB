function h = get_h(S,Sg,set)
%函数功能：计算估价函数
%输入：现在状态S，目标状态Sg
%输出：估价值h
    method=set.method;
    if method == 1
    %估价方法1，不一样的个数
    A=S-Sg;
    A(A~=0)=1;
    h=sum(sum(A));
    else if method ==2
            %估价方法2，不一样的数字相减，求和绝对值
            A=S-Sg;
            A=abs(A);
            h=sum(sum(A));
        else if method ==3
            %估价方法3，推出来的
            h=ceil((2*(S(1,1)+S(2,1))-(set.boat+1)*S(3,1))/(set.boat-1));
            else
                A=S(1:2,:)-Sg(1:2,:);
                A=abs(A);
                h=sum(sum(A));
            end
        end
    end
end
