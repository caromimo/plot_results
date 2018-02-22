#import required libraries
library(tidyverse)
library(readr)

#set working directory - would need to be reset to re-run the scripts in other folder 
#in Windows you have to use forward slashes as opposed to Linux which uses backward slashes in the path
if(.Platform$OS.type=="windows"){
	setwd("Y:/Risk Assessments/Meetings/20180400")
}

#read csv file with the readr library which creates a tibble
tb <- read_csv("test_data.csv")

#tb$Occurrence_Start_Month <- as.numeric(tb$Occurrence_Start_Month)

steps <- unique(tb$step)

for (step_number in steps) {
  tb_step <- tb %>% filter(step == step_number)

  risk_assessment_names <- unique(tb_step$risk_assessment)

  for (risk_assessment_name in risk_assessment_names){
  tb_step_ra <- tb_step %>%
	  filter(risk_assessment == risk_assessment_name) %>%
	  count(likelihood) 

 #TODO:Clean it up
  #%>% 
#	  right_join(tibble(Likelihood_ranking = c("negligible", "low", "medium", "high", "extreme")), by )

#      likelihood_counts <- tb_step_ra %>%
#        count(likelihood) %>%
          
  print(tb_step_ra)
  }
}
#  tb_zone <- tb %>% filter(Zone == zone)
#  
#  tb_step_ra <- unique(tb_zone$Subzone)
#  
#  for (subzone in all_subzones) {
#    tb_subzone <- tb_zone %>% filter(Subzone == subzone)
#    
#    all_diseases <- unique(tb_subzone$Disease)
#    
#    for (disease in all_diseases) {
#      tb_disease <- tb_subzone %>% filter(Disease == disease)
#      
#      #filter and count likelihood rankings
#      
#      #filter and count uncertainty rankings
#      in_pacifics_per_year <- tb_disease %>%
#        filter(Species_Group == "Pacific salmon") %>%
#        count(Occurrence_Start_Year) %>%
#        right_join(tibble(Occurrence_Start_Year = 2002:2017))
#      
#      #filter and count per month for Atlantic salmon
#      in_atlantics_per_month <- tb_disease %>%
#        filter(Species_Group == "Atlantic salmon") %>%
#        count(Occurrence_Start_Month) %>%
#        right_join(tibble(Occurrence_Start_Month = 1:12))
#      
#      #filter and count per month for Pacific salmon
#      in_pacifics_per_month <- tb_disease %>%
#        filter(Species_Group == "Pacific salmon") %>%
#        count(Occurrence_Start_Month) %>%
#        right_join(tibble(Occurrence_Start_Month = 1:12))
#      
#      #create dynamic axis ranges
#      atlantics_max_count_year <-
#        max(in_atlantics_per_year$n, na.rm = TRUE)
#      pacifics_max_count_year <-
#        max(in_pacifics_per_year$n, na.rm = TRUE)
#      max_count_year <-
#        max(c(atlantics_max_count_year, pacifics_max_count_year, 5))
#      
#      atlantics_max_count_month <-
#        max(in_atlantics_per_month$n, na.rm = TRUE)
#      pacifics_max_count_month <-
#        max(in_pacifics_per_month$n, na.rm = TRUE)
#      max_count_month <-
#        max(c(atlantics_max_count_month, pacifics_max_count_month, 5))
#      
#      #save plot
#      png(
#        sprintf(
#          "%s_fhes_in_zone_%d-%d.png",
#          disease,
#          zone,
#          subzone
#        ),
#        width = 1250,
#        height = 800,
#        res = 72
#      )
#      
#      #organize plot side by side
#      par(
#        mfrow = c(1, 2),
#        oma = c(1, 5, 7, 3),
#        mgp = c(4.2, 1, 0)
#      )
#      
#      #create plots
#      year_abbreviations = as.character(c(2002:2017))
#      month_abbreviations = c("jan",
#                              "feb",
#                              "mar",
#                              "apr",
#                              "may",
#                              "jun",
#                              "jul",
#                              "aug",
#                              "sep",
#                              "oct",
#                              "nov",
#                              "dec")
#      barplot(
#        in_atlantics_per_year$n,
#        main = "ATLANTIC SALMON FARMS",
#        cex.main = 1.7,
#        col = "skyblue1",
#        xlab = "Year",
#        names.arg = year_abbreviations,
#        ylim = c(0, max_count_year + 5),
#        cex.axis = 1.5,
#        cex.names = 1.4,
#        las = 2,
#        font.lab = 1,
#        cex.lab = 1.8
#      )
#      barplot(
#        in_atlantics_per_month$n,
#        main = "ATLANTIC SALMON FARMS",
#        cex.main = 1.7,
#        col = "darkblue",
#        xlab = "Month",
#        names.arg = month_abbreviations,
#        ylim = c(0, max_count_month + 5),
#        cex.axis = 1.5,
#        cex.names = 1.5,
#        las = 1,
#        font.lab = 1,
#        cex.lab = 1.8
#      )
#      mtext(
#        text = "Number of farm-level diagnoses",
#        side = 2,
#        line = 0,
#        cex = 1.75,
#        outer = TRUE
#      )
#      title(
#        sprintf(
#          "DRAFT FOR INTERNAL DISCUSSION ONLY\nFish health events related to %s \n in zone %d-%d of Pacific Region between 2002 and 2017-Q1 (no data between 2013 and 2015-Q4)",
#          disease,
#          zone,
#          subzone
#        ),
#        cex.main = 2,
#        outer = TRUE
#      )
#      dev.off()
#    }
#  }
#}
