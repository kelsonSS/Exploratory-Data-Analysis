## This Script will read the data and create a barplot of the total amount of PM2.5 over time in Baltimore

library(dplyr)
filename= "fig2.pdf"

#Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>% filter(.,fips == "24510")  %>% group_by(year) 

Total_Emissions <- summarise(NEI,Total=sum(Emissions))
#plotting
pdf(file =sprintf("~/Github/Exploratory-Data-Analysis/%s", filename ))
barplot(Total_Emissions$Total/1000,names.arg = Total_Emissions$year,xlab="Year", ylab ="Tons of PM2.5(Thousands)", main = "Baltimore Total PM2.5 Pollution")
dev.off()

