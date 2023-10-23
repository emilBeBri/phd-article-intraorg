# plot_man_g1$term0 %>% unique()  %>%  write_clip() 
# plot_man_g1$term0 %>%  uniqueN(.)
# plot_man_g1$term0 %>%  length(.)


elab_plot_man_g = data.table()
elab_plot_man_g$from = c(
'grp_man_tie_alter = female-man-male-0-female-0',
'grp_man_tie_alter = female-man-male-0-female-1',
'grp_man_tie_alter = female-man-male-1-female-0',
'grp_man_tie_alter = female-man-male-1-female-1',
'grp_man_tie_alter = male-man-male-0-female-1',
'grp_man_tie_alter = male-man-male-1-female-0',
'grp_man_tie_alter = male-man-male-1-female-1'
)


# errorcheck
stopifnot('the labels do not match' = { 
    t1 = sets(elab_plot_man_g$from, plot_man_g1$term0)
    t1$in_x  %>% length() + t1$in_y  %>% length() == 0   
})

elab_plot_man_g$to = c(
'female-man-male-0-female-0',
'female-man-male-0-female-1',
'female-man-male-1-female-0',
'female-man-male-1-female-1',
'male-man-male-0-female-1',
'male-man-male-1-female-0',
'male-man-male-1-female-1'
)

elab_plot_man_g[, grp_term_lab  := factor(to, levels=c(

'female-man-male-0-female-0',
'female-man-male-0-female-1',
'female-man-male-1-female-0',
'female-man-male-1-female-1',

'male-man-male-0-female-1',
'male-man-male-1-female-0',
'male-man-male-1-female-1'

))]


# levels(elab_plot_man_g$grp_term_lab)

# fwrite(elab_plot_man_g, 'tmp-data/label-dictionaries/elab_plot_man_g.csv', sep=';')
# system('alacritty -e visidata tmp-data/label-dictionaries/elab_plot_man_g.csv --csv-delimiter=";"')



# levels(elab_plot_man_g$to)

# plot_man_g = mod_all2[grp_mod %in% qc(man_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
plot_man_g1[elab_plot_man_g, grp_term_lab := grp_term_lab, on=c(term0='from')]
# errorcheck
stopifnot('there should be no missing labels' = plot_man_g1[is.na(grp_term_lab), .N] == 0 )



