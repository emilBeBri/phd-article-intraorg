setwd('/home/emil/Dropbox/arbejde/cbs/phd/presentations/intra-org-inequality-budapest')
source('/home/emil/Dropbox/data-science/R/.minimal-Rprofile')
library(data.table)
library(purrr)
library(broom)
library(dttools)
library(knitr)
library(kableExtra)
library(readxl)
library(fs)
library(formattable)

# mod_ab0 = read_xlsx('input/models/modeloutput-block-A-B-AB-2.xlsx') |> data.table()
mod_ab0 = read_xlsx('input/models/etab_modelsC.xlsx') |> data.table()
setnames(mod_ab0, qc(V1, f1),qc(term0, coef0))
mod_ab0[grp %ilike% 'disco$', grp := gsub('(.*)', '\\16', grp) ]
mod_ab0[, grp := factor(grp)]
# levels(mod_ab0$grp)
# make grps
mod_ab0[, grp_mod := gsub('([a-z]+)_.*', '\\1', grp) |> factor()]
mod_ab0[, grp_fe := gsub('[a-z]+_(.*)', '\\1', grp) |> factor()]
# levels(mod_ab0$grp_mod)
# levels(mod_ab0$grp_fe)

# colc(mod_ab0)
# mod_ab0$term
# data.table(
#     from= map(qc(noman, man, all), ~{ .x %p0% '_disco' %p0% c('', 1:4) }),
#     to=c(
#         'noman disco' %p0% c(6, 1:4)
#     ) |> factor()
# )

dic_term = data.table( from=c(
'femaleTRUE',
'bin_noman_tie_maleTRUE',
'i(factor_var=female,var=bin_noman_tie_male,ref=FALSE)',
'bin_noman_tie_femaleTRUE',
'i(factor_var=female,var=bin_noman_tie_female,ref=FALSE)',
'bin_man_tie_maleTRUE',
'i(factor_var=female,var=bin_man_tie_male,ref=FALSE)',
'bin_man_tie_femaleTRUE',
'i(factor_var=female,var=bin_man_tie_female,ref=FALSE)'
))
dic_term$to = c (
    'female',
    'non-mgnr male tie',
    'non-mgnr male tie * female',
    'non-mgnr female tie',
    'non-mgnr female tie * female',
    'mgnr male tie',
    'mgnr male tie * female',
    'mgnr female tie',
    'mgnr female tie * female'
) |> factor()
# levels(dic_term$to)


thecols_coef_ctrl ='geo_west|alder|disco|heltid|privat|jobexp|n_arbnr'
# mod_ab0[ term0 %!ilike% thecols_coef_ctrl, ][, .N, term]
# mod_ab0[ term0 %ilike% thecols_coef_ctrl, ][, .N, term]
mod_ab1 =    mod_ab0[ term0 %!ilike% thecols_coef_ctrl, ]; nrf2(mod_ab0, mod_ab1)
# also remove the one NA at the top (make sure there is only one)
mod_ab1 = mod_ab1[!is.na(term0) & term0 %!ilike% 'Dependent Var\\.:' ]
 # mod_ab1[is.na(term) | term0 %ilike% 'Dependent Var\\.:' ]

dic_term = data.table( from=c(
'femaleTRUE',
'localundirected_transi_zero',
'i(factor_var=female,var=localundirected_transi_zero,ref=FALSE)',
'yulesq',
'i(factor_var=female,var=yulesq,ref=FALSE)'
))
dic_term$to = c (
    'female',
   'transitivity',
   'transitivity * female',
   'Yules Q',
   'Yules Q * female'
) |> factor()

# mod_ab1[, term := NULL ]
mod_ab1[dic_term, term := to, on=c(term0='from')]
mod_ab1[!dic_term, term := term0, on=c(term0='from')]
# mod_ab1[, .N, term]
# mod_ab1[, .N, term0]
# levels(mod_ab1$term)

setcolorder(mod_ab1, 'term')
for(xcol in colc(mod_ab1, '', not='term')) set(mod_ab1, i=which(is.na(mod_ab1[[xcol]])), j=xcol, value='')
mod_ab2 = copy(mod_ab1)
# change '---' delimiters to less
for( xcol in colc(mod_ab2))  {
# no_underscores = rep( '_' , max(nchar( mod_abc [[xcol]] ), na.rm=T ) ) |> paste(collapse='')
no_underscores = rep( '_' , 15 ) |> paste(collapse='')
    mod_ab2[get(xcol) %ilike% '_{3,}' , (xcol) := gsub('_{2,}', no_underscores, get(xcol))]
    mod_ab2[get(xcol) %ilike% '-{3,}' , (xcol) := gsub('-{2,}', no_underscores, get(xcol))][]
}

# mod_ab2 %>% kable('html') %>% kable_styling(bootstrap_options=qc(striped), position='left', fixed_thead=T)  %>% kable_paper('hover', full_width=TRUE)  
# View(mod_ab2 )

#########################################
# coefficient plots #section
#########################################

# models as plots
plot_ab1 = copy(mod_ab2)
# make me a loop in R
xcol = 'coef0'
# plot_ab1[get(xcol) %ilike% '\\(.*\\)'   , coef1 := gsub('(^[ ]*[-.0-9]*)[*]*.*', '\\1', get(xcol)) %>% gsub('(\\d).$','\\1',)  |> as.numeric()]
plot_ab1[get(xcol) %ilike% '\\(.*\\)'   , coef1 := gsub('(^[ ]*[-.0-9]*)([*]*.*)', '\\1', get(xcol)) ]
plot_ab1[get(xcol) %ilike% '\\(.*\\)'   , coef1 := gsub('(\\d).$','\\1', coef1) ]
plot_ab1[, coef1 :=  as.numeric(coef1)]
plot_ab1[get(xcol) %ilike% '\\(.*\\)'   , sd1 := 
    gsub('.*\\(([-.0-9]+)\\)', '\\1', get(xcol)) |> as.numeric()]

# plot_ab1[is.na(coef1), .(term, coef0, coef1, sd1)][sample(.N, 30)]


library(ggplot2)

# plot_ab1[, .N, grp]
# plot_ab1[, .N, term]

plot_ab2a = plot_ab1[( term %ilike% '^female$' | term %ilike% 'transi' ) & grp %ilike% 'transi'   ]
# plot_ab2a[, .N, grp]
# plot_ab2a[, .N, term]
# make a coef plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_ab2a, aes(coef1, term, group=grp_fe, fill=grp_fe), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7, shape=21) + 
# geom_linerange(aes(xmin=coef1-sd1, xmax=coef1+sd1), linewidth=2) + 
geom_errorbar(aes(color=grp_fe, xmin=coef1-sd1, xmax=coef1+sd1), width=0.1) + 
facet_wrap(~grp_mod, scales='free_y') +
# theme(legend.position='none') + 
labs(x='coef', y='term') +
geom_vline(xintercept=0, color='black') +
theme_bb() + scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05))
# plotly::ggplotly()

plot_ab2a[,.N,coef1 ]
plot_ab2a[term, ]
plot_ab2a[grp_fe, ]
plot_ab2a[sd1, ]


na.omit(plot_ab2a)

plot_ab2b = plot_ab1[( term %ilike% '^female$' | term %ilike% 'yule' ) & grp %ilike% 'yule'   ]
# plot_ab2b[, .N, grp]
# plot_ab2b[, .N, term]
# make a coef plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_ab2b, aes(coef1, term, group=grp_fe, fill=grp_fe), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7, shape=21) + 
# geom_linerange(aes(xmin=coef1-sd1, xmax=coef1+sd1), linewidth=2) + 
geom_errorbar(aes(color=grp_fe, xmin=coef1-sd1, xmax=coef1+sd1), width=0.1) + 
facet_wrap(~grp_mod, scales='free_y') +
# theme(legend.position='none') + 
labs(x='coef', y='term') +
geom_vline(xintercept=0, color='black') +
theme_bb() + scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05))
# plotly::ggplotly()


