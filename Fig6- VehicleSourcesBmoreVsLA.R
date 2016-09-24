## This Script will read the data and create a barplot of the total amount of PM2.5 over time in Baltimore by type of pollutant

library(dplyr)
library(ggplot2)
filename ="fig6" 

# Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
VehicleSources<-readRDS("Source_Classification_Code.rds")%>%tbl_df() %>%filter(grepl("Vehicle",EI.Sector))
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>% filter(.,fips %in%  c("24510","06037"),SCC %in%VehicleSources$SCC) %>% 
  mutate(year=as.factor(year),type=as.factor(fips)) %>% group_by(year,fips)

Total_Emissions <- summarise(NEI,Total=sum(Emissions))
#plotting
ggplot(data=Total_Emissions, aes(x=year, y=Total, fill=fips)) +
  geom_bar(stat = "identity", color="black",position = position_dodge()) + 
  ggtitle(label = "Vehicle PM2.5 Emissions from 1999-2008") +
  ylab(label = "Tons of PM2.5 Emissions")+ 
  scale_fill_discrete(name = "City", breaks=c("24510","06037"),labels =c("Baltimore", "LA County"))+
  ggsave(filename =sprintf( "~/Github/Exploratory-Data-Analysis/%s.pdf",filename))
dev.off()
