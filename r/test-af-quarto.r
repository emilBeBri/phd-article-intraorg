
table-team-moves-n_inflow-nace5-lmarket.xlsx



a1  <- copy(l3)
a1
l3
uniqueN(l3, by=qc(type_firm_ws_status, type_move))
uniqueN(a1, by=qc(type_firm_ws_status, type_move))

dups(a1, by=qc(type_firm_ws_status, type_move))
dups(l3, by=qc(type_firm_ws_status, type_move))
wideScreen()
options(width=5000)

map(m1, \(.x)  .x[, 1] ) 
map(m1, 1) |> unlist() |> unique()






setwd('..'); getwd()




library('readxl')
library('plotly')

a1 <- read_excel('input/dst-out/ras_n_fid_novprio1.xlsx') %>% data.table() 

p1 <- a1 %>% ggplot(aes(bef_aar, N)) + geom_line() + theme_bb()
ggplotly(p1)







b1 <- dir_table('input/dst-out', regex='arbnr|fid')

b2 <- map(b1$path, ~ read_excel(.x) %>% data.table())

names(b2)  <- c('establishment', 'company')

b2  <- rbindlist(b2, idcol='grp')
p2 <- b2 %>% ggplot(aes(bef_aar, N, color=grp)) + geom_line() + theme_bb()
ggplotly(p2)



seq(0, 350000, 50000)
