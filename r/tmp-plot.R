library(tidyverse)
library(patchwork)

raw=tibble( 
  labels=c(
    "Spirituality, faith and religion",
    "Freedom and independence",
    "Hobbies and recreation",
    "Physical and mental health",
    "COVID-19",
    "Pets",
    "Nature and the outdoors"),
  Dem=c(8,6,13,13,8,5,5),
  Rep=c(22,12,7,9,5,2,3)
)

df=raw

#display the tibble
df

df_long=df %>% 
  pivot_longer(-labels)

df_long


df=raw %>% # raw is just the generated data
  
  # compute the gap
  mutate(gap=Rep-Dem) %>% 
  
  # find the maximum value by label
  group_by(labels) %>% 
  mutate(max=max(Dem, Rep)) %>% 
  ungroup() %>% 
  
  # sort the labels by gap value
  # note that its absolute value of gap
  mutate(labels=forcats::fct_reorder(labels, abs(gap)))  

# make into long format for easier plotting  
df_long=df %>% 
  pivot_longer(
    c(Dem,Rep)
  )

df 



# set a custom nudge value
nudge_value=.6

p_main=
df_long %>% 
  
  # the following 3 lines of code are the same
  ggplot(aes(x=value,y=labels)) +
  geom_line(aes(group=labels), color="#E7E7E7", linewidth=3.5) +
  geom_point(aes(color=name), size=3) +
  
  # but we want geom_text for the data callouts and the legend
  
  # data callout
  geom_text(aes(label=value, color=name),
            size=3.25,
            nudge_x=if_else(
              df_long$value==df_long$max, # if it's the larger value...
              nudge_value,   # move it to the right of the point
              -nudge_value), # otherwise, move it to the left of the point
            hjust=if_else(
              df_long$value==df_long$max, #if it's the larger value
              0, # left justify
              1),# otherwise, right justify      
            )+
   
  # legend
  geom_text(aes(label=name, color=name), 
            data=. %>% filter(gap==max(gap)),
            nudge_y =.5, 
            fontface="bold",
            size=3.25)+  
  
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.y = element_text(color="black"),
        axis.text.x = element_text(color="#989898"),
        axis.title = element_blank(),
        panel.grid = element_blank()
        ) +
  labs(x="%",y=NULL) +
  scale_color_manual(values=c("#436685", "#BF2F24")) +
  
  #extend the y-axis otherwise the legend is cut off
  coord_cartesian(ylim=c(1, 7.5)) +
  
  #display percentages with % appended
  scale_x_continuous(labels = scales::percent_format(scale = 1)) 

p_main




df_gap=
df %>%  # note i am using df and not df_long
  mutate(
    label=fct_reorder(labels, abs(gap)), #order label by descending gaps
    
    # we need a column for the party with the max value
    gap_party_max=if_else(
      Rep==max, 
      "R",
      "D"
    ),
    
    # format gap values
    gap_label=
      paste0("+", abs(gap), gap_party_max) %>% 
      fct_inorder() #turns into factor to bake in the order
  )


p_gap=
  df_gap %>% 
  ggplot(aes(x=gap,y=labels)) +
  geom_text(aes(x=0, label=gap_label, color=gap_party_max),
            fontface="bold",
            size=3.25) +
  
  geom_text(aes(x=0, y=7), # 7 because that's the # of y-axis values
            label="Diff",
            nudge_y =.5, # match the nudge value of the main plot legend    
            fontface="bold",
            size=3.25) +
  
  theme_void() +
  coord_cartesian(xlim = c(-.05, 0.05), 
                  ylim=c(1,7.5) # needs to match main plot
                  )+
  theme(
    plot.margin = margin(l=0, r=0, b=0, t=0), #otherwise it adds too much space
    panel.background = element_rect(fill="#EFEFE3", color="#EFEFE3"),
    legend.position = "none"
  )+
  scale_color_manual(values=c("#436685", "#BF2F24"))

p_gap

df_gap




p_whole=
  # syntax from `patchwork`
  p_main + p_gap + plot_layout(design=
  c(
    area(l=0,  r=45, t=0, b=1), # defines the main figure area
    area(l=46, r=52, t=0, b=1)  # defines the gap figure area
  )) 

p_whole



