## read and wrangle ICD codes

library(tidyverse)
library(readxl)
library(here)

## paths to the local copies of the raw data

## HIV codes
## data were taken form the "version 3..." tab of the file "\\hlm\data\project
##    \Coghill_Research\HIV and Cancer_Tissue and Abstraction
##    \dataset QC and reviews\documented version and QC"
path_icd_hiv <- here("data/raw_data/icd_codes_hiv.csv")

## transplant codes
path_icd_transplant <- here("data/raw_data/icd_codes_transplant.csv")

## codes for other immune-related defficiencies
path_icd_immune <- here("data/raw_data/icd_codes_immune_related_defficiencies.csv")

## read the data from file
df_icd_hiv <- read_csv(path_icd_hiv)
df_icd_transplant <- read_csv(path_icd_transplant)
df_icd_immune <- read_csv(path_icd_immune)

# separate the HIV ICD codes from the description
df_icd_hiv <-
    df_icd_hiv %>% 
    separate(ICD_codes, into = c("icd_code", "icd_description"), 
             sep = " ", 
             extra = "merge") %>% 
    mutate(disease_category = "HIV")


# separate the transplant ICD codes from the description
df_icd_transplant <-
    df_icd_transplant %>% 
    separate(ICD_codes, into = c("icd_code", "icd_description"), 
             sep = " ", 
             extra = "merge") %>% 
    mutate(disease_category = "Transplant")

# separate the other immune ICD codes from the description
df_icd_immune <-
    df_icd_immune %>% 
    separate(ICD_codes, into = c("icd_code", "icd_description"), 
             sep = " ", 
             extra = "merge") %>% 
    mutate(disease_category = "Immune-related defficiencies")


## Join all into one dataframe
list_icd_codes <- list(df_icd_hiv, 
                       df_icd_transplant, 
                       df_icd_immune)

df_icd_full <- bind_rows(list_icd_codes)


## Write all to file
write_csv(df_icd_full, file = here("data/tidy_data/df_icd_full.csv"))


write_rds(df_icd_full, file = here("data/tidy_data/df_icd_full.rds"))
write_rds(df_icd_hiv, file = here("data/tidy_data/df_icd_hiv.rds"))
write_rds(df_icd_transplant, file = here("data/tidy_data/df_icd_transplant.rds"))
write_rds(df_icd_immune, file = here("data/tidy_data/df_icd_immune.rds"))
