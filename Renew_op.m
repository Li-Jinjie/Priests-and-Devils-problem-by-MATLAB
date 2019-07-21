function opnew = Renew_op(id,op,isdeep)
%函数功能：更新open表
%输入：添加的标签号，open表
%输出：更新后的open表
%注，这个改成启发式算法不用管，因为启发式算法算最小值不看排序
if isdeep
    opnew=[id,op(1:end)]; %深度优先,people=3,计算了12个节点
else
    opnew=[op(1:end),id]; %广度优先,people=3,计算了15个节点
end
end