% ���ܣ�����Ұ�˹������Ⲣ����ÿһ����״̬
clear;clc;

isqfs=1;  %1 ����ʽ��0 ���ʽ
method=2;  %1 ����λ������2 ������ֵ 3�� A*  4. ����������������ֵ 
isdeep=0; %1 �������DFS�� 0 �������BFS  ���ѡ������ʽ���ѡ��û��

num_cjs=8;  %����ʿ����
num_yr=8;   %Ұ������
num_boat=4; %��������
set=struct('cjs',num_cjs,'yr',num_yr,'boat',num_boat','method',method);

num_count=0;  %ͳ�Ƽ����˼����ڵ�
S(:,:,1)=[num_cjs,0;num_yr,0;1,0];  %man;beast;boatstate  left and right ��ʼ״̬ΪS1
Sg=[0,num_cjs;0,num_yr;0,1];
op=[];cl=[];  %��ʼ�� open ; closed
Lo=0; %length of open
Lc=0; %length of closed
id=1; %symbol ÿһ���ڵ�ı��
success=0; % if success, 1
Dp=0; %��ʾ��ǰ���������
fuDp=-1; %������ʼ����һ������
depth(1)=Dp;
M(1) = IniM(0,S(:,:,1),fuDp,Sg,set);  %��ʼ���������Ѿ�����f
%���ۺ���f(i)=h(i)+depth
%%
%�ѳ�ʼ�ڵ�S0����Open������f��S1��
op(1)=1;Lo=Lo+1;
%%
while(Lo~=0)   %��open��Ϊ�գ��˳�
   num_count=num_count+1; %���������һ
   %%
   if isqfs == 1
       %����ʽ�㷨����
       fmin=M(op(1)).f;  %fmin��open���һ��ֵ
       mintag=1;
       for i=1:Lo   %�ҳ����ۺ�����С��mintag,���fֵ��ͬѡ��һ��tag
           if M(op(i)).f<fmin
               fmin=M(op(i)).f;
               mintag=i;
           end
       end

       cl=[op(mintag),cl(1:end)];Lc=Lc+1; %����closed

       if mintag == 1           %����open
           op=op(mintag+1:end);
       else if mintag == Lo
           op=op(1:mintag-1);
           else 
           op=[op(1:mintag-1),op(mintag+1:end)];
           end
       end
       Lo=Lo-1; %��op���е�һ���ڵ����closed����
   %%
   else
%  ������ȣ��������ʱ����
        cl=[op(1),cl(1:end)];Lc=Lc+1; %����closed
        op=op(2:end);Lo=Lo-1; %��op���е�һ���ڵ����closed����
   end
   %%
   %�ж��Ƿ��˳���Ҫ��չ�ĺ������ɵ�
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
   [N,j]=plusyeah(M,cl(1),num_boat); %NΪ��Ҫ�жϵ������ɵ���״̬��jΪ���ɵ���״̬��
   if j == 0 %������չ ��һ��
       continue
   end
   fuDp=M(cl(1)).g;  %���ڵ����
   fuPtr=cl(1);      %���ڵ�ı��
  %%
   for q=1:j  %����������״̬
       iscopy=0;  %��ʾ�Ƿ���open���closed���ظ� 
       if Lo~=0   %���open��Ϊ��             
           for temp=1:Lo  %�������open��
               if isequal(M(op(temp)).State,N(:,:,q)) %�������״̬��open���е�һ��
                    iscopy=1; %ֻҪ��һ�£�iscopy=1
                    if M(op(temp)).g>fuDp+1  %�����·������Ƚ϶̣������Ϊ����ʽ�㷨Ҳ���ùܣ���Ϊ��ͬ״̬��fֵ�Ĳ����������  
                       M(op(temp))=IniM(fuPtr,M(op(temp)).State,fuDp,Sg,set); %�޸ķ���ָ�룬�޸����
                       op = Renew_op(op(temp),op,isdeep); Lo=Lo+1; %�Ż�open��ĳ���������㷨��һ���ĵط�
                   end
                   break; %ֻҪ�ҵ�һ�µģ�������open��Ѱ��ѭ��
               end
           end
            if iscopy
               continue;
            end
       end
           %%
           for temp=1:Lc  %�������closed��
               if isequal(M(cl(temp)).State,N(:,:,q)) %�������״̬��open���е�һ��
                      iscopy=1;
                    if M(cl(temp)).g>fuDp+1  %�����·������Ƚ϶�   
                       M(cl(temp))=IniM(fuPtr,M(cl(temp)).State,fuDp,Sg,set); %�޸ķ���ָ�룬�޸����
                       op=Renew_op(cl(temp),op,isdeep); Lo=Lo+1; %����open����������չ
                   end
                   break; %ֻҪ�ҵ�һ�µģ�������open��Ѱ��ѭ��
               end
           end           
           if iscopy
               continue;
           end
           %%
               id=id+1;  %����һ���ڵ�
               M(id)=IniM(fuPtr,N(:,:,q),fuDp,Sg,set);
               op=Renew_op(id,op,isdeep);Lo=Lo+1; %�Ż�open���ײ�������չ
           
    end
end
%%
%��ʾ

for i=1:id
    disp(['��ţ�',num2str(i)]);
    disp(['���ڵ��ţ�',num2str(M(i).Ptr)]);
    disp(['����f=',num2str(M(i).f)]);disp(['����h=',num2str(M(i).h)]);disp(['���g=',num2str(M(i).g)]);
    disp(M(i).State);%fprintf('%c%c', 8, 8);
end
disp(['����ڵ�����',num2str(num_count)]);
if success
    disp('Success!');
else
    disp('No solution!');
end

%treeplot(tree);��ͼ

tree=zeros(id-1,2);
juzhen=[' ״̬:',num2str(M(1).State(1,:)),';',num2str(M(1).State(2,:)),';',num2str(M(1).State(3,:))];
ChannelName(1)={['�ڵ�',num2str(0),', f=',num2str(M(1).f),', h=',num2str(M(1).h),', g=',num2str(M(1).g),juzhen]};
for i=2:id
    tree(i-1,1)=M(i).Ptr-1;
    tree(i-1,2)=i-1;
    juzhen=[' ״̬:',num2str(M(i).State(1,:)),';',num2str(M(i).State(2,:)),';',num2str(M(i).State(3,:))];
    ChannelName(i)={['�ڵ�',num2str(i-1),', f=',num2str(M(i).f),', h=',num2str(M(i).h),', g=',num2str(M(i).g),juzhen]};
end
cm = zeros(id);
for i = 1:id-1
   cm(tree(i,1)+1,tree(i,2)+1) = 1; 
end
bg1 = biograph(cm,ChannelName);
view(bg1);

