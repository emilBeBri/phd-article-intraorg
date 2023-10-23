setwd('/home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality')
source('/home/emil/Dropbox/data-science/R/.minimal-Rprofile')
library(data.table)
library(purrr)
library(dttools)
library(readxl)
library(qs)
library(broom)
library(knitr)
library(formattable)
library(fs)
library(kableExtra)
library(ggplot2)
source('r/preprocessing-models.R')
source('r/setup-dataviz-colors.R')
# mod_all2 = qread('tmp-data/models/mod_all2.qs', nthreads=no_threads)



# n1 = qread('tmp-data/models/mod_all2_net.qs', nthreads=no_threads)
# a1 = qread('tmp-data/models/mod_all2_all.qs', nthreads=no_threads)
#
# n1[, .N,  by=grp_mod]
# n1[, .N,  by=grp_fe]
#
# t1 = map(list(n1, a1), \(.x){
#     .x = n1
#     .x[grp_mod %in% 'noman' & grp_fe %in% 'arbnr_disco6']
# })
# map(t1, ~ .x[, .(cof1)])



#########################################
# cofficient plots no-alters  #section
#########################################

plot_ab1 = mod_all2[grp %!ilike% 'transi|yq_' & grp_mod %ilike% 'noman' & grp_mod %!ilike% '_g']

###########################
# version 1: hver for sig #sebsection

plot_a1 = mod_all2[grp_mod == 'noman' & !is.na(cof1) & grp_fe_lab %ilike% 'WS-only$|disco6']
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_a1, aes(cof1, term0, group=grp_fe, shape=grp_fe, color=grp_fe), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe), width=0.1) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1, fill=grp_fe), color='grey45', width=0.1) + 
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()

# #spm: hvorfor er effekten af arbnr-disco mindre end arbnr-disco-aar?


plot_b1 = mod_all2[grp_mod == 'man' & !is.na(cof1) & grp_fe %ilike% 'arbnr$|\\+']
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_b1, aes(cof1, term0, group=grp_fe, shape=grp_fe, color=grp_fe), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe), width=0.1) + 
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()


##### subsection over #####

###########################
# version 2: i samme plot #sebsection

plot_ab1 = mod_all2[grp_mod %in% qc(noman, man) 
    & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[' ]

# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
# ggplot(plot_a1, aes(cof1, grp_koen_tie, group=grp_mod, color=grp_mod, shape=grp_fe), color='black') + 
g1 = ggplot(plot_ab1, aes(cof1, grp_koen_tie, group=grp_mod, color=grp_mod, shape=grp_fe)) + 
# geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_point(size=3,  alpha=0.9) +
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
# geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
# facet_wrap(~grp_mod)
# theme(legend.position='none') + 
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
# scale_color_manual(values=c(ecolr_noman_man )) +
scale_color_manual(values=c(ecolr_noman_man), labels=c('Non-manager tie', 'Manager tie')) +
scale_shape_discrete(labels=c('Worksite', 'Worksite-ISCO-year')) +
scale_y_discrete(labels=c('Woman with\n contact(s)', 'Man without\n contact(s)', 'Man with\n contact(s)')) +
# scale_shape_manual(values=c(ecolr_noman_man),breaks=c('worksite', 'worksite-occupation')) +
labs(x='Log of yearly wages', y='', color='Coef. type: ', shape='F.E. type: ') +
theme_bb() 
addSmallLegend(g1, 5, 10, 1)
# save plot to file in cm
ggsave('output/models/plot_ab1.png', width=18, height=15, units='cm')
g1
# plotly::ggplotly()




##### subsection over #####



# plot with both noman and man 

# thecols = c('term0', 'sd1', 'cof1', colc(mod_all2, '^grp'))
#  = mod_all2[, ..thecols]
plot_ab1 = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
elab_noman_man=c(
    'Woman w. manager tie',
    'Woman w. non-manager tie',
    'Woman w. both tie types',
    'Man without ties',
    'Man w. manager tie',
    'Man w. non-manager tie',
    'Man w. both tie types'
)

# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_ab1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()



#########################################
# with alter-gender #section
#########################################


plot_ag1 = mod_all2[grp_mod %in% qc(noman_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
elab_noman_g=c(
    'Woman w. female non-manager tie',
    'Woman w. male non-manager tie',
    'Woman w. both non-manager tie',
    'Man w. no tie',
    'Man w. female non-manager tie',
    'Man w. male non-manager tie',
    'Man w. both non-manager tie'
)

# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_ag1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()


plot_bg1 = mod_all2[grp_mod %in% qc(man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
elab_noman_g=c(
    'Woman w. female non-manager tie',
    'Woman w. male non-manager tie',
    'Woman w. both non-manager tie',
    'Man w. no tie',
    'Man w. female non-manager tie',
    'Man w. male non-manager tie',
    'Man w. both non-manager tie'
)
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_bg1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
# scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()

plot_abg1 = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
elab_noman_g=c(
    'Woman w. female non-manager tie',
    'Woman w. male non-manager tie',
    'Woman w. both non-manager tie',
    'Man w. no tie',
    'Man w. female non-manager tie',
    'Man w. male non-manager tie',
    'Man w. both non-manager tie'
)

# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
ggplot(plot_abg1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
# scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
theme_bb()  
# plotly::ggplotly()

#########################################
# transitivity etc #section
#########################################

plot_t1 = mod_all2[grp_mod %in% qc(transi) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
ggplot(plot_t1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
scale_x_continuous(breaks= seq(-0.05, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
theme_bb()  


plot_y1 = mod_all2[grp_mod %in% qc(yq) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
ggplot(plot_y1, aes(cof1, term0, group=grp_mod,  shape=grp_fe), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
scale_x_continuous(breaks= seq(-0.05, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
theme_bb()  

#########################################
# sensitivity analysis #section
#########################################



# plot_sens0 = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1)]
plot_sens0 = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1) & grp_fe_lab %!ilike% '[1234]' & grp_fe_lab %ilike% '/|\\+']

# ggplot(plot_sens0, aes(cof1, term0, group=grp_mod, fill=grp_fe_lab, shape=grp_disco_lvl ), color='black') + 
ggplot(plot_sens0, aes(cof1, term0, group=grp_mod, fill=grp_fe_type, shape=grp_disco_lvl ), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_fe_type, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
# geom_errorbar(aes(color=grp_fe_lab, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
scale_shape_manual(values=c(21:25)) +
scale_fill_manual(values=c(ecolr_fixed_arbnr,  ecolr_fixed_disco)) +
scale_color_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_disco)) +
theme_bb() 
# plotly::ggplotly()








