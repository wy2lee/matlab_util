    figure
        imagesc(data_plot.image_big); axis image; axis off;
        text(10, 20, scan_type{count_scan},'FontSize',10,'Color',[1 1 1]);
        set(gca,'position',[0 0 1 1],'units','normalized');
        set(gcf,'inverthardcopy','off');
        %iptsetpref('ImshowBorder','tight');
        set(gcf,'PaperUnits','inches','PaperPosition',[0 0 1.5 1.5]);
        print('-dtiff','-r300',[scan_type{count_scan}]);
        
    %subplot('Position',[0.35, y_loc , 0.6, 0.22])
    figure
    plot(data_plot.wm.bins,100*data_plot.wm.hist/data_plot.wm.num,'k:','LineWidth',1.5);
    hold on
    plot(data_plot.gm.bins,100*data_plot.gm.hist/data_plot.gm.num,'k-','LineWidth',1.5);
    plot(data_plot.noise.bins,100*data_plot.noise.hist/data_plot.noise.num,'k--','LineWidth',1.5);
    hold off
    set(gca,'FontSize',4);
    title(scan_type{count_scan},'FontSize',8);
    ylabel('Percentage of voxels in ROI','FontSize',4);
    xlabel(xlabels{count_scan},'FontSize',4);
%    line([data_plot.wm.sig data_plot.wm.sig],[0 max(1.1*data_plot.wm.hist)],'Color','r','LineWidth',4);
%    line([data_plot.gm.sig data_plot.gm.sig],[0 max(1.1*data_plot.gm.hist)],'Color','g','LineWidth',4);
%    line([data_plot.noise.sig data_plot.noise.sig],[0 max(1.1*data_plot.noise.hist)],'Color','b','LineWidth',4);
    axis([min([data_plot.wm.values data_plot.gm.values]) max([data_plot.wm.values data_plot.gm.values]) 0 30])
    if strcmp(scan_type{count_scan},'ADC'),
        leg = legend(['WM'], ...
            ['Heterotopia'],...
            ['GM']);
        set(leg,'FontSize',3,'Location','northeast');
    end
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 1.5 1.5]);
    
    print('-dtiff','-r300',[scan_type{count_scan} '_hist']);
    