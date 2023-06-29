# mod_ab0 = read_xlsx('input/models/modeloutput-block-A-B-AB-2.xlsx') |> data.table()
mod_ab0 = read_xlsx('input/models/modeloutput-block-AB-etable.xlsx') |> data.table()
thecols_coef_ctrl ='geo_west|alder|disco|heltid|privat|jobexp|n_arbnr'
# mod_ab0[ term %!ilike% thecols_coef_ctrl, !'statistic'][, .N, term]
mod_ab1 =    mod_ab0[ term %!ilike% thecols_coef_ctrl, !'statistic']
setnames(mod_ab1, qc(std.error, estimate), qc(std, coef ))
thecols = qc(std, coef)
mod_ab1[, p :=  ''][p.value < .1, p := ' *'] %>%
    .[p.value < .05, p := ' **'] %>%
    .[p.value < .01, p := ' ***']
mod_ab1[, p.value := NULL]
mod_ab1[, (thecols) := map(100*.SD, round, 1), .SDcols=thecols]
setorder(mod_ab1, mod)
setorder(mod_ab1, term)

wc(mod_ab1, 'term', 10)


dic_term = data.table( from=c(
	'bin_degreeTRUE',
	'i(factor_var = female, var = bin_degree, ref = FALSE)',
	'bin_gender_tie_homoTRUE',
	'i(factor_var = female, var = bin_gender_tie_homo, ref = FALSE)',
	'bin_man_tieTRUE',
	'i(factor_var = female, var = bin_man_tie, ref = FALSE)',
	'bin_man_tie_homoTRUE',
	'i(factor_var = female, var = bin_man_tie_homo, ref = FALSE)',
	'bin_noman_tieTRUE',
	'i(factor_var = female, var = bin_noman_tie, ref = FALSE)',
	'bin_noman_tie_homoTRUE',
	'i(factor_var = female, var = bin_noman_tie_homo, ref = FALSE)'
)) 

dic_term$to = c(
        'tie',
        'tie * female',
        'homoph. tie',
       'homoph. tie * female',
        'man. tie',
        'man. tie * female',
        'homoph. man. tie',
       'homoph. man. tie * female',
        'tie',
        'tie * female',
        'homoph. tie',
       'homoph. tie * female'
)

# dic_term$to = c(
#         'tie',
#         'tie * female',
#         'homoph. tie',
#        'homoph. tie * female',
#         'man. tie',
#         'man. tie * female',
#         'homoph. man. tie',
#        'homoph. man. tie * female',
#         'non-man. tie',
#         'non-man. tie * female',
#         'homoph. non-man. tie',
#        'homoph. non-man. tie * female'
# )

dic_term$to = c(
        'tie',
        'tie * female',
        'homoph. tie',
       'homoph. tie * female',
        'man. tie',
        'man. tie * female',
        'homoph. man. tie',
       'homoph. man. tie * female',
        'tie',
        'tie * female',
        'homoph. tie',
       'homoph. tie * female'
)

# change nonman tie to just tie


mod_ab1[dic_term, term2 := to, on=c(term='from')]
mod_ab1[, term2 := factor(term2, levels=unique(dic_term$to)) ]
mod_ab1[, coef2 := paste0(coef, p)]
mod_ab1[, std2 := paste0('(', std, ')')]
mod_ab1[, mod2 := factor(mod, levels=qc(A, Ah, B, Bh, AB, ABh))]

mod_ab2 = mod_ab1[, .(mod=mod2, term=term2, coef=coef2, std=std2)]
setorder(mod_ab2, mod) 
mod_ab3a = dcast(mod_ab2, term  ~ mod, value.var = qc(coef))
mod_ab3b = dcast(mod_ab2, term  ~ mod, value.var = qc( std))
mod_ab3a[, flag_std := FALSE]
mod_ab3b[, flag_std := TRUE]

mod_ab4 = rbind(mod_ab3a, mod_ab3b, use.names=TRUE)
setorder(mod_ab4, term)
for(xcol in colc(mod_ab4, '', not='term')) set(mod_ab4, i=which(is.na(mod_ab4[[xcol]])), j=xcol, value='')

mod_ab4[flag_std == TRUE, term := ''][, flag_std := NULL]


mod_ab4 %>% kable('html') %>% kable_styling(bootstrap_options=qc(striped), position='left', fixed_thead=T)  %>% kable_paper('hover', full_width=TRUE)  




# function needed 


wc <- function(df1, var='pnr', n=1, from='head', all=FALSE, sample=FALSE) {

		# df1 <- y_pnr
		# var <- 'pnr'
		# from <- 'tail'
		# n <- 1
  # require(clipr)

	stopifnot('col does not exit' = var %in% colnames(df1))

  if(all==TRUE) n <- nrow(df1)
	index <- 1:n
	if(from == 'tail') index <- (nrow(df1)	-n):nrow(df1)	
		

  if(sample==TRUE) {
    clipr::write_clip(
    df1[seq(1,nrow(df1),ceiling((nrow(df1)/n))), get(var)]
    , col.names=F)
  } else {
  	clipr::write_clip(df1[index, get(var)] , col.names=F)
  } 




}



