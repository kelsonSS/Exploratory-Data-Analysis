## This Script will read the data and create a plot of the Coal emissions over time in The US

library(dplyr)
library(ggplot2)
filename= "Fig4"

# Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
CoalSources<-readRDS("Source_Classification_Code.rds")%>%tbl_df() %>%filter(grepl("[cC]oal",Short.Name))

NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>%
  mutate(year=as.factor(year)) %>%  filter(SCC %in% CoalSources$SCC) %>% group_by(year)
    
  
Total_Emissions<-summarise(NEI,Total=sum(Emissions))
#plotting
pdf(file =sprintf("~/Github/Exploratory-Data-Analysis/%s",filename ))
barplot(Total_Emissions$Total/1000,names.arg = Total_Emissions$year,xlab="Year", ylab =" Tons of PM2.5 (Thousands)", main = "US Total PM2.5 Coal Pollution")
dev.off()