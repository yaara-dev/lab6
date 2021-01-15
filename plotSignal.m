%Yaara Diamant Karasik & Karin Vardy

function []=plotSignal(fileName,sampleFreq,sampleFreqLFP)
%creating a structure to contain the data from the file
data=struct;
load(fileName);
data.rawData=CRAW_007;
data.spk=CSPK_007;
data.LFP=CLFP_007;
data.stimTime=stimTime;
%for the plot- ylim
minLim=min(data.rawData);
maxLim=max(data.rawData);

%x axis vector of time using the frequency 
time=0:1/sampleFreq:(length(data.rawData)/sampleFreq)-1/sampleFreq;
%x axis vector of time using the LFP frequency
timeLFP=0:1/sampleFreqLFP:(length(data.LFP)/sampleFreqLFP)-1/sampleFreqLFP;

figure
subplot(3,1,1)
%if there was a stimulus it will show the range it accured in time 
%and it's frequency (for each of the three signals)
for i=stimTime
line([i,i],[min(data.LFP),max(data.LFP)],'color','k')
end
hold on
%plot of the raw signal
plot(time,data.rawData,'m')
title('Raw Signal')
xlabel('Time [sec]')
ylabel('Amplitude [µV]')
ylim([minLim maxLim])
xlim([0 121])
%plot of the LFP signal
subplot(3,1,2)
for i=stimTime
line([i,i],[min(data.LFP),max(data.LFP)],'color','k')
end
hold on
plot(timeLFP,data.LFP,'g')
title('Low Frequencies LFP')
xlabel('Time [sec]')
ylabel('Amplitude [µV]')
xlim([0 121])
ylim([minLim maxLim])
%plot of the spk signal
subplot(3,1,3)
for i=stimTime
line([i,i],[min(data.LFP),max(data.LFP)],'color','k')
end
hold on
plot(time,data.spk,'c')
title('High Frequencies SPK')
xlabel('Time [sec]')
ylabel('Amplitude [µV]')
xlim([0 121])
ylim([minLim maxLim])