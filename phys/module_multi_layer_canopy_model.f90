


  MODULE clm_varpar_my

  implicit none
  save

  
  integer, parameter :: NN       = 1000
  real :: S_CHATS(NN), sw_in_CHATS(NN), lw_in_CHATS(NN), &
          tsoil_CHATS(NN), qsoil_CHATS(NN), G_CHATS(NN),  Utop_CHATS(NN)
  CHARACTER(LEN=24) :: date_CHATS(NN)
  

  real :: sc_p(20)  
   
  real :: zmax = 2.22, vt(100)  

  integer, private :: i  
  integer, parameter :: mxlevcan_wrf = 100  
  integer, parameter :: nlevsoi      = 10   
  integer, parameter :: nlevgrnd     = 15   
  integer, parameter :: numrad       = 2    

  real, parameter :: mincoszen = 0.
  real, parameter :: smpmin = -1.e8     
  real, parameter :: grav   = 9.80616   
  real, parameter :: sb     = 5.67e-8   
  real, parameter :: vkc    = 0.4       
  real, parameter :: rgas   = 8314.468  
  real, parameter :: rwat   = 461.5046  
  real, parameter :: rair   = 287.0423  
  real, parameter :: roverg = 47062.73  
  real, parameter :: cpliq  = 4.188e3   
  real, parameter :: cpice  = 2.11727e3 
  real, parameter :: cpair  = 1.00464e3 
  real, parameter :: hvap   = 2.501e6   
  real, parameter :: hfus   = 3.337e5   
  real, parameter :: hsub   = 2.501e6+3.337e5 
  real, parameter :: denh2o = 1.000e3   
  real, parameter :: denice = 0.917e3   
  real, parameter :: tkair  = 0.023     
  real, parameter :: tkice  = 2.290     
  real, parameter :: tkwat  = 0.57      
  real, parameter :: tfrz   = 273.16    
  real, parameter :: tcrit  = 2.5       
  real, parameter :: po2    = 0.209     
  real, parameter :: pco2   = 355.e-06  
  real, parameter :: pstd   = 101325.0  
  real, parameter :: bdsno  = 250.      
  real, parameter :: e_ice  = 6.0       
  real, parameter :: watmin = 0.01      

  integer, parameter :: numpft = 16
  character(len=40) pftname(1:numpft)
  data (pftname(i),i=1,16)/ 'needleleaf_evergreen_temperate_tree',&
                            'needleleaf_evergreen_boreal_tree'   ,&
                            'needleleaf_deciduous_boreal_tree'   ,&
                            'broadleaf_evergreen_tropical_tree'  ,&
                            'broadleaf_evergreen_temperate_tree' ,&
                            'broadleaf_deciduous_tropical_tree'  ,&
                            'broadleaf_deciduous_temperate_tree' ,&
                            'broadleaf_deciduous_boreal_tree'    ,&
                            'broadleaf_evergreen_shrub'          ,&
                            'broadleaf_deciduous_temperate_shrub',&
                            'broadleaf_deciduous_boreal_shrub'   ,&
                            'c3_arctic_grass'                    ,&
                            'c3_non-arctic_grass'                ,&
                            'c4_grass'                           ,&
                            'corn'                               ,&
                            'wheat'/
  real dleaf(0:numpft)       
  real c3psn(0:numpft)       
  real vcmx25(0:numpft)      
  real mp(0:numpft)          
  real qe25(0:numpft)        
  real xl(0:numpft)          
  real rhol(0:numpft,numrad) 
  real rhos(0:numpft,numrad) 
  real taul(0:numpft,numrad) 
  real taus(0:numpft,numrad) 
  real emsv(0:numpft)        
  real roota_par(0:numpft)   
  real rootb_par(0:numpft)   
  real slatop(0:numpft)      
  real leafcn(0:numpft)      
  real flnr(0:numpft)        
  real smpso(0:numpft)       
  real smpsc(0:numpft)       
  real fnitr(0:numpft)       

  data (dleaf(i),i=1,16)/ 0.04, 0.04, 0.04, 0.04, 0.04,&
         0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04,&
         0.04, 0.04, 0.04/

  data (c3psn(i),i=1,16)/1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,&
        1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0/

  data (vcmx25(i),i=1,16)/51.0,43.0,43.0,75.0,69.0,40.0,&
       51.0,51.0,17.0,17.0,33.0,43.0,43.0,24.0,50.0,50.0/

  data (mp(i),i=1,16)/6.0,6.0,6.0,9.0,9.0,9.0,9.0,9.0,&
        9.0,9.0,9.0,9.0,9.0,5.0,9.0,9.0/

  data (qe25(i),i=1,16)/ 0.06, 0.06, 0.06, 0.06, 0.06,&
        0.06, 0.06, 0.06, 0.06, 0.06, 0.06, 0.06, 0.06,&
        0.04, 0.06, 0.06/

  data (rhol(i,1),i=1,16)/ 0.07, 0.07, 0.07, 0.10, 0.10,&
        0.10, 0.10, 0.10, 0.07, 0.10, 0.10, 0.11, 0.11,&
        0.11, 0.11, 0.11/

  data (rhol(i,2),i=1,16)/ 0.35, 0.35, 0.35, 0.45, 0.45,&
        0.45, 0.45, 0.45, 0.35, 0.45, 0.45, 0.58, 0.58, &
        0.58, 0.58, 0.58/

  data (rhos(i,1),i=1,16) /0.16, 0.16, 0.16, 0.16, 0.16,&
         0.16, 0.16, 0.16, 0.16, 0.16, 0.16, 0.36, 0.36,&
         0.36, 0.36, 0.36/

  data (rhos(i,2),i=1,16)/ 0.39, 0.39, 0.39, 0.39, 0.39,&
        0.39, 0.39, 0.39, 0.39, 0.39, 0.39, 0.58, 0.58, &
        0.58, 0.58, 0.58/

  data (taul(i,1),i=1,16)/ 0.05, 0.05, 0.05, 0.05, 0.05,&
        0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.07, 0.07,&
        0.07, 0.07, 0.07/

  data (taul(i,2),i=1,16)/ 0.10, 0.10, 0.10, 0.25, 0.25,&
        0.25, 0.25, 0.25, 0.10, 0.25, 0.25, 0.25, 0.25, &
        0.25, 0.25, 0.25/

  data (taus(i,1),i=1,16)/0.001, 0.001, 0.001, 0.001,&
       0.001,0.001, 0.001, 0.001, 0.001, 0.001, 0.001,&
       0.220, 0.220, 0.220, 0.220, 0.220/

  data (taus(i,2),i=1,16)/ 0.001, 0.001, 0.001, 0.001,&
       0.001, 0.001, 0.001, 0.001, 0.001, 0.001, &
       0.001, 0.380, 0.380, 0.380, 0.380, 0.380/

  data (emsv(i),i=1,16)/0.95,0.95,0.95,0.95,0.95, 0.95,&
       0.95, 0.95, 0.95, 0.95, 0.95,  0.95,  0.95,&
        0.95,  0.95,  0.95/

  data (xl(i),i=1,16)/0.01,0.01,0.01,0.10,0.10, 0.01,&
       0.25, 0.25, 0.01, 0.25, 0.25, -0.30, -0.30,&
       -0.30, -0.30, -0.30/

  data (roota_par(i),i=1,16)/ 7.0, 7.0, 7.0, 7.0,&
      7.0, 6.0, 6.0, 6.0, 7.0, 7.0, 7.0, 11.0, &
      11.0, 11.0,  6.0,  6.0/

  data (rootb_par(i),i=1,16)/ 2.0, 2.0, 2.0, &
     1.0, 1.0, 2.0, 2.0, 2.0, 1.5, 1.5, 1.5, &
     2.0, 2.0, 2.0, 3.0, 3.0/

  data (slatop(i),i=1,numpft)/0.010,0.008,0.024,0.012,0.012,0.030,&
        0.030,0.030,0.012,0.030,0.030,0.030,0.030,0.030,0.030,0.030/

  data (leafcn(i),i=1,numpft)/35,40,25,30,30,25,25,25,30,25,25,&
        25,25,25,25,25 /

  data (flnr(i),i=1,numpft)/0.05,0.04,0.08,0.06,0.06,0.09,0.09,0.09,&
       0.06,0.09,0.09,0.09,0.09,0.09,0.10,0.10 /

  data (smpso(i),i=1,numpft)/-66000,-66000,-66000,-66000,-66000,-35000,&
      -35000,-35000,-83000,-83000,-83000,-74000,-74000,-74000,-74000,-74000 /

  data (smpsc(i),i=1,numpft)/-255000,-255000,-255000,-255000,-255000,-224000,&
      -224000,-224000,-428000,-428000,-428000,-275000,-275000,-275000,-275000,-275000 /

  data(fnitr(i),i=1,numpft)/0.72,0.78,0.79,0.83,0.71,0.66,0.64,0.70,0.62,&
      0.60,0.76,0.68,0.61,0.64,0.61,0.61/

  
  integer, parameter :: mxsoil_color   =   20  
  real :: albsat(mxsoil_color,numrad) 
  real :: albdry(mxsoil_color,numrad) 

  data(albsat(i,1),i=1,20) /0.25,0.23,0.21,0.20,0.19,0.18,0.17,0.16,&
                     0.15,0.14,0.13,0.12,0.11,0.10,0.09,0.08,0.07,0.06,0.05,0.04/
  data(albsat(i,2),i=1,20) /0.50,0.46,0.42,0.40,0.38,0.36,0.34,0.32,&
                     0.30,0.28,0.26,0.24,0.22,0.20,0.18,0.16,0.14,0.12,0.10,0.08/
  data(albdry(i,1),i=1,20) /0.36,0.34,0.32,0.31,0.30,0.29,0.28,0.27,&
                     0.26,0.25,0.24,0.23,0.22,0.20,0.18,0.16,0.14,0.12,0.10,0.08/
  data(albdry(i,2),i=1,20) /0.61,0.57,0.53,0.51,0.49,0.48,0.45,0.43,&
                     0.41,0.39,0.37,0.35,0.33,0.31,0.29,0.27,0.25,0.23,0.21,0.16/
  
  




















  real :: sand(19)                           
  real :: clay(19)                           
  integer  :: soic(19)

  data(sand(i), i=1,19)/92.,80.,66.,20.,5.,43.,60.,&
    10.,32.,51., 6.,22.,39.7,0.,100.,54.,17.,100.,92./

  data(clay(i), i=1,19)/ 3., 5.,10.,15.,5.,18.,27.,&
    33.,33.,41.,47.,58.,14.7,0., 0., 8.5,54.,  0., 3./

  data(soic(i), i=1,19)/1,2,2,3,3,4,5,5,6,7,7,8,8,0,&
                          1,1,4,7,1/

  real :: organic(nlevgrnd)  
  
  data(organic(i),i=1,nlevgrnd)/15.36,15.12,13.22,10.80,8.31,6.09,4.37,3.12,&
                                0.00,0.00,0.00,0.00,0.00,0.00,0.00/

  END MODULE clm_varpar_my





  MODULE mcm_data_mod 

  USE clm_varpar_my, only : mxlevcan_wrf, nlevgrnd
  
  implicit none

  type mcm_force
      real :: dt                    
      real :: swd(2)                
      real :: swi(2)                
      real :: lwd                   
      real :: coszen                
      real :: surf_pre              

      real :: wind(1:mxlevcan_wrf)  
      real :: tair(1:mxlevcan_wrf)  
      real :: qair(1:mxlevcan_wrf)  
      real :: rho(1:mxlevcan_wrf)   
      real :: co2(1:mxlevcan_wrf)   
      real :: tsoil(1:nlevgrnd)     
      real :: qsoil(1:nlevgrnd)     
      real :: t10                   
      real :: dayl_factor           
      real :: us                    
      real :: Gsoil                 
  end type mcm_force

  
  type canopy_lai
      integer :: ipvt                
      integer :: bl                  
      integer :: nw                  
      real    :: h                   
      real    :: z(1:mxlevcan_wrf)   
      real    :: dz(1:mxlevcan_wrf)  
      real    :: lad(1:mxlevcan_wrf) 
      real    :: lad0(1:mxlevcan_wrf) 
      real    :: tlai                
      real    :: lai(1:mxlevcan_wrf) 
      real    :: sai(1:mxlevcan_wrf) 
      real    :: cd(1:mxlevcan_wrf)
      real    :: cd0  
  end type canopy_lai
  
  
  type Soil_property
      integer :: soilcol         
      integer :: ipts            
  
      real :: z(0:nlevgrnd)      
      real :: dz(0:nlevgrnd)     
      real :: zi(0:nlevgrnd)     
      real :: rootfr(nlevgrnd)
      real :: rootr(nlevgrnd)    
        
      real :: bsw(nlevgrnd)      
      real :: watsat(nlevgrnd)   
      real :: hksat(nlevgrnd)    
      real :: sucsat(nlevgrnd)   
      real :: csol(nlevgrnd)     
      real :: tkmg(nlevgrnd)     
      real :: tkdry(nlevgrnd)    
      real :: tksatu(nlevgrnd)   
  
      real :: cv (nlevgrnd)      
      real :: tk (nlevgrnd)      


      real :: zwt                
      real :: btran              
      real :: ems                
  end type Soil_property
  

  type (canopy_lai), save :: CLAI1
  type (mcm_force), save :: MF1
  type (Soil_property), save :: SP1

  type (mcm_force), allocatable, save :: MF(:,:)
  type (canopy_lai), allocatable, save :: CLAI(:,:)
  type (Soil_property), allocatable, save :: SP(:,:)

  END MODULE mcm_data_mod 




 MODULE module_multi_layer_canopy_model_func

  CONTAINS

  
  subroutine set_surface_temp(t, itimestep, dt, &
                              ids, ide, jds, jde,     &
                              ims, ime, jms, jme,     &
                              its, ite, jts, jte      )
  implicit none
  
  INTEGER, INTENT( IN )  :: ids, ide, jds, jde,  &
                            ims, ime, jms, jme,  &
                            its, ite, jts, jte 
  REAL,DIMENSION(ims:ime,jms:jme) :: t
  INTEGER :: itimestep
  REAL :: dt

  INTEGER :: i, j
 
  DO j = jts, min(jte,jde-1)
  DO i = its, min(ite,ide-1)
       t(i,j) = 265. - itimestep*dt/3600*0.25 -300.
  ENDDO
  ENDDO

  end subroutine set_surface_temp

  
  subroutine get_hgt( hgt, ibm_opt, HT, IBM_HT_M, &
                      ims, ime, jms, jme )
  implicit none
  INTEGER :: ims, ime, jms, jme
  REAL,DIMENSION(ims:ime,jms:jme) :: hgt, HT, IBM_HT_M
  integer :: ibm_opt

  if (ibm_opt == 0) then
      hgt = HT
  else
      hgt = IBM_HT_M
  endif
  end subroutine get_hgt

  
  subroutine get_hgt_twj( hgt, HT, ims, ime, jms, jme )




  implicit none
  INTEGER :: ims, ime, jms, jme
  REAL,DIMENSION(ims:ime,jms:jme) :: hgt, HT

  hgt = HT

  end subroutine get_hgt_twj

  
  subroutine read_obs_driving( OBS_interval, itimestep, dt, &
                               sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   
                               lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C )     

  USE clm_varpar_my, only : date_CHATS, S_CHATS, sw_in_CHATS, lw_in_CHATS, &
          tsoil_CHATS, qsoil_CHATS, G_CHATS, Utop_CHATS, date_CHATS, NN

  implicit none
  integer :: itimestep
  real :: OBS_interval, dt  
  real :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, coszen, lwd, &
          tsoil_C, qsoil_C, G_C, Utop_C

  LOGICAL, SAVE :: READ_DATA = .true.
  integer, save :: it_ct = 1
  integer :: io, it

  if (READ_DATA) then
      READ_DATA = .false.
      OPEN ( FILE = 'drive_force_for_LES.txt', UNIT = 234, STATUS = 'OLD', &
            ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ')
     
      read( 234, *, iostat = io)
      DO it = 1, NN
          read( 234, *, iostat = io) date_CHATS(it), S_CHATS(it), sw_in_CHATS(it), lw_in_CHATS(it), &
                                     tsoil_CHATS(it), qsoil_CHATS(it), G_CHATS(it), Utop_CHATS(it)
          if (io < 0) exit
      ENDDO     
      CLOSE(234)
  endif

  IF ( mod(itimestep, int(OBS_interval/dt) ) .EQ. 1) then

      tsoil_C = tsoil_CHATS(it_ct)
      qsoil_C = qsoil_CHATS(it_ct)
      G_C = G_CHATS(it_ct)
      Utop_C = Utop_CHATS(it_ct)

      lwd = lw_in_CHATS(it_ct)
      coszen = max(0.001, sin(S_CHATS(it_ct)))

      if ( coszen > 0.001 ) then
          call one_to_four_stream_sw_1( coszen, sw_in_CHATS(it_ct), &
                                  sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )  
      else
          sw_dir_vis = 0.
          sw_dir_nir = 0.
          sw_dif_vis = 0.
          sw_dif_nir = 0.
      endif
      it_ct = it_ct + 1
  ENDIF
  end subroutine read_obs_driving

  
  subroutine initiate_mcm_forest( SP, CLAI, MF, zi, nz, z0 )

  USE mcm_data_mod, only : Soil_property, canopy_lai, mcm_force
  USE clm_varpar_my, only : nlevgrnd, sc_p
  
  implicit none

  INTEGER, INTENT( IN )  :: nz
  REAL, DIMENSION(1:nz),INTENT(IN) :: zi
  real :: z0  

  TYPE(Soil_property), INTENT(OUT) :: SP
  TYPE(canopy_lai),    INTENT(OUT) :: CLAI
  TYPE(mcm_force),     INTENT(OUT) :: MF

  integer :: i
  real :: sum_lai, LAI

  write(*,*), 'TWJ z0 = ', z0

  
  if (zi(1) < 0.) then  
      CLAI%cd0 = 0.
  else
      CLAI%cd0 = (0.4/(log((zi(1)+z0)/z0)))**2.0
  endif
  

  CLAI%ipvt = 7  

  SP%ipts = 7 
  CLAI%sai(:) = 0.
  call lai_wrf_grid( CLAI%tlai, CLAI%lai, CLAI%lad, CLAI%h, CLAI%z, CLAI%dz, CLAI%bl, CLAI%nw, zi(1:nz), nz)

  sum_lai = 0.
  do i = 1, CLAI%nw
     sum_lai = sum_lai + CLAI%lai(i)
  enddo

  do i = 1, CLAI%nw
      CLAI%lai(i) = CLAI%LAI(I) * CLAI%tlai/sum_lai
      CLAI%lad(i) = CLAI%lad(I) * CLAI%tlai/sum_lai
  enddo
  CLAI%lad0 = CLAI%lad

  
  sum_lai = 0.
  do i = 1, CLAI%nw
     sum_lai = sum_lai + CLAI%lai(i)
  enddo
  write(*,*) 'lai', sum_lai
  

  
  MF%dt = -9999
  MF%t10 = -9999
  MF%dayl_factor = -9999
  MF%swd(:) = -9999.
  MF%swi(:) = -9999.
  MF%lwd = -9999.
  MF%coszen = -9999.
  MF%surf_pre = -9999.
  MF%wind(:) = -9999.
  MF%tair(:) = -9999.
  MF%qair(:) = -9999.
  MF%rho(:) = -9999.
  MF%co2(:) = -9999.
  MF%tsoil(:) = -9999.
  MF%qsoil(:) = -9999.

  end subroutine initiate_mcm_forest

  

  subroutine initiate_mcm_grass( CLAI, zi, nz, z0 )

  USE mcm_data_mod, only : Soil_property, canopy_lai, mcm_force
  USE clm_varpar_my, only : nlevgrnd, sc_p
  
  implicit none

  INTEGER, INTENT( IN )  :: nz
  REAL, DIMENSION(1:nz),INTENT(IN) :: zi
  real :: z0  

  TYPE(canopy_lai),    INTENT(OUT) :: CLAI

  
  if (zi(1) < 0.) then  
      CLAI%cd0 = 0.
  else
      CLAI%cd0 = (0.4/(log((zi(1)+z0)/z0)))**2.0
  endif
  

  CLAI%nw = 0

  end subroutine initiate_mcm_grass

  



  subroutine initial_soil_1d( SP, CLAI )
  
  use clm_varpar_my, only :  roota_par, rootb_par, sand, clay, organic, nlevsoi, nlevgrnd
  USE mcm_data_mod, only : Soil_property, canopy_lai
  implicit none

  TYPE(Soil_property), INTENT(INOUT) :: SP
  TYPE(canopy_lai),    INTENT(IN)    :: CLAI









    












  
  real :: scalez       = 0.025 
  real :: om_watsat    = 0.9   
  real :: om_hksat     = 0.1   
  real :: om_tkm       = 0.25  
  real :: om_sucsat    = 10.3  
  real :: om_csol      = 2.5   
  real :: om_tkd       = 0.05  
  real :: om_b         = 2.7   
  real :: organic_max  = 130.  
  real :: csol_bedrock = 2.0e6 
  real :: pc           = 0.5   
  real :: pcbeta       = 0.139 
  real :: zsapric      = 0.5   

  real :: perc_frac            
  real :: perc_norm            
  real :: uncon_hksat          
  real :: uncon_frac           
  real :: bd                   
  real :: tkm                  
  real :: xksat                
  real :: om_frac
  real :: rootfr_sum

  real :: om_watsat1,  om_b1, om_sucsat1, om_hksat1

  integer :: j


  integer :: ivt, its

  ivt = CLAI%ipvt
  its = SP%ipts

  SP%z(0) = 0.
  do j = 1, nlevgrnd
      SP%z(j) = scalez*(exp(0.5*(j - 0.5)) - 1.)    
  enddo


  SP%dz(1) = 0.5*(SP%z(1) + SP%z(2))             
  do j = 2,nlevgrnd-1
      SP%dz(j) = 0.5*(SP%z(j+1) - SP%z(j-1))
  enddo
  SP%dz(nlevgrnd) = SP%z(nlevgrnd) - SP%z(nlevgrnd-1)

  SP%zi(0) = 0.
  do j = 1, nlevgrnd-1
      SP%zi(j) = 0.5*(SP%z(j) + SP%z(j+1))       
  enddo
  SP%zi(nlevgrnd) = SP%z(nlevgrnd) + 0.5*SP%dz(nlevgrnd)

  
  rootfr_sum = 0.
  do j = 1, nlevsoi-1
     SP%rootfr(j) = 0.5*( exp(-roota_par(ivt) * SP%zi(j-1))  &
                        + exp(-rootb_par(ivt) * SP%zi(j-1))  &
                        - exp(-roota_par(ivt) * SP%zi(j  ))  &
                        - exp(-rootb_par(ivt) * SP%zi(j  )) )
     
     
     
     
     
     
     
     rootfr_sum = rootfr_sum + SP%rootfr(j)
  enddo
  SP%rootfr(nlevsoi) = 0.5*( exp(-roota_par(ivt) * SP%zi(nlevsoi-1))  &
                           + exp(-rootb_par(ivt) * SP%zi(nlevsoi-1)) )
  SP%rootfr(nlevsoi+1:nlevgrnd) = 0.

  do j = 1, nlevsoi
     SP%rootfr(j) = SP%rootfr(j) / rootfr_sum
  enddo

  
  do j = 1, nlevgrnd
      if (j <= nlevsoi) then
          om_frac = (organic(j)/organic_max)
      else
          om_frac = 0.
      endif

      om_watsat1  = max(0.93 - 0.1*(SP%z(j)/zsapric), 0.83)
      om_b1       = min(2.7 + 9.3*(SP%z(j)/zsapric), 12.0)
      om_sucsat1  = min(10.3 - 0.2*(SP%z(j)/zsapric), 10.1)
      om_hksat1   = max(0.28 - 0.2799*(SP%z(j)/zsapric), 0.0001)

      SP%bsw(j)    = (1. - om_frac)*(2.91 + 0.159*clay(its)) + om_frac*om_b1
      SP%sucsat(j) = (1. - om_frac)*(10.*(10.**(1.88 - 0.0131*sand(its))))+ om_frac*om_sucsat1
      SP%watsat(j) = (1. - om_frac)*(0.489 - 0.00126*sand(its)) + om_frac*om_watsat1

      
      if (om_frac > pc) then
          perc_norm = (1. - pc)**(-pcbeta)
          perc_frac = perc_norm*(om_frac - pc)**pcbeta
      else
          perc_frac = 0.
      endif
      
      uncon_frac = (1. - om_frac) + (1. - perc_frac)*om_frac
      xksat      = 0.0070556 * ( 10.**(-0.884 + 0.0153*sand(its)) ) 
      
      if (om_frac < 1.) then
          uncon_hksat = uncon_frac/( (1. - om_frac)/xksat + (1. - perc_frac)*om_frac/om_hksat )
      else
          uncon_hksat = 0.
      endif
      SP%hksat(j)  = uncon_frac*uncon_hksat + perc_frac*om_frac*om_hksat

      tkm       = (1. - om_frac)*(8.80*sand(its) + 2.92*clay(its))/(sand(its) + clay(its)) &
                  + om_tkm*om_frac   
      SP%tkmg(j)   = tkm**(1. -  SP%watsat(j))

      SP%tksatu(j) = SP%tkmg(j)*0.57**SP%watsat(j)

      bd        = (1. - (0.489 - 0.00126*sand(its)))*2.7e3
      SP%tkdry(j)  = (0.135*bd + 64.7)/(2.7e3 - 0.947*bd)*(1. - om_frac) + om_tkd*om_frac

      SP%csol(j)   = 1.e6 * ( (1. - om_frac)*(2.128*sand(its) + 2.385*clay(its)) &
                           /(sand(its) + clay(its)) + om_csol*om_frac )  
      if (j > nlevsoi) then
          SP%csol(j) = csol_bedrock
      endif

      
      
      
      
      
      

      
      SP%ems = 0.97 

  enddo

  end subroutine initial_soil_1d


  subroutine read_lai( nlevel, lad, lad_ht, cht, lai )
  implicit none
  integer, intent(out) :: nlevel
  real, dimension(1:200), intent(out) :: lad, lad_ht
  real, intent(out) :: cht, lai

  integer :: i, io
  OPEN ( FILE = 'lai.txt', UNIT = 123, STATUS = 'OLD', &
        ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ' )

  read( 123, *, iostat = io ) cht, lai
  i = 1
  do while( .TRUE. )    
     read( 123, *, iostat = io ) lad(i), lad_ht(i)
     if (io < 0) exit
     i = i + 1
  enddo
  nlevel = i - 1 
  close(123)

  end subroutine read_lai



  subroutine IBM_Concentration_BDY(S, S1, IBM_FS_M, S_bdy, &
                                   itimestep,  &
                                   ids,ide, jds,jde, kds,kde, &
                                   ims,ime, jms,jme, kms,kme, &
                                   its,ite, jts,jte, kts,kte )

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte
  
  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: S, S1
  INTEGER, DIMENSION(ims:ime, kms:kme, jms:jme) :: IBM_FS_M
  INTEGER :: itimestep
  real :: S_bdy
  integer :: i,j,k


  if (itimestep < 5*60*50) return

  DO j = jts, min(jte,jde-1)
  DO k = kts, kte-1
  DO i = its, min(ite,ide-1)
      IF (IBM_FS_M(i,k,j) == 1) THEN
          if (i<=300) S(i,k,j) = S_bdy
          if (i<=300) S(i,k+1,j) = S_bdy
          if (i>300) S1(i,k,j) = S_bdy
          if (i>300) S1(i,k+1,j) = S_bdy
      ENDIF
  ENDDO
  ENDDO
  ENDDO
  end subroutine IBM_Concentration_BDY
 


  subroutine random_trig(U, &
                         ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte )

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte
  
  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: u
  integer :: i,j,k
  real, dimension(kte) :: rand

  CALL random_seed()         
  CALL RANDOM_NUMBER(rand)

  DO j = jts, min(jte,jde-1)
  DO k = 3, 30
  DO i = its, ite
      if (j == jde/2 .and. mod(i,10) == 0 ) then
          U(i,k,j) = U(i,k,j) +  rand(k)*0.3*(35.-k)/30.
      endif
  ENDDO
  ENDDO
  ENDDO

  end subroutine random_trig
 



  subroutine random_lai(CLAI)
  USE mcm_data_mod, only : canopy_lai
  implicit none
  
  TYPE(canopy_lai),    INTENT(OUT) :: CLAI
  integer :: i, nw
  real, allocatable, dimension(:) :: rand

  nw = CLAI%nw
  allocate(rand(nw))

  CALL random_seed()         
  CALL RANDOM_NUMBER(rand)

  

  
  
  
  CLAI%cd = 0.25
  CLAI%cd(1) = 0.05
  CLAI%cd(2) = 0.08
  CLAI%cd(3) = 0.1
  CLAI%cd(4) = 0.15
  CLAI%cd(5) = 0.2

  CLAI%cd(nw) = 0.05
  CLAI%cd(nw-1) = 0.05
  CLAI%cd(nw-2) = 0.1


  end subroutine random_lai
 


  subroutine lai_wrf_grid( tlai, lai_z, lad_z, h, z, dz, bl, numcan_wrf, zi, nz )

  use clm_varpar_my, only : mxlevcan_wrf 
  implicit none

  integer :: nz
  real, dimension(1:nz), intent(in) :: zi  

  real, dimension(1:mxlevcan_wrf), intent(out) :: lai_z, lad_z, z, dz
  real :: h, tlai
  integer, intent(out) :: bl               
  integer, intent(out) :: numcan_wrf       

  
  integer :: nlevel   
  real :: cht         
  real :: lad(200), lad_ht(200) 
  real :: lh(200)
  real, dimension(1:mxlevcan_wrf) :: lai_z_tmp, lad_z_tmp, z_tmp, dz_tmp
  integer :: k, ir, tl
 
  call read_lai( nlevel, lad, lad_ht, cht, tlai )
  lh = lad_ht*cht
  h = cht  

  if ( zi(nz) < cht ) then
      write(*,*) 'Input layers height are wrong!', nz, zi(nz), cht 
      STOP
  endif

  
  k = 1
  do while ( k < nz )
      if ( zi(k) > 0. ) then
          bl = k  
          exit
      endif
      k = k + 1
  enddo

  
  do k = bl, nz
      if ( zi(k) <= cht ) then
          call to_zk2( zi(k), lh(1:nlevel), lad(1:nlevel), nlevel, lad_z_tmp(k) )
          z_tmp(k) = zi(k)
          tl = k  
      else
          exit
      endif 
  enddo

  
  dz_tmp(bl) = zi(bl) + 0.5*( zi(bl+1) - zi(bl) )
  dz_tmp(tl) = cht - zi(tl) + 0.5*( zi(tl) - zi(tl-1) )
  do k = bl+1, tl-1
      dz_tmp(k) = 0.5* ( zi(k+1) - zi(k) ) + 0.5*( zi(k) - zi(k-1) )   
  enddo

  do k = bl, tl
      lai_z_tmp(k) = lad_z_tmp(k) * dz_tmp(k)
  enddo

  
  numcan_wrf = tl - bl + 1
  do ir = 1, numcan_wrf
      k = numcan_wrf - ir + bl  
      lai_z(ir) = lai_z_tmp(k)
      lad_z(ir) = lad_z_tmp(k)
      z(ir)  = z_tmp(k)
      dz(ir) = dz_tmp(k)
  enddo
 
  end subroutine lai_wrf_grid
 

  subroutine simple_mcm_heat_profile( sh_out, C, rho, Qtop, WRF_var, kms, kme)

  USE clm_varpar_my, only : mxlevcan_wrf, cpair
  USE mcm_data_mod,  only : canopy_lai

  implicit none

  real, INTENT(INOUT) :: sh_out(mxlevcan_wrf)  
  real :: rho(mxlevcan_wrf), Qtop

  TYPE(canopy_lai),    INTENT(IN)    :: C

  INTEGER :: kms, kme
  REAL, DIMENSION(kms:kme), INTENT(OUT) :: WRF_var

  real, dimension(1:200) :: lh, zoh, sh
  real :: zi, tsh, tsh1
  integer :: k, i, io, nlev, nw, bl, tl, ir

  nw = C%nw
  bl = C%bl

  OPEN ( FILE = 'heat.txt', UNIT = 123, STATUS = 'OLD', &
        ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ' )

  i = 1
  do while( .TRUE. )    
     read( 123, *, iostat = io ) sh(i), zoh(i)  
     if (io < 0) exit
     i = i + 1
  enddo
  nlev = i - 1 
  close(123)





  lh = zoh*C%h

  tsh = 0.
  do k = 1, nw
      zi = C%z(k)
      call to_zk2( zi, lh(1:nlev), sh(1:nlev), nlev, sh_out(k) )
      tsh = tsh + sh_out(k)
  enddo
  
  do k = 1, nw
      sh_out(k) = sh_out(k) * Qtop/tsh     
  enddo

  
  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  
      WRF_var(k) = sh_out(ir)
  ENDDO
  
  
  DO k = 1, nw
      sh_out(k) = sh_out(k)*cpair*rho(k)  
  ENDDO

  end subroutine simple_mcm_heat_profile


  subroutine simple_mcm( qv_mcm, sh_mcm, an_mcm, &
                         C, rho)

  USE clm_varpar_my, only : mxlevcan_wrf, cpair
  USE mcm_data_mod,  only : canopy_lai
  IMPLICIT NONE

  TYPE(canopy_lai),    INTENT(IN)    :: C

  real, intent(inout) :: qv_mcm(mxlevcan_wrf)  
  real, intent(inout) :: sh_mcm(mxlevcan_wrf)  
  real, intent(inout) :: an_mcm(mxlevcan_wrf)  
  real :: rho(mxlevcan_wrf)

  real :: Qtop  
  integer :: nw, iv, bl, tl, k, ir
  real :: tlai1, tlai2, tsh

  
  
  Qtop = 0.0

  qv_mcm(:) = 0.
  sh_mcm(:) = 0.
  an_mcm(:) = 0.

  nw = C%nw
  bl = C%bl

  
  

  
  if (nw == 0) then
     
     sh_mcm(1) = Qtop
     
     sh_mcm(1) = sh_mcm(1)  
     
  endif

  if (nw > 0) then
      tlai1 = 0.
      do iv = 1, nw
          tlai2 = tlai1 + C%lai(iv)
          
          sh_mcm(iv) = Qtop * (exp(-0.6*tlai1) - exp(-0.6*tlai2))
          tlai1 = tlai2
      enddo

      
      

      tsh = 0.
      do iv = 1, nw
          tsh = tsh + sh_mcm(iv)
      enddo

      do k = 1, nw
          sh_mcm(k) = sh_mcm(k) * Qtop/tsh
      enddo

      DO iv = 1, nw
          sh_mcm(iv) = sh_mcm(iv)*cpair*rho(iv)  
      ENDDO
  endif

  end subroutine simple_mcm



 SUBROUTINE multi_layer_canopy( qv_out, sh_out, an_out, LEg, SHg, C, S, M,    &
                                sw_can_z, lw_can_z, efsh_z, efe_z )
                                
                                
                                
                                
                                
                                
                                

  USE clm_varpar_my, only : nlevgrnd, mxlevcan_wrf, numrad, hvap, cpair
  USE mcm_data_mod,  only : mcm_force, canopy_lai, Soil_property
  IMPLICIT NONE
 
  TYPE(canopy_lai),    INTENT(IN)    :: C
  TYPE(Soil_property), INTENT(INOUT) :: S  
  TYPE(mcm_force),     INTENT(INOUT) :: M  

  REAL, DIMENSION(mxlevcan_wrf), INTENT(INOUT) :: sw_can_z, &
                                                  lw_can_z, &
                                                  efe_z,    &
                                                  efsh_z

  
  real, INTENT(INOUT) :: qv_out(mxlevcan_wrf)  
  real, INTENT(INOUT) :: sh_out(mxlevcan_wrf)  
  real, INTENT(INOUT) :: an_out(mxlevcan_wrf)  
  real, INTENT(OUT) :: LEg, SHg

 
  real :: ag_out(mxlevcan_wrf)  
  real :: parsun_z_1(mxlevcan_wrf)
  real :: parsha_z_1(mxlevcan_wrf)




  real :: fn_z(mxlevcan_wrf)        
  real :: sw_grnd                   
  real :: lw_grnd                   
  real :: eflx_sh_grnd              
  real :: qflx_ev_grnd              
  real :: sw_out

  real :: t_source(mxlevcan_wrf)

  real :: tveg_z(mxlevcan_wrf)      
  real, save :: tveg_z_save(mxlevcan_wrf) = -999.     

  real :: rb_z(mxlevcan_wrf)        
  real :: rah                       
  real :: rsoil                     

  real :: an_sun_z(mxlevcan_wrf)          
  real :: an_sha_z(mxlevcan_wrf)          

  real :: parsun_z(numrad,mxlevcan_wrf)   
  real :: parsha_z(numrad,mxlevcan_wrf)   
  real :: fsun_z(mxlevcan_wrf)            

  real :: rs_sun_z(mxlevcan_wrf)          
  real :: rs_sha_z(mxlevcan_wrf)          
  real :: gs_sun_z(mxlevcan_wrf)          
  real :: gs_sha_z(mxlevcan_wrf)          

  real :: psncan_ac, psncan_aj

  real :: ci_sun_z(mxlevcan_wrf)          
  real :: ci_sha_z(mxlevcan_wrf)          
  real :: ac_sun_z(mxlevcan_wrf)          
  real :: ac_sha_z(mxlevcan_wrf)          
  real :: aj_sun_z(mxlevcan_wrf)          
  real :: aj_sha_z(mxlevcan_wrf)          
  real :: ap_sun_z(mxlevcan_wrf)          
  real :: ap_sha_z(mxlevcan_wrf)          
  real :: ag_sun_z(mxlevcan_wrf)          
  real :: ag_sha_z(mxlevcan_wrf)          
  real :: lmr_z(mxlevcan_wrf)          

  real :: qflx_tran_veg                   

  real :: cgrnd   
  real :: psncan, gscan, lw_out
  real :: btran_z(nlevgrnd)
  real :: topo_slope = 0.
  real :: t_grnd, Utop, Ttop, Qtop, An_soil

  INTEGER ::  k, iv, iter, nw

  qv_out = 0.
  sh_out = 0.
  an_out = 0.

  nw = C%nw
  IF (nw == 0) RETURN   

  Utop = M%wind(99)
  Ttop = M%tair(1)
  Qtop = M%qair(1)



  call boundary_layer_resistance_rb( rb_z, M%wind, nw, C%ipvt )
  


  S%soilcol = 10
  call SurfaceRadiation( M%swd, M%swi, M%coszen, M%qsoil(1),   &
                         C%lai, C%sai, nw, C%ipvt, S%soilcol,  &
                         parsun_z, parsha_z, fsun_z, sw_can_z, sw_grnd, sw_out )
  parsun_z_1 = parsun_z(1,:)
  parsha_z_1 = parsha_z(1,:)

  call Soil_Transpiration_Wetness_Factor( S%btran, S%rootr, btran_z,           &
                                          C%ipvt, S%dz, S%rootfr,     &
                                          S%sucsat, S%bsw, S%watsat,  &
                                          M%qsoil, M%tsoil )
  S%btran = 1.0

  
  

  tveg_z = M%tair  
  t_grnd = M%tsoil(1)
  do iter = 1, 3
      
      call Lw_Canopy( C%ipvt, M%lwd, tveg_z, M%tair, t_grnd, S%ems, &
                      C%lai, C%sai, nw, lw_can_z, lw_grnd, lw_out )

      
      
      
      
      
      
      
      




      call Photosynthesis_new( gs_sun_z, gs_sha_z, an_sun_z, an_sha_z, &
                               ag_sun_z, ag_sha_z, &
                               M%surf_pre, M%tair, M%qair, M%co2, &
                               tveg_z, tveg_z, fsun_z, C%lai, rb_z, &
                               parsun_z(1,:), parsha_z(1,:), nw ) 

      qflx_tran_veg = 0.  
      do iv = 1, nw
         

          call en_brent( fn_z(iv), tveg_z(iv), iv, efe_z(iv), efsh_z(iv), t_source(iv),  &
                         S%btran, M%tair(iv), M%qair(iv), M%rho(iv), M%surf_pre, &
                         rb_z(iv), 1./gs_sun_z(iv), 1./gs_sha_z(iv), fsun_z(iv),       &
                         
                         C%lai(iv), C%sai(iv), sw_can_z(iv), lw_can_z(iv), tveg_z_save(iv) )

          efe_z(iv) = efe_z(iv)*C%lai(iv)
          efsh_z(iv) = efsh_z(iv)*C%lai(iv)

          

          
          qflx_tran_veg = qflx_tran_veg - efe_z(iv)/(hvap)
      enddo

      call Surface_energy_balance_new( SHg, LEg, t_grnd, rsoil, M%surf_pre, &
                                       sw_grnd + lw_grnd, M%Gsoil, M%tair(nw), &
                                       M%qair(nw), M%qsoil(1), M%tsoil(1), Utop,  sw_grnd )






  enddo
  tveg_z_save = tveg_z
  
  
  do iv = 1, nw
      lw_can_z(iv) = lw_can_z(iv)*C%lai(iv)
      sw_can_z(iv) = sw_can_z(iv)*C%lai(iv)
  enddo
  

  

  
  

  
  
  

  
  
  
  
  
  
  
  
  

  
  
  
  







An_soil = 5.5



  DO iv = 1, nw 
      qv_out(iv) = -efe_z(iv)/hvap  
      sh_out(iv) = -efsh_z(iv)      
      an_out(iv) = -an_sun_z(iv) - an_sha_z(iv) 
      ag_out(iv) = -ag_sun_z(iv) - ag_sha_z(iv) 
      
      
      
  ENDDO
  
  
  qv_out(nw) = qv_out(nw) + LEg/hvap
  sh_out(nw) = sh_out(nw) + SHg
  
  an_out(nw) = an_out(nw) + An_soil
  
  

 
  
  

  gscan = 0.
  DO iv = 1, nw 
      
      gscan = gscan + fsun_z(iv)*(gs_sun_z(iv)) + (1.-fsun_z(iv))*(gs_sha_z(iv))
  ENDDO
  gscan = gscan/nw



 end SUBROUTINE multi_layer_canopy




  subroutine to_zk2(obs_v, mdl_v, mdl_data, iz, interp_out )
  
  implicit none
  
  integer :: k, iz, k1
  real, intent(in) :: obs_v
  real, dimension(1:iz), intent(in) :: mdl_v, mdl_data
  real, intent(out) :: interp_out
  real :: dz, dzm, zk
  
  if (obs_v < mdl_v(1) ) then
      interp_out = mdl_data(1)
      return
  else if (obs_v >= mdl_v(iz)) then
      interp_out = mdl_data(iz)
      return
  else
      do k = 1,iz-1
          if(obs_v >= mdl_v(k) .and. obs_v < mdl_v(k+1)) then
              zk = real(k) + (obs_v - mdl_v(k))/(mdl_v(k+1) - mdl_v(k))
              exit
          endif
      enddo
      k1 = int( zk )
      dz = zk - float( k1 )
      dzm = float( k1+1 ) - zk
  
      interp_out = dzm*mdl_data(k1) + dz*mdl_data(k1+1)
      return
  endif
  
  end subroutine to_zk2
 


  subroutine energy_func( fout, tv, efe, efsh, ts, tv_save, &
                          btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, &
                          fsun, tlai, tsai, sw_can , lw_can, hvap, cpair )
  USE clm_varpar_my, only :  sc_p
  implicit none
  real, intent(in) :: tv, tair, qair, rho, rb, rs_sun, rs_sha, fsun, tlai, tsai, &
                      hvap, cpair, sw_can , lw_can, pbot, btran, tv_save

  real, intent(out) :: fout, efe, efsh
  
  real :: efe_tmp, dummy, qsat_tv, cpm_eff, efsh_veg, tv_sv, dT, ts
  real :: efsh_tmp
  real :: q1, tmp1, tmp2, tmp3, qair1
  
  
            

  
  efsh = 2.* rho * cpair * (1. + 0.8 *qair) * ( tair - tv ) /rb

  
  efsh_veg = 1.3*efsh
  
  

  
  call Qsat(tv, pbot, tmp1, tmp2, qsat_tv, tmp3)
  
  efe_tmp = (qsat_tv - qair) * ( fsun/(rb+rs_sun) + (1.-fsun)/(rb+rs_sha) )

  if (qsat_tv - qair < 0. ) efe_tmp = 0.

  efe = -hvap*rho*efe_tmp
  
  fout = sw_can + lw_can + efsh + efe + efsh_veg










  end subroutine energy_func



  subroutine en_brent( fb, tv, iv, efe, efsh, ts, &
                       btran, tair, qair, rho, pbot, &
                       rb, rs_sun, rs_sha, fsun, tlai, tsai,     &
                       sw_can , lw_can, tv_save )






  USE clm_varpar_my, only :  hvap, cpair
  implicit none
  real, intent(out) :: tv, fb, efe ,efsh, ts
  integer, intent(in) :: iv  

  real, intent(in) :: btran, tair, qair, rho, rb, rs_sun, rs_sha, fsun, tlai, tsai, &
                      sw_can , lw_can, pbot, tv_save

  
  real :: x1, x2, f1, f2  
  
  integer, parameter :: ITMAX = 40            
  real, parameter :: EPS = 1.e-4       

  integer :: iter, i
  real :: a,b,c,d,e,fa,fc,p,q,r,s,tol1,xm
  real :: x_tmp, x_save, f_tmp, f_save

  
  x1 = tair - 1.0
  x2 = tair + 1.0
  call energy_func( f1, x1, efe, efsh, ts, tv_save, &
                    btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, fsun, tlai, tsai, &
                    sw_can, lw_can, hvap, cpair)

  call energy_func( f2, x2, efe, efsh, ts, tv_save, &
                    btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, fsun, tlai, tsai, &
                    sw_can, lw_can, hvap, cpair)
  a = x1
  b = x2
  fa = f1
  fb = f2
  c = b
  fc = fb

  if((fa > 0. .and. fb > 0.).or.(fa < 0. .and. fb < 0.))then

      
      
      
      
      
      
      
      
      
      
      
      

      
      

      tv = tair+1.
      call energy_func( f_tmp, tv, efe, efsh, ts, tv_save, &
                        btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, fsun, &
                        tlai, tsai, sw_can, lw_can, hvap, cpair )

      write(*,*) 'Warning! energy unbalance on leaf layer, t_veg, fn:', tv, f_tmp 
      return
  endif


  iter = 0
  do
      if(iter == ITMAX) exit

      iter = iter+1
      if((fb > 0. .and. fc > 0.) .or. (fb < 0. .and. fc < 0.))then
          c = a   
          fc = fa
          d = b-a
          e = d
      endif
      if( abs(fc) < abs(fb)) then
          a = b
          b = c
          c = a
          fa = fb
          fb = fc
          fc = fa
      endif
      tol1 = 2.*EPS*abs(b)  
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          tv=b
          call energy_func( fb, b, efe, efsh, ts, tv_save, &
                            btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, &
                            fsun, tlai, tsai, sw_can , lw_can, hvap, cpair)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa 
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q 
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d 
              d = p/q
          else
              d = xm  
              e = d
          endif
      else 
          d = xm
          e = d
      endif

      a = b 
      fa = fb
      if(abs(d) > tol1) then 
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif
          call energy_func( fb, b, efe, efsh, ts, tv_save, & 
                            btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, &
                            fsun, tlai, tsai, sw_can , lw_can, hvap, cpair)
      if( fb == 0.) exit
  enddo



  tv = b
  return

  end subroutine en_brent



  subroutine clm_multi_layer_lai( tlai_z_wrf, tsai_z_wrf, numcan_wrf, dincmax,        &
                                  tlai, tsai, tlai_z, tsai_z, laisum, mxlevcan, nrad, &
                                  laisum_wrf )

  
  
  
  
  
  

  USE clm_varpar_my, only :  mxlevcan_wrf
  implicit none

  INTEGER, INTENT(IN) :: numcan_wrf
  INTEGER, INTENT(IN) :: mxlevcan
  REAL,    INTENT(IN) :: tlai_z_wrf(1:mxlevcan_wrf)      
  REAL,    INTENT(IN) :: tsai_z_wrf(1:mxlevcan_wrf)      
  REAL,    INTENT(INOUT) :: dincmax                         

  REAL, INTENT(OUT) :: tlai              
  REAL, INTENT(OUT) :: tsai              
  REAL, INTENT(OUT) :: tlai_z(mxlevcan)  
  REAL, INTENT(OUT) :: tsai_z(mxlevcan)  
  REAL, INTENT(OUT) :: laisum(mxlevcan)  
  REAL, INTENT(OUT) :: laisum_wrf(1:mxlevcan_wrf)
  INTEGER, INTENT(OUT) :: nrad           

  
  real :: dinc              
  real :: dincmax_sum       
  real, parameter:: mpe = 1.0e-6  
  integer :: iv

  tlai = 0.
  tsai = 0.
  DO iv = 1, numcan_wrf
      tlai = tlai + tlai_z_wrf(iv) 
      tsai = tsai + tsai_z_wrf(iv) 
      IF (iv == 1) THEN
          laisum_wrf(iv) = 0.5*(tlai_z_wrf(iv) + tsai_z_wrf(iv))
      ELSE
          laisum_wrf(iv) = laisum_wrf(iv-1) + &
                           0.5*( (tlai_z_wrf(iv-1) + tsai_z_wrf(iv-1)) + &
                                 (tlai_z_wrf(iv) + tsai_z_wrf(iv)) )
      ENDIF
  ENDDO
  

  

  
  IF ( tlai + tsai < 10.*dincmax ) dincmax = (tlai + tsai)/10.

  dincmax_sum = 0.
  DO iv = 1, mxlevcan
      dincmax_sum = dincmax_sum + dincmax
      IF ( ( (tlai+tsai)-dincmax_sum ) > 1.e-06) THEN
          nrad = iv
          dinc = dincmax
          tlai_z(iv) = dinc * tlai / max(tlai+tsai, mpe)
          tsai_z(iv) = dinc * tsai / max(tlai+tsai, mpe)
      ELSE
          nrad = iv
          dinc = dincmax - (dincmax_sum - (tlai+tsai))
          tlai_z(iv) = dinc * tlai / max(tlai+tsai, mpe)
          tsai_z(iv) = dinc * tsai / max(tlai+tsai, mpe)
          EXIT
      ENDIF
  ENDDO

  DO iv = 1, nrad
      IF (iv == 1) THEN
         laisum(iv) = 0.5 * (tlai_z(iv)+tsai_z(iv))
      ELSE
         laisum(iv) = laisum(iv-1) + &
                      0.5*( (tlai_z(iv-1) + tsai_z(iv-1)) + &
                            (tlai_z(iv) + tsai_z(iv)) )
      ENDIF
  ENDDO

  end subroutine clm_multi_layer_lai



  subroutine SurfaceRadiation( forc_solad, forc_solai, coszen, h2osoi_vol_surf,     &
                               tlai_z_wrf, tsai_z_wrf, numcan_wrf, ivt, soilcol,    &
                               parsun_z_wrf, parsha_z_wrf, fsun_z_wrf, sw_can_z, sabg, sw_out )



  USE clm_varpar_my, only : numrad, rhol, rhos, taul, taus, xl, mxlevcan_wrf, mincoszen

  IMPLICIT NONE

  
  REAL, INTENT(IN) :: forc_solad(numrad)        
  REAL, INTENT(IN) :: forc_solai(numrad)        
  REAL, INTENT(IN) :: coszen                    
  REAL, INTENT(IN) :: h2osoi_vol_surf           
  INTEGER, INTENT(IN)  :: numcan_wrf            
  REAL, INTENT(IN) :: tlai_z_wrf(1:mxlevcan_wrf)  
  REAL, INTENT(IN) :: tsai_z_wrf(1:mxlevcan_wrf)  
  INTEGER, INTENT(IN)  :: ivt                   
  INTEGER, INTENT(IN)  :: soilcol               

  
  REAL, INTENT(OUT) :: parsun_z_wrf(numrad,1:mxlevcan_wrf) 
  REAL, INTENT(OUT) :: parsha_z_wrf(numrad,1:mxlevcan_wrf) 
  REAL, INTENT(OUT) :: fsun_z_wrf(1:mxlevcan_wrf)          
  REAL, INTENT(OUT) :: sw_can_z(1:mxlevcan_wrf)            
  REAL, INTENT(OUT) :: sabg                              
  REAL, INTENT(OUT) :: sw_out                              
  
  
  
  
  
  
  

  
  
  real :: trd(numrad) 
  real :: tri(numrad) 
  real :: cad(numrad) 
  real :: cai(numrad) 
  real :: sabv        

  real :: albsod(numrad)    
  real :: albsoi(numrad)    
  

  integer :: nrad   

  real :: tlai      
  real :: tsai      
  real :: elai      
  real :: esai      

  integer, parameter :: mxlevcan = 1000

  real :: tlai_z(mxlevcan)      
  real :: tsai_z(mxlevcan)      

  real :: laisum_wrf(1:numcan_wrf)
  real :: laisum_clm(mxlevcan)  

  real :: laisun_z(mxlevcan)    
  real :: laisha_z(mxlevcan)    
  real :: laisun                
  real :: laisha                
  real :: parsun_z(numrad,mxlevcan)    
  real :: parsha_z(numrad,mxlevcan)    

  integer, parameter :: nband = numrad    
  real :: fabd(numrad)        
  real :: fabi(numrad)        
  real :: ftdd(numrad)        
  real :: ftid(numrad)        
  real :: ftii(numrad)        
  real :: fabd_sun_z(numrad,mxlevcan) 
  real :: fabd_sha_z(numrad,mxlevcan) 
  real :: fabi_sun_z(numrad,mxlevcan) 
  real :: fabi_sha_z(numrad,mxlevcan) 
  real :: fsun_z(mxlevcan)     

  real,  parameter:: mpe = 1.0e-6  
  real :: wl                       
  real :: ws                       
  real :: rho(numrad)              
  real :: tau(numrad)              

  real :: dincmax                  

  INTEGER :: iv, ib, kk
  real :: tmp, dz1 ,dz2

  parsun_z_wrf = 0.
  parsha_z_wrf = 0.
  fsun_z_wrf = 0.
  sw_can_z = 0.
  sabg = 0.

  if (coszen < mincoszen ) return
     
  
  dincmax = 0.02
  call clm_multi_layer_lai( tlai_z_wrf, tsai_z_wrf, numcan_wrf, dincmax,            &
                            tlai, tsai, tlai_z, tsai_z, laisum_clm, mxlevcan, nrad, &
                            laisum_wrf )

  elai = tlai
  esai = tsai

  
  wl = elai / max( elai+esai, mpe )
  ws = esai / max( elai+esai, mpe )
  DO ib = 1, numrad
      rho(ib) = max( rhol(ivt,ib)*wl + rhos(ivt,ib)*ws, mpe )
      tau(ib) = max( taul(ivt,ib)*wl + taus(ivt,ib)*ws, mpe )
  ENDDO
  
  CALL SoilAlbedo( albsod, albsoi, soilcol, h2osoi_vol_surf )

  CALL two_stream( fabd_sun_z, fabd_sha_z, fabi_sun_z, fabi_sha_z, fsun_z,    &
                   fabd, fabi, ftdd, ftid, ftii,                              &
                   mxlevcan, nrad, coszen, rho, tau, albsod, albsoi, xl(ivt), &
                   elai, esai, tlai_z, tsai_z, laisum_clm )

  
  parsun_z = 0.
  parsha_z = 0.
  sabv = 0.
  sabg = 0.
  

  tmp = 0.
  DO ib = 1, numrad 

      
      cad(ib) = forc_solad(ib)*fabd(ib)
      cai(ib) = forc_solai(ib)*fabi(ib)
      sabv = sabv + cad(ib) + cai(ib)

      

          DO iv = 1, nrad
              parsun_z(ib,iv) = forc_solad(ib)*fabd_sun_z(ib,iv) + forc_solai(ib)*fabi_sun_z(ib,iv)
              parsha_z(ib,iv) = forc_solad(ib)*fabd_sha_z(ib,iv) + forc_solai(ib)*fabi_sha_z(ib,iv)
              
              
              
          ENDDO


      

      trd(ib) = forc_solad(ib)*ftdd(ib)
      tri(ib) = forc_solad(ib)*ftid(ib) + forc_solai(ib)*ftii(ib)

      
      sabg = sabg + trd(ib)*(1. - albsod(ib)) + tri(ib)*(1. - albsoi(ib))

  ENDDO

  
  sw_out = forc_solad(1) + forc_solai(1) + forc_solad(2) + forc_solai(2) - sabg - sabv


  
  
  
  DO iv = 1, numcan_wrf

      call to_zk2_para( laisum_wrf(iv), laisum_clm(1:nrad), nrad, kk, dz1, dz2 )
 
      parsun_z_wrf(:,iv) = dz1 * parsun_z(:,kk) + dz2 * parsun_z(:,kk+1)
      parsha_z_wrf(:,iv) = dz1 * parsha_z(:,kk) + dz2 * parsha_z(:,kk+1)
      fsun_z_wrf(iv)   = dz1 * fsun_z(kk) + dz2 * fsun_z(kk+1)

      
      
      
      

      
      sw_can_z(iv) = parsun_z_wrf(1,iv)*fsun_z_wrf(iv)        + &
                     parsun_z_wrf(2,iv)*fsun_z_wrf(iv)        + &
                     parsha_z_wrf(1,iv)*(1. - fsun_z_wrf(iv)) + &
                     parsha_z_wrf(2,iv)*(1. - fsun_z_wrf(iv))
  
  ENDDO

  end subroutine SurfaceRadiation



  subroutine two_stream( fabd_sun_z, fabd_sha_z, fabi_sun_z, fabi_sha_z, fsun_z, &
                         fabd, fabi, ftdd, ftid, ftii,                           &
                         mxlevcan, nrad, coszen, rho, tau, albgrd, albgri, xl,   &
                         elai, esai, tlai_z, tsai_z, laisum_z )

  USE clm_varpar_my, only : numrad

  IMPLICIT NONE

  INTEGER, INTENT(IN) :: nrad  
  INTEGER, INTENT(IN) :: mxlevcan
  REAL, INTENT(IN) :: coszen   
  REAL, INTENT(IN) :: rho(numrad) 
  REAL, INTENT(IN) :: tau(numrad) 
  REAL, INTENT(IN) :: albgrd(numrad)   
  REAL, INTENT(IN) :: albgri(numrad)   
  REAL, INTENT(IN) :: xl               
             
  REAL, INTENT(IN) :: elai             
  REAL, INTENT(IN) :: esai             
  REAL, INTENT(IN) :: tlai_z(mxlevcan) 
  REAL, INTENT(IN) :: tsai_z(mxlevcan) 
  REAL, INTENT(IN) :: laisum_z(mxlevcan) 

  
  REAL, INTENT(OUT) :: fabd_sun_z(numrad,mxlevcan) 
  REAL, INTENT(OUT) :: fabd_sha_z(numrad,mxlevcan) 
  REAL, INTENT(OUT) :: fabi_sun_z(numrad,mxlevcan) 
  REAL, INTENT(OUT) :: fabi_sha_z(numrad,mxlevcan) 
  REAL, INTENT(OUT) :: fsun_z(mxlevcan)            
  REAL, INTENT(OUT) :: fabd(numrad)  
  REAL, INTENT(OUT) :: fabi(numrad)  
  REAL, INTENT(OUT) :: ftdd(numrad)  
  REAL, INTENT(OUT) :: ftid(numrad)  
  REAL, INTENT(OUT) :: ftii(numrad)  

  
  real :: albd(numrad)     
  real :: albi(numrad)     
  real :: fabd_sun(numrad) 
  real :: fabd_sha(numrad) 
  real :: fabi_sun(numrad) 
  real :: fabi_sha(numrad) 

  
  real :: cosz             
  real :: asu              
  real :: chil             
  real :: gdir             
  real :: twostext         
  real :: avmu             
  real :: omega(numrad)    
  real :: omegal           
  real :: betai            
  real :: betail           
  real :: betad            
  real :: betadl           
  real :: tmp0,tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7,tmp8,tmp9 
  real :: p1,p2,p3,p4,s1,s2,u1,u2,u3                        
  real :: b,c1,d,d1,d2,f,h,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10   
  real :: phi1,phi2,sigma                                   
  real :: temp0,temp1,temp2                                 
  real :: t1                                                
  real :: a1,a2                   
  real :: v,dv,u,du                                       
  real :: dh2,dh3,dh5,dh6,dh7,dh8,dh9,dh10                
  real :: da1,da2                                         
  real :: d_ftid,d_ftii           
  real :: d_fabd,d_fabi           
  real :: d_fabd_sun,d_fabd_sha   
  real :: d_fabi_sun,d_fabi_sha   
  real :: laisum                  
  integer :: iv                   
  integer :: ib                   
  
  cosz = max(0.001, coszen)
  chil = min( max(xl, -0.4), 0.6 ) 
  if (abs(chil) <= 0.01) chil = 0.01
  phi1 = 0.5 - 0.633*chil - 0.33*chil*chil
  phi2 = 0.877 * (1.-2.*phi1)
  gdir = phi1 + phi2*cosz
  twostext = gdir/cosz
  avmu = ( 1. - phi1/phi2 * log((phi1+phi2)/phi1) ) / phi2
  temp0 = gdir + phi2*cosz
  temp1 = phi1*cosz
  temp2 = ( 1. - temp1/temp0 * log((temp1+temp0)/temp1) )

  
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  DO ib = 1, numrad   
      
      
      

      omegal = rho(ib) + tau(ib)
      asu = 0.5*omegal*gdir/temp0*temp2
      betail = 0.5 * ( (rho(ib)+tau(ib)) + (rho(ib)-tau(ib))*((1.+chil)/2.)**2 ) / omegal
      betadl = (1.+avmu*twostext)/(omegal*avmu*twostext)*asu
  
      
      omega(ib) = omegal
      betad = betadl
      betai = betail

      
      b = 1. - omega(ib) + omega(ib)*betai
      c1 = omega(ib)*betai
      tmp0 = avmu*twostext
      d = tmp0 * omega(ib)*betad
      f = tmp0 * omega(ib)*(1.-betad)
      tmp1 = b*b - c1*c1
      h = sqrt(tmp1) / avmu
      sigma = tmp0*tmp0 - tmp1
      p1 = b + avmu*h
      p2 = b - avmu*h
      p3 = b + tmp0
      p4 = b - tmp0

      
      
      t1 = min(h*(elai+esai), 40.)
      s1 = exp(-t1)
      t1 = min(twostext*(elai+esai), 40.)
      s2 = exp(-t1)

      

      u1 = b - c1/albgrd(ib)
      u2 = b - c1*albgrd(ib)
      u3 = f + c1*albgrd(ib)
      tmp2 = u1 - avmu*h
      tmp3 = u1 + avmu*h
      d1 = p1*tmp2/s1 - p2*tmp3*s1
      tmp4 = u2 + avmu*h
      tmp5 = u2 - avmu*h
      d2 = tmp4/s1 - tmp5*s1
      h1 = -d*p4 - c1*f
      tmp6 = d - h1*p3/sigma
      tmp7 = ( d - c1 - h1/sigma*(u1+tmp0) ) * s2
      h2 = ( tmp6*tmp2/s1 - p2*tmp7 ) / d1
      h3 = - ( tmp6*tmp3*s1 - p1*tmp7 ) / d1
      h4 = -f*p3 - c1*d
      tmp8 = h4/sigma
      tmp9 = ( u3 - tmp8*(u2-tmp0) ) * s2
      h5 = - ( tmp8*tmp4/s1 + tmp9 ) / d2
      h6 = ( tmp8*tmp5*s1 + tmp9 ) / d2

      albd(ib) = h1/sigma + h2 + h3
      ftid(ib) = h4*s2/sigma + h5*s1 + h6/s1
      ftdd(ib) = s2
      fabd(ib) = 1. - albd(ib) - (1.-albgrd(ib)) * ftdd(ib) - (1.-albgri(ib))*ftid(ib)

      a1 = h1 / sigma * (1. - s2*s2) / (2. * twostext) &
         + h2         * (1. - s2*s1) / (twostext + h) &
         + h3         * (1. - s2/s1) / (twostext - h)

      a2 = h4 / sigma * (1. - s2*s2) / (2. * twostext) &
         + h5         * (1. - s2*s1) / (twostext + h) &
         + h6         * (1. - s2/s1) / (twostext - h)

      fabd_sun(ib) = (1. - omega(ib)) * ( 1. - s2 + 1. / avmu * (a1 + a2) )
      fabd_sha(ib) = fabd(ib) - fabd_sun(ib)

      

      u1 = b - c1/albgri(ib)
      u2 = b - c1*albgri(ib)
      tmp2 = u1 - avmu*h
      tmp3 = u1 + avmu*h
      d1 = p1*tmp2/s1 - p2*tmp3*s1
      tmp4 = u2 + avmu*h
      tmp5 = u2 - avmu*h
      d2 = tmp4/s1 - tmp5*s1
      h7 = (c1*tmp2) / (d1*s1)
      h8 = (-c1*tmp3*s1) / d1
      h9 = tmp4 / (d2*s1)
      h10 = (-tmp5*s1) / d2

      albi(ib) = h7 + h8
      ftii(ib) = h9*s1 + h10/s1
      fabi(ib) = 1. - albi(ib) - (1.-albgri(ib))*ftii(ib)

      a1 = h7 * (1. - s2*s1) / (twostext + h) +  h8 * (1. - s2/s1) / (twostext - h)
      a2 = h9 * (1. - s2*s1) / (twostext + h) + h10 * (1. - s2/s1) / (twostext - h)

      fabi_sun(ib) = (1. - omega(ib)) / avmu * (a1 + a2)
      fabi_sha(ib) = fabi(ib) - fabi_sun(ib)

      
      
      
      
      
      

      
      

      
          DO iv = 1, nrad  

              
              laisum = laisum_z(iv)

              

              t1 = min(h*laisum, 40.)
              s1 = exp(-t1)
              t1 = min(twostext*laisum, 40.)
              s2 = exp(-t1)
              fsun_z(iv) = s2

              
              
              

              

              u1 = b - c1/albgrd(ib)
              u2 = b - c1*albgrd(ib)
              u3 = f + c1*albgrd(ib)
              tmp2 = u1 - avmu*h
              tmp3 = u1 + avmu*h
              d1 = p1*tmp2/s1 - p2*tmp3*s1
              tmp4 = u2 + avmu*h
              tmp5 = u2 - avmu*h
              d2 = tmp4/s1 - tmp5*s1
              h1 = -d*p4 - c1*f
              tmp6 = d - h1*p3/sigma
              tmp7 = ( d - c1 - h1/sigma*(u1+tmp0) ) * s2
              h2 = ( tmp6*tmp2/s1 - p2*tmp7 ) / d1
              h3 = - ( tmp6*tmp3*s1 - p1*tmp7 ) / d1
              h4 = -f*p3 - c1*d
              tmp8 = h4/sigma
              tmp9 = ( u3 - tmp8*(u2-tmp0) ) * s2
              h5 = - ( tmp8*tmp4/s1 + tmp9 ) / d2
              h6 = ( tmp8*tmp5*s1 + tmp9 ) / d2

              a1 = h1 / sigma * (1. - s2*s2) / (2. * twostext) &
                 + h2         * (1. - s2*s1) / (twostext + h) &
                 + h3         * (1. - s2/s1) / (twostext - h)

              a2 = h4 / sigma * (1. - s2*s2) / (2. * twostext) &
                 + h5         * (1. - s2*s1) / (twostext + h) &
                 + h6         * (1. - s2/s1) / (twostext - h)

              

              v = d1
              dv = h * p1 * tmp2 / s1 + h * p2 * tmp3 * s1

              u = tmp6 * tmp2 / s1 - p2 * tmp7
              du = h * tmp6 * tmp2 / s1 + twostext * p2 * tmp7
              dh2 = (v * du - u * dv) / (v * v)

              u = -tmp6 * tmp3 * s1 + p1 * tmp7
              du = h * tmp6 * tmp3 * s1 - twostext * p1 * tmp7
              dh3 = (v * du - u * dv) / (v * v)

              v = d2
              dv = h * tmp4 / s1 + h * tmp5 * s1

              u = -h4/sigma * tmp4 / s1 - tmp9
              du = -h * h4/sigma * tmp4 / s1 + twostext * tmp9
              dh5 = (v * du - u * dv) / (v * v)

              u = h4/sigma * tmp5 * s1 + tmp9
              du = -h * h4/sigma * tmp5 * s1 - twostext * tmp9
              dh6 = (v * du - u * dv) / (v * v)

              da1 = h1/sigma * s2*s2 + h2 * s2*s1 + h3 * s2/s1 &
                  + (1. - s2*s1) / (twostext + h) * dh2 &
                  + (1. - s2/s1) / (twostext - h) * dh3
              da2 = h4/sigma * s2*s2 + h5 * s2*s1 + h6 * s2/s1 &
                  + (1. - s2*s1) / (twostext + h) * dh5 &
                  + (1. - s2/s1) / (twostext - h) * dh6

              

              d_ftid = -twostext*h4/sigma*s2 - h*h5*s1 + h*h6/s1 + dh5*s1 + dh6/s1
              d_fabd = -(dh2+dh3) + (1.-albgrd(ib))*twostext*s2 - (1.-albgri(ib))*d_ftid
              d_fabd_sun = (1. - omega(ib)) * (twostext*s2 + 1. / avmu * (da1 + da2))
              d_fabd_sha = d_fabd - d_fabd_sun

              fabd_sun_z(ib,iv) = max(d_fabd_sun, 0.)
              fabd_sha_z(ib,iv) = max(d_fabd_sha, 0.)

              
              
              

              fabd_sun_z(ib,iv) = fabd_sun_z(ib,iv) / fsun_z(iv)
              fabd_sha_z(ib,iv) = fabd_sha_z(ib,iv) / (1. - fsun_z(iv))

              
              
              

              

              u1 = b - c1/albgri(ib)
              u2 = b - c1*albgri(ib)
              tmp2 = u1 - avmu*h
              tmp3 = u1 + avmu*h
              d1 = p1*tmp2/s1 - p2*tmp3*s1
              tmp4 = u2 + avmu*h
              tmp5 = u2 - avmu*h
              d2 = tmp4/s1 - tmp5*s1
              h7 = (c1*tmp2) / (d1*s1)
              h8 = (-c1*tmp3*s1) / d1
              h9 = tmp4 / (d2*s1)
              h10 = (-tmp5*s1) / d2

              a1 = h7 * (1. - s2*s1) / (twostext + h) +  h8 * (1. - s2/s1) / (twostext - h)
              a2 = h9 * (1. - s2*s1) / (twostext + h) + h10 * (1. - s2/s1) / (twostext - h)

              

              v = d1
              dv = h * p1 * tmp2 / s1 + h * p2 * tmp3 * s1

              u = c1 * tmp2 / s1
              du = h * c1 * tmp2 / s1
              dh7 = (v * du - u * dv) / (v * v)

              u = -c1 * tmp3 * s1
              du = h * c1 * tmp3 * s1
              dh8 = (v * du - u * dv) / (v * v)

              v = d2
              dv = h * tmp4 / s1 + h * tmp5 * s1

              u = tmp4 / s1
              du = h * tmp4 / s1
              dh9 = (v * du - u * dv) / (v * v)

              u = -tmp5 * s1
              du = h * tmp5 * s1
              dh10 = (v * du - u * dv) / (v * v)

              da1 = h7*s2*s1 +  h8*s2/s1 + (1.-s2*s1)/(twostext+h)*dh7 + (1.-s2/s1)/(twostext-h)*dh8
              da2 = h9*s2*s1 + h10*s2/s1 + (1.-s2*s1)/(twostext+h)*dh9 + (1.-s2/s1)/(twostext-h)*dh10

              

              d_ftii = -h * h9 * s1 + h * h10 / s1 + dh9 * s1 + dh10 / s1
              d_fabi = -(dh7+dh8) - (1.-albgri(ib))*d_ftii
              d_fabi_sun = (1. - omega(ib)) / avmu * (da1 + da2)
              d_fabi_sha = d_fabi - d_fabi_sun

              fabi_sun_z(ib,iv) = max(d_fabi_sun, 0.)
              fabi_sha_z(ib,iv) = max(d_fabi_sha, 0.)

              
              
              

              fabi_sun_z(ib,iv) = fabi_sun_z(ib,iv) / fsun_z(iv)
              fabi_sha_z(ib,iv) = fabi_sha_z(ib,iv) / (1. - fsun_z(iv))

          ENDDO  

      

  ENDDO 

  end subroutine two_stream



  subroutine Lw_Canopy( ivt, forc_lwrad, t_veg_z, t_air_z, t_grnd, ems, tlai_z, tsai_z, numcan, &
                        lwcan, lw_grnd, lw_out )

  
  USE clm_varpar_my, only : sb, emsv, mxlevcan_wrf

  implicit none
  
  integer, intent(in) :: ivt
  real, intent(in) :: forc_lwrad  
  real, intent(in) :: t_grnd      
  real, intent(in) :: ems         
  integer, intent(in) :: numcan   
  real, dimension(mxlevcan_wrf), intent(in)  :: t_veg_z 
  real, dimension(mxlevcan_wrf), intent(in)  :: t_air_z 
  real, dimension(mxlevcan_wrf), intent(in)  :: tlai_z, tsai_z

  real, dimension(mxlevcan_wrf), intent(out) :: lwcan 
  real, dimension(mxlevcan_wrf) :: lwcan1 
  real, dimension(mxlevcan_wrf) :: lwcan2 
  real, intent(out) :: lw_grnd, lw_out

  
  real :: avmuir  
  real :: ev    
  real :: inlayer, outlayer, emv(numcan)
  real :: IRin, IRout
  integer :: iv









  avmuir = 1.
  ev = emsv(ivt)

  lwcan = 0.


  inlayer = forc_lwrad
  do iv = 1, numcan  
      
      
      emv(iv) = ( 1. - exp(-(tlai_z(iv)+tsai_z(iv))/avmuir) ) * ev

      outlayer = emv(iv)*sb*t_veg_z(iv)**4
      lwcan(iv) = lwcan(iv) + emv(iv)*inlayer - outlayer
      inlayer = (1.-emv(iv))*inlayer + outlayer

  enddo

  lw_grnd = ems*inlayer  



  inlayer = ems*sb*t_grnd**4 + (1.-ems)*inlayer

  do iv = numcan, 1, -1  
      outlayer = emv(iv)*sb*t_veg_z(iv)**4
      lwcan(iv) = lwcan(iv) + emv(iv)*inlayer - outlayer
      inlayer = (1.-emv(iv))*inlayer + outlayer

  enddo

  lw_out = inlayer


  do iv = 1, numcan  
      lwcan(iv) = lwcan(iv)/(tlai_z(iv)+tsai_z(iv))

  enddo

  end subroutine Lw_Canopy



  subroutine SoilAlbedo( albsod, albsoi, soilcol, surf_h2osoi_vol )

  USE clm_varpar_my, only : numrad, albsat, albdry
  implicit none
  
  integer, intent(in) :: soilcol
  real, intent(in) :: surf_h2osoi_vol
  
  real, intent(out) :: albsod(numrad)  
  real, intent(out) :: albsoi(numrad)  
  
  integer :: ib  
  real :: inc

  DO ib = 1, numrad
      inc = max( 0.11-0.40*surf_h2osoi_vol, 0. )

      albsod(ib) = min( albsat(soilcol,ib) + inc, albdry(soilcol,ib) )
      albsoi(ib) = albsod(ib)

  ENDDO

  end subroutine SoilAlbedo



  subroutine SoilWater( h2osoi_vol, qflx_ev_grnd, qflx_tran_veg, t_soisno, &
                        dtime, z, dz, zi, watsat, hksat, bsw, sucsat, rootr, zwt, topo_slope )































































  use clm_varpar_my, only :  denh2o, denice, tfrz, hfus, grav, smpmin, &
                             e_ice, nlevsoi, nlevgrnd
  implicit none

  real, intent(out) :: h2osoi_vol(nlevgrnd) 
  real, intent(in) :: qflx_ev_grnd       
  real, intent(in) :: qflx_tran_veg      
  real, intent(in) :: t_soisno(nlevgrnd) 
  real, intent(in) :: dtime              
  real, intent(in) :: z(0:nlevgrnd)      
  real, intent(in) :: dz(0:nlevgrnd)     
  real, intent(in) :: zi(0:nlevgrnd)     
  real, intent(in) :: watsat(nlevgrnd)   
  real, intent(in) :: hksat(nlevgrnd)    
  real, intent(in) :: bsw(nlevgrnd)      
  real, intent(in) :: sucsat(nlevgrnd)   
  real, intent(inout) :: zwt                
  real, intent(in) :: rootr(nlevgrnd)    
                                         
  real, intent(in) :: topo_slope     
  

  real :: qflx_infl              
  real :: h2osoi_liq(nlevgrnd)   
  real :: h2osoi_ice(nlevgrnd)   

  real :: fracice(nlevgrnd)      
  real :: dwat(1:nlevsoi)        
  real :: hk(1:nlevsoi)          
  real :: dhkdw(1:nlevsoi)       

  real :: zmm(1:nlevsoi+1)       
  real :: dzmm(1:nlevsoi+1)      
  real :: zimm(0:nlevsoi)        
  real :: zwtmm                  
  real :: vol_eq(1:nlevsoi+1)    
  real :: zq(1:nlevsoi+1)        
  real :: vwc_liq(1:nlevsoi+1)   
  real :: vwc_zwt

  real :: tempi                  
  real :: temp0                  
  real :: voleq1                 
  real :: s_node                 
  real :: s1                     
  real :: s2                     
  real :: smp(1:nlevsoi)         
  real :: sdamp                  
  real :: amx(1:nlevsoi+1)       
  real :: bmx(1:nlevsoi+1)       
  real :: cmx(1:nlevsoi+1)       
  real :: rmx(1:nlevsoi+1)       
  real :: dzq                    
                                 
  real :: den                    
  real :: dqidw0(1:nlevsoi+1)    
  real :: dqidw1(1:nlevsoi+1)    
  real :: dqodw1(1:nlevsoi+1)    
  real :: dqodw2(1:nlevsoi+1)    
  real :: dsmpdw(1:nlevsoi+1)    
  real :: num                    
  real :: qin(1:nlevsoi+1)       
  real :: qout(1:nlevsoi+1)      
  integer :: jwt                 
  real :: vol_ice(1:nlevsoi), icefrac(1:nlevsoi)
  real :: qcharge           
  
  integer :: origflag = 0        
  integer :: j
  real :: smp1,dsmpdw1,wh,wh_zwt,ka, dwat2(1:nlevsoi+1), imped(1:nlevsoi)
  
  h2osoi_ice = 0.

  
  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_vol(j)*( dz(j)*denh2o ) 
  enddo

  
  

  do j = 1, nlevsoi
      zmm(j) = z(j)*1.e3
      dzmm(j) = dz(j)*1.e3
      zimm(j) = zi(j)*1.e3
      
      vol_ice(j) = min(watsat(j), h2osoi_ice(j)/(dz(j)*denice))
      icefrac(j) = min(1.,vol_ice(j)/watsat(j))
      vwc_liq(j) = max(h2osoi_liq(j),1.0e-6)/(dz(j)*denh2o)
      fracice(j) = 0.  
  end do
  zimm(0) = 0.0
  zwtmm  = zwt*1.e3

  
  
  

  jwt = nlevsoi
  
  do j = 1,nlevsoi
      if(zwt <= zi(j)) then
          jwt = j-1
          exit
      end if
  enddo

  
  
  vwc_zwt = watsat(nlevsoi)
  if(t_soisno(jwt+1) < tfrz) then
      vwc_zwt = vwc_liq(nlevsoi)
      do j = nlevsoi,nlevgrnd
          if(zwt <= zi(j)) then
              smp1 = hfus*(tfrz-t_soisno(j))/(grav*t_soisno(j)) * 1000.  
              smp1 = max(0., smp1)
              smp1 = max(sucsat(nlevsoi),smp1)
              vwc_zwt = watsat(nlevsoi)*(smp1/sucsat(nlevsoi))**(-1./bsw(nlevsoi))
              
              vwc_zwt = min(vwc_zwt, 0.5*(watsat(nlevsoi) + h2osoi_vol(nlevsoi)) )
              exit
          endif
      enddo
  endif

  

  do j=1,nlevsoi
      if ((zwtmm .le. zimm(j-1))) then
          vol_eq(j) = watsat(j)

          
          

      else if ((zwtmm .lt. zimm(j)) .and. (zwtmm .gt. zimm(j-1))) then
          tempi = 1.0
          temp0 = (((sucsat(j)+zwtmm-zimm(j-1))/sucsat(j)))**(1.-1./bsw(j))
          voleq1 = -sucsat(j)*watsat(j)/(1.-1./bsw(j))/(zwtmm-zimm(j-1))*(tempi-temp0)
          vol_eq(j) = (voleq1*(zwtmm-zimm(j-1)) + watsat(j)*(zimm(j)-zwtmm))/(zimm(j)-zimm(j-1))
          vol_eq(j) = min(watsat(j),vol_eq(j))
          vol_eq(j) = max(vol_eq(j),0.0)
      else
          tempi = (((sucsat(j)+zwtmm-zimm(j))/sucsat(j)))**(1.-1./bsw(j))
          temp0 = (((sucsat(j)+zwtmm-zimm(j-1))/sucsat(j)))**(1.-1./bsw(j))
          vol_eq(j) = -sucsat(j)*watsat(j)/(1.-1./bsw(j))/(zimm(j)-zimm(j-1))*(tempi-temp0)
          vol_eq(j) = max(vol_eq(j),0.0)
          vol_eq(j) = min(watsat(j),vol_eq(j))
      endif
      zq(j) = -sucsat(j)*(max(vol_eq(j)/watsat(j),0.01))**(-bsw(j))
      zq(j) = max(smpmin, zq(j))
  end do

  
  j = nlevsoi
  if(jwt == nlevsoi) then
      tempi = 1.
      temp0 = (((sucsat(j)+zwtmm-zimm(j))/sucsat(j)))**(1.-1./bsw(j))
      vol_eq(j+1) = -sucsat(j)*watsat(j)/(1.-1./bsw(j))/(zwtmm-zimm(j))*(tempi-temp0)
      vol_eq(j+1) = max(vol_eq(j+1),0.0)
      vol_eq(j+1) = min(watsat(j),vol_eq(j+1))
      zq(j+1) = -sucsat(j)*(max(vol_eq(j+1)/watsat(j),0.01))**(-bsw(j))
      zq(j+1) = max(smpmin, zq(j+1))
  end if

  

  sdamp = 0.
  do j = 1, nlevsoi
      

      if(origflag == 1) then
          s1 = 0.5*(h2osoi_vol(j) + h2osoi_vol(min(nlevsoi, j+1))) / &
               ( 0.5*(watsat(j) + watsat(min(nlevsoi, j+1))) )
      else
          s1 = 0.5*(vwc_liq(j) + vwc_liq(min(nlevsoi, j+1))) / &
               ( 0.5*(watsat(j) + watsat(min(nlevsoi, j+1))) )
      endif
      s1 = min(1., s1)
      s2 = hksat(j)*s1**(2.*bsw(j)+2.)  

      
      if(origflag == 1) then
          imped(j)=(1.-0.5*(fracice(j)+fracice(min(nlevsoi, j+1))))
      else
          imped(j)=10.**(-e_ice*( 0.5*(icefrac(j)+icefrac(min(nlevsoi, j+1))) ))
      endif
      hk(j) = imped(j)*s1*s2
      dhkdw(j) = imped(j)*(2.*bsw(j)+3.)*s2*(1./(watsat(j)+watsat(min(nlevsoi, j+1))))

      
      if(origflag == 1) then
          s_node = max(h2osoi_vol(j)/watsat(j), 0.01)
      else
          s_node = max(vwc_liq(j)/watsat(j), 0.01)
      endif
      s_node = min(1.0, s_node)

      smp(j) = -sucsat(j)*s_node**(-bsw(j))
      smp(j) = max(smpmin, smp(j))

      if(origflag == 1) then
          dsmpdw(j) = -bsw(j)*smp(j)/(s_node*watsat(j))
      else
          dsmpdw(j) = -bsw(j)*smp(j)/vwc_liq(j)
      endif

      
      

  end do

  
  zmm(nlevsoi+1) = 0.5*(1.e3*zwt + zmm(nlevsoi))
  if(jwt < nlevsoi) then
      dzmm(nlevsoi+1) = dzmm(nlevsoi)
  else
      dzmm(nlevsoi+1) = (1.e3*zwt - zmm(nlevsoi))
  end if

  

  

  
  qflx_infl = -qflx_ev_grnd  

  j = 1
  qin(j) = qflx_infl
  den    = zmm(j+1) - zmm(j)
  dzq    = zq(j+1) - zq(j)
  num    = smp(j+1) - smp(j) - dzq
  qout(j)   = -hk(j)*num/den
  dqodw1(j) = -(-hk(j)*dsmpdw(j)   + num*dhkdw(j))/den
  dqodw2(j) = -( hk(j)*dsmpdw(j+1) + num*dhkdw(j))/den
  rmx(j) =  qin(j) - qout(j) - qflx_tran_veg * rootr(j)
  amx(j) =  0.
  bmx(j) =  dzmm(j)*(sdamp+1./dtime) + dqodw1(j)
  cmx(j) =  dqodw2(j)

  

  do j = 2, nlevsoi - 1
      den    = zmm(j) - zmm(j-1)
      dzq    = zq(j)-zq(j-1)
      num    = smp(j)-smp(j-1) - dzq
      qin(j)    = -hk(j-1)*num/den
      dqidw0(j) = -(-hk(j-1)*dsmpdw(j-1) + num*dhkdw(j-1))/den
      dqidw1(j) = -( hk(j-1)*dsmpdw(j)   + num*dhkdw(j-1))/den
      den    = zmm(j+1)-zmm(j)
      dzq    = zq(j+1)-zq(j)
      num    = smp(j+1)-smp(j) - dzq
      qout(j)   = -hk(j)*num/den
      dqodw1(j) = -(-hk(j)*dsmpdw(j)   + num*dhkdw(j))/den
      dqodw2(j) = -( hk(j)*dsmpdw(j+1) + num*dhkdw(j))/den
      rmx(j)    =  qin(j) - qout(j) - qflx_tran_veg*rootr(j)
      amx(j)    = -dqidw0(j)
      bmx(j)    =  dzmm(j)/dtime - dqidw1(j) + dqodw1(j)
      cmx(j)    =  dqodw2(j)
  end do

  

  j = nlevsoi
  if(j > jwt) then 
      den    = (zmm(j) - zmm(j-1))
      dzq    = (zq(j)-zq(j-1))
      num    = (smp(j)-smp(j-1)) - dzq
      qin(j)    = -hk(j-1)*num/den
      dqidw0(j) = -(-hk(j-1)*dsmpdw(j-1) + num*dhkdw(j-1))/den
      dqidw1(j) = -( hk(j-1)*dsmpdw(j)   + num*dhkdw(j-1))/den
      qout(j)   =  0.
      dqodw1(j) =  0.
      rmx(j)    =  qin(j) - qout(j) - qflx_tran_veg*rootr(j)
      amx(j)    = -dqidw0(j)
      bmx(j)    =  dzmm(j)/dtime - dqidw1(j) + dqodw1(j)
      cmx(j)    =  0.

      
      rmx(j+1) = 0.
      amx(j+1) = 0.
      bmx(j+1) = dzmm(j+1)/dtime
      cmx(j+1) = 0.
  else 

      
      if(origflag == 1) then
           s_node = max(0.5*( 1.0+h2osoi_vol(j)/watsat(j) ), 0.01)
      else
           s_node = max(0.5*( (vwc_zwt+vwc_liq(j))/watsat(j) ), 0.01)
      endif
      s_node = min(1.0, s_node)

      
      smp1 = -sucsat(j)*s_node**(-bsw(j))
      smp1 = max(smpmin, smp1)

      
      dsmpdw1 = -bsw(j)*smp1/(s_node*watsat(j))

      
      den    = (zmm(j) - zmm(j-1))
      dzq    = (zq(j)-zq(j-1))
      num    = (smp(j)-smp(j-1)) - dzq
      qin(j)    = -hk(j-1)*num/den
      dqidw0(j) = -(-hk(j-1)*dsmpdw(j-1) + num*dhkdw(j-1))/den
      dqidw1(j) = -( hk(j-1)*dsmpdw(j)   + num*dhkdw(j-1))/den
      den    = (zmm(j+1)-zmm(j))
      dzq    = (zq(j+1)-zq(j))
      num    = (smp1-smp(j)) - dzq
      qout(j)   = -hk(j)*num/den
      dqodw1(j) = -(-hk(j)*dsmpdw(j)   + num*dhkdw(j))/den
      dqodw2(j) = -( hk(j)*dsmpdw1 + num*dhkdw(j))/den

      rmx(j) =  qin(j) - qout(j) - qflx_tran_veg*rootr(j)
      amx(j) = -dqidw0(j)
      bmx(j) =  dzmm(j)/dtime - dqidw1(j) + dqodw1(j)
      cmx(j) =  dqodw2(j)

      
      qin(j+1)    = qout(j)
      dqidw0(j+1) = -(-hk(j)*dsmpdw(j) + num*dhkdw(j))/den
      dqidw1(j+1) = -( hk(j)*dsmpdw1   + num*dhkdw(j))/den
      qout(j+1)   =  0.  
      dqodw1(j+1) =  0.  
      rmx(j+1) =  qin(j+1) - qout(j+1)
      amx(j+1) = -dqidw0(j+1)
      bmx(j+1) =  dzmm(j+1)/dtime - dqidw1(j+1) + dqodw1(j+1)
      cmx(j+1) =  0.
  endif

  

  call Tridiagonal(nlevsoi+1, amx, bmx, cmx, rmx, dwat2)

  
  do j = 1, nlevsoi
      dwat(j)=dwat2(j)
  end do

  
  
  

  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_liq(j) + dwat2(j)*dzmm(j)
      
      
      
      h2osoi_vol(j) = h2osoi_liq(j)/( dz(j)*denh2o ) 
      h2osoi_vol(j) = min( h2osoi_vol(j), watsat(j) )
  end do


  
  if(jwt < nlevsoi) then
      wh_zwt = 0.   

      
      s_node = max(h2osoi_vol(jwt+1)/watsat(jwt+1), 0.01)
      s1 = min(1., s_node)

      
      ka = imped(jwt+1)*hksat(jwt+1)*s1**(2.*bsw(jwt+1)+3.)

      
      smp1 = max(smpmin, smp(max(1,jwt)))
      wh   = smp1 - zq(max(1,jwt))

      
      if(jwt == 0) then
         qcharge = -ka * (wh_zwt-wh)/((zwt+1.e-3)*1000.)
      else
         
         
         qcharge = -ka * (wh_zwt-wh)/((zwt-z(jwt))*1000.*2.0)
      endif

      
      qcharge = max(-10.0/dtime,qcharge)
      qcharge = min( 10.0/dtime,qcharge)
  else
      
      qcharge = dwat2(nlevsoi+1)*dzmm(nlevsoi+1)/dtime
  endif

  call Drainage( h2osoi_vol, zwt, qcharge, t_soisno, dtime, z, dz, zi, &
                 watsat, hksat, bsw, sucsat, topo_slope )

  end subroutine SoilWater



  subroutine Drainage( h2osoi_vol, zwt, qcharge, t_soisno, dtime, z, dz, zi, &
                       watsat, hksat, bsw, sucsat, topo_slope )
  
  use clm_varpar_my, only :  denh2o, denice, tfrz, hfus, grav, smpmin, &
                             e_ice, watmin, nlevsoi, nlevgrnd
  implicit none
  real, intent(inout) :: h2osoi_vol(nlevgrnd) 
  real, intent(inout) :: zwt                
  real, intent(in) :: qcharge           
  real, intent(in) :: t_soisno(nlevgrnd) 
  real, intent(in) :: dtime              
  real, intent(in) :: z(0:nlevgrnd)      
  real, intent(in) :: dz(0:nlevgrnd)     
  real, intent(in) :: zi(0:nlevgrnd)     
  real, intent(in) :: watsat(nlevgrnd)   
  real, intent(in) :: hksat(nlevgrnd)    
  real, intent(in) :: bsw(nlevgrnd)      
  real, intent(in) :: sucsat(nlevgrnd)   
                                         
  real, intent(in) :: topo_slope     

  
  integer :: jwt                 
  real :: dzmm(1:nlevsoi+1)      
 
  real :: eff_porosity(nlevsoi)   
  real :: h2osoi_liq(nlevgrnd)   
  real :: h2osoi_ice(nlevgrnd)   

  real :: qflx_drain     
  real :: qflx_rsub_sat  
  real :: rsub_bot       
  real :: rsub_top       


  real :: wtsub          
  real :: rous           
  real :: frost_table    

  real :: qflx_drain_perched     
  real :: qcharge_tot, qcharge_layer
  real :: q_perch_max 
  real :: q_perch 
  real :: s_y
  real :: imped
  real :: rsub_top_tot
  real :: rsub_top_layer
  real :: sat_lev, s1, s2, m, b
  real :: zwt_perched  
  real :: available_h2osoi_liq

  real :: icefrac(nlevgrnd)   
  real :: xs              
  real :: xsi             
  real :: xsia            
  real :: xs1             

  integer :: k_frz, k_perch
  integer :: i, j
  real :: tmp

  REAL :: PI = 3.1415926535897932384626433
  real :: pondmx = 0.0     

  integer :: origflag = 0        

  h2osoi_ice = 0.
  icefrac = 0.

  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_vol(j)*dz(j)*denh2o 
      eff_porosity(j) = watsat(j)  
  enddo


  
  do j = 1, nlevsoi
      dzmm(j) = dz(j)*1.e3
  enddo

  
  qflx_drain = 0.

  
  
   
  jwt = nlevsoi
  
  do j = 1,nlevsoi
      if(zwt <= zi(j)) then
          jwt = j-1
          exit
      end if
  enddo




  
  rous = watsat(nlevsoi) * ( 1. - (1.+1.e3*zwt/sucsat(nlevsoi))**(-1./bsw(nlevsoi)))
  rous = max(rous, 0.02)

  if(jwt == nlevsoi) then 

      zwt = zwt - (qcharge * dtime)/1000./rous

  else 

      qcharge_tot = qcharge * dtime

      if(qcharge_tot > 0.) then 
          do j = jwt+1, 1, -1
              
              s_y = watsat(j) * ( 1. -  (1.+1.e3*zwt/sucsat(j))**(-1./bsw(j)))
              s_y = max(s_y, 0.02)

              qcharge_layer = min(qcharge_tot, (s_y*(zwt - zi(j-1))*1.e3))
              qcharge_layer = max(qcharge_layer, 0.)
              qcharge_tot = qcharge_tot - qcharge_layer

              zwt = zwt - qcharge_layer/s_y/1000.

              if (qcharge_tot <= 0.) exit
          enddo

      else 
          do j = jwt+1, nlevsoi
              
              s_y = watsat(j) * ( 1. -  (1.+1.e3*zwt/sucsat(j))**(-1./bsw(j)))
              s_y=max(s_y,0.02)

              qcharge_layer = max(qcharge_tot, -(s_y*(zi(j) - zwt)*1.e3))
              qcharge_layer = min(qcharge_layer, 0.)
              qcharge_tot = qcharge_tot - qcharge_layer

              if (qcharge_tot >= 0.) then
                  zwt = zwt - qcharge_layer/s_y/1000.
                  exit
              else
                  zwt = zi(j)
              endif
          enddo 
          if (qcharge_tot > 0.) zwt = zwt - qcharge_tot/rous/1000.
      endif

      
      do j = 1,nlevsoi
          if(zwt <= zi(j)) then
              jwt = j-1
              exit
          endif
      enddo

  endif




  
  q_perch_max = 1.e-5 * sin(topo_slope * (PI/180.))

  
  
  

  

  k_frz = nlevsoi
  if(t_soisno(1) <= tfrz) k_frz = 1

  do j = 2, nlevsoi
      if (t_soisno(j-1) > tfrz .and. t_soisno(j) <= tfrz) then
          k_frz = j
          exit
      endif
  enddo

  frost_table = z(k_frz)

  
  zwt_perched = frost_table
  qflx_drain_perched = 0.




























































































































  
  
  
  


  
  
  

  do j = nlevsoi, 2, -1
      xsi             = max(h2osoi_liq(j)-eff_porosity(j)*dzmm(j), 0.)
      h2osoi_liq(j)   = min(eff_porosity(j)*dzmm(j), h2osoi_liq(j))
      h2osoi_liq(j-1) = h2osoi_liq(j-1) + xsi
  enddo

  xs1 = max(h2osoi_liq(1), 0.) - max((pondmx + watsat(1)*dzmm(1) - h2osoi_ice(1)), 0.)
  xs1 = max(xs1, 0.)

  tmp = max(0., pondmx + watsat(1)*dzmm(1) - h2osoi_ice(1))
  h2osoi_liq(1) = min(tmp, h2osoi_liq(1))

  
  
  
  
  
  
  
  
  qflx_rsub_sat=  xs1 / dtime

  

  
  
  
  

  do j = 1, nlevsoi-1
      if (h2osoi_liq(j) < watmin) then
          xs = watmin - h2osoi_liq(j)
          
          if(j == jwt) zwt = zwt + xs/eff_porosity(j)/1000.
      else
          xs = 0.
      endif
      h2osoi_liq(j  ) = h2osoi_liq(j  ) + xs
      h2osoi_liq(j+1) = h2osoi_liq(j+1) - xs
  enddo

  
  j = nlevsoi
  if (h2osoi_liq(j) < watmin) then
      xs = watmin - h2osoi_liq(j)
 
      do i = nlevsoi-1, 1, -1
          available_h2osoi_liq = max(h2osoi_liq(i) - watmin - xs, 0.)
          if (available_h2osoi_liq >= xs) then
              h2osoi_liq(j) = h2osoi_liq(j) + xs
              h2osoi_liq(i) = h2osoi_liq(i) - xs
              xs = 0.
              exit
          else
              h2osoi_liq(j) = h2osoi_liq(j) + available_h2osoi_liq
              h2osoi_liq(i) = h2osoi_liq(i) - available_h2osoi_liq
              xs = xs - available_h2osoi_liq
          endif
      enddo
  else
      xs = 0.
  end if

  
  h2osoi_liq(j) = h2osoi_liq(j) + xs

  
  
  

  
  


  do j = 1, nlevsoi
      h2osoi_vol(j) = h2osoi_liq(j)/( dz(j)*denh2o ) 
      h2osoi_vol(j) = min( h2osoi_vol(j), watsat(j) )
  end do

  end subroutine Drainage



  subroutine SoilTemperature( t_soisno, eflx_sh_grnd, qflx_ev_grnd, h2osoi_vol, &
                              cgrnd, dlrad, sabg, dtime, z, dz, zi,             &
                              watsat, tkmg, tkdry, csol, tk, cv, ems )





















  use clm_varpar_my  , only :  denh2o, denice, tfrz, sb,  hvap, nlevsoi, nlevgrnd
  implicit none

  real, intent(out) :: t_soisno(nlevgrnd)   

  real, intent(in) :: eflx_sh_grnd    
  real, intent(in) :: qflx_ev_grnd    
  real, intent(in) :: h2osoi_vol(nlevgrnd)   
  real, intent(in) :: cgrnd           
  real, intent(in) :: dlrad           
  real, intent(in) :: sabg            
  real, intent(in) :: dtime           
  real, intent(in) :: z(0:nlevgrnd)   
  real, intent(in) :: dz(0:nlevgrnd)  
  real, intent(in) :: zi(0:nlevgrnd)  
  real, intent(in) :: watsat(nlevgrnd)
  real, intent(in) :: tkmg(nlevgrnd)  
  real, intent(in) :: tkdry(nlevgrnd) 
  real, intent(in) :: csol(nlevgrnd)  
  real, intent(in) :: tk (nlevgrnd)   
  real, intent(in) :: cv (nlevgrnd)   
  real, intent(in) :: ems             

  
  real :: t_grnd               
  real :: h2osoi_liq(nlevgrnd) 
  real :: h2osoi_ice(nlevgrnd) 
  real :: hs_top               
  real :: dhsdT                
  real :: dlwrad_emit          
  real :: lwrad_emit           
  real :: at (1:nlevgrnd)      
  real :: bt (1:nlevgrnd)      
  real :: ct (1:nlevgrnd)      
  real :: rt (1:nlevgrnd)      
  real :: fn (1:nlevgrnd)      
  real :: fn1(1:nlevgrnd)      
  real :: dzm                  
  real :: dzp                  
  real :: fact(1:nlevgrnd)     
  real :: emg                  

  real :: cnfac = 0.5          
  real :: capr = 0.34          
  integer :: j

  t_grnd = t_soisno(1)
  do j = 1, nlevgrnd
      h2osoi_ice(j) = 0.
      h2osoi_liq(j) = h2osoi_vol(j)*( dz(j)*denh2o ) 
  enddo

  
  emg = ems  
  lwrad_emit  =    emg * sb * t_grnd**4
  dlwrad_emit = 4.*emg * sb * t_grnd**3  
  
  hs_top = sabg + dlrad - (eflx_sh_grnd+qflx_ev_grnd*hvap)
  

  dhsdt = - cgrnd - dlwrad_emit
  

  
  
  

  
  do j = 1,nlevgrnd
      if (j == 1) then
          fact(j) = dtime/cv(j) * dz(j) / (0.5*(z(j)-zi(j-1)+capr*(z(j+1)-zi(j-1)))) 
          fn(j)   = tk(j)*(t_soisno(j+1)-t_soisno(j))/(z(j+1)-z(j))
      else if ( j <= nlevgrnd-1) then
          fact(j) = dtime/cv(j)
          fn(j)   = tk(j)*(t_soisno(j+1)-t_soisno(j))/(z(j+1)-z(j))
          dzm     = z(j)-z(j-1)
      else if (j == nlevgrnd) then
          fact(j) = dtime/cv(j)
          fn(j) = 0.
      end if
  enddo


  
  do j = 1,nlevgrnd
      if (j == 1) then
          dzp   = z(j+1)-z(j)
          at(j) = 0.
          bt(j) = 1+(1.-cnfac)*fact(j)*tk(j)/dzp-fact(j)*dhsdT
          ct(j) = -(1.-cnfac)*fact(j)*tk(j)/dzp
          rt(j) = t_soisno(j) + fact(j)*( hs_top - dhsdT*t_soisno(j) + cnfac*fn(j) ) 
      else if (j <= nlevgrnd-1) then
          dzm   = z(j)-z(j-1)
          dzp   = z(j+1)-z(j)
          at(j) = - (1.-cnfac)*fact(j)* tk(j-1)/dzm
          bt(j) = 1.+ (1.-cnfac)*fact(j)*(tk(j)/dzp + tk(j-1)/dzm)
          ct(j) = - (1.-cnfac)*fact(j)* tk(j)/dzp
          rt(j) = t_soisno(j) + cnfac*fact(j)*( fn(j) - fn(j-1) )
      else if (j == nlevgrnd) then
          dzm   = z(j)-z(j-1)
          at(j) = - (1.-cnfac)*fact(j)*tk(j-1)/dzm
          bt(j) = 1.+ (1.-cnfac)*fact(j)*tk(j-1)/dzm
          ct(j) = 0.
          rt(j) = t_soisno(j) - cnfac*fact(j)*fn(j-1) + fact(j)*fn(j)
      end if
  enddo

  call Tridiagonal(nlevgrnd, at, bt, ct, rt, t_soisno)

  
  

  end subroutine SoilTemperature



  subroutine SoilThermProp( tk, cv, t_soisno, h2osoi_vol, &
                            dz, zi, z, watsat, tkmg, tkdry, csol )















  use clm_varpar_my, only : denh2o, denice, tfrz, tkwat, tkice, cpice, cpliq, &
                            nlevsoi, nlevgrnd
  implicit none
  
  real, intent(out) :: tk(nlevgrnd) 
  real, intent(out) :: cv(nlevgrnd) 

  
  real, intent(in) :: t_soisno(nlevgrnd)    
  real, intent(in) :: h2osoi_vol(nlevgrnd)  
  real, intent(in) :: dz(0:nlevgrnd)        
  real, intent(in) :: zi(0:nlevgrnd)        
  real, intent(in) :: z(0:nlevgrnd)         
  real, intent(in) :: watsat(nlevgrnd)      
  real, intent(in) :: tkmg(nlevgrnd)        
  real, intent(in) :: tkdry(nlevgrnd)       
  real, intent(in) :: csol(nlevgrnd)        

  
  real :: h2osoi_ice(nlevgrnd) 
  real :: h2osoi_liq(nlevgrnd) 
  real :: dksat                
  real :: dke                  
  real :: fl                   
  real :: satw                 
  real :: thk(nlevgrnd)        
  real :: thk_bedrock = 3.0    
                               
  integer :: j
  
  h2osoi_ice = 0.  

  do j = 1, nlevgrnd
      h2osoi_liq(j) = h2osoi_vol(j)*dz(j)*denh2o 

      satw = (h2osoi_liq(j)/denh2o + h2osoi_ice(j)/denice)/(dz(j)*watsat(j))
      satw = min(1., satw)
      if (satw > 1.e-6) then
          if (t_soisno(j) >= tfrz) then       
              dke = max(0., log10(satw) + 1.0)
          else                                
              dke = satw
          end if
          fl = h2osoi_vol(j) / ( h2osoi_vol(j) + h2osoi_ice(j)/denice/dz(j) )
          dksat = tkmg(j)*tkwat**(fl*watsat(j))*tkice**((1.-fl)*watsat(j))
          thk(j) = dke*dksat + (1.-dke)*tkdry(j)
      else
          thk(j) = tkdry(j)
      endif

      if (j > nlevsoi) thk(j) = thk_bedrock
  enddo

  

  do j = 1,nlevgrnd
      if ( j <= nlevgrnd-1) then
          tk(j) = thk(j)*thk(j+1)*(z(j+1) - z(j)) &
                   /( thk(j)*(z(j+1) - zi(j)) + thk(j+1)*(zi(j) - z(j)) )
      else if (j == nlevgrnd) then
          tk(j) = 0.
      end if
  end do
  
  
 
  do j = 1, nlevgrnd
      cv(j) = csol(j)*(1-watsat(j))*dz(j) + h2osoi_ice(j)*cpice + h2osoi_liq(j)*cpliq
  end do

  end subroutine SoilThermProp



  subroutine Soil_Transpiration_Wetness_Factor( btran, rootr, btran_z, &
                                                ivt, dz, rootfr, sucsat, bsw, watsat, &
                                                h2osoi_vol, t_soisno )

  use clm_varpar_my, only : denh2o, tfrz, smpso, smpsc, nlevgrnd
  implicit none

  real, intent(out) :: btran              
  real, intent(out) :: rootr(nlevgrnd)    

  integer, intent(in) :: ivt
  real, intent(in) :: dz(0:nlevgrnd)        
  real, intent(in) :: rootfr(nlevgrnd)
  real, intent(in) :: sucsat(nlevgrnd)    
  real, intent(in) :: bsw(nlevgrnd)       
  real, intent(in) :: watsat(nlevgrnd)    
  real, intent(in) :: h2osoi_vol(nlevgrnd)
  real, intent(in) :: t_soisno(nlevgrnd)  

  
  real :: h2osoi_liq(nlevgrnd)  
  real :: s_node                
  real :: smp_node              
  real :: rresis(nlevgrnd)      
  real :: eff_porosity, vol_liq, vol_ice
  real :: tmp
  real :: btran_z(nlevgrnd)

  integer :: i













  vol_ice = 0.
  btran = 0.

  tmp = 0.
  btran_z = 0.
  do i = 1, nlevgrnd
  
      h2osoi_liq(i) = h2osoi_vol(i)*dz(i)*denh2o 

      eff_porosity = watsat(i) - vol_ice
      
      vol_liq = min( eff_porosity, h2osoi_vol(i) )
      if (vol_liq <= 0. .or. t_soisno(i) <= tfrz-2.) then
          rootr(i) = 0.
      else
          s_node = max(vol_liq/eff_porosity, 0.01)
          smp_node = max(smpsc(ivt), -sucsat(i)*s_node**(-bsw(i)))
          
          
          rresis(i) = (smp_node - smpsc(ivt))/(smpso(ivt) - smpsc(ivt))
          rresis(i) = min(rresis(i), 1.)

          rootr(i) = rootfr(i)*rresis(i)
          btran = btran + rootr(i)
          btran_z(i) = rootr(i)
      endif

  enddo

  do i = 1, nlevgrnd

      rootr(i) = rootr(i)/btran  
  enddo

  end subroutine Soil_Transpiration_Wetness_Factor



  subroutine spd_porfile(can_u, h, lad_z, can_z, Utop, numcan)
  
  USE clm_varpar_my, only : mxlevcan_wrf, vt, zmax
  implicit none

  integer :: numcan
  real :: h, Utop
  real :: lad_z(mxlevcan_wrf), can_z(mxlevcan_wrf), can_u(mxlevcan_wrf)

  real :: d0
  real :: lad_z_ex(mxlevcan_wrf), can_z_ex(mxlevcan_wrf)
  integer :: i, iv, nn, N
 
  real :: C0, kv, AAu, AAv, AAw, Aq, Cu, alpha, Cg,  &
          Bp, Bd, PrTKE, khigh, klow, Uhigh, Ulow, epson
  real :: maxerr, eps, tmp_out, maxerr1
  real, allocatable, dimension(:) :: z, lad, Lmix, lambda3, aa, bb, cc, dd, Xn
  real, allocatable, dimension(:) :: U, K, dvt, dU
 
  real :: dz
 
  kv = 0.4
  C0 = 0.2  

  d0 = 0.67*h

  do i = 1, numcan
      iv = numcan - i + 1
      lad_z_ex(i) = lad_z(iv)
      can_z_ex(i) = can_z(iv)
  enddo
  can_z_ex(numcan+1) = 1.01*h 
  can_z_ex(numcan+2) = zmax*h
  lad_z_ex(numcan+1) = 0.
  lad_z_ex(numcan+2) = 0.

  
  N = size(vt)
  allocate(lad(N), z(N))

  do i = 1, N
      z(i) = zmax*h/(N-1)*(i-1)
      call to_zk2( z(i), can_z_ex(1:numcan+2), lad_z_ex(1:numcan+2), numcan+2, tmp_out )
      lad(i) = tmp_out
  enddo
  dz = z(2) - z(1)

  
  
  AAu = 2.3
  AAv = 2.1
  AAw = 1.25
  Aq = 0.5*(AAu**2 + AAv**2 + AAw**2)
  Cu = (1./Aq)**2
  
  alpha=0.05
  Cg = (2./alpha)**(2./3.)
  PrTKE = 1.
  Bp = 1.
  Bd = sqrt(Cu)*Cg*Bp + 3./PrTKE
  

  allocate( U(N), K(N) )

  Ulow = 0.
  Uhigh = Utop

  Khigh = 0.5*(AAu**2+AAv**2+AAw**2)
  Klow = 0.001*Khigh

  do i = 1, N
     U(i) = Ulow + (Uhigh - Ulow)/(N-1)*(i-1)
     K(i) = Klow + (Khigh - Klow)/(N-1)*(i-1)
  enddo

  
  
  allocate(Lmix(N), lambda3(N))

  do i = 1, N
      if (z(i)<=h .and. z(i+1)> h) then
          nn = i
         exit 
      endif
  enddo

  Lmix(1:nn-1) = kv/3.*h
  Lmix(nn+1:N) = kv*(z(nn+1:N) - d0) 
  Lmix(nn) = 0.5*(Lmix(nn-1) + Lmix(nn+1))

  lambda3 = -Aq**3*(AAu**2-AAw**2)/(AAw**2-(Aq**2)/3.)*Lmix

  
  eps = 0.1
  maxerr = 1.e6

  allocate( dvt(N), dU(N) )
  allocate( aa(N), bb(N), cc(N), dd(N), Xn(N) )

  do while (.True.)
      if (maxerr < 1.e-3) exit

      
      do i = 1, N
          vt(i) = Cu**0.25 * Lmix(i) * sqrt(abs(K(i)))
      enddo

      
      do i = 2, N
          dvt(i) = (vt(i) - vt(i-1))/dz
          dU(i) = (U(i) - U(i-1))/dz
      enddo
      dvt(1) = dvt(2)
      dU(1) = dU(2)

      
      do i = 1, N
          aa(i) = vt(i)/(dz*dz) - dvt(i)/(2.*dz)
          bb(i) = -vt(i)*2/(dz*dz) - C0*lad(i)*abs(U(i))
          cc(i) = vt(i)/(dz*dz) + dvt(i)/(2.*dz)
          dd(i) = 0.
      enddo

      aa(1) = 0.
      bb(1) = 1.
      cc(1) = -1.
      dd(1) = 0.

      aa(N) = 0.
      bb(N) = 1.
      cc(N) = 0.
      dd(N) = Uhigh

      call Tridiagonal(N, aa, bb, cc, dd, Xn)

      
      U = abs(eps*Xn + (1-eps)*U)

      

      do i = 1, N
          aa(i) = vt(i)/(dz*dz) - dvt(i)/(2.*dz)
          bb(i) = -vt(i)*2/(dz*dz) - Bd*abs(U(i))*C0*lad(i)
          cc(i) = vt(i)/(dz*dz) + dvt(i)/(2.*dz)
          epson = sqrt(2.*K(i))**3/lambda3(i)  
          dd(i) = epson - C0*lad(i)*Bp*abs(U(i))**3 - vt(i)*dU(i)**2
      enddo

      aa(1) = 0.
      bb(1) = 1.
      cc(1) = -1.
      dd(1) = 0.

      aa(N) = 0.
      bb(N) = 1.
      cc(N) = 0.
      dd(N) = khigh

      call Tridiagonal(N, aa, bb, cc, dd, Xn)
      K = abs(eps*Xn + (1-eps)*K)

      maxerr1 = 0.
      do i = 1, N
         if (abs(Xn(i) - K(i)) > maxerr1) then
              maxerr1 = abs(Xn(i) - K(i))
              
         endif
      enddo
      maxerr = maxerr1
      
  enddo

  do i = 1, numcan
      call to_zk2( can_z(i), z, U, N, tmp_out )
      can_u(i) = max(0.1, tmp_out)
  enddo

  end subroutine spd_porfile


 

  subroutine scalar_transfer(can_C, h, lad_z, lai_z, can_z, Ctop, SH_z, SH_grnd, numcan )

  USE clm_varpar_my, only : mxlevcan_wrf, vt, zmax
  implicit none

  integer :: numcan
  real :: h, Ctop
  real :: lad_z(mxlevcan_wrf), lai_z(mxlevcan_wrf), can_z(mxlevcan_wrf), can_C(mxlevcan_wrf), &
          SH_z(mxlevcan_wrf), SH_grnd
 

  real :: lad_z_ex(mxlevcan_wrf), can_z_ex(mxlevcan_wrf), S_z_ex(mxlevcan_wrf)
  integer :: i, iv, nn, N, iter

  real, allocatable, dimension(:) :: z, lad, S, C, aa, bb, cc, dd, Xn, dvt
  real :: maxerr, eps, tmp_out, maxerr1, sum_ts, sum_ts1, dz
  real :: grnd_flux, pr

  pr = 1.3

  grnd_flux = SH_grnd

  sum_ts = 0.
  do i = 1, numcan
      iv = numcan - i + 1
      lad_z_ex(i) = lad_z(iv)
      can_z_ex(i) = can_z(iv)
      S_z_ex(i) = -SH_z(iv)/lai_z(iv)
      sum_ts = sum_ts + SH_z(i)
  enddo

  can_z_ex(numcan+1) = 1.01*h 
  can_z_ex(numcan+2) = zmax*h
  lad_z_ex(numcan+1) = 0.
  lad_z_ex(numcan+2) = 0.
  S_z_ex(numcan+1) = 0.
  S_z_ex(numcan+2) = 0.
  
  
  N = size(vt)
  allocate(lad(N), S(N), z(N))

  sum_ts1 = 0.
  do i = 1, N
      z(i) = zmax*h/(N-1)*(i-1)
      call to_zk2( z(i), can_z_ex(1:numcan+2), lad_z_ex(1:numcan+2), numcan+2, tmp_out )
      lad(i) = tmp_out
      call to_zk2( z(i), can_z_ex(1:numcan+2), S_z_ex(1:numcan+2), numcan+2, tmp_out )
      S(i) = tmp_out
      S(i) = S(i)*lad(i)
      sum_ts1 = sum_ts1 - S(i)
  enddo
  dz = z(2) - z(1)
  sum_ts1 = sum_ts1*dz


  
  S = sum_ts/sum_ts1*S
  

  
  allocate( C(N) )
  C = Ctop
  eps = 0.1
  maxerr = 1.e6

  allocate( dvt(N), aa(N), bb(N), cc(N), dd(N), Xn(N) )

  iter = 0.
  do while (.True.)
      if (iter >50 .or. maxerr < 1.e-4) exit

      
      do i = 2, N
          dvt(i) = pr*(vt(i) - vt(i-1))/dz
      enddo
      dvt(1) = dvt(2)

      
      do i = 1, N
          aa(i) = pr*vt(i)/(dz*dz) - dvt(i)/(2.*dz)
          bb(i) = -pr*vt(i)*2/(dz*dz)
          cc(i) = pr*vt(i)/(dz*dz) + dvt(i)/(2.*dz)
          dd(i) = S(i)
      enddo

      aa(1) = 0.
      bb(1) = 1.
      cc(1) = -1.
      dd(1) = grnd_flux*dz/vt(1)/pr

      aa(N) = 0.
      bb(N) = 1.
      cc(N) = 0.
      dd(N) = C(N-1)

      call Tridiagonal(N, aa, bb, cc, dd, Xn)

      
      C = abs(eps*Xn + (1-eps)*C)

      maxerr1 = 0.
      do i = 1, N
         if (abs(Xn(i) - C(i)) > maxerr1) then
              maxerr1 = abs(Xn(i) - C(i))
              
         endif
      enddo
      maxerr = maxerr1
   
      iter = iter + 1
  enddo

  do i = 1, numcan
      call to_zk2( can_z(i), z, C, N, tmp_out )
      can_C(i) = tmp_out
  enddo
   
  end subroutine scalar_transfer



  subroutine Surface_energy_balance_new(SHg, LEg, t_grnd, rsoil, forc_pbot, &
                                        Rn_grnd, G, tair, qair, &
                                        qsoil, tsoil, spd, sw_grnd )
  use clm_varpar_my , only : sc_p
  implicit none

  real, intent(out) :: SHg 
  real, intent(out) :: LEg
  real, intent(out) :: t_grnd
  

  real, intent(in) :: forc_pbot, Rn_grnd, tair, qair, G, &
                      qsoil, tsoil, spd, sw_grnd

  real :: bsw           
  real :: watsat        
  real :: sucsat        
  
  real :: epsoil, rsoil

  real :: x1, x2, f1, f2

  epsoil = 0.98
  watsat = 0.464
  sucsat = 500.
  bsw = 8.

  x1 = max(263.16,tair-8.)
  x2 = tair + 27.

  call surface_energy_func( f1, x1, LEg, SHg, rsoil, &
                            forc_pbot, Rn_grnd, tair, qair, G, &
                            qsoil, tsoil, spd, epsoil, watsat, sucsat, bsw, sw_grnd)
   
  call surface_energy_func( f2, x2, LEg, SHg, rsoil, &
                            forc_pbot, Rn_grnd, tair, qair, G, &
                            qsoil, tsoil, spd, epsoil, watsat, sucsat, bsw, sw_grnd)

  if (f1*f2 <= 0.) then
      call tgrnd_brent( t_grnd, x1, x2, f1, f2, &
                        LEg, SHg, rsoil, forc_pbot, Rn_grnd, tair, qair, G, &
                        qsoil, tsoil, spd, epsoil, watsat, sucsat, bsw, sw_grnd)
  else

      call surface_energy_func( f2, 0.5*(tair + tsoil), LEg, SHg, rsoil, &
                                forc_pbot, Rn_grnd, tair, qair, G, &
                                qsoil, tsoil, spd, epsoil, watsat, sucsat, bsw, sw_grnd)

  endif
  
  
  
  end subroutine Surface_energy_balance_new



  subroutine surface_energy_func( fval, t_grnd, LEg, SHg, rsoil, &
                                  forc_pbot, Rn_grnd, t_air, q_air, G, &
                                  qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)

  use clm_varpar_my , only : roverg, cpair, hvap, smpmin, sb, sc_p

  implicit none

  real, intent(in) :: forc_pbot, t_grnd, Rn_grnd, t_air, q_air, G, &
                      qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd
  real, intent(out) :: SHg, LEg, fval

  real :: rah, rsoil, rho_air, fac, psit, tg, qsatg, qg_soil, hr
  real :: tmp1, tmp2, tmp3
  
  rho_air = 1.22

  if (t_grnd > t_air) then
  
      rah = 600./spd1  
  else
      rah = 9000./spd1
  endif
  
     
  SHg = rho_air*cpair*(t_grnd - t_air)/rah

  fac  = max( 0.01, min(1., qsoil/watsat) )
  psit = max( -sucsat * fac ** -bsw, smpmin )

  tg = 0.5*t_grnd + 0.5*tsoil

  
  hr = exp(psit/roverg/tg)

  call QSat(tg , forc_pbot, tmp1, tmp2, qsatg, tmp3)

  if ( qsatg > q_air .and. q_air > hr*qsatg ) then
      qg_soil = q_air
  else
      qg_soil = hr*qsatg
  endif

  
  rsoil = exp(11.5-7.5*fac)

  LEg = rho_air*hvap*(qg_soil - q_air)/(rsoil + rah)
  LEg = max(0., LEg)

  fval = Rn_grnd - SHg - LEg + G - epsoil*sb*t_grnd**4

  end subroutine surface_energy_func



  subroutine tgrnd_brent( t_grnd, x1, x2, f1, f2, &
                          LEg, SHg, rsoil, forc_pbot, Rn_grnd, t_air, q_air, G, &
                          qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)
  implicit none

  real, intent(in) :: forc_pbot, Rn_grnd, t_air, q_air, G, &
                      qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd
  real, intent(out) :: t_grnd, SHg, LEg, rsoil

  
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            
  real, parameter :: EPS = 1.e-4       

  

  a = x1
  b = x2
  fa = f1
  fb = f2
  c = b
  fc = fb

  iter = 0
  do
      if(iter == ITMAX) exit

      iter = iter+1
      if((fb > 0. .and. fc > 0.) .or. (fb < 0. .and. fc < 0.))then
          c = a   
          fc = fa
          d = b-a
          e = d
      endif
      if( abs(fc) < abs(fb)) then
          a = b
          b = c
          c = a
          fa = fb
          fb = fc
          fc = fa
      endif
      tol1 = 2.*EPS*abs(b)  
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          t_grnd = b
          call surface_energy_func( fval, b, LEg, SHg, rsoil,  &
                                    forc_pbot, Rn_grnd, t_air, q_air, G, &
                                    qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa 
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q 
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d 
              d = p/q
          else
              d = xm  
              e = d
          endif
      else 
          d = xm
          e = d
      endif

      a = b 
      fa = fb
      if(abs(d) > tol1) then 
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call surface_energy_func( fb, b, LEg, SHg, rsoil, &
                                forc_pbot, Rn_grnd, t_air, q_air, G, &
                                qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)

      if( fb == 0.) exit
  enddo



  t_grnd = b
  fval = fb
  return

  end subroutine tgrnd_brent



  subroutine Surface_energy_balance( eflx_sh_grnd, qflx_ev_grnd, cgrnd, &
                                     rah, rsoil, &
                                     q_air, t_air, rho_air, forc_pbot,  &
                                     h2osoi_grnd, t_grnd, us, coszen, &
                                     dz, bsw, watsat, sucsat )


  use clm_varpar_my , only : denh2o, denice, roverg, cpair, hvap, smpmin
  implicit none

  real, intent(out) :: eflx_sh_grnd 
  real, intent(out) :: qflx_ev_grnd 
  real, intent(out) :: cgrnd        
                                    
  real, intent(out) :: rah          
  real, intent(out) :: rsoil        
  real, intent(in) :: q_air         
  real, intent(in) :: t_air         
  real, intent(in) :: rho_air       
  real, intent(in) :: forc_pbot     
  real, intent(in) :: h2osoi_grnd   
  real, intent(in) :: t_grnd        
  real, intent(in) :: us
  real, intent(in) :: dz            
  real, intent(in) :: bsw           
  real, intent(in) :: watsat        
  real, intent(in) :: sucsat        
  real :: coszen



  
  
  

  
  real :: soilbeta       
  real :: wx, fac, psit, hr
  real :: qg_soil, dqgdT, dummy, qsatg, qsatgdT
  real :: raih, raiw


  real, parameter :: D0 = 2.2e-5   
  real, parameter :: e = 2.718
  real :: D, L 
  real :: thetar
  real :: tmp1, tmp2, tmp3

  

  
  wx   = h2osoi_grnd       
  fac  = max( 0.01, min(1., wx/watsat) )
  psit = -sucsat * fac ** (-bsw)
  psit = max(smpmin, psit)

  
  hr   = exp(psit/roverg/t_grnd)

  call QSat(t_grnd , forc_pbot, tmp1, tmp2, qsatg, qsatgdT)
  if (qsatg > q_air .and. q_air > hr*qsatg) then
     qg_soil = q_air
     dqgdT = 0. 
  else
     qg_soil = hr*qsatg
     dqgdT = hr*qsatgdT
  end if








  
  if ( isnan(us)) then
      rah = 450.
  else
      rah = 45./us
  endif

  
  
  thetar = watsat * (smpmin/(-sucsat))**(-1./bsw)
  D = D0 * watsat**2 * (1. - thetar/watsat)**(2. + 3.*bsw)
  
  L = dz / (e - 1.) * (exp( (1. - fac)**5 ) - 1.)
  rsoil = L/D*0.3
  
  



  raiw = rho_air/(rah + rsoil)
  raih = rho_air*cpair/rah

  
   cgrnd = raih + hvap*raiw*dqgdT  

  qflx_ev_grnd = -raiw*(q_air - qg_soil)  
  eflx_sh_grnd = -raih*(t_air - t_grnd)  




  

  end subroutine Surface_energy_balance



  subroutine Photosynthesis( rs_sun_z, rs_sha_z, ci_sun_z, ci_sha_z, an_sun_z, an_sha_z,  &
                             ac_sun_z, ac_sha_z, aj_sun_z, aj_sha_z, ap_sun_z, ap_sha_z,  &
                             lmr_z, &
                             gs_mol_sun_z, gs_mol_sha_z, psncan, psncan_ac, psncan_aj, gscan, &
                             ivt, forc_pbot, par_sun_z, par_sha_z, tair_z, cair_z_ppm,&
                             tveg_z, qair_z, tlai_z, fsun_z, t10, dayl_factor, btran, rb_z, nrad )
                          
  use clm_varpar_my  , only : po2, mxlevcan_wrf, rgas, tfrz, slatop, leafcn, flnr, c3psn, sc_p
  implicit none

  integer, intent(in) :: ivt          
  integer, intent(in) :: nrad         
  
  real, intent(in) :: forc_pbot       
  real, intent(in) :: par_sun_z(mxlevcan_wrf) 
  real, intent(in) :: par_sha_z(mxlevcan_wrf) 
  real, intent(in) :: tair_z(mxlevcan_wrf)    
  real, intent(in) :: cair_z_ppm(mxlevcan_wrf)    
  real, intent(in) :: tveg_z(mxlevcan_wrf)    
  real, intent(in) :: qair_z(mxlevcan_wrf)    
  real, intent(in) :: tlai_z(mxlevcan_wrf)    
  real, intent(in) :: fsun_z(mxlevcan_wrf)    
  real, intent(in) :: t10             
  real, intent(in) :: dayl_factor     
  real, intent(in) :: btran           
  real, intent(in) :: rb_z(mxlevcan_wrf)      

  
  real, intent(out) :: rs_sun_z(mxlevcan_wrf)   
  real, intent(out) :: rs_sha_z(mxlevcan_wrf)   
  real, intent(out) :: ci_sun_z(mxlevcan_wrf)   
  real, intent(out) :: ci_sha_z(mxlevcan_wrf)   
  real, intent(out) :: an_sun_z(mxlevcan_wrf)   
  real, intent(out) :: an_sha_z(mxlevcan_wrf)   
  real, intent(out) :: ac_sun_z(mxlevcan_wrf)  
  real, intent(out) :: ac_sha_z(mxlevcan_wrf) 
  real, intent(out) :: aj_sun_z(mxlevcan_wrf)  
  real, intent(out) :: aj_sha_z(mxlevcan_wrf)  
  real, intent(out) :: ap_sun_z(mxlevcan_wrf) 
  real, intent(out) :: ap_sha_z(mxlevcan_wrf) 
  real, intent(out) :: gs_mol_sun_z(mxlevcan_wrf) 
  real, intent(out) :: gs_mol_sha_z(mxlevcan_wrf) 


  real :: psncan 
  
  real :: lmr_z(mxlevcan_wrf) 
  real :: rh_leaf       
  real :: oair          

  
  real :: vcmax_z(mxlevcan_wrf) 
  real :: jmax_z(mxlevcan_wrf)  
  real :: tpu_z(mxlevcan_wrf)   
  real :: kp_z(mxlevcan_wrf)    

  real :: lnc        
  
  real :: kc_z(mxlevcan_wrf) 
  real :: ko_z(mxlevcan_wrf) 
  real :: cp_z(mxlevcan_wrf) 
  real :: bbbopt     
  real :: bbb        
  real :: mbbopt     
  real :: mbb        
  real :: kn         
  real :: vcmax25top 
  real :: jmax25top  
  real :: tpu25top   
  real :: lmr25top   
  real :: kp25top    

  real :: vcmax25    
  real :: jmax25     
  real :: tpu25      
  real :: lmr25      
  real :: kp25       
  real :: kc25       
  real :: ko25       
  real :: cp25       

  real :: vcmaxha    
  real :: jmaxha     
  real :: tpuha      
  real :: lmrha      
  real :: kcha       
  real :: koha       
  real :: cpha       

  real :: vcmaxhd    
  real :: jmaxhd     
  real :: tpuhd      
  real :: lmrhd      

  real :: vcmaxse    
  real :: jmaxse     
  real :: tpuse      
  real :: lmrse      

  real :: vcmaxc     
  real :: jmaxc      
  real :: tpuc       
  real :: lmrc       

  
  real :: esat_tv    
  real :: cf         
  real :: rsmax0     
  real :: cs1        
  real :: cs2        
  real :: hs1        
  real :: hs2        
 
  real :: sco        
  real :: ft         
  real :: fth        
  real :: fth25      
  real :: tl         
  real :: ha         
  real :: hd         
  real :: se         
  real :: cc         
  real :: ciold      
  real :: gs_mol_err1
  real :: gs_mol_err2

  real :: fnr        
  real :: act25      
  integer  :: niter  
  real :: nscaler    

  real :: gb_mol         

  real :: laican         
  real :: rh_can

  real :: cair_z(mxlevcan_wrf)    
  logical :: c3flag       
 
  integer :: iv, iter
  real :: dummy, eair, forc_pbot1
  real :: psncan_sun, psncan_sha
  real :: psncan_ac_sun, psncan_ac_sha
  real :: psncan_aj_sun, psncan_aj_sha
  real :: psncan_ac, psncan_aj
  real :: tlai_sun, tlai_sha
  real :: rs, rb, gscan, gscan_sun, gscan_sha
  real :: tmp1, tmp2, tmp3


  
  
 
  ft(tl,ha) = exp( ha / (rgas*1.e-3*(tfrz+25.)) * (1. - (tfrz+25.)/tl) )
  fth(tl,hd,se,cc) = cc / ( 1. + exp( (-hd+se*tl) / (rgas*1.e-3*tl) ) )    
  fth25(hd,se) = 1. + exp( (-hd+se*(tfrz+25.)) / (rgas*1.e-3*(tfrz+25.)) ) 

  
  if ( c3psn(ivt) == 1.0 ) then
      c3flag = .true.
  else
      c3flag = .false.
  endif

  
  
  
  
  

  

  
  
  
  
  
  
  
  
  

  oair = 0.210 * forc_pbot
  
  cair_z = 379. * forc_pbot * 1.e-6

  kcha = 79430.
  koha = 36380.
  cpha = 37830.

  kc25 = (404.9 / 1.e6) * forc_pbot
  ko25 = (278.4 / 1.e3) * forc_pbot
  
  
  
  cp25 = (42.75 / 1.e6) * forc_pbot
  
  do iv = 1, nrad
      
      kc_z(iv) = kc25 * ft(tveg_z(iv), kcha)
      ko_z(iv) = ko25 * ft(tveg_z(iv), koha)
      cp_z(iv) = cp25 * ft(tveg_z(iv), cpha)
      
      
      

  enddo
  


  
  
  

  
  
  
  
  
  vcmax25top = 55.  
  
  
  jmax25top = (2.59 - 0.035*min(max((t10-tfrz),11.),35.)) * vcmax25top  
  tpu25top = 0.167 * vcmax25top
  kp25top = 20000. * vcmax25top  

  
  if (c3flag) then
      lmr25top = 0.015 * vcmax25top
  else
      lmr25top = 0.025 * vcmax25top
  end if
  

  
  
  
  
  

  vcmaxha = 72000.
  jmaxha  = 50000.
  tpuha   = 72000.
  lmrha   = 46390.

  
  
  

  vcmaxhd = 200000.
  jmaxhd  = 200000.
  tpuhd   = 200000.
  lmrhd   = 150650.
  lmrse   = 490.
  lmrc   = fth25 (lmrhd, lmrse)
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  kn = 0.22 
  


  
  

  laican = 0.
  do iv = 1, nrad

      
      

      
      
      if (iv == 1) then
          laican = 0.5 * tlai_z(iv)
      else
          laican = laican + 0.5 * (tlai_z(iv-1)+tlai_z(iv))
      end if
      nscaler = exp(-kn * laican)

      

      lmr25 = lmr25top * nscaler
      if (c3flag) then
          lmr_z(iv) = lmr25 * ft(tveg_z(iv), lmrha) * fth(tveg_z(iv), lmrhd, lmrse, lmrc)
          
      else
          lmr_z(iv) = lmr25 * 2.**((tveg_z(iv)-(tfrz+25.))/10.) &
                            / (1. + exp( 1.3*(tveg_z(iv)-(tfrz+55.)) ))
      end if
      

      if (par_sun_z(iv) <= 0.) then           

         vcmax_z(iv) = 0.
         jmax_z(iv) = 0.
         tpu_z(iv) = 0.
         kp_z(iv) = 0.

     else                                 

         vcmax25 = vcmax25top * nscaler
         
         if (c3flag) then

             
             vcmaxse = 668.39 - 1.07 * min(max((t10-tfrz),11.),35.)
             jmaxse  = 659.70 - 0.75 * min(max((t10-tfrz),11.),35.)
             tpuse   = vcmaxse

             jmax25 = jmax25top * nscaler
             tpu25 = tpu25top * nscaler

             vcmaxc = fth25 (vcmaxhd, vcmaxse)
             jmaxc  = fth25 (jmaxhd, jmaxse)
             tpuc   = fth25 (tpuhd, tpuse)

             vcmax_z(iv) = vcmax25 * ft(tveg_z(iv), vcmaxha) &
                                   * fth(tveg_z(iv), vcmaxhd, vcmaxse, vcmaxc)
             jmax_z(iv)  = jmax25  * ft(tveg_z(iv), jmaxha) &
                                   * fth(tveg_z(iv), jmaxhd, jmaxse, jmaxc)
             tpu_z(iv)   = tpu25   * ft(tveg_z(iv), tpuha) &
                                   * fth(tveg_z(iv), tpuhd, tpuse, tpuc)

         else

             vcmax_z(iv) = vcmax25 * 2.**((tveg_z(iv)-(tfrz+25.))/10.) &
                                   / (1. + exp( 0.2*((tfrz+15.)-tveg_z(iv)) )) &
                                   / (1. + exp( 0.3*(tveg_z(iv)-(tfrz+40.)) ))
             kp25 = kp25top * nscaler
             kp_z(iv) = kp25 * 2.**((tveg_z(iv)-(tfrz+25.))/10.)

         end if
 
     end if


  end do       

  
  
  

  if (c3flag) then
     bbbopt = 10000.
     mbbopt = 9.
     bbbopt = 20000.  
     mbbopt = 16.5 
  else
     bbbopt = 40000.
     mbbopt = 4.
  end if

  
  bbb = max(bbbopt*btran, 1.)
  
  mbb = mbbopt

  
  
  
  

  rsmax0 = 2.5e4
  
 
  ac_sun_z = 0.
  aj_sun_z = 0.
  ap_sun_z = 0.
  an_sun_z = 0.
  
  do iv = 1, nrad

      cf = forc_pbot/(rgas*tair_z(iv))*1.e09  

      if (par_sun_z(iv) <= 0.) then           

          an_sun_z(iv) = - lmr_z(iv)*btran
          rs_sun_z(iv) = min(rsmax0, 1./bbb * cf)
          ci_sun_z(iv) = 0.

      else                                     

          
          gb_mol = 1./rb_z(iv) * cf

          call QSat (tveg_z(iv), forc_pbot, esat_tv, tmp1, tmp2, tmp3)
          eair = qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198)
          eair = min( eair,  esat_tv )
          

          
          if (c3flag) then
              ci_sun_z(iv) = 0.7 * cair_z(iv)
          else
              ci_sun_z(iv) = 0.4 * cair_z(iv)
          end if

          
          call hybrid( ci_sun_z(iv), gs_mol_sun_z(iv), an_sun_z(iv),   &
                       ac_sun_z(iv), aj_sun_z(iv), ap_sun_z(iv),       &
                       vcmax_z(iv), cp_z(iv), kc_z(iv), ko_z(iv),      &
                       jmax_z(iv), par_sun_z(iv), tpu_z(iv), kp_z(iv), &
                       lmr_z(iv), cair_z(iv), oair, eair, esat_tv, forc_pbot,   &
                       gb_mol, mbbopt, bbbopt, btran, c3flag )

          
          rs_sun_z(iv) = min(cf / gs_mol_sun_z(iv), rsmax0)

      end if    


      if (par_sha_z(iv) <= 0.) then           

          an_sha_z(iv) = - lmr_z(iv)*btran
          rs_sha_z(iv) = min(rsmax0, 1./bbb * cf)
          ci_sha_z(iv) = 0.

      else                                     

          
          gb_mol = 1./rb_z(iv) * cf

          call QSat (tveg_z(iv), forc_pbot, esat_tv, tmp1, tmp2, tmp3)
          eair = qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198)
          eair = min( eair,  esat_tv )
          

          
          if (c3flag) then
              ci_sha_z(iv) = 0.7 * cair_z(iv)
          else
              ci_sha_z(iv) = 0.4 * cair_z(iv)
          end if

          
          call hybrid( ci_sha_z(iv), gs_mol_sha_z(iv), an_sha_z(iv),   &
                       ac_sha_z(iv), aj_sha_z(iv), ap_sha_z(iv),       &
                       vcmax_z(iv), cp_z(iv), kc_z(iv), ko_z(iv),      &
                       jmax_z(iv), par_sha_z(iv), tpu_z(iv), kp_z(iv), &
                       lmr_z(iv), cair_z(iv), oair, eair, esat_tv, forc_pbot,   &
                       gb_mol, mbbopt, bbbopt, btran, c3flag )

          
          rs_sha_z(iv) = min(cf / gs_mol_sha_z(iv), rsmax0)

      end if    

  end do        

  end subroutine Photosynthesis



  subroutine Photosynthesis_new( gs_sun_z, gs_sha_z, An_sun_z, An_sha_z, &
                                 Ag_sun_z, Ag_sha_z, &
                                 forc_pbot, tair_z, qair_z, cair_z, &
                                 tc_sun_z, tc_sha_z, fsun_z, lai_z, rb_z, & 
                                 par_sun_z, par_sha_z, numcan ) 

  use clm_varpar_my  , only : po2, mxlevcan_wrf, rgas, sc_p
  implicit none

  integer, intent(in) :: numcan        
  real, intent(in) :: forc_pbot       
  real, intent(in) :: tair_z(mxlevcan_wrf)    
  real, intent(in) :: qair_z(mxlevcan_wrf)    
  real, intent(in) :: cair_z(mxlevcan_wrf)    
  real, intent(in) :: rb_z(mxlevcan_wrf)      

  real, intent(in) :: tc_sun_z(mxlevcan_wrf)
  real, intent(in) :: tc_sha_z(mxlevcan_wrf)
  real, intent(in) :: fsun_z(mxlevcan_wrf)    
  real, intent(in) :: lai_z(mxlevcan_wrf)  
  real, intent(in) :: par_sun_z(mxlevcan_wrf) 
  real, intent(in) :: par_sha_z(mxlevcan_wrf) 

  real, intent(out) :: gs_sun_z(mxlevcan_wrf) 
  real, intent(out) :: gs_sha_z(mxlevcan_wrf) 
  real, intent(out) :: An_sun_z(mxlevcan_wrf) 
  real, intent(out) :: An_sha_z(mxlevcan_wrf) 
  real, intent(out) :: Ag_sun_z(mxlevcan_wrf) 
  real, intent(out) :: Ag_sha_z(mxlevcan_wrf) 

  
  real :: ci_sun_z(mxlevcan_wrf)   
  real :: ci_sha_z(mxlevcan_wrf)   


  real :: kn         
  real :: vcmax25top 
  real :: lmr25, lmr   

  real :: vcmax25    

  real :: cf         
  real :: g0         
  real :: m          
  real :: tlai
  real :: esat_sun_tv, esat_sha_tv, eair  
  real :: cair       
  real :: gb_mol, gs_mol, ci, An, Ag

  integer :: iv
  real :: tmp1, tmp2, tmp3

  integer :: opt 

  
  real :: ft         
  real :: fth        
  real :: tc         
  real :: ha         
  real :: hd         
  real :: se         

  ft(tc, ha) = exp( ha / (rgas*1.e-3*298.15) * (1. - 298.15/tc) )

  fth(tc, hd, se) = ( 1. + exp((se*298.15 - hd)/(rgas*1.e-3*298.15)) ) / &
                      ( 1. + exp((se*tc - hd)/(rgas*1.e-3*tc)) ) 
  

  
  
  
  opt = 2;  m = 4.4;   g0 = 0.02   
  
  
  

  
  
  vcmax25top = 64.  
  kn = 0.1





























  tlai = 0.
  do iv = 1, numcan
      
      if (iv == 1) then
          tlai = 0.5 * lai_z(iv)
      else
          tlai = tlai + 0.5 * (lai_z(iv-1)+lai_z(iv))
      end if

      vcmax25 =  vcmax25top*exp(-kn*tlai)

      call QSat (tc_sun_z(iv), forc_pbot, esat_sun_tv, tmp1, tmp2, tmp3)
      call QSat (tc_sha_z(iv), forc_pbot, esat_sha_tv, tmp1, tmp2, tmp3)



      eair = min( qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198), esat_sha_tv)
      cair = cair_z(iv) * forc_pbot * 1.e-6 



      cf = forc_pbot/(rgas*tair_z(iv))*1.e03 




      gb_mol = (1./rb_z(iv))*cf  
 
      if (par_sun_z(iv) > 0.) then

          call find_ci( ci, gs_mol, An, Ag, &
                        forc_pbot, cair, eair, esat_sun_tv, tc_sun_z(iv), par_sun_z(iv), &
                        gb_mol, g0, m, vcmax25, opt )

          gs_sun_z(iv) = gs_mol/cf  
          ci_sun_z(iv) = ci
          An_sun_z(iv) = An
          Ag_sun_z(iv) = Ag
      else
          gs_sun_z(iv) = g0/cf
          ci_sun_z(iv) = 0.

          lmr25 = 0.015*vcmax25  
          lmr = lmr25 * ft(tc_sun_z(iv), 46390.) * fth(tc_sun_z(iv), 150650., 490.)
          An_sun_z(iv) = - lmr
          Ag_sun_z(iv) = 0.
      endif

      if (par_sha_z(iv) > 0.) then

          call find_ci( ci, gs_mol, An, Ag, &
                        forc_pbot, cair, eair, esat_sha_tv, tc_sha_z(iv), par_sha_z(iv), &
                        gb_mol, g0, m, vcmax25, opt )

          gs_sha_z(iv) = gs_mol/cf  
          ci_sha_z(iv) = ci
          An_sha_z(iv) = An
          Ag_sha_z(iv) = Ag
      else
          gs_sha_z(iv) = g0/cf  
          ci_sha_z(iv) = 0.

          lmr25 = 0.015*vcmax25  
          lmr = lmr25 * ft(tc_sha_z(iv), 46390.) * fth(tc_sun_z(iv), 150650., 490.)
          An_sha_z(iv) = - lmr
          Ag_sha_z(iv) = 0.
      endif

      An_sun_z(iv) = An_sun_z(iv) * lai_z(iv) * fsun_z(iv)
      An_sha_z(iv) = An_sha_z(iv) * lai_z(iv) * (1.- fsun_z(iv))

      Ag_sun_z(iv) = Ag_sun_z(iv) * lai_z(iv) * fsun_z(iv)
      Ag_sha_z(iv) = Ag_sha_z(iv) * lai_z(iv) * (1. - fsun_z(iv))
  enddo
 
  end subroutine Photosynthesis_new



  subroutine find_ci( ci, gs_mol, An, Ag, &
                      forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25, opt )

  implicit none

  integer, intent(in) :: opt 
  real, intent(in) :: forc_pbot, cair, eair, esat_tv  
  real, intent(in) :: tc   
  real, intent(in) :: par   
  real, intent(in) :: gb_mol  
  real, intent(in) :: g0  
  real, intent(in) :: m   
  real, intent(in) :: vcmax25   
   
  real, intent(out) :: ci     
  real, intent(out) :: gs_mol 
  real, intent(out) :: An, Ag     

  
  real :: eps, eps1
  real :: x1, f0, f1, x ,dx, tol, minx, minf, x0 
  integer :: iter
  integer, parameter :: ITMAX = 20            

  eps = 1.e-2 
  eps1 = 1.e-4
  x0 = 0.7*cair

  call ci_func_new( f0, x0, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv, &
                    tc, par, gb_mol, g0, m, vcmax25, opt )

  if(f0 == 0.) then
      ci = x0
      return
  endif

  minx = x0
  minf = f0
  x1 = x0 * 0.99
  call ci_func_new( f1, x1, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv, &
                    tc, par, gb_mol, g0, m, vcmax25, opt )
  if(f1 == 0.) then
      x0 = x1
      ci = x0
      return
  endif
  if(f1 < minf)then
     minx = x1
     minf = f1
  endif

 
  iter = 0
  do
      iter = iter + 1
      dx = - f1 * (x1-x0)/(f1-f0)
      x = x1 + dx
      tol = abs(x) * eps
      if(abs(dx)<tol)then
          x0 = x
          exit
      endif
      x0 = x1
      f0 = f1
      x1 = x
      call ci_func_new( f1, x1, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv, &
                        tc, par, gb_mol, g0, m, vcmax25, opt )
      if(f1<minf)then
          minx = x1
          minf =f1
      endif
      if(abs(f1)<=eps1)then
          x0 = x1
          exit
      endif

      
      if(f1 * f0 < 0.)then
          call ci_brent( x, x0, x1, f0, f1, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv,&
                         tc, par, gb_mol, g0, m, vcmax25, opt )
          x0 = x
          exit
      endif

      if(iter>itmax)then
          
          
          
          
          call ci_func_new( f1, minx, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv, &
                            tc, par, gb_mol, g0, m, vcmax25, opt )
          x0 = minx
          exit
      endif
  enddo
  ci = x0

  end subroutine find_ci



  subroutine ci_func_new( fval, ci, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                          tc, par, gb_mol, g0, m, vcmax25, opt )

  implicit none

  real, intent(in) :: ci, forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25
  integer, intent(in) :: opt 
  real, intent(out) :: fval, An, gs, Ag

  real :: cs, cp, cs1, cp1, fb
  real :: aquad, bquad, cquad, r1, r2

  call Farquhar(An, Ag, ci, cp, forc_pbot, tc, par, vcmax25)

  if (An <= 0.) then
      fval = 0.
      gs = g0
      return
  endif

  cs = cair - 1.4/gb_mol*An*forc_pbot/1.e6
  cs1 = cs/forc_pbot*1.e6  
  cp1 = cp/forc_pbot*1.e6  

  call gs_brent(gs, g0, m, gb_mol, An, cs1, eair, esat_tv, cp1, opt)
  
  
  
  
  
  
  

  

  fval = (cair - (1.4/gb_mol + 1.6/gs)*An*forc_pbot/1.e6 - ci)/cair

  end subroutine ci_func_new



  subroutine ci_brent( ci, x1, x2, f1, f2, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                       tc, par, gb_mol, g0, m, vcmax25, opt )
  implicit none

  real, intent(in) :: forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25
  integer, intent(in) :: opt 
  real, intent(out) :: ci, gs, An, Ag

  
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            
  real, parameter :: EPS = 1.e-3       

  

  a = x1
  b = x2
  fa = f1
  fb = f2
  c = b
  fc = fb

  iter = 0
  do
      if(iter == ITMAX) exit

      iter = iter+1
      if((fb > 0. .and. fc > 0.) .or. (fb < 0. .and. fc < 0.))then
          c = a   
          fc = fa
          d = b-a
          e = d
      endif
      if( abs(fc) < abs(fb)) then
          a = b
          b = c
          c = a
          fa = fb
          fb = fc
          fc = fa
      endif
      tol1 = 2.*EPS*abs(b)  
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          ci = b
          call ci_func_new( fval, b, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                            tc, par, gb_mol, g0, m, vcmax25, opt )
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa 
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q 
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d 
              d = p/q
          else
              d = xm  
              e = d
          endif
      else 
          d = xm
          e = d
      endif

      a = b 
      fa = fb
      if(abs(d) > tol1) then 
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call ci_func_new( fb, b, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                        tc, par, gb_mol, g0, m, vcmax25, opt )

      if( fb == 0.) exit
  enddo



  ci = b
  fval = fb
  return

  end subroutine ci_brent



  subroutine gs_brent(gs, g0, m, gb, An, cs, eair, esat_tv, cp, opt)

  implicit none

  real, intent(in) :: g0, m, gb, An, cs, eair, esat_tv, cp
  integer, intent(in) :: opt 
  real, intent(out) :: gs

  
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            
  real, parameter :: EPS = 1.e-6       

  
  x1 = 0.001
  x2 = 2.0

  call gs_func(f1, x1, g0, m, gb, An, cs, eair, esat_tv, cp, opt)
  call gs_func(f2, x2, g0, m, gb, An, cs, eair, esat_tv, cp, opt)

  a = x1
  b = x2
  fa = f1
  fb = f2
  c = b
  fc = fb

  if((fa > 0. .and. fb > 0.).or.(fa < 0. .and. fb < 0.))then
      write(*,*) 'root must be bracketed for brent in gs_func ', fa, fb
      write(*,*) 'x1, x2, An', x1, x2, An
      gs = g0
      fval = 0.
      return
  endif

  iter = 0
  do
      if(iter == ITMAX) exit

      iter = iter+1
      if((fb > 0. .and. fc > 0.) .or. (fb < 0. .and. fc < 0.))then
          c = a   
          fc = fa
          d = b-a
          e = d
      endif
      if( abs(fc) < abs(fb)) then
          a = b
          b = c
          c = a
          fa = fb
          fb = fc
          fc = fa
      endif
      tol1 = 2.*EPS*abs(b)  
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          gs = b
          call gs_func(fval, b, g0, m, gb, An, cs, eair, esat_tv, cp, opt)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa 
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q 
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d 
              d = p/q
          else
              d = xm  
              e = d
          endif
      else 
          d = xm
          e = d
      endif

      a = b 
      fa = fb
      if(abs(d) > tol1) then 
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call gs_func(fb, b, g0, m, gb, An, cs, eair, esat_tv, cp, opt)

      if( fb == 0.) exit
  enddo



  gs = b
  fval = fb
  return

  end subroutine gs_brent



  subroutine gs_func(fval, gs, g0, m, gb, An, cs, eair, esat_tv, cp, opt)
  implicit none
  real, intent(in) :: gs, g0, gb, An, cs, eair, esat_tv, cp
  integer, intent(in) :: opt 
  real, intent(out) :: fval

  

  real :: m  
  real :: es, hs, Ds, D0

  es = (esat_tv*gs + eair*gb)/(gs+gb)
  hs = es/esat_tv  
  Ds = max( (esat_tv - es)*1.e-3, 0.01 )  
  
  

  if (opt == 1) then   
      
      fval = gs - g0 - m*An*hs/cs
  endif

  if (opt == 2) then   
      
      D0 = 1.5  
      fval = gs - g0 - m*An/(cs-cp)/(1.+Ds/D0)
  endif

  if (opt == 3) then   
      
      fval = gs - g0 - 1.6*(1 + m/sqrt(Ds))*An/cs
  endif

  end subroutine gs_func



  subroutine Farquhar(an, ag, ci, cp, forc_pbot, tc, par, vcmax25)

  use clm_varpar_my  , only : rgas, sc_p

  implicit none

  real, intent(in) :: ci, forc_pbot, tc, par, vcmax25
  real, intent(out) :: an, ag
  

  real :: jmax25     
  real :: tpu25      
  real :: lmr25      
  real :: cp25       
  real :: kp25       
  real :: kc25       
  real :: ko25       

  real :: oair, cp, kc, ko  
  real :: vcmax, jmax, tpu, lmr  
  real :: PAR_mol, eff_PAR, je
  real :: alphaj  
  real :: ac, aj, ap, ai, ci1

  
  real :: ft         
  real :: fth        
  real :: ha         
  real :: hd         
  real :: se         

  ft(tc, ha) = exp( ha / (rgas*1.e-3*298.15) * (1. - 298.15/tc) )

  fth(tc, hd, se) = ( 1. + exp((se*298.15 - hd)/(rgas*1.e-3*298.15)) ) / &
                      ( 1. + exp((se*tc - hd)/(rgas*1.e-3*tc)) ) 
  

  jmax25 = 1.97*vcmax25
  tpu25  = 0.167*vcmax25
  lmr25  = 0.015*vcmax25

  oair = 0.21 * forc_pbot  

  cp25 = (42.75 * 1.e-6) * forc_pbot    
  kc25 = (404.9 * 1.e-6) * forc_pbot    
  ko25 = (278.4 * 1.e-3) * forc_pbot    

  
  cp = cp25*ft(tc, 37830.)
  kc = kc25*ft(tc, 79430.)
  ko = ko25*ft(tc, 36380.)

  
  vcmax = vcmax25 * ft(tc, 65330.) * fth(tc, 149250., 485.)
  jmax = jmax25 * ft(tc, 43540.) * fth(tc, 152040., 495.) 
  tpu = tpu25 * ft(tc, 65330.) * fth(tc, 149250., 485.)
  lmr = lmr25 * ft(tc, 46390.) * fth(tc, 150650., 490.)

  
  PAR_mol = 4.6*PAR    
  alphaj = 0.48  
  
  
  eff_PAR = alphaj * PAR_mol  

  
  je =  ( eff_PAR + jmax - sqrt( (eff_PAR + jmax)**2 - 4.*eff_PAR*jmax*0.7 ) )/(2.*0.7)
  
  
  ac = vcmax * max(ci-cp, 0.) / (ci + kc*(1.+oair/ko)) 
  aj = 0.25*je * max(ci-cp, 0.) / (ci+2.*cp)           
  ap = 3.*tpu  

  ai = (ac + aj - sqrt( (ac + aj)**2 - 4.*ac*aj*0.98 ) )/(2.*0.98)
  ag = (ai + ap - sqrt( (ai + ap)**2 - 4.*ai*ap*0.95 ) )/(2.*0.95)
 
  ag = max(0., ag)
  an = ag - lmr
  
  end subroutine Farquhar



  subroutine hybrid( x0, gs_mol, an, ac, aj, ap,                               &
                     vcmax_z, cp, kc, ko, jmax_z, par_z, tpu_z, kp_z,          &
                     lmr_z, cair, oair, eair, esat_tv, forc_pbot,              &
                     gb_mol, mbb, bbb, btran, c3flag )












  implicit none
  real, intent(inout) :: x0      
  real, intent(out) :: gs_mol    
  real, intent(out) :: an        

  real, intent(in) :: jmax_z     
  real, intent(in) :: lmr_z      
  real, intent(in) :: par_z      
  real, intent(in) :: gb_mol     
  real, intent(in) :: cair       
  real, intent(in) :: oair       
  real, intent(in) :: eair       
  real, intent(in) :: esat_tv    
  logical, intent(in) :: c3flag  
  real, intent(in)  :: vcmax_z   
  real, intent(in)  :: cp        
  real, intent(in)  :: kc        
  real, intent(in)  :: ko        
  real, intent(in)  :: tpu_z     
  real, intent(in)  :: kp_z      
  real, intent(in)  :: forc_pbot 
  real, intent(in)  :: bbb       
  real, intent(in)  :: mbb        
  real, intent(in) :: btran           

  real :: ac   
  real :: aj   
  real :: ap   

  real :: je          
  real :: fnps        
  real :: theta_psii  

  
  real :: x1, f0, f1, x ,dx, tol, minx, minf
  real, parameter :: eps = 1.e-2      
  real, parameter :: eps1= 1.e-4
  integer,  parameter :: itmax = 20   
  integer :: iter
  real :: qabs, aquad, bquad, cquad  
  real :: r1, r2               

  
  
  if (c3flag) then
      
      fnps = 0.85
      theta_psii = 0.7 

      aquad = theta_psii
      qabs  = 0.5 * (1. - fnps) * (par_z * 4.6) 
      bquad = -(qabs + jmax_z)
      cquad = qabs * jmax_z
      call quadratic (aquad, bquad, cquad, r1, r2)
      je = min(r1,r2)
  endif

  call ci_func ( x0, f0, gs_mol, an, ac, aj, ap, &
                 lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                 c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )

  if(f0 == 0.) return

  minx = x0
  minf = f0
  x1 = x0 * 0.99
  call ci_func ( x1, f1, gs_mol, an, ac, aj, ap, &
                 lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                 c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
  if(f1 == 0.) then
      x0 = x1
      return
  endif
  if(f1 < minf)then
     minx = x1
     minf = f1
  endif

 
  iter = 0
  do
      iter = iter + 1
      dx = - f1 * (x1-x0)/(f1-f0)
      x = x1 + dx
      tol = abs(x) * eps
      if(abs(dx)<tol)then
          x0 = x
          exit
      endif
      x0 = x1
      f0 = f1
      x1 = x
      call ci_func ( x1, f1, gs_mol, an, ac, aj, ap, &
                     lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                     c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
      if(f1<minf)then
          minx = x1
          minf =f1
      endif
      if(abs(f1)<=eps1)then
          x0 = x1
          exit
      endif

      
      if(f1 * f0 < 0.)then
          call brent( x, x0, x1, f0, f1, tol, gs_mol, an, ac, aj, ap, &
                      lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                      c3flag, vcmax_z, cp, kc, ko, tpu_z, kp_z, mbb, bbb, btran )
          x0 = x
          exit
      endif

      if(iter>itmax)then
          
          
          
          
          call ci_func ( minx, f1, gs_mol, an, ac, aj, ap, &
                         lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                         c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
          x0 = minx
          exit
      endif
  enddo

  end subroutine hybrid



  subroutine ci_func ( ci, fval, gs_mol, an, ac, aj, ap, &
                       lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                       c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )

  
  
  

  
  
  
  implicit none
  real, intent(in) :: ci                
  real, intent(out) :: fval              
  real, intent(out) :: gs_mol           
  real, intent(out) :: an               

  real, intent(in) :: lmr_z  
  real, intent(in) :: par_z  
  real, intent(in) :: gb_mol 
  real, intent(in) :: cair   
  real, intent(in) :: oair   
  real, intent(in) :: eair       
  real, intent(in) :: esat_tv    

  logical, intent(in) :: c3flag  
  real, intent(in)  :: vcmax_z   
  real, intent(in)  :: cp        
  real, intent(in)  :: kc        
  real, intent(in)  :: ko        
  real, intent(in)  :: tpu_z     
  real, intent(in)  :: kp_z      
  real, intent(in)  :: forc_pbot 
  real, intent(in)  :: bbb       
  real, intent(in)  :: mbb        
  real, intent(in)  :: btran           
  real, intent(in)  :: je        

  real :: qe         
  real :: theta_ip   
  real :: theta_cj   

  
  real :: ac   
  real :: aj   
  real :: ap   
  real :: ag   
  real :: ai   

  real :: cs   
  real :: aquad, bquad, cquad  
  real :: r1, r2               
  real :: vcmax, lmr, b  
  real :: fb, Ds

  real :: sbtran

  

  vcmax = vcmax_z
  lmr   = lmr_z * btran
  
  b = bbb

  if (c3flag) then
      ac = vcmax * max(ci-cp, 0.) / (ci+kc*(1.+oair/ko)) 

      
      aj = 0.25*je * max(ci-cp, 0.) / (ci+2.*cp)             

      ap = 3. * tpu_z       

      theta_cj = 0.98       

      theta_ip = 0.95       
 
  else
      ac = vcmax          

      qe = 0.05             
      aj = qe * par_z * 4.6 

      ap = kp_z * max(ci, 0.) / forc_pbot 

      theta_cj = 0.80       

      theta_ip = 0.95       
  end if

  

  aquad = theta_cj
  bquad = -(ac + aj)
  cquad = ac * aj
  call quadratic (aquad, bquad, cquad, r1, r2)
  ai = min(r1,r2)

  aquad = theta_ip
  bquad = -(ai + ap)
  cquad = ai * ap
  call quadratic (aquad, bquad, cquad, r1, r2)
  ag = min(r1,r2)

  

  an = ag - lmr

  if (an <= 0.) then
      fval = 0.
      gs_mol = b
      return
  endif

  
  

  cs = cair - 1.4/gb_mol * an * forc_pbot
  cs = max(cs,1.e-06)

  
  aquad = cs
  bquad = cs*(gb_mol - b) - mbb*an*forc_pbot
  cquad = -gb_mol*(cs*b + mbb*an*forc_pbot*eair/esat_tv)
  call quadratic (aquad, bquad, cquad, r1, r2)
  gs_mol = max(r1,r2)

  

  







  









  































  

  fval = ci - cair + an * forc_pbot * (1.4*gs_mol+1.6*gb_mol) / (gb_mol*gs_mol)

  end subroutine ci_func




  subroutine brent( x, x1, x2, f1, f2, tol, gs_mol, an, ac, aj, ap, &
                    lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                    c3flag, vcmax_z, cp, kc, ko, tpu_z, kp_z, mbb, bbb, btran )




  implicit none
  real, intent(out) :: x    
  real, intent(out) :: an   
  real :: x1, x2, f1, f2    
  real, intent(out) :: gs_mol           
  real :: tol               
  real, intent(in)  :: mbb        
  real, intent(in) :: btran           

  
  real :: lmr_z             
  real :: par_z             
  real :: gb_mol            
  real :: je                
  real :: cair              
  real :: oair              
  real :: eair       
  real :: esat_tv    
  real :: forc_pbot          

  logical :: c3flag             
  real :: vcmax_z          
  real :: cp                 
  real :: kc                 
  real :: ko                 
  real :: tpu_z              
  real :: kp_z               
  real :: bbb                

  real :: ac   
  real :: aj   
  real :: ap   
  
  integer, parameter :: ITMAX=20            
  real, parameter :: EPS=1.e-2       

  integer :: iter
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm

  a = x1
  b = x2
  fa = f1
  fb = f2
  if((fa > 0. .and. fb > 0.).or.(fa < 0. .and. fb < 0.))then
      write(*,*) 'root must be bracketed for brent'
      STOP
  endif
  c = b
  fc = fb
  iter = 0

  do
      if(iter == ITMAX) exit

      iter = iter+1
      if((fb > 0. .and. fc > 0.) .or. (fb < 0. .and. fc < 0.))then
          c = a   
          fc = fa
          d = b-a
          e = d
      endif
      if( abs(fc) < abs(fb)) then
          a = b
          b = c
          c = a
          fa = fb
          fb = fc
          fc = fa
      endif
      tol1 = 2.*EPS*abs(b) + 0.5*tol  
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          x=b
          
          call ci_func ( b, fb, gs_mol, an, ac, aj, ap, &
                         lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                         c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa 
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q 
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d 
              d = p/q
          else
              d = xm  
              e = d
          endif
      else 
          d = xm
          e = d
      endif

      a = b 
      fa = fb
      if(abs(d) > tol1) then 
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call ci_func ( b, fb, gs_mol, an, ac, aj, ap, &
                     lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                     c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
      if( fb == 0.) exit
  enddo



  x = b
  return

  end subroutine brent



  subroutine quadratic (a, b, c, r1, r2)














   implicit none


   real, intent(in)  :: a,b,c       
   real, intent(out) :: r1,r2       


   real :: q                        


   if (a == 0.) then
      write (*,*) 'Quadratic solution error: a = ',a
      STOP
   end if

   if (b >= 0.) then
      q = -0.5 * (b + sqrt(b*b - 4.*a*c))
   else
      q = -0.5 * (b - sqrt(b*b - 4.*a*c))
   end if

   r1 = q / a
   if (q /= 0.) then
      r2 = c / q
   else
      r2 = 1.e36
   end if

  end subroutine quadratic



  subroutine QSat (T, p, es, esdT, qs, qsdT)








  implicit none
  integer,parameter :: r8 = selected_real_kind(12)
  real, intent(in)  :: T        
  real, intent(in)  :: p        
  real, intent(out) :: es       
  real, intent(out) :: esdT     
  real, intent(out) :: qs       
  real, intent(out) :: qsdT     

  
  
  
  real :: T_limit
  real :: td,vp,vp1,vp2
  
  
  
  real, parameter :: a0 =  6.11213476_r8
  real, parameter :: a1 =  0.444007856_r8
  real, parameter :: a2 =  0.143064234e-01_r8
  real, parameter :: a3 =  0.264461437e-03_r8
  real, parameter :: a4 =  0.305903558e-05_r8
  real, parameter :: a5 =  0.196237241e-07_r8
  real, parameter :: a6 =  0.892344772e-10_r8
  real, parameter :: a7 = -0.373208410e-12_r8
  real, parameter :: a8 =  0.209339997e-15_r8
  
  
  
  real, parameter :: b0 =  0.444017302_r8
  real, parameter :: b1 =  0.286064092e-01_r8
  real, parameter :: b2 =  0.794683137e-03_r8
  real, parameter :: b3 =  0.121211669e-04_r8
  real, parameter :: b4 =  0.103354611e-06_r8
  real, parameter :: b5 =  0.404125005e-09_r8
  real, parameter :: b6 = -0.788037859e-12_r8
  real, parameter :: b7 = -0.114596802e-13_r8
  real, parameter :: b8 =  0.381294516e-16_r8
  
  
  
  real, parameter :: c0 =  6.11123516_r8
  real, parameter :: c1 =  0.503109514_r8
  real, parameter :: c2 =  0.188369801e-01_r8
  real, parameter :: c3 =  0.420547422e-03_r8
  real, parameter :: c4 =  0.614396778e-05_r8
  real, parameter :: c5 =  0.602780717e-07_r8
  real, parameter :: c6 =  0.387940929e-09_r8
  real, parameter :: c7 =  0.149436277e-11_r8
  real, parameter :: c8 =  0.262655803e-14_r8
  
  
  
  real, parameter :: d0 =  0.503277922_r8
  real, parameter :: d1 =  0.377289173e-01_r8
  real, parameter :: d2 =  0.126801703e-02_r8
  real, parameter :: d3 =  0.249468427e-04_r8
  real, parameter :: d4 =  0.313703411e-06_r8
  real, parameter :: d5 =  0.257180651e-08_r8
  real, parameter :: d6 =  0.133268878e-10_r8
  real, parameter :: d7 =  0.394116744e-13_r8
  real, parameter :: d8 =  0.498070196e-16_r8
 

  T_limit = T - 273.15
  if (T_limit > 100.0) T_limit=100.0
  if (T_limit < -75.0) T_limit=-75.0

  td       = T_limit
  if (td >= 0.0) then
     es   = a0 + td*(a1 + td*(a2 + td*(a3 + td*(a4 &
          + td*(a5 + td*(a6 + td*(a7 + td*a8)))))))
     esdT = b0 + td*(b1 + td*(b2 + td*(b3 + td*(b4 &
          + td*(b5 + td*(b6 + td*(b7 + td*b8)))))))
  else
     es   = c0 + td*(c1 + td*(c2 + td*(c3 + td*(c4 &
          + td*(c5 + td*(c6 + td*(c7 + td*c8)))))))
     esdT = d0 + td*(d1 + td*(d2 + td*(d3 + td*(d4 &
          + td*(d5 + td*(d6 + td*(d7 + td*d8)))))))
  endif

  es    = es    * 100.            
  esdT  = esdT  * 100.            

  vp    = 1.0   / (p - 0.378*es)
  vp1   = 0.622 * vp
  vp2   = vp1   * vp

  qs    = es    * vp1             
  qsdT  = esdT  * vp2 * p         

  end subroutine QSat



  subroutine boundary_layer_resistance_rb( rb_z, wind_z, numcan_wrf, ivt )
  
  USE clm_varpar_my, only : dleaf, mxlevcan_wrf, sc_p
  implicit none
  
  integer, intent(in) :: numcan_wrf, ivt
  real, dimension(mxlevcan_wrf), intent(in)  :: wind_z
  real, dimension(mxlevcan_wrf), intent(out) :: rb_z
  real :: dleaf_CHATS, wind

  real :: Cv = 0.01  
  integer :: i
  
  

  dleaf_CHATS = 0.05



  DO i = 1, numcan_wrf

     wind = max(wind_z(i), 0.1)
     
     rb_z(i) = 1./0.005*sqrt(dleaf_CHATS/wind)

     
  ENDDO
  
  end subroutine boundary_layer_resistance_rb



  subroutine Tridiagonal(N, AA, BB, CC, RR, X)










  INTEGER, INTENT(IN) :: N
  REAL, INTENT(IN) :: AA(N), BB(N), CC(N), RR(N)
  REAL, INTENT(INOUT) :: X(N)

  REAL :: A(N), B(N), C(N), R(N)

  INTEGER :: I

  A = AA
  B = BB
  C = CC
  R = RR

  DO I = 2, N
      C(I-1) = C(I-1)/B(I-1)
      R(I-1) = R(I-1)/B(I-1)
      B(I) = B(I)-A(I)*C(I-1)
      R(I) = R(I)-A(I)*R(I-1)
  ENDDO

  X(N) = R(N)/B(N)
  DO I = N-1, 1, -1
      X(I) = R(I)-C(I)*X(I+1)
  ENDDO
  RETURN

  end subroutine Tridiagonal


  subroutine to_zk2_para(obs_v, mdl_v, iz, kk, dz1, dz2 )

  implicit none

  integer                                     :: k, iz, k1
  real,                           intent(in)  :: obs_v
  real, dimension(1:iz),          intent(in)  :: mdl_v
  real                                        :: dz, dzm, zk
  integer , intent(out) :: kk
  real , intent(out) :: dz1, dz2

  dz1 = 1.0
  dz2 = 0.0

  if (obs_v < mdl_v(1) ) then
      kk = 1
      return
  else if (obs_v > mdl_v(iz)) then
      kk = iz
      return
  else
      do k = 1,iz-1
          if(obs_v >= mdl_v(k) .and. obs_v < mdl_v(k+1)) then
              zk = real(k) + (obs_v - mdl_v(k))/(mdl_v(k+1) - mdl_v(k))
              exit
          endif
      enddo
      k1  = int( zk )
      dz  = zk - float( k1 )
      dzm = float( k1+1 ) - zk
      kk = k1;  dz1 = dzm;  dz2 = dz
      
      return
  endif

  end subroutine to_zk2_para





  SUBROUTINE one_to_four_stream_sw_1( coszen, swd, &
                                    sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )
  implicit none
  real, intent(in)  :: coszen, swd
  real, intent(out) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir

  real :: fiv, fv, ru, solar_sine_beta, rdvis, rsvis, &
          wa, rdir, rsdir, rvt, rit, rtt
       
  solar_sine_beta = coszen

    fiv = 0.54   
    fv = 0.46    
    ru = 1./solar_sine_beta

    
    rdvis = 624.0 * exp(-.185 * ru) * solar_sine_beta

    
    rsvis = 0.4 * (624. *solar_sine_beta - rdvis)

    wa = 1373.0 * .077 * (2.*ru)**0.3

    
    rdir = (748.0 * exp(-.06 * ru) - wa) * solar_sine_beta
    rdir = max(rdir, 0.)

    
    rsdir = 0.6* (748. -rdvis/solar_sine_beta-wa)*solar_sine_beta
    rsdir = max(rsdir, 0.)

    rvt = rdvis + rsvis
    rit = rdir + rsdir
    rit = max(rit, 0.1)
    rvt = max(rvt, 0.1)

    
    
    
    
    

    rtt = rdvis + rsvis + rdir + rsdir
    rdvis = rdvis/rtt
    rsvis = rsvis/rtt
    rdir = rdir/rtt
    rsdir = rsdir/rtt
    

    sw_dir_vis = rdvis*swd
    sw_dif_vis = rsvis*swd
    sw_dir_nir = rdir*swd
    sw_dif_nir = rsdir*swd

  END SUBROUTINE one_to_four_stream_sw_1



  SUBROUTINE one_to_four_stream_sw( swd, swd_top, &
                                    sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )
  implicit none
  real, intent(in)  :: swd, swd_top
  real, intent(out) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir

  
  real :: kt  
  real :: kd  
  real :: kv  
  real :: a, b, c, d

  kt = swd/max(1e-3, swd_top)

  
  if (kt <= 0.22) then
      kd = 1. - 0.09*kt
  else if (kt <= 0.8) then   
      kd = 0.9511 - 0.1604*kt + 4.388*kt**2 - 16.638*kt**3 + 12.336*kt**4
  else  
      kd = 0.165
  endif


  kd = min(1., max(0., kd))













  d = 0.01
  c = kd - 0.01
  a = 0.4 * (1 - kd)
  b = 0.6 * (1 - kd)

  
  
  
  

  sw_dir_vis = swd * a
  sw_dir_nir = swd * b
  sw_dif_vis = swd * c
  sw_dif_nir = swd * d

  END SUBROUTINE one_to_four_stream_sw



  SUBROUTINE solar_flux_at_top(date_str, xlat, xlon, swd_top, coszen, decl)

  implicit none
  CHARACTER(LEN=24) , INTENT(IN) :: date_str
  REAL, INTENT(IN)  :: xlat, xlon
  REAL, INTENT(OUT) :: swd_top, coszen

  REAL :: DECL, SOLCON, GMT
  INTEGER :: julday

  swd_top = 0.

  call Julian_DAY( date_str, julday, gmt )
  call radconst( DECL, SOLCON, julday )
  call calc_coszen( julday, gmt, decl, xlon, xlat ,coszen )

  if (coszen > 1.e-3 ) swd_top = SOLCON* coszen

  END SUBROUTINE solar_flux_at_top




  SUBROUTINE radconst(DECLIN,SOLCON,julday)

  IMPLICIT NONE

  INTEGER, INTENT(IN   )      ::       julday
  REAL, INTENT(OUT  )      ::       DECLIN,SOLCON
  REAL :: PI = 3.1415926535897932384626433
  REAL :: DPD = 360./365.
  REAL :: SXLONG, ARG, OBECL, SINOB, RJUL, ECCFAC, degrad

  degrad = PI/180.

  
  
  

 

  OBECL = 23.45*DEGRAD
  SINOB = SIN(OBECL)

  
  IF(JULDAY.GE.80.)SXLONG=DPD*(JULDAY-80.)
  IF(JULDAY.LT.80.)SXLONG=DPD*(JULDAY+285.)

  SXLONG=SXLONG*DEGRAD
  ARG=SINOB*SIN(SXLONG)
  DECLIN=-ASIN(ARG)


  RJUL=2.*pi*(julday-1)/365.
  ECCFAC=1.000110+0.034221*COS(RJUL)+0.001280*SIN(RJUL)+0.000719* &
         COS(2*RJUL)+0.000077*SIN(2*RJUL)
  SOLCON=1367.*ECCFAC

  END SUBROUTINE radconst



  SUBROUTINE calc_coszen( julian, gmt, declin, xlon, xlat ,coszen)

  implicit none
  INTEGER, intent(in) :: julian
  real, intent(in)    :: declin,gmt
  real, intent(in)    :: xlat,xlon
  real, intent(inout) :: coszen
  REAL :: PI = 3.1415926535897932384626433

  real    :: da,eot,xt24,tloctm,xxlat, hrang, degrad
  degrad = PI/180.

  da=6.2831853071795862*(julian-1)/365.
  eot=(0.000075+0.001868*cos(da)-0.032077*sin(da) &
       -0.014615*cos(2*da)-0.04089*sin(2*da))*(229.18)
  xt24=eot
  tloctm=gmt+xt24/60.+xlon/15.
  hrang=15.*(tloctm-12.)*degrad
  xxlat=xlat*degrad
  coszen=sin(xxlat)*sin(declin) &
                   +cos(xxlat)*cos(declin) *cos(hrang)
  END SUBROUTINE calc_coszen



  SUBROUTINE Julian_DAY( date_str, julday, gmt )

  IMPLICIT NONE

  CHARACTER (LEN=24) , INTENT(IN) :: date_str
  INTEGER, INTENT(OUT  ) :: julday
  REAL, INTENT(OUT  ) :: gmt

  INTEGER :: ny , nm , nd , nh , ni , ns
  INTEGER :: my1, my2, my3, monss
  INTEGER, DIMENSION(12) :: mmd
  DATA MMD/31,28,31,30,31,30,31,31,30,31,30,31/

  CALL split_date_char ( date_str, ny, nm, nd, nh, ni, ns )

  MY1 = MOD(ny,4)
  MY2 = MOD(ny,100)
  MY3 = MOD(ny,400)
  IF(MY1.EQ.0.AND.MY2.NE.0.OR.MY3.EQ.0)  MMD(2) = 29

  GMT = nh + FLOAT(ni)/60. + FLOAT(ns)/3600.

  JULDAY = nd
  DO MONSS = 1, nm-1
      JULDAY = JULDAY + MMD(MONSS)
  ENDDO

  END SUBROUTINE Julian_DAY


  SUBROUTINE split_date_char ( date, year, month, day, hour, minute, second )


  IMPLICIT NONE

  CHARACTER(LEN=24) , INTENT(IN) :: date
  INTEGER , INTENT(OUT) :: year, month, day, hour, minute, second

  READ(date,FMT='(    I4.4)') year
  READ(date,FMT='( 5X,I2.2)') month
  READ(date,FMT='( 8X,I2.2)') day
  READ(date,FMT='(11X,I2.2)') hour
  READ(date,FMT='(14X,I2.2)') minute
  READ(date,FMT='(17X,I2.2)') second

  END SUBROUTINE split_date_char




  subroutine save_mcm_var( mcm_var, WRF_var, bl, nw, kms, kme )

  USE clm_varpar_my, only : mxlevcan_wrf
  implicit none
  
  INTEGER, INTENT( IN )  ::  bl, nw, kms, kme
  REAL, DIMENSION(mxlevcan_wrf), INTENT(IN) :: mcm_var
  REAL, DIMENSION(kms:kme), INTENT(INOUT) :: WRF_var

  
  INTEGER :: k, tl, ir

  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  
      
      WRF_var(k) = mcm_var(ir)
      
  ENDDO

  end subroutine save_mcm_var



  subroutine save_mcm_var_nan( WRF_var, bl, nw, kms, kme )

  USE clm_varpar_my, only : mxlevcan_wrf
  implicit none

  INTEGER, INTENT( IN )  ::  bl, nw, kms, kme
  REAL, DIMENSION(kms:kme), INTENT(INOUT) :: WRF_var

  
  INTEGER :: k, tl, ir

  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  
      
      WRF_var(k) = -999.
      
  ENDDO

  end subroutine save_mcm_var_nan



  subroutine set_mcm_force( config_flags, MF, CLAI, restart, dt,                          &
                            sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &
                            lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C, &
                            P, t, qv, rho, co2, wind,             &
                            swvisdir, swnirdir, swvisdif, swnirdif, glw, &
                            kms, kme)

  USE mcm_data_mod, only : mcm_force, canopy_lai
  USE module_configure, ONLY : grid_config_rec_type
  implicit none

  TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags
 
  INTEGER, INTENT( IN )  :: kms, kme

  LOGICAL, INTENT(IN) :: restart
  REAL, INTENT(IN) :: dt  

  REAL, INTENT(IN) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, lwd, coszen, &
                      Utop_C, qsoil_C, tsoil_C, G_C

  REAL, DIMENSION(kms:kme),INTENT(IN) ::  P, t, qv, rho, wind
  REAL, INTENT(IN) ::  swvisdir, swnirdir, swvisdif, swnirdif, glw
  REAL, DIMENSION(kms:kme),INTENT(INOUT) ::  co2  

  TYPE(canopy_lai), INTENT(IN) :: CLAI
  TYPE(mcm_force), INTENT(OUT) :: MF

  
  integer :: k, bl, nw, ir

  bl = CLAI%bl
  nw = CLAI%nw

  MF%dt = dt
  MF%t10 = 25. + 273.15
  MF%dayl_factor = 0.9  
  MF%surf_pre = P(bl)

  DO k = 1, nw
      ir = nw - k + bl  
      MF%tair(k) = t(ir)
      MF%qair(k) = qv(ir)
      MF%rho(k)  = rho(ir)
      MF%co2(k)  = CO2(ir) 
      MF%wind(k) = wind(ir)


  ENDDO

  IF (config_flags%mcm_link_rad) THEN
    MF%swd(1) = swvisdir
    MF%swd(2) = swnirdir
    MF%swi(1) = swvisdif
    MF%swi(2) = swnirdif
    MF%lwd    = glw
  ELSE
    MF%swd(1) = sw_dir_vis
    MF%swd(2) = sw_dir_nir
    MF%swi(1) = sw_dif_vis
    MF%swi(2) = sw_dif_nir
    MF%lwd    = lwd
  ENDIF
  MF%coszen = coszen
  MF%wind(99) = Utop_C
  MF%qsoil(:) = qsoil_C
  MF%tsoil(:) = tsoil_C
  MF%Gsoil = G_C


  
  

  end subroutine set_mcm_force



  subroutine simple_scalar_source_NOIBM( co2, co2_tend, CLAI,       & 
                                   zw,  mut, itimestep, &
                                   ids,ide, jds,jde, kds,kde, &
                                   ims,ime, jms,jme, kms,kme, &
                                   its,ite, jts,jte, kts,kte )
                       
  USE clm_varpar_my, only : rgas, mxlevcan_wrf, cpair
  USE mcm_data_mod, only : canopy_lai
  IMPLICIT NONE
  INTEGER, INTENT(IN) :: ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte
  
  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: co2, co2_tend
  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(IN) :: zw
  REAL, DIMENSION(ims:ime, jms:jme), INTENT(IN) :: mut
  TYPE(canopy_lai), DIMENSION(ims:ime,jms:jme), INTENT(IN) :: CLAI
  INTEGER :: itimestep

  
  integer :: i, j, k, bl, tl, nw, ir, iv
  real :: cht, cdz_top, tlai1, tlai2, tsh, SC, rdz
  real :: co2_tend_tmp(kms:kme), co2_tend_re(kms:kme)

  co2_tend = 0.

  if (itimestep >= 5*60*50) then
      DO j = jts, min(jte,jde-1)
      DO i = its, min(ite,ide-1)
          
          co2_tend(i,1,j) = 1.
      ENDDO
      ENDDO
  endif

  return
  

  SC = 1.  
  if (nw > 0) then
      DO j = jts, min(jte,jde-1)
      DO i = its, min(ite,ide-1)

          cht = CLAI(i,j)%h
          bl = CLAI(i,j)%bl
          nw = CLAI(i,j)%nw
          tl = nw + bl - 1

          tlai1 = 0.
          do iv = 1, nw
              tlai2 = tlai1 + CLAI(i,j)%lai(iv)
              co2_tend_tmp(iv) = SC * (exp(-0.6*tlai1) - exp(-0.6*tlai2))
              tlai1 = tlai2
          enddo

          
          tsh = 0.
          do iv = 1, nw
              tsh = tsh + co2_tend_tmp(iv)
          enddo

          do k = 1, nw
              co2_tend_re(k) = co2_tend_tmp(k) * SC/tsh
          enddo
          

          DO k = bl, tl
              rdz = 1./(zw(i,k+1,j) - zw(i,k,j))
              iv = nw - k + bl
              co2_tend(i,k,j) = co2_tend_re(iv)*rdz
          ENDDO
      ENDDO
      ENDDO
  endif

  end subroutine simple_scalar_source_NOIBM






  subroutine flux_to_tendency( qv_tend, t_tend, co2_tend, &
                               q_source, co2_source, &
                               qv_mcm, sh_mcm, an_mcm, CLAI,       & 
                               zw, qv, rho_phy, t_phy, p_phy, dnw, mu, &
                               
                               mcm_tau13_t, mcm_tau13_q, mcm_tau13_c, &
                               kms, kme )
                       
 
  USE clm_varpar_my, only : rgas, mxlevcan_wrf, cpair
  USE mcm_data_mod, only : canopy_lai
  implicit none
  
  INTEGER, INTENT( IN )  ::  kms, kme

  TYPE(canopy_lai), INTENT(IN) :: CLAI
  real, intent(in) :: qv_mcm(mxlevcan_wrf)  
  real, intent(in) :: sh_mcm(mxlevcan_wrf)  
  real, intent(in) :: an_mcm(mxlevcan_wrf)  
  real, dimension(kms:kme), intent(in) :: zw, qv, rho_phy, t_phy, p_phy
  real, dimension(kms:kme), intent(in) :: dnw
  real :: mu

  real, dimension(kms:kme), intent(out) :: qv_tend 
  real, dimension(kms:kme), intent(out) :: t_tend 
  real, dimension(kms:kme), intent(out) :: co2_tend  
  real, intent(out) :: mcm_tau13_t, mcm_tau13_q, mcm_tau13_c

  real, dimension(kms:kme), intent(out) :: q_source
  real, dimension(kms:kme), intent(out) :: co2_source

  
  real :: sh_mcm_flux(mxlevcan_wrf)  
  integer :: k, bl, tl, nw, ir
  real, parameter :: g = 9.81
  real, parameter :: hvap   = 2.501e6   
  real :: cpm_eff, rdz, sh_sum, Qtop, sh_grass, sum_an, le_grass, an_grass

  qv_tend = 0.
  t_tend = 0.
  co2_tend = 0.

  q_source = 0.
  co2_source = 0.

  bl = CLAI%bl
  nw = CLAI%nw
  tl = nw + bl - 1

  

  
  
  
  

  if (nw == 0) then
      rdz = 1./(zw(2) - zw(1))

      
      le_grass = 50./hvap  
      
      
      qv_tend(1) = le_grass*(-g/dnw(1))
      q_source(1) = le_grass*rdz  

      
      
      
      
      
      
      

      
      
      
      co2_tend(1) = 5.5*rdz*8.314*t_phy(1)/p_phy(1)
      co2_source(1) = 5.5*rdz  
      return
  endif

  
  sh_sum = 0.
  DO k = 1, nw
      ir = nw - k + bl  

      
      cpm_eff = cpair
      sh_mcm_flux(k) = sh_mcm(k)/cpm_eff/rho_phy(ir)  
      sh_sum = sh_sum + sh_mcm_flux(k)
  ENDDO


  
  
  
  
  
  

  sum_an = 0.
  DO k = bl, tl
      rdz = 1./(zw(k+1) - zw(k))

      ir = nw - k + bl  

      
      
      qv_tend(k) = -qv_mcm(ir)*g/dnw(k)
      q_source(k) = qv_mcm(ir)*rdz  
      q_source(k) = q_source(k)*mu

      
      

      
      

      t_tend(k) = -sh_mcm_flux(ir)*rho_phy(k)*g/dnw(k)
      t_tend(k) = t_tend(k)*mu

      

      
      co2_tend(k) = an_mcm(ir)*rdz*8.314*t_phy(k)/p_phy(k)
      co2_source(k) = an_mcm(ir)*rdz  
      co2_source(k) = co2_source(k)*mu

      
  ENDDO

  mcm_tau13_t = sh_mcm(nw)/(1.00464e3 * (1. + 0.8 *qv(nw)))/rho_phy(nw)
  mcm_tau13_q = qv_mcm(nw)/rho_phy(nw)
  mcm_tau13_c = an_mcm(nw)*8.314*t_phy(nw)/p_phy(nw) 

  end subroutine flux_to_tendency



  subroutine set_mcm_force_from_chats( dt, CLAI, MF, ntime, &
                                       date_str, us, P_surf, SWD, LWD, CO2, TS, QS, Gsoil, &
                                       SPD, T, Q, xlat, xlon, flag ) 

  USE clm_varpar_my, only : nlevgrnd, mincoszen
  USE mcm_data_mod, only : mcm_force, canopy_lai
  implicit none
  
  INTEGER, INTENT(IN) :: ntime 

  REAL, INTENT(IN) :: dt  
  TYPE(canopy_lai), INTENT(IN) :: CLAI
  TYPE(mcm_force), INTENT(OUT) :: MF
  LOGICAL :: flag

  
  integer, parameter :: nl = 7
  real :: SPD, T, Q, P_surf, SWD, LWD, CO2, TS, QS, Gsoil, us
  CHARACTER(LEN=24) :: date_str
  real :: z_ob(nl)

  real :: swd_top, coszen, xlat, xlon, decl, dayl, max_dayl, max_decl, tmp
  real :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir
  real :: frac_cloud

  integer :: k, bl, nw, ir
  flag = .true.

  z_ob(1) = 1.5
  z_ob(2) = 3.0
  z_ob(3) = 4.5
  z_ob(4) = 6.0
  z_ob(5) = 7.5
  z_ob(6) = 9.0
  z_ob(7) = 10.

  nw = CLAI%nw

  MF%wind(:) = SPD    
  MF%tair(:) = T
  MF%qair(:) = Q


  MF%dt = dt
  MF%t10 = 25. + 273.15
  MF%dayl_factor = 0.9  

  MF%us = us
  MF%Gsoil = Gsoil
  MF%surf_pre = P_surf

  
  MF%lwd    = LWD
  
  
  
  


  MF%co2(:)  = CO2   

  MF%rho(:)  = 1.22  

  
  

  MF%tsoil(:) = TS
  MF%qsoil(:) = QS

  if (ntime == 1) then
      MF%tsoil(:) = TS
      MF%qsoil(1) = 0.15
      MF%qsoil(2) = 0.18
      MF%qsoil(3) = 0.20
      MF%qsoil(4) = 0.22
      MF%qsoil(5) = 0.23
      MF%qsoil(6) = 0.24
      MF%qsoil(7) = 0.24
      MF%qsoil(8) = 0.24
      MF%qsoil(9) = 0.28
      MF%qsoil(10:nlevgrnd) = 0.30
  endif

  
  
  xlat = -38.  
  xlon = -121.

  
  
  call solar_flux_at_top(date_str, xlat, xlon, swd_top, coszen, decl)
  MF%coszen = coszen

  

  if ( swd < -100. ) swd = 0.9*swd_top 
  if ( coszen > mincoszen ) then
      
      
      call one_to_four_stream_sw_1( MF%coszen, swd, &
                                  sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )  
      MF%swd(1) = sw_dir_vis 
      MF%swd(2) = sw_dir_nir 
      MF%swi(1) = sw_dif_vis 
      MF%swi(2) = sw_dif_nir 
  else
      MF%swd(1) = 0.
      MF%swd(2) = 0.
      MF%swi(1) = 0.
      MF%swi(2) = 0.
  endif
  
  end subroutine set_mcm_force_from_chats



  subroutine read_chats_data_all( date_str, P_surf, SWD, LWD, SWU, LWU, &
                                  CO2, TS, QS, t_source_ob, h2o_source_ob, &
                                  SPD, T, Q, us, Gsoil, nl, nt )
  implicit none

  integer :: nl, nt
  real :: SPD(nt, nl), T(nt, nl), Q(nt, nl), P_surf(nt), LWU(nt), &
          SWD(nt), LWD(nt), SWU(nt), CO2(nt), TS(nt), QS(nt), t_source_ob(nt), &
          h2o_source_ob(nt), us(nt), Gsoil(nt)
  CHARACTER(LEN=24) :: date_str(nt)

  integer :: i, io, ntt, it
  OPEN ( FILE = 'drive_force.txt', UNIT = 123, STATUS = 'OLD', &
        ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ')

  DO i = 1, 9
      read( 123, *, iostat = io )
  ENDDO


  DO it = 1, nt
      read( 123, *, iostat = io ) date_str(it), p_surf(it), SWD(it), LWD(it), SWU(it), &
                                  LWU(it), CO2(it), TS(it), QS(it), &
                                  t_source_ob(it), h2o_source_ob(it), us(it), Gsoil(it)
      DO i = 1, 7
         read( 123, *, iostat = io ) spd(it, i), T(it, i), Q(it, i)
      enddo
  ENDDO

  close(123)

  end subroutine read_chats_data_all



  subroutine read_chats_data_all_toplayer( date_str, T, S, sw_in, lw_in, tair, qair, &
                                           Psurf, spd, tsoil, qsoil, G,            &
                                           sw_out, lw_out, LE, SH, LEg, SHg,       &
                                           Rn, NEE, &
                                           mxlen, nt ) 
  implicit none

  integer :: mxlen, nt
  real :: T(mxlen), S(mxlen), sw_in(mxlen), lw_in(mxlen), tair(mxlen), qair(mxlen), &
          Psurf(mxlen), spd(mxlen), tsoil(mxlen), qsoil(mxlen), G(mxlen), &
          sw_out(mxlen), lw_out(mxlen), LE(mxlen), SH(mxlen), LEg(mxlen), SHg(mxlen), &
          Rn(mxlen), NEE(mxlen)
  CHARACTER(LEN=24) :: date_str(mxlen)

  integer :: i, io, it

  OPEN ( FILE = 'drive_force.txt', UNIT = 234, STATUS = 'OLD', &
        ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ')

  read(234, *)

  it = 1
  
  
  
  
  
  
  
  
  
  do while( .TRUE. )
      read( 234, *, iostat = io) date_str(it), T(it), S(it), sw_in(it), lw_in(it), &
                                 tair(it), &
                                 qair(it), Psurf(it), spd(it), tsoil(it), qsoil(it), G(it),&
                                 sw_out(it), lw_out(it), Rn(it), LE(it), SH(it), &
                                 LEg(it), SHg(it), NEE(it)
      if (io < 0) exit
      it = it + 1
  ENDDO
  nt = it - 1

  CLOSE(234) 

  end subroutine read_chats_data_all_toplayer



  subroutine read_chats_data( date_str, P_surf, SWD, LWD, CO2, TS, QS, t_source_ob, &
                              SPD, T, Q, nl, ntime )
  implicit none

  INTEGER, INTENT(IN) :: ntime 
  integer :: nl
  real :: SPD(nl), T(nl), Q(nl), P_surf, SWD, LWD, CO2, TS, QS, t_source_ob
  CHARACTER(LEN=24) :: date_str

  integer :: i, io, ntt
  OPEN ( FILE = 'chats.txt', UNIT = 123, STATUS = 'OLD', &
        ACCESS = 'SEQUENTIAL', FORM = 'FORMATTED', ACTION = 'READ')

  DO i = 1, 9
      read( 123, *, iostat = io )
  ENDDO

  ntt = (ntime-1)*8
  DO i = 1, ntt
     read(123, *, iostat = io) 
  ENDDO

  read( 123, *, iostat = io ) date_str, p_surf, SWD, LWD, CO2, TS, QS, t_source_ob

  i = 1
  DO i = 1, 7
     read( 123, *, iostat = io ) spd(i), T(i), Q(i)
  enddo

  close(123)

  end subroutine read_chats_data



  subroutine surface_drag( ru_tendf, rv_tendf, u, v, rho, z, dnw, & 
                           CLAI, &
                           ids,ide, jds,jde, kds,kde, &
                           ims,ime, jms,jme, kms,kme, &
                           its,ite, jts,jte, kts,kte )

  USE mcm_data_mod, only : canopy_lai

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte

  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(IN) :: u, v, rho, z
  REAL, DIMENSION(kms:kme), INTENT(IN) :: dnw

  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: ru_tendf, rv_tendf

  TYPE(canopy_lai), DIMENSION(ims:ime,jms:jme), INTENT(IN) :: CLAI

  
  INTEGER :: i, j, id, jd
  REAL :: tao_xz, tao_yz, V0_u, V0_v, epsilon=0.01
  REAl :: g = 9.81, cd0, z0, z1, rho_1

  DO j = jts, min(jte,jde-1)
  DO i = its, ite

       id = max(its, i-1)
       cd0 = CLAI(id,j)%cd0
       rho_1 = rho(id,1,j)

       V0_u = sqrt( (u(i,1,j)**2) + &
                     ( (v(i,1,j)+v(i,1,j+1)+v(i-1,1,j)+v(i-1,1,j+1))*0.25 )**2 )+epsilon

       tao_xz = cd0*V0_u*u(i,1,j)*rho_1
       ru_tendf(i,1,j) = ru_tendf(i,1,j) +  g*tao_xz/dnw(1)
  ENDDO
  ENDDO

  DO j = jts, jte
  DO i = its, min(ite,ide-1)

       jd = max(jts, j-1)
       cd0 = CLAI(i,jd)%cd0
       rho_1 = rho(i,1,jd)

       V0_v = sqrt( (v(i,1,j)**2) + &
                     ( (u(i,1,j)+u(i,1,j-1)+u(i+1,1,j)+u(i+1,1,j-1))*0.25 )**2 )+epsilon

       tao_yz = cd0*V0_v*v(i,1,j)*rho_1
       rv_tendf(i,1,j) = rv_tendf(i,1,j) +  g*tao_yz/dnw(1)
  ENDDO
  ENDDO

  end subroutine surface_drag



  SUBROUTINE momentum_drag ( u, v, w, tke, dt, &
                             muu, muv, mut, cd_pan,   &
                             ru_tendf, rv_tendf, rw_tendf, tke_tend, wind, &
                             CLAI,  &
                             ids,ide, jds,jde, kds,kde, &
                             ims,ime, jms,jme, kms,kme, &
                             its,ite, jts,jte, kts,kte )

  USE mcm_data_mod, only : canopy_lai
  IMPLICIT NONE

  INTEGER, INTENT(IN) :: ids,ide, jds,jde, kds,kde, &
                         ims,ime, jms,jme, kms,kme, &
                         its,ite, jts,jte, kts,kte

  REAL, INTENT(IN) :: dt
  REAL, DIMENSION(ims:ime, jms:jme), INTENT(IN) :: muu, muv, mut
  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: u, v, w, tke

  TYPE(canopy_lai), DIMENSION(ims:ime,jms:jme), INTENT(IN) :: CLAI

  REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: ru_tendf, &
                                                               rv_tendf, &
                                                               rw_tendf, &
                                                               tke_tend, &
                                                               wind, cd_pan

  
  INTEGER :: i, j, k, i1, j1, bl, tl, nw, ir
  REAL ::  pre_tend, pre_test, A_f, speed
  REAL, PARAMETER :: C_d = 0.2
  
  REAL :: C_d1 

  
  DO j = jts, min(jte,jde-1)
  DO i = its, ite

      i1 = min(i, ide - 1)
      if (CLAI(i1,j)%nw > 0 ) then
        bl = CLAI(i1,j)%bl
        nw = CLAI(i1,j)%nw
        tl = nw + bl - 1

        DO k = bl, tl+1
            ir = nw - k + bl  
            if ( k == tl+1) then
                A_f = CLAI(i1,j)%lad(bl)*0.1 
            else 
                A_f = CLAI(i1,j)%lad(ir)
            endif

            speed = sqrt( (u(i,k,j)**2) + &
                          ( (v(i,k,j)+v(i,k,j+1)+v(i-1,k,j)+v(i-1,k,j+1))*0.25 )**2 + &
                          ( (w(i,k,j)+w(i-1,k,j)+w(i,k+1,j)+w(i-1,k+1,j))*0.25 )**2 )

            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            C_d1 = C_d
            

            pre_tend = - C_d1 * A_f * speed * u(i,k,j)
            pre_test = u(i,k,j) + dt * pre_tend
            IF ( SIGN(pre_test,u(i,k,j)) /= pre_test ) THEN
                pre_tend = - u(i,k,j)/dt
            ENDIF
 
            
            ru_tendf(i,k,j) =  ru_tendf(i,k,j) + pre_tend * muu(i,j)
        ENDDO
      endif
  ENDDO
  ENDDO

  
  DO j = jts, jte
  DO i = its, min(ite,ide-1)

      j1 = min(j, jde - 1)
      if (CLAI(i,j1)%nw > 0 ) then
        bl = CLAI(i,j1)%bl
        nw = CLAI(i,j1)%nw
        tl = nw + bl - 1

        DO k = bl, tl+1

            ir = nw - k + bl  
            if ( k == tl+1) then
                A_f = CLAI(i,j1)%lad(bl)*0.1 
            else 
                A_f = CLAI(i,j1)%lad(ir)
            endif

            speed = sqrt( (v(i,k,j)**2) + &
                          ( (u(i,k,j)+u(i,k,j-1)+u(i+1,k,j)+u(i+1,k,j-1))*0.25 )**2 + &
                          ( (w(i,k,j)+w(i,k,j-1)+w(i,k+1,j)+w(i,k+1,j-1))*0.25 )**2 )

            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            C_d1 = C_d
            

            pre_tend = - C_d1 * A_f * speed * v(i,k,j)
            pre_test = v(i,k,j) + dt * pre_tend
            IF ( SIGN(pre_test,v(i,k,j)) /= pre_test ) THEN
                pre_tend = - v(i,k,j)/dt
            ENDIF
            
            rv_tendf(i,k,j) = rv_tendf(i,k,j) + pre_tend * muv(i,j)
        ENDDO
      endif
  ENDDO
  ENDDO

  
  DO j = jts, min(jte,jde-1)
  DO i = its, min(ite,ide-1)
      if (CLAI(i,j)%nw > 0 ) then
        bl = CLAI(i,j)%bl
        nw = CLAI(i,j)%nw
        tl = nw + bl - 1

        DO k = bl+1, tl+1

            ir = nw - k + bl  
            if ( k == tl+1) then
                A_f = CLAI(i,j1)%lad(bl)*0.1 
            else 
                A_f = 0.5*( CLAI(i,j)%lad(ir+1) + CLAI(i,j)%lad(ir) )
            endif

            IF ( k ==1 ) THEN
                speed = sqrt( ((u(i,k,j) + u(i+1,k,j))*0.25)**2 + &
                              ((v(i,k,j) + v(i,k,j+1))*0.25)**2 + &
                              w(i,k,j)**2 )
            ELSE
                speed = sqrt( ((u(i,k,j) + u(i+1,k,j) + u(i,k-1,j) + u(i+1,k-1,j))*0.25)**2 + &
                              ((v(i,k,j) + v(i,k,j+1) + v(i,k-1,j) + v(i,k-1,j+1))*0.25)**2 + &
                              w(i,k,j)**2 )
            ENDIF

            
            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            C_d1 = C_d
            

            pre_tend = - C_d1 * A_f * speed * w(i,k,j)
            pre_test = w(i,k,j) + dt * pre_tend
            IF ( SIGN(pre_test,w(i,k,j)) /= pre_test ) THEN
                pre_tend = - w(i,k,j)/dt
            ENDIF
            rw_tendf(i,k,j) = rw_tendf(i,k,j) + pre_tend * mut(i,j)
        ENDDO
      endif
  ENDDO
  ENDDO

  
  DO j = jts, min(jte,jde-1)
  DO i = its, min(ite,ide-1)
      if (CLAI(i,j)%nw > 0 ) then
        bl = CLAI(i,j)%bl
        nw = CLAI(i,j)%nw
        tl = nw + bl - 1

        DO k = bl, tl

            ir = nw - k + bl  
            A_f = CLAI(i,j)%lad(ir)





            speed = sqrt( ((u(i,k,j) + u(i+1,k,j))*0.5)**2 + &
                          ((v(i,k,j) + v(i,k,j+1))*0.5)**2 + &
                          w(i,k,j)**2 )

            
            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            
            

            pre_tend = 2.67 * C_d * A_f * speed * tke(i,k,j)
            
            
            
            
            tke_tend(i,k,j) =  pre_tend * mut(i,j)

            wind(i,k,j) = speed
         ENDDO
      endif
  ENDDO
  ENDDO

  END SUBROUTINE momentum_drag



  SUBROUTINE constant_pressure_gradient_nudge( pres_gradient, &
                                               ru_tendf, rho, muu,    &
                                               ids, ide, jds, jde, kds, kde, &
                                               ims, ime, jms, jme, kms, kme, &
                                               its, ite, jts, jte, kts, kte )
   IMPLICIT NONE
   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL ,INTENT(IN) :: pres_gradient
   REAL , DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT(INOUT) :: ru_tendf

   REAL , DIMENSION( ims:ime, jms:jme ),          INTENT(IN) :: muu
   REAL , DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT(IN) :: rho

   
   INTEGER :: i, j, k

   DO j = jts, MIN(jte,jde-1)
   DO k = kts, kte-1
   DO i = its, ite
        ru_tendf(i,k,j) = ru_tendf(i,k,j) + &
                          muu(i,j)*1./(0.5*(rho(i,k,j) + rho(i-1,k,j)))*pres_gradient
   ENDDO
   ENDDO
   ENDDO

  END SUBROUTINE constant_pressure_gradient_nudge





END MODULE module_multi_layer_canopy_model_func




MODULE module_multi_layer_canopy_model

   USE module_state_description
 
   USE module_domain
   USE module_configure
   USE module_tiles
   USE module_machine
 
   USE module_bc


 CONTAINS

  SUBROUTINE MCM_DRIVER( grid, config_flags, &
                         t_phy, p_phy,       &
                         QV, CO2, QV_tend, CO2_tend,       &
 
                         ru_tendf, rv_tendf, rw_tendf,     &
                         t_tendf, tke_tend,                &
                         ids, ide, jds, jde, kds, kde,     &
                         ims, ime, jms, jme, kms, kme,     &
                         its, ite, jts, jte, kts, kte      )

  USE module_domain, only : domain
  USE module_configure, ONLY : grid_config_rec_type

  USE module_multi_layer_canopy_model_func
  USE clm_varpar_my, only : nlevgrnd, mxlevcan_wrf


  USE mcm_data_mod, only : CLAI, SP, MF

  IMPLICIT NONE
  TYPE(domain) , INTENT(INOUT)   :: grid
  TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags

  INTEGER, INTENT( IN )  :: ids, ide, jds, jde, kds, kde, &
                            ims, ime, jms, jme, kms, kme, &
                            its, ite, jts, jte, kts, kte

  REAL, DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(IN) :: t_phy, p_phy

  REAL, DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(IN) :: QV   
  REAL,DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(INOUT) :: CO2

  REAL, DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(INOUT) :: QV_tend,  &
                                                            CO2_tend, &
                                                            t_tendf, &
                                                            ru_tendf,  &
                                                            rv_tendf,  &
                                                            rw_tendf,  &
                                                            tke_tend
  
  
  REAL,DIMENSION(ims:ime,jms:jme) :: hgt
  REAL,DIMENSION(ims:ime,kms:kme,jms:jme) :: wind
  REAL,DIMENSION(kms:kme) :: tmp_1d
  REAL :: pres_gradient

  
  real :: qv_out(mxlevcan_wrf)      
  real :: sh_out(mxlevcan_wrf)      
  real :: an_out(mxlevcan_wrf)      

  real :: sw_can_z(mxlevcan_wrf)    
  real :: lw_can_z(mxlevcan_wrf)    
  real :: efsh_z(mxlevcan_wrf)      
  real :: efe_z(mxlevcan_wrf)       
  real :: sw_grnd                   
  real :: lw_grnd                   
  real :: eflx_sh_grnd              
  real :: qflx_ev_grnd              
  real :: SHg, LEg, sw_out, lw_out
  real :: Qtop 

  REAL :: dt_soil
  REAL :: OBS_interval
  INTEGER :: i, j, k, i_start, i_end, j_start, j_end, dd
  real, save :: sw_dir_vis = 0, sw_dir_nir = 0, sw_dif_vis = 0, sw_dif_nir = 0, &
                lwd = 0, coszen = 0, Utop_C = 0, qsoil_C = 0, tsoil_C = 0, G_C = 0
  real :: s_bdy, roughness_len
  logical, save :: initial_mcm  = .true.
  
  
  
 


  CALL wrf_debug(200, 'Entering MCM_DRIVER')

  




  

  IF (.not. allocated(SP))   allocate(SP(ims:ime,jms:jme))
  IF (.not. allocated(CLAI)) allocate(CLAI(ims:ime,jms:jme))
  IF (.not. allocated(MF))   allocate(MF(ims:ime,jms:jme))

  call get_hgt_twj( hgt, grid%HT, ims, ime, jms, jme )

  IF (initial_mcm) THEN
      initial_mcm = .false.

      CO2 = 0.
      

      DO j = jts, min(jte,jde-1)
      DO i = its, min(ite,ide-1)
          
          
             roughness_len = 0.05 
             call initiate_mcm_forest( SP(i,j), CLAI(i,j), MF(i,j), &
                                grid%z(i,1:kme-1,j) - hgt(i,j), kme-1, roughness_len )
          
          
          
          
          




             call initial_soil_1d( SP(i,j), CLAI(i,j) )
      ENDDO
      ENDDO
      CALL wrf_debug(200, 'Done initiate_mcm_forest')
  ENDIF

  
  

  call surface_drag( ru_tendf, rv_tendf, &
                     grid%u_2, grid%v_2, grid%rho, grid%z, grid%dnw, & 
                     CLAI, &
                     ids,ide, jds,jde, kds,kde, &
                     ims,ime, jms,jme, kms,kme, &
                     its,ite, jts,jte, kts,kte )
  CALL wrf_debug(200, 'Done surface_drag')

  call momentum_drag ( grid%u_2, grid%v_2, grid%w_2, grid%tke_2, grid%dt, &
                       grid%muu, grid%muv, grid%mut, grid%cd_pan, &
                       ru_tendf, rv_tendf, rw_tendf, tke_tend, wind, &
                       CLAI,                      &
                       ids,ide, jds,jde, kds,kde, &
                       ims,ime, jms,jme, kms,kme, &
                       its,ite, jts,jte, kts,kte )
  CALL wrf_debug(200, 'Done momentum_drag')









  



























  OBS_interval = 30.  
  
  call read_obs_driving( OBS_interval, grid%itimestep, grid%dt, &
                         sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   
                         lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C )     
  CALL wrf_debug(200, 'Done read_obs_driving')

  dd = 1
  

  i_start = its
  i_end   = MIN(ite,ide-1)
  j_start = jts
  j_end   = MIN(jte,jde-1)










  IF ( mod(grid%itimestep,dd) .EQ. 0) then
      DO j = j_start, j_end
      DO i = i_start, i_end









      

          dt_soil = grid%dt*dd

          
          call set_mcm_force( config_flags, MF(i,j), CLAI(i,j), grid%restart, dt_soil,                  &
                              sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   
                              lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C,     &   
                              p_phy(i,:,j), t_phy(i,:,j), qv(i,:,j), grid%rho(i,:,j), &
                              CO2(i,:,j), wind(i,:,j),                               &
                              grid%swvisdir(i,j), grid%swnirdir(i,j), grid%swvisdif(i,j), &
                              grid%swnirdif(i,j), grid%glw(i,j), &
                              
                              kms, kme )
          CALL wrf_debug(200, 'Done set_mcm_force')

          
          
          

          
          

          CALL multi_layer_canopy( qv_out, sh_out, an_out,             &  
                                   LEg, SHg, &
                                   CLAI(i,j), SP(i,j), MF(i,j),        &
                                   sw_can_z, lw_can_z, efsh_z, efe_z )
                                   
          CALL wrf_debug(200, 'Done multi_layer_canopy')


          
          call flux_to_tendency( grid%mcm_qv_tend(i,:,j), grid%mcm_t_tend(i,:,j),    &
                                 grid%mcm_co2_tend(i,:,j),                           &
                                 grid%mcm_q_source(i,:,j),                           &  
                                 grid%mcm_co2_source(i,:,j),                           &
                                 qv_out, sh_out, an_out, CLAI(i,j),                  &
                                 grid%z_at_w(i,:,j), qv(i,:,j), grid%rho(i,:,j), t_phy(i,:,j), &
                                 p_phy(i,:,j), grid%dnw, grid%mut(i,j), &
                                 
                                 grid%mcm_tau13_t(i,1,j), grid%mcm_tau13_q(i,1,j), &
                                 grid%mcm_tau13_c(i,1,j), kms, kme )
          CALL wrf_debug(200, 'Done flux_to_tendency')

          call save_mcm_var( CLAI(i,j)%lai, grid%mcm_tlai(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( sw_can_z, grid%mcm_sw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( lw_can_z, grid%mcm_lw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( efsh_z,   grid%mcm_sh(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( efe_z,    grid%mcm_le(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          

          
          grid%mcm_sh_grnd(i,j) = SHG
          grid%mcm_le_grnd(i,j) = LEG

          grid%mcm_sw_in(i,j) = MF(i,j)%swd(1) + MF(i,j)%swd(2) + MF(i,j)%swi(1) + MF(i,j)%swi(2)
          
          grid%mcm_lw_in(i,j) = MF(i,j)%lwd 
          

      DO k = kts, kte
          grid%www(i,k,j) = grid%ww(i,k,j)/grid%mu_2(i,j)
      ENDDO
















      ENDDO
      ENDDO

  ENDIF



  QV_tend  = QV_tend  + grid%mcm_qv_tend

  CO2_tend = CO2_tend + grid%mcm_co2_tend


  
  
  
  

  CALL wrf_debug(200, 'Leaving MCM_DRIVER')

  END SUBROUTINE MCM_DRIVER




   
  SUBROUTINE sum_plane_scalar(  plane_sum_s, scalar, &
                                ids, ide, jds, jde, kds, kde, &
                                ims, ime, jms, jme, kms, kme, &
                                its, ite, jts, jte, kts, kte )

   IMPLICIT NONE

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( kms:kme ) :: plane_sum_s

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: scalar

   
   INTEGER :: i, j, k

   plane_sum_s(:) = 0.
   DO i = its, MIN(ite,ide-1)
       if (i == ide-1) then  
           DO k = kts, kte-1
           DO j = jts, MIN(jte,jde-1)
               plane_sum_s(k) = plane_sum_s(k) + scalar(i,k,j)
           ENDDO
           ENDDO
       endif
   ENDDO

  END SUBROUTINE sum_plane_scalar



  SUBROUTINE scalar_nudge(  plane_avg_s, scalar, scalar_bg, &
                            ids, ide, jds, jde, kds, kde, &
                            ims, ime, jms, jme, kms, kme, &
                            its, ite, jts, jte, kts, kte )

   IMPLICIT NONE

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( kms:kme ) :: plane_avg_s
   REAL :: scalar_bg

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: scalar

   
   INTEGER :: i, j, k
   REAL :: coeff

   coeff = 0.

   DO i = its, MIN(ite,ide-1)
       if (i >= ide-4) then
           if (i == ide-4) coeff = 0.1
           if (i == ide-3) coeff = 0.3
           if (i == ide-2) coeff = 0.7
           if (i == ide-1) coeff = 1.0

           DO k = kts, kte-1
           DO j = jts, MIN(jte,jde-1)
               
               scalar(i,k,j) = scalar(i,k,j) - coeff*(plane_avg_s(k) - scalar_bg)
           ENDDO
           ENDDO
       endif
   ENDDO
  
  END SUBROUTINE scalar_nudge
END MODULE module_multi_layer_canopy_model









































































































































































