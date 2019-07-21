% 功能：计算野人过河问题并给出每一步的状态
clear;clc;

isqfs=1;  %1 启发式；0 穷举式
method=2;  %1 不在位个数；2 相差绝对值 3； A*  4. 不包含船的相差绝对值 
isdeep=0; %1 深度优先DFS； 0 广度优先BFS  如果选了启发式这个选项没用

num_cjs=8;  %传道士人数
num_yr=8;   %野人人数
num_boat=4; %船上人数
set=struct('cjs',num_cjs,'yr',num_yr,'boat',num_boat','method',method);

num_count=0;  %统计计算了几个节点
S(:,:,1)=[num_cjs,0;num_yr,0;1,0];  %man;beast;boatstate  left and right 初始状态为S1
Sg=[0,num_cjs;0,num_yr;0,1];
op=[];cl=[];  %初始化 open ; closed
Lo=0; %length of open
Lc=0; %length of closed
id=1; %symbol 每一个节点的标号
success=0; % if success, 1
Dp=0; %表示当前搜索的深度
fuDp=-1; %仅供初始化第一个矩阵
depth(1)=Dp;
M(1) = IniM(0,S(:,:,1),fuDp,Sg,set);  %初始化过程中已经计算f
%估价函数f(i)=h(i)+depth
%%
%把初始节点S0放入Open表，计算f（S1）
op(1)=1;Lo=Lo+1;
%%
while(Lo~=0)   %若open表为空，退出
   num_count=num_count+1; %计算次数加一
   %%
   if isqfs == 1
       %启发式算法启用
       fmin=M(op(1)).f;  %fmin是open表第一个值
       mintag=1;
       for i=1:Lo   %找出估价函数最小的mintag,多个f值相同选第一个tag
           if M(op(i)).f<fmin
               fmin=M(op(i)).f;
               mintag=i;
           end
       end

       cl=[op(mintag),cl(1:end)];Lc=Lc+1; %更新closed

       if mintag == 1           %更新open
           op=op(mintag+1:end);
       else if mintag == Lo
           op=op(1:mintag-1);
           else 
           op=[op(1:mintag-1),op(mintag+1:end)];
           end
       end
       Lo=Lo-1; %将op表中第一个节点放在closed表中
   %%
   else
%  深度优先，广度优先时启用
        cl=[op(1),cl(1:end)];Lc=Lc+1; %更新closed
        op=op(2:end);Lo=Lo-1; %将op表中第一个节点放在closed表中
   end
   %%
   %判断是否退出：要扩展的和新生成的
    if isequal(M(cl(1)).State,Sg) 
           success=1;
    end
   for i=1:Lo      
       if isequal(M(op(i)).State,Sg) 
           success=1;
           break
       end
   end
   
   if success
       break;
   end
   %%
   [N,j]=plusyeah(M,cl(1),num_boat); %N为需要判断的新生成的子状态，j为生成的子状态数
   if j == 0 %不可拓展 下一轮
       continue
   end
   fuDp=M(cl(1)).g;  %父节点深度
   fuPtr=cl(1);      %父节点的标号
  %%
   for q=1:j  %遍历所有新状态
       iscopy=0;  %表示是否与open表或closed表重复 
       if Lo~=0   %如果open表不为空             
           for temp=1:Lo  %检查所有open表
               if isequal(M(op(temp)).State,N(:,:,q)) %如果有子状态和open表中的一致
                    iscopy=1; %只要有一致，iscopy=1
                    if M(op(temp)).g>fuDp+1  %如果新路径的深度较短，这里改为启发式算法也不用管，因为相同状态，f值的差异在于深度  
                       M(op(temp))=IniM(fuPtr,M(op(temp)).State,fuDp,Sg,set); %修改返回指针，修改深度
                       op = Renew_op(op(temp),op,isdeep); Lo=Lo+1; %放回open表某处，各种算法不一样的地方
                   end
                   break; %只要找到一致的，就跳出open表寻找循环
               end
           end
            if iscopy
               continue;
            end
       end
           %%
           for temp=1:Lc  %检查所有closed表
               if isequal(M(cl(temp)).State,N(:,:,q)) %如果有子状态和open表中的一致
                      iscopy=1;
                    if M(cl(temp)).g>fuDp+1  %如果新路径的深度较短   
                       M(cl(temp))=IniM(fuPtr,M(cl(temp)).State,fuDp,Sg,set); %修改返回指针，修改深度
                       op=Renew_op(cl(temp),op,isdeep); Lo=Lo+1; %放入open表中重新拓展
                   end
                   break; %只要找到一致的，就跳出open表寻找循环
               end
           end           
           if iscopy
               continue;
           end
           %%
               id=id+1;  %增加一个节点
               M(id)=IniM(fuPtr,N(:,:,q),fuDp,Sg,set);
               op=Renew_op(id,op,isdeep);Lo=Lo+1; %放回open表首部重新扩展
           
    end
end
%%
%显示

for i=1:id
    disp(['标号：',num2str(i)]);
    disp(['父节点标号：',num2str(M(i).Ptr)]);
    disp(['估价f=',num2str(M(i).f)]);disp(['启发h=',num2str(M(i).h)]);disp(['深度g=',num2str(M(i).g)]);
    disp(M(i).State);%fprintf('%c%c', 8, 8);
end
disp(['计算节点数：',num2str(num_count)]);
if success
    disp('Success!');
else
    disp('No solution!');
end

%treeplot(tree);作图

tree=zeros(id-1,2);
juzhen=[' 状态:',num2str(M(1).State(1,:)),';',num2str(M(1).State(2,:)),';',num2str(M(1).State(3,:))];
ChannelName(1)={['节点',num2str(0),', f=',num2str(M(1).f),', h=',num2str(M(1).h),', g=',num2str(M(1).g),juzhen]};
for i=2:id
    tree(i-1,1)=M(i).Ptr-1;
    tree(i-1,2)=i-1;
    juzhen=[' 状态:',num2str(M(i).State(1,:)),';',num2str(M(i).State(2,:)),';',num2str(M(i).State(3,:))];
    ChannelName(i)={['节点',num2str(i-1),', f=',num2str(M(i).f),', h=',num2str(M(i).h),', g=',num2str(M(i).g),juzhen]};
end
cm = zeros(id);
for i = 1:id-1
   cm(tree(i,1)+1,tree(i,2)+1) = 1; 
end
bg1 = biograph(cm,ChannelName);
view(bg1);

