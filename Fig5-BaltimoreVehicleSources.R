## This Script will read the data and create a barplot of the total amount of PM2.5 over time in Baltimore for vehicle sources 

library(dplyr)
filename= "fig5.pdf"

# Cleaning- make sure the exdata_data_NEI_data-1 folder is your current Working Directory
VehicleSources<-readRDS("Source_Classification_Code.rds")%>%tbl_df() %>%filter(grepl("Vehicle",EI.Sector))
NEI <- readRDS("summarySCC_PM25.rds") %>% tbl_df() %>% filter(SCC %in% VehicleSources$SCC,fips == "24510" )  %>% group_by(year) 

Total_Emissions <- summarise(NEI,Total=sum(Emissions))
#plotting 
pdf(file =sprintf("~/Github/Exploratory-Data-Analysis/%s", filename ))
barplot(Total_Emissions$Total,names.arg = Total_Emissions$year,xlab="Year", ylab ="Tons of PM2.5", main = "Baltimore Total PM2.5 Vehicle Pollution")
dev.off()

