clear;close all;clc
sampleFreq=44000;
sampleFreqLFP=1000;
fileName='F19.mat';
load(fileName);
peakTimes=spikeDetection(fileName,sampleFreq);
signal= CSPK_007;
windSize=2;
[windMat,firstMax]=plotSpikes(signal,peakTimes,sampleFreq,windSize);
plotSignal(fileName,sampleFreq,sampleFreqLFP)