setwd('/home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality')
source('/home/emil/Dropbox/data-science/R/.minimal-Rprofile')
library(data.table)
library(purrr)
library(dttools)
library(readxl)
library(qs)
str_extract = stringr::str_extract 
p0 = paste0
write_clip = clipr::write_clip



# mod_all0 = read_xlsx('input/models/etab_models_net.xlsx') |> data.table()
mod_all0 = read_xlsx('input/models/etab_models_net_indi_female_disco6.xlsx') |> data.table()
# mod_all0 = read_xlsx('input/models/etab_models_all.xlsx') |> data.table()
# mod_all0 = read_xlsx('input/models/etab_models_net.xlsx') |> data.table()
# setnames(mod_all0, qc(V1, f1),qc(term0, cof0))
# mod_all0[grp %ilike% 'disco$'] 
# mod_all0[grp %ilike% 'disco$', grp := gsub('(.*)', '\\16', grp) ] # disco$ is actually disco 6-level 

# fix grp_noman_man_tie_alter  so female-1 and male-1 is written out verbosely
mod_all0[term0 =='grp_noman_man_tie_alter = female-1', term0  := 'grp_noman_man_tie_alter = female-noman-female-1-male-1-man-female-1-male-1']
mod_all0[term0 =='grp_noman_man_tie_alter = female-0', term0  := 'grp_noman_man_tie_alter = female-noman-female-0-male-0-man-female-0-male-0']
mod_all0[term0 =='grp_noman_man_tie_alter = male-0', term0  := 'grp_noman_man_tie_alter = male-noman-female-0-male-0-man-female-0-male-0']
mod_all0[term0 =='grp_noman_man_tie_alter = male-1', term0  := 'grp_noman_man_tie_alter = male-noman-female-1-male-1-man-female-1-male-1']
# mod_all0[term0 %ilike% 'grp_noman_man_tie_alter', .N, term0][, term0]


thecols_cof_ctrl ='geo_west|alder|disco|heltid|privat|jobexp|n_arbnr'
# mod_all0[ term0 %!ilike% thecols_cof_ctrl, ][, .N, term]
# mod_all0[ term0 %ilike% thecols_cof_ctrl, ][, .N, term]
mod_all1 =    mod_all0[ term0 %!ilike% thecols_cof_ctrl, ]
# mod_ctrl1 =    mod_all0[ term0 %ilike% thecols_cof_ctrl, ] # echo

# nrf2(mod_all0, mod_all1)
# also remove the one NA at the top (make sure there is only one)
mod_all1 = mod_all1[!is.na(term0) & term0 %!ilike% 'Dependent Var\\.:' ]
 # mod_all1[is.na(term0) | term0 %ilike% 'Dependent Var\\.:' ]

# setcolorder(mod_all1, 'term')
for(xcol in colc(mod_all1, '', not='term')) set(mod_all1, i=which(is.na(mod_all1[[xcol]])), j=xcol, value='')
mod_all2 = copy(mod_all1)
# change '---' delimiters to less
for( xcol in colc(mod_all2))  {
# no_underscores = rep( '_' , max(nchar( mod_allc [[xcol]] ), na.rm=T ) ) |> paste(collapse='')
no_underscores = rep( '_' , 15 ) |> paste(collapse='')
    mod_all2[get(xcol) %ilike% '_{3,}' , (xcol) := gsub('_{2,}', no_underscores, get(xcol))]
    mod_all2[get(xcol) %ilike% '-{3,}' , (xcol) := gsub('-{2,}', no_underscores, get(xcol))][]
}


# make into numeric coefs and sd
xcol = 'cof0'
# mod_all2[get(xcol) %ilike% '\\(.*\\)'   , cof1 := gsub('(^[ ]*[-.0-9]*)[*]*.*', '\\1', get(xcol)) %>% gsub('(\\d).$','\\1',)  |> as.numeric()]
mod_all2[get(xcol) %ilike% '\\(.*\\)'   , cof1 := gsub('(^[ ]*[-.0-9]*)([*]*.*)', '\\1', get(xcol)) ]
mod_all2[get(xcol) %ilike% '\\(.*\\)'   , cof1 := gsub('(\\d).$','\\1', cof1) ]
mod_all2[, cof1 :=  as.numeric(cof1)]
mod_all2[get(xcol) %ilike% '\\(.*\\)'   , sd1 := 
    gsub('.*\\(([-.0-9]+)\\)', '\\1', get(xcol)) |> as.numeric()]



# mod_all2 %>% kable('html') %>% kable_styling(bootstrap_options=qc(striped), position='left', fixed_thead=T)  %>% kable_paper('hover', full_width=TRUE)  
# View(mod_all2 )

# tag for all the non-terms 
mod_all2[, bin_term  := TRUE][term0 %ilike% 'Within|Fixed-|^arbnr$|^bef_aar$|observations|--|__|^r2$|clustered', bin_term := FALSE]

#########################################
# groupins #section
#########################################

mod_all2[, grp := factor(grp)]

# gender - ego and alter
mod_all2[, grp_koen_ego :=  str_extract(term0, '= [fe]*male')  %>% gsub('^= ', '', .) ]

mod_all2[, grp_koen_homo  := NA] [term0 %ilike% '^grp\\w+_alter = ' , grp_koen_homo   := F ]
mod_all2[term0 %ilike% '^grp\\w+_alter = .*female-1' & grp_koen_ego == 'female', grp_koen_homo  :=  TRUE]
mod_all2[term0 %ilike% '^grp\\w+_alter = [^e]*male-1' & grp_koen_ego == 'male', grp_koen_homo  :=  TRUE]

# tie - works currently (2023-07-24) only for alter, but not the full model noman_man_alter
mod_all2[,   grp_koen_alter :=  gsub('.*man-(.*)', '\\1', term0)]
# gender for both ego and alter
mod_all2[,   grp_koen_both := p0(grp_koen_ego, '-', grp_koen_alter) ]
mod_all2[term0 %!ilike% '\\w+_alter ',  `:=`(grp_koen_alter = NA, grp_koen_both = NA) ]

# make fixed effect groups and labels
mod_all2[, grp_fe := gsub('.*(arbnr.*$)', '\\1', grp) |> factor() ]
stopifnot('grp_fe fejl' = mod_all2[grp_fe %ilike% 'man', .N] == 0)
source('r/labels/labels-grp_fe.R') # 

# groupings for sensitivity analysis
# mod_all2[,  grp_disco_lvl :=  NULL]
mod_all2[grp_fe %ilike% 'disco[0-9]', grp_disco_lvl  := str_extract(grp_fe, 'disco[0-9]')]
mod_all2[grp_fe %!ilike% 'disco' & !is.na(cof1) , grp_disco_lvl  := 'none']

# mod_all2[,  grp_fe_type :=  NULL]
mod_all2[grp_fe_lab %ilike% '\\+' & !is.na(cof1), grp_fe_type  := '+']
mod_all2[grp_fe_lab %ilike% '\\/' & !is.na(cof1), grp_fe_type  := '/']
# mod_all2[grp_fe_lab %!ilike% '\\+' & grp_fe_lab %!ilike% '\\/' & !is.na(cof1), ][, .N,  .(grp_fe)]
mod_all2[grp_fe_lab %!ilike% '\\+' & grp_fe_lab %!ilike% '\\/' & !is.na(cof1),  grp_fe_type  := '-' ]


# ii=c(1, 100, 500)
# mod_all2[ii, grp] %>% gsub('.*(arbnr.*$)', '\\1', .)

mod_all2[, grp_mod := gsub('(.*)_arbnr.*$', '\\1', grp) |> factor() ]



mod_all2[, grp_man_alter := FALSE][!is.na(cof1) & term0 %ilike% '-man-1', grp_man_alter := TRUE]
# plot_noman1[, grp_man_alter := FALSE][!is.na(cof1) & term0 %ilike% '-man-1', grp_man_alter := TRUE]


# test af grupper
# f1 = mod_all2[!is.na(cof1), .(term0)]  %>% unique()
# f1[term0 %ilike% 'man-1', grp_man_alter := TRUE]




###########################
# no. contacts #subsection

tmp1 = data.table()

# split a string by character '+'
mod_all2$grp_no_ties = map_int( mod_all2$term0, \(.x) {
    as.character(.x)  %>% 
        strsplit('\\D', perl=T) %>% unlist() %>% .[.!=''] %>% as.numeric() %>% sum()
}  )


mod_all2[is.na(cof1), grp_no_ties := NA]


mod_all2[, grp_koen_homo  := NA] [term0 %ilike% '^grp\\w+_alter = ' , grp_koen_homo   := F ]
mod_all2[grp_koen_ego =='male' & term0 %ilike% '-male-1', grp_koen_homo   := TRUE ]
mod_all2[grp_koen_ego =='female' & term0 %ilike% '-female-1', grp_koen_homo  := TRUE ]


mod_all2[, grp_no_ties := factor(grp_no_ties, levels=sort(unique(grp_no_ties)))]
# levels(elab_plot_abg1$grp_no_ties)



##### subsection over #####





qsave(mod_all2 , 'tmp-data/models/mod_all2.qs', 'high', nthreads=no_threads)
# qsave(mod_all2 , 'tmp-data/models/mod_all2_all.qs', 'high', nthreads=no_threads)
# qsave(mod_all2 , 'tmp-data/models/mod_all2_net.qs', 'high', nthreads=no_threads)

