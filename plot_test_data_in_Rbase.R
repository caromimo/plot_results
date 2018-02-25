# import required libraries
library(tidyverse)
library(readr)

# set working directory
# path used forward slashes in Windows and backward slashes in Linux
if (.Platform$OS.type == "windows") {
  setwd("Y:/")
} else {
  setwd("~/projects/plot_risk_rankings/")
}

# read csv file with the readr library which creates a tibble
tb <- read_csv("test_data.csv")

steps <- unique(tb$step)
likelihood_categories <-
  c(
    "Extremely unlikely",
    "Very unlikely",
    "Unlikely",
    "Likely",
    "Very likely",
    "Extremely likely"
  )
likelihood_labels <-
  c(
    "Extremely\nunlikely",
    "Very\nunlikely",
    "Unlikely",
    "Likely",
    "Very\nlikely",
    "Extremely\nlikely"
  )
uncertainty_categories <-
  c("Highly certain",
    "Reasonably certain",
    "Reasonably uncertain",
    "Highly uncertain")
uncertainty_labels <-
  c(
    "Highly\ncertain",
    "Reasonably\ncertain",
    "Reasonably\nuncertain",
    "Highly\nuncertain"
  )

for (step_number in steps) {
  tb_step <- tb %>% filter(step == step_number)

  risk_assessment_names <- unique(tb_step$risk_assessment)

  for (risk_assessment_name in risk_assessment_names) {
    tb_step_ra <- tb_step %>%
      filter(risk_assessment == risk_assessment_name)

    # count the number of occurrence for the likelihood
    likelihood_counts <- tb_step_ra %>%
      count(likelihood) %>%
      right_join(tibble(likelihood = likelihood_categories))

    # count the number of occurrence for the uncertainty
    uncertainty_counts <- tb_step_ra %>%
      count(uncertainty) %>%
      right_join(tibble(uncertainty = uncertainty_categories))

    #save plot
    png(
      sprintf("%s_for_%s.png",
              step_number,
              risk_assessment_name),
      width = 1350,
      height = 800,
      res = 72
    )

    #organize plot side by side
    par(
      mfrow = c(1, 2),
      oma = c(2, 4, 7, 3),
      mgp = c(5, 2, 0)
    )

    #create plots
    barplot(
      likelihood_counts$n,
      main = "LIKELIHOOD",
      cex.main = 1.7,
      col = "darkgreen",
      #  ylab = "Number of rankings",
      ylim = c(0, 16),
      # xlab = "Likelihood ranking",
      names.arg = likelihood_labels,
      las = 1,
      cex.axis = 1.5,
      cex.names = 1.4,
      font.lab = 1,
      cex.lab = 1.8
    )
    barplot(
      uncertainty_counts$n,
      main = "UNCERTAINTY",
      cex.main = 1.7,
      col = "palegreen1",
      #  ylab = "Number of rankings",
      ylim = c(0, 16),
      # xlab = "Uncertainty ranking",
      names.arg = uncertainty_labels,
      cex.axis = 1.5,
      cex.names = 1.4,
      las = 1,
      font.lab = 1,
      cex.lab = 1.8
    )
    mtext(
      text = "Number of rankings",
      side = 2,
      line = 0,
      cex = 1.75,
      outer = TRUE
    )

    title(
      sprintf("%s - %s risk assessment",
              step_number,
              risk_assessment_name),
      cex.main = 2,
      outer = TRUE
    )
    dev.off()
  }
}
