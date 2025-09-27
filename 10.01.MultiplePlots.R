# P.166 - Loading the data...
  frame <- read.csv( "DataSet-Hurricanes.csv" )
  head( frame , n = 8 )
  library( ggplot2 )
#
  label_object <-
    labs ( title = "US Atlantic  Hurricanes"
         , subtitle = "1950-2012"
         , x = "Event Year"
         , y = "Damage $ Millions"
         , caption = "Source: Wikipedia | rpt:001 ~ loading the data"
         )
#
  ggplot( frame
        , aes ( x = Year
              , y = DamageMillions
              , size = DamageMillions
              , color = WindMPH
              )
        ) +
    geom_point( ) +
    label_object # Add this line to include the label.
#-------------------------------------------------------------
# P.168 - Retaining objects...
  damage_plot <-
    ggplot  ( frame
            , aes ( x = Year
                  , y = DamageMillions
#                  , size = DamageMillions # source flagged...
                  , color = WindMPH
                  )
            )
#
  damage_plot +
    geom_point( )+
      labs(caption = "Source: Wikipedia | rpt:002 ~ retaining objects" )
#--- Include the next line in your selection to add lines.
  damage_plot +
    geom_point( ) +
    geom_line( linewidth = 0.5 ) +
      labs(caption = "Source: Wikipedia | rpt:003 ~ add a line" )
#------------------------------------------------------------
# P.170 - Overriding labels...
  damage_plot +
    ggtitle( "US Atlantic Hurricanes" ) +
    xlab( "Event Year" ) +
    ylab( "Damage $ Millions" ) +
    geom_point( ) +
    geom_line( linewidth = 0.5 )+
      labs(caption = "Source: Wikipedia | rpt:004 ~ overriding labels" )
#--- Include the next lines in your selection for an object.
  damage_plot +
    label_object +
    geom_point( ) +
    geom_line( linewidth = 0.5 )+
      labs(caption = "Source: Wikipedia | rpt:005 ~ overriding labels" )
#------------------------------------------------------------
# P.172 - Adding fonts...
# windowsFonts( )
# install.packages( "extrafont" , dependencies = TRUE )
# font_import( prompt = FALSE )
# loadfonts( device = "win" )
# length( windowsFonts( )  )
# ^
# \
# +------ these don't work on my Linuxmint system
#------------------------------------------------------------
# P.172 - Adding a theme...
  theme_object <-
    theme ( plot.title =
              element_text( color = "Red"
                          , family = "Wide Latin"
                          )
          , plot.subtitle =
              element_text( color = "Red"
                          )
          , axis.title.x =
              element_text( color = "Red"
                          , face = "bold"
                          )
          , axis.title.y =
              element_text( color = "Red"
                          , face = "bold"
                          )
          , plot.caption =
              element_text( color = "Black"
                          , face = "italic"
                          )
          , legend.background =
              element_rect( color = "Gray"
                          )
          )
#
  damage_plot +
    label_object +
    geom_point( ) +
    geom_line( linewidth = 0.5 ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:006 ~ adding a theme" )
#------------------------------------------------------------
#P.175 - Comparing boxes (Boxplot)...
  gender_plot <-
    ggplot  ( frame
            , aes  ( x = Sex
                   , y = Deaths
                   , color = Sex
                   )
            #, size = 3 #? # source flagged...
            )
      gender_plot +
      label_object +
      xlab( "Gender" ) +
      ylab( "Number of Fatalities" ) +
      geom_jitter( ) +
      geom_boxplot( alpha = 0.5 ) + ylim( 10 , 200 ) +
      theme_object+
        labs(caption = "Source: Wikipedia | rpt:007 ~ comparing boxes" )
#------------------------------------------------------------
# P.176 - Identifying extremes...
  fatal_plot <-
    ggplot  ( frame
            , aes   ( x = Year
                    , y = Deaths
                    )
            )
#
  fatal_plot +
    label_object +
    ylab( "Number of Fatalities" ) +
    geom_point( aes( color = WindMPH )  ) +
#   geom_text( aes(label = Name )  ) +
    geom_text( aes( label =
                      ifelse( Deaths > 180
                            , Name
                            , ""
                            )
                  )
            , angle = 45
            , hjust = 1.1
            ) +
    geom_smooth( ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:008 ~ identifying extremes" )
#------------------------------------------------------------
# P.178 - Limiting focus...
  windspeed_plot <-
    ggplot  ( frame
            , aes ( x = Year
                  , y = Deaths
                  )
            )
#
  windspeed_plot +
    ylab( "Number of Fatalities" ) +
    geom_point  ( aes( color = WindMPH )
                , size = 10
                , shape = 17
                ) +
    label_object +
    xlim( 1980 , 2000 ) +
    ylim( 0 , 65 ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:009 ~ limiting focus" )
#------------------------------------------------------------
# P.179 - Zooming focus...
  windspeed_plot +
    geom_point ( aes( color = WindMPH )
               , size = 10
               , shape = 17
               ) +
    label_object +
    ylab( "Number of Fatalities" ) +
    xlim( 1980 , 2000 ) +
    ylim( 0 , 65 ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:010 ~ zooming focus" )
#
  strike_plot <-
    ggplot  ( frame
            , aes ( x = Year
                  , fill = Sex
                  )
            )
#
  strike_plot +
    label_object +
    ylab( "Number of Strikes" ) +
    geom_bar( ) +
    coord_cartesian( xlim = c( 1980 , 2000 )  ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:011 ~ coordinates" )
#------------------------------------------------------------
# P.180 - Displaying facets...
  frame.tx <-
    frame[ grep( "TX" , frame$AffectedStates ) , ]
#
  texas_plot <-
    ggplot  ( frame.tx
            , aes  ( x = Year
                   , y = DamageMillions
                   , size = Deaths
                   , color = AffectedStates
                   )
            )
#
  texas_plot +
    label_object +
    geom_point( aes( size = Deaths )  ) +
    facet_grid( AffectedStates~. ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:012 ~ displaying facets")
#------------------------------------------------------------
# P.181 - Displaying facets (cont'd)...
  frame.fl <-
    frame[ grep( "FL", frame$AffectedStates ) , ]
#
  florida_plot <-
    ggplot  ( frame.fl
            , aes(x = Year )
            )
#
  florida_plot +
    label_object +
    ylab( "Number of Strikes in Florida" ) +
    geom_histogram( aes ( fill = AffectedStates )
                  , color = "Black"
                  , bins = 20
                  ) +
    theme_object+
      labs(caption = "Source: Wikipedia | rpt:013 ~ displaying facets (cont'd)" )
#------------------------------------------------------------
# Cleanup
  detach( package:ggplot2 )
  rm( damage_plot
      ,fatal_plot
      ,florida_plot
      ,frame
      ,frame.fl
      ,frame.tx
      ,gender_plot
      ,label_object
      ,strike_plot
      ,texas_plot
      ,theme_object
      ,windspeed_plot )
#--End--------------------------------------------------------
