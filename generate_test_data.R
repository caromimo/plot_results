library(tidyverse)

assessor_list <- c("MW", "CM", "NS", "KG", "IB", "JP", "FB", "KL", "ML", "DW", "FK", "AS")
risk_assessment_list <- c("Chelsea", "Wakefield", "Ottawa", "Gatineau")
step_number <- c(1:10)
likelihood_rankings <- c("negligible", "low", "moderate", "high", "extreme")
uncertainty_rankings <- c("highly uncertain", "reasonably uncertain", "reasonably certain", "high certain")

row_number <- 750

test_data <- tibble(assessor=sample(assessor_list, row_number, replace=TRUE), risk_assessment=sample(risk_assessment_list, row_number, replace=TRUE), step=sample(step_number, row_number, replace=TRUE), likelihood=sample(likelihood_rankings, row_number, replace=TRUE), uncertainty=sample(uncertainty_rankings, row_number, replace=TRUE))

write_csv(test_data, "test_data.csv")
