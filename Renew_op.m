function opnew = Renew_op(id,op,isdeep)
%�������ܣ�����open��
%���룺��ӵı�ǩ�ţ�open��
%��������º��open��
%ע������ĳ�����ʽ�㷨���ùܣ���Ϊ����ʽ�㷨����Сֵ��������
if isdeep
    opnew=[id,op(1:end)]; %�������,people=3,������12���ڵ�
else
    opnew=[op(1:end),id]; %�������,people=3,������15���ڵ�
end
end