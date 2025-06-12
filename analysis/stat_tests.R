load_or_install <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

load_or_install("dplyr")
load_or_install("tidyr")
load_or_install("rstatix")
load_or_install("ggpubr")

# Macro F1-score

df <- tibble::tibble(
  Fold = 1:5,
  BERT = c(0.56, 0.63, 0.54, 0.51, 0.48),
  CNN = c(0.58, 0.68, 0.64, 0.70, 0.69),
  Wczesna = c(0.53, 0.54, 0.62, 0.55, 0.60),
  Fuzja_weighted = c(0.64, 0.70, 0.65, 0.61, 0.64),
  Fuzja_stacking = c(0.69, 0.67, 0.66, 0.66, 0.63)
)

df_long <- df %>%
  pivot_longer(cols = -Fold, names_to = "Model", values_to = "F1")

ggqqplot(df_long, x = "F1", facet.by = "Model")

df_long %>%
  group_by(Model) %>%
  summarise(
    p_value = shapiro.test(F1)$p.value
  )

anova_res <- df_long %>% anova_test(F1 ~ Model)
print(anova_res)

tukey_res <- df_long %>% tukey_hsd(F1 ~ Model)
knitr::kable(tukey_res) %>% print()

# Balanced Accuracy

df <- tibble::tibble(
  Fold = 1:5,
  BERT = c(0.56, 0.63, 0.56, 0.51, 0.48),
  CNN = c(0.62, 0.70, 0.65, 0.74, 0.72),
  Wczesna = c(0.55, 0.56, 0.61, 0.57, 0.62),
  Fuzja_weighted = c(0.70, 0.69, 0.70, 0.66, 0.65),
  Fuzja_stacking = c(0.64, 0.68, 0.63, 0.60, 0.63)
)

df_long <- df %>%
  pivot_longer(cols = -Fold, names_to = "Model", values_to = "BalancedAcc")

ggqqplot(df_long, x = "BalancedAcc", facet.by = "Model")

df_long %>%
  group_by(Model) %>%
  summarise(
    p_value = shapiro.test(BalancedAcc)$p.value
  )

anova_res <- df_long %>% anova_test(BalancedAcc ~ Model)
print(anova_res)

tukey_res <- df_long %>% tukey_hsd(BalancedAcc ~ Model)
knitr::kable(tukey_res) %>% print()