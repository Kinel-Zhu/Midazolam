% 提数据
input=table2array(BPDATA(:,1:4));
onput=table2array(BPDATA(:,5));

%调用lasso函数，其中参数为（自变量x，因变量y，使用交叉验证，10折交叉验证，α，α=0为岭回归，α=1为lasso回归）
%返回值为（b：权重系数，fitinfo:模型信息）
[b,fitinfo] = lasso(input,onput,'CV',10,'Alpha',1);

%画图
axTrace = lassoPlot(b,fitinfo,'PlotType','Lambda','XScale','log');
%为图像添加图例，位置在图的右侧外面
legend('show','Location','EastOutside');
axCV = lassoPlot(b,fitinfo,'PlotType','CV');
%寻找最小误差对应的迭代次数
lam1SE = fitinfo.Index1SE;
%最小误差的值
mse_1=fitinfo.MSE(lam1SE);
%取最小误差对应的系数；b矩阵lam1SE列所有行
mat=b(:,lam1SE);
%寻找系数中的非零项（~=0为不等于0）
[row1SE, ] = find(b(:,lam1SE)~=0);
%计算原来的最小均方误差
rhat = input\onput;
res = input*rhat - onput;   
MSEmin_real= res'*res/325; 
%最小均方误差对应的迭代次数，上面误差是1se这里是mse
lamMinMSE = fitinfo.IndexMinMSE;
lamMinMSE = fitinfo.IndexMinMSE;
%主成分的系数
matMinMSE = b(:,lamMinMSE);  
%寻找非零自变量的下标（即主成分的下标）
[rowMinMSE, ] = find(b(:,lamMinMSE)~=0);
%两种计算误差方式使得所降成的维度不同，根据自己需求比较两个误差计算方式的差异选择留几个变量。
