
# plot_abg1$term0 %>% unique()  %>%  write_clip() 
# plot_abg1$term0 %>%  uniqueN(.)
# plot_abg1$term0 %>%  length(.)




elab_plot_noman_man_g = data.table()


elab_plot_noman_man_g$from = c(
'grp_noman_man_tie_alter = male-0',
'grp_noman_man_tie_alter = male-noman-female-0-male-0-man-female-0-male-1',
'grp_noman_man_tie_alter = male-noman-female-0-male-0-man-female-1-male-0',
'grp_noman_man_tie_alter = male-noman-female-0-male-0-man-female-1-male-1',
'grp_noman_man_tie_alter = male-noman-female-0-male-1-man-female-0-male-0',
'grp_noman_man_tie_alter = male-noman-female-0-male-1-man-female-0-male-1',
'grp_noman_man_tie_alter = male-noman-female-0-male-1-man-female-1-male-0',
'grp_noman_man_tie_alter = male-noman-female-0-male-1-man-female-1-male-1',
'grp_noman_man_tie_alter = male-noman-female-1-male-0-man-female-0-male-0',
'grp_noman_man_tie_alter = male-noman-female-1-male-0-man-female-0-male-1',
'grp_noman_man_tie_alter = male-noman-female-1-male-0-man-female-1-male-0',
'grp_noman_man_tie_alter = male-noman-female-1-male-0-man-female-1-male-1',
'grp_noman_man_tie_alter = male-noman-female-1-male-1-man-female-0-male-0',
'grp_noman_man_tie_alter = male-noman-female-1-male-1-man-female-0-male-1',
'grp_noman_man_tie_alter = male-noman-female-1-male-1-man-female-1-male-0',
'grp_noman_man_tie_alter = male-noman-female-1-male-1-man-female-1-male-1',
# 'grp_noman_man_tie_alter = male-1',
# 'grp_noman_man_tie_alter = female-0',
'grp_noman_man_tie_alter = female-noman-female-0-male-0-man-female-0-male-0',
'grp_noman_man_tie_alter = female-noman-female-0-male-0-man-female-0-male-1',
'grp_noman_man_tie_alter = female-noman-female-0-male-0-man-female-1-male-0',
'grp_noman_man_tie_alter = female-noman-female-0-male-0-man-female-1-male-1',
'grp_noman_man_tie_alter = female-noman-female-0-male-1-man-female-0-male-0',
'grp_noman_man_tie_alter = female-noman-female-0-male-1-man-female-0-male-1',
'grp_noman_man_tie_alter = female-noman-female-0-male-1-man-female-1-male-0',
'grp_noman_man_tie_alter = female-noman-female-0-male-1-man-female-1-male-1',
'grp_noman_man_tie_alter = female-noman-female-1-male-0-man-female-0-male-0',
'grp_noman_man_tie_alter = female-noman-female-1-male-0-man-female-0-male-1',
'grp_noman_man_tie_alter = female-noman-female-1-male-0-man-female-1-male-0',
'grp_noman_man_tie_alter = female-noman-female-1-male-0-man-female-1-male-1',
'grp_noman_man_tie_alter = female-noman-female-1-male-1-man-female-0-male-0',
'grp_noman_man_tie_alter = female-noman-female-1-male-1-man-female-0-male-1',
'grp_noman_man_tie_alter = female-noman-female-1-male-1-man-female-1-male-0',
'grp_noman_man_tie_alter = female-noman-female-1-male-1-man-female-1-male-1'
# 'grp_noman_man_tie_alter = female-1'
)


# sets(elab_plot_noman_man_g$from, plot_abg1$term0)


elab_plot_noman_man_g$to = c(
'male-noman-female-0-male-0-man-female-0-male-0',
'male-noman-female-0-male-0-man-female-0-male-1',
'male-noman-female-0-male-0-man-female-1-male-0',
'male-noman-female-0-male-0-man-female-1-male-1',
'male-noman-female-0-male-1-man-female-0-male-0',
'male-noman-female-0-male-1-man-female-0-male-1',
'male-noman-female-0-male-1-man-female-1-male-0',
'male-noman-female-0-male-1-man-female-1-male-1',
'male-noman-female-1-male-0-man-female-0-male-0',
'male-noman-female-1-male-0-man-female-0-male-1',
'male-noman-female-1-male-0-man-female-1-male-0',
'male-noman-female-1-male-0-man-female-1-male-1',
'male-noman-female-1-male-1-man-female-0-male-0',
'male-noman-female-1-male-1-man-female-0-male-1',
'male-noman-female-1-male-1-man-female-1-male-0',
'male-noman-female-1-male-1-man-female-1-male-1',
'female-noman-female-0-male-0-man-female-0-male-0',
'female-noman-female-0-male-0-man-female-0-male-1',
'female-noman-female-0-male-0-man-female-1-male-0',
'female-noman-female-0-male-0-man-female-1-male-1',
'female-noman-female-0-male-1-man-female-0-male-0',
'female-noman-female-0-male-1-man-female-0-male-1',
'female-noman-female-0-male-1-man-female-1-male-0',
'female-noman-female-0-male-1-man-female-1-male-1',
'female-noman-female-1-male-0-man-female-0-male-0',
'female-noman-female-1-male-0-man-female-0-male-1',
'female-noman-female-1-male-0-man-female-1-male-0',
'female-noman-female-1-male-0-man-female-1-male-1',
'female-noman-female-1-male-1-man-female-0-male-0',
'female-noman-female-1-male-1-man-female-0-male-1',
'female-noman-female-1-male-1-man-female-1-male-0',
'female-noman-female-1-male-1-man-female-1-male-1'
)
# View(elab_plot_noman_man_g)


# elab_plot_noman_man_g$to  %>% write_clip()
elab_plot_noman_man_g[, grp_term_lab  := factor(to, levels=c(
# female no ties 
'female-noman-female-0-male-0-man-female-0-male-0',

# no manager ties

'female-noman-female-1-male-0-man-female-0-male-0',
'female-noman-female-0-male-1-man-female-0-male-0',


'female-noman-female-1-male-1-man-female-0-male-0',


# female manager tie, 

'female-noman-female-0-male-0-man-female-1-male-0',
'female-noman-female-1-male-0-man-female-1-male-0',
'female-noman-female-0-male-1-man-female-1-male-0',
'female-noman-female-1-male-1-man-female-1-male-0',

# male manager tie 

'female-noman-female-0-male-0-man-female-0-male-1',

'female-noman-female-1-male-0-man-female-0-male-1',

'female-noman-female-0-male-1-man-female-0-male-1',

'female-noman-female-1-male-1-man-female-0-male-1',

'female-noman-female-0-male-0-man-female-1-male-1',

'female-noman-female-1-male-0-man-female-1-male-1',

'female-noman-female-0-male-1-man-female-1-male-1',

# 4 ties
'female-noman-female-1-male-1-man-female-1-male-1',


# dividing line
'the great divide',

# male no ties (ref - so isn’t in here)
# 'male-noman-female-0-male-0-man-female-0-male-0',

# no manager ties

'male-noman-female-1-male-0-man-female-0-male-0',
'male-noman-female-0-male-1-man-female-0-male-0',


'male-noman-female-1-male-1-man-female-0-male-0',


# female manager tie, 

'male-noman-female-0-male-0-man-female-1-male-0',
'male-noman-female-1-male-0-man-female-1-male-0',
'male-noman-female-0-male-1-man-female-1-male-0',
'male-noman-female-1-male-1-man-female-1-male-0',

# male manager tie 

'male-noman-female-0-male-0-man-female-0-male-1',

'male-noman-female-1-male-0-man-female-0-male-1',

'male-noman-female-0-male-1-man-female-0-male-1',

'male-noman-female-1-male-1-man-female-0-male-1',

'male-noman-female-0-male-0-man-female-1-male-1',

'male-noman-female-1-male-0-man-female-1-male-1',

'male-noman-female-0-male-1-man-female-1-male-1',

# 4 ties
'male-noman-female-1-male-1-man-female-1-male-1'
))]
# levels(elab_plot_noman_man_g$grp_term_lab)

# fwrite(elab_plot_noman_man_g, 'tmp-data/label-dictionaries/elab_plot_noman_man_g.csv', sep=';')
# system('alacritty -e visidata tmp-data/label-dictionaries/elab_plot_noman_man_g.csv --csv-delimiter=";"')






# plot_abg1 = mod_all2[grp_mod %in% qc(noman_man_g) & !is.na(cof1) & grp_fe %ilike% 'arbnr$|disco6\\[']


if( !is.null(plot_noman_man_g1$grp_term_lab)) plot_noman_man_g1[, grp_term_lab  := NULL] 
plot_noman_man_g1[elab_plot_noman_man_g, grp_term_lab := grp_term_lab, on=c(term0='from')]
# errorcheck
stopifnot('there should be no missing labels' = plot_noman_man_g1[is.na(grp_term_lab), .N] == 0 )



#########################################
# DT for visual labels in legend #section
#########################################


###########################
# make the DTs #subsection


p_dat_dt0 = list(

    # p_dat_leg00 = data.table(
    #     grp_ego= NA,
    #     grp= 'the great divide',
    #     alter_female=NA,
    #     manager=NA,
    #     x = 1:1
    # ),


    p_dat_leg01 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-1-man-female-1-male-1', 4),
        alter_female=c(T,F,T,F),
        manager=c(F,F,T,T),
        x = 1:4
    )

    ,
    p_dat_leg02 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-1-man-female-1-male-1', 4),
        alter_female=c(NA, F,T,F),
        manager=c(NA, F,T,T),
        x = 1:4
    )
    ,



    p_dat_leg03 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-0-man-female-1-male-1', 4),
        alter_female=c(T,NA,T,F),
        manager=c(F,NA,T,T),

        x = 1:4
    )
    ,

    p_dat_leg04 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-0-man-female-1-male-1', 4),
        alter_female=c(NA, NA,T,F),
        manager=c(NA,NA,T,T),
        x = 1:4

    )
    ,

    p_dat_leg05 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-1-man-female-0-male-1', 4),
        alter_female=c(T,F,NA,F),
        manager=c(F,F,NA,T),
        x = 1:4
    )

    ,


    p_dat_leg06 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-1-man-female-0-male-1', 4),
        alter_female=c(NA,F,NA,T),
        manager=c(NA,F,NA,T),
        x = 1:4
    )

    ,


    p_dat_leg07 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-0-man-female-0-male-1', 4),
        alter_female=c(T,NA,NA,F),
        manager=c(F,NA,NA,T),
        x = 1:4
    )

    ,


    p_dat_leg08 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-0-man-female-0-male-1', 4),
        alter_female=c(NA,NA,NA,F),
        manager=c(NA,NA,NA,T),
        x = 1:4
    )

    ,




    p_dat_leg09 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-0-man-female-1-male-0', 4),
        alter_female=c(NA,NA,T,NA),
        manager=c(NA,NA,T,NA),
        x = 1:4
    )

    ,


    p_dat_leg10 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-1-man-female-1-male-0', 4),
        alter_female=c(T,F,T,NA),
        manager=c(F,F,T,NA),
        x = 1:4
    )

    ,


    p_dat_leg11 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-1-man-female-1-male-0', 4),
        alter_female=c(NA, F,T,NA),
        manager=c(NA, F,T,NA),
        x = 1:4
    )

    ,


    p_dat_leg12 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-0-man-female-1-male-0', 4),
        alter_female=c(T,NA,T,NA),
        manager=c(F,NA,T,NA),
        x = 1:4
    )

    ,


    p_dat_leg13 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-1-man-female-0-male-0', 4),
        alter_female=c(T,F,NA,NA),
        manager=c(F,F,NA,NA),
        x = 1:4
    )

    ,



    p_dat_leg14 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-1-man-female-0-male-0', 4),
        alter_female=c(NA, F,NA,NA),
        manager=c(NA, F,NA,NA),
        x = 1:4
    )

    ,


    p_dat_leg15 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-1-male-0-man-female-0-male-0', 4),
        alter_female=c(T,NA,NA,NA),
        manager=c(F,NA,NA,NA),
        x = 1:4
    )


    ,
    p_dat_leg16 = data.table(
        grp_ego= rep('male', 4),
        grp= rep('male-noman-female-0-male-0-man-female-0-male-0', 4),
        alter_female=c(NA,NA,NA,NA),
        manager=c(NA,NA,NA,NA),
        x = 1:4
    )



p_leg_dat_noman_man1 = unique(plot_noman_man1[, .(grp_term_lab, grp_koen_ego, grp_man_alter, grp_koen_alter)])
p_leg_dat_noman_man1[grp_term_lab == 'female-noman-0-man-0', grp_man_alter  := NA]
p_leg_dat_noman_man1 $x = c(0,1,2)  %>% as.double()

)



##### subsection over #####

p_dat_dt1 = rbindlist(p_dat_dt0)
p_dat_dt1[, x  := as.double(x)]


# uniqueA(p_dat_dt1)



# create a new dt with female categories (it is a dubplicate except ego is a woman)
p_dat_dt2a = copy(p_dat_dt1)
p_dat_dt2a[, `:=`( grp = gsub('^male-', 'female-', grp), grp_ego = 'female')]

p_dat_dt3 = rbind(p_dat_dt2a, p_dat_dt1)

# remove ref cat 
p_dat_legend_noman_man_g =  p_dat_dt3[grp %!in% 'male-noman-female-0-male-0-man-female-0-male-0' ]

# setnames(p_dat_legend_noman_man_g, 'grp', 'grp_term_lab')
p_dat_legend_noman_man_g[, grp_term_lab := factor(grp, levels=levels(elab_plot_noman_man_g$grp_term_lab)) ]
# levels(p_dat_legend_noman_man_g$grp_term_lab)



# errorcheck (not working cuz male with zero is ref so is not in there)
stopifnot('the labels do not match' = { 
    t1 = sets(p_dat_legend_noman_man_g$grp_term_lab, plot_noman_man_g1$grp_term_lab)
    t1$in_x  %>% length() + t1$in_y  %>% length() < 2
})
