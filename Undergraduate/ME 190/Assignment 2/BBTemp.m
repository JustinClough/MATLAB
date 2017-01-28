function Temp=BBTemp(t);
Temp(1)=(1000-60)*exp(-t(1)/60)+60;
Temp(2)=(1000-60)*exp(-t(2)/60)+60;
Temp(3)=(1000-60)*exp(-t(3)/60)+60;