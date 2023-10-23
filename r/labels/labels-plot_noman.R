
# plot_noman1$term0 %>% unique()  %>%  write_clip() 
# grp_noman_tie = female-noman-0
# grp_noman_tie = female-noman-1
# grp_noman_tie = male-noman-1

# plot_noman1$term0 %>%  uniqueN(.)
# plot_noman1$term0 %>%  length(.)


elab_plot_noman = data.table()

elab_plot_noman$from = c(
    'grp_noman_tie = female-noman-0',
    'grp_noman_tie = female-noman-1',
    'grp_noman_tie = male-noman-1'
)


# errorcheck
stopifnot('the labels do not match' = { 
    t1 = sets(elab_plot_noman$from, plot_noman1$term0)
    t1$in_x  %>% length() + t1$in_y  %>% length() == 0   
})



elab_plot_noman$to = c(
    'female-noman-0',
    'female-noman-1',
    'male-noman-1'
)
elab_plot_noman$grp_term_lab = elab_plot_noman$to %>% factor()
# levels(elab_plot_noman$to)

# fwrite(elab_plot_noman, 'tmp-data/label-dictionaries/elab_plot_noman.csv', sep=';')
# system('alacritty -e visidata tmp-data/label-dictionaries/elab_plot_noman.csv --csv-delimiter=";"')



# levels(elab_plot_noman$to)



# plot_noman = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
plot_noman1[elab_plot_noman, grp_term_lab := grp_term_lab, on=c(term0='from')]
# errorcheck
stopifnot('there should be no missing labels' = plot_noman1[is.na(grp_term_lab), .N] == 0 )

#
# #########################################
# # DT for visual labels in legend #section
# #########################################
#
#
# ###########################
# # make the DTs #subsection
#
# p_leg_dat_noman1 = unique(plot_noman1[, .(grp_term_lab, grp_koen_ego, grp_man_alter, grp_koen_alter)])
# p_leg_dat_noman1[grp_term_lab == 'female-noman-0', grp_man_alter   := NA]
# # p_dat_dt1[, x := 1:.N  %>% as.double]
# p_leg_dat_noman1 $x = c(0,1,2)  %>% as.double()
#
#
# p_leg1 =ggplot(p_leg_dat_noman1 , aes(x=x, y=grp_term_lab, shape=grp_man_alter)) + 
# geom_point(size=5, color='black', fill='grey75') + 
# theme_bb() + 
# theme_void() + 
# theme(legend.position="none") +
# scale_shape_manual(values=c(24,22)) 
# p_leg1
#
#
# p_leg1
#
#
#
# plot_noman2 = ggplot(plot_noman1, aes(cof1, grp_term_lab, group=grp_fe_lab, fill=grp_fe_lab), color='black') + 
# # ggplot(plot_noman1, aes(cof1, term0, group=grp_fe_lab, shape=grp_fe_lab, color=grp_fe_lab), color='black') + 
# # geom_point(size=4, position='jitter') + 
# geom_jitter(size=4, width=0, height=0.05, alpha=0.7, shape=21) + 
# # geom_linerange(aes(xmin=cof1-sd1, xmax=cof1+sd1), linewidth=2) + 
# geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1,  color=grp_fe_lab), width=0.1) + 
# # geom_errorbar(aes( xmin=cof1-sd1, xmax=cof1+sd1, fill=grp_fe_lab), color='grey45', width=0.1) + 
# # theme(legend.position='none') + 
# scale_color_manual(values=ecolr_fixed_arbnr_disco ) +
# scale_fill_manual(values=ecolr_fixed_arbnr_disco ) +
# labs(title='Coworker ties', x='% of wages (yearly)', y='', fill='FE type') +
# geom_vline(xintercept=0, color='black') +
# scale_y_discrete(labels=c('Woman, 0 ties', 'Woman, 1+ ties', 'Man, 1+ ties')) +
# scale_x_continuous(breaks= seq(-0.1, 0.1, 0.05)) + 
# coord_cartesian(xlim = c(-.125, 0.1)) +
# theme_bb()  
# plot_noman2
#
#
#
#
#
#
#
# # scale_color_viridis() +
# # scale_color_manual(values=c(p0('darkseagreen', 1:4),'black')) +
# # scale_color_manual(values=c(ecolr_no_ties)) +
# scale_fill_manual(values=c( "#BF2F24", "#436685")) +
# scale_shape_manual(values=c(23,24)) +
# # scale_color_manual(values=c( "#436685" , "#E7B800" )) +
# geom_vline(xintercept=0, color='black', size=1.25) +
# labs(x='% of wages (yearly)', y='', fill='') +
# theme(axis.text.y=element_blank(), axis.ticks.y=element_blank() ) + 
# theme(legend.position='none') + 
# theme_bb()
# p_noman1
#
#
# ##### subsection over #####
#
#
#
#
