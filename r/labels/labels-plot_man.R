

# plot_man1$term0 %>% unique()  %>%  write_clip() 
# plot_man1$term0 %>%  uniqueN(.)
# plot_man1$term0 %>%  length(.)


elab_plot_man = data.table()

elab_plot_man$from = c(
'grp_man_tie = female-man-0',
'grp_man_tie = female-man-1',
'grp_man_tie = male-man-1'
)


# errorcheck
stopifnot('the labels do not match' = { 
    t1 = sets(elab_plot_man$from, plot_man1$term0)
    t1$in_x  %>% length() + t1$in_y  %>% length() == 0   
})



elab_plot_man$to = c(
'female-man-0',
'female-man-1',
'male-man-1'
)
elab_plot_man$grp_term_lab = elab_plot_man$to %>% factor()
# levels(elab_plot_man$to)

# fwrite(elab_plot_man, 'tmp-data/label-dictionaries/elab_plot_man.csv', sep=';')
# system('alacritty -e visidata tmp-data/label-dictionaries/elab_plot_man.csv --csv-delimiter=";"')



# levels(elab_plot_man$to)



# plot_man = mod_all2[grp_mod %in% qc(man_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
plot_man1[elab_plot_man, grp_term_lab := grp_term_lab, on=c(term0='from')]
# errorcheck
stopifnot('there should be no missing labels' = plot_man1[is.na(grp_term_lab), .N] == 0 )



