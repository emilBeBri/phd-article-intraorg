##############  #section ################
# settings for colors, factor levels etc 
#########################################

data(ecolor_data)

# make a palette with two different shades of one color, for a couple of categories
funs <- c(colorspace::darken, colorspace::lighten)
args <- list(amount=0.15)

# # first the dark, then the light versions
# ecolors_edgetypes <- ecolor_data[grp %ilike% 'classic', hex][1:3] %>% 
#   map(~ funs %>% map(exec, .x, !!!args)  ) %>%  unlist() 
# # ecolor_pal(ecolors_edgetypes)
# ecolors_edgetypes_without <- ecolor_data[grp %ilike% 'classic', hex][1:3]

# version with edgetypes bundled in colors
# first the dark, then the light versions
# ecolors_edgetypes <- ecolor_data[grp %ilike% 'classic', hex][1:4] %>% 
#   map(~ funs %>% map(exec, .x, !!!args)  ) %>%  unlist() 


# version where without is first,  then with
ec1 <- map(1:5, ~ {  
  # ecolor_data[grp %ilike% 'classic', hex][.x] 
  ecolor_data[grp %ilike% 'nord aurora', hex][.x] %>%
    map(~ funs %>% map(exec, .x, !!!args)  ) %>%  unlist()   
}) 
# set the colors apart 
ecolors_edgetypes <- c(map_chr(ec1, 2), map_chr(ec1, 1))
# ecolor_pal(ecolors_edgetypes); bplot()
# ecolors_edgetypes_without <- ecolor_data[grp %ilike% 'classic', hex][1:4]
# ecolor_pal(ecolors_edgetypes_without); bplot()



# version where without is first,  then with
ec1 <- map(1:5, ~ {  
  # ecolor_data[grp %ilike% 'classic', hex][.x] 
  ecolor_data[grp %ilike% 'nord aurora', hex][.x] %>%
    map(~ funs %>% map(exec, .x, !!!args)  ) %>%  unlist()   
}) 


# set the colors apart 
ecolors_edgetypes <- c(map_chr(ec1, 2), map_chr(ec1, 1))


#########################################
# coef plot colors - sensitivity analysis #section
#########################################
# /home/emil/Dropbox/arbejde/cbs/phd/articles/intra-org-inequality/r/models_all.R:122


# arbnr fe color
ecolr_fixed_arbnr = c('#A3BE8C') 

# make a palette that goes from red to yellow, in 5 steps for disco
ecolr_yellow_to_red <- c('#E7B800', '#FC4E07')  
ecolr_fixed_disco <- colorRampPalette(ecolr_yellow_to_red)(7)
# ecolor_pal(ecolr_fixed_disco)
# library(ggplot2)
# ggplot(iris, aes(Sepal.Width, Sepal.Length)) + geom_point()
# colc(iris)
ecolr_fixed_arbnr_disco = ecolor_data[grp %ilike% 'nord aurora', rev(hex)] 



ecolr_yellow_to_deepred <- c('#E7B800', '#BF2F24')  
ecolr_no_ties <- colorRampPalette(ecolr_yellow_to_deepred)(5)



# a lighter and a darker version of the same color
ecolr_fixed_degree = c('#5E81AC')
ecolr_fixed_degree = ecolr_fixed_degree |> map(~ funs %>% map(exec, .x, !!!list(amount=0.35))  ) %>%  unlist()   
# ecolor_pal(ecolr_fixed_degree)


ecolr_noman_man <- c('#BF616A', '#5E81AC')

# ecolor_data[grp %ilike% 'nord aurora', hex] |> ecolor_pal()  


# elab_grp_no_ties
# make a palette that goes from light red to dark of this color in five steps: #BF616A  
ecolr_grp = c('#BF616A') |> map(~ funs %>% map(exec, .x, !!!list(amount=0.35))  ) %>%  unlist()





#########################################
# ggplot defaults #section
#########################################

eplot_def_width=28
# eplot_def_width=30
# eplot_def_width=25
eplot_def_height=15



