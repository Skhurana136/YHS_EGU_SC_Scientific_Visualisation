#CAMELS GB plotting examples

library(dplyr)
library(ggplot2)

path_to_files = "C:/Users/stein/Nextcloud/YHS/DataVisShortCourse/plotting_data/"
setwd(path_to_files)


timeseries_station <- read.csv("CAMELS_GB_hydromet_timeseries_27003_19701001-20150930.csv")
#load lat long data
station_topographic <- read.csv("CAMELS_GB_topographic_attributes.csv")

station_landcover <- read.csv("CAMELS_GB_landcover_attributes.csv")

station_join = merge(station_topographic, station_landcover, by = "gauge_id")



##### Categorical scatterplot ##### 

#decidous forest percentage against elevation coloured by land cover
p1 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()

#add labels
p2 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")

#Change colour and label legend
tol6qualitative=c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677","#AA4499")
#Source: https://www.r-bloggers.com/2013/02/the-paul-tol-21-color-salute/

p3 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land cover")

#Increase point size
p4 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point(size = 2)+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land cover")

#change theme 
#full theme plotting options: https://ggplot2.tidyverse.org/reference/ggtheme.html
p5 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point(size = 2)+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land use")+theme_minimal()

#split into multiple smaller plots
p6 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land cover")+theme_minimal()+facet_wrap(~dom_land_cover)

#remove legend
p7 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land cover")+theme_minimal()+facet_wrap(~dom_land_cover)+theme(legend.position ="none")

#choose theme according to preference
p8 = ggplot(station_join, aes(x = dwood_perc, y = elev_mean, col = dom_land_cover))+geom_point()+xlab("Percentage deciduous woods [%]")+ylab("Catchment mean elevation [m.a.s.l.]")+scale_colour_manual(values=tol6qualitative, name = "Land cover")+theme_bw()+facet_wrap(~dom_land_cover)+theme(legend.position ="none")

plotlist = list(p1, p2, p3, p4, p5, p6, p7, p8)
for(i in c(1:7)){
  ggsave(file = paste0("C:/Users/stein/Nextcloud/YHS/DataVisShortCourse/plot_categorical_", i, ".pdf"), plot = plotlist[[i]],dpi = "retina", width = 8, height = 5 )
}


