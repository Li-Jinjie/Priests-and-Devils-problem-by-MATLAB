function M = IniM(fuPtr,A,fuDp,Sg,set)
%�������ܣ�ΪM��ʼ��
%���룺����ţ�״ֵ̬�����ڵ����ȣ�hֵ
%�������ʼ���Ľṹ��M
h=get_h(A,Sg,set);
Dp=fuDp+1; %������ȱȸ��ڵ��һ
M=struct('Ptr',fuPtr,'State',A,'f',h+Dp,'h',h,'g',Dp);
end
