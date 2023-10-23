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
mod_all2 = qread('tmp-data/models/mod_all2.qs', nthreads=no_threads)

###########################
# both noman and man #subsection




ecolr_grp_no_ties= ecolor_data[grp %ilike% 'nord aurora', hex][1:5]


# with varying slopes for year
plot_abg1 = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']


source('r/setup-labels-plot-abg1.R')
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
# ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,  shape=grp_fe, color=grp_no_ties)) + 
ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,   fill=grp_no_ties), shape=21) + 
# ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,  shape=grp_fe), color='black') + 
# geom_jitter(size=4, width=0, height=0.05) +
geom_point(size=4, shape=21, color='black') +
# geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
facet_wrap(~grp_fe) +
# scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
scale_fill_manual(values=ecolr_grp_no_ties) + 
theme_bb() + theme_dark()
# plotly::ggplotly()



# with non-varyiwng for year
plot_abg1 = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %in% c('arbnr','arbnr^bef_aar^disco6')]
source('r/setup-labels-plot-abg1.R')
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
# ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,  shape=grp_fe, color=grp_no_ties)) + 
ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,   fill=grp_no_ties), shape=21) + 
# ggplot(plot_abg1, aes(cof1, grp_lab, group=grp_mod,  shape=grp_fe), color='black') + 
# geom_jitter(size=4, width=0, height=0.05) +
geom_point(size=4, shape=21, color='black') +
# geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
facet_wrap(~grp_fe) +
# scale_y_discrete(labels=elab_noman_man) +
# theme(legend.position='none') + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
scale_fill_manual(values=ecolr_grp_no_ties) + 
theme_bb()  
# plotly::ggplotly()



##### subsection over #####
