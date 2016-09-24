## This Script will read the data and create a barplot of the total amount of PM2.5 over time in Baltimore by type of pollutant

library(dplyr)
library(ggplot2)
filename ="fig3" 

# Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>% filter(.,fips == "24510") %>% 
  mutate(year=as.factor(year),type=as.factor(type)) %>% group_by(year,type)

Total_Emissions <- summarise(NEI,Total=sum(Emissions))
#plotting
ggplot(data=Total_Emissions, aes(x=year, y=Total, fill=type)) +
geom_bar(stat = "identity", color="black",position = position_dodge()) + 
ggtitle(label = "Baltimore PM2.5 Emissions from 1999-2008") +
ylab(label = "Tons of PM2.5 Emissions (Thousands)")+ scale_fill_discrete(name = "Pollutant Source")+ggsave(filename =sprintf( "~/Github/Exploratory-Data-Analysis/%s.pdf",filename))
dev.off()
