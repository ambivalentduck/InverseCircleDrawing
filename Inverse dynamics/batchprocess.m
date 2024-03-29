clc
clear all

for k=1:8
    ks=num2str(k)
   % try
        clear distCell indCell
        load(['./Data/',ks,'rta.mat']);
        subcells(k).distCell=distCell;
        subcells(k).matDist=matDist;
%     catch
%         try
%             disp(['Could not load sub',ks])
%             processCount(ks,10*k);
%         catch
%             disp('...And count process failed.')
%             addSubjectPlus(5ks);
%             makeParagons(ks);
%             processCount(ks,10*k);
%         end
%     end
end

time=-10*20:10:10*20;
gains=[.8 1 2 4 8 16];
subaves=zeros(length(subcells),length(gains),length(time));
for k=1 %:length(subcells)
    figure(k)
    clf

    for g=1:length(gains)
        subplot(length(gains),1,g)
        hold on

        for kk=1:length(time)
            subaves(k,g,kk)=mean(subcells(k).distCell{g,kk});
        end
            semilogy(time(kk)*ones(size(subcells(k).distCell{g,kk})),subcells(k).distCell{g,kk},'Color',[.5 .5 .5])
            %Have to go back to processCount in order to save the original
            %matrix with the -1s since you can't recover lines otherwise.
        %end
        semilogy(time,squeeze(subaves(k,g,:)),'r')
        ylabel(num2str(gains(g)))
    end
    xlabel('Time since Reset, ms');
    suplabel('Kp Gain','y');
    suplabel(['Reset-Triggered Distance Error: Sub#',num2str(k),', cm'],'t');
end

figure(length(subcells)+1)
clf
for g=1:length(gains)
    subplot(length(gains),1,g)
    hold on
    for k=1:length(subcells)
        plot(time,squeeze(subaves(k,g,:)),'Color',[.5 .5 .5])
    end
    for k=1:length(time)
        allMean(g,k)=mean(subaves(:,g,k));
    end
    plot(time,allMean(g,:),'r')
    ylabel(num2str(gains(g)))
end
xlabel('Time since Reset, ms');
suplabel('Kp Gain','y');
suplabel('Reset-Triggered Distance Error: Across-Subject Comparison and Mean, cm','t');

figure(length(subcells)+2)
clf
for g=1:length(gains)
    subplot(length(gains),1,g)
    hold on
    for k=1:length(subcells)
        normalizing=squeeze(subaves(k,g,:));
        normalizing=normalizing-min(normalizing);
        normalizing=normalizing/max(normalizing);
        plot(time,normalizing,'Color',[.5 .5 .5])
    end
    for k=1:length(time)
        allMean(g,k)=mean(subaves(:,g,k));
    end
    allMean(g,:)=allMean(g,:)-min(allMean(g,:));
    allMean(g,:)=allMean(g,:)/max(allMean(g,:));
    plot(time,allMean(g,:),'r')
    ylabel(num2str(gains(g)))
end
xlabel('Time since Reset, ms');
suplabel('Kp Gain','y');
suplabel('Reset-Triggered Distance Error: Normailized Across-Subject Comparison and Mean, cm','t');