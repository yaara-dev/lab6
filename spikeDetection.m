%Yaara Diamant Karasik & Karin Vardy
function [peakTimes]=spikeDetection(fileName,sampleFreq)
%creating a structure to contain the data from the file
data=struct;
load(fileName);
data.rawData=CRAW_007;
data.spk=CSPK_007;
data.LFP=CLFP_007;
data.stimTime=stimTime;
%for the plot- ylim
minLim=min(data.spk);
maxLim=max(data.spk);
%x axis vector of time using the frequency 
time=0:1/sampleFreq:(length(data.rawData)/sampleFreq)-1/sampleFreq;
%we chose the spk signal to work with
amplitudePeaks=zeros(1,length(data.spk));
%we chose the threshold to be -500 microVolt
threshold=-600;
%filtering the over -500 microVolt values and only the peaks
for i=2:length(data.spk)-1
    if (data.spk(i)<data.spk(i-1))&&(data.spk(i)<data.spk(i+1))&&(data.spk(i)<threshold) 
       amplitudePeaks(i)=data.spk(i);
    end
end

figure
%plot of the spk signal
plot(time,data.spk,'c')
title('High Frequencies SPK')
xlabel('Time [sec]')
ylabel('Amplitude [µV]')
xlim([0 121])
ylim([minLim maxLim])
hold on
%we chose minISI to be 2 miliSeconds so with the frquency
%of 44000 for second, 88 is 2 miliSeconds
minISI=88;
peakVal=[];
peakInd=[];

%filtering only the peaks to a different variable 
for i=1:length(amplitudePeaks)
     if amplitudePeaks(i)~=0
         peakVal=[peakVal amplitudePeaks(i)];
         peakInd=[peakInd i];
     end
end

%applying the minISI filter and choosing the lower
%peak if there are more than one in the interval
for i=2:length(peakInd)
    if (peakInd(i)-peakInd(i-1))<minISI
        if peakVal(i)> peakVal(i-1)
            amplitudePeaks(peakInd(i))=0;
        elseif peakVal(i)<peakVal(i-1)
            amplitudePeaks(peakInd(i-1))=0;
        end
    end
end

%ploting the peaks after the filters
for i=1:length(amplitudePeaks)
    if amplitudePeaks(i)<0
        plot(time(i),amplitudePeaks(i),'r*')
        hold on
    end
end
xlim([0 121])

%creating the output vector in [sec]

peakTimes=(find(amplitudePeaks<0)).*(1/44000);
end