#packages load----------------------------------------------------------------------------------

library(tidyverse)
library(rlist)
library(gridExtra)
library(ggpattern)
library(gdxrrw)
library(openxlsx)
library(RColorBrewer)
library(imputeTS)



#setting------------------------------------------------------------------------
#path
path_iamc<-"../221110Climate/output/iiasa_database/txt/"
path_iamc2<-"../221110Climate/output/iiasa_database/gdx/"
path_ccs<-"../data/CCS/"
path_ar6<-"../data/AR6/"
path_output_fig<-"../fig/"

#theme
my_theme<-theme(
  panel.background = element_rect(fill = "transparent", colour = "black"),
  panel.grid = element_blank(),
  strip.background = element_blank(),
  legend.key = element_blank()
)

#figure setting
set2Pal <- brewer.pal(8, "Set2")
pastelpal <- brewer.pal(8, "Set1")


v_year1<-c("2005","2010","2015","2020","2025","2030","2035","2040","2045","2050","2055","2060","2065","2070","2075","2080","2085","2090","2095","2100")
v_year2<-c("2005","2010","2020","2030","2040","2050","2060","2070","2080","2090","2100")
v_year3<-c("2020","2025","2030","2035","2040","2045","2050","2055","2060","2065","2070","2075","2080","2085","2090","2095","2100")
v_year4<-c("2020","2030","2040","2050","2060","2070","2080","2090","2100")

v_cate<-c("C1","C2","C3","C4","C5","C6","C7","C8")
v_cate2<-c("C1","C2","C3","C4")

v_sce<-c("SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC")
v_sce2<-c("SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC","SSP2_500C_CACN_DAC_deep_NoCC")

v_scca<-c("C1","C2","C3","C4","C5","C6","C7","C8","SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC")
v_scca2<-c("C1","C2","SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC")
v_scca3<-c("C1","C2","C3","C4","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC")
v_scca4<-c("SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC")

v_sc_color1<-c("C1"="lightblue",
             "C2"="darkolivegreen4",
             "C3"="skyblue4",
             "C4"="slateblue2",
             "C5"="skyblue3",
             "C6"="goldenrod1",
             "C7"="coral2",
             "C8"="coral4",
             "SSP2_BaU_NoCC"="gray40",
             "SSP2_500C_CACN_DAC_NoCC"="orangered",
             "SSP2_500C_CACN_DAC_deep_NoCC"="darkolivegreen3",
             "SSP2_500C_CACN_DAC_deep2_NoCC"="dodgerblue3")

v_sc_color2<-c("C1"="lightblue",
               "C2"="darkolivegreen4",
               "C3"="skyblue4",
               "C4"="slateblue2",
               "C5"="skyblue3",
               "C6"="goldenrod1",
               "C7"="coral2",
               "C8"="coral4",
               "SSP2_BaU_NoCC"="NA",
               "SSP2_500C_CACN_DAC_NoCC"="NA",
               "SSP2_500C_CACN_DAC_deep_NoCC"="NA",
               "SSP2_500C_CACN_DAC_deep2_NoCC"="NA")

v_sc_color3<-c("C1"="lightblue",
               "C2"="darkolivegreen4",
               "SSP2_BaU_NoCC"="gray40",
               "SSP2_500C_CACN_DAC_NoCC"="orangered",
               "SSP2_500C_CACN_DAC_deep_NoCC"="darkolivegreen3",
               "SSP2_500C_CACN_DAC_deep2_NoCC"="dodgerblue3")

v_sc_color4<-c("C1"="lightblue",
               "C2"="darkolivegreen4",
               "SSP2_BaU_NoCC"="NA",
               "SSP2_500C_CACN_DAC_NoCC"="NA",
               "SSP2_500C_CACN_DAC_deep_NoCC"="NA",
               "SSP2_500C_CACN_DAC_deep2_NoCC"="NA")

v_sc_color5<-c("SSP2_500C_CACN_DAC_NoCC"="orangered",
               "SSP2_500C_CACN_DAC_deep_NoCC"="darkolivegreen3",
               "SSP2_500C_CACN_DAC_deep2_NoCC"="dodgerblue3")

v_sc_color6<-c("C1"="lightblue",
               "C2"="darkolivegreen4")

v_sc_color7<-c("C1"="lightblue",
               "C2"="darkolivegreen4",
               "C3"="skyblue4",
               "C4"="slateblue2",
               "SSP2_500C_CACN_DAC_NoCC"="orangered",
               "SSP2_500C_CACN_DAC_deep_NoCC"="darkolivegreen3",
               "SSP2_500C_CACN_DAC_deep2_NoCC"="dodgerblue3")

v_sc_lb<-c("C1"="C1",
           "C2"="C2",
           "C3"="C3",
           "C4"="C4",
           "C5"="C5",
           "C6"="C6",
           "C7"="C7",
           "C8"="C8",
           "SSP2_BaU_NoCC"="Baseline",
           "SSP2_500C_CACN_DAC_NoCC"="1p5C",
           "SSP2_500C_CACN_DAC_deep_NoCC"="PreInd",
           "SSP2_500C_CACN_DAC_deep2_NoCC"="CurClimate")

v_sc_sh<-c("SSP2_500C_CACN_DAC_NoCC"=4,
           "SSP2_500C_CACN_DAC_deep_NoCC"=16,
           "SSP2_500C_CACN_DAC_deep2_NoCC"=17)


lb_sce <- as_labeller(c("SSP2_BaU_NoCC"="Baseline",
                        "SSP2_500C_CACN_DAC_NoCC"="1p5C",
                        "SSP2_500C_CACN_DAC_deep_NoCC"="PreInd",
                        "SSP2_500C_CACN_DAC_deep2_NoCC"="CurClimate"))

v_re17<-c("USA","XE25","XER","TUR","XOC","CHN","IND","JPN","XSE","XSA","XLM","XME","CAN","CIS","BRA","XNF","XAF")
v_re5<-c("R5LAM","R5ASIA","R5OECD90+EU","R5MAF","R5REF")

v_cseq<-c("Carbon Sequestration|CCS|Biomass",
  "Carbon Sequestration|CCS|Fossil",
  "Carbon Sequestration|Land Use|Afforestation",
  "Carbon Sequestration|Direct Air Capture",
  "Carbon Sequestration|Enhanced Weathering",
  "Carbon Sequestration|Feedstock",
  "Carbon Sequestration|Other")

v_prm_color<- c("Primary Energy|Coal|w/o CCS"="#000000",
          "Primary Energy|Coal|w/ CCS"="#7f878f",
          "Primary Energy|Oil|w/o CCS"="#ff2800",
          "Primary Energy|Oil|w/ CCS"="#ffd1d1",
          "Primary Energy|Gas|w/o CCS"="#9a0079",
          "Primary Energy|Gas|w/ CCS"="#c7b2de",
          "Primary Energy|Hydro"="#0041ff",
          "Primary Energy|Nuclear"="#663300",
          "Primary Energy|Solar"="#b4ebfa",
          "Primary Energy|Wind"="#ff9900",
          "Primary Energy|Biomass|w/o CCS"="#35a16b",
          "Primary Energy|Biomass|w/ CCS"="#cbf266",
          "Primary Energy|Geothermal"="#edc58f",
          "Primary Energy|Other"="#ffff99")

v_prm_lb<-c("Primary Energy|Coal|w/o CCS"="Coal|w/o CCS",
            "Primary Energy|Coal|w/ CCS"="Coal|w/ CCS",
            "Primary Energy|Oil|w/o CCS"="Oil|w/o CCS",
            "Primary Energy|Oil|w/ CCS"="Oil|w/ CCS",
            "Primary Energy|Gas|w/o CCS"="Gas|w/o CCS",
            "Primary Energy|Gas|w/ CCS"="Gas|w/ CCS",
            "Primary Energy|Hydro"="Hydro",
            "Primary Energy|Nuclear"="Nuclear",
            "Primary Energy|Solar"="Solar",
            "Primary Energy|Wind"="Wind",
            "Primary Energy|Biomass|w/o CCS"="Biomass|w/o CCS",
            "Primary Energy|Biomass|w/ CCS"="Biomass|w/ CCS",
            "Primary Energy|Geothermal"="Geothermal",
            "Primary Energy|Other"="Other")

v_prm<- c("Primary Energy|Coal|w/o CCS",
                "Primary Energy|Coal|w/ CCS",
                "Primary Energy|Oil|w/o CCS",
                "Primary Energy|Oil|w/ CCS",
                "Primary Energy|Gas|w/o CCS",
                "Primary Energy|Gas|w/ CCS",
                "Primary Energy|Hydro",
                "Primary Energy|Nuclea",
                "Primary Energy|Solar",
                "Primary Energy|Wind",
                "Primary Energy|Biomass|w/o CCS",
                "Primary Energy|Biomass|w/ CCS",
                "Primary Energy|Geothermal",
                "Primary Energy|Other")

areapalette <- c("Coal|w/o CCS"="#000000",
                 "Coal|w/ CCS"="#7f878f",
                 "Oil|w/o CCS"="#ff2800",
                 "Oil|w/ CCS"="#ffd1d1",
                 "Gas|w/o CCS"="#9a0079",
                 "Gas|w/ CCS"="#c7b2de",
                 "Hydro"="#0041ff",
                 "Nuclear"="#663300",
                 "Solar"="#b4ebfa",
                 "Wind"="#ff9900",
                 "Biomass|w/o CCS"="#35a16b",
                 "Biomass|w/ CCS"="#cbf266",
                 "Geothermal"="#edc58f",
                 "Other"="#ffff99",
                 "Solid"=pastelpal[1],"Liquid"=pastelpal[2],"Gas"=pastelpal[3],"Electricity"=pastelpal[4],"Heat"=pastelpal[5],"Hydrogen"=pastelpal[6],
                 "Industry"=set2Pal[1],"Transport"=set2Pal[2],"Commercial"=set2Pal[3],"Residential"=set2Pal[4],
                 "Build-up"=pastelpal[1],"Cropland (for food)"=pastelpal[2],"Forest"=pastelpal[3],"Pasture"=pastelpal[4],"Energy Crops"=pastelpal[5],"Other Land"=pastelpal[6],"Other Arable Land"=pastelpal[7])

v_forc <- c("Forcing|CO2",
            "Forcing|Aerosol|BC",
            "Forcing|Aerosol|OC",
            "	Forcing|Aerosol|Other",
            "Forcing|Aerosol|Sulfate Direct",
            "Forcing|CH4",
            "FForcing|F-Gases",
            "Forcing|N2O",
            "Forcing|Other",
            "Forcing|Aerosol|Cloud Indirect",
            "Forcing|Aerosol|Black and Organic Carbon",
            "Forcing|Tropospheric Ozone"
            )

v_Temp<-c( "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|5.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|50.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|95.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|5.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|50.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|95.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|5.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|50.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|95.0th Percentile")

v_Temp2<-c("AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|5.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|50.0th Percentile",
           "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|95.0th Percentile")

v_ar6<-c("Emissions|CO2",
         "Carbon Sequestration|CCS|Biomass",
         "Carbon Sequestration|CCS|Fossil",
         "Carbon Sequestration|Land Use",
         "Carbon Sequestration|Direct Air Capture",
         "Carbon Sequestration|Enhanced Weathering",
         "Carbon Sequestration|Feedstock",
         "Carbon Sequestration|Other",
         "Price|Carbon",
         "GDP|MER",
         "Policy Cost|GDP Loss",
         "Consumption",
         "Primary Energy",
         "Policy Cost|Consumption Loss",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|5.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|50.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|CICERO-SCM|95.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|5.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|50.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|FaIRv1.6.2|95.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|5.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|50.0th Percentile",
         "AR6 climate diagnostics|Surface Temperature (GSAT)|MAGICCv7.5.3|95.0th Percentile")

df_ccsg<-data.frame(CCSgrade=c("grade1",  "grade2",  "grade3",  "grade4",  "grade5",  "grade6",  "grade7",  "grade8",  "grade9",  "grade10", "grade11"),
                    CCSres=factor(c("FF_land", "FF_land","FF_land","FF_land","FF_land","FF_sea","FF_sea","AQ_land", "FF_sea","FF_sea", "AQ_sea"),levels=c("AQ_sea","FF_sea","AQ_land","FF_land" )))
#data import--------------------------------------------------------------------

#AIMHub result
df_iamc <- read_csv(paste(path_iamc,"global_17_IAMC.csv",sep=""))%>%
  pivot_longer(cols=!c(MODEL,SCENARIO,REGION,VARIABLE,UNIT),names_to = "year",values_to="value")%>%
  filter(!(value %in% NA),SCENARIO%in%v_sce)

df_iamc2 <- rgdx.param(paste(path_iamc2,"global_17_IAMC.gdx",sep=""),"IAMC_Template")%>%
  filter(SCENARIO%in%v_sce)

#CCS storage estimate
df_ccs  <- rgdx.param(paste(path_ccs,"CCS_capacity.gdx",sep=""), "CO2_capacity_sr106_practical_hi")%>%
  left_join(rgdx.param(paste(path_ccs,"CCS_capacity.gdx",sep=""), "CO2_capacity_sr106_practical_lo"))%>%
  left_join(df_ccsg)%>%
  group_by(CCSres)%>%
  summarise(ccs_hi=sum(CO2_capacity_sr106_practical_hi)/1000,
            ccs_lo=sum(CO2_capacity_sr106_practical_lo)/1000)%>%
  ungroup()%>%
  mutate(year="2100")%>%
  bind_rows(
    rgdx.param(paste(path_ccs,"CCS_capacity.gdx",sep=""), "CO2_capacity_sr106_practical_hi")%>%
      left_join(rgdx.param(paste(path_ccs,"CCS_capacity.gdx",sep=""), "CO2_capacity_sr106_practical_lo"))%>%
      left_join(df_ccsg)%>%
      group_by(CCSres)%>%
      summarise(ccs_hi=sum(CO2_capacity_sr106_practical_hi)/1000,
                ccs_lo=sum(CO2_capacity_sr106_practical_lo)/1000)%>%
      ungroup()%>%
      mutate(year="2010")
  )

#AR6 database
df_ar6  <- read_csv(paste(path_ar6,"AR6_Scenario_Database.csv",sep=""))%>%
  filter(Variable %in% v_ar6)%>%
  pivot_longer(cols=!c(Model,Scenario,Region,Variable,Unit),names_to = "year",values_to="value")%>%
  filter(!(value %in% NA))%>%
  left_join(read.xlsx(paste(path_ar6,"AR6_Scenarios_Database_metadata_indicators_v1.1.xlsx",sep=""),sheet = "meta_Ch3vetted_withclimate")%>%
  select("Model","Scenario","Category"))%>%
  filter(!(Category %in% NA))


#Figure-------------------------------------------------------------------------

#Tempreture --------------------------------------------------------------------

p<- df_ar6%>%
  filter(Variable%in%v_Temp2,Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  mutate(Variable=str_extract(Variable, pattern="5.0th|95.0th|50.0th"))%>%
  group_by(Category,year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value),
            up5=quantile(value,
                         probs=0.95,
                         na.rm =T),
            up25=quantile(value,
                          probs=0.75,
                          na.rm =T),
            med=median(value,
                       na.rm =T),
            lo25=quantile(value,
                          probs=0.25,
                          na.rm =T),
            lo5=quantile(value,
                         probs=0.05,
                         na.rm =T))%>%
  ungroup()%>%  
  pivot_longer(cols=!c(Category,year,Unit,Region,Variable), names_to="stat", values_to="value")%>%
  mutate(Variable=paste(stat,Variable,sep="_"))%>%
  select(-stat)%>%
  filter(Variable=="lo5_50.0th"|Variable=="up5_50.0th"|Variable=="med_50.0th",Category=="C1"|Category=="C2")%>%
  pivot_wider(values_from=value, names_from=Variable)%>%
  rename(SCENARIO=Category,)%>%
  mutate(MODEL="AR6",
         SCENARIO=factor(SCENARIO,levels=v_scca2))%>%
  ggplot(aes(group = interaction(MODEL,SCENARIO)))
p <- p + geom_ribbon(aes(x = year, ymin=lo5_50.0th, ymax=up5_50.0th, fill=SCENARIO),alpha = 0.35)
p <- p + geom_line(aes(x = year, y=med_50.0th, color=SCENARIO, size=MODEL),alpha=0.4,size=0.8)
p <- p + geom_line(data = 
                     df_iamc%>%
                     filter(VARIABLE=="Temperature|Global Mean",REGION=="World")%>%  
                     mutate(SCENARIO=factor(SCENARIO,levels=v_scca2)
                            ),
                   aes(x = year, y = value, color=SCENARIO, size=MODEL))
p <- p  +  scale_x_discrete(breaks=c("2010","2030","2050","2070","2090"))
p <- p + scale_fill_manual(values=v_sc_color4,labels=v_sc_lb)
p <- p + scale_color_manual(values=v_sc_color3,labels=v_sc_lb)
p <- p + scale_size_manual(values=c(2.6,1.4))
p <- p + my_theme
p <- p  + theme(text = element_text(size = 35),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="none")
p <- p + labs(x="", y="Temperature change (degree Celsius)")
p1<-p + ggtitle("a")
png(paste(path_output_fig,"Temp1.png",sep=""), width = 3400, height = 3800, res=300)
print(p)
dev.off() 

#Emission CO2------------------------------------------------------------------

p<- df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  group_by(Category,year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value),
            up5=quantile(value,
                          probs=0.95,
                          na.rm =T),
           up25=quantile(value,
                         probs=0.75,
                         na.rm =T),
            med=median(value,
                       na.rm =T),
           lo25=quantile(value,
                         probs=0.25,
                         na.rm =T),
           lo5=quantile(value,
                         probs=0.05,
                         na.rm =T))%>%
  ungroup()%>%  
  rename(SCENARIO=Category)%>%
  mutate(MODEL="AR6 median",
         SCENARIO=factor(SCENARIO,levels=v_scca))%>%
  ggplot(aes(group = interaction(MODEL,SCENARIO)))
p <- p + geom_ribbon(aes(x = year, ymin=lo25/1000, ymax=up25/1000, fill=SCENARIO),alpha = 0.15)
p <- p + geom_line(aes(x = year, y=med/1000, color=SCENARIO, linetype=MODEL),alpha=0.7,size=0.8)
p <- p + geom_line(data = df_iamc%>%
                     filter(VARIABLE=="Emissions|CO2",REGION=="World")%>%  
                     mutate(SCENARIO=factor(SCENARIO,levels=v_scca)),
                   aes(x = year, y = value/1000, color=SCENARIO, linetype=MODEL),
                   size=1.5)
p <- p + scale_fill_manual(values=v_sc_color2,labels=v_sc_lb)
p <- p + scale_color_manual(values=v_sc_color1,labels=v_sc_lb)
p <- p + my_theme
p <- p  +  scale_x_discrete(breaks=c("2010","2020","2030","2040","2050","2060","2070","2080","2090","2100"))
p <- p  + theme(text = element_text(size = 40),
                          axis.text.x = element_text(angle = 0, 
                                                     hjust = 0.5,
                                                     vjust = 0.5,
                                                     size = 30),
                          legend.position ="bottom",
                          legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="", y="Carbo dioxide emission (Gt/year)",fill="Scenario",color="Scenario",linetype="Data source")
png(paste(path_output_fig,"CO2_emission1.png",sep=""), width = 5000, height = 4000,res = 300)
print(p)
dev.off() 




p<- df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  group_by(Category,year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value),
            up5=quantile(value,
                         probs=0.95,
                         na.rm =T),
            up25=quantile(value,
                          probs=0.75,
                          na.rm =T),
            med=median(value,
                       na.rm =T),
            lo25=quantile(value,
                          probs=0.25,
                          na.rm =T),
            lo5=quantile(value,
                         probs=0.05,
                         na.rm =T))%>%
  ungroup()%>%  
  rename(SCENARIO=Category)%>%
  mutate(MODEL="AR6 median by category",
         SCENARIO=factor(SCENARIO,levels=v_scca))%>%
  ggplot(aes(group = SCENARIO))
p <- p + geom_ribbon(aes(x = year, ymin=lo25/1000, ymax=up25/1000, fill=SCENARIO),alpha = 0.35)
p <- p + geom_line(aes(x = year, y=med/1000, color=SCENARIO, linetype=MODEL,size=MODEL),alpha = 0.4)
p <- p + geom_line(data = df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  group_by(year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value))%>%
  ungroup()%>%  
  mutate(MODEL="AR6 range",
         SCENARIO="AR6"),
  aes(x = year, y = min/1000,linetype=MODEL,size=MODEL))
p <- p + geom_line(data = df_ar6%>%
                     filter(Variable=="Emissions|CO2",Region=="World",year!="2005",Category%in%v_cate)%>%
                     filter(year %in% v_year2)%>%
                     group_by(year,Unit,Region,Variable)%>%
                     summarise(max=max(value),
                               min=min(value))%>%
                     ungroup()%>%  
                     mutate(MODEL="AR6 range",
                            SCENARIO="AR6"),
                   aes(x = year, y = max/1000,linetype=MODEL,size=MODEL)
                   )
p <- p + geom_line(data = df_iamc%>%
                     filter(VARIABLE=="Emissions|CO2",REGION=="World")%>%  
                     mutate(SCENARIO=factor(SCENARIO,levels=v_scca)),
                   aes(x = year, y = value/1000, color=SCENARIO, linetype=MODEL,size=MODEL)
                   )
p <- p + scale_fill_manual(values=v_sc_color2,labels=v_sc_lb)
p <- p + scale_color_manual(values=v_sc_color1,labels=v_sc_lb)
p <- p + scale_linetype_manual(values=c("solid","solid","longdash"))
p <- p + scale_size_manual(values=c(2.4,1.2,1))
p <- p + my_theme
p <- p  +  scale_x_discrete(breaks=c("2010","2030","2050","2070","2090"))
p <- p  + theme(text = element_text(size = 35),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right",
                 legend.key.size = unit(1.5, 'cm'))
p <- p　+ guides(color = guide_legend(override.aes = list(size = 1.8)))
p <- p + labs(x="", y="Carbo dioxide emission (Gt/year)",fill="Scenario",color="Scenario",linetype="Data source",size="Data source")
p2 <- p + ggtitle("b")
png(paste(path_output_fig,"CO2_emission2.png",sep=""), width = 5200, height = 3800,res = 300)
print(p)
dev.off() 



df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  group_by(year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value))%>%
  ungroup()%>%  
  mutate(MODEL="AR6 range")%>%
View()










p<- df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  rename(SCENARIO=Scenario,
         MODEL=Model)%>%
  ggplot(aes(group = interaction(MODEL,SCENARIO)))
p <- p + geom_line(aes(x = year, y=value/1000, color=Category),alpha=0.03)
p <- p + geom_line(data = df_iamc%>%
                     filter(VARIABLE=="Emissions|CO2",REGION=="World")%>%  
                     mutate(SCENARIO=factor(SCENARIO,levels=v_scca)),
                   aes(x = year, y = value/1000, color=SCENARIO))
p <- p + scale_color_manual(values=v_sc_color1,labels=v_sc_lb)
p <- p + my_theme
p
p <- p  + theme(text = element_text(size = 50),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 40),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="", y="CO2 emission (Gt-CO2)")
# png(paste(path_output_fig,"CO2_emission2.png",sep=""), width = 6000, height = 5000,res = 300)
# print(p)
# dev.off() 








#Carbon sequestration---------------------------------------------------------------

p<- df_iamc%>%
  filter(VARIABLE %in% v_cseq,year=="2050"|year=="2100",REGION=="World")%>%
  mutate(SCENARIO=factor(SCENARIO,levels=c("AR6","SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC","SSP2_500C_CACN_DAC_deep_NoCC")))%>%
  ggplot(aes(x = SCENARIO , y = value/1000))
p <- p + facet_wrap(. ~ year, scales = "fix",nrow=1)
p <- p+ geom_boxplot(data=  df_ar6%>%
                       filter(Variable %in% v_cseq,year=="2050"|year=="2100",Region=="World",Category=="C1"|Category=="C2")%>%
                       mutate(value=abs(value))%>%
                       group_by(Model,Scenario,Region,Category,year,Unit)%>%
                       summarise(value=sum(value))%>%
                       ungroup()%>%
                       mutate(SCENARIO=factor("AR6",levels=c("AR6","SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC","SSP2_500C_CACN_DAC_deep_NoCC"))),
                     aes(group=interaction(Category,SCENARIO),fill=Category),alpha=0.5)
p <- p + stat_boxplot(data=  df_ar6%>%
                        filter(Variable %in% v_cseq,year=="2050"|year=="2100",Region=="World",Category=="C1"|Category=="C2")%>%
                        mutate(value=abs(value))%>%
                        group_by(Model,Scenario,Region,Category,year,Unit)%>%
                        summarise(value=sum(value))%>%
                        ungroup()%>%
                        mutate(SCENARIO=factor("AR6",levels=c("AR6","SSP2_BaU_NoCC","SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC","SSP2_500C_CACN_DAC_deep_NoCC"))),
                      aes(group=interaction(Category,SCENARIO)),geom='errorbar',alpha=0.35)
p <- p + geom_bar(aes(group = VARIABLE, fill = VARIABLE), stat = "identity", width=0.6,color="grey30")
p <- p + scale_x_discrete(limits=c("SSP2_BaU_NoCC", "SSP2_500C_CACN_DAC_NoCC","SSP2_500C_CACN_DAC_deep2_NoCC","SSP2_500C_CACN_DAC_deep_NoCC","AR6"),labels = c("AR6"="AR6","SSP2_BaU_NoCC"="baseline","SSP2_500C_CACN_DAC_NoCC"="1p5C","SSP2_500C_CACN_DAC_deep_NoCC"="PreInd","SSP2_500C_CACN_DAC_deep2_NoCC"="Current"))
p <- p + scale_fill_manual(values=c("lightblue","darkolivegreen4","olivedrab3","grey50","turquoise3","peru"),labels=c("C1","C2","CCS_Biomass","CCS_Fossil","Direct_Air_Capture","Land_Use"))
p <- p + geom_hline(yintercept = 0, color = "grey40")
p <- p + my_theme
p <- p  + theme(text = element_text(size = 40),
                axis.text.x = element_text(angle = 90, 
                                           hjust = 1,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "horizontal",
                legend.text = element_text(size = 30)
)
p <- p　+   theme(legend.position ="bottom")
p <- p + labs(x="", y="CO2 sequestration (Gt/year)",fill="")
p3<- p + ggtitle("c") 
png(paste(path_output_fig,"CO2_seq.png",sep=""), width = 4500, height = 4000,res = 300)
print(p)
dev.off() 


#Primary energy-----------------------------------------------------------------

p<- df_iamc%>%
  filter(VARIABLE%in% v_prm,REGION=="World",year!="2010",year!="2015")%>%
  mutate(VARIABLE=factor(VARIABLE,levels=rev(v_prm)))%>%
  ggplot(aes(x = year , y = value))
p <- p + geom_area(aes(group= VARIABLE, fill = VARIABLE))
p <- p + facet_wrap(. ~ fct_rev(SCENARIO), nrow = 1,labeller=lb_sce)
p <- p + scale_fill_manual(values=v_prm_color,labels=v_prm_lb)
p <- p  +  scale_x_discrete(breaks=c("2030","2050","2070","2090"))
p <- p + my_theme
p <- p  + theme(text = element_text(size = 40),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="", y="Primary energy (EJ/year)",fill="")
png(paste(path_output_fig,"prm1.png",sep=""), width = 8000, height = 4000,res = 300)
print(p)
dev.off() 


p<- df_ar6%>%
  filter(Variable=="Primary Energy",Region=="World",year!="2005",Category%in%v_cate)%>%
  filter(year %in% v_year2)%>%
  group_by(Category,year,Unit,Region,Variable)%>%
  summarise(max=max(value),
            min=min(value),
            up5=quantile(value,
                         probs=0.95,
                         na.rm =T),
            up25=quantile(value,
                          probs=0.75,
                          na.rm =T),
            med=median(value,
                       na.rm =T),
            lo25=quantile(value,
                          probs=0.25,
                          na.rm =T),
            lo5=quantile(value,
                         probs=0.05,
                         na.rm =T))%>%
  ungroup()%>%  
  rename(SCENARIO=Category)%>%
  mutate(MODEL="AR6 median by category",
         SCENARIO=factor(SCENARIO,levels=v_scca))%>%
  ggplot(aes(group = SCENARIO))
p <- p + geom_ribbon(aes(x = year, ymin=lo25, ymax=up25, fill=SCENARIO),alpha = 0.35)
p <- p + geom_line(aes(x = year, y=med, color=SCENARIO, linetype=MODEL,size=MODEL),alpha = 0.5)
p <- p + geom_line(data = df_ar6%>%
                     filter(Variable=="Primary Energy",Region=="World",year!="2005",Category%in%v_cate)%>%
                     filter(year %in% v_year2)%>%
                     group_by(year,Unit,Region,Variable)%>%
                     summarise(max=max(value),
                               min=min(value))%>%
                     ungroup()%>%  
                     mutate(MODEL="AR6 range",
                            SCENARIO="AR6"),
                   aes(x = year, y = min,linetype=MODEL,size=MODEL))
p <- p + geom_line(data = df_ar6%>%
                     filter(Variable=="Primary Energy",Region=="World",year!="2005",Category%in%v_cate)%>%
                     filter(year %in% v_year2)%>%
                     group_by(year,Unit,Region,Variable)%>%
                     summarise(max=max(value),
                               min=min(value))%>%
                     ungroup()%>%  
                     mutate(MODEL="AR6 range",
                            SCENARIO="AR6"),
                   aes(x = year, y = max,linetype=MODEL,size=MODEL)
)
p <- p + geom_line(data = df_iamc%>%
                     filter(VARIABLE=="Primary Energy",REGION=="World")%>%  
                     mutate(SCENARIO=factor(SCENARIO,levels=v_scca)),
                   aes(x = year, y = value, color=SCENARIO, linetype=MODEL,size=MODEL)
)

p <- p + scale_fill_manual(values=v_sc_color2,labels=v_sc_lb)
p <- p + scale_color_manual(values=v_sc_color1,labels=v_sc_lb)
p <- p + scale_linetype_manual(values=c("solid","solid","longdash"))
p <- p + scale_size_manual(values=c(2.2,1.2,1))
p <- p + my_theme
p <- p  +  scale_x_discrete(breaks=c("2010","2030","2050","2070","2090"))
p <- p  + theme(text = element_text(size = 35),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right",
                 legend.key.size = unit(1.5, 'cm'))
p <- p + coord_cartesian(ylim = c(-10,NA))
p <- p　+ guides(color = guide_legend(override.aes = list(size = 1.8)))
p <- p + labs(x="", y="Primary energy supply (EJ/year)",fill="Scenario",color="Scenario",linetype="Data source",size="Data source")
p6<- p + ggtitle("b")
png(paste(path_output_fig,"Primary_energy.png",sep=""), width = 5200, height = 3800,res = 300)
print(p)
dev.off() 



#Radiative forcing--------------------------------------------------------------
p<- df_iamc%>%
  filter(VARIABLE%in% v_forc,REGION=="World",year!="2010",year!="2015")%>%
  mutate(VARIABLE=factor(VARIABLE,levels=rev(v_forc)))%>%
ggplot(aes(x = year , y = value))
p <- p + geom_area(aes(group= VARIABLE, fill = VARIABLE))
p <- p  +  scale_x_discrete(breaks=c("2030","2050","2070","2090"))
p <- p + facet_wrap(. ~ fct_rev(SCENARIO), nrow = 1,labeller=lb_sce)
p <- p + scale_fill_viridis_d(labels=c("Tropospheric Ozone","Black and Organic Carbon","Cloud Indirect","Other","N2O","CH4","Sulfer Direct","OC","BC","CO2"))
p <- p + my_theme
p <- p  + theme(text = element_text(size = 40),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="", y="Radiative forcing (W/m2)",fill="source")
png(paste(path_output_fig,"forc1.png",sep=""), width = 8000, height = 4000,res = 300)
print(p)
dev.off() 



#Carbon price-------------------------------------------------------------------


p <- df_ar6%>%
  filter(Variable=="Price|Carbon",Region=="World",year=="2030"|year=="2050"|year=="2100",Category=="C1"|Category=="C2")%>%
  ggplot(aes(x = year,
             y = value))
p <- p + geom_boxplot(aes(group = interaction(year,Category),
                      fill = Category),
                      position="dodge",
                      width=0.4,
                      alpha=0.5)
p <- p + stat_boxplot(aes(group = interaction(year,Category)),position="dodge",geom='errorbar',width=0.4,alpha=0.5)
p <- p + coord_cartesian(ylim = c(-10, 1000))
p <- p + geom_point(data=df_iamc%>%
                      filter(VARIABLE=="Price|Carbon",REGION=="World",year=="2030"|year=="2050"|year=="2100")%>%  
                      mutate(SCENARIO=factor(SCENARIO,levels=v_scca)),
                    aes(group =SCENARIO ,color=SCENARIO),size=8,alpha=0.8)
p <- p + scale_color_manual(values=v_sc_color5,labels=v_sc_lb)
p <- p + scale_fill_manual(values=v_sc_color6)
#p <- p + scale_shape_manual(values=c(4,17,15),labels=v_sc_lb)
p <- p + my_theme
p <- p  + theme(text = element_text(size = 40),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p + labs(x="", y="Carbon Price($/tCO2)",color="Scenario")
p5<- p + ggtitle("a")
png(paste(path_output_fig,"PrcCar2.png",sep=""), width = 4500, height = 4000,res = 300)
print(p)
dev.off() 



#CumulativeCCS------------------------------------------------------------------

p<-df_iamc%>%
  filter(VARIABLE=="Carbon Sequestration|CCS",REGION=="World")%>%
  group_by(SCENARIO)%>%
  mutate(cumccs=cumsum(value)*5/1000)%>%
  ungroup()%>%
  ggplot()
p<-p+geom_area(data=df_ccs,
              aes(fill=CCSres,
                  group=CCSres,
                  x=year,y=ccs_lo),
              alpha=0.25)
p<-p+geom_line(aes(x = year,
                   y = cumccs,
                   group = SCENARIO,
                   color = SCENARIO),size=2.5)
p <- p + scale_color_manual(values=v_sc_color5,labels=v_sc_lb)
p <- p + scale_fill_manual(labels=c("Saline aquifer/sea","Oil gas field/sea","Saline aquifer/land","Coal oil gas field/land"),
                           values=c("lightsteelblue","gold","grey50","orange3"))
p <- p + my_theme
p <- p  + theme(text = element_text(size = 40),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical",
                legend.text = element_text(size = 30),
                legend.title = element_text(size = 35)
)
p <- p　+   theme(legend.position ="right",
                 legend.key.size = unit(1.5, 'cm'))
p <- p  +  scale_x_discrete(breaks=c("2010","2030","2050","2070","2090"))
p <- p + labs(x="", y="Cumulative CO2 storage amount (Gt)",fill="CCS storage capacity",color="Scenario")
p4<-p + ggtitle("d")
png(paste(path_output_fig,"CCS_sto.png",sep="") , width = 5000, height = 4000,res = 300)
print(p)
dev.off() 


#GDP loss-----------------------------------------------------------------------


p <- df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",Category%in%v_cate2,year%in%v_year3)%>%
  group_by(Category,Model,Scenario,Unit,Region,Variable)%>%
  summarise(CO2cum=mean(value)*81/1000)%>%
  ungroup()%>% 
  select(-Unit,-Variable)%>%
  left_join(df_ar6%>%
  filter(Variable=="Policy Cost|GDP Loss"|Variable=="GDP|MER",Region=="World",Category%in%v_cate,year%in%v_year3)%>%
  pivot_wider(names_from=Variable,values_from=value)%>%
  na.omit()%>%
  rename("GDP"="GDP|MER","loss"="Policy Cost|GDP Loss")%>%
  mutate(GDPbau=GDP+loss,
         disc_GDP=GDP*(1-0.05)^(as.numeric(year)-2020),
         disc_GDPbau=GDPbau*(1-0.05)^(as.numeric(year)-2020))%>%
  group_by(Category,Model,Scenario,Unit,Region)%>%
  summarise(GDPloss=-(sum(disc_GDP)-sum(disc_GDPbau))*100/sum(disc_GDPbau))%>%
  ungroup()%>%
  select(-Unit))%>%
  na.omit()%>%
  mutate(Category=factor(Category,levels=v_scca3))%>%
  ggplot(aes(x = CO2cum, y = abs(GDPloss)))
p <- p + geom_point(aes(group=Category, color=Category),alpha=0.4,size=7)
p <- p + geom_point(data=df_iamc%>%
  filter(VARIABLE=="GDP|MER",REGION=="World",year%in%v_year3,SCENARIO%in%v_sce)%>%
  mutate(disc_value=value*(1-0.05)^(as.numeric(year)-2020))%>%
  group_by(MODEL,SCENARIO,UNIT,REGION,VARIABLE)%>%
  summarise(cum=sum(disc_value))%>%
  ungroup()%>%
  select(-UNIT,-VARIABLE)%>%
  left_join(df_iamc%>%
              filter(VARIABLE=="GDP|MER",REGION=="World",year%in%v_year3,SCENARIO=="SSP2_BaU_NoCC")%>%
              mutate(disc_value=value*(1-0.05)^(as.numeric(year)-2020))%>%
              group_by(MODEL,SCENARIO,UNIT,REGION,VARIABLE)%>%
              summarise(cumbau=sum(disc_value))%>%
              ungroup()%>%
              select(-UNIT,-SCENARIO,-VARIABLE)
  )%>%
  mutate(GDPloss=(cum-cumbau)*100/cumbau)%>%
  left_join(df_iamc2%>%
              filter(VEMF=="Emi_CO2_Cum",REMF=="World",YEMF=="2100",SCENARIO%in%v_sce)%>%
              mutate(CO2cum=IAMC_Template/1000)%>%
              select(SCENARIO,CO2cum))%>%
    filter(SCENARIO!="SSP2_BaU_NoCC")%>%
    mutate(SCENARIO=factor(SCENARIO,levels=v_scca3)),
  aes(group=SCENARIO, color=SCENARIO),size=9,alpha=0.8)
#p<-p+geom_smooth(method="lm",formula='y ~ x',se=F,color="grey30",linetype="dashed")
p <- p + scale_color_manual(values=v_sc_color7,labels=v_sc_lb)
#p <- p + scale_shape_manual(values=c("C1"=16,"C2"=16,"C3"=16,"C4"=16,"SSP2_500C_CACN_DAC_deep2_NoCC"=17,"SSP2_500C_CACN_DAC_deep_NoCC"=15,"SSP2_500C_CACN_DAC_NoCC"=4),labels=v_sc_lb)
p <- p + my_theme
p <- p  + theme(text = element_text(size = 35),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="none")
p <- p + labs(x="Cumulative CO2 emissions (Gt) from 2020 to 2100", y="GDP loss (%)",color="Scenario",shape="Scenario")
p7<- p + ggtitle("c")
png(paste(path_output_fig,"GDP_CO2.png",sep=""),  width = 4500, height = 5000,res = 300)
print(p)
dev.off() 

  
#HH loss------------------------------------------------------------------------


p <- df_ar6%>%
  filter(Variable=="Emissions|CO2",Region=="World",Category%in%v_cate2,year%in%v_year3)%>%
  group_by(Category,Model,Scenario,Unit,Region,Variable)%>%
  summarise(CO2cum=mean(value)*81/1000)%>%
  ungroup()%>% 
  select(-Unit,-Variable)%>%
  left_join(df_ar6%>%
              filter(Variable=="Policy Cost|Consumption Loss"|Variable=="Consumption",Region=="World",Category%in%v_cate,year%in%v_year3)%>%
              pivot_wider(names_from=Variable,values_from=value)%>%
              na.omit()%>%
              rename("CNS"="Consumption","loss"="Policy Cost|Consumption Loss")%>%
              mutate(CNSbau=CNS+loss,
                     disc_CNS=CNS*(1-0.05)^(as.numeric(year)-2020),
                     disc_CNSbau=CNSbau*(1-0.05)^(as.numeric(year)-2020))%>%
              group_by(Category,Model,Scenario,Unit,Region)%>%
              summarise(CNSloss=-(sum(disc_CNS)-sum(disc_CNSbau))*100/sum(disc_CNSbau))%>%
              ungroup()%>%
              select(-Unit))%>%
  na.omit()%>%
  ggplot(aes(x = CO2cum, y = abs(CNSloss)))
p <- p + geom_point(aes(group=Category, color=Category),alpha=0.4,size=7)
p <- p + geom_point(data=df_iamc%>%
                      filter(VARIABLE=="Consumption",REGION=="World",year%in%v_year3,SCENARIO%in%v_sce)%>%
                      mutate(disc_value=value*(1-0.05)^(as.numeric(year)-2020))%>%
                      group_by(MODEL,SCENARIO,UNIT,REGION,VARIABLE)%>%
                      summarise(cum=sum(disc_value))%>%
                      ungroup()%>%
                      select(-UNIT,-VARIABLE)%>%
                      left_join(df_iamc%>%
                                  filter(VARIABLE=="Consumption",REGION=="World",year%in%v_year3,SCENARIO=="SSP2_BaU_NoCC")%>%
                                  mutate(disc_value=value*(1-0.05)^(as.numeric(year)-2020))%>%
                                  group_by(MODEL,SCENARIO,UNIT,REGION,VARIABLE)%>%
                                  summarise(cumbau=sum(disc_value))%>%
                                  ungroup()%>%
                                  select(-UNIT,-SCENARIO,-VARIABLE)
                      )%>%
                      mutate(CNSloss=(cum-cumbau)*100/cumbau)%>%
                      left_join(df_iamc2%>%
                                  filter(VEMF=="Emi_CO2_Cum",REMF=="World",YEMF=="2100",SCENARIO%in%v_sce)%>%
                                  mutate(CO2cum=IAMC_Template/1000)%>%
                                  select(SCENARIO,CO2cum))%>%
                      filter(SCENARIO!="SSP2_BaU_NoCC"),
                    aes(group=SCENARIO, color=SCENARIO),size=9,alpha=0.8)
#p<-p+geom_smooth(method="lm",formula='y ~ x',se=F,color="grey30",linetype="dashed")
p <- p + scale_color_manual(values=v_sc_color7,labels=v_sc_lb)
p <- p + my_theme
p <- p  + theme(text = element_text(size = 35),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 30),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="Cumulative CO2 emissions from 2020 to 2100 (Gt)", y="Household consumption loss (%)",color="Scenario")
p8<- p + ggtitle("d")
png(paste(path_output_fig,"HH_CO2.png",sep=""), width = 4500, height = 5000,res = 300)
print(p)
dev.off() 






p<- df_iamc2%>%
  filter(VEMF=="Pol_Cos_Cns_Los_rat"|VEMF=="GDP_per_cap",YEMF%in%v_year4,SCENARIO%in%v_sce,REMF%in%v_re17,SCENARIO!="SSP2_BaU_NoCC")%>%
  pivot_wider(names_from=VEMF,values_from=IAMC_Template)%>%
  ggplot(aes(x = GDP_per_cap, y = Pol_Cos_Cns_Los_rat))
#p <- p + facet_wrap(. ~ YEMF, scales = "free")
p<-p+geom_point(aes(color=REMF),size=4,alpha=0.7)
p<-p+scale_x_log10()
p<-p+geom_smooth(method="lm",formula='y ~ x',se=F,color="grey30",linetype="dashed")
p <- p + my_theme
p <- p  + theme(text = element_text(size = 30),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 20),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="GDP per capita (1000$/capita)", y="Household consumption loss (%)",color="Region")
png(paste(path_output_fig,"HH_GDP_cap.png",sep=""), width = 4500, height = 4000,res = 300)
print(p)
dev.off()




p<- df_iamc2%>%
  filter(VEMF=="Pol_Cos_Cns_Los_rat"|VEMF=="GDP_per_cap",YEMF%in%v_year4,SCENARIO%in%v_sce,REMF%in%v_re5,SCENARIO!="SSP2_BaU_NoCC")%>%
  pivot_wider(names_from=VEMF,values_from=IAMC_Template)%>%
  mutate(SCENARIO=factor(SCENARIO,levels=v_sce2))%>%
  ggplot(aes(x = GDP_per_cap, y = Pol_Cos_Cns_Los_rat))
#p <- p + facet_wrap(. ~ YEMF, scales = "free")
p<-p+geom_point(aes(color=REMF,fill=REMF,shape=SCENARIO),size=4,alpha=0.75,stroke=1.5)
p<-p+scale_x_log10()
p<-p+geom_smooth(method="lm",formula='y ~ x',se=F,color="grey30",linetype="dashed")
p<-p+scale_shape_manual(values=v_sc_sh,labels=v_sc_lb)
p <- p + my_theme
p <- p  + theme(text = element_text(size = 30),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 20),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="GDP per capita (1000$/capita)", y="Household consumption loss (%)",color="Region",fill="Region",shape="Scenario")
png(paste(path_output_fig,"HH_GDP_cap_r5.png",sep=""), width = 4000, height = 3500,res = 300)
print(p)
dev.off() 


p<- df_iamc2%>%
  filter(VEMF=="Pol_Cos_Cns_Los_rat"|VEMF=="GDP_per_cap",YEMF%in%v_year4,SCENARIO%in%v_sce,REMF%in%v_re5,SCENARIO!="SSP2_BaU_NoCC",YEMF!="2020",YEMF!="2030",YEMF!="2040")%>%
  pivot_wider(names_from=VEMF,values_from=IAMC_Template)%>%
  ggplot(aes(x = GDP_per_cap, y = Pol_Cos_Cns_Los_rat))
#p <- p + facet_wrap(. ~ YEMF, scales = "free")
p<-p+geom_point(aes(color=REMF),size=4,alpha=0.7)
p<-p+scale_x_log10()
p<-p+geom_smooth(method="lm",formula='y ~ x',se=F,color="grey30",linetype="dashed")
p <- p + my_theme
p <- p  + theme(text = element_text(size = 30),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 20),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="GDP per capita (1000$/capita)", y="Household consumption loss (%)",color="Region")
png(paste(path_output_fig,"HH_GDP_cap_r5_2050.png",sep=""), width = 4500, height = 4000,res = 300)
print(p)
dev.off() 

  
p<- df_iamc2%>%
  filter(VEMF=="Pol_Cos_Cns_Los_rat"|VEMF=="GDP_per_cap",
         YEMF%in%v_year4,
         SCENARIO%in%v_sce,
         REMF%in%v_re17,
         SCENARIO!="SSP2_BaU_NoCC",
         YEMF!="2020",YEMF!="2030",YEMF!="2040")%>%
  pivot_wider(names_from=VEMF,values_from=IAMC_Template)%>%
  mutate(SCENARIO=factor(SCENARIO,levels=v_sce2))%>%
  ggplot(aes(x = GDP_per_cap, y = Pol_Cos_Cns_Los_rat))
p <- p + facet_wrap(. ~ REMF, scales = "free")
p<-p+geom_point(aes(color=SCENARIO),alpha=0.7,size=3)
p<-p+scale_color_manual(values=v_sc_color5,labels=v_sc_lb)
p<-p+scale_x_log10()
p<-p+geom_smooth(aes(color=SCENARIO),method="lm",formula='y ~ x',se=F,linetype="dashed")
p <- p + my_theme
p <- p  + theme(text = element_text(size = 20),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 10),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="GDP per capita (1000$/capita)", y="Household consumption loss (%)",color="Scenario")
png(paste(path_output_fig,"HH_GDP_cap2.png",sep=""), width = 5500, height = 4000,res = 300)
print(p)
dev.off() 
  
  



p<- df_iamc2%>%
  filter(VEMF=="Pol_Cos_Cns_Los_rat"|VEMF=="GDP_per_cap",
         YEMF%in%v_year4,
         SCENARIO%in%v_sce,
         REMF%in%v_re5,
         SCENARIO!="SSP2_BaU_NoCC",
         YEMF!="2020",YEMF!="2030",YEMF!="2040")%>%
  pivot_wider(names_from=VEMF,values_from=IAMC_Template)%>%
  mutate(SCENARIO=factor(SCENARIO,levels=v_sce2))%>%
  ggplot(aes(x = GDP_per_cap, y = Pol_Cos_Cns_Los_rat))
p <- p + facet_wrap(. ~ REMF, scales = "free")
p<-p+geom_point(aes(color=SCENARIO),alpha=0.7,size=3)
p<-p+scale_color_manual(values=v_sc_color5,labels=v_sc_lb)
p<-p+scale_x_log10()
p<-p+geom_smooth(aes(color=SCENARIO),method="lm",formula='y ~ x',se=F,linetype="dashed")
p <- p + my_theme
p <- p  + theme(text = element_text(size = 20),
                axis.text.x = element_text(angle = 0, 
                                           hjust = 0.5,
                                           vjust = 0.5,
                                           size = 10),
                legend.position ="bottom",
                legend.direction = "vertical"
)
p <- p　+   theme(legend.position ="right")
p <- p + labs(x="GDP per capita (1000$/capita)", y="Household consumption loss (%)",color="Scenario")
png(paste(path_output_fig,"HH_GDP_cap2_r5.png",sep=""), width = 5500, height = 4000,res = 300)
print(p)
dev.off() 

  



#for paper---------------------------------------------------------------------

png(paste(path_output_fig,"fig1.png",sep=""), width = 7200, height = 7000,res = 300)
   layout1<-rbind(c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2),c(3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4))
   p<-grid.arrange(p1, p2,p3,p4,layout_matrix =layout1)
   print(p)
dev.off()


png(paste(path_output_fig,"fig2.png",sep=""), width = 7200, height = 7000,res = 300)
layout1<-rbind(c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2),
               c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2),
               c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2),
               c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2),
               c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2),
               c(3,3,3,3,3,3,3,3,3,NA,4,4,4,4,4,4,4,4,4,4,4),
               c(3,3,3,3,3,3,3,3,3,NA,4,4,4,4,4,4,4,4,4,4,4),
               c(3,3,3,3,3,3,3,3,3,NA,4,4,4,4,4,4,4,4,4,4,4),
               c(3,3,3,3,3,3,3,3,3,NA,4,4,4,4,4,4,4,4,4,4,4)
               )
p<-grid.arrange(p5, p6,p7,p8,layout_matrix =layout1)
print(p)
dev.off()

