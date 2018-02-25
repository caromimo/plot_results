# import required libraries
library(tidyverse)
library(readr)

# set working directory
# path used forward slashes in Windows and backward slashes in Linux
if (.Platform$OS.type == "windows") {
  setwd("Y:/Risk Assessments/Meetings/20180400")
}

# read csv file with the readr library which creates a tibble
tb <- read_csv("test_data.csv")

steps <- unique(tb$step)
uncertainty_categories <- c("Highly certain", "Reasonably certain", "Reasonably uncertain", "Highly uncertain")
likelihood_categories <- c("Extremely unlikely", "Very unlikely", "Unlikely", "Likely", "Very likely", "Extremely likely")

for (step_number in steps) {
  tb_step <- tb %>% filter(step == step_number)

  risk_assessment_names <- unique(tb_step$risk_assessment)

  for (risk_assessment_name in risk_assessment_names) {
    tb_step_ra <- tb_step %>%
      filter(risk_assessment == risk_assessment_name)

    likelihood_counts <- tb_step_ra %>%
      group_by(likelihood) %>%
      summarise(count = n()) %>%
      right_join(tibble(likelihood = likelihood_categories)) %>%
      ggplot(aes(x=likelihood, y=count)) + geom_col() +
      scale_x_discrete(limits = likelihood_categories)
      ggsave(sprintf("%s_%s_likelihood.png", step_number, risk_assessment_name))

    uncertainty_counts <- tb_step_ra %>%
      group_by(uncertainty) %>%
      summarise(count = n()) %>%
      right_join(tibble(uncertainty = uncertainty_categories)) %>%
      ggplot(aes(x=uncertainty, y=count)) + geom_col() +
      scale_x_discrete(limits = uncertainty_categories)
      ggsave(sprintf("%s_%s_uncertainty.png", step_number, risk_assessment_name))
    }
}
