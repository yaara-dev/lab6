%Yaara Diamant Karasik & Karin Vardy
function []= plotSpikes(signal,peakTimes,sampleFreq,windSize)
%This function plots all the spikes on a given window size and plots the
%clustering for two different cells
milisec=44;
windSize=windSize*milisec;
peakTimes= round(peakTimes.*sampleFreq);
windMat=[];

figure(99)

for i= 1:length(peakTimes)
    startWind=peakTimes(i)-(0.5*windSize);
    endWind=peakTimes(i)+(0.5*windSize);
    if endWind>length(signal)
        endWind=length(signal);
    end
    if startWind<1
        startWind=1;
    end
    window=signal(startWind:endWind);
    windMat=[windMat;window];
    
    
    plot([1:length(window)],window);
    
    hold on
end

peakPoint=ceil(windSize/2);

stdVec=std(windMat);
[~,maxi]= findpeaks(stdVec(peakPoint:end));
maxi(1)=maxi(1)+peakPoint;
maxi(2)=maxi(2)+peakPoint;

figure(100)
plot((1:size(windMat,2)),std(windMat),'.-',(1:size(windMat,2)),mean(windMat),'.-');grid on
figure(101)
plot(windMat(:,maxi(1)),windMat(:,maxi(2)),'o');grid on


    
    
