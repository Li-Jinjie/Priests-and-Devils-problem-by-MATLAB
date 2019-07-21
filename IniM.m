function M = IniM(fuPtr,A,fuDp,Sg,set)
%函数功能：为M初始化
%输入：父标号，状态值，父节点的深度，h值
%输出：初始化的结构体M
h=get_h(A,Sg,set);
Dp=fuDp+1; %现有深度比父节点加一
M=struct('Ptr',fuPtr,'State',A,'f',h+Dp,'h',h,'g',Dp);
end
