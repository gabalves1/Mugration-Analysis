library(ggplot2)
library(cowplot)
library(dplyr)
library(data.table)
library(ape)
library(circlize)
library("migest")
library(phytools)
library("readxl")
library(lubridate)
library("scales")
theme_set(theme_cowplot())


##circos
#file flow
flowname <- read.delim("Flow_circosHIV3.txt", row.names=1)

flowname <- as.matrix(flowname)

#dataframe from to
df_final = data.frame(from = rep(rownames(flowname), times = ncol(flowname)),
                      to = rep(colnames(flowname), each = nrow(flowname)),
                      value = as.vector(flowname),
                      stringsAsFactors = FALSE)

df_final

#chord diagram
chordDiagram(df_final)

border_mat2 = matrix("black", nrow = nrow(flowname), ncol = 1)
rownames(border_mat2) = rownames(flowname)
colnames(border_mat2) = colnames(flowname) [2]
cores_dict <- c(
  Europe = "#8e4747",   
  NortheastBR = "#2b3c3c",   
  SouthBR = "#295c5c",    
  NorthBR = "#287049",
  CentralWestBR = "#c1dab3", 
  SoutheastBR = "#cdcdcd",
  Bahia = "#4df7ee",        
  OtherCountries = "#ffffff"
)
grid.col <- unname(cores_dict[colnames(flowname)])

chordDiagram(flowname, grid.col = grid.col, link.lwd = 2)# ,link.border = border_mat2)

