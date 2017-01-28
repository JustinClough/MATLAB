%%
%Written for: Decides which of 4 stats test is applicable (Wilcoxon Signed
%Rank Test, Paired t-Test, Mann Whitney U-Test, or Unpaired t-Test),
%performs test on data, and reports results to user.
%Written by: Justin Clough
%Written on: 01/20/2017

%% Prep Workspace

clear
close all
home
DIR = 'RPI_EA/'; %Uncommon_Charter_Stats/';
fileID = fopen( [DIR 'Statisticals_Results.txt'], 'w');

%% Import Data

%Request file name from User
fprintf(['Message to User: \nThe data must contain information organized against the following headers:\n'...
    'Member ID, Group Type 1, Group Type 2... Group Type N, Measure 1, Measure 2.\n'...
    '(Measure 2 is an optional column and tiggers pair-wise comparison)\n' ...
    '(If not all group types are needed, insert zeros for that column)\n' ...
    'File must not include anything but values (no letters or special characters).\n'...
    'File name must end in .csv (<example>.csv).\n'])

%Repeat for printing to results file
fprintf(fileID,['Message to User: \r\nThe data must contain information organized against the following headers:\r\n'...
    'Member ID, Group Type 1, Group Type 2... Group Type N, Measure 1, Measure 2.\r\n'...
    '(Measure 2 is an optional column and tiggers pair-wise comparison)\r\n' ...
    '(If not all group types are needed, insert zeros for that column)\r\n' ...
    'File must not include anything but values (no letters or special characters).\r\n'...
    'File name must end in .csv (<example>.csv).\r\n']);

%Non-present data flag set as '-1'

RawName = input('\nEnter name of data csv file:\n', 's');
fprintf(fileID, ['\r\nUser Reported File Name: ' RawName ' \r\n']);
GroupTypeCount = input('Enter number of Group Types: ');
fprintf(fileID, 'User Reported Number of Groups: %2.0f \r\n', GroupTypeCount);
%Load data from file
Data = csvread( RawName );


%% Preliminary analysis & Sorting

%Get meta data
[DataLength, DataWidth] = size(Data);

%Set Pairwise switch; infer measurement count
MeasureCount = DataWidth-1-GroupTypeCount;
if MeasureCount ~= 1
    PairwiseSwitch = 0;
    %If not only one measurement type is given, then infer that the user
    %wants a before/after (paired) test
elseif MeasureCount <= 0
    fprintf('No Measurement Data Entered')
    return;
else
    PairwiseSwitch = 1;
end

%Duplicate old data onto seperate matrix
OldGroups = Data(:,2:(GroupTypeCount+1));

%Count Sub Groups for each Group Type
for i=1:GroupTypeCount %For each group type
    UniqueEntries = OldGroups(1,i); %The first entry is unique
    for j=1:length(OldGroups(:,i)) %For each entry of each group type
        ThisEntry = OldGroups(j,i);
        %Compare this entry against all previous entries of the from the
        %same group type
        Count = 0;
        for k=1:length(UniqueEntries);
            if UniqueEntries(k)~= ThisEntry
                Count=Count+1;
            else
                %This entry is not unique :(
            end
        end
        clear k
        if Count == length(UniqueEntries)
            UniqueEntries(length(UniqueEntries)+1) = ThisEntry;
        end
    end
    clear j
    GCounter(i) = length(UniqueEntries);
    clear UniqueEntries
end
clear i

%Calculate Maximum number of possibly unique groups
TotalGroups = 1; %There must be atleast one indivisable group
for i=1:GroupTypeCount
    TotalGroups = TotalGroups*(GCounter(i)+1);
end
clear i

%Conglomerate group information
%GroupInfo(GroupType1 SubType, GroupType2 SubType, ...GroupTypeN SubType,
%First group member ID, Second, ... Pth member ID, mean 1, standard
%deviation 1, mean 2 (if applicable), standard deviation 2 (if appl.))

%Construct group information
tc=zeros(1,GroupTypeCount);
for i=1:TotalGroups
    for j=1:GroupTypeCount
        GroupInfo(i,j) = tc(j);
    end
    clear j
    tc(GroupTypeCount) = tc(GroupTypeCount)+1;
    j=GroupTypeCount;
    while j>0
        if tc(j)>GCounter(j)
            tc(j) = 0;
            if j~=1
                tc(j-1) = tc(j-1)+1;
            end
        end
        j=j-1;
    end
    clear j
end
clear tc i

%Sort each group indirectly; Collect ID numbers to act as group pointers
for i=1:TotalGroups
    ThisType = GroupInfo(i,1:GroupTypeCount); %Type information for current selection
    index = GroupTypeCount+1;
    for j=1:DataLength
        CCount = 0;
        for k=1:GroupTypeCount
            if (ThisType(k)==0) || (ThisType(k) == Data(j,k+1))
                CCount = CCount+1;
            else
                %This member is not part of the group in question
            end
        end
        clear k
        if CCount == GroupTypeCount
            GroupInfo(i,index) = Data(j,1); %Store member ID to appropriate Group
            index = index+1;
        end
    end
    clear j CCount
end
clear index i ThisType

%Find mean and Standard Deviation for each group
GroupMeasures = -1*ones(TotalGroups, DataLength, MeasureCount);
for i=1:TotalGroups
    for j=1:MeasureCount
        GIWriteIndex = GroupTypeCount+DataLength+j;
        ReadIndex = GroupTypeCount+1;
        m = 1;
        while (ReadIndex <= (GroupTypeCount+DataLength))
            if GroupInfo(i,ReadIndex) ~= 0
                for k=1:DataLength
                    if (GroupInfo(i,ReadIndex) == Data(k,1)) %&& (Data(k,1+GroupTypeCount+j)~=-1)
                        GroupMeasures(i,m,j) = Data(k,1+GroupTypeCount+j);
                        m=m+1;
                    end
                end
            end
            ReadIndex = ReadIndex+1;
        end
        if GroupMeasures(i,1,j) == -1;
            %Empty group: therefore no mean or standard deviation
        else
            ThisMean = mean(GroupMeasures(i,:,j));
            ThisStDev = std(GroupMeasures(i,:,j));
            GroupInfo(i, GIWriteIndex) = ThisMean;
            GroupInfo(i, GIWriteIndex+MeasureCount) = ThisStDev;
        end
    end
end
clear i j k m N ReadIndex GIWriteIndex ThisMean

%% Check for Normativity

fprintf(fileID,'\r\nResults from Goodness-of-Fit (GoF) Test. \r\n');
fprintf(fileID,'Test Parameters: \r\nLevel of Significance at 5%% \r\nNull Hyp(0): Normal Distributions.\r\nAlt Hyp(1): Not Normal.\r\n\r\n');
%Apply Goodness-of-Fit test for each population to check for normaltivity.
%H0 = Normally distributed; H1 = Not Normally distributed
%Record result as Normal=0, Not=1 format along appended column to GroupInfo
for i=1:TotalGroups     %For each group
    for k = 1:MeasureCount  %For each measurement Type
        j = 1;
        if GroupMeasures(i,j,k) == -1
            TheseMeasures = -1;
        else
            q=1;
            while (j<=DataLength)    %While measure is within the range
                %Record non-null measurements into TheseMeasures
                if (GroupMeasures(i,j,k) ~= -1)
                    TheseMeasures(q) = GroupMeasures(i,j,k);
                    q=q+1;
                end
                j = j+1;
            end
        end
        clear j
        if TheseMeasures == -1;
            %Empty group
        else
            [h,p] = chi2gof(TheseMeasures);
            if isnan(p) == 1
                h=1;
                p=-1;
                %Groups with not enought members (degrees of freedom) are
                %assumed to be not normal
            end
            GroupNorma(i,1,k) = h;
            GroupNorma(i,2,k) = p;
        end
        if h == 1 && p ~= -1
            %h=1 is rejection of the null hyp (not-normal)
            fprintf(fileID, 'Groupset %2.0f Failed GoF for Measurement number %2.0f (p=%5.4f).\r\n', i,k,p);
        elseif h ==1 && p==-1
            fprintf(fileID, ...
                'Groupset %2.0f has insufficient members for Measurement number %2.0f: Assume Non-Normal.\r\n', i, k);
        elseif h==0
            %h=0 is failure to reject the null hyp: (normal)
            fprintf(fileID, 'Groupset %2.0f Passed GoF for Measurement number %2.0f (p=%5.4f).\r\n', i,k,p);
        end
        clear TheseMeasures
    end
end
clear i k m TD

%% Build Results matrix

%GroupResults(First Group set #, Second Group set #, Test type #, h, p)
%Test Type #'s:
%1 = Paired t-test
%2 = Regular t-test
%3 = Wilcoxon Signed-Rank test
%4 = Wilcoxon RankSum (Mann-Whitney U) test

TotalComp = 0;
j=1;
for i = 1:TotalGroups+1
    HomeSet = i-1;
    AwaySet = HomeSet;
    while (AwaySet < TotalGroups)
        GroupResults(j,1) = HomeSet;
        GroupResults(j,2) = AwaySet;
        AwaySet= AwaySet+1;
        j= j+1;
        TotalComp = TotalComp+1;
    end
end
clear i j HomeGroup AwayGroup

%% IFF Normal & Paired: Paired t-test

fprintf(fileID,'\r\nResults from Paired t-test Test. \r\n');
fprintf(fileID,'Test Parameters: \r\nLevel of Significance at 5%% \r\nNull Hyp(0): Groups means are equal.\r\nAlt Hyp(1): Groups not equal.\r\n\r\n');
PtTest =0;
if PairwiseSwitch == 0
    for i=1:TotalComp
        HomeSet = GroupResults(i,1);
        AwaySet = GroupResults(i,2);
        if (HomeSet == AwaySet)
            if (GroupNorma(HomeSet+1,1)~=1) && (GroupNorma(AwaySet+1,1)~=1)
                %Since testing is pairwise, only 'Before' and 'After' instances
                %of the same group sets and be compared
                
                %Construct First set of measurements
                j = 1;
                if GroupMeasures(HomeSet+1,j,1) == -1
                    TheseMeasures1 = NaN;
                else
                    q=1;
                    while (j<=DataLength)    %While measure is within the range
                        %Record non-null measurements into TheseMeasures
                        if (GroupMeasures(HomeSet+1,j,1) ~= -1)
                            TheseMeasures1(q) = GroupMeasures(HomeSet+1,j,1);
                            q=q+1;
                        else
                            TheseMeasure1(q) = NaN;
                            q=q+1;
                        end
                        j = j+1;
                    end
                end
                clear j
                %Construct Second set of measurements
                j = 1;
                if GroupMeasures(AwaySet+1,j,2) == -1
                    TheseMeasures2 = NaN;
                else
                    q=1;
                    while (j<=DataLength)    %While measure is within the range
                        %Record non-null measurements into TheseMeasures
                        if (GroupMeasures(AwaySet+1,j,2) ~= -1)
                            TheseMeasures2(q) = GroupMeasures(AwaySet+1,j,2);
                            q=q+1;
                        else
                            TheseMeasure2(q) = NaN;
                            q=q+1;
                        end
                        j = j+1;
                    end
                end
                clear j
                if TheseMeasures1(1) == -1 || TheseMeasures2(1) == -1
                    %Empty group
                else
                    %Run test and record results
                    [h,p] = ttest(TheseMeasures1,TheseMeasures2);
                    GroupResults(i,4) = h;
                    GroupResults(i,5) = p;
                    GroupResults(i,3) = 1; %record which test (paired-t = 1)
                    %was performed
                    PtTest = 1;
                end
                if h == 1
                    fprintf(fileID, 'Group Comparison %2.0f Failed paired t-test (p=%5.4f).\r\n', i,p);
                else
                    fprintf(fileID, 'Group Comparison %2.0f Passed paired t-test (p=%5.4f).\r\n', i,p);
                end
                clear TheseMeasures1 TheseMeasures2
            end
        end
        
    end
end
if PtTest == 0
    fprintf(fileID, 'No paired t-test Performed.\r\n');
end


%% IFF Normal & Not-Paired: Regular t-test

fprintf(fileID,'\r\nResults from Non-Paired t-test Test. \r\n');
fprintf(fileID,'Test Parameters: \r\nLevel of Significance at 5%% \r\nNull Hyp(0): Groups means are equal.\r\nAlt Hyp(1): Groups not equal.\r\n\r\n');
UnPtTest = 0;
for i=1:TotalComp
    HomeSet = GroupResults(i,1);
    AwaySet = GroupResults(i,2);
    if (HomeSet ~= AwaySet) && (GroupNorma(HomeSet+1,1)~=1) && (GroupNorma(AwaySet+1,1)~=1)
        %Since testing is pairwise, only 'Before' and 'After' instances
        %of the same group sets and be compared
        
        %Construct First set of measurements
        j = 1;
        if GroupMeasures(HomeSet+1,j,1) == -1
            TheseMeasures1 = NaN;
        else
            q=1;
            while (j<=DataLength)    %While measure is within the range
                %Record non-null measurements into TheseMeasures
                if (GroupMeasures(HomeSet+1,j,1) ~= -1)
                    TheseMeasures1(q) = GroupMeasures(HomeSet+1,j,1);
                    q=q+1;
                else
                    TheseMeasure1(q) = NaN;
                    q=q+1;
                end
                j = j+1;
            end
        end
        clear j
        %Construct Second set of measurements
        j = 1;
        if GroupMeasures(AwaySet+1,j,1) == -1
            TheseMeasures2 = NaN;
        else
            q=1;
            while (j<=DataLength)    %While measure is within the range
                %Record non-null measurements into TheseMeasures
                if (GroupMeasures(AwaySet+1,j,1) ~= -1)
                    TheseMeasures2(q) = GroupMeasures(AwaySet+1,j,1);
                    q=q+1;
                else
                    TheseMeasure2(q) = NaN;
                    q=q+1;
                end
                j = j+1;
            end
        end
        clear j
        if TheseMeasures1(1) == -1 || TheseMeasures2(1) == -1
            %Empty group
        else
            %Run test and record results
            [h,p] = ttest2(TheseMeasures1,TheseMeasures2);
            GroupResults(i,4) = h;
            GroupResults(i,5) = p;
            GroupResults(i,3) = 2; %record which test (unpaired-t = 2)
            %was performed
            UnPtTest = 1;
        end
        if h == 1
            fprintf(fileID, 'Group Comparison %2.0f Failed non-paired t-test (p=%5.4f).\r\n', i,p);
        else
            fprintf(fileID, 'Group Comparison %2.0f Passed non-paired t-test (p=%5.4f).\r\n', i,p);
        end
        clear TheseMeasures1 TheseMeasures2
    end
end
if UnPtTest == 0
    fprintf(fileID, 'No non-paired t-test Performed.\r\n');
end

%% IFF Not Normal & Paired: Wilcoxon Signed Rank Test

fprintf(fileID,'\r\nResults from Wilcoxon Signed Rank Test. \r\n');
fprintf(fileID,'Test Parameters: \r\nLevel of Significance at 5%% \r\nNull Hyp(0): Groups means are equal.\r\nAlt Hyp(1): Groups not equal.\r\n\r\n');
WilSignStat = 0;

if PairwiseSwitch == 0
    for i=1:TotalComp
        HomeSet = GroupResults(i,1);
        AwaySet = GroupResults(i,2);
        if (HomeSet == AwaySet) && (GroupNorma(HomeSet+1,1)==1) && (GroupNorma(AwaySet+1,1)==1)
            %Since testing is pairwise, only 'Before' and 'After' instances
            %of the same group sets and be compared
            
            %Construct First set of measurements
            j = 1;
            if GroupMeasures(HomeSet+1,j,1) == -1
                TheseMeasures1 = NaN;
            else
                q=1;
                while (j<=DataLength)    %While measure is within the range
                    %Record non-null measurements into TheseMeasures
                    if (GroupMeasures(HomeSet+1,j,1) ~= -1)
                        TheseMeasures1(q) = GroupMeasures(HomeSet+1,j,1);
                        q=q+1;
                    else
                        TheseMeasure1(q) = NaN;
                        q=q+1;
                    end
                    j = j+1;
                end
            end
            clear j
            %Construct Second set of measurements
            j = 1;
            if GroupMeasures(AwaySet+1,j,2) == -1
                TheseMeasures2 = NaN;
            else
                q=1;
                while (j<=DataLength)    %While measure is within the range
                    %Record non-null measurements into TheseMeasures
                    if (GroupMeasures(AwaySet+1,j,2) ~= -1)
                        TheseMeasures2(q) = GroupMeasures(AwaySet+1,j,2);
                        q=q+1;
                    else
                        TheseMeasure2(q) = NaN;
                        q=q+1;
                    end
                    j = j+1;
                end
            end
            clear j
            if TheseMeasures1(1) == -1 || TheseMeasures2(1) == -1
                %Empty group
            else
                %Run test and record results
                [p,h] = signrank(TheseMeasures1,TheseMeasures2);
                GroupResults(i,4) = h;
                GroupResults(i,5) = p;
                GroupResults(i,3) = 3; %record which test (Singed Rank = 3)
                %was performed
                WilSignStat = 1;
            end
            if h == 1
                fprintf(fileID, 'Group Comparison %2.0f Failed Wilcoxon Signed Rank Test (p=%5.4f).\r\n', i,p);
            else
                fprintf(fileID, 'Group Comparison %2.0f Wilcoxon Signed Rank Test (p=%5.4f).\r\n', i,p);
            end
            clear TheseMeasures1 TheseMeasures2
        end
    end
end

if WilSignStat == 0;
    fprintf(fileID, 'No Wilcoxon Signed Rank Tests Performed.\r\n');
end

%% IFF Not Normal & Not Paired: Wilcoxon Rank Sum (Mann Whityney U) test

fprintf(fileID,'\r\nResults from Mann Whitney U-Test. \r\n');
fprintf(fileID,'Test Parameters: \r\nLevel of Significance at 5%% \r\nNull Hyp(0): Groups means are equal.\r\nAlt Hyp(1): Groups not equal.\r\n\r\n');
MannWhitStat = 0;

for i=1:TotalComp
    HomeSet = GroupResults(i,1);
    AwaySet = GroupResults(i,2);
    if (HomeSet ~= AwaySet) && (GroupNorma(HomeSet+1,1)==1) && (GroupNorma(AwaySet+1,1)==1)
        %Since testing is pairwise, only 'Before' and 'After' instances
        %of the same group sets and be compared
        
        %Construct First set of measurements
        j = 1;
        if GroupMeasures(HomeSet+1,j,1) == -1
            TheseMeasures1 = NaN;
        else
            q=1;
            while (j<=DataLength)    %While measure is within the range
                %Record non-null measurements into TheseMeasures
                if (GroupMeasures(HomeSet+1,j,1) ~= -1)
                    TheseMeasures1(q) = GroupMeasures(HomeSet+1,j,1);
                    q=q+1;
                else
                    TheseMeasure1(q) = NaN;
                    q=q+1;
                end
                j = j+1;
            end
        end
        clear j
        %Construct Second set of measurements
        j = 1;
        if GroupMeasures(AwaySet+1,j,1) == -1
            TheseMeasures2 = NaN;
        else
            q=1;
            while (j<=DataLength)    %While measure is within the range
                %Record non-null measurements into TheseMeasures
                if (GroupMeasures(AwaySet+1,j,1) ~= -1)
                    TheseMeasures2(q) = GroupMeasures(AwaySet+1,j,1);
                    q=q+1;
                else
                    TheseMeasure2(q) = NaN;
                    q=q+1;
                end
                j = j+1;
            end
        end
        clear j
        if TheseMeasures1(1) == -1 || TheseMeasures2(1) == -1
            %Empty group
        else
            %Run test and record results
            [p,h] = ranksum(TheseMeasures1,TheseMeasures2);
            GroupResults(i,4) = h;
            GroupResults(i,5) = p;
            GroupResults(i,3) = 4; %record which test (Rank Sum (mann-whit) = 4)
            %was performed
            MannWhitStat = 1;
        end
        if h == 1
            fprintf(fileID, 'Group Comparison %2.0f Failed Mann Whitney U-Test (p=%5.4f).\r\n', i,p);
        else
            fprintf(fileID, 'Group Comparison %2.0f Passed Mann Whitney U-Test (p=%5.4f).\r\n', i,p);
        end
        clear TheseMeasures1 TheseMeasures2
    end
end


if MannWhitStat == 0;
    fprintf(fileID, 'No Mann Whitney U-Tests Performed.\r\n');
end

%% All Testing Complete. Summarize & Close open app.s

fprintf(fileID,'

fclose(fileID);
open Statisticals_Results.txt