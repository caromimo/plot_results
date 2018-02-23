library(tidyverse)

assessor_list <- c(
  "Assessor 1",
  "Assessor 2",
  "Assessor 3",
  "Assessor 4",
  "Assessor 5",
  "Assessor 6",
  "Assessor 7",
  "Assessor 8",
  "Assessor 9",
  "Assessor 10",
  "Assessor 11",
  "Assessor 12"
)

risk_assessment_list <- c(
  "Pathogen A",
  "Pathogen B",
  "Pathogen C",
  "Pathogen D"
)

step_number <- c(
  "Disease 1",
  "Disease 2",
  "Release 1",
  "Release 2",
  "Exposure 1",
  "Exposure 2",
  "Exposure 3",
  "Infection 1",
  "Infection 2",
  "Infection 3",
  "Consequence to abundance",
  "Consequence to diversity"
)

likelihood_rankings <- c(
  "extremely unlikely",
  "very unlikely",
  "unlikely",
  "likely",
  "very likely",
  "extremely likely"
)

uncertainty_rankings <- c(
  "high uncertainty",
  "reasonable uncertainty",
  "reasonable certainty",
  "high certainty"
)

row_number <- 750

test_data <- tibble(
  assessor=sample(assessor_list, row_number, replace=TRUE),
  risk_assessment=sample(risk_assessment_list, row_number, replace=TRUE),
  step=sample(step_number, row_number, replace=TRUE),
  likelihood=sample(likelihood_rankings, row_number, replace=TRUE),
  uncertainty=sample(uncertainty_rankings, row_number, replace=TRUE)
)

write_csv(test_data, "test_data.csv")
