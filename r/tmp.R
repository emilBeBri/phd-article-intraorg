


#########################################
# standard stuff #section
#########################################


# check groups
colc(mod_all2, 'grp')   %>% write_clip()
mod_all2[, .N, grp]
mod_all2[, .N, grp_disco_lvl]
mod_all2[, .N, grp_fe]
mod_all2[, .N, grp_fe_lab]
mod_all2[, .N, grp_fe_type]
mod_all2[, .N, grp_koen_alter]
mod_all2[, .N, grp_koen_both]
mod_all2[, .N, grp_koen_ego]
mod_all2[, .N, grp_koen_homo]
mod_all2[, .N, grp_man_alter]
mod_all2[, .N, grp_mod]
mod_all2[, .N, grp_no_ties]





#########################################
# 00-trash #section
#########################################
#
#
# # give me unique of every group variable 
# mod_all2[ ]
#
#
#
#
# # mod_all2[grp_fe_lab %!ilike% '\\+' & grp_fe_lab %!ilike% '\\/' & !is.na(cof1), ][, .N,  .(grp_fe)]
#
# plot_sens0 [, .N, grp_fe_lab]
# plot_noman_man1 [, .N, grp_fe_lab]
#
#
# mod_all2[, .N,   grp_mod]
#
#
#
# plot_sens0 [, .N, grp_fe_lab]
# plot_noman_man1 [, .N, grp_fe_lab]
#
# 'WS+Year', 'WS-I6+Year'
#
#
# dtdesc(plot_sens0, 'grp')
# colc(plot_sens0, 'grp')
#
# View(plot_sens0)
#
#
# mod_all2[, .N,   grp_mod]
#
#
# mod_all2$grp_fe_lab  %>% levels()
# plot_sens0$grp_fe_lab  %>% levels()
#
#
# plot_sens0 = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1)]
# View(plot_sens0[, .(term0, grp_fe, grp_fe_lab)])
#
# plot_sens0 = mod_all2[grp_mod %in% qc(noman_man) & !is.na(cof1) & grp_fe_lab %!ilike% '*[1234]*']
#
#
#
# p_dat_t = data.table(
#     Gender=c('Female', "Male"),
#     # Alter=c('Coworker', "Manager"),
#     Alter=c('Coworker', "Manager"),
#     x=1:2, y=1:2)
# p_t = ggplot(p_dat_t, aes(x, y, fill=Gender, shape=Alter, color=Gender)) + geom_point(size=5) +
# scale_fill_manual(values=c("#436685",  "#BF2F24")) +
# scale_shape_manual(values=c(22,24))  +
# scale_color_manual(values=c("#436685",  "#BF2F24")) +
# labs(shape='', color='', fill='') +
# theme_void() +
# theme(legend.direction="horizontal") 
# # Extract the legend. Returns a gtable & Convert to a ggplot and print
# leg <- ggpubr::get_legend(p_t)
# leg = ggpubr::as_ggplot(leg); leg
#
# p_whole= p_leg1 + p_noman_man_g_main + leg #& theme(legend.position = "bottom") 
# p_whole= p_leg1 + p_noman_man_g_main 
#
#
#
# p_whole + plot_layout(design=
#   c(
#     area(l=0,  r=6, t=0, b=1), 
#     area(l=0, r=50, t=0, b=2)
# ))
#   # ), guides='collect')  
#
#
#
#
# p1 + inset_element(p2, left = 0.6, bottom = 0.6, right = 1, top = 1)
#
#
#
#
#
# p_noman_man_g_main[, .N, g]
# colc(plot_noman_man_g1, 'grp')
# colc(mod_all2, 'grp')
#
#
# # male no ties 
# 'male-noman-female-0-male-0-man-female-0-male-0',
#
# # no manager ties
#
# 'male-noman-female-1-male-0-man-female-0-male-0',
# 'male-noman-female-0-male-1-man-female-0-male-0',
# 'male-noman-female-1-male-1-man-female-0-male-0',
#
#
# # female manager tie, 
#
# 'male-noman-female-1-male-0-man-female-1-male-0',
# 'male-noman-female-0-male-1-man-female-1-male-0',
# 'male-noman-female-1-male-1-man-female-1-male-0',
# 'male-noman-female-0-male-0-man-female-1-male-0',
#
# # male manager tie 
#
# 'male-noman-female-0-male-0-man-female-0-male-1',
#
# 'male-noman-female-1-male-0-man-female-0-male-1',
#
# 'male-noman-female-0-male-1-man-female-0-male-1',
#
# 'male-noman-female-1-male-1-man-female-0-male-1',
#
# 'male-noman-female-0-male-0-man-female-1-male-1',
#
# 'male-noman-female-1-male-0-man-female-1-male-1',
#
# 'male-noman-female-0-male-1-man-female-1-male-1',
#
# # 4 ties
# 'male-noman-female-1-male-1-man-female-1-male-1'
#
#
#
