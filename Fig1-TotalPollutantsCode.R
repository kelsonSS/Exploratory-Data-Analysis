## This Script will read the data and create a barplot of the total amount of PM2.5 over time in Baltimore


library(dplyr)
filename= "fig1"

#Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>%  group_by(year) 
Total_Emissions<-summarise(NEI,Total=sum(Emissions))

#Plotting
pdf(file = sprintf("~/Github/Exploratory-Data-Analysis/%s", filename))
barplot(Total_Emissions$Total/1000000,names.arg = Total_Emissions$year,xlab="Year",
        ylab =" Tons of PM2.5 (Millions)", main = "US Total PM2.5 Pollution")
dev.off()

