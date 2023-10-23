

# mod_all2$grp_fe %>% unique()  %>%  write_clip() 
# mod_all2$grp_fe %>%  uniqueN(.)
# mod_all2$grp_fe %>%  length(.)




elab_grp_fe = data.table()

elab_grp_fe$from = c(
    'arbnr',
    'arbnr + bef_aar',
    'arbnr^bef_aar',
    'arbnr[bef_aar]',
    'arbnr^disco6',
    'arbnr^bef_aar^disco6',
    'arbnr^disco6[bef_aar]',
    'arbnr^disco6 + bef_aar',
    'arbnr^disco1',
    'arbnr^bef_aar^disco1',
    'arbnr^disco1[bef_aar]',
    'arbnr^disco1 + bef_aar',
    'arbnr^disco2',
    'arbnr^bef_aar^disco2',
    'arbnr^disco2[bef_aar]',
    'arbnr^disco2 + bef_aar',
    'arbnr^disco3',
    'arbnr^bef_aar^disco3',
    'arbnr^disco3[bef_aar]',
    'arbnr^disco3 + bef_aar',
    'arbnr^disco4',
    'arbnr^bef_aar^disco4',
    'arbnr^disco4[bef_aar]',
    'arbnr^disco4 + bef_aar'
)


elab_grp_fe$to = c(
    'WS-only',
    'WS+Year',
    'WS-Year',
    'WS/Year',
    'WS-I6',
    'WS-I6-Year',
    'WS-I6/Year',
    'WS-I6+Year',
    'WS-I1',
    'WS-I1-Year',
    'WS-I1/Year',
    'WS-I1+Year',
    'WS-I2',
    'WS-I2-Year',
    'WS-I2/Year',
    'WS-I2+Year',
    'WS-I3',
    'WS-I3-Year',
    'WS-I3/Year',
    'WS-I3+Year',
    'WS-I4',
    'WS-I4-Year',
    'WS-I4/Year',
    'WS-I4+Year'
)

# View(elab_grp_fe)

# get into visidata for processing
# fwrite(elab_grp_fe, 'tmp-data/label-dictionaries/elab_grp_fe.csv', sep=';')
# system('emils-open-command.sh  tmp-data/label-dictionaries/elab_grp_fe.csv')


# errorcheck
stopifnot('the labels do not match' = { 
    t1 = sets(elab_grp_fe$from, mod_all2$grp_fe)
    t1$in_x  %>% length() + t1$in_y  %>% length() == 0   
})





# elab_grp_fe$to  %>% write_clip()
elab_grp_fe[, grp_lab  := factor(to, levels=c(
    'WS-only',
    'WS+Year',
    'WS-Year',
    'WS/Year',
    'WS-I1',
    'WS-I1-Year',
    'WS-I1/Year',
    'WS-I1+Year',
    'WS-I2',
    'WS-I2-Year',
    'WS-I2/Year',
    'WS-I2+Year',
    'WS-I3',
    'WS-I3/Year',
    'WS-I3+Year',
    'WS-I3-Year',
    'WS-I4',
    'WS-I4/Year',
    'WS-I4+Year',
    'WS-I4-Year',
    'WS-I6',
    'WS-I6/Year',
    'WS-I6+Year',
    'WS-I6-Year'
))]
# levels(elab_grp_fe$grp_lab)

if( !is.null(mod_all2$grp_fe_lab) ) mod_all2[, grp_fe_lab  := NULL]
mod_all2[elab_grp_fe, grp_fe_lab := grp_lab, on=c(grp_fe='from')]
# mod_all2[, .N, grp_fe_lab]
# mod_all2$grp_fe_lab  %>% levels()



