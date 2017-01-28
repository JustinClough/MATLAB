%%
%Written for: Runs multinomial and Wilcoxon two-sample test on Watervliet
%survey data
%Written on: 12/16/2016
%Written by: Justin Clough

%% Import data from csv into workspace; seperate information

% NOTE:

%
fileNameIn = 'Reduced_Data.csv';
rawImport = csvread(fileNameIn);

q_pre = rawImport(:,2:8);
q_post = rawImport(:,10:16);


%% Prep data for Wilcoxon two-sample test

[lPre, wPre] = size(q_pre);
[lPost, wPost] = size(q_post);

if wPre~=wPost
    fprintf('Error: Number of presurvey questions not equal to post.\n')
    return
else
    width = wPre;
end

q_tot = [q_pre,q_post];
[lTot, wTot] = size(q_tot);

%% Run Wilcoxon Two-Sample Test

%variable ranks=(data type, response number, question number)
%   data type: 1=Response value, 2= original index, 3=source
%   (0=pre,1=post), 4=rank

for i=1:wTot; %for each question
    for j=1:(lTot) %for each response
        ranks(1,j,i) = q_tot(i,j);
    end
    clear j;
    [ranks(1,:,i), ranks(2,:,i)] = sort(ranks(1,:,i));
    for j=1:lTot
        if ranks(2,j,i)<=lPre
            ranks(3,j,i) = 0;
        else
            ranks(3,j,i) = 1;
        end
    end
    clear j;
    RankCount=1;
    Divider=1;
    for j=1:lTot
        if ranks(1,j,i) ==ranks(1,j+1,i);
            InstanceMembers(Divider) = j;
            InstanceMembers(Divider+1) = j+1;
            Divider=Divider+1;
        else
            for k=0:length(InstanceMembers)
                ThisRank = (RankCount+length(InstanceMembers))/Divider;
                ranks(4,j,i) = 
    
    
end


















