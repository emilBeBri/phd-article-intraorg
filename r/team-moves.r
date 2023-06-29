source('/home/emil/Dropbox/data-science/R/.Rprofile')
source('/home/emil/Dropbox/data-science/R/r-setup-standard-packages.r')
setwd("/home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality")

library('writexl')
library('knitr')
library('kableExtra')





f1  <- read_xlsx('input/table-team-moves-n_inflow-binary-vars.xlsx') |> data.table()
setnames(f1, 'n_inflow2', 'N')
# v2(f1)

# NA in sector get's it's own category
f1[is.na(type_nace5), type_nace5 := 'Unknown']




#######  #subsection ######
#  type_appear disappear


# for the two different types of markets
m1 <- map(c('', 'external market', 'internal market'), \(.x) {
		# .x  <- ''
		# .x  <- 'external market'
	l1 <- f1[type_lmarket %ilike% .x]

	l2 <- l1[, .(N=sum(N)), .(type_move, type_arbnr_app, type_fid_app)]
	l2[, and := round(N/sum(N), 2) , by=type_move]
	# l2[, sum(and), .(type_move)]
	# what categories are big
	l2[order(-and)] 
	l2[order(-and)][and > 0.02, sum(and)] # most are captured here
	l3 <- l2[order(-and)][and > 0.02]


	# l2[type_arbnr_app %ilike% 'dis']
	# create new categories 
	l3[, type_firm_ws_status := paste0(type_arbnr_app, ' + ', type_fid_app)]

	l4n <- dcast(l3, type_firm_ws_status ~ type_move, value.var='N') %>%  .[order(type_firm_ws_status)]
	l4and <- dcast(l3,type_firm_ws_status ~ type_move, value.var='and') %>%  .[order(type_firm_ws_status)]
	# NA to 0
	for(xcol in names(l4and)) set(l4and, i=which(is.na(l4and[[xcol]])), j=xcol, value=0)

	# fix for output
	# l4and2  <- modify_if(l4and, is.numeric, \(x)  sprintf("%02g", x*100) %p0% ' %') %>%  .[, !'NA'] 
	# l4and2

	l4and
} ) 
names(m1)  <- c('all', 'external market', 'internal market')

l5  <- rbindlist(m1, idcol='type_lmarket')
l5[, type_firm_ws_status2 := fcase(
	type_firm_ws_status == "both ws existed priorly + both firms existed priorly", 'all firms and worksites exists', 
	type_firm_ws_status == "ws A disappears + both firms existed priorly", 'both firms existed, ws A disappears', 
	type_firm_ws_status == "ws A disappears + firm A disappears", 'firm X & ws A disappears', 
	type_firm_ws_status == "ws B appears + both firms existed priorly", 'both firms existed, ws B appears', 
	type_firm_ws_status == "ws B appears + firm B appears", 'firm Y appears, ws B appears', 
	type_firm_ws_status == "ws A disappears & ws B appears + firm A disappears & firm B appears", 'XA disappears and YB appears', 
	type_firm_ws_status == "ws A disappears & ws B appears + both firms existed priorly", 'firms exists, ws A disappears, ws B appears', 
	default=NA
	)]

# get the ones that are in one cat but not in the other in there, too
o1  <- split(l5, l5$type_lmarket)
o2  <- map(o1, \(.x) {
	# .x  <- t1[[1]]
	# .x[ unique(l5[, .(type_firm_ws_status2)]), on='type_firm_ws_status2']
	.x[ unique(l5[, .(type_firm_ws_status2, type_firm_ws_status)]), 
		on=c('type_firm_ws_status2', 'type_firm_ws_status')][, !'type_lmarket']
})
l6 <- rbindlist(o2, idcol='type_lmarket')
for(xcol in names(l6)) set(l6, i=which(is.na(l6[[xcol]])), j=xcol, value='00 %')

# order by size of category for all 
t1 <- dtcolc(l6, 'move', plus='type_firm_ws_status2')
t1[, rank := 
	as.integer(gsub(' %', '', `individual move`) ) +
	as.integer(gsub(' %', '', `team move`) ) ]
lvl1 <- t1[, sum(rank), .(type_firm_ws_status2)][order(-V1)]
fwrite(lvl1, 'output/levels-app-disapp.csv')


l6[, type_firm_ws_status2 := factor(type_firm_ws_status2, levels=t2$type_firm_ws_status2)]
setorder(l6, type_lmarket, type_firm_ws_status2)

fwrite(l6, 'output/table-team-moves-firms-and-worksites-appearrs-disappears.csv', sep=';')

##### subsection over #####



#######  #subsection ######
#  type_nace5


j2 <- f1[, .(N=sum(N)), .(type_move, type_nace5)]
j2[, and := round(N/sum(N), 2) , by=type_move]
j3n <- dcast(j2, type_nace5 ~ type_move, value.var='N') %>%  .[order(type_nace5)]
j3and <- dcast(j2, type_nace5 ~ type_move, value.var='and') %>%  .[order(type_nace5)]

j2 <- cube(f1,
	.(N = sum(N)),
	by = qc(type_move, type_nace5))
j2[!is.na(type_nace5) & !is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
j2[!is.na(type_nace5) & is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
j2[is.na(type_nace5) & !is.na(type_move) , and := round( N/sum(N), 2), by=type_nace5]
j2[!is.na(type_nace5) & is.na(type_move) , and := round( N/sum(N), 2), by=type_nace5]

j3n <- dcast(j2, type_nace5 ~ type_move, value.var='N') %>%  .[order(type_nace5)]
j3and <- dcast(j2, type_nace5 ~ type_move, value.var='and') %>%  .[order(type_nace5)]
setcolorder_rev(j3and, 'NA')
setcolorder_rev(j3n, 'NA')

# fix for output
# j3and2 <- modify_if(f3and, is.numeric, pct ) %>%  .[, !'NA'] 
j3and2  <- modify_if(f3and, is.numeric, \(x)  sprintf("%02g", x*100) %p0% ' %') %>%  .[, !'NA'] 
fwrite(j3and2, 'output/table-team-moves-type_nace5.csv', sep=';')



##### subsection over #####


#######  #subsection ######
# type_lmarket

c2 <- f1[, .(N=sum(N)), .(type_move, type_lmarket)]

c2[, and := round(N/sum(N), 2) , by=type_move]

c3n <- dcast(c2, type_lmarket ~ type_move, value.var='N') %>%  .[order(type_lmarket)]
c3and <- dcast(c2, type_lmarket ~ type_move, value.var='and') %>%  .[order(type_lmarket)]


c2 <- cube(f1,
	.(N = sum(N)),
	by = qc(type_move, type_lmarket))
# fwrite(c2, 'output/test.csv', sep=';')

c2[!is.na(type_lmarket) & !is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
# c2[!is.na(type_lmarket) & is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
c2[is.na(type_lmarket) & !is.na(type_move) , and := round( N/sum(N), 2), by=type_lmarket]
c2[is.na(type_lmarket) & is.na(type_move) , and := round( N/sum(N), 2)]


c3n <- dcast(c2, type_lmarket ~ type_move, value.var='N') %>%  .[order(type_lmarket)]
c3and <- dcast(c2, type_lmarket ~ type_move, value.var='and') %>%  .[order(type_lmarket)]
setcolorder_rev(c3and, 'NA')
setcolorder_rev(c3n, 'NA')

# fix for output, to pct
# c3and2 <- modify_if(c3and, is.numeric, pct ) %>%  .[, !'NA'] 
c3and2  <- modify_if(c3and, is.numeric, \(x)  sprintf("%02g", x*100) %p0% ' %') %>%  .[, !'NA'] 
fwrite(c3and2, 'output/table-team-moves-type_lmarket.csv', sep=';')


##### subsection over #####


#######  #subsection ######
# off_privat

i2 <- f1[, .(N=sum(N)), .(type_move, off_privat)]

i2[, and := round(N/sum(N), 2) , by=type_move]

i3n <- dcast(i2, off_privat ~ type_move, value.var='N') %>%  .[order(off_privat)]
i3and <- dcast(i2, off_privat ~ type_move, value.var='and') %>%  .[order(off_privat)]


i2 <- cube(f1,
	.(N = sum(N)),
	by = qc(type_move, off_privat))
# fwrite(i2, 'output/test.csv', sep=';')


i2  <- i2[!is.na(off_privat) & !is.na(type_move),]

i2[!is.na(off_privat) & !is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
i2[!is.na(off_privat) & is.na(type_move) , and := round( N/sum(N), 2), by=type_move]
i2[is.na(off_privat) & !is.na(type_move) , and := round( N/sum(N), 2), by=off_privat]
i2[is.na(off_privat) & is.na(type_move) , and := round( N/sum(N), 2)]



i3n <- dcast(i2, off_privat ~ type_move, value.var='N') %>%  .[order(off_privat)]
i3and <- dcast(i2, off_privat ~ type_move, value.var='and') %>%  .[order(off_privat)]
i3and[, off_privat := fcase(off_privat == 'Privat', 'Private', off_privat == 'Offentlig', 'Public')]
# setcolorder_rev(i3and, 'NA')
# setcolorder_rev(i3n, 'NA')

# fix for output, to pct
# i3and2 <- modify_if(i3and, is.numeric, pct ) %>%  .[, !'NA'] 
i3and2  <- modify_if(i3and, is.numeric, \(x)  sprintf("%02g", x*100) %p0% ' %') %>%  .[, !'NA'] 
fwrite(i3and2, 'output/table-team-moves-off_privat.csv', sep=';')




##### subsection over #####






#########################################
#   #section
#########################################



j1a <- fread('output/table-team-moves-type_lmarket.csv', sep=';')
j1c <- fread('output/table-team-moves-off_privat.csv', sep=';')
j1b <- fread('output/table-team-moves-type_nace5.csv', sep=';')[ type_nace5 != 'Unknown', ]
for(x in qc(j1a, j1b, j1c)) setnames(get(x), 1, 'type') 
# for(x in qc(j1a, j1b)) setnames(get(x), 1, '') 

j2 <- rbind(j1a, j1b)[type != '']
j2 <- rbind(j2, j1c)[type != '']
j2 <- rbind(j1a[type == ''] , j2)

j2 %>% kable('html') %>% kable_styling(bootstrap_options=qc(striped), position='left', fixed_thead=T) |>  
kable_paper('hover', full_width=TRUE)  |>  
pack_rows('Marginal share ', 1, 1) |>  
pack_rows('labour market type', 2, 3) |>  
pack_rows('changed sector', 4, 5) |> 
pack_rows('Private/Public', 6, 7)






#########################################
# kable experiments  #section
#########################################

#| label: tbl-team-moves-app-disapp
#| tbl-cap: a table

g1  <- fread('output/table-team-moves-firms-and-worksites-appearrs-disappears.csv')
# thecols  <- qc(type_lmarket, type_firm_ws_status)

lvl1  <- fread('output/levels-app-disapp.csv')

thecols  <- qc(type_firm_ws_status)
g2 <- g1[, !..thecols]
g2[, type_firm_ws_status2 := factor(type_firm_ws_status2, levels=lvl1$type_firm_ws_status2)]
setorder(g2, type_firm_ws_status2, type_lmarket)



g1  <- fread('output/table-team-moves-firms-and-worksites-appearrs-disappears.csv')
lvl1 <- fread('output/levels-app-disapp.csv')
# thecols  <- qc(type_lmarket, type_firm_ws_status)
thecols  <- qc(type_firm_ws_status)
g2 <- g1[, !..thecols]
g2[, type_firm_ws_status2 := factor(type_firm_ws_status2, levels=lvl1$type_firm_ws_status2)]
setorder(g2, type_firm_ws_status2, type_lmarket)
setcolorder(g2, c('type_lmarket', 'type_firm_ws_status2'))
# setnames(g2, 'type_firm_ws_status2', '')
# setnames(g2, 'type_firm_ws_status', '')


g2[, !'type_firm_ws_status2'] %>% kable('html') %>% kable_styling(full_width=FALSE, 
							bootstrap_options=qc(striped), 
							position='center', fixed_thead=T) |>  
kable_paper('hover', full_width=TRUE) |>
pack_rows('all firms and worksites exists', 1, 3) |>  
pack_rows('both firms existed, ws B appears', 4, 6) |>  
pack_rows('firm Y appears, ws B appears', 7, 9) |>
pack_rows('both firms existed, ws A disappears', 10, 12) |>
pack_rows('firm X & ws A disappears', 13, 15) |>
pack_rows('firms firms exists, ws A disappears, ws B appears', 16, 18) |>
pack_rows('XA disappears and YB appears', 19, 21)



```




rollup(j1,
	.(N = sum(N)),
	by = qc(type_move, type_lmarket))
# you only need to show the external market, since the rest is on the internal market


#######  #subsection ######
#  fig-team-moves-nace
##### subsection over #####

library(pals)


r1 <- read_xlsx('input/table-team-moves-n_inflow-nace5-lmarket.xlsx') |> data.table()
setnames(r1, 'n_inflow2', 'N')

# r1 <- r1[nace5 %!like% c('S |T |U ') & !is.na(nace5)]
r1 <- r1[ !is.na(nace5)]
# remove the ones with < 5000 moves 
r2  <- r1[nace5 %!in% 
	r1[, .(N=sum(N)), nace5][N < 5000, nace5]
	]

r2[, and := N/sum(N), .(type_move)]#[, and := round(and*100,0)]
r2[, and2 := N/sum(N), .(nace5, type_lmarket)]#[, and2 := round(and2*100,0)]
sum(r2$and); sum(r2$and2)


# you only need to show the external market, since the rest is on the internal market
# you only need to show the external market, since the rest is on the internal market
ggplot(r2[type_move %like% c( 'team' )], aes(nace5, and2, fill=nace5) ) + geom_col(color='black', position='dodge') + facet_wrap(~type_lmarket, scale='free_y') + theme_dark() + scale_fill_manual(values=cols25()) + guides(fill=guide_legend(ncol=5, byrow=TRUE)) + theme(legend.position='bottom') 


r2[nace5 %ilike% 'G '][, .(type_move, and2, type_lmarket)][order(type_lmarket)]




#
#
#
# ggplot(r2[nace5 %like% c( 'R |F ' )], aes(type_lmarket, and2, fill=nace5)) + geom_col(position='dodge') + facet_wrap(~type_move) + theme_dark()
#
#
# ggplot(r2[type_lmarket %like% c( 'external' )], aes(type_lmarket, and2, fill=nace5)) + geom_col(position='dodge') + facet_wrap(~type_move) + theme_dark(); bplot()
#
# ggplot(r2[type_move %like% c( 'team' )], aes(nace5, and2, fill=nace5) ) + geom_col(color='black', position='dodge') + facet_wrap(~type_lmarket) + theme_dark() + scale_fill_manual(values=cols25())
#
#
#
# ggplot(r2, aes(type_lmarket, and2, fill=nace5)) + geom_col(position='dodge') + facet_wrap(~type_move) + theme_dark()
