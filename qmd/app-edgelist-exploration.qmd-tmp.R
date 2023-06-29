









library(fs)
library(readxl)
library(magrittr)
library(data.table)
library(dttools)
library(knitr)
library(kableExtra)
``` 


```{r,  echo=FALSE}


include_graphics('img/test.png') 














# df <- read_xlsx(here::here("input/table-external-markets-arbnr-fid-appears-disappears.xlsx"))

ex1 <- read_xlsx('input/table-external-markets-arbnr-fid-appears-disappears.xlsx') %>% data.table()


ex1 %>% kbl() %>% kable_styling()



``` 

