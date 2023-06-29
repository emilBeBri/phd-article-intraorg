 
 
 
 
 
 
 
 
 

source('/home/emil/Dropbox/data-science/R/.Rprofile')
source('/home/emil/Dropbox/data-science/R/r-setup-standard-packages.r')
setwd("/home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality")


library('knitr')
library('kableExtra')
library(formattable) 

f1 <- fread('output/table-team-moves-type_lmarket.csv', sep=';')

f1 %>% kable('html') %>% kable_styling(bootstrap_options=qc(striped), position='left', fixed_thead=T)  %>% kable_paper('hover', full_width=TRUE)  








