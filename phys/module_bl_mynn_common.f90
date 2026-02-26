

 module module_bl_mynn_common

















  use module_gfs_machine,  only : kind_phys


  use module_model_constants, only:         &
    & karman, g, p1000mb,                   &
    & cp, r_d, r_v, rcp, xlv, xlf, xls,     &
    & svp1, svp2, svp3, p608, ep_2, rvovrd, &                                                                         
    & cpv, cliq, cice, svpt0

 implicit none
 save




























 real,parameter:: zero   = 0.0
 real,parameter:: half   = 0.5
 real,parameter:: one    = 1.0
 real,parameter:: two    = 2.0
 real,parameter:: onethird  = 1./3.
 real,parameter:: twothirds = 2./3.
 real,parameter:: tref  = 300.0   
 real,parameter:: TKmin = 253.0   




 real,parameter:: tice  = 240.0  
 real,parameter:: grav  = g
 real,parameter:: t0c   = svpt0        


 real,parameter:: ep_3   = 1.-ep_2 
 real,parameter:: gtr    = grav/tref
 real,parameter:: rk     = cp/r_d
 real,parameter:: tv0    =  p608*tref
 real,parameter:: tv1    = (1.+p608)*tref
 real,parameter:: xlscp  = (xlv+xlf)/cp
 real,parameter:: xlvcp  = xlv/cp
 real,parameter:: g_inv  = 1./grav













 end module module_bl_mynn_common
