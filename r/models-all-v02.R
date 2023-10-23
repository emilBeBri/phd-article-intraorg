setwd('/home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality')
source('/home/emil/Dropbox/data-science/R/.minimal-Rprofile')
library(magrittr)
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
library(patchwork)
ggplotly = plotly::ggplotly
get_legend=ggpubr::get_legend
as_ggplot=ggpubr::as_ggplot
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
# alone-noman    #section
#########################################

plot_noman1 = mod_all2[grp_mod == 'noman' & !is.na(cof1) & grp_fe_lab %ilike% '\\+' & grp_fe_lab %!ilike% '[12345]']
source('r/labels/labels-plot_noman.R')
qsave(plot_noman1, 'output/models/plot_noman_data.qs', preset=qs_preset, nthreads=no_threads)
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks

plot_noman2 = ggplot(plot_noman1, aes(cof1, grp_term_lab, group=grp_fe_lab, fill=grp_fe_lab), color='black') + 
# ggplot(plot_noman1, aes(cof1, term0, group=grp_fe_lab, shape=grp_fe_lab, color=grp_fe_lab), color='black') + 
# geom_point(size=4, position='jitter') + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab), width=0.1) + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.99, shape=21) + 
# theme(legend.position='none') + 
scale_color_manual(values=ecolr_fixed_arbnr_disco ) +
scale_fill_manual(values=ecolr_fixed_arbnr_disco ) +
labs(title='Coworker ties', x='% of wages (yearly)', y='', fill='FE type') +
geom_vline(xintercept=0, color='black') +
scale_y_discrete(labels=c('Woman, 0 ties', 'Woman, 1+ ties', 'Man, 1+ ties')) +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05)) + 
coord_cartesian(xlim = c(-.125, 0.1)) +
theme_bb()  
plot_noman2

plotly::ggplotly(plot_noman2)
ggsave(plot=plot_noman2, 'output/models/plot_noman.png', width=eplot_default_width, height=eplot_default_height, units='cm')
qsave(plot_noman2, 'output/models/plot_noman.qs', preset=qs_preset, nthreads=no_threads)


#########################################
# alone-man    #section
#########################################

plot_man1 = mod_all2[grp_mod == 'man' & !is.na(cof1) & grp_fe_lab %ilike% '\\+' & grp_fe_lab %!ilike% '[12345]']
source('r/labels/labels-plot_man.R')
qsave(plot_man1, 'output/models/plot_man_data.qs', preset=qs_preset, nthreads=no_threads)
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
plot_man2 = ggplot(plot_man1, aes(cof1, grp_term_lab, group=grp_fe_lab, fill=grp_fe_lab), color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.99, shape=21) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab), width=0.1) + 
# theme(legend.position='none') + 
scale_color_manual(values=ecolr_fixed_arbnr_disco ) +
scale_fill_manual(values=ecolr_fixed_arbnr_disco ) +
labs(title='Manager ties', x='% of wages (yearly)', y='', fill='FE type') +
geom_vline(xintercept=0, color='black') +
scale_y_discrete(labels=c('Woman, 0 ties', 'Woman, 1+ ties', 'Man, 1+ ties')) +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05)) + 
coord_cartesian(xlim = c(-.125, 0.125)) +
theme_bb()  
plot_man2
plotly::ggplotly(plot_man2)
ggsave(plot=plot_man2, 'output/models/plot_man.png', width=eplot_default_width, height=eplot_default_height, units='cm')
qsave(plot_man2, 'output/models/plot_man.qs', preset=qs_preset, nthreads=no_threads)

# to talk about (both noman and man)

### to talk about: 

# the diff btw worksite an worksite-occ in FE - so that is the unobservables, controlled for time?
# I wonder what the diff is in having woman 1+ ties, and the three different FEs. almost zero w. ws-occ.

#########################################
# alone-noman & alone-man: i samme plot #section
#########################################


# plot_ab1 = mod_all2[grp_mod %in% qc(noman, man) 
#     & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[' ]
# # make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
# # ggplot(plot_noman1, aes(cof1, grp_koen_tie, group=grp_mod, color=grp_mod, shape=grp_fe), color='black') + 
# g1 = ggplot(plot_ab1, aes(cof1, grp_koen_tie, group=grp_mod, color=grp_mod, shape=grp_fe)) + 
# # geom_jitter(size=4, width=0, height=0.05, alpha=0.7) +
# geom_point(size=3,  alpha=0.9) +
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
# # geom_errorbar(aes(color=grp_mod, xmin=cof1-sd1, xmax=cof1+sd1), color='grey45', width=0.1) + 
# # facet_wrap(~grp_mod)
# # theme(legend.position='none') + 
# geom_vline(xintercept=0, color='black') +
# # scale_x_continuous(breaks= seq(-0.1, 0.1, 0.025), limits=c(-0.1, 0.05)) + 
# # scale_color_manual(values=c(ecolr_noman_man )) +
# scale_color_manual(values=c(ecolr_noman_man), labels=c('Non-manager tie', 'Manager tie')) +
# scale_shape_discrete(labels=c('Worksite', 'Worksite-ISCO-year')) +
# scale_y_discrete(labels=c('Woman with\n contact(s)', 'Man without\n contact(s)', 'Man with\n contact(s)')) +
# # scale_shape_manual(values=c(ecolr_noman_man),breaks=c('worksite', 'worksite-occupation')) +
# labs(x='Log of yearly wages', y='', color='Coef. type: ', shape='F.E. type: ') +
# theme_bb() 
# addSmallLegend(g1, 5, 10, 1)
# # save plot to file in cm
# ggsave('output/models/plot_ab1.png', width=eplot_def_width, height=eplot_def_height, units='cm')
# g1
# # plotly::ggplotly()


#########################################
# alone-noman-man  #section
#########################################

# thecols = c('term0', 'sd1', 'cof1', colc(mod_all2, '^grp'))
#  = mod_all2[, ..thecols]

plot_noman_man1 = mod_all2[grp_mod == 'noman_man' & !is.na(cof1) & grp_fe_lab %ilike% '\\+' & grp_fe_lab %!ilike% '[12345]']
source('r/labels/labels-plot_noman_man.R')
qsave(plot_noman_man1, 'output/models/plot_noman_man_data.qs', preset=qs_preset, nthreads=no_threads)





# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
plot_noman_man2 = ggplot(plot_noman_man1, aes(cof1, grp_term_lab, group=grp_fe_lab, fill=grp_fe_lab), color='black') + 
# ggplot(plot_noman_man1, aes(cof1, term0, group=grp_fe_lab, shape=grp_fe_lab, color=grp_fe_lab), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1 ), width=0.01, size=0.7) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab ), width=0.1) + 
geom_jitter(size=5, width=0, height=0.00, alpha=0.99, shape=21) + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1, fill=grp_fe_lab), color='grey45', width=0.1) + 
theme(legend.position='none') + 
scale_color_manual(values=ecolr_fixed_arbnr_disco ) +
scale_fill_manual(values=ecolr_fixed_arbnr_disco ) +
labs(title='noman_manager ties', x='% of wages (yearly)', y='', fill='FE type', color='') +
theme(axis.text.y=element_blank(), axis.ticks.y=element_blank() ) + 
guides(color = FALSE) +
geom_vline(xintercept=0, color='black') +
scale_x_continuous(breaks= seq(-0.1, 0.15, 0.05)) + 
coord_cartesian(xlim = c(-.125, 0.15)) +
theme_bb()  
plot_noman_man2


# legend 1
p_leg1 =ggplot(p_dat_legend_noman_man, aes(x=x, y=grp_term_lab, shape=grp_man_alter)) + 
geom_point(size=5, color='black', fill='grey75') + 
theme_bb() + 
theme_void() + 
theme(legend.position="none") +
scale_shape_manual(values=c(22,24)) +
coord_cartesian(xlim=c(0.90,2.10))
p_leg1

# legend 2
p_leg2 = p_dat_legend_noman_man[, .(grp_term_lab, grp_koen_ego)]    %>% unique()
p_leg2$x = 1
p_leg2 =ggplot(p_leg2, aes(x=x, y=grp_term_lab, shape=grp_koen_ego)) + 
geom_point(size=10, color='black', fill='grey75') + 
theme_bb() + 
theme_void() + 
theme(legend.position="none") +
scale_shape_manual(values=c("\u2640","\u2642"))  +
coord_cartesian(xlim=c(1,1))
p_leg2


# make legend for manager / non manager
legdat_man = data.table(
    grp=c('Coworker', "Manager"), x=1:2, y=1:2)
leg_man = ggplot(legdat_man , aes(x, y, shape=grp)) + geom_point(size=3, fill='grey75') +
scale_shape_manual(values=c(22,24)) + labs(shape='') + theme_void() +
theme(legend.direction="horizontal") 
leg_man = ggpubr::get_legend(leg_man)
leg_man = ggpubr::as_ggplot(leg_man)
leg_man

# make legend for fixed effects
legdat_fe = data.table(
    grp=c('WS+Year', 'WS-I6+Year'), x=1:2, y=1:2)
leg_fe = ggplot(legdat_fe , aes(x, y, color=grp)) + geom_point(size=3, fill='grey75') +
scale_color_manual(values=ecolr_fixed_arbnr_disco) + labs(color='FE type') + 
# theme(legend.direction="horizontal") +
theme_void() 
leg_fe = ggpubr::get_legend(leg_fe)
leg_fe = ggpubr::as_ggplot(leg_fe)
leg_fe



p_whole=
p_leg1 + plot_noman_man2 + p_leg2 + plot_layout(design=
  c(
    area(l=1,  r=6, t=0, b=1), 
    area(l=7, r=50, t=0, b=1), 
    area(l=4, r=10, t=0, b=1)
  )) 
p_whole

plot_noman_man3= p_whole + 
inset_element(leg_man, left = 0.25, bottom = 2.002, right = 0.0, top = 0.0) +
inset_element(leg_fe, left = 0.0, bottom = 0.0, right = 10.01, top = .3) 
plot_noman_man3
# plotly::ggplotly(plot_noman_man2)
ggsave(plot=plot_noman_man3, 'output/models/plot_noman_man.png', width=eplot_def_width, height=eplot_def_height, units='cm')
qsave(plot_noman_man3, 'output/models/plot_noman_man.qs', preset=qs_preset, nthreads=no_threads)





#########################################
# alter-noman #section
#########################################



plot_noman_g1 = mod_all2[grp_mod == 'noman_g' & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco[6]']
source('r/labels/labels-plot_noman_g.R')
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
plot_noman_g2 = ggplot(plot_noman_g1, aes(cof1, grp_term_lab, group=grp_fe_lab,  color=grp_fe_lab, shape=grp_koen_homo), color='black') + 
# ggplot(plot_noman_g1, aes(cof1, term0, group=grp_fe_lab, shape=grp_fe_lab, color=grp_fe_lab), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab), width=0.1) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1, fill=grp_fe_lab), color='grey45', width=0.1) + 
# theme(legend.position='none') + 
labs(title='coworker - alter gender', x='% of wages (yearly)', y='Coworker tie', color='FE type') +
geom_vline(xintercept=0, color='black') +
# scale_y_discrete(labels=elab_noman_man) +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
theme_bb()  
plot_noman_g2
plotly::ggplotly(plot_noman_g2)
ggsave(plot=plot_noman_g2, 'output/models/plot_noman_g.png', width=eplot_def_width, height=eplot_def_height, units='cm')
qsave(plot_noman_g2, 'output/models/plot_noman_g.qs', preset=qs_preset, nthreads=no_threads)




#########################################
# alter-man #section
#########################################



plot_man_g1 = mod_all2[grp_mod == 'man_g' & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco[6]']
source('r/labels/labels-plot_man_g.R')
# make a cof plot with conf intervals in ggplot and x axis should have 0.025 as tick marks
plot_man_g2 = ggplot(plot_man_g1, aes(cof1, grp_term_lab, group=grp_fe_lab,  color=grp_fe_lab, shape=grp_koen_homo), color='black') + 
# ggplot(plot_man_g1, aes(cof1, term0, group=grp_fe_lab, shape=grp_fe_lab, color=grp_fe_lab), color='black') + 
# geom_point(size=4, position='jitter') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7) + 
# geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab), width=0.1) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1, fill=grp_fe_lab), color='grey45', width=0.1) + 
# theme(legend.position='none') + 
labs(title='Manager - alter gender', x='% of wages (yearly)', y='Coworker tie', color='FE type') +
geom_vline(xintercept=0, color='black') +
# scale_y_discrete(labels=elab_man_man) +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
theme_bb()  
plot_man_g2
plotly::ggplotly(plot_man_g2)
ggsave(plot=plot_man_g2, 'output/models/plot_man_g.png', width=eplot_def_width, height=eplot_def_height, units='cm')
qsave(plot_man_g2, 'output/models/plot_man_g.qs', preset=qs_preset, nthreads=no_threads)




#########################################
# alter-noman_man_g (The Grand Fucking One) #section
#########################################

        
plot_noman_man_g1 = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %in% 'arbnr^disco6 + bef_aar']
source('r/labels/labels-plot_noman_man_g.R')
# levels(plot_noman_man_g1$grp_term_lab)


plot_noman_man_g2 = copy(plot_noman_man_g1)

p_noman_man_g_main = ggplot(plot_noman_man_g2, aes(x=cof1, y=grp_term_lab, fill=grp_koen_ego)) +
scale_x_continuous(breaks= seq(-0.1, 0.15, 0.05), limits=c(-0.1, 0.15)) + 
geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1), width=0.001) + 
geom_point(size=5, shape=21) + 
# scale_color_viridis() +
# scale_color_manual(values=c(p0('darkseagreen', 1:4),'black')) +
# scale_color_manual(values=c(ecolr_no_ties)) +
scale_fill_manual(values=c( "#BF2F24", "#436685")) +
scale_shape_manual(values=c(23,24)) +
# scale_color_manual(values=c( "#436685" , "#E7B800" )) +
geom_vline(xintercept=0, color='black', size=1.25) +
labs(x='% of wages (yearly)', y='', fill='') +
theme(axis.text.y=element_blank(), axis.ticks.y=element_blank() ) + 
theme(legend.position='none') + 
theme_bb()
p_noman_man_g_main




p_dat_legend_noman_man_g2 = copy(p_dat_legend_noman_man_g)
p_dat_legend_noman_man_g2[x == 1, x  := 0]
p_dat_legend_noman_man_g2[x == 2, x  := 0.5]
p_dat_legend_noman_man_g2[x == 3, x  := 1.5]
p_dat_legend_noman_man_g2[x == 4, x  := 2]
# p_leg1 =ggplot(p_dat_legend_noman_man_g2, aes(x=x, y=grp_term_lab, color=alter_female, shape=manager)) + 
p_leg1 =ggplot(p_dat_legend_noman_man_g2, aes(x=x, y=grp_term_lab, fill=alter_female, shape=manager)) + 
geom_point(size=5) + 
theme_bb() + 
# theme(axis.text.y=element_blank(), axis.ticks.y=element_blank() ) + 
theme_void() + 
theme(legend.position="none") +
scale_fill_manual(values=c("#436685",  "#BF2F24")) +
# scale_color_manual(values=c("#436685",  "#BF2F24")) 
scale_shape_manual(values=c(22,24)) 
# scale_shape_manual(values=c(16,eplot_def_height,17)) 
# scale_color_manual(values=c("#436685", 'black', "#BF2F24"))  +
# scale_shape_manual(values=c(16,eplot_def_height,17)) 
# scale_x_continuous(breaks= seq(0,1,.25)) 
p_leg1

# p_dat_legend_noman_man_g2[grp_term_lab == 'female-noman-female-0-male-0-man-female-0-male-0']





p_whole=
  # syntax from `patchwork`
p_leg1 + p_noman_man_g_main + plot_layout(design=
  c(
    area(l=0,  r=6, t=0, b=1), # defines the main figure area
    area(l=7, r=50, t=0, b=1)  # defines the gap figure area
  )) 
p_whole








library(viridis)

# p_dat_dt3t = p_dat_dt3[grp_term_lab %in% test_set]
# p_dat_legend_noman_man_gt = copy(p_dat_legend_noman_man_g)
# p_dat_legend_noman_man_gt[, x  :=  fcase(
#     x == 1, 0,
#     x == 2, 0.1,
#     x == 3, 0.2,
#     x == 4, 0.3
# )]
# t1=data.table(x=1)
# t1[, grp_term_lab  := factor('the great divide', levels=levels(p_dat_legend_noman_man_g$grp_term_lab))]
# t1[, grp_ego  := 'other']
# t1[, alter_female  := 'other']
# t1[, manager  := 'other']
# p_dat_legend_noman_man_g2= rbind(p_dat_legend_noman_man_g,t1 , use.names=TRUE, fill=TRUE)




# levels(p_dat_legend_noman_man_gt$grp_term_lab) == levels(plot_noman_man_g2$grp_term_lab)

plot_noman_man_g2$grp_term_lab
plot_noman_man_g2[, .(grp_term_lab, grp_koen_homo)]  %>% View()



p_old = ggplot(plot_noman_man_g2, aes(x=cof1, y=grp_term_lab, 
    # color=grp_koen_ego)) +
    color=grp_koen_homo)) +
geom_point(size=3) + 
scale_x_continuous(breaks= seq(-0.1, 0.15, 0.05), limits=c(-0.1, 0.15)) + 
# scale_color_manual(values=c( "#BF2F24", "#436685")) +
scale_color_manual(values=c( "#436685" , "#E7B800" )) +
geom_vline(xintercept=0, color='black') +
labs(y='') +  
  # theme(axis.text.y=element_blank(),
  #       axis.ticks.y=element_blank() 
  #       ) + 
theme_bb()
p_old




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
# ggplotly()




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
plot_sens_noman_man = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1) & grp_fe_lab %!ilike% '[1234]' & grp_fe_lab %ilike% '/|\\+']

# ggplot(plot_sens_noman_man, aes(cof1, term0, group=grp_mod, fill=grp_fe_lab, shape=grp_disco_lvl ), color='black') + 
ggplot(plot_sens_noman_man, aes(cof1, term0, group=grp_mod, fill=grp_fe_type, shape=grp_disco_lvl ), color='black') + 
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





# noman no alter
plot_sens_noman = mod_all2[grp_mod %in% qc(noman) & !is.na(cof1)]
# ggplot(plot_sens_noman, aes(cof1, grp_fe_lab, group=grp_mod, color=grp_fe_s, shape=grp_disco_lvl)) + 
ggplot(plot_sens_noman, aes(cof1, grp_fe_lab, group=grp_mod, color=grp_fe_s)) + 
geom_jitter(size=6, width=0, height=0.05, alpha=0.7) +
# geom_errorbar(aes(color=grp_fe, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
facet_wrap(~term0) +
labs(x='coef', y='fixed effect type') +
geom_vline(xintercept=0, color='black') +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
# scale_fill_manual(values=c(ecolr_fixed_arbnr,  ecolr_fixed_disco)) +
# scale_color_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_disco)) +
theme_bb() 
# plotly::ggplotly()


# noman  alter
plot_sens_noman_g = mod_all2[grp_mod %in% qc(noman_g) & !is.na(cof1)]
# ggplot(plot_sens_noman_g, aes(cof1, grp_fe_lab, group=grp_mod, color=grp_fe_s, shape=grp_disco_lvl)) + 
ggplot(plot_sens_noman_g, aes(cof1, grp_fe_lab, group=grp_mod, color=grp_fe_s)) + 
geom_jitter(size=6, width=0, height=0.05, alpha=0.7) +
# geom_errorbar(aes(color=grp_fe, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
facet_wrap(~term0) +
geom_vline(xintercept=0, color='black') +
scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
# scale_fill_manual(values=c(ecolr_fixed_arbnr,  ecolr_fixed_disco)) +
# scale_color_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_disco)) +
theme_bb() 
# plotly::ggplotly()




# noman  alter - version w. deviations from arbnr FE



plot_sens_noman_g_b = mod_all2[grp_mod %in% qc(noman_g) & !is.na(cof1)]
t1=plot_sens_noman_g_b[grp_fe == 'arbnr', .(cof1, term0, grp_fe)]
# t2=plot_sens_noman_g_b[grp_fe == 'arbnr^disco6', .(cof1, term0, grp_fe)]
plot_sens_noman_g_b[t1, cof_fe_arbnr  := i.cof1 - cof1, on=.(term0)]


# errorcheck
stopifnot('something wrong in the join' = plot_sens_noman_g_b[ cof1 == cof_fe_arbnr, .N] == t1[, .N])


# noman  alter
# ggplot(plot_sens_noman_g, aes(cof1, grp_fe_lab, group=grp_mod, color=grp_fe_s, shape=grp_disco_lvl)) + 
ggplot(plot_sens_noman_g_b, aes(cof_fe_arbnr, grp_fe_lab, group=grp_mod, color=grp_fe_s)) + 
geom_jitter(size=6, width=0, height=0.05, alpha=0.7) +
# geom_errorbar(aes(color=grp_fe, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
facet_wrap(~term0) +
geom_vline(xintercept=0, color='black') +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05), limits=c(-0.1, 0.1)) + 
# scale_fill_manual(values=c(ecolr_fixed_arbnr,  ecolr_fixed_disco)) +
# scale_color_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_disco)) +
theme_bb() 
# plotly::ggplotly()


# #spm-til-lasse : med additiv year-effect er er forskllen altid stoerre, aldrig mindre, end uden - er det ikke lidt interessant? 


# with degree fe
ggplot(plot_sens0, aes(cof1, term0, group=grp_mod, fill=grp_fe ), shape=21, color='black') + 
geom_jitter(size=4, width=0, height=0.05, alpha=0.7, shape=21) +
geom_errorbar(aes(color=grp_fe, xmin=cof1-sd1, xmax=cof1+sd1), width=0.1) + 
labs(x='cof', y='term') +
geom_vline(xintercept=0, color='black') +
scale_fill_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_degree, ecolr_fixed_disco)) +
scale_color_manual(values=c(ecolr_fixed_arbnr, ecolr_fixed_degree, ecolr_fixed_disco)) +
theme_bb() 
# plotly::ggplotly()




