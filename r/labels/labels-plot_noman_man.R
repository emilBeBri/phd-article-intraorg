
# plot_noman_man1$term0 %>% unique()  %>%  write_clip() 
# plot_noman_man1$term0 %>%  uniqueN(.)
# plot_noman_man1$term0 %>%  length(.)


elab_plot_noman_man = data.table()
elab_plot_noman_man$from = c(
'grp_noman_man_tie = female-noman-0-man-0',
'grp_noman_man_tie = female-noman-1-man-0',
'grp_noman_man_tie = female-noman-0-man-1',
'grp_noman_man_tie = female-noman-1-man-1',
'grp_noman_man_tie = male-noman-1-man-0',
'grp_noman_man_tie = male-noman-0-man-1',
'grp_noman_man_tie = male-noman-1-man-1'
)


# errorcheck
stopifnot('the labels do not match' = { 
    t1 = sets(elab_plot_noman_man$from, plot_noman_man1$term0)
    t1$in_x  %>% length() + t1$in_y  %>% length() == 0   
})


elab_plot_noman_man$to = c(
'female-noman-0-man-0',
'female-noman-1-man-0',
'female-noman-0-man-1',
'female-noman-1-man-1',
'male-noman-1-man-0',
'male-noman-0-man-1',
'male-noman-1-man-1'
)



elab_plot_noman_man[, grp_term_lab  := factor(to, levels=c(

'female-noman-0-man-0',
'female-noman-1-man-0',
'female-noman-0-man-1',
'female-noman-1-man-1',

'male-noman-1-man-0',
'male-noman-0-man-1',
'male-noman-1-man-1'

))]


# levels(elab_plot_noman_man$grp_term_lab)

# fwrite(elab_plot_noman_man, 'tmp-data/label-dictionaries/elab_plot_noman_man.csv', sep=';')
# system('alacritty -e visidata tmp-data/label-dictionaries/elab_plot_noman_man.csv --csv-delimiter=";"')



# levels(elab_plot_noman_man$to)

# plot_noman_man = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']
plot_noman_man1[elab_plot_noman_man, grp_term_lab := grp_term_lab, on=c(term0='from')]
# errorcheck
stopifnot('there should be no missing labels' = plot_noman_man1[is.na(grp_term_lab), .N] == 0 )


#########################################
# DT for visual labels in legend #section
#########################################

p_dat_dt0 = list(

 
    p_dat_leg00 = data.table(
        grp_koen_ego= rep('male', 2),
        grp= rep('male-noman-0-man-0', 2),
        grp_man_alter=c(NA,NA),
        x = 1:2
    )




    ,
    p_dat_leg01 = data.table(
        grp_koen_ego= rep('male', 2),
        grp= rep('male-noman-1-man-0', 2),
        grp_man_alter=c(F,NA),
        x = 1:2
    )


    ,
    p_dat_leg02 = data.table(
        grp_koen_ego= rep('male', 2),
        grp= rep('male-noman-0-man-1', 2),
        grp_man_alter=c(NA,T),
        x = 1:2
    )


    ,
    p_dat_leg03 = data.table(
        grp_koen_ego= rep('male', 2),
        grp= rep('male-noman-1-man-1', 2),
        grp_man_alter=c(F,T),
        x = 1:2
    )


)


p_dat_dt1 = rbindlist(p_dat_dt0)
p_dat_dt1[, x  := as.double(x)]



# create a new dt with female categories (it is a dubplicate except ego is a woman)
p_dat_dt2a = copy(p_dat_dt1)
p_dat_dt2a[, `:=`( grp = gsub('^male-', 'female-', grp), grp_koen_ego = 'female')]

p_dat_dt3 = rbind(p_dat_dt2a, p_dat_dt1)

# remove ref cat 
p_dat_legend_noman_man =  p_dat_dt3[grp %!in% 'male-noman-0-man-0' ]

# setnames(p_dat_legend_noman_man, 'grp', 'grp_term_lab')
p_dat_legend_noman_man[, grp_term_lab := factor(grp, levels=levels(elab_plot_noman_man$grp_term_lab)) ]
# levels(p_dat_legend_noman_man$grp_term_lab)

# errorcheck (not working cuz male with zero is ref so is not in there)
stopifnot('the labels do not match' = { 
    t1 = sets(p_dat_legend_noman_man$grp_term_lab, plot_noman_man1$grp_term_lab)
    t1$in_x  %>% length() + t1$in_y  %>% length() < 2
})


