library(readxl)
library(writexl)
library(stringr)
library(dplyr)

## GBIF_CPNWH_DWC-Combine.xlsx consists of all records from the GBIF and CPNWH 
### source datasets (from Andrew/IMERSS), combined into one spreadsheet and 
### converted into Darwin-core format.
data <- read_excel(".../GBIF_CPNWH_DWC-Combine.xlsx", sheet="Sheet2") ##update path as needed
data <- as.data.frame(data)

## Assign a duplication ID number to records with the same Catalogue.Number
## Duplicate records have a duplication_id number > 1
data1 <- data %>% 
  group_by(Catalogue.Number) %>% 
  mutate(duplication_id = seq(n())) %>% 
  ungroup ()

## Assign a duplication ID number to records with the same Collector.Number
## Duplicate records have a duplication_id2 number > 1
data2 <- data1 %>% 
  group_by(Collector.Number) %>% 
  mutate(duplication_id2 = seq(n())) %>% 
  ungroup ()

## Create a string variable "hash", which concatenates together 7 key identifying variables
### (scientificName, basisOfRecord, year, month, day, decimalLatitude, decimalLongitude)
## Assign a duplication ID number to records with the same "hash" variable
## Duplicate records have a duplication_id3 number > 1
data3 <- data2 %>% 
  mutate(hash = str_c(scientificName, basisOfRecord, year, month, day, decimalLatitude, decimalLongitude)) %>%
  group_by(hash) %>% 
  mutate(duplication_id3 = seq(n())) %>% 
  ungroup ()

write_xlsx(data3, ".../GBIF_CPNWH_Compared_CHECK.xlsx")  # update save location


## Keep only the rows that have different catalogue AND collector numbers
### these records have been kept since they are unique
data4 <- data3 %>% 
  distinct(Catalogue.Number, Collector.Number, .keep_all = TRUE)

## Find the rows that had the same catalogue AND collector numbers
### these records have been removed since they are duplicates
data4_1 <- anti_join(data3, data4)

## Save spreadsheet to keep track of records removed
write_xlsx(data4_1, ".../GBIF_CPNWH_Compared_DupCatCollNums.xlsx") ##update path as needed


## Keep only the rows that have different hash identifiers
### these records have been kept since they are unique
data5 <- data4 %>% distinct(hash, .keep_all = TRUE)

## Find the rows that had the same hash identifiers
### these records have been removed since they are duplicates
data5_1 <- anti_join(data4, data5)

## Save spreadsheet to keep track of records removed
write_xlsx(data5_1, ".../GBIF_CPNWH_Compared_Duphash.xlsx") ##update path as needed


## Save spreadsheet of all unique records
write_xlsx(data5, ".../GBIF_CPNWH_Unique.xlsx") ##update path as needed


## Next step done manually in excel using GBIF_CPNWH_Unique.xlsx
## Sheet #1: "Unique"
## Sorted through remaining records for additional duplicates based on 
### catalogue OR collector numbers
## Made note of any potential duplicates in the LT_Notes column 

## Sheet #2: "Removed"
## Compiled duplicates from GBIF_CPNWH_Compared_DupCatCollNums.xlsx and 
### GBIF_CPNWH_Compared_Duphash.xlsx spreadsheets. 
## Added column "Why Removed?" to add note of why the record was removed from 
### the original GBIF_CPNWH_DWC-Combine.xlsx file

## Saved resulting file as GBIF_CPNWH_Unique_Final.xlsx


## Add institution and collection information from GBIF and CPNWH datasets 
### to the Unique_Final dataset
Final_data <- read_excel(".../GBIF_CPNWH_Unique_Final.xlsx", sheet="Unique") ##update path as needed
Final_data <- as.data.frame(Final_data)
Final_data$datasetName <- as.character(Final_data$datasetName)
Final_data$RowNum <- as.integer(Final_data$RowNum)

GBIF_data <- read.csv(".../GBIF_2024_07_11_Tracheophyta-assigned.csv") ##update path as needed
GBIF_data <- as.data.frame(GBIF_data)
GBIF_data$datasetName <- as.character(GBIF_data$datasetName)
GBIF_data$RowNum <- as.integer(GBIF_data$RowNum)
GBIF_data2 <- GBIF_data[, c("datasetName", "RowNum", "institution", "collection")]

Final_data2 <- merge(Final_data, GBIF_data2, by = c("datasetName", "RowNum"), all.x = TRUE)


CPNWH_data <- read.csv(".../CPNWH_20240726-121916-distinct-assigned.csv") ##update path as needed
CPNWH_data <- as.data.frame(CPNWH_data)
CPNWH_data$datasetName <- as.character(CPNWH_data$datasetName)
CPNWH_data$RowNum <- as.integer(CPNWH_data$RowNum)
CPNWH_data2 <- CPNWH_data[, c("datasetName", "RowNum", "institution", "collection")]

Final_data3 <- merge(Final_data2, CPNWH_data2, by = c("datasetName", "RowNum"), all.x = TRUE)


write_xlsx(Final_data3, ".../GBIF_CPNWH_Unique_Final2.xlsx")  ##update path as needed