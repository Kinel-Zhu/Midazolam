% 提数据 补一个随机分割，不用补
input=table2array(BPDATA(:,1:4));
onput=table2array(BPDATA(:,5));
input_Vali=table2array(BPDATA(308:440,1:4));
onput_Vali=table2array(BPDATA(308:440,5));
class(input)
class(onput)
class(input_Vali)
class(onput_Vali)
input_1=input.';
onput_1=onput.';
input_Vali_1=input_Vali.';
onput_Vali_1=onput_Vali.';
% 数据转换
in=mapminmax(input_1);
out=mapminmax(onput_1);
in_Vali=mapminmax(input_Vali_1);
%out_Vali=sim(bp_net,in_Vali_1);
%搭建BP模型
bp_net=newff(in,out,[72,48,36,36,24,24,16,16,8,8],{'tansig','tansig','purelin'},'trainlm');
%最大训练步数和网络误差准则
bp_net.trainParam.epochs=100;
bp_net.trainParam.goad=0.0001;
%训练模型
bp_net = train(bp_net,in,out);

%bp_net=newff(in,out,[36,24,16,8]);bp_net = train(bp_net,in,out);

%


