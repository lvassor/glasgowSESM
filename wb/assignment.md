# MED5538 Evidence Based Biomedical Research Methods and Statistics Summative Assessment

#### GUID: 2957161

1. 

a. Using either Minitab or SPSS, obtain appropriate descriptive statistics and suitable plots for the variables Sex, DepCat, RegCat and DFMT individually (i.e. do not look at any relationships between these variables). Provide a short interpretation of the output you produce for each variable.

The data in the sample are all complete except one entry, which contains a NA value for deprivation category. Since we are comparing dental health between areas with different deprivation categories, this record was first removed.

This leaves 40 male and 59 female individuals in the sample, giving us a fairly even spread between the sexes. Obviously our sample contains more females than male. Should there be sex-based differences in dental health, this perhaps would present some issues with our sample, but given we area comparing area, this gives us broad coverage across both. 

| Sex | n | proportion |
|---|---|-----------|
| 1 | 40 | 40.40404 |
| 2 | 59 |  59.59596 |

<img src="../output/assignment/sex_barplot.png" style="width: 40%">

DepCat is a categorical variable representing deprivation category for the postcode area of the record. Summary statistics are as follows:

| DepCat |  n | proportion |
|--------|----|------------|
|      4 | 18 |         18.18 |
|      6 | 33 |         33.33 |
|      7 | 48 |         48.48 |


<img src="../output/assignment/depcat_barplot.png" style="width: 40%">


DepCat 7 is the most deprived area in this study, and represents a greater proportion of the sample, contrasted with the more affluent area of department 4. Such a difference in proportion may allow averages to be more susceptible to skewing.

Children in the most deprived area (DepCat=7) have the greatest number of decayed, filled or missing teeth (DFMT) (mean=6.35, median=5). In a slightly less deprived area (DepCat=6), children have fewer DFMT (mean=3.78, median=2). In the least deprived/most affluent area of the sample (DepCat=4), the average DFMT is interesting insofar as the mean is slightly less (mean=3.22), while the median is greater (median=3) than DepCat=6. Only in the least deprived area do the data appear to be symmetrical (mean approximates median), as shown by the boxplot. For DepCat 6 and 7, the data do not appear to be symmetrical, indicating that a handful of individuals with extreme levels of poor dental health may be skewing the mean. This is congruent with the variability of the data, as shown by the standard deviations, which differ across the deprivation categories but are as great, if not greater, than their corresponding mean.

| DepCat | DFMT_N | DFMT_N_total | DFMT_Mean | DFMT_SE_Mean | DFMT_StDev | DFMT_Min | DFMT_Q1 | DFMT_Median | DFMT_Q3 | DFMT_Max |
|--------|--------|--------------|-----------|--------------|------------|----------|---------|-------------|--------|----------|
| 4      | 18     | 18           | 3.222222  | 0.7256080    | 3.078494   | 0        | 0.00    | 3           | 5.75   | 9        |
| 6      | 33     | 33           | 3.787879  | 0.8231471    | 4.728620   | 0        | 0.00    | 2           | 5.00   | 17       |
| 7      | 48     | 48           | 6.354167  | 0.7698264    | 5.333513   | 0        | 1.75    | 5           | 10.00  | 20       |

2. Formal Analysis Output

**Levene's Test for Homogeneity of Variance (center = median)**

| Df | F value | Pr(>F) |
|----|---------|--------|
| 1  | 4.6299  | 0.0339 |
| 97 |         |        |



**Welch Two Sample t-test**

|                  |                  |
|:----------------:|:----------------:|
| **data:**         | DFMT by Poorest  |
| **t:**            | -2.8561          |
| **df:**           | 89.241           |
| **p-value:**      | 0.005335         |
| **alternative hypothesis:** | true difference in means between group 0 and group 1 is not equal to 0 |
| **95 percent confidence interval:** | -4.6901221 -0.8417406 |
| **sample estimates:** | |
| mean in group 0 | mean in group 1 |
| 3.588235 | 6.354167 |

This is a 2-sample t-test and Confidence Interval (CI) comparing DFMT count of children living in one of the poorest areas of Glasgow (deprivation category of 7), and children not living in one of the poorest areas (deprivation categories of 4 and 6). To help decide whether equal variances should be assumed or not, Levene’s test is used (H0 (null hypothesis): population variances for poorest and not poorest areas are the same). Since the p-value = 0.0339, i.e. is less than the significance level of 0.05, there is evidence against the null hypothesis. Therefore, we reject the null hypothesis of equal variances, concluding that the assumption of equal variances is violated. This means we should use a version of the t-test and CI that does not assume homogeneity of variance, such as the Welch Two Sample t-test, rather than Student's t-test.

For the Welch's t-test, the H0 is that the population mean DFMT count for the poorest area = population mean DFMT count for non-poorest areas. H1 is that they are unequal. Since the p-value of 0.005335 is less than 0.05, we have sufficient evidence to reject the null hypothesis that DFMT counts are the same for both groups. There is sufficient evidence to conclude that the mean DFMT values are significantly different between the two groups (Poorest 0 and Poorest 1). The negative t-value suggests that the mean DFMT value is lower in group 1 compared to group 0. The 95 percent confidence interval for the difference in means does not include zero, supporting the significance of the result.