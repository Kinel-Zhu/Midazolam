%CYP3A4表达值 for neonate
age_n=[0.001,0.01,0.0493,0.3288,0.6164,3,18,0.0027];
fraction_n=[0.0913,0.123,0.301,0.346,0.438,1.08,1,0.066];

%CYP3A4表达值 for premature
age_p=[-0.479,-0.095,-0.077];
fraction_p=[0.062,0.0336,0.006];

%for neonate 指数拟合 fraction = Fbirth + (Fmax-Fbirth)* Agen/(Age50n+Agen)
[fitresult, gof] = fit(age_n',fraction_n', 'a+b*(x^c/(d+x^c))','Startpoint',[0.1 0.5 1 0.01] );

%for premature 线性拟合 fraction=a+b*Age
cftool
%or
t=polyfit(age_p,fraction_p,1);
plot(age_p,fraction_p,'*',age_p,polyval(t,age_p));