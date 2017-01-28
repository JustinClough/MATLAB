%Runs an ANOVA Test based on known samples
clear
clc

Comparisons=input('Number of comparisons: ');

%User inputs sample data
yn=2;
while yn==2
    for i=1:Comparisons
        fprintf('For Sample set %.0f, input number of data points:',i')
        n(i)=input('');
        fprintf('For Sample set %.0f :\n',i')
        for j=1:n(i)
            fprintf('Enter data point number %.0f:',j)
            SampelSet(i,j)=input(' ');
        end
        clc
    end
    transpose(SampelSet)
    yn=input('Is this correct? 1 for yes, 2 for no: ');
end

%W=within, B=between, t=total

%degrees of freedom calculations:
dfb=Comparisons-1;
dft=sum(n)-1;
dfw=dft-dfb;

%Sum of squares calc
straightsum=sum(sum(SampelSet));
squaredsum=sum(sum(SampelSet.^2));
SST=squaredsum-(straightsum)^2/sum(n);

for k=1:i
    weightedVar(k)=(var(SampelSet(k,:)))*(n(k)-1);
    weight(k)=n(k)-1;
end

WMS=sum(weightedVar)/sum(weight);
SSW=dfw*WMS;
SSB=SST-SSW;
BMS=SSB*dfb;

ANOVA_Table=[SSB, dfb, BMS; SSW, dfw, WMS; SST, dft, 0]
F_value=BMS/WMS