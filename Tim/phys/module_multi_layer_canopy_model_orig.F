! Multi-layer canopy model (MCM), based on CLM4.5
! Yulong 10/24/2016 at WSU

  MODULE clm_varpar_my

  implicit none
  save

  !-----------------  CHATS input 
  integer, parameter :: NN       = 1000
  real :: S_CHATS(NN), sw_in_CHATS(NN), lw_in_CHATS(NN), &
          tsoil_CHATS(NN), qsoil_CHATS(NN), G_CHATS(NN),  Utop_CHATS(NN)
  CHARACTER(LEN=24) :: date_CHATS(NN)
  !-------------------

  real :: sc_p(20)  ! parameters from SCEM_UA  
   
  real :: zmax = 2.22, vt(100)  ! used in turbulent transfer submodel, vt is eddy viscosity

  integer, private :: i  ! loop index
  integer, parameter :: mxlevcan_wrf = 100  ! max canopy layers in WRF grids
  integer, parameter :: nlevsoi      = 10   ! number of hydrologically active soil layers
  integer, parameter :: nlevgrnd     = 15   ! number of ground layers
  integer, parameter :: numrad       = 2    ! number of solar radiation bands: 1=vis,2=nir

  real, parameter :: mincoszen = 0.
  real, parameter :: smpmin = -1.e8     ! restriction for min of soil potential (mm) (new)
  real, parameter :: grav   = 9.80616   ! gravity constant [m/s2]
  real, parameter :: sb     = 5.67e-8   ! stefan-boltzmann constant  [W/m2/K4]
  real, parameter :: vkc    = 0.4       ! von Karman constant [-]
  real, parameter :: rgas   = 8314.468  ! Universal gas constant ~ J/K/kmole
  real, parameter :: rwat   = 461.5046  ! gas constant for water vapor [J/(kg K)]
  real, parameter :: rair   = 287.0423  ! gas constant for dry air [J/kg/K]
  real, parameter :: roverg = 47062.73  ! Rw/g constant, (8.3144/0.018)/(9.8062)*1000. mm/K
  real, parameter :: cpliq  = 4.188e3   ! Specific heat of water [J/kg-K]
  real, parameter :: cpice  = 2.11727e3 ! Specific heat of ice [J/kg-K]
  real, parameter :: cpair  = 1.00464e3 ! specific heat of dry air [J/kg/K]
  real, parameter :: hvap   = 2.501e6   ! Latent heat of evap for water [J/kg]
  real, parameter :: hfus   = 3.337e5   ! Latent heat of fusion for ice [J/kg]
  real, parameter :: hsub   = 2.501e6+3.337e5 !Latent heat of sublimation    [J/kg]
  real, parameter :: denh2o = 1.000e3   ! density of liquid water [kg/m3]
  real, parameter :: denice = 0.917e3   ! density of ice [kg/m3]
  real, parameter :: tkair  = 0.023     ! thermal conductivity of air   [W/m/k]
  real, parameter :: tkice  = 2.290     ! thermal conductivity of ice   [W/m/k]
  real, parameter :: tkwat  = 0.57      ! thermal conductivity of water [W/m/k]
  real, parameter :: tfrz   = 273.16    ! freezing temperature [K]
  real, parameter :: tcrit  = 2.5       ! critical temperature to determine rain or snow
  real, parameter :: po2    = 0.209     ! constant atmospheric partial pressure O2 (mol/mol)
  real, parameter :: pco2   = 355.e-06  ! constant atmospheric partial pressure CO2 (mol/mol)
  real, parameter :: pstd   = 101325.0  ! standard pressure ~ pascals
  real, parameter :: bdsno  = 250.      ! bulk density snow (kg/m**3)
  real, parameter :: e_ice  = 6.0       ! soil ice impedance factor
  real, parameter :: watmin = 0.01      ! minimum soil moisture (mm)

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
  real dleaf(0:numpft)       !characteristic leaf dimension (m)
  real c3psn(0:numpft)       !photosynthetic pathway: 0. = c4, 1. = c3
  real vcmx25(0:numpft)      !max rate of carboxylation at 25C (umol CO2/m**2/s)
  real mp(0:numpft)          !slope of conductance-to-photosynthesis relationship
  real qe25(0:numpft)        !quantum efficiency at 25C (umol CO2 / umol photon)
  real xl(0:numpft)          !leaf/stem orientation index
  real rhol(0:numpft,numrad) !leaf reflectance: 1=vis, 2=nir
  real rhos(0:numpft,numrad) !stem reflectance: 1=vis, 2=nir
  real taul(0:numpft,numrad) !leaf transmittance: 1=vis, 2=nir
  real taus(0:numpft,numrad) !stem transmittance: 1=vis, 2=nir
  real emsv(0:numpft)        !long wave radiation emission
  real roota_par(0:numpft)   !CLM rooting distribution parameter [1/m]
  real rootb_par(0:numpft)   !CLM rooting distribution parameter [1/m]
  real slatop(0:numpft)      !SLA at top of canopy [m^2/gC]
  real leafcn(0:numpft)      !leaf C:N [gC/gN]
  real flnr(0:numpft)        !fraction of leaf N in Rubisco [no units]
  real smpso(0:numpft)       !soil water potential at full stomatal opening (mm)
  real smpsc(0:numpft)       !soil water potential at full stomatal closure (mm)
  real fnitr(0:numpft)       !foliage nitrogen limitation factor (-)

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

  ! -----------------------------
  integer, parameter :: mxsoil_color   =   20  
  real :: albsat(mxsoil_color,numrad) !wet soil albedo by color class and waveband (1=vis,2=nir)
  real :: albdry(mxsoil_color,numrad) !dry soil albedo by color class and waveband (1=vis,2=nir)

  data(albsat(i,1),i=1,20) /0.25,0.23,0.21,0.20,0.19,0.18,0.17,0.16,&
                     0.15,0.14,0.13,0.12,0.11,0.10,0.09,0.08,0.07,0.06,0.05,0.04/
  data(albsat(i,2),i=1,20) /0.50,0.46,0.42,0.40,0.38,0.36,0.34,0.32,&
                     0.30,0.28,0.26,0.24,0.22,0.20,0.18,0.16,0.14,0.12,0.10,0.08/
  data(albdry(i,1),i=1,20) /0.36,0.34,0.32,0.31,0.30,0.29,0.28,0.27,&
                     0.26,0.25,0.24,0.23,0.22,0.20,0.18,0.16,0.14,0.12,0.10,0.08/
  data(albdry(i,2),i=1,20) /0.61,0.57,0.53,0.51,0.49,0.48,0.45,0.43,&
                     0.41,0.39,0.37,0.35,0.33,0.31,0.29,0.27,0.25,0.23,0.21,0.16/
  
  !--------  19 soil texture type
!  soil type from MM5
! (1)  sand
! (2)  loamy-sand
! (3)  sandy-loam
! (4)  silt-loam
! (5)  silt
! (6)  loam
! (7)  sandy-clay-loam
! (8)  silty-clay-loam
! (9)  clay-loam
! (10) sandy-clay
! (11) silty-clay
! (12) clay
! (13) organic-material,
! (14) water
! (15) bedrock
! (16) other(land-ice)
! (17) playa
! (18) lava
! (19) white-sand
  real :: sand(19)                           ! percent sand
  real :: clay(19)                           ! percent clay
  integer  :: soic(19)

  data(sand(i), i=1,19)/92.,80.,66.,20.,5.,43.,60.,&
    10.,32.,51., 6.,22.,39.7,0.,100.,54.,17.,100.,92./

  data(clay(i), i=1,19)/ 3., 5.,10.,15.,5.,18.,27.,&
    33.,33.,41.,47.,58.,14.7,0., 0., 8.5,54.,  0., 3./

  data(soic(i), i=1,19)/1,2,2,3,3,4,5,5,6,7,7,8,8,0,&
                          1,1,4,7,1/
! ------------------------------------------------- TWJ
  real :: organic(nlevgrnd)  ! organic matter (kg/m3)
  ! The following data are global average for each soil layer, taken from clm
  data(organic(i),i=1,nlevgrnd)/15.36,15.12,13.22,10.80,8.31,6.09,4.37,3.12,&
                                0.00,0.00,0.00,0.00,0.00,0.00,0.00/

  END MODULE clm_varpar_my
! ALL OF THESE CODE ARE MODIFIED FROM CLM4.5

! ===================================================================
! ===================================================================

  MODULE mcm_data_mod 

  USE clm_varpar_my, only : mxlevcan_wrf, nlevgrnd
  
  implicit none

  type mcm_force
      real :: dt                    ! for soil (s)
      real :: swd(2)                ! direct beam radiation (W/m**2)
      real :: swi(2)                ! diffus radiation (W/m**2)
      real :: lwd                   ! downward infrared (longwave) radiation (W/m**2)
      real :: coszen                ! cosine of solar zenith angle
      real :: surf_pre              ! surface pressure (Pa)
!      real :: tveg(1:mxlevcan_wrf)  ! save tveg 
      real :: wind(1:mxlevcan_wrf)  ! wind speed at canopy layer (m/s)
      real :: tair(1:mxlevcan_wrf)  ! air temp at canopy layer (K)
      real :: qair(1:mxlevcan_wrf)  ! air water vapor at canopy layer (kg/kg)
      real :: rho(1:mxlevcan_wrf)   ! air density at canopy layer (kg/M3)
      real :: co2(1:mxlevcan_wrf)   ! CO2  at canopy layer (ppmv)
      real :: tsoil(1:nlevgrnd)     ! temp  at soil layer (K)
      real :: qsoil(1:nlevgrnd)     ! moisture  at soil layer (m^3/m^3)
      real :: t10                   ! 10-day mean air temperature (K)
      real :: dayl_factor           ! Eq. 8.24
      real :: us                    ! friction velocity (m/s)    
      real :: Gsoil                 ! soil flux (W/m^2) + into soil
  end type mcm_force

  ! ---- canopy property, canopy model start from top to bottom ---
  type canopy_lai
      integer :: ipvt                ! vegetation type
      integer :: bl                  ! botton layer number in WRF grid, (not 1 in WRF-IBM)
      integer :: nw                  ! leyers in WRF, = tl - bl + 1
      real    :: h                   ! canopy heigt (m)
      real    :: z(1:mxlevcan_wrf)   ! canopy layer height, (m)
      real    :: dz(1:mxlevcan_wrf)  ! canopy layer height, dz (m)
      real    :: lad(1:mxlevcan_wrf) ! lai density, max 100 layers
      real    :: lad0(1:mxlevcan_wrf) ! base lai density, max 100 layers
      real    :: tlai                ! total lai
      real    :: lai(1:mxlevcan_wrf) ! lai at each layer, lai = lad*dz
      real    :: sai(1:mxlevcan_wrf) ! sai at each layer
      real    :: cd(1:mxlevcan_wrf)
      real    :: cd0  ! surface roughness coeff., cd0 = (0.4/(log((zi(1)+z0)/z0)))**2.0
  end type canopy_lai
  
  ! ---- soil property ---
  type Soil_property
      integer :: soilcol         ! soilcolor, used in surface albedo
      integer :: ipts            ! soil texture type
  
      real :: z(0:nlevgrnd)      ! layer depth (m)
      real :: dz(0:nlevgrnd)     ! layer thickness (m)
      real :: zi(0:nlevgrnd)     ! interface level below a "z" level (m)
      real :: rootfr(nlevgrnd)
      real :: rootr(nlevgrnd)    ! effective fraction of roots in each soil layer
        
      real :: bsw(nlevgrnd)      ! Clapp and Hornberger "b" (nlevgrnd)
      real :: watsat(nlevgrnd)   ! volumetric soil water at saturation (porosity)
      real :: hksat(nlevgrnd)    ! hydraulic conductivity at saturation (mm H2O /s)
      real :: sucsat(nlevgrnd)   ! minimum soil suction (mm) (nlevgrnd)
      real :: csol(nlevgrnd)     ! heat capacity, soil solids (J/m**3/Kelvin)
      real :: tkmg(nlevgrnd)     ! thermal conductivity, soil minerals  [W/m-K]
      real :: tkdry(nlevgrnd)    ! thermal conductivity, dry soil (W/m/Kelvin)
      real :: tksatu(nlevgrnd)   ! thermal conductivity, saturated soil [W/m-K]
  
      real :: cv (nlevgrnd)      ! heat capacity [J/(m2 K)]
      real :: tk (nlevgrnd)      ! thermal conductivity [W/(m K)]

!      real :: organic(nlevgrnd)  ! organic matter (kg/m3) 
      real :: zwt                ! water table depth (m)
      real :: btran              ! transpiration wetness factor (0 to 1)
      real :: ems                ! top layer soil emissivity 
  end type Soil_property
  

  type (canopy_lai), save :: CLAI1
  type (mcm_force), save :: MF1
  type (Soil_property), save :: SP1

  type (mcm_force), allocatable, save :: MF(:,:)
  type (canopy_lai), allocatable, save :: CLAI(:,:)
  type (Soil_property), allocatable, save :: SP(:,:)

  END MODULE mcm_data_mod 

! ===================================================================
! ===================================================================

 MODULE module_multi_layer_canopy_model_func

  CONTAINS

  !--------------------------------------------------------
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

  !--------------------------------------------------------
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

  !--------------------------------------------------------
  subroutine get_hgt_twj( hgt, HT, ims, ime, jms, jme )

! This subroutine was modified to not account for IBM since
! it is not implemented in this version of the ported code.

  implicit none
  INTEGER :: ims, ime, jms, jme
  REAL,DIMENSION(ims:ime,jms:jme) :: hgt, HT

  hgt = HT

  end subroutine get_hgt_twj

  !--------------------------------------------------------
  subroutine read_obs_driving( OBS_interval, itimestep, dt, &
                               sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   ! OBS Driving
                               lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C )     ! OBS Driving

  USE clm_varpar_my, only : date_CHATS, S_CHATS, sw_in_CHATS, lw_in_CHATS, &
          tsoil_CHATS, qsoil_CHATS, G_CHATS, Utop_CHATS, date_CHATS, NN

  implicit none
  integer :: itimestep
  real :: OBS_interval, dt  ! unit [s]
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

  !--------------------------------------------------------
  subroutine initiate_mcm_forest( SP, CLAI, MF, zi, nz, z0 )

  USE mcm_data_mod, only : Soil_property, canopy_lai, mcm_force
  USE clm_varpar_my, only : nlevgrnd, sc_p
  
  implicit none

  INTEGER, INTENT( IN )  :: nz
  REAL, DIMENSION(1:nz),INTENT(IN) :: zi
  real :: z0  !input roughness

  TYPE(Soil_property), INTENT(OUT) :: SP
  TYPE(canopy_lai),    INTENT(OUT) :: CLAI
  TYPE(mcm_force),     INTENT(OUT) :: MF

  integer :: i
  real :: sum_lai, LAI

  write(*,*), 'TWJ z0 = ', z0

  ! ------- canopy ground roughness coeff. ------
  if (zi(1) < 0.) then  ! This only happens when using IBM, surface drag is invalid
      CLAI%cd0 = 0.
  else
      CLAI%cd0 = (0.4/(log((zi(1)+z0)/z0)))**2.0
  endif
  !-------------------------

  CLAI%ipvt = 7  ! canopy type, TODO
! TWJ
  SP%ipts = 7 ! TODO
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

  !--------
  sum_lai = 0.
  do i = 1, CLAI%nw
     sum_lai = sum_lai + CLAI%lai(i)
  enddo
  write(*,*) 'lai', sum_lai
  !--------

  ! ------- driving force ------
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

  !--------------------------------------------------------

  subroutine initiate_mcm_grass( CLAI, zi, nz, z0 )

  USE mcm_data_mod, only : Soil_property, canopy_lai, mcm_force
  USE clm_varpar_my, only : nlevgrnd, sc_p
  
  implicit none

  INTEGER, INTENT( IN )  :: nz
  REAL, DIMENSION(1:nz),INTENT(IN) :: zi
  real :: z0  !input roughness

  TYPE(canopy_lai),    INTENT(OUT) :: CLAI

  ! ------- canopy ground roughness coeff. ------
  if (zi(1) < 0.) then  ! This only happens when using IBM, surface drag is invalid
      CLAI%cd0 = 0.
  else
      CLAI%cd0 = (0.4/(log((zi(1)+z0)/z0)))**2.0
  endif
  !-------------------------

  CLAI%nw = 0

  end subroutine initiate_mcm_grass

  !--------------------------------------------------------

!  subroutine initial_soil_1d( z, dz, zi, rootfr, bsw, watsat, hksat, sucsat, &
!                              csol, tkmg, tkdry, tksatu, ivt, its )
  subroutine initial_soil_1d( SP, CLAI )
  
  use clm_varpar_my, only :  roota_par, rootb_par, sand, clay, organic, nlevsoi, nlevgrnd
  USE mcm_data_mod, only : Soil_property, canopy_lai
  implicit none

  TYPE(Soil_property), INTENT(INOUT) :: SP
  TYPE(canopy_lai),    INTENT(IN)    :: CLAI

!  integer, intent(in) :: ivt             ! vegetation type
!  integer, intent(in) :: its             ! soil texture type
!!  real, intent(in) :: organic(nlevgrnd)  ! organic material (kg/m^3)

!  real, intent(out) :: z(0:nlevgrnd)     ! layer depth (m)
!  real, intent(out) :: dz(0:nlevgrnd)    ! layer thickness (m)
!  real, intent(out) :: zi(0:nlevgrnd)    ! interface level below a "z" level (m)
!  real, intent(out) :: rootfr(nlevgrnd)
    
!  real, intent(out) :: bsw(nlevgrnd)     ! Clapp and Hornberger "b" 
!  real, intent(out) :: watsat(nlevgrnd)  ! volumetric soil water at saturation (porosity)
!  !real, intent(out) :: watdry(nlevgrnd)  ! btran parameter for btran=0
!  !real, intent(out) :: watopt(nlevgrnd)  ! btran parameter for btran = 1
!  !real, intent(out) :: watfc(nlevgrnd)   ! volum. soil water at field capacity (nlevsoi)
!  real, intent(out) :: hksat(nlevgrnd)   ! hydraulic conductivity at saturation (mm H2O/s)
!  real, intent(out) :: sucsat(nlevgrnd)  ! minimum soil suction (mm) (nlevgrnd)
!  real, intent(out) :: csol(nlevgrnd)    ! heat capacity, soil solids (J/m**3/Kelvin)
!  real, intent(out) :: tkmg(nlevgrnd)    ! thermal conductivity, soil minerals  [W/m-K]
!  real, intent(out) :: tkdry(nlevgrnd)   ! thermal conductivity, dry soil (W/m/Kelvin)
!  real, intent(out) :: tksatu(nlevgrnd)  ! thermal conductivity, saturated soil [W/m-K]

  ! ------ local ------
  real :: scalez       = 0.025 ! Soil layer thickness discretization (m)
  real :: om_watsat    = 0.9   ! porosity of organic soil
  real :: om_hksat     = 0.1   ! saturated hydraulic conductivity of organic soil [mm/s]
  real :: om_tkm       = 0.25  ! thermal conductivity of organic soil (Farouki, 1986) [W/m/K]
  real :: om_sucsat    = 10.3  ! saturated suction for organic matter (Letts, 2000)
  real :: om_csol      = 2.5   ! heat capacity of peat soil *10^6 (J/K m3) (Farouki, 1986)
  real :: om_tkd       = 0.05  ! thermal conductivity of dry organic soil (Farouki, 1981)
  real :: om_b         = 2.7   ! Clapp Hornberger paramater for oragnic soil (Letts, 2000)
  real :: organic_max  = 130.  ! organic matter (kg/m3) where soil is assumed to act like peat
  real :: csol_bedrock = 2.0e6 ! vol. heat capacity of granite/sandstone J/(m3 K)(Shabbir, 2000)
  real :: pc           = 0.5   ! percolation threshold
  real :: pcbeta       = 0.139 ! percolation exponent
  real :: zsapric      = 0.5   ! depth (m) that organic matter takes on characteristics of sapric peat

  real :: perc_frac            ! "percolating" fraction of organic soil
  real :: perc_norm            ! normalize to 1 when 100% organic soil
  real :: uncon_hksat          ! series conductivity of mineral/organic soil
  real :: uncon_frac           ! fraction of "unconnected" soil
  real :: bd                   ! bulk density of dry soil material [kg/m^3]
  real :: tkm                  ! mineral conductivity
  real :: xksat                ! maximum hydraulic conductivity of soil [mm/s]
  real :: om_frac
  real :: rootfr_sum

  real :: om_watsat1,  om_b1, om_sucsat1, om_hksat1

  integer :: j

! TWJ
  integer :: ivt, its

  ivt = CLAI%ipvt
  its = SP%ipts

  SP%z(0) = 0.
  do j = 1, nlevgrnd
      SP%z(j) = scalez*(exp(0.5*(j - 0.5)) - 1.)    ! node depths
  enddo
!write(*,*) z

  SP%dz(1) = 0.5*(SP%z(1) + SP%z(2))             ! thickness b/n two interfaces
  do j = 2,nlevgrnd-1
      SP%dz(j) = 0.5*(SP%z(j+1) - SP%z(j-1))
  enddo
  SP%dz(nlevgrnd) = SP%z(nlevgrnd) - SP%z(nlevgrnd-1)

  SP%zi(0) = 0.
  do j = 1, nlevgrnd-1
      SP%zi(j) = 0.5*(SP%z(j) + SP%z(j+1))       ! interface depths
  enddo
  SP%zi(nlevgrnd) = SP%z(nlevgrnd) + 0.5*SP%dz(nlevgrnd)

  !------------------------
  rootfr_sum = 0.
  do j = 1, nlevsoi-1
     SP%rootfr(j) = 0.5*( exp(-roota_par(ivt) * SP%zi(j-1))  &
                        + exp(-rootb_par(ivt) * SP%zi(j-1))  &
                        - exp(-roota_par(ivt) * SP%zi(j  ))  &
                        - exp(-rootb_par(ivt) * SP%zi(j  )) )
     !if (j == 1) rootfr(j) = rootfr(j) * 0.2
     !if (j == 2) rootfr(j) = rootfr(j) * 0.3
     !if (j == 3) rootfr(j) = rootfr(j) * 0.3
     !if (j == 4) rootfr(j) = rootfr(j) * 0.6
     !if (j == 5) rootfr(j) = rootfr(j) * 0.7
     !if (j == 6) rootfr(j) = rootfr(j)
     !if (j == 7) rootfr(j) = rootfr(j)
     rootfr_sum = rootfr_sum + SP%rootfr(j)
  enddo
  SP%rootfr(nlevsoi) = 0.5*( exp(-roota_par(ivt) * SP%zi(nlevsoi-1))  &
                           + exp(-rootb_par(ivt) * SP%zi(nlevsoi-1)) )
  SP%rootfr(nlevsoi+1:nlevgrnd) = 0.

  do j = 1, nlevsoi
     SP%rootfr(j) = SP%rootfr(j) / rootfr_sum
  enddo

  !------------------------
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

      ! perc_frac is zero unless perf_frac greater than percolation threshold
      if (om_frac > pc) then
          perc_norm = (1. - pc)**(-pcbeta)
          perc_frac = perc_norm*(om_frac - pc)**pcbeta
      else
          perc_frac = 0.
      endif
      ! uncon_frac is fraction of mineral soil plus fraction of "nonpercolating" organic soil
      uncon_frac = (1. - om_frac) + (1. - perc_frac)*om_frac
      xksat      = 0.0070556 * ( 10.**(-0.884 + 0.0153*sand(its)) ) ! mm/s
      ! uncon_hksat is series addition of mineral/organic conductivites
      if (om_frac < 1.) then
          uncon_hksat = uncon_frac/( (1. - om_frac)/xksat + (1. - perc_frac)*om_frac/om_hksat )
      else
          uncon_hksat = 0.
      endif
      SP%hksat(j)  = uncon_frac*uncon_hksat + perc_frac*om_frac*om_hksat

      tkm       = (1. - om_frac)*(8.80*sand(its) + 2.92*clay(its))/(sand(its) + clay(its)) &
                  + om_tkm*om_frac   ! W/(mK)
      SP%tkmg(j)   = tkm**(1. -  SP%watsat(j))

      SP%tksatu(j) = SP%tkmg(j)*0.57**SP%watsat(j)

      bd        = (1. - (0.489 - 0.00126*sand(its)))*2.7e3
      SP%tkdry(j)  = (0.135*bd + 64.7)/(2.7e3 - 0.947*bd)*(1. - om_frac) + om_tkd*om_frac

      SP%csol(j)   = 1.e6 * ( (1. - om_frac)*(2.128*sand(its) + 2.385*clay(its)) &
                           /(sand(its) + clay(its)) + om_csol*om_frac )  ! J/(m3 K)
      if (j > nlevsoi) then
          SP%csol(j) = csol_bedrock
      endif

      ! watdry(j) = watsat(j) * (316230./sucsat(j))**(-1./bsw(j))
      ! watopt(j) = watsat(j) * (158490./sucsat(j))**(-1./bsw(j))
      !! added by K.Sakaguchi for beta from Lee and Pielke, 1992
      ! water content at field capacity, defined as hk = 0.1 mm/day
      ! used eqn (7.70) in CLM3 technote with k = 0.1 (mm/day) / 86400 (day/sec)
      ! watfc(j) = watsat(j) * (0.1 / (hksat(j)*86400.))**(1./(2.*bsw(j)+3))

      ! TWJ
      SP%ems = 0.97 ! from CLM, assume no snow

  enddo

  end subroutine initial_soil_1d

!==============================================================
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
  do while( .TRUE. )    ! LOOP IN  STIE FILE
     read( 123, *, iostat = io ) lad(i), lad_ht(i)
     if (io < 0) exit
     i = i + 1
  enddo
  nlevel = i - 1 
  close(123)

  end subroutine read_lai

!=============================================================

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
 
!=============================================================

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

  CALL random_seed()         ! see example of RANDOM_SEED
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
 
!=============================================================
!=============================================================

  subroutine random_lai(CLAI)
  USE mcm_data_mod, only : canopy_lai
  implicit none
  
  TYPE(canopy_lai),    INTENT(OUT) :: CLAI
  integer :: i, nw
  real, allocatable, dimension(:) :: rand

  nw = CLAI%nw
  allocate(rand(nw))

  CALL random_seed()         ! see example of RANDOM_SEED
  CALL RANDOM_NUMBER(rand)

  !rand = (rand - 0.5)*2.  ! [-1, 1]

  !do i = 1, CLAI%nw
  !    CLAI%lad(i) = CLAI%lad0(i) + CLAI%lad0(i) * rand(i)*0.4  ! 30% variation
  !enddo
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
 
!=============================================================

  subroutine lai_wrf_grid( tlai, lai_z, lad_z, h, z, dz, bl, numcan_wrf, zi, nz )

  use clm_varpar_my, only : mxlevcan_wrf 
  implicit none

  integer :: nz
  real, dimension(1:nz), intent(in) :: zi  ! above surf (m), start from surf to canopy top

  real, dimension(1:mxlevcan_wrf), intent(out) :: lai_z, lad_z, z, dz
  real :: h, tlai
  integer, intent(out) :: bl               ! bottom layer layer in zi
  integer, intent(out) :: numcan_wrf       ! layers in MCM

  ! ------ local ------
  integer :: nlevel   ! levels read from usr input
  real :: cht         ! canopy height from usr input
  real :: lad(200), lad_ht(200) ! lai density and relative canopy height
  real :: lh(200)
  real, dimension(1:mxlevcan_wrf) :: lai_z_tmp, lad_z_tmp, z_tmp, dz_tmp
  integer :: k, ir, tl
 
  call read_lai( nlevel, lad, lad_ht, cht, tlai )
  lh = lad_ht*cht
  h = cht  ! canopy height

  if ( zi(nz) < cht ) then
      write(*,*) 'Input layers height are wrong!', nz, zi(nz), cht 
      STOP
  endif

  ! --- for WRF-IBM, zi might be negative (below surface)
  k = 1
  do while ( k < nz )
      if ( zi(k) > 0. ) then
          bl = k  ! bottom layer
          exit
      endif
      k = k + 1
  enddo

  ! --- lai density ---
  do k = bl, nz
      if ( zi(k) <= cht ) then
          call to_zk2( zi(k), lh(1:nlevel), lad(1:nlevel), nlevel, lad_z_tmp(k) )
          z_tmp(k) = zi(k)
          tl = k  ! top layer
      else
          exit
      endif 
  enddo

  ! --- lai at each layer ---
  dz_tmp(bl) = zi(bl) + 0.5*( zi(bl+1) - zi(bl) )
  dz_tmp(tl) = cht - zi(tl) + 0.5*( zi(tl) - zi(tl-1) )
  do k = bl+1, tl-1
      dz_tmp(k) = 0.5* ( zi(k+1) - zi(k) ) + 0.5*( zi(k) - zi(k-1) )   
  enddo

  do k = bl, tl
      lai_z_tmp(k) = lad_z_tmp(k) * dz_tmp(k)
  enddo

  ! --- reverse, canopy model start from top
  numcan_wrf = tl - bl + 1
  do ir = 1, numcan_wrf
      k = numcan_wrf - ir + bl  ! nw = tl - bl + 1
      lai_z(ir) = lai_z_tmp(k)
      lad_z(ir) = lad_z_tmp(k)
      z(ir)  = z_tmp(k)
      dz(ir) = dz_tmp(k)
  enddo
 
  end subroutine lai_wrf_grid
 
!=============================================================
  subroutine simple_mcm_heat_profile( sh_out, C, rho, Qtop, WRF_var, kms, kme)

  USE clm_varpar_my, only : mxlevcan_wrf, cpair
  USE mcm_data_mod,  only : canopy_lai

  implicit none

  real, INTENT(INOUT) :: sh_out(mxlevcan_wrf)  ! W/m^2, positvie to air
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
  do while( .TRUE. )    ! LOOP IN  STIE FILE
     read( 123, *, iostat = io ) sh(i), zoh(i)  ! z/h
     if (io < 0) exit
     i = i + 1
  enddo
  nlev = i - 1 
  close(123)

!  do k = 1, nw
!     zoh(k) = 1. - zoh(k)  !top layer is 1
!  enddo

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

  ! -- out put --
  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  ! numcan_wrf = tl - bl + 1
      WRF_var(k) = sh_out(ir)
  ENDDO
  ! -- out put --
  
  DO k = 1, nw
      sh_out(k) = sh_out(k)*cpair*rho(k)  ! K m /s to W/m^2
  ENDDO

  end subroutine simple_mcm_heat_profile
!=============================================================

  subroutine simple_mcm( qv_mcm, sh_mcm, an_mcm, &
                         C, rho)

  USE clm_varpar_my, only : mxlevcan_wrf, cpair
  USE mcm_data_mod,  only : canopy_lai
  IMPLICIT NONE

  TYPE(canopy_lai),    INTENT(IN)    :: C

  real, intent(inout) :: qv_mcm(mxlevcan_wrf)  ! kg/m^2/s, positive to air
  real, intent(inout) :: sh_mcm(mxlevcan_wrf)  ! W/m^2, positvie to air
  real, intent(inout) :: an_mcm(mxlevcan_wrf)  ! (umol CO2/m**2/s)
  real :: rho(mxlevcan_wrf)

  real :: Qtop  ! Km/s, user set
  integer :: nw, iv, bl, tl, k, ir
  real :: tlai1, tlai2, tsh

  !-------- heat at canopy top (K m/s)---
  !Qtop = -0.0001
  Qtop = 0.0

  qv_mcm(:) = 0.
  sh_mcm(:) = 0.
  an_mcm(:) = 0.

  nw = C%nw
  bl = C%bl

  !cpair  = 1.00464e3 ! specific heat of dry air [J/kg/K]
  ! Km/s -> W/m^2 = Qtop*cpair*rho

  ! -- grass land ---
  if (nw == 0) then
     !sh_mcm(1) = -0.03
     sh_mcm(1) = Qtop
     !sh_mcm(1) = -0.01
     sh_mcm(1) = sh_mcm(1)  ! For grass, unit is K m /s, since rho(1)=-9999
     !sh_mcm(1) = sh_mcm(1)*cpair*rho(1)  ! K m /s to W/m^2
  endif

  if (nw > 0) then
      tlai1 = 0.
      do iv = 1, nw
          tlai2 = tlai1 + C%lai(iv)
          !sh_out(iv) = Qtop * (exp(-0.6*tlai1) - exp(-0.6*tlai2))/C%dz(iv)
          sh_mcm(iv) = Qtop * (exp(-0.6*tlai1) - exp(-0.6*tlai2))
          tlai1 = tlai2
      enddo

      !sh_mcm(nw) = -Qtop*0.1
      !sh_mcm(nw-1) = -Qtop*0.03

      tsh = 0.
      do iv = 1, nw
          tsh = tsh + sh_mcm(iv)
      enddo

      do k = 1, nw
          sh_mcm(k) = sh_mcm(k) * Qtop/tsh
      enddo

      DO iv = 1, nw
          sh_mcm(iv) = sh_mcm(iv)*cpair*rho(iv)  ! K m /s to W/m^2
      ENDDO
  endif

  end subroutine simple_mcm

!=============================================================

 SUBROUTINE multi_layer_canopy( qv_out, sh_out, an_out, LEg, SHg, C, S, M,    &
                                sw_can_z, lw_can_z, efsh_z, efe_z )
                                !!, &sw_out, lw_out )
                                !! ----
                                !tveg_z, psncan, psncan_ac, psncan_aj, gscan, rs_sun_z, rs_sha_z, &
                                !rb_z, t_source, sw_grnd, lw_grnd, lw_out, &
                                !ac_sun_z, aj_sun_z, an_sun_z, an_sha_z, lmr_z, btran_z, &
                                !eflx_sh_grnd, qflx_ev_grnd, parsun_z_1, parsha_z_1, sw_out, &
                                !t_grnd, rsoil)

  USE clm_varpar_my, only : nlevgrnd, mxlevcan_wrf, numrad, hvap, cpair
  USE mcm_data_mod,  only : mcm_force, canopy_lai, Soil_property
  IMPLICIT NONE
 
  TYPE(canopy_lai),    INTENT(IN)    :: C
  TYPE(Soil_property), INTENT(INOUT) :: S  ! S%tk, S%cv, S%btran
  TYPE(mcm_force),     INTENT(INOUT) :: M  ! M%tsoil, M%qsoil

  REAL, DIMENSION(mxlevcan_wrf), INTENT(INOUT) :: sw_can_z, &
                                                  lw_can_z, &
                                                  efe_z,    &
                                                  efsh_z

  ! --- MCM output ---
  real, INTENT(INOUT) :: qv_out(mxlevcan_wrf)  ! kg/m^2/s, positive to air
  real, INTENT(INOUT) :: sh_out(mxlevcan_wrf)  ! W/m^2, positvie to air
  real, INTENT(INOUT) :: an_out(mxlevcan_wrf)  ! (umol CO2/m**2/s)
  real, INTENT(OUT) :: LEg, SHg

 !------ local ------
  real :: ag_out(mxlevcan_wrf)  ! (umol CO2/m**2/s)
  real :: parsun_z_1(mxlevcan_wrf)
  real :: parsha_z_1(mxlevcan_wrf)
!  real :: sw_can_z(mxlevcan_wrf)    ! absorbed sw at each canopy layer
!  real :: lw_can_z(mxlevcan_wrf)    ! absorbed lw at each canopy layer
!  real :: efe_z(mxlevcan_wrf)       ! latent heat flux from leaf (W/m^2)
!  real :: efsh_z(mxlevcan_wrf)      ! sensible heat flux from leaf (W/m^2)
  real :: fn_z(mxlevcan_wrf)        ! canpy layer energy residual
  real :: sw_grnd                   ! solar radiation absorbed by ground (W/m**2)
  real :: lw_grnd                   ! longwave radiation absorbed by ground (W/m**2)
  real :: eflx_sh_grnd              ! sensible heat flux from ground (W/m**2) [+ to atm]
  real :: qflx_ev_grnd              ! soil evaporation (kg/m**2/s) (+ = to atm)
  real :: sw_out

  real :: t_source(mxlevcan_wrf)

  real :: tveg_z(mxlevcan_wrf)      ! canopy layer temp. (K)
  real, save :: tveg_z_save(mxlevcan_wrf) = -999.     ! canopy layer temp. (K)

  real :: rb_z(mxlevcan_wrf)        ! boundary layer resistance (s/m)
  real :: rah                       ! surface aerodynamic resistance (s/m)
  real :: rsoil                     ! aerodynamic resistance (s/m)

  real :: an_sun_z(mxlevcan_wrf)          ! net leaf photosynthesis (umol CO2/m**2/s)
  real :: an_sha_z(mxlevcan_wrf)          ! net leaf photosynthesis (umol CO2/m**2/s)

  real :: parsun_z(numrad,mxlevcan_wrf)   ! absorbed PAR for sunlit leaves in canopy layer
  real :: parsha_z(numrad,mxlevcan_wrf)   ! absorbed PAR for shaded leaves in canopy layer
  real :: fsun_z(mxlevcan_wrf)            ! sunlit fraction of canopy layer, 0 - 1.0

  real :: rs_sun_z(mxlevcan_wrf)          ! canopy layer: leaf stomatal resistance (s/m)
  real :: rs_sha_z(mxlevcan_wrf)          ! canopy layer: leaf stomatal resistance (s/m)
  real :: gs_sun_z(mxlevcan_wrf)          ! leaf stomatal conductance (umol H2O/m**2/s)
  real :: gs_sha_z(mxlevcan_wrf)          ! leaf stomatal conductance (umol H2O/m**2/s)

  real :: psncan_ac, psncan_aj

  real :: ci_sun_z(mxlevcan_wrf)          ! intracellular leaf CO2 (Pa)
  real :: ci_sha_z(mxlevcan_wrf)          ! intracellular leaf CO2 (Pa)
  real :: ac_sun_z(mxlevcan_wrf)          
  real :: ac_sha_z(mxlevcan_wrf)          
  real :: aj_sun_z(mxlevcan_wrf)          
  real :: aj_sha_z(mxlevcan_wrf)          
  real :: ap_sun_z(mxlevcan_wrf)          
  real :: ap_sha_z(mxlevcan_wrf)          
  real :: ag_sun_z(mxlevcan_wrf)          
  real :: ag_sha_z(mxlevcan_wrf)          
  real :: lmr_z(mxlevcan_wrf)          

  real :: qflx_tran_veg                   ! canopy transpiration (mm H2O/s) (+ = to atm)

  real :: cgrnd   ! deriv. of soil energy flux wrt to soil temp [w/m2/k] (dH/dT + d(rE)/dT)
  real :: psncan, gscan, lw_out
  real :: btran_z(nlevgrnd)
  real :: topo_slope = 0.
  real :: t_grnd, Utop, Ttop, Qtop, An_soil

  INTEGER ::  k, iv, iter, nw

  qv_out = 0.
  sh_out = 0.
  an_out = 0.

  nw = C%nw
  IF (nw == 0) RETURN   ! only for forest canopies, skip non-forested cells

  Utop = M%wind(99)
  Ttop = M%tair(1)
  Qtop = M%qair(1)

!  call spd_porfile(M%wind, C%h, C%lad, C%z, Utop, nw)

  call boundary_layer_resistance_rb( rb_z, M%wind, nw, C%ipvt )
  !rb_z = 50.

! TWJ
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
!  S%btran = min(S%btran, 1.0) + 0.3
  !write(*,*) S%btran
  !SSS

  tveg_z = M%tair  ! initial guess for Photosynthesis module
  t_grnd = M%tsoil(1)
  do iter = 1, 3
      ! canopy and soil absorbed lw radiation
      call Lw_Canopy( C%ipvt, M%lwd, tveg_z, M%tair, t_grnd, S%ems, &
                      C%lai, C%sai, nw, lw_can_z, lw_grnd, lw_out )

      !call Photosynthesis( rs_sun_z, rs_sha_z, ci_sun_z, ci_sha_z,           &
      !                     an_sun_z, an_sha_z, ac_sun_z, ac_sha_z,           &
      !                     aj_sun_z, aj_sha_z, ap_sun_z, ap_sha_z,           &
      !                     lmr_z, &
      !                     gs_sun_z, gs_sha_z, psncan, psncan_ac, psncan_aj, gscan,     &
      !                     C%ipvt, M%surf_pre, parsun_z(1,:), parsha_z(1,:), &
      !                     M%tair, M%co2, tveg_z, M%qair, C%lai, fsun_z,     &
      !                     M%t10, M%dayl_factor, S%btran, rb_z, nw ) 

!      TWJ
!      write(*,*) 'Entering Photosynthesis_new ...'

      call Photosynthesis_new( gs_sun_z, gs_sha_z, an_sun_z, an_sha_z, &
                               ag_sun_z, ag_sha_z, &
                               M%surf_pre, M%tair, M%qair, M%co2, &
                               tveg_z, tveg_z, fsun_z, C%lai, rb_z, &
                               parsun_z(1,:), parsha_z(1,:), nw ) 

      qflx_tran_veg = 0.  ! [mm H20 /s], used as sink term in soil water
      do iv = 1, nw
         ! transpiration flux, only on leaf (no evaporation)

          call en_brent( fn_z(iv), tveg_z(iv), iv, efe_z(iv), efsh_z(iv), t_source(iv),  &
                         S%btran, M%tair(iv), M%qair(iv), M%rho(iv), M%surf_pre, &
                         rb_z(iv), 1./gs_sun_z(iv), 1./gs_sha_z(iv), fsun_z(iv),       &
                         !rb_z(iv), rs_sun_z(iv), rs_sha_z(iv), fsun_z(iv),       &
                         C%lai(iv), C%sai(iv), sw_can_z(iv), lw_can_z(iv), tveg_z_save(iv) )

          efe_z(iv) = efe_z(iv)*C%lai(iv)
          efsh_z(iv) = efsh_z(iv)*C%lai(iv)

          !write(*,*) efe_z(iv), efsh_z(iv)

          !qflx_tran_veg = qflx_tran_veg - efe_z(iv)/(hvap*M%rho(iv))
          qflx_tran_veg = qflx_tran_veg - efe_z(iv)/(hvap)
      enddo

      call Surface_energy_balance_new( SHg, LEg, t_grnd, rsoil, M%surf_pre, &
                                       sw_grnd + lw_grnd, M%Gsoil, M%tair(nw), &
                                       M%qair(nw), M%qsoil(1), M%tsoil(1), Utop,  sw_grnd )

!      call scalar_transfer(M%tair, C%h, C%lad, C%lai, C%z, Ttop, &
!                          -efsh_z/cpair/M%rho(1), SHg/cpair/M%rho(1), nw )
!
!      call scalar_transfer(M%qair, C%h, C%lad, C%lai, C%z, Qtop, &
!                          -efe_z/hvap, LEg/hvap, nw )
  enddo
  tveg_z_save = tveg_z
  !write(*,*) M%tair(1:nw)
  
  do iv = 1, nw
      lw_can_z(iv) = lw_can_z(iv)*C%lai(iv)
      sw_can_z(iv) = sw_can_z(iv)*C%lai(iv)
  enddo
  !=============================

  ! ----- soil water and temp ------
  ! soil water effects btran, assume btran doesn't change top much, 
  ! so the function move out of inter loop
  ! vegetation transpiration (mm H2O/s) (+ = to atm)

  !CALL SoilThermProp( S%tk, S%cv,       & ! Thermal conductivity and Heat capacity
  !                    M%tsoil, M%qsoil, & 
  !                    S%dz, S%zi, S%z, S%watsat, S%tkmg, S%tkdry, S%csol )

  !CALL Surface_energy_balance( eflx_sh_grnd, qflx_ev_grnd, cgrnd,             &
  !                             rah, rsoil,                                    &
  !                             M%qair(nw), M%tair(nw), M%rho(nw), M%surf_pre, &
  !                             M%qsoil(1), M%tsoil(1), M%us, M%coszen,                 &
  !                             S%dz(1), S%bsw(1), S%watsat(1), S%sucsat(1) )
  !
  !CALL SoilWater( M%qsoil, qflx_ev_grnd, qflx_tran_veg,    &
  !                M%tsoil, M%dt, S%z, S%dz, S%zi, S%watsat,&
  !                S%hksat, S%bsw, S%sucsat, S%rootr, S%zwt, topo_slope )

  !CALL SoilTemperature( M%tsoil, eflx_sh_grnd, qflx_ev_grnd,              &
  !                      M%qsoil, cgrnd, lw_grnd, sw_grnd,                 &
  !                      M%dt, S%z, S%dz, S%zi, S%watsat, S%tkmg, S%tkdry, &
  !                      S%csol, S%tk, S%cv, S%ems )


!=========================================

!==================
! Palmroth et al. 2005, fitted by 5cm data from CHATS
!An_soil = 0.4016*exp(0.1151*(M%tsoil(1)-273.15))*(1.-exp(-31.353*M%qsoil(1)+4.311))
An_soil = 5.5
!==================

! !--- model out ----
  DO iv = 1, nw 
      qv_out(iv) = -efe_z(iv)/hvap  ! kg/m^2/s, positive to air
      sh_out(iv) = -efsh_z(iv)      ! W/m^2, positvie to air
      an_out(iv) = -an_sun_z(iv) - an_sha_z(iv) ! (umol CO2/m**2/s)
      ag_out(iv) = -ag_sun_z(iv) - ag_sha_z(iv) ! (umol CO2/m**2/s)
      !an_out(iv) = -an_sun_z(iv)*fsun_z(iv)*C%lai(iv) - &
      !             an_sha_z(iv)*(1.-fsun_z(iv))*C%lai(iv) ! (umol CO2/m**2/s)
      !write(*,*) qv_out(iv), sh_out(iv), an_out(iv), ag_out(iv)
  ENDDO
  
  ! surface source
  qv_out(nw) = qv_out(nw) + LEg/hvap
  sh_out(nw) = sh_out(nw) + SHg
  !an_out(nw) = an_out(nw) + 5.5 ! constant soil source, CHATS
  an_out(nw) = an_out(nw) + An_soil
  !an_out(nw) = 0.
  !an_out(nw) = an_out(nw) + 9.3 ! constant soil source, Katul

 ! test!!
  !qv_out(nw) = qv_out(nw) + SHg/hvap
  !an_out(nw) = an_out(nw) + SHg/20. ! constant soil source

  gscan = 0.
  DO iv = 1, nw 
      !write(*,*) gscan, C%lai(iv), rb_z(iv), rs_sun_z(iv)
      gscan = gscan + fsun_z(iv)*(gs_sun_z(iv)) + (1.-fsun_z(iv))*(gs_sha_z(iv))
  ENDDO
  gscan = gscan/nw

!write(*,*) S%zwt

 end SUBROUTINE multi_layer_canopy

!=============================================================
!=============================================================

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
 
!==============================================================

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
  
  !cpm_eff = rho * cpair * (1. + 0.8 *qair)  + 0.05*tlai*4.2e4
            !2760. * 4.21*tlai/1.5*0.4  ! tree, kiefer et al. 2013

  !efsh = 2.* rho * cpair * (1. + 0.8 *qair1) * ( tair - tv ) * ( tlai + tsai )/rb1
  efsh = 2.* rho * cpair * (1. + 0.8 *qair) * ( tair - tv ) /rb

  !efsh_veg = 1.6*efsh  ! 10 days simulation
  efsh_veg = 1.3*efsh
  !efsh_veg = sc_p(1)*(sw_can + lw_can)
  !efsh_veg = -0.09*(sw_can + lw_can)

  !--------------- LE ----------
  call Qsat(tv, pbot, tmp1, tmp2, qsat_tv, tmp3)
  
  efe_tmp = (qsat_tv - qair) * ( fsun/(rb+rs_sun) + (1.-fsun)/(rb+rs_sha) )

  if (qsat_tv - qair < 0. ) efe_tmp = 0.

  efe = -hvap*rho*efe_tmp
  
  fout = sw_can + lw_can + efsh + efe + efsh_veg

!  TWJ
!  write (*,*) 'In subroutine energy_func'

!  if (fout < -999.) then
!    write(*,*) '!!!!!!!!!!!'
!    write(*,*) sw_can, lw_can, efsh, efe, efsh_veg, fout
!    write(*,*) rho, cpair, qair, tair, tv, rb
!  endif

  end subroutine energy_func

!==============================================================

  subroutine en_brent( fb, tv, iv, efe, efsh, ts, &
                       btran, tair, qair, rho, pbot, &
                       rb, rs_sun, rs_sha, fsun, tlai, tsai,     &
                       sw_can , lw_can, tv_save )

! !DESCRIPTION:
! Use Brent's method to find the root of a single variable function, 
! which is known to exist between x1 and x2.
! The found root will be updated until its accuracy is tol.

  USE clm_varpar_my, only :  hvap, cpair
  implicit none
  real, intent(out) :: tv, fb, efe ,efsh, ts
  integer, intent(in) :: iv  ! test

  real, intent(in) :: btran, tair, qair, rho, rb, rs_sun, rs_sha, fsun, tlai, tsai, &
                      sw_can , lw_can, pbot, tv_save

  ! ------ local ------
  real :: x1, x2, f1, f2  
  !minimum and maximum of the variable domain to search for the solution
  integer, parameter :: ITMAX = 40            !maximum number of iterations
  real, parameter :: EPS = 1.e-4       !relative error tolerance

  integer :: iter, i
  real :: a,b,c,d,e,fa,fc,p,q,r,s,tol1,xm
  real :: x_tmp, x_save, f_tmp, f_save

  ! initial guess
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
      !write(*,*) 'root must be bracketed for brent in engerg_cun', &
      !            iv, x1, x2, f1, f2, sw_can, lw_can
      !f_save = 1.e6
      !do i = 1, 300 
      !    x_tmp = tair - 10. + i*0.1
      !    call energy_func( f_tmp, x_tmp, efe, efsh, ts, tv_save, &
      !                      btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, fsun, &
      !                      tlai, tsai, sw_can, lw_can, hvap, cpair )
      !    if (f_tmp < f_save) then
      !        f_save = f_tmp
      !        x_save = x_tmp
      !    endif
      !enddo

      !tv = x_save
      !fb = f_save

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
          c = a   !Rename a, b, c and adjust bounding interval d.
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
      tol1 = 2.*EPS*abs(b)  !Convergence check.
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          tv=b
          call energy_func( fb, b, efe, efsh, ts, tv_save, &
                            btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, &
                            fsun, tlai, tsai, sw_can , lw_can, hvap, cpair)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa !Attempt inverse quadratic interpolation.
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q !Check whether in bounds.
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d !Accept interpolation.
              d = p/q
          else
              d = xm  !Interpolation failed, use bisection.
              e = d
          endif
      else !Bounds decreasing too slowly, use bisection.
          d = xm
          e = d
      endif

      a = b !Move last best guess to a.
      fa = fb
      if(abs(d) > tol1) then !Evaluate new trial root.
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif
          call energy_func( fb, b, efe, efsh, ts, tv_save, & 
                            btran, tair, qair, rho, pbot, rb, rs_sun, rs_sha, &
                            fsun, tlai, tsai, sw_can , lw_can, hvap, cpair)
      if( fb == 0.) exit
  enddo

!  if(iter == ITMAX) write(*,*) 'brent exceeding maximum iterations', b, fb

  tv = b
  return

  end subroutine en_brent

!==============================================================

  subroutine clm_multi_layer_lai( tlai_z_wrf, tsai_z_wrf, numcan_wrf, dincmax,        &
                                  tlai, tsai, tlai_z, tsai_z, laisum, mxlevcan, nrad, &
                                  laisum_wrf )

  ! Diagnose number of canopy layers for radiative transfer, in increments of dincmax.
  ! Add to number of layers so long as cumulative leaf+stem area does not exceed total
  ! leaf+stem area. Then add any remaining leaf+stem area to next layer and exit the loop.
  ! Do this first for elai and esai (not buried by snow)
  ! tlai_z summed from 1 to nrad = elai
  ! tlai_z summed from 1 to ncan = tlai

  USE clm_varpar_my, only :  mxlevcan_wrf
  implicit none

  INTEGER, INTENT(IN) :: numcan_wrf
  INTEGER, INTENT(IN) :: mxlevcan
  REAL,    INTENT(IN) :: tlai_z_wrf(1:mxlevcan_wrf)      ! tlai increment for canopy layer
  REAL,    INTENT(IN) :: tsai_z_wrf(1:mxlevcan_wrf)      ! tsai increment for canopy layer
  REAL,    INTENT(INOUT) :: dincmax                         ! lai+sai increment for canopy layer

  REAL, INTENT(OUT) :: tlai              ! one-sided leaf area index, no burying by snow
  REAL, INTENT(OUT) :: tsai              ! one-sided stem area index, no burying by snow
  REAL, INTENT(OUT) :: tlai_z(mxlevcan)  ! tlai increment for canopy layer
  REAL, INTENT(OUT) :: tsai_z(mxlevcan)  ! tsai increment for canopy layer
  REAL, INTENT(OUT) :: laisum(mxlevcan)  ! cumulative lai+sai (at middle of canopy layer)
  REAL, INTENT(OUT) :: laisum_wrf(1:mxlevcan_wrf)
  INTEGER, INTENT(OUT) :: nrad           ! canopy layer in CLM

  ! ------ local ------
  real :: dinc              ! lai+sai increment for canopy layer
  real :: dincmax_sum       ! cumulative sum of maximum lai+sai increment for canopy layer
  real, parameter:: mpe = 1.0e-6  ! prevents overflow for division by zero
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
  !write(*,*) tlai

  ! lai and sai are assumed to the have same shape!!  Yulong

  !dincmax = 0.04   ! original value is 0.25 in CLM4.5
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

!==============================================================

  subroutine SurfaceRadiation( forc_solad, forc_solai, coszen, h2osoi_vol_surf,     &
                               tlai_z_wrf, tsai_z_wrf, numcan_wrf, ivt, soilcol,    &
                               parsun_z_wrf, parsha_z_wrf, fsun_z_wrf, sw_can_z, sabg, sw_out )
! !DESCRIPTION:
! Calculate solar fluxes absorbed by vegetation and ground surface

  USE clm_varpar_my, only : numrad, rhol, rhos, taul, taus, xl, mxlevcan_wrf, mincoszen

  IMPLICIT NONE

  ! --- input ---
  REAL, INTENT(IN) :: forc_solad(numrad)        ! direct beam radiation (W/m**2)
  REAL, INTENT(IN) :: forc_solai(numrad)        ! diffus radiation (W/m**2)
  REAL, INTENT(IN) :: coszen                    ! cosine of solar zenith angle
  REAL, INTENT(IN) :: h2osoi_vol_surf           ! surface volumetric soil water [m3/m3]
  INTEGER, INTENT(IN)  :: numcan_wrf            ! layers in WRF grid
  REAL, INTENT(IN) :: tlai_z_wrf(1:mxlevcan_wrf)  ! tlai increment for canopy layer
  REAL, INTENT(IN) :: tsai_z_wrf(1:mxlevcan_wrf)  ! tsai increment for canopy layer
  INTEGER, INTENT(IN)  :: ivt                   ! vegetation type
  INTEGER, INTENT(IN)  :: soilcol               ! soilcolor

  ! --- output ---
  REAL, INTENT(OUT) :: parsun_z_wrf(numrad,1:mxlevcan_wrf) ! absorbed PAR for sunlit leaves
  REAL, INTENT(OUT) :: parsha_z_wrf(numrad,1:mxlevcan_wrf) ! absorbed PAR for shaded leaves
  REAL, INTENT(OUT) :: fsun_z_wrf(1:mxlevcan_wrf)          ! sunlit fraction, 0 - 1.0
  REAL, INTENT(OUT) :: sw_can_z(1:mxlevcan_wrf)            ! absorbed sw at each layer
  REAL, INTENT(OUT) :: sabg                              ! sw absorbed by ground (W/m**2)
  REAL, INTENT(OUT) :: sw_out                              ! sw out at canopy top (W/m**2)
  
  ! --- plant parameter, read from clm_varpar
  !real :: rhol(numpft,numrad)             ! leaf reflectance: 1=vis, 2=nir
  !real :: rhos(numpft,numrad)             ! stem reflectance: 1=vis, 2=nir
  !real :: taul(numpft,numrad)             ! leaf transmittance: 1=vis, 2=nir
  !real :: taus(numpft,numrad)             ! stem transmittance: 1=vis, 2=nir
  !real :: xl        ! ecophys const - leaf/stem orientation index (-1,1)

  ! ------ local ------
  ! --- potential output ---
  real :: trd(numrad) ! transmitted solar radiation: direct (W/m**2)
  real :: tri(numrad) ! transmitted solar radiation: diffuse (W/m**2)
  real :: cad(numrad) ! direct beam absorbed by canopy (W/m**2)
  real :: cai(numrad) ! diffuse radiation absorbed by canopy (W/m**2)
  real :: sabv        ! solar radiation absorbed by vegetation (W/m**2)

  real :: albsod(numrad)    ! soil albedo (direct)
  real :: albsoi(numrad)    ! soil albedo (diffuse)
  !--------------------------

  integer :: nrad   ! canopy layer levels used in clm

  real :: tlai      ! one-sided leaf area index, no burying by snow
  real :: tsai      ! one-sided stem area index, no burying by snow
  real :: elai      ! one-sided leaf area index with burying by snow, elai = tlai here
  real :: esai      ! one-sided stem area index with burying by snow, esai = tsai here

  integer, parameter :: mxlevcan = 1000

  real :: tlai_z(mxlevcan)      ! tlai increment for canopy layer in CLM
  real :: tsai_z(mxlevcan)      ! tsai increment for canopy layer in CLM

  real :: laisum_wrf(1:numcan_wrf)
  real :: laisum_clm(mxlevcan)  ! cumulative lai+sai for canopy layer (at middle of layer)

  real :: laisun_z(mxlevcan)    ! sunlit leaf area for canopy layer in CLM
  real :: laisha_z(mxlevcan)    ! shaded leaf area for canopy layer in CLM
  real :: laisun                ! sunlit leaf area
  real :: laisha                ! shaded leaf area
  real :: parsun_z(numrad,mxlevcan)    ! absorbed PAR for sunlit leaves in canopy layer
  real :: parsha_z(numrad,mxlevcan)    ! absorbed PAR for shaded leaves in canopy layer

  integer, parameter :: nband = numrad    ! number of solar radiation waveband classes
  real :: fabd(numrad)        ! flux absorbed by canopy per unit direct flux
  real :: fabi(numrad)        ! flux absorbed by canopy per unit diffuse flux
  real :: ftdd(numrad)        ! down direct flux below canopy per unit direct flx
  real :: ftid(numrad)        ! down diffuse flux below canopy per unit direct flx
  real :: ftii(numrad)        ! down diffuse flux below canopy per unit diffuse flx
  real :: fabd_sun_z(numrad,mxlevcan) ! absorbed sunlit leaf direct  PAR (per unit lai+sai) for each canopy layer
  real :: fabd_sha_z(numrad,mxlevcan) ! absorbed shaded leaf direct  PAR (per unit lai+sai) for each canopy layer
  real :: fabi_sun_z(numrad,mxlevcan) ! absorbed sunlit leaf diffuse PAR (per unit lai+sai) for each canopy layer
  real :: fabi_sha_z(numrad,mxlevcan) ! absorbed shaded leaf diffuse PAR (per unit lai+sai) for each canopy layer
  real :: fsun_z(mxlevcan)     ! sunlit fraction of canopy layer, 0 - 1.0

  real,  parameter:: mpe = 1.0e-6  ! prevents overflow for division by zero
  real :: wl                       ! fraction of LAI+SAI that is LAI
  real :: ws                       ! fraction of LAI+SAI that is SAI
  real :: rho(numrad)              ! leaf/stem refl weighted by fraction LAI and SAI
  real :: tau(numrad)              ! leaf/stem tran weighted by fraction LAI and SAI

  real :: dincmax                  ! lai+sai increment for canopy layer

  INTEGER :: iv, ib, kk
  real :: tmp, dz1 ,dz2

  parsun_z_wrf = 0.
  parsha_z_wrf = 0.
  fsun_z_wrf = 0.
  sw_can_z = 0.
  sabg = 0.

  if (coszen < mincoszen ) return
     
  ! first calculate radiative in clm model d(LAI), then convert to WRF
  dincmax = 0.02
  call clm_multi_layer_lai( tlai_z_wrf, tsai_z_wrf, numcan_wrf, dincmax,            &
                            tlai, tsai, tlai_z, tsai_z, laisum_clm, mxlevcan, nrad, &
                            laisum_wrf )

  elai = tlai
  esai = tsai

  ! Weight reflectance/transmittance by lai and sai
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

  !----------------------
  parsun_z = 0.
  parsha_z = 0.
  sabv = 0.
  sabg = 0.
  ! Loop over nband wavebands, here only visible band and near-infrared band

  tmp = 0.
  DO ib = 1, numrad 

      ! Absorbed by canopy
      cad(ib) = forc_solad(ib)*fabd(ib)
      cai(ib) = forc_solai(ib)*fabi(ib)
      sabv = sabv + cad(ib) + cai(ib)

      ! Absorbed PAR profile through canopy
!      IF ( ib == 1 ) THEN
          DO iv = 1, nrad
              parsun_z(ib,iv) = forc_solad(ib)*fabd_sun_z(ib,iv) + forc_solai(ib)*fabi_sun_z(ib,iv)
              parsha_z(ib,iv) = forc_solad(ib)*fabd_sha_z(ib,iv) + forc_solai(ib)*fabi_sha_z(ib,iv)
              !part(iv) = fabd_sun_z(1,iv)
              !tmp = tmp + parsun_z(ib,iv)*fsun_z(iv)* (tlai_z(iv)+tsai_z(iv)) + &
              !            parsha_z(ib,iv)*(1.-fsun_z(iv)) * (tlai_z(iv)+tsai_z(iv))
          ENDDO
!      ENDIF

      ! Transmitted = solar fluxes incident on ground

      trd(ib) = forc_solad(ib)*ftdd(ib)
      tri(ib) = forc_solad(ib)*ftid(ib) + forc_solai(ib)*ftii(ib)

      ! calculate absorbed solar by soil
      sabg = sabg + trd(ib)*(1. - albsod(ib)) + tri(ib)*(1. - albsoi(ib))

  ENDDO

  ! --- sw out --------
  sw_out = forc_solad(1) + forc_solai(1) + forc_solad(2) + forc_solai(2) - sabg - sabv


  ! ---------------
  ! convert to wrf layer defined by height
  ! tmp = 0
  DO iv = 1, numcan_wrf

      call to_zk2_para( laisum_wrf(iv), laisum_clm(1:nrad), nrad, kk, dz1, dz2 )
 
      parsun_z_wrf(:,iv) = dz1 * parsun_z(:,kk) + dz2 * parsun_z(:,kk+1)
      parsha_z_wrf(:,iv) = dz1 * parsha_z(:,kk) + dz2 * parsha_z(:,kk+1)
      fsun_z_wrf(iv)   = dz1 * fsun_z(kk) + dz2 * fsun_z(kk+1)

      !sw_can_z(iv) = parsun_z_wrf(1,iv)*fsun_z_wrf(iv)*(tlai_z_wrf(iv) + tsai_z_wrf(iv))        + &
      !               parsun_z_wrf(2,iv)*fsun_z_wrf(iv)*(tlai_z_wrf(iv) + tsai_z_wrf(iv))        + &
      !               parsha_z_wrf(1,iv)*(1. - fsun_z_wrf(iv))*(tlai_z_wrf(iv) + tsai_z_wrf(iv)) + &
      !               parsha_z_wrf(2,iv)*(1. - fsun_z_wrf(iv))*(tlai_z_wrf(iv) + tsai_z_wrf(iv))

      ! per LAI
      sw_can_z(iv) = parsun_z_wrf(1,iv)*fsun_z_wrf(iv)        + &
                     parsun_z_wrf(2,iv)*fsun_z_wrf(iv)        + &
                     parsha_z_wrf(1,iv)*(1. - fsun_z_wrf(iv)) + &
                     parsha_z_wrf(2,iv)*(1. - fsun_z_wrf(iv))
  !   tmp = tmp + sw_can_z(i)
  ENDDO

  end subroutine SurfaceRadiation

!==============================================================

  subroutine two_stream( fabd_sun_z, fabd_sha_z, fabi_sun_z, fabi_sha_z, fsun_z, &
                         fabd, fabi, ftdd, ftid, ftii,                           &
                         mxlevcan, nrad, coszen, rho, tau, albgrd, albgri, xl,   &
                         elai, esai, tlai_z, tsai_z, laisum_z )

  USE clm_varpar_my, only : numrad

  IMPLICIT NONE

  INTEGER, INTENT(IN) :: nrad  ! number of canopy layers, above snow for radiative transfer
  INTEGER, INTENT(IN) :: mxlevcan
  REAL, INTENT(IN) :: coszen   ! cosine solar zenith angle for next time step
  REAL, INTENT(IN) :: rho(numrad) ! leaf/stem refl weighted by fraction LAI and SAI
  REAL, INTENT(IN) :: tau(numrad) ! leaf/stem tran weighted by fraction LAI and SAI
  REAL, INTENT(IN) :: albgrd(numrad)   ! ground albedo (direct) (column-level)
  REAL, INTENT(IN) :: albgri(numrad)   ! ground albedo (diffuse)(column-level)
  REAL, INTENT(IN) :: xl               ! ecophys const - leaf/stem orientation index (-1,1)
             !-1 for vertical, 0 for random, and 1 for horizontal leaf orientation
  REAL, INTENT(IN) :: elai             ! one-sided leaf area index without burying by snow
  REAL, INTENT(IN) :: esai             ! one-sided stem area index without burying by snow
  REAL, INTENT(IN) :: tlai_z(mxlevcan) ! tlai increment for canopy layer
  REAL, INTENT(IN) :: tsai_z(mxlevcan) ! tsai increment for canopy layer
  REAL, INTENT(IN) :: laisum_z(mxlevcan) ! cumulative lai+sai for canopy layer (at middle of layer)

  ! - multi-layer canopy output, only visible waveband (ib=1)
  REAL, INTENT(OUT) :: fabd_sun_z(numrad,mxlevcan) ! absorbed sunlit leaf direct  PAR (per unit lai+sai)
  REAL, INTENT(OUT) :: fabd_sha_z(numrad,mxlevcan) ! absorbed shaded leaf direct  PAR (per unit lai+sai)
  REAL, INTENT(OUT) :: fabi_sun_z(numrad,mxlevcan) ! absorbed sunlit leaf diffuse PAR (per unit lai+sai)
  REAL, INTENT(OUT) :: fabi_sha_z(numrad,mxlevcan) ! absorbed shaded leaf diffuse PAR (per unit lai+sai)
  REAL, INTENT(OUT) :: fsun_z(mxlevcan)            ! sunlit fraction of canopy layer
  REAL, INTENT(OUT) :: fabd(numrad)  ! flux absorbed by canopy per unit direct flux
  REAL, INTENT(OUT) :: fabi(numrad)  ! flux absorbed by canopy per unit diffuse flux
  REAL, INTENT(OUT) :: ftdd(numrad)  ! down direct  flux below canopy per unit direct flux
  REAL, INTENT(OUT) :: ftid(numrad)  ! down diffuse flux below canopy per unit direct flux
  REAL, INTENT(OUT) :: ftii(numrad)  ! down diffuse flux below canopy per unit diffuse flux

  ! loca variables may output
  real :: albd(numrad)     ! surface (big leaf canopy) albedo (direct)
  real :: albi(numrad)     ! surface (big leaf caonpy) albedo (diffuse)
  real :: fabd_sun(numrad) ! flux absorbed by sunlit canopy per unit direct flux
  real :: fabd_sha(numrad) ! flux absorbed by shaded canopy per unit direct flux
  real :: fabi_sun(numrad) ! flux absorbed by sunlit canopy per unit diffuse flux
  real :: fabi_sha(numrad) ! flux absorbed by shaded canopy per unit diffuse flux

  ! Local variables
  real :: cosz             ! 0.001 <= coszen <= 1.000
  real :: asu              ! single scattering albedo
  real :: chil             ! -0.4 <= xl <= 0.6
  real :: gdir             ! leaf projection in solar direction (0 to 1)
  real :: twostext         ! optical depth of direct beam per unit leaf area
  real :: avmu             ! average diffuse optical depth
  real :: omega(numrad)    ! fraction of intercepted radiation that is scattered (0 to 1)
  real :: omegal           ! omega for leaves
  real :: betai            ! upscatter parameter for diffuse radiation
  real :: betail           ! betai for leaves
  real :: betad            ! upscatter parameter for direct beam radiation
  real :: betadl           ! betad for leaves
  real :: tmp0,tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7,tmp8,tmp9 ! temporary
  real :: p1,p2,p3,p4,s1,s2,u1,u2,u3                        ! temporary
  real :: b,c1,d,d1,d2,f,h,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10   ! temporary
  real :: phi1,phi2,sigma                                   ! temporary
  real :: temp0,temp1,temp2                                 ! temporary
  real :: t1                                                ! temporary
  real :: a1,a2                   ! parameter for sunlit/shaded leaf radiation absorption
  real :: v,dv,u,du                                       ! temporary for flux derivatives
  real :: dh2,dh3,dh5,dh6,dh7,dh8,dh9,dh10                ! temporary for flux derivatives
  real :: da1,da2                                         ! temporary for flux derivatives
  real :: d_ftid,d_ftii           ! ftid, ftii derivative with respect to lai+sai
  real :: d_fabd,d_fabi           ! fabd, fabi derivative with respect to lai+sai
  real :: d_fabd_sun,d_fabd_sha   ! fabd_sun, fabd_sha derivative with respect to lai+sai
  real :: d_fabi_sun,d_fabi_sha   ! fabi_sun, fabi_sha derivative with respect to lai+sai
  real :: laisum                  ! cumulative lai+sai (at middle of layer)
  integer :: iv                   ! canopy layer number
  integer :: ib                   ! waveband number
  
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

  ! Loop over all wavebands to calculate for the full canopy the scattered fluxes
  ! reflected upward and transmitted downward by the canopy and the flux absorbed by the
  ! canopy for a unit incoming direct beam and diffuse flux at the top of the canopy given
  ! an underlying surface of known albedo.
  !
  ! Output:
  ! ------------------
  ! Direct beam fluxes
  ! ------------------
 
  ! albd       - Upward scattered flux above canopy (per unit direct beam flux)
  ! ftid       - Downward scattered flux below canopy (per unit direct beam flux)
  ! ftdd       - Transmitted direct beam flux below canopy (per unit direct beam flux)
  ! fabd       - Flux absorbed by canopy (per unit direct beam flux)
  ! fabd_sun   - Sunlit portion of fabd
  ! fabd_sha   - Shaded portion of fabd
  ! fabd_sun_z - absorbed sunlit leaf direct PAR (per unit sunlit lai+sai) for each canopy layer
  ! fabd_sha_z - absorbed shaded leaf direct PAR (per unit shaded lai+sai) for each canopy layer
  ! ------------------
  ! Diffuse fluxes
  ! ------------------
  ! albi       - Upward scattered flux above canopy (per unit diffuse flux)
  ! ftii       - Downward scattered flux below canopy (per unit diffuse flux)
  ! fabi       - Flux absorbed by canopy (per unit diffuse flux)
  ! fabi_sun   - Sunlit portion of fabi
  ! fabi_sha   - Shaded portion of fabi
  ! fabi_sun_z - absorbed sunlit leaf diffuse PAR (per unit sunlit lai+sai) for each canopy layer
  ! fabi_sha_z - absorbed shaded leaf diffuse PAR (per unit shaded lai+sai) for each canopy layer

  DO ib = 1, numrad   !numrad = 2
      ! Calculate two-stream parameters omega, betad, and betai.
      ! Also, the transmittances and reflectances (tau, rho) are linear
      ! weights of leaf and stem values.

      omegal = rho(ib) + tau(ib)
      asu = 0.5*omegal*gdir/temp0*temp2
      betail = 0.5 * ( (rho(ib)+tau(ib)) + (rho(ib)-tau(ib))*((1.+chil)/2.)**2 ) / omegal
      betadl = (1.+avmu*twostext)/(omegal*avmu*twostext)*asu
  
      ! no snow
      omega(ib) = omegal
      betad = betadl
      betai = betail

      ! Common terms
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

      ! Absorbed, reflected, transmitted fluxes per unit incoming radiation
      ! for full canopy
      t1 = min(h*(elai+esai), 40.)
      s1 = exp(-t1)
      t1 = min(twostext*(elai+esai), 40.)
      s2 = exp(-t1)

      ! Direct beam

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

      ! Diffuse

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

      ! Repeat two-stream calculations for each canopy layer to calculate derivatives.
      ! tlai_z and tsai_z are the leaf+stem area increment for a layer. Derivatives are
      ! calculated at the center of the layer. Derivatives are needed only for the
      ! visible waveband to calculate absorbed PAR (per unit lai+sai) for each canopy layer.
      ! Derivatives are calculated first per unit lai+sai and then normalized for sunlit
      ! or shaded fraction of canopy layer.

      ! Sun/shade big leaf code uses only one layer, with canopy integrated values from above
      ! and also canopy-integrated scaling coefficients

      !IF (ib == 1) THEN 
          DO iv = 1, nrad  !nrad must > 1

              ! Cumulative lai+sai at center of layer
              laisum = laisum_z(iv)

              ! Coefficients s1 and s2 depend on cumulative lai+sai. s2 is the sunlit fraction

              t1 = min(h*laisum, 40.)
              s1 = exp(-t1)
              t1 = min(twostext*laisum, 40.)
              s2 = exp(-t1)
              fsun_z(iv) = s2

              ! ===============
              ! Direct beam
              ! ===============

              ! Coefficients h1-h6 and a1,a2 depend of cumulative lai+sai

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

              ! Derivatives for h2, h3, h5, h6 and a1, a2

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

              ! Flux derivatives

              d_ftid = -twostext*h4/sigma*s2 - h*h5*s1 + h*h6/s1 + dh5*s1 + dh6/s1
              d_fabd = -(dh2+dh3) + (1.-albgrd(ib))*twostext*s2 - (1.-albgri(ib))*d_ftid
              d_fabd_sun = (1. - omega(ib)) * (twostext*s2 + 1. / avmu * (da1 + da2))
              d_fabd_sha = d_fabd - d_fabd_sun

              fabd_sun_z(ib,iv) = max(d_fabd_sun, 0.)
              fabd_sha_z(ib,iv) = max(d_fabd_sha, 0.)

              ! Flux derivatives are APARsun and APARsha per unit (LAI+SAI). Need
              ! to normalize derivatives by sunlit or shaded fraction to get
              ! APARsun per unit (LAI+SAI)sun and APARsha per unit (LAI+SAI)sha

              fabd_sun_z(ib,iv) = fabd_sun_z(ib,iv) / fsun_z(iv)
              fabd_sha_z(ib,iv) = fabd_sha_z(ib,iv) / (1. - fsun_z(iv))

              ! ===============
              ! Diffuse
              ! ===============

              ! Coefficients h7-h10 and a1,a2 depend of cumulative lai+sai

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

              ! Derivatives for h7, h8, h9, h10 and a1, a2

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

              ! FLUX derivatives

              d_ftii = -h * h9 * s1 + h * h10 / s1 + dh9 * s1 + dh10 / s1
              d_fabi = -(dh7+dh8) - (1.-albgri(ib))*d_ftii
              d_fabi_sun = (1. - omega(ib)) / avmu * (da1 + da2)
              d_fabi_sha = d_fabi - d_fabi_sun

              fabi_sun_z(ib,iv) = max(d_fabi_sun, 0.)
              fabi_sha_z(ib,iv) = max(d_fabi_sha, 0.)

              ! Flux derivatives are APARsun and APARsha per unit (LAI+SAI). Need
              ! to normalize derivatives by sunlit or shaded fraction to get
              ! APARsun per unit (LAI+SAI)sun and APARsha per unit (LAI+SAI)sha

              fabi_sun_z(ib,iv) = fabi_sun_z(ib,iv) / fsun_z(iv)
              fabi_sha_z(ib,iv) = fabi_sha_z(ib,iv) / (1. - fsun_z(iv))

          ENDDO  ! end of canopy layer loop

      !ENDIF  ! end if ib == 1

  ENDDO !end of radiation band loop

  end subroutine two_stream

!==============================================================

  subroutine Lw_Canopy( ivt, forc_lwrad, t_veg_z, t_air_z, t_grnd, ems, tlai_z, tsai_z, numcan, &
                        lwcan, lw_grnd, lw_out )

  ! adopted from SHAW model by Yulong
  USE clm_varpar_my, only : sb, emsv, mxlevcan_wrf

  implicit none
  
  integer, intent(in) :: ivt
  real, intent(in) :: forc_lwrad  ! lw at canopy top (W/m^2)
  real, intent(in) :: t_grnd      ! ground temp (K)
  real, intent(in) :: ems         ! ground (soil) emision
  integer, intent(in) :: numcan   ! canopy layers
  real, dimension(mxlevcan_wrf), intent(in)  :: t_veg_z ! canopy temp (K)
  real, dimension(mxlevcan_wrf), intent(in)  :: t_air_z ! air temp (K)
  real, dimension(mxlevcan_wrf), intent(in)  :: tlai_z, tsai_z

  real, dimension(mxlevcan_wrf), intent(out) :: lwcan ! lw absorbed by canopy
  real, dimension(mxlevcan_wrf) :: lwcan1 ! lw absorbed by canopy
  real, dimension(mxlevcan_wrf) :: lwcan2 ! lw absorbed by canopy
  real, intent(out) :: lw_grnd, lw_out

  ! --- local ---
  real :: avmuir  !ir inverse optical depth per unit leaf area
  real :: ev    !ir inverse optical depth per unit leaf area
  real :: inlayer, outlayer, emv(numcan)
  real :: IRin, IRout
  integer :: iv

!  TWJ
!  write(*,*) 'In Lw_Canopy'
!  write(*,*) ivt, forc_lwrad, t_grnd, ems, numcan
!  write(*,*) t_veg_z(1:numcan)
!  write(*,*) t_air_z(1:numcan)
!  write(*,*) tlai_z(1:numcan)
!  write(*,*) tsai_z(1:numcan)

  avmuir = 1.
  ev = emsv(ivt)

  lwcan = 0.

!  write(*,*) 'Entering loop 1'
  inlayer = forc_lwrad
  do iv = 1, numcan  ! top to grnd
      ! Effectvie vegetation Emissivity, similar to sw diffusion
      ! Using Taylor expansion, emv ~= (tlai_z(iv)+tsai_z(iv))/avmuir
      emv(iv) = ( 1. - exp(-(tlai_z(iv)+tsai_z(iv))/avmuir) ) * ev

      outlayer = emv(iv)*sb*t_veg_z(iv)**4
      lwcan(iv) = lwcan(iv) + emv(iv)*inlayer - outlayer
      inlayer = (1.-emv(iv))*inlayer + outlayer
!      write(*,*) iv, emv(iv), outlayer, lwcan(iv), inlayer
  enddo

  lw_grnd = ems*inlayer  ! consider emission later in surface energy balance

!  write(*,*) 'Entering loop 2'
!  write(*,*) inlayer
  inlayer = ems*sb*t_grnd**4 + (1.-ems)*inlayer
!  write(*,*) inlayer, ems, sb, t_grnd
  do iv = numcan, 1, -1  ! grnd to top
      outlayer = emv(iv)*sb*t_veg_z(iv)**4
      lwcan(iv) = lwcan(iv) + emv(iv)*inlayer - outlayer
      inlayer = (1.-emv(iv))*inlayer + outlayer
!      write(*,*) iv, emv(iv), sb, t_veg_z(iv), outlayer, lwcan(iv), inlayer
  enddo

  lw_out = inlayer

!  write(*,*) 'Entering loop 3'
  do iv = 1, numcan  ! per LAI
      lwcan(iv) = lwcan(iv)/(tlai_z(iv)+tsai_z(iv))
!      write(*,*) iv, lwcan(iv), tlai_z(iv), tsai_z(iv)
  enddo

  end subroutine Lw_Canopy

!==============================================================

  subroutine SoilAlbedo( albsod, albsoi, soilcol, surf_h2osoi_vol )

  USE clm_varpar_my, only : numrad, albsat, albdry
  implicit none
  
  integer, intent(in) :: soilcol
  real, intent(in) :: surf_h2osoi_vol
  
  real, intent(out) :: albsod(numrad)  ! soil albedo (direct)
  real, intent(out) :: albsoi(numrad)  ! soil albedo (diffuse)
  
  integer :: ib  
  real :: inc

  DO ib = 1, numrad
      inc = max( 0.11-0.40*surf_h2osoi_vol, 0. )
!      write(*,*) inc, surf_h2osoi_vol, soilcol, ib
      albsod(ib) = min( albsat(soilcol,ib) + inc, albdry(soilcol,ib) )
      albsoi(ib) = albsod(ib)
!      write(*,*) albsod(ib), albsoi(ib)
  ENDDO

  end subroutine SoilAlbedo

!==============================================================

  subroutine SoilWater( h2osoi_vol, qflx_ev_grnd, qflx_tran_veg, t_soisno, &
                        dtime, z, dz, zi, watsat, hksat, bsw, sucsat, rootr, zwt, topo_slope )

! !DESCRIPTION:
! Soil hydrology
! Soil moisture is predicted from a 10-layer model (as with soil
! temperature), in which the vertical soil moisture transport is governed
! by infiltration, runoff, gradient diffusion, gravity, and root
! extraction through canopy transpiration.  The net water applied to the
! surface layer is the snowmelt plus precipitation plus the throughfall
! of canopy dew minus surface runoff and evaporation.
! CLM3.5 uses a zero-flow bottom boundary condition.
!
! The vertical water flow in an unsaturated porous media is described by
! Darcy's law, and the hydraulic conductivity and the soil negative
! potential vary with soil water content and soil texture based on the work
! of Clapp and Hornberger (1978) and Cosby et al. (1984). The equation is
! integrated over the layer thickness, in which the time rate of change in
! water mass must equal the net flow across the bounding interface, plus the
! rate of internal source or sink. The terms of water flow across the layer
! interfaces are linearly expanded by using first-order Taylor expansion.
! The equations result in a tridiagonal system equation.
!
! Note: length units here are all millimeter
! (in temperature subroutine uses same soil layer
! structure required but lengths are m)
!
! Richards equation:
!
! d wat      d     d wat d psi
! ----- = - -- [ k(----- ----- - 1) ] + S
!   dt      dz       dz  d wat
!
! where: wat = volume of water per volume of soil (mm**3/mm**3)
! psi = soil matrix potential (mm)
! dt  = time step (s)
! z   = depth (mm)
! dz  = thickness (mm)
! qin = inflow at top (mm h2o /s)
! qout= outflow at bottom (mm h2o /s)
! s   = source/sink flux (mm h2o /s)
! k   = hydraulic conductivity (mm h2o /s)
!
!                       d qin                  d qin
! qin[n+1] = qin[n] +  --------  d wat(j-1) + --------- d wat(j)
!                       d wat(j-1)             d wat(j)
!                ==================|=================
!                                  < qin
!
!                 d wat(j)/dt * dz = qin[n+1] - qout[n+1] + S(j)
!
!                                  > qout
!                ==================|=================
!                        d qout               d qout
! qout[n+1] = qout[n] + --------- d wat(j) + --------- d wat(j+1)
!                        d wat(j)             d wat(j+1)
!
!
! Solution: linearize k and psi about d wat and use tridiagonal
! system of equations to solve for d wat,
! where for layer j
!
!
! r_j = a_j [d wat_j-1] + b_j [d wat_j] + c_j [d wat_j+1]

  use clm_varpar_my, only :  denh2o, denice, tfrz, hfus, grav, smpmin, &
                             e_ice, nlevsoi, nlevgrnd
  implicit none

  real, intent(out) :: h2osoi_vol(nlevgrnd) ! vol. soil water (0 ~ watsat) [m3/m3]
  real, intent(in) :: qflx_ev_grnd       ! soil evaporation (kg/m**2/s) (+ = to atm)
  real, intent(in) :: qflx_tran_veg      ! vegetation transpiration (mm H2O/s) (+ = to atm)
  real, intent(in) :: t_soisno(nlevgrnd) ! soil temperature (Kelvin)
  real, intent(in) :: dtime              ! land model time step (sec)
  real, intent(in) :: z(0:nlevgrnd)      ! layer depth (m)
  real, intent(in) :: dz(0:nlevgrnd)     ! layer thickness (m)
  real, intent(in) :: zi(0:nlevgrnd)     ! interface level below a "z" level (m)
  real, intent(in) :: watsat(nlevgrnd)   ! volumetric soil water at saturation (porosity)
  real, intent(in) :: hksat(nlevgrnd)    ! hydraulic conductivity at saturation (mm H2O/s)
  real, intent(in) :: bsw(nlevgrnd)      ! Clapp and Hornberger "b"
  real, intent(in) :: sucsat(nlevgrnd)   ! minimum soil suction (mm)
  real, intent(inout) :: zwt                ! water table depth (m)
  real, intent(in) :: rootr(nlevgrnd)    ! effective fraction of roots in each soil layer
                                         ! cal. in Soil_Transpiration_Wetness_Factor()
  real, intent(in) :: topo_slope     ! topographic slope
  !------- local ------

  real :: qflx_infl              ! infiltration (mm H2O /s), LE at soil surface
  real :: h2osoi_liq(nlevgrnd)   ! liquid water (kg/m2)
  real :: h2osoi_ice(nlevgrnd)   ! ice water (kg/m2)

  real :: fracice(nlevgrnd)      ! fractional impermeability (-), Eq. 7.63, = 0 if ice=0
  real :: dwat(1:nlevsoi)        ! change of soil water [m3/m3]
  real :: hk(1:nlevsoi)          ! hydraulic conductivity [mm h2o/s]
  real :: dhkdw(1:nlevsoi)       ! d(hk)/d(vol_liq)

  real :: zmm(1:nlevsoi+1)       ! layer depth [mm]
  real :: dzmm(1:nlevsoi+1)      ! layer thickness [mm]
  real :: zimm(0:nlevsoi)        ! layer interface depth [mm]
  real :: zwtmm                  ! water table depth [mm]
  real :: vol_eq(1:nlevsoi+1)    ! equilibrium volumetric water content
  real :: zq(1:nlevsoi+1)        ! equilibrium matric potential for each layer [mm]
  real :: vwc_liq(1:nlevsoi+1)   ! liquid volumetric water content
  real :: vwc_zwt

  real :: tempi                  ! temp variable for calculating vol_eq
  real :: temp0                  ! temp variable for calculating vol_eq
  real :: voleq1                 ! temp variable for calculating vol_eq
  real :: s_node                 ! soil wetness
  real :: s1                     ! "s" at interface of layer
  real :: s2                     ! k*s**(2b+2)
  real :: smp(1:nlevsoi)         ! soil matrix potential [mm]
  real :: sdamp                  ! extrapolates soiwat dependence of evaporation
  real :: amx(1:nlevsoi+1)       ! "a" left off diagonal of tridiagonal matrix
  real :: bmx(1:nlevsoi+1)       ! "b" diagonal column for tridiagonal matrix
  real :: cmx(1:nlevsoi+1)       ! "c" right off diagonal tridiagonal matrix
  real :: rmx(1:nlevsoi+1)       ! "r" forcing term of tridiagonal matrix
  real :: dzq                    ! used in calculating qin, qout 
                                 ! (difference in equilbirium matric potential)
  real :: den                    ! used in calculating qin, qout
  real :: dqidw0(1:nlevsoi+1)    ! d(qin)/d(vol_liq(i-1))
  real :: dqidw1(1:nlevsoi+1)    ! d(qin)/d(vol_liq(i))
  real :: dqodw1(1:nlevsoi+1)    ! d(qout)/d(vol_liq(i))
  real :: dqodw2(1:nlevsoi+1)    ! d(qout)/d(vol_liq(i+1))
  real :: dsmpdw(1:nlevsoi+1)    ! d(smp)/d(vol_liq)
  real :: num                    ! used in calculating qin, qout
  real :: qin(1:nlevsoi+1)       ! flux of water into soil layer [mm h2o/s]
  real :: qout(1:nlevsoi+1)      ! flux of water out of soil layer [mm h2o/s]
  integer :: jwt                 ! index of the soil layer right above the water table (-)
  real :: vol_ice(1:nlevsoi), icefrac(1:nlevsoi)
  real :: qcharge           ! aquifer recharge rate (mm/s)
  
  integer :: origflag = 0        !use control soil hydraulic properties
  integer :: j
  real :: smp1,dsmpdw1,wh,wh_zwt,ka, dwat2(1:nlevsoi+1), imped(1:nlevsoi)
  
  h2osoi_ice = 0.

  ! ---  add by yulong
  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_vol(j)*( dz(j)*denh2o ) ! no ice in soil
  enddo

  ! Because the depths in this routine are in mm, use local
  ! variable arrays instead of pointers

  do j = 1, nlevsoi
      zmm(j) = z(j)*1.e3
      dzmm(j) = dz(j)*1.e3
      zimm(j) = zi(j)*1.e3
      ! calculate icefrac up here
      vol_ice(j) = min(watsat(j), h2osoi_ice(j)/(dz(j)*denice))
      icefrac(j) = min(1.,vol_ice(j)/watsat(j))
      vwc_liq(j) = max(h2osoi_liq(j),1.0e-6)/(dz(j)*denh2o)
      fracice(j) = 0.  ! add by yulong for no ice soil
  end do
  zimm(0) = 0.0
  zwtmm  = zwt*1.e3

  ! compute jwt index -- the soil layer right above the water table
  ! The layer index of the first unsaturated layer, i.e., the layer right above
  ! the water table

  jwt = nlevsoi
  ! allow jwt to equal zero when zwt is in top layer
  do j = 1,nlevsoi
      if(zwt <= zi(j)) then
          jwt = j-1
          exit
      end if
  enddo

  ! compute vwc at water table depth (mainly for case when t < tfrz)
  ! this will only be used when zwt is below the soil column
  vwc_zwt = watsat(nlevsoi)
  if(t_soisno(jwt+1) < tfrz) then
      vwc_zwt = vwc_liq(nlevsoi)
      do j = nlevsoi,nlevgrnd
          if(zwt <= zi(j)) then
              smp1 = hfus*(tfrz-t_soisno(j))/(grav*t_soisno(j)) * 1000.  !(mm)
              smp1 = max(0., smp1)
              smp1 = max(sucsat(nlevsoi),smp1)
              vwc_zwt = watsat(nlevsoi)*(smp1/sucsat(nlevsoi))**(-1./bsw(nlevsoi))
              ! for temperatures close to tfrz, limit vwc to total water content
              vwc_zwt = min(vwc_zwt, 0.5*(watsat(nlevsoi) + h2osoi_vol(nlevsoi)) )
              exit
          endif
      enddo
  endif

  ! calculate the equilibrium water content based on the water table depth

  do j=1,nlevsoi
      if ((zwtmm .le. zimm(j-1))) then
          vol_eq(j) = watsat(j)

          ! use the weighted average from the saturated part (depth > wtd) 
          ! and the equilibrium solution for therest of the layer

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

  ! If water table is below soil column calculate zq for the 11th layer
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

  ! Hydraulic conductivity and soil matric potential and their derivatives

  sdamp = 0.
  do j = 1, nlevsoi
      ! compute hydraulic conductivity based on liquid water content only

      if(origflag == 1) then
          s1 = 0.5*(h2osoi_vol(j) + h2osoi_vol(min(nlevsoi, j+1))) / &
               ( 0.5*(watsat(j) + watsat(min(nlevsoi, j+1))) )
      else
          s1 = 0.5*(vwc_liq(j) + vwc_liq(min(nlevsoi, j+1))) / &
               ( 0.5*(watsat(j) + watsat(min(nlevsoi, j+1))) )
      endif
      s1 = min(1., s1)
      s2 = hksat(j)*s1**(2.*bsw(j)+2.)  !should be 2*B+3, multiply s1 later

      ! replace fracice with impedance factor, as in zhao 97,99
      if(origflag == 1) then
          imped(j)=(1.-0.5*(fracice(j)+fracice(min(nlevsoi, j+1))))
      else
          imped(j)=10.**(-e_ice*( 0.5*(icefrac(j)+icefrac(min(nlevsoi, j+1))) ))
      endif
      hk(j) = imped(j)*s1*s2
      dhkdw(j) = imped(j)*(2.*bsw(j)+3.)*s2*(1./(watsat(j)+watsat(min(nlevsoi, j+1))))

      ! compute matric potential and derivative based on liquid water content only
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

      !smp_l(j) = smp(j)
      !hk_l(j) = hk(j)

  end do

  ! aquifer (11th) layer
  zmm(nlevsoi+1) = 0.5*(1.e3*zwt + zmm(nlevsoi))
  if(jwt < nlevsoi) then
      dzmm(nlevsoi+1) = dzmm(nlevsoi)
  else
      dzmm(nlevsoi+1) = (1.e3*zwt - zmm(nlevsoi))
  end if

  ! Set up r, a, b, and c vectors for tridiagonal solution

  ! Node j=1 (top)

  !qflx_infl = -qflx_ev_grnd/denh2o*1.e3  ! [kg/m^2/s -> mm/s]
  qflx_infl = -qflx_ev_grnd  ! [kg/m^2/s -> mm/s]

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

  ! Nodes j=2 to j=nlevsoi-1

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

  ! Node j=nlevsoi (bottom)

  j = nlevsoi
  if(j > jwt) then !water table is in soil column
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

      ! next set up aquifer layer; hydrologically inactive
      rmx(j+1) = 0.
      amx(j+1) = 0.
      bmx(j+1) = dzmm(j+1)/dtime
      cmx(j+1) = 0.
  else ! water table is below soil column

      ! compute aquifer soil moisture as average of layer 10 and saturation
      if(origflag == 1) then
           s_node = max(0.5*( 1.0+h2osoi_vol(j)/watsat(j) ), 0.01)
      else
           s_node = max(0.5*( (vwc_zwt+vwc_liq(j))/watsat(j) ), 0.01)
      endif
      s_node = min(1.0, s_node)

      ! compute smp for aquifer layer
      smp1 = -sucsat(j)*s_node**(-bsw(j))
      smp1 = max(smpmin, smp1)

      ! compute dsmpdw for aquifer layer
      dsmpdw1 = -bsw(j)*smp1/(s_node*watsat(j))

      ! first set up bottom layer of soil column
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

      ! next set up aquifer layer; den/num unchanged, qin=qout
      qin(j+1)    = qout(j)
      dqidw0(j+1) = -(-hk(j)*dsmpdw(j) + num*dhkdw(j))/den
      dqidw1(j+1) = -( hk(j)*dsmpdw1   + num*dhkdw(j))/den
      qout(j+1)   =  0.  ! zero-flow bottom boundary condition
      dqodw1(j+1) =  0.  ! zero-flow bottom boundary condition
      rmx(j+1) =  qin(j+1) - qout(j+1)
      amx(j+1) = -dqidw0(j+1)
      bmx(j+1) =  dzmm(j+1)/dtime - dqidw1(j+1) + dqodw1(j+1)
      cmx(j+1) =  0.
  endif

  ! Solve for dwat

  call Tridiagonal(nlevsoi+1, amx, bmx, cmx, rmx, dwat2)

  ! set dwat
  do j = 1, nlevsoi
      dwat(j)=dwat2(j)
  end do

  ! Renew the mass of liquid water
  ! also compute qcharge from dwat in aquifer layer
  ! update in drainage for case jwt < nlevsoi

  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_liq(j) + dwat2(j)*dzmm(j)
      ! see 7.155, not h2osoi_vol, not a bug here. 
      ! h2osoi_liq [kg/m^2], dzmm [mm], water density 1000kg/m^3, maybe the reson?
      ! add by yulong
      h2osoi_vol(j) = h2osoi_liq(j)/( dz(j)*denh2o ) ! no ice in soil
      h2osoi_vol(j) = min( h2osoi_vol(j), watsat(j) )
  end do

! --- qcharge used in drainage ---
  ! calculate qcharge for case jwt < nlevsoi
  if(jwt < nlevsoi) then
      wh_zwt = 0.   !since wh_zwt = -sucsat - zq_zwt, where zq_zwt = -sucsat

      ! Recharge rate qcharge to groundwater (positive to aquifer)
      s_node = max(h2osoi_vol(jwt+1)/watsat(jwt+1), 0.01)
      s1 = min(1., s_node)

      !scs: this is the expression for unsaturated hk
      ka = imped(jwt+1)*hksat(jwt+1)*s1**(2.*bsw(jwt+1)+3.)

      ! Recharge rate qcharge to groundwater (positive to aquifer)
      smp1 = max(smpmin, smp(max(1,jwt)))
      wh   = smp1 - zq(max(1,jwt))

      !scs: original formulation
      if(jwt == 0) then
         qcharge = -ka * (wh_zwt-wh)/((zwt+1.e-3)*1000.)
      else
         ! qcharge(c) = -ka * (wh_zwt-wh)/((zwt(c)-z(c,jwt(c)))*1000._r8)
         ! scs: 1/2, assuming flux is at zwt interface, saturation deeper than zwt
         qcharge = -ka * (wh_zwt-wh)/((zwt-z(jwt))*1000.*2.0)
      endif

      ! To limit qcharge  (for the first several timesteps)
      qcharge = max(-10.0/dtime,qcharge)
      qcharge = min( 10.0/dtime,qcharge)
  else
      ! if water table is below soil column, compute qcharge from dwat2(11)
      qcharge = dwat2(nlevsoi+1)*dzmm(nlevsoi+1)/dtime
  endif
!---------------
  call Drainage( h2osoi_vol, zwt, qcharge, t_soisno, dtime, z, dz, zi, &
                 watsat, hksat, bsw, sucsat, topo_slope )

  end subroutine SoilWater

!==============================================================

  subroutine Drainage( h2osoi_vol, zwt, qcharge, t_soisno, dtime, z, dz, zi, &
                       watsat, hksat, bsw, sucsat, topo_slope )
  
  use clm_varpar_my, only :  denh2o, denice, tfrz, hfus, grav, smpmin, &
                             e_ice, watmin, nlevsoi, nlevgrnd
  implicit none
  real, intent(inout) :: h2osoi_vol(nlevgrnd) ! vol. soil water (0 ~ watsat) [m3/m3]
  real, intent(inout) :: zwt                ! water table depth (m)
  real, intent(in) :: qcharge           ! aquifer recharge rate (mm/s)
  real, intent(in) :: t_soisno(nlevgrnd) ! soil temperature (Kelvin)
  real, intent(in) :: dtime              ! land model time step (sec)
  real, intent(in) :: z(0:nlevgrnd)      ! layer depth (m)
  real, intent(in) :: dz(0:nlevgrnd)     ! layer thickness (m)
  real, intent(in) :: zi(0:nlevgrnd)     ! interface level below a "z" level (m)
  real, intent(in) :: watsat(nlevgrnd)   ! volumetric soil water at saturation (porosity)
  real, intent(in) :: hksat(nlevgrnd)    ! hydraulic conductivity at saturation (mm H2O/s)
  real, intent(in) :: bsw(nlevgrnd)      ! Clapp and Hornberger "b"
  real, intent(in) :: sucsat(nlevgrnd)   ! minimum soil suction (mm)
                                         ! cal. in Soil_Transpiration_Wetness_Factor()
  real, intent(in) :: topo_slope     ! topographic slope

  !---- local ----
  integer :: jwt                 ! index of the soil layer right above the water table (-)
  real :: dzmm(1:nlevsoi+1)      ! layer thickness [mm]
 
  real :: eff_porosity(nlevsoi)   ! effective porosity = porosity - vol_ice
  real :: h2osoi_liq(nlevgrnd)   ! liquid water (kg/m2)
  real :: h2osoi_ice(nlevgrnd)   ! ice water (kg/m2)

  real :: qflx_drain     ! sub-surface runoff (mm H2O /s)
  real :: qflx_rsub_sat  ! soil saturation excess [mm h2o/s]
  real :: rsub_bot       ! subsurface runoff - bottom drainage (mm/s)
  real :: rsub_top       ! subsurface runoff - topographic control (mm/s)

!  real :: wa             ! water in the unconfined aquifer (mm)
  real :: wtsub          ! summation of hk*dzmm for layers below water table (mm**2/s)
  real :: rous           ! aquifer yield (-)
  real :: frost_table    ! frost table depth (m)

  real :: qflx_drain_perched     ! perched wt sub-surface runoff (mm H2O /s)
  real :: qcharge_tot, qcharge_layer
  real :: q_perch_max ! maximum drainage rate
  real :: q_perch 
  real :: s_y
  real :: imped
  real :: rsub_top_tot
  real :: rsub_top_layer
  real :: sat_lev, s1, s2, m, b
  real :: zwt_perched  ! perched water table depth (m)
  real :: available_h2osoi_liq

  real :: icefrac(nlevgrnd)   ! minimum soil suction (mm)
  real :: xs              ! water needed to bring soil moisture to watmin (mm)
  real :: xsi             ! excess soil water above saturation at layer i (mm)
  real :: xsia            ! available pore space at layer i (mm)
  real :: xs1             ! excess soil water above saturation at layer 1 (mm)

  integer :: k_frz, k_perch
  integer :: i, j
  real :: tmp

  REAL :: PI = 3.1415926535897932384626433
  real :: pondmx = 0.0     !Ponding depth (mm)

  integer :: origflag = 0        !use control soil hydraulic properties

  h2osoi_ice = 0.
  icefrac = 0.

  do j = 1, nlevsoi
      h2osoi_liq(j) = h2osoi_vol(j)*dz(j)*denh2o ! no ice in soil
      eff_porosity(j) = watsat(j)  ! no ice
  enddo


  ! Convert layer thicknesses from m to mm
  do j = 1, nlevsoi
      dzmm(j) = dz(j)*1.e3
  enddo

  ! Initial set
  qflx_drain = 0.

  ! The layer index of the first unsaturated layer, i.e., the layer right above
  ! the water table
   
  jwt = nlevsoi
  ! allow jwt to equal zero when zwt is in top layer
  do j = 1,nlevsoi
      if(zwt <= zi(j)) then
          jwt = j-1
          exit
      end if
  enddo

!============================== QCHARGE =========================================
! Water table changes due to qcharge

  ! use analytical expression for aquifer specific yield
  rous = watsat(nlevsoi) * ( 1. - (1.+1.e3*zwt/sucsat(nlevsoi))**(-1./bsw(nlevsoi)))
  rous = max(rous, 0.02)

  if(jwt == nlevsoi) then ! water table is below the soil column 
!     wa = qcharge * dtime ??????????
      zwt = zwt - (qcharge * dtime)/1000./rous

  else ! water table within soil layers 1-9

      qcharge_tot = qcharge * dtime

      if(qcharge_tot > 0.) then !rising water table
          do j = jwt+1, 1, -1
              ! use analytical expression for specific yield
              s_y = watsat(j) * ( 1. -  (1.+1.e3*zwt/sucsat(j))**(-1./bsw(j)))
              s_y = max(s_y, 0.02)

              qcharge_layer = min(qcharge_tot, (s_y*(zwt - zi(j-1))*1.e3))
              qcharge_layer = max(qcharge_layer, 0.)
              qcharge_tot = qcharge_tot - qcharge_layer

              zwt = zwt - qcharge_layer/s_y/1000.

              if (qcharge_tot <= 0.) exit
          enddo

      else ! deepening water table (negative qcharge)
          do j = jwt+1, nlevsoi
              ! use analytical expression for specific yield
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

      !-- recompute jwt for following calculations  ---
      do j = 1,nlevsoi
          if(zwt <= zi(j)) then
              jwt = j-1
              exit
          endif
      enddo

  endif

!=================  BASEFLOW ===================
! perched water table code

  ! specify maximum drainage rate
  q_perch_max = 1.e-5 * sin(topo_slope * (PI/180.))

  ! if layer containing water table is frozen, compute the following:
  !     frost table, perched water table, and drainage from perched
  !     saturated layer

  ! define frost table as first frozen layer with unfrozen layer above it

  k_frz = nlevsoi
  if(t_soisno(1) <= tfrz) k_frz = 1

  do j = 2, nlevsoi
      if (t_soisno(j-1) > tfrz .and. t_soisno(j) <= tfrz) then
          k_frz = j
          exit
      endif
  enddo

  frost_table = z(k_frz)

  ! initialize perched water table to frost table, and qflx_drain_perched(c) to zero
  zwt_perched = frost_table
  qflx_drain_perched = 0.

!  ! =================  water table above or below frost table ==============
!
!  ! if water table is above frost table, do not use topmodel baseflow formulation
!  if (zwt < frost_table .and. t_soisno(k_frz) <= tfrz .and. origflag == 0) then
!
!      ! compute drainage from perched saturated region
!      wtsub = 0.
!      q_perch = 0.
!      do j = jwt+1, k_frz
!          imped = 10.**(-e_ice*(0.5*(icefrac(j) + icefrac(min(nlevsoi, j+1)))))
!          q_perch = q_perch + imped*hksat(j)*dzmm(j)
!          wtsub = wtsub + dzmm(j)
!      enddo
!
!      if (wtsub > 0.) q_perch = q_perch/wtsub
!
!      qflx_drain_perched = q_perch_max * q_perch * (frost_table - zwt)
!
!      ! remove drainage from perched saturated layers
!      rsub_top_tot = -  qflx_drain_perched * dtime
!      do j = jwt+1, k_frz
!         rsub_top_layer = max(rsub_top_tot, -(h2osoi_liq(j) - watmin))
!         rsub_top_layer = min(rsub_top_layer, 0.)
!         rsub_top_tot = rsub_top_tot - rsub_top_layer
!
!         h2osoi_liq(j) = h2osoi_liq(j) + rsub_top_layer
!
!         if (rsub_top_tot >= 0.) then
!            zwt = zwt - rsub_top_layer/eff_porosity(j)/1000.
!            exit
!         else
!            zwt = zi(j)
!         endif
!      enddo
!
!     ! if rsub_top_tot is greater than available water (above frost table),
!     ! then decrease qflx_drain_perched by residual amount for water balance
!     qflx_drain_perched = qflx_drain_perched + rsub_top_tot/dtime
!
!      !-- recompute jwt for following calculations  ---
!      jwt = nlevsoi
!      do j = 1,nlevsoi
!          if(zwt <= zi(j)) then
!              jwt = j-1
!              exit
!          endif
!      enddo
!
!  else !  water table below frost table
!
!!--  compute possible perched water table *and* groundwater table afterwards
!! locate perched water table from bottom up starting at frost table
!! sat_lev is an arbitrary saturation level used to determine perched water table
!      sat_lev = 0.9
!
!      k_perch = 1
!      do j = k_frz, 1, -1
!          !h2osoi_vol = h2osoi_liq(j)/(dz(j)*denh2o) + h2osoi_ice(j)/(dz(j)*denice)
!          if (h2osoi_vol(j)/watsat(j) <= sat_lev) then
!              k_perch = j
!              exit
!          endif
!      enddo
!
!      ! if frost_table = nlevsoi, only compute perched water table if frozen
!      if (t_soisno(k_frz) > tfrz) k_perch = k_frz
!
!      ! if perched water table exists
!      if (k_frz > k_perch) then
!          ! interpolate between k_perch and k_perch+1 to find perched water table height
!          s1 = h2osoi_liq(k_perch)/(dz(k_perch)*denh2o)
!               ! & + h2osoi_ice(k_perch)/(dz(k_perch)*denice))/watsat(k_perch)
!          s2 = h2osoi_liq(k_perch+1)/(dz(k_perch+1)*denh2o)
!               !+ h2osoi_ice(c,k_perch+1)/(dz(c,k_perch+1)*denice))/watsat(c,k_perch+1)
!
!          m = (z(k_perch+1) - z(k_perch))/(s2 - s1)
!          b = z(k_perch+1) - m*s2
!          zwt_perched = max(0., m*sat_lev + b)
!
!          ! compute drainage from perched saturated region
!          wtsub = 0.
!          q_perch = 0.
!          do j = k_perch, k_frz
!              imped=10.**(-e_ice*(0.5*(icefrac(j)+icefrac(min(nlevsoi, j+1)))))
!              q_perch = q_perch + imped*hksat(j)*dzmm(j)
!              wtsub = wtsub + dzmm(j)
!          enddo
!          if (wtsub > 0.) q_perch = q_perch/wtsub
!
!          qflx_drain_perched = q_perch_max * q_perch * (frost_table - zwt_perched)
!
!          ! no perched water table drainage if using original formulation
!          if(origflag == 1) qflx_drain_perched = 0.
!
!          ! remove drainage from perched saturated layers
!          rsub_top_tot = -qflx_drain_perched * dtime
!          do j = k_perch+1, k_frz
!
!             rsub_top_layer = max(rsub_top_tot,-(h2osoi_liq(j) - watmin))
!             rsub_top_layer = min(rsub_top_layer, 0.)
!             rsub_top_tot = rsub_top_tot - rsub_top_layer
!
!             h2osoi_liq(j) = h2osoi_liq(j) + rsub_top_layer
!
!             if (rsub_top_tot >= 0.) then
!                 zwt_perched = zwt_perched - rsub_top_layer/eff_porosity(j)/1000.
!                 exit
!             else
!                 zwt_perched = zi(j)
!             endif
!
!          enddo
!
!          ! if rsub_top_tot is greater than available water (above frost table),
!          ! then decrease qflx_drain_perched by residual amount for water balance
!          qflx_drain_perched = qflx_drain_perched + rsub_top_tot/dtime
!
!      else  ! k_frz <= k_perch
!          qflx_drain_perched = 0.
!      endif
!  endif ! ================= end water table above or below frost table ==============


  !==================================
  !-- Topographic runoff !--- 
  ! TODO...
  !==================================


  !================================
  !  excessive water above saturation added to the above unsaturated layer like a bucket
  !  if column fully saturated, excess water goes to runoff

  do j = nlevsoi, 2, -1
      xsi             = max(h2osoi_liq(j)-eff_porosity(j)*dzmm(j), 0.)
      h2osoi_liq(j)   = min(eff_porosity(j)*dzmm(j), h2osoi_liq(j))
      h2osoi_liq(j-1) = h2osoi_liq(j-1) + xsi
  enddo

  xs1 = max(h2osoi_liq(1), 0.) - max((pondmx + watsat(1)*dzmm(1) - h2osoi_ice(1)), 0.)
  xs1 = max(xs1, 0.)

  tmp = max(0., pondmx + watsat(1)*dzmm(1) - h2osoi_ice(1))
  h2osoi_liq(1) = min(tmp, h2osoi_liq(1))

  !if(h2osfcflag == 1) then
  !   ! send this water up to h2osfc rather than sending to drainage
  !   h2osfc(c) = h2osfc(c) + xs1(c)
  !   qflx_rsub_sat(c)     = 0._r8
  !else
  !   ! use original code to send water to drainage (non-h2osfc case)
  !   qflx_rsub_sat(c)     = xs1(c) / dtime
  !endif
  qflx_rsub_sat=  xs1 / dtime

  ! add in ice check, TODO

  ! -------------------
  ! Limit h2osoi_liq to be greater than or equal to watmin.
  ! Get water needed to bring h2osoi_liq equal watmin from lower layer.
  ! If insufficient water in soil layers, get from aquifer water

  do j = 1, nlevsoi-1
      if (h2osoi_liq(j) < watmin) then
          xs = watmin - h2osoi_liq(j)
          ! deepen water table if water is passed from below zwt layer
          if(j == jwt) zwt = zwt + xs/eff_porosity(j)/1000.
      else
          xs = 0.
      endif
      h2osoi_liq(j  ) = h2osoi_liq(j  ) + xs
      h2osoi_liq(j+1) = h2osoi_liq(j+1) - xs
  enddo

  ! Get water for bottom layer from layers above if possible
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

  ! Needed in case there is no water to be found
  h2osoi_liq(j) = h2osoi_liq(j) + xs

  ! Instead of removing water from aquifer where it eventually
  ! shows up as excess drainage to the ocean, take it back out of drainage
  ! rsub_top = rsub_top - xs/dtime

  ! Sub-surface runoff and drainage
  ! qflx_drain = qflx_rsub_sat + rsub_top


  do j = 1, nlevsoi
      h2osoi_vol(j) = h2osoi_liq(j)/( dz(j)*denh2o ) ! no ice in soil
      h2osoi_vol(j) = min( h2osoi_vol(j), watsat(j) )
  end do

  end subroutine Drainage

!==============================================================

  subroutine SoilTemperature( t_soisno, eflx_sh_grnd, qflx_ev_grnd, h2osoi_vol, &
                              cgrnd, dlrad, sabg, dtime, z, dz, zi,             &
                              watsat, tkmg, tkdry, csol, tk, cv, ems )
!
! !DESCRIPTION:
! Snow and soil temperatures including phase change
! o The volumetric heat capacity is calculated as a linear combination
!   in terms of the volumetric fraction of the constituent phases.
! o The thermal conductivity of soil is computed from
!   the algorithm of Johansen (as reported by Farouki 1981), and the
!   conductivity of snow is from the formulation used in
!   SNTHERM (Jordan 1991).
! o Boundary conditions:
!   F = Rnet - Hg - LEg (top),  F= 0 (base of the soil column).
! o Soil / snow temperature is predicted from heat conduction
!   in 10 soil layers and up to 5 snow layers.
!   The thermal conductivities at the interfaces between two
!   neighboring layers (j, j+1) are derived from an assumption that
!   the flux across the interface is equal to that from the node j
!   to the interface and the flux from the interface to the node j+1.
!   The equation is solved using the Crank-Nicholson method and
!   results in a tridiagonal system equation.
!

  use clm_varpar_my  , only :  denh2o, denice, tfrz, sb,  hvap, nlevsoi, nlevgrnd
  implicit none

  real, intent(out) :: t_soisno(nlevgrnd)   ! soil temperature (Kelvin)

  real, intent(in) :: eflx_sh_grnd    ! sensible heat flux from ground (W/m**2) [+ to atm]
  real, intent(in) :: qflx_ev_grnd    ! soil evaporation (kg/m**2/s) (+ = to atm)
  real, intent(in) :: h2osoi_vol(nlevgrnd)   ! vol. soil water  [m3/m3]
  real, intent(in) :: cgrnd           ! deriv. of soil energy flux [w/m2/k] (dH/dT + d(rE)/dT)
  real, intent(in) :: dlrad           ! downward longwave radiation blow the canopy [W/m2]
  real, intent(in) :: sabg            ! solar radiation absorbed by ground (W/m**2)
  real, intent(in) :: dtime           ! land model time step (sec)
  real, intent(in) :: z(0:nlevgrnd)   ! layer thickness (m)
  real, intent(in) :: dz(0:nlevgrnd)  ! layer depth (m)
  real, intent(in) :: zi(0:nlevgrnd)  ! interface level below a "z" level (m)
  real, intent(in) :: watsat(nlevgrnd)! volumetric soil water at saturation (porosity)
  real, intent(in) :: tkmg(nlevgrnd)  ! thermal conductivity, soil minerals  [W/m-K]
  real, intent(in) :: tkdry(nlevgrnd) ! thermal conductivity, dry soil (W/m/Kelvin)
  real, intent(in) :: csol(nlevgrnd)  ! heat capacity, soil solids (J/m**3/Kelvin)
  real, intent(in) :: tk (nlevgrnd)   ! thermal conductivity [W/(m K)]
  real, intent(in) :: cv (nlevgrnd)   ! heat capacity [J/(m2 K)]
  real, intent(in) :: ems             ! surface emssion

  ! ------ local ------
  real :: t_grnd               ! ground surface temperature [K]
  real :: h2osoi_liq(nlevgrnd) ! liquid water (kg/m2)
  real :: h2osoi_ice(nlevgrnd) ! ice lens (kg/m2)
  real :: hs_top               ! net energy flux into the surface (w/m2)
  real :: dhsdT                ! d(hs)/dT
  real :: dlwrad_emit          ! derivative of emitted longwave radiation to soil temp
  real :: lwrad_emit           ! emitted longwave radiation
  real :: at (1:nlevgrnd)      ! "a" vector for tridiagonal matrix
  real :: bt (1:nlevgrnd)      ! "b" vector for tridiagonal matrix
  real :: ct (1:nlevgrnd)      ! "c" vector for tridiagonal matrix
  real :: rt (1:nlevgrnd)      ! "r" vector for tridiagonal solution
  real :: fn (1:nlevgrnd)      ! heat diffusion through the layer interface [W/m2]
  real :: fn1(1:nlevgrnd)      ! heat diffusion through the layer interface [W/m2]
  real :: dzm                  ! used in computing tridiagonal matrix
  real :: dzp                  ! used in computing tridiagonal matrix
  real :: fact(1:nlevgrnd)     ! used in computing tridiagonal matrix, dt/cv
  real :: emg                  ! surface emssion

  real :: cnfac = 0.5          ! Crank Nicholson factor, used in soil temp
  real :: capr = 0.34          ! Tuning factor to turn first layer T into surface T, Eq.6.4
  integer :: j

  t_grnd = t_soisno(1)
  do j = 1, nlevgrnd
      h2osoi_ice(j) = 0.
      h2osoi_liq(j) = h2osoi_vol(j)*( dz(j)*denh2o ) ! no ice in soil
  enddo

  ! Net ground heat flux into the surface and its temperature derivative
  emg = ems  ! = soil emission
  lwrad_emit  =    emg * sb * t_grnd**4
  dlwrad_emit = 4.*emg * sb * t_grnd**3  
  
  hs_top = sabg + dlrad - (eflx_sh_grnd+qflx_ev_grnd*hvap)
  !hs_top = sabg + dlrad - (eflx_sh_grnd+qflx_ev_grnd*hvap)
  !write(*,*) 'G_soil', hs_top, sabg, dlrad, eflx_sh_grnd+qflx_ev_grnd*hvap
  dhsdt = - cgrnd - dlwrad_emit
  !dhsdt = 0.

  ! Determine heat diffusion through the layer interface and factor used in computing
  ! tridiagonal matrix and set up vector r and vectors a, b, c that define tridiagonal
  ! matrix and solve system

  ! cv unit [J/(m2 K)], cv = ci*dz
  do j = 1,nlevgrnd
      if (j == 1) then
          fact(j) = dtime/cv(j) * dz(j) / (0.5*(z(j)-zi(j-1)+capr*(z(j+1)-zi(j-1)))) ! EQ. 6.4
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
!write(*,*) 

  !cnfac = 0.5 !Crank Nicholson factor
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

  ! Melting or Freezing
  ! To be done ...

  end subroutine SoilTemperature

!==============================================================

  subroutine SoilThermProp( tk, cv, t_soisno, h2osoi_vol, &
                            dz, zi, z, watsat, tkmg, tkdry, csol )
!
! !DESCRIPTION:
! Calculation of thermal conductivities and heat capacities of
! snow/soil layers
! (1) The volumetric heat capacity is calculated as a linear combination
!     in terms of the volumetric fraction of the constituent phases.
!
! (2) The thermal conductivity of soil is computed from the algorithm of
!     Johansen (as reported by Farouki 1981), and of snow is from the
!     formulation used in SNTHERM (Jordan 1991).
! The thermal conductivities at the interfaces between two neighboring
! layers (j, j+1) are derived from an assumption that the flux across
! the interface is equal to that from the node j to the interface and the
! flux from the interface to the node j+1.
!
  use clm_varpar_my, only : denh2o, denice, tfrz, tkwat, tkice, cpice, cpliq, &
                            nlevsoi, nlevgrnd
  implicit none
  
  real, intent(out) :: tk(nlevgrnd) ! thermal conductivity at interface[W/(m K)]  
  real, intent(out) :: cv(nlevgrnd) ! heat capacity [J/(m2 K)]

  ! input
  real, intent(in) :: t_soisno(nlevgrnd)    ! soil temperature (Kelvin)
  real, intent(in) :: h2osoi_vol(nlevgrnd)  ! liquid water (m^3/m^3)
  real, intent(in) :: dz(0:nlevgrnd)        ! layer depth (m)
  real, intent(in) :: zi(0:nlevgrnd)        ! interface level below a "z" level (m)
  real, intent(in) :: z(0:nlevgrnd)         ! layer thickness (m)
  real, intent(in) :: watsat(nlevgrnd)      ! vol. soil water at saturation (porosity)
  real, intent(in) :: tkmg(nlevgrnd)        ! thermal conductivity, soil minerals  [W/m-K]
  real, intent(in) :: tkdry(nlevgrnd)       ! thermal conductivity, dry soil (W/m/Kelvin)
  real, intent(in) :: csol(nlevgrnd)        ! heat capacity, soil solids (J/m**3/Kelvin)

  ! --- local ---
  real :: h2osoi_ice(nlevgrnd) ! ice lens (kg/m2)
  real :: h2osoi_liq(nlevgrnd) ! liquid water (kg/m2)
  real :: dksat                ! thermal conductivity for saturated soil (j/(k s m))
  real :: dke                  ! kersten number
  real :: fl                   ! volume fraction of liquid or unfrozen water to total water
  real :: satw                 ! relative total water content of soil.
  real :: thk(nlevgrnd)        ! thermal conductivity of layer 
  real :: thk_bedrock = 3.0    ! thermal conductivity of 'typical' saturated granitic rock
                               ! (Clauser and Huenges, 1995)(W/m/K)
  integer :: j
  
  h2osoi_ice = 0.  ! TO DO...

  do j = 1, nlevgrnd
      h2osoi_liq(j) = h2osoi_vol(j)*dz(j)*denh2o ! no ice in soil

      satw = (h2osoi_liq(j)/denh2o + h2osoi_ice(j)/denice)/(dz(j)*watsat(j))
      satw = min(1., satw)
      if (satw > 1.e-6) then
          if (t_soisno(j) >= tfrz) then       ! Unfrozen soil
              dke = max(0., log10(satw) + 1.0)
          else                                ! Frozen soil
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

  ! Thermal conductivity at the layer interface

  do j = 1,nlevgrnd
      if ( j <= nlevgrnd-1) then
          tk(j) = thk(j)*thk(j+1)*(z(j+1) - z(j)) &
                   /( thk(j)*(z(j+1) - zi(j)) + thk(j+1)*(zi(j) - z(j)) )
      else if (j == nlevgrnd) then
          tk(j) = 0.
      end if
  end do
  
  ! Soil heat capacity, from de Vires (1963)
 
  do j = 1, nlevgrnd
      cv(j) = csol(j)*(1-watsat(j))*dz(j) + h2osoi_ice(j)*cpice + h2osoi_liq(j)*cpliq
  end do

  end subroutine SoilThermProp

!==============================================================

  subroutine Soil_Transpiration_Wetness_Factor( btran, rootr, btran_z, &
                                                ivt, dz, rootfr, sucsat, bsw, watsat, &
                                                h2osoi_vol, t_soisno )

  use clm_varpar_my, only : denh2o, tfrz, smpso, smpsc, nlevgrnd
  implicit none

  real, intent(out) :: btran              ! transpiration wetness factor (0 to 1)
  real, intent(out) :: rootr(nlevgrnd)    ! effective fraction of roots in each soil layer

  integer, intent(in) :: ivt
  real, intent(in) :: dz(0:nlevgrnd)        ! layer depth (m)
  real, intent(in) :: rootfr(nlevgrnd)
  real, intent(in) :: sucsat(nlevgrnd)    ! minimum soil suction (mm)
  real, intent(in) :: bsw(nlevgrnd)       ! Clapp and Hornberger "b"
  real, intent(in) :: watsat(nlevgrnd)    ! volumetric soil water at saturation (porosity)
  real, intent(in) :: h2osoi_vol(nlevgrnd)! liquid water (m^3/m^3)
  real, intent(in) :: t_soisno(nlevgrnd)  ! soil temperature (Kelvin)

  ! ------ local ------
  real :: h2osoi_liq(nlevgrnd)  ! liquid water (kg/m2)
  real :: s_node                ! vol_liq/eff_porosity
  real :: smp_node              ! matrix potential
  real :: rresis(nlevgrnd)      ! root resistance by layer (0-1)  (nlevgrnd)
  real :: eff_porosity, vol_liq, vol_ice
  real :: tmp
  real :: btran_z(nlevgrnd)

  integer :: i
!  real :: smpso       ! soil water potential at full stomatal opening (mm)
!  real :: smpsc       ! soil water potential at full stomatal closure (mm)

!  write(*,*) 'Inside subroutine!'
!  write(*,*) ivt
!  write(*,*) dz
!  write(*,*) rootfr
!  write(*,*) sucsat
!  write(*,*) bsw
!  write(*,*) watsat
!  write(*,*) h2osoi_vol
!  write(*,*) t_soisno

  vol_ice = 0.
  btran = 0.

  tmp = 0.
  btran_z = 0.
  do i = 1, nlevgrnd
  !do i = 1, 10
      h2osoi_liq(i) = h2osoi_vol(i)*dz(i)*denh2o ! no ice in soil

      eff_porosity = watsat(i) - vol_ice
      !vol_liq = min( eff_porosity, h2osoi_liq(i)/(dz(i)*denh2o) )
      vol_liq = min( eff_porosity, h2osoi_vol(i) )
      if (vol_liq <= 0. .or. t_soisno(i) <= tfrz-2.) then
          rootr(i) = 0.
      else
          s_node = max(vol_liq/eff_porosity, 0.01)
          smp_node = max(smpsc(ivt), -sucsat(i)*s_node**(-bsw(i)))
          !rresis(i) = eff_porosity/watsat(i)*(smp_node - smpsc(ivt)) &
          !            /(smpso(ivt) - smpsc(ivt))
          rresis(i) = (smp_node - smpsc(ivt))/(smpso(ivt) - smpsc(ivt))
          rresis(i) = min(rresis(i), 1.)

          rootr(i) = rootfr(i)*rresis(i)
          btran = btran + rootr(i)
          btran_z(i) = rootr(i)
      endif
!   write(*,*) 'bbb',i, bsw(i), btran
  enddo
!  write(*,*) btran, tmp
  do i = 1, nlevgrnd
!      write(*,*) i, rootr(i), btran
      rootr(i) = rootr(i)/btran  ! used in soil water subroutine as TR sink
  enddo

  end subroutine Soil_Transpiration_Wetness_Factor

!==============================================================

  subroutine spd_porfile(can_u, h, lad_z, can_z, Utop, numcan)
  ! using Katul et al. 2004 K-e one equation model
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
  C0 = 0.2  ! drag coeffient

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

  !------- z in this submodel, with more layers than in MCM
  N = size(vt)
  allocate(lad(N), z(N))

  do i = 1, N
      z(i) = zmax*h/(N-1)*(i-1)
      call to_zk2( z(i), can_z_ex(1:numcan+2), lad_z_ex(1:numcan+2), numcan+2, tmp_out )
      lad(i) = tmp_out
  enddo
  dz = z(2) - z(1)

  !----------- Wake TKE budget coefficients (Sanz, 2003)
  !----------- Shortcircuit in Dissipation (linear in Bp)
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
  !-------------

  allocate( U(N), K(N) )

  Ulow = 0.
  Uhigh = Utop

  Khigh = 0.5*(AAu**2+AAv**2+AAw**2)
  Klow = 0.001*Khigh

  do i = 1, N
     U(i) = Ulow + (Uhigh - Ulow)/(N-1)*(i-1)
     K(i) = Klow + (Khigh - Klow)/(N-1)*(i-1)
  enddo

  !---------- Mixing Length model
  !fraction of mixing length (Lmixing = alpha x h) inside the canopy up to canopy top
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

  !----------------
  eps = 0.1
  maxerr = 1.e6

  allocate( dvt(N), dU(N) )
  allocate( aa(N), bb(N), cc(N), dd(N), Xn(N) )

  do while (.True.)
      if (maxerr < 1.e-3) exit

      !-------- Viscocity (and derivative) Model
      do i = 1, N
          vt(i) = Cu**0.25 * Lmix(i) * sqrt(abs(K(i)))
      enddo

      !----  dv/dz,  dU/dz ---
      do i = 2, N
          dvt(i) = (vt(i) - vt(i-1))/dz
          dU(i) = (U(i) - U(i-1))/dz
      enddo
      dvt(1) = dvt(2)
      dU(1) = dU(2)

      !------ Set the elements of the Tri-diagonal Matrix
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

      ! Use successive relaxations in iterations
      U = abs(eps*Xn + (1-eps)*U)

      !=========== for TKE ODE ============

      do i = 1, N
          aa(i) = vt(i)/(dz*dz) - dvt(i)/(2.*dz)
          bb(i) = -vt(i)*2/(dz*dz) - Bd*abs(U(i))*C0*lad(i)
          cc(i) = vt(i)/(dz*dz) + dvt(i)/(2.*dz)
          epson = sqrt(2.*K(i))**3/lambda3(i)  ! dissipation rate
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
              !write(*,*) maxerr
         endif
      enddo
      maxerr = maxerr1
      
  enddo

  do i = 1, numcan
      call to_zk2( can_z(i), z, U, N, tmp_out )
      can_u(i) = max(0.1, tmp_out)
  enddo

  end subroutine spd_porfile

!==============================================================
 

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
  
  !------- z in this submodel, with more layers than in MCM
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
  !write(*,*) 'SH', SH_z, 'g', SH_grnd

  !---- rescale to ensure total source is the same as from input (interp err)
  S = sum_ts/sum_ts1*S
  !write(*,*) sum_ts*sum_ts1

  !----------------
  allocate( C(N) )
  C = Ctop
  eps = 0.1
  maxerr = 1.e6

  allocate( dvt(N), aa(N), bb(N), cc(N), dd(N), Xn(N) )

  iter = 0.
  do while (.True.)
      if (iter >50 .or. maxerr < 1.e-4) exit

      !----  dv/dz,  dU/dz ---
      do i = 2, N
          dvt(i) = pr*(vt(i) - vt(i-1))/dz
      enddo
      dvt(1) = dvt(2)

      !------ Set the elements of the Tri-diagonal Matrix
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

      ! Use successive relaxations in iterations
      C = abs(eps*Xn + (1-eps)*C)

      maxerr1 = 0.
      do i = 1, N
         if (abs(Xn(i) - C(i)) > maxerr1) then
              maxerr1 = abs(Xn(i) - C(i))
              !write(*,*) maxerr
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

!==============================================================

  subroutine Surface_energy_balance_new(SHg, LEg, t_grnd, rsoil, forc_pbot, &
                                        Rn_grnd, G, tair, qair, &
                                        qsoil, tsoil, spd, sw_grnd )
  use clm_varpar_my , only : sc_p
  implicit none

  real, intent(out) :: SHg ! sensible heat flux from ground (W/m**2) [+ to atm]
  real, intent(out) :: LEg
  real, intent(out) :: t_grnd
  !real, intent(out) :: qflx_ev_grnd ! soil evaporation (kg/m**2/s) (+ = to atm)

  real, intent(in) :: forc_pbot, Rn_grnd, tair, qair, G, &
                      qsoil, tsoil, spd, sw_grnd

  real :: bsw           ! Clapp and Hornberger "b" (nlevgrnd)
  real :: watsat        ! volumetric soil water at saturation (porosity)
  real :: sucsat        ! minimum soil suction (mm) (nlevgrnd)
  
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
      !write(*,*) 'Surface engergy balance wrong', f1, f2, x1, x2
      call surface_energy_func( f2, 0.5*(tair + tsoil), LEg, SHg, rsoil, &
                                forc_pbot, Rn_grnd, tair, qair, G, &
                                qsoil, tsoil, spd, epsoil, watsat, sucsat, bsw, sw_grnd)

  endif
  ! write(*,*) tsoil, qsoil, SHg, LEg
  ! write(*,*) t_grnd, tair, Rn_grnd
  
  end subroutine Surface_energy_balance_new

!==============================================================

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
  !if (sw_grnd > 0.) then
      rah = 600./spd1  ! need to be improved
  else
      rah = 9000./spd1
  endif
  !rah = 1.
     
  SHg = rho_air*cpair*(t_grnd - t_air)/rah

  fac  = max( 0.01, min(1., qsoil/watsat) )
  psit = max( -sucsat * fac ** -bsw, smpmin )

  tg = 0.5*t_grnd + 0.5*tsoil

  ! modify qred to account for h2osfc, eq. 5.72
  hr = exp(psit/roverg/tg)

  call QSat(tg , forc_pbot, tmp1, tmp2, qsatg, tmp3)

  if ( qsatg > q_air .and. q_air > hr*qsatg ) then
      qg_soil = q_air
  else
      qg_soil = hr*qsatg
  endif

  !rsoil = exp(11.5-8.5*fac)
  rsoil = exp(11.5-7.5*fac)

  LEg = rho_air*hvap*(qg_soil - q_air)/(rsoil + rah)
  LEg = max(0., LEg)

  fval = Rn_grnd - SHg - LEg + G - epsoil*sb*t_grnd**4

  end subroutine surface_energy_func

!==============================================================

  subroutine tgrnd_brent( t_grnd, x1, x2, f1, f2, &
                          LEg, SHg, rsoil, forc_pbot, Rn_grnd, t_air, q_air, G, &
                          qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)
  implicit none

  real, intent(in) :: forc_pbot, Rn_grnd, t_air, q_air, G, &
                      qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd
  real, intent(out) :: t_grnd, SHg, LEg, rsoil

  ! --- local ---
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            !maximum number of iterations
  real, parameter :: EPS = 1.e-4       !relative error tolerance

  ! initial guess

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
          c = a   !Rename a, b, c and adjust bounding interval d.
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
      tol1 = 2.*EPS*abs(b)  !Convergence check.
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          t_grnd = b
          call surface_energy_func( fval, b, LEg, SHg, rsoil,  &
                                    forc_pbot, Rn_grnd, t_air, q_air, G, &
                                    qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa !Attempt inverse quadratic interpolation.
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q !Check whether in bounds.
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d !Accept interpolation.
              d = p/q
          else
              d = xm  !Interpolation failed, use bisection.
              e = d
          endif
      else !Bounds decreasing too slowly, use bisection.
          d = xm
          e = d
      endif

      a = b !Move last best guess to a.
      fa = fb
      if(abs(d) > tol1) then !Evaluate new trial root.
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call surface_energy_func( fb, b, LEg, SHg, rsoil, &
                                forc_pbot, Rn_grnd, t_air, q_air, G, &
                                qsoil, tsoil, spd1, epsoil, watsat, sucsat, bsw, sw_grnd)

      if( fb == 0.) exit
  enddo

!  if(iter == ITMAX) write(*,*) 'brent exceeding maximum iterations', b, fb

  t_grnd = b
  fval = fb
  return

  end subroutine tgrnd_brent

!==============================================================

  subroutine Surface_energy_balance( eflx_sh_grnd, qflx_ev_grnd, cgrnd, &
                                     rah, rsoil, &
                                     q_air, t_air, rho_air, forc_pbot,  &
                                     h2osoi_grnd, t_grnd, us, coszen, &
                                     dz, bsw, watsat, sucsat )
!                                     sabg, dlrad )

  use clm_varpar_my , only : denh2o, denice, roverg, cpair, hvap, smpmin
  implicit none

  real, intent(out) :: eflx_sh_grnd ! sensible heat flux from ground (W/m**2) [+ to atm]
  real, intent(out) :: qflx_ev_grnd ! soil evaporation (kg/m**2/s) (+ = to atm)
  real, intent(out) :: cgrnd        ! deriv. of soil energy flux wrt to soil temp [w/m2/k]
                                    ! (dH/dT + d(rE)/dT)
  real, intent(out) :: rah          ! aerodynamic resistance (s/m)
  real, intent(out) :: rsoil        ! aerodynamic resistance (s/m)
  real, intent(in) :: q_air         ! humidity ratio at first layer of air, (kg/kg)
  real, intent(in) :: t_air         ! temp at first layer of air, (K)
  real, intent(in) :: rho_air       ! density at first layer of air, (kg/m^3)
  real, intent(in) :: forc_pbot     ! pressure (Pa)
  real, intent(in) :: h2osoi_grnd   ! soil top layer liquid water (m^3/m^3)
  real, intent(in) :: t_grnd        ! equal to first soil layer temp (K)
  real, intent(in) :: us
  real, intent(in) :: dz            ! layer thickness (m)
  real, intent(in) :: bsw           ! Clapp and Hornberger "b" (nlevgrnd)
  real, intent(in) :: watsat        ! volumetric soil water at saturation (porosity)
  real, intent(in) :: sucsat        ! minimum soil suction (mm) (nlevgrnd)
  real :: coszen

!  REAL :: sabg        ! solar radiation absorbed by ground (W/m**2)
!  real :: dlrad
  !real :: xkmv ! SGS diffusive coefficent [m^/s], Shao el. at. 2013, BLM
  !real :: z1  ! first layer hegiht AGL [m]
  !real :: z0  ! roughness [m]

  ! --- local ---
  real :: soilbeta       ! soil wetness relative to field capacity
  real :: wx, fac, psit, hr
  real :: qg_soil, dqgdT, dummy, qsatg, qsatgdT
  real :: raih, raiw

! Sakaguchi and Zeng, 2009. soil resistence
  real, parameter :: D0 = 2.2e-5   ! molecular difficient (m^2/s)
  real, parameter :: e = 2.718
  real :: D, L 
  real :: thetar
  real :: tmp1, tmp2, tmp3

  ! --- from Biogeophysics1Mod.F90 ---

  !wx   = (h2osoi_liq(1)/denh2o+h2osoi_ice(1)/denice)/dz(1)
  wx   = h2osoi_grnd       ! no ice
  fac  = max( 0.01, min(1., wx/watsat) )
  psit = -sucsat * fac ** (-bsw)
  psit = max(smpmin, psit)

  ! modify qred to account for h2osfc, eq. 5.72
  hr   = exp(psit/roverg/t_grnd)

  call QSat(t_grnd , forc_pbot, tmp1, tmp2, qsatg, qsatgdT)
  if (qsatg > q_air .and. q_air > hr*qsatg) then
     qg_soil = q_air
     dqgdT = 0. 
  else
     qg_soil = hr*qsatg
     dqgdT = hr*qsatgdT
  end if

!  if ( z0 > z1 ) then
!      write(*,*) 'roughness length must larger than first layer height!'
!      STOP
!  else
!      rah = z1/xkmv*log(z1/z0)  ! Shao et al. 2013, BLM
!  endif
!  rah = 100.
  
  if ( isnan(us)) then
      rah = 450.
  else
      rah = 45./us
  endif

  ! ----------------------------
  ! Sakaguchi and zeng, 2009
  thetar = watsat * (smpmin/(-sucsat))**(-1./bsw)
  D = D0 * watsat**2 * (1. - thetar/watsat)**(2. + 3.*bsw)
  !L = dz / (e - 1.) * (exp( (1. - fac)**5 ) - 1.)
  L = dz / (e - 1.) * (exp( (1. - fac)**5 ) - 1.)
  rsoil = L/D*0.3
  !write(*,*) fac, wx, rsoil
  ! ----------------------------

  !write(*,*) 'hr', hr, rsoil

  raiw = rho_air/(rah + rsoil)
  raih = rho_air*cpair/rah

  ! Derivative of fluxes with respect to ground temperature
   cgrnd = raih + hvap*raiw*dqgdT  ! pick up LW/dt later

  qflx_ev_grnd = -raiw*(q_air - qg_soil)  ! [kg/m^2/s]
  eflx_sh_grnd = -raih*(t_air - t_grnd)  ![ W/m^2 ]

!write(*,*) coszen, eflx_sh_grnd, t_air , t_grnd
  !write(*,*) 'Surf LE, SH:', qflx_ev_grnd*hvap, eflx_sh_grnd

  !qflx_ev_grnd  = min( qflx_ev_grnd, (sabg + dlrad - eflx_sh_grnd)/hvap )

  end subroutine Surface_energy_balance

!==============================================================

  subroutine Photosynthesis( rs_sun_z, rs_sha_z, ci_sun_z, ci_sha_z, an_sun_z, an_sha_z,  &
                             ac_sun_z, ac_sha_z, aj_sun_z, aj_sha_z, ap_sun_z, ap_sha_z,  &
                             lmr_z, &
                             gs_mol_sun_z, gs_mol_sha_z, psncan, psncan_ac, psncan_aj, gscan, &! 
                             ivt, forc_pbot, par_sun_z, par_sha_z, tair_z, cair_z_ppm,&
                             tveg_z, qair_z, tlai_z, fsun_z, t10, dayl_factor, btran, rb_z, nrad )
                          
  use clm_varpar_my  , only : po2, mxlevcan_wrf, rgas, tfrz, slatop, leafcn, flnr, c3psn, sc_p
  implicit none

  integer, intent(in) :: ivt          ! vegetation type
  integer, intent(in) :: nrad         ! number of canopy layers, above snow
  !logical, intent(in) :: c3flag       ! true if C3 and false if C4
  real, intent(in) :: forc_pbot       ! atmospheric pressure (Pa)
  real, intent(in) :: par_sun_z(mxlevcan_wrf) ! par absorbed per unit lai for canopy layer (w/m**2)
  real, intent(in) :: par_sha_z(mxlevcan_wrf) ! par absorbed per unit lai for canopy layer (w/m**2)
  real, intent(in) :: tair_z(mxlevcan_wrf)    ! air temperature at canopy layer (kelvin)
  real, intent(in) :: cair_z_ppm(mxlevcan_wrf)    ! Atmospheric CO2 (ppm)
  real, intent(in) :: tveg_z(mxlevcan_wrf)    ! vegetation temperature (Kelvin)
  real, intent(in) :: qair_z(mxlevcan_wrf)    ! humidity (kg/kg)
  real, intent(in) :: tlai_z(mxlevcan_wrf)    ! total leaf area index for canopy layer
  real, intent(in) :: fsun_z(mxlevcan_wrf)    ! sunlit fraction of canopy layer, 0 - 1.0
  real, intent(in) :: t10             ! 10-day running mean of the 2 m temperature (K)
  real, intent(in) :: dayl_factor     ! scalar (0-1) for daylength effect on Vcmax
  real, intent(in) :: btran           ! transpiration wetness factor (0 to 1)
  real, intent(in) :: rb_z(mxlevcan_wrf)      ! boundary layer resistance (s/m)

  !------- out ---------
  real, intent(out) :: rs_sun_z(mxlevcan_wrf)   ! canopy layer: leaf stomatal resistance (s/m)
  real, intent(out) :: rs_sha_z(mxlevcan_wrf)   ! canopy layer: leaf stomatal resistance (s/m)
  real, intent(out) :: ci_sun_z(mxlevcan_wrf)   ! intracellular leaf CO2 (Pa)
  real, intent(out) :: ci_sha_z(mxlevcan_wrf)   ! intracellular leaf CO2 (Pa)
  real, intent(out) :: an_sun_z(mxlevcan_wrf)   ! net leaf photosynthesis (umol CO2/m**2/s)
  real, intent(out) :: an_sha_z(mxlevcan_wrf)   ! net leaf photosynthesis (umol CO2/m**2/s)
  real, intent(out) :: ac_sun_z(mxlevcan_wrf)  
  real, intent(out) :: ac_sha_z(mxlevcan_wrf) 
  real, intent(out) :: aj_sun_z(mxlevcan_wrf)  
  real, intent(out) :: aj_sha_z(mxlevcan_wrf)  
  real, intent(out) :: ap_sun_z(mxlevcan_wrf) 
  real, intent(out) :: ap_sha_z(mxlevcan_wrf) 
  real, intent(out) :: gs_mol_sun_z(mxlevcan_wrf) ! leaf stomatal conductance (umol H2O/m**2/s)
  real, intent(out) :: gs_mol_sha_z(mxlevcan_wrf) ! leaf stomatal conductance (umol H2O/m**2/s)


  real :: psncan 
  ! ------- local ------
  real :: lmr_z(mxlevcan_wrf) ! canopy layer: leaf maintenance respiration rate (umol CO2/m**2/s)
  real :: rh_leaf       ! fractional humidity at leaf surface (dimensionless)
  real :: oair          ! Atmospheric O2 partial pressure (Pa)

  ! Leaf photosynthesis parameters
  real :: vcmax_z(mxlevcan_wrf) ! maximum rate of carboxylation (umol co2/m**2/s)
  real :: jmax_z(mxlevcan_wrf)  ! maximum electron transport rate (umol electrons/m**2/s)
  real :: tpu_z(mxlevcan_wrf)   ! triose phosphate utilization rate (umol CO2/m**2/s)
  real :: kp_z(mxlevcan_wrf)    ! initial slope of CO2 response curve (C4 plants)

  real :: lnc        ! leaf N concentration (gN leaf/m^2)
  !real, allocatable, dimension(:) :: kc_z ! Michaelis-Menten constant for CO2 (Pa)
  real :: kc_z(mxlevcan_wrf) ! Michaelis-Menten constant for CO2 (Pa)
  real :: ko_z(mxlevcan_wrf) ! Michaelis-Menten constant for O2 (Pa)
  real :: cp_z(mxlevcan_wrf) ! CO2 compensation point (Pa)
  real :: bbbopt     ! Ball-Berry minimum leaf conductance, unstressed (umol H2O/m**2/s)
  real :: bbb        ! Ball-Berry minimum leaf conductance (umol H2O/m**2/s)
  real :: mbbopt     ! Ball-Berry slope of conductance-photosynthesis relationship, unstressed
  real :: mbb        ! Ball-Berry slope of conductance-photosynthesis relationship
  real :: kn         ! leaf nitrogen decay coefficient
  real :: vcmax25top ! canopy top: maximum rate of carboxylation at 25C (umol CO2/m**2/s)
  real :: jmax25top  ! canopy top: maximum electron transport rate at 25C (umol electrons/m**2/s)
  real :: tpu25top   ! canopy top: triose phosphate utilization rate at 25C (umol CO2/m**2/s)
  real :: lmr25top   ! canopy top: leaf maintenance respiration rate at 25C (umol CO2/m**2/s)
  real :: kp25top    ! canopy top: initial slope of CO2 response curve (C4 plants) at 25C

  real :: vcmax25    ! leaf layer: maximum rate of carboxylation at 25C (umol CO2/m**2/s)
  real :: jmax25     ! leaf layer: maximum electron transport rate at 25C (umol electrons/m**2/s)
  real :: tpu25      ! leaf layer: triose phosphate utilization rate at 25C (umol CO2/m**2/s)
  real :: lmr25      ! leaf layer: leaf maintenance respiration rate at 25C (umol CO2/m**2/s)
  real :: kp25       ! leaf layer: Initial slope of CO2 response curve (C4 plants) at 25C
  real :: kc25       ! Michaelis-Menten constant for CO2 at 25C (Pa)
  real :: ko25       ! Michaelis-Menten constant for O2 at 25C (Pa)
  real :: cp25       ! CO2 compensation point at 25C (Pa)

  real :: vcmaxha    ! activation energy for vcmax (J/mol)
  real :: jmaxha     ! activation energy for jmax (J/mol)
  real :: tpuha      ! activation energy for tpu (J/mol)
  real :: lmrha      ! activation energy for lmr (J/mol)
  real :: kcha       ! activation energy for kc (J/mol)
  real :: koha       ! activation energy for ko (J/mol)
  real :: cpha       ! activation energy for cp (J/mol)

  real :: vcmaxhd    ! deactivation energy for vcmax (J/mol)
  real :: jmaxhd     ! deactivation energy for jmax (J/mol)
  real :: tpuhd      ! deactivation energy for tpu (J/mol)
  real :: lmrhd      ! deactivation energy for lmr (J/mol)

  real :: vcmaxse    ! entropy term for vcmax (J/mol/K)
  real :: jmaxse     ! entropy term for jmax (J/mol/K)
  real :: tpuse      ! entropy term for tpu (J/mol/K)
  real :: lmrse      ! entropy term for lmr (J/mol/K)

  real :: vcmaxc     ! scaling factor for high temperature inhibition (25 C = 1.0)
  real :: jmaxc      ! scaling factor for high temperature inhibition (25 C = 1.0)
  real :: tpuc       ! scaling factor for high temperature inhibition (25 C = 1.0)
  real :: lmrc       ! scaling factor for high temperature inhibition (25 C = 1.0)

  !--------
  real :: esat_tv    ! saturation vapor pressure at t_veg (Pa)
  real :: cf         ! s m**2/umol -> s/m
  real :: rsmax0     ! maximum stomatal resistance [s/m]
  real :: cs1        ! CO2 partial pressure at leaf surface (Pa)
  real :: cs2        ! CO2 partial pressure at leaf surface (Pa)
  real :: hs1        ! fractional humidity at leaf surface (dimensionless)
  real :: hs2        ! fractional humidity at leaf surface (dimensionless)
 !real :: gs         ! leaf stomatal conductance (m/s)
  real :: sco        ! relative specificity of rubisco
  real :: ft         ! photosynthesis temperature response (statement function)
  real :: fth        ! photosynthesis temperature inhibition (statement function)
  real :: fth25      ! ccaling factor for photosynthesis temperature inhibition (statement function)
  real :: tl         ! leaf temperature in photosynthesis temperature function (K)
  real :: ha         ! activation energy in photosynthesis temperature function (J/mol)
  real :: hd         ! deactivation energy in photosynthesis temperature function (J/mol)
  real :: se         ! entropy term in photosynthesis temperature function (J/mol/K)
  real :: cc         ! scaling factor for high temperature inhibition (25 C = 1.0)
  real :: ciold      ! previous value of Ci for convergence check
  real :: gs_mol_err1! gs_mol for error check
  real :: gs_mol_err2! gs_mol for error check
!  real :: ceair      ! vapor pressure of air, constrained (Pa)
  real :: fnr        ! (gRubisco/gN in Rubisco)
  real :: act25      ! (umol/mgRubisco/min) Rubisco activity at 25 C
  integer  :: niter  ! iteration loop index
  real :: nscaler    ! leaf nitrogen scaling coefficient

  real :: gb_mol         ! leaf boundary layer conductance (umol H2O/m**2/s)

  real :: laican         ! canopy sum of lai_z
  real :: rh_can

  real :: cair_z(mxlevcan_wrf)    ! Atmospheric CO2 partial pressure (Pa)
  logical :: c3flag       ! true if C3 and false if C4
 
  integer :: iv, iter
  real :: dummy, eair, forc_pbot1
  real :: psncan_sun, psncan_sha
  real :: psncan_ac_sun, psncan_ac_sha
  real :: psncan_aj_sun, psncan_aj_sha
  real :: psncan_ac, psncan_aj
  real :: tlai_sun, tlai_sha
  real :: rs, rb, gscan, gscan_sun, gscan_sha
  real :: tmp1, tmp2, tmp3


  !-------------------------------------------------------------------------------- 
  ! Temperature and soil water response functions
 
  ft(tl,ha) = exp( ha / (rgas*1.e-3*(tfrz+25.)) * (1. - (tfrz+25.)/tl) )
  fth(tl,hd,se,cc) = cc / ( 1. + exp( (-hd+se*tl) / (rgas*1.e-3*tl) ) )    ! Eq. 8.11
  fth25(hd,se) = 1. + exp( (-hd+se*(tfrz+25.)) / (rgas*1.e-3*(tfrz+25.)) ) ! Eq. 8.11

  !---------------------
  if ( c3psn(ivt) == 1.0 ) then
      c3flag = .true.
  else
      c3flag = .false.
  endif

  !oair = po2 * forc_pbot
  !cair_z = cair_z_ppm * forc_pbot * 1.e-6  ! ppmv -> pa
  !oair = 210000. ! m mol
  !cair_z = 385.
  !==============================================================================!

  !if (ivt == nsoybean .or. ivt == nsoybeanirrig) btran = min(1.8, btran * 1.25)

  !-----------------------
  ! kc, ko, cp, from: Bernacchi et al (2001) Plant, Cell and Environment 24:253-259
  !
  !       kc25 = 404.9 umol/mol
  !       ko25 = 278.4 mmol/mol
  !       cp25 = 42.75 umol/mol
  !
  ! Derive sco from cp and O2 using present-day O2 (0.209 mol/mol) and re-calculate
  ! cp to account for variation in O2 using cp = 0.5 O2 / sco

  oair = 0.210 * forc_pbot
  !cair_z = 385. * forc_pbot * 1.e-6  ! ppmv -> pa
  cair_z = 379. * forc_pbot * 1.e-6

  kcha = 79430.
  koha = 36380.
  cpha = 37830.

  kc25 = (404.9 / 1.e6) * forc_pbot
  ko25 = (278.4 / 1.e3) * forc_pbot
  !ko25 = (322. / 1.e3) * forc_pbot1
  !sco = 0.5 * 0.209 / (42.75 / 1.e06)
  !cp25 = 0.5 * oair / sco   ! CO2 compensation point at 25C (Pa)
  cp25 = (42.75 / 1.e6) * forc_pbot
  
  do iv = 1, nrad
      ! used in C3 plants
      kc_z(iv) = kc25 * ft(tveg_z(iv), kcha)
      ko_z(iv) = ko25 * ft(tveg_z(iv), koha)
      cp_z(iv) = cp25 * ft(tveg_z(iv), cpha)
      !kc_z(iv) = 403. * ft(tveg_z(iv), kcha)
      !ko_z(iv) = 322000.* ft(tveg_z(iv), koha)
      !cp_z(iv) = 41.* ft(tveg_z(iv), cpha)
      !write(*,*) 'kc, ko, cp:', iv, kc_z(iv), ko_z(iv), cp_z(iv)
  enddo
  !-----------------------


  !-----------------------
  ! vcmax25top and parameters derived from vcmax25top at canopy top
  ! Bonan et al (2011) JGR, 116, doi:10.1029/2010JG001593

  ! cal. vcmax25 at canopy top, as in CN but using lnc at top of the canopy
  !lnc = 1. / (slatop(ivt) * leafcn(ivt)) ! Leaf nitrogen concentration at top (g N / m**2 leaf)
  !fnr = 7.16  ! vcmax25 parameters, from CN
  !act25 = 60. ! umol/gRubisco/s
  !vcmax25top = lnc * flnr(ivt) * fnr * act25 * dayl_factor
  vcmax25top = 55.  ! yulong
  
  !jmax25top = 1.97 * vcmax25top ! Wullschleger (1993) Journal of Experimental Botany 44:907-920.
  jmax25top = (2.59 - 0.035*min(max((t10-tfrz),11.),35.)) * vcmax25top  ![ (2.2~1.36) vcmax25]
  tpu25top = 0.167 * vcmax25top
  kp25top = 20000. * vcmax25top  ! used in PEP carboxylase-limited rate (C4 only)

  ! Leaf maintenance respiration in proportion to vcmax25top
  if (c3flag) then
      lmr25top = 0.015 * vcmax25top
  else
      lmr25top = 0.025 * vcmax25top
  end if
  !-----------------------

  !-----------------------
  ! Activation energy, from:
  ! Bernacchi et al (2001) Plant, Cell and Environment 24:253-259
  ! Bernacchi et al (2003) Plant, Cell and Environment 26:1419-1430
  ! except TPU from: Harley et al (1992) Plant, Cell and Environment 15:271-282

  vcmaxha = 72000.
  jmaxha  = 50000.
  tpuha   = 72000.
  lmrha   = 46390.

  ! High temperature deactivation, from:
  ! Leuning (2002) Plant, Cell and Environment 25:1205-1210
  ! The factor "c" scales the deactivation to a value of 1.0 at 25C

  vcmaxhd = 200000.
  jmaxhd  = 200000.
  tpuhd   = 200000.
  lmrhd   = 150650.
  lmrse   = 490.
  lmrc   = fth25 (lmrhd, lmrse)
  !-----------------------
  
  !-----------------------
  ! Nitrogen scaling factor. Bonan et al (2011) JGR, 116, doi:10.1029/2010JG001593 used
  ! kn = 0.11. Here, derive kn from vcmax25 as in Lloyd et al (2010) Biogeosciences, 7, 1833-1859
  ! Remove daylength factor from vcmax25 so that kn is based on maximum vcmax25
  ! But not used as defined here if using sun/shade big leaf code. Instead,
  ! will use canopy integrated scaling factors from SurfaceAlbedo.

  !if (dayl_factor .eq. 0.) then
  !    kn =  0.
  !else
  !    kn = exp(0.00963 * vcmax25top/dayl_factor - 2.43) ! Eq. 8.38
  !    !kn = 0.11
  !end if
  kn = 0.22 ! yulong
  !-----------------------


  ! Loop through canopy layers (above snow). Respiration needs to be
  ! calculated every timestep. Others are calculated only if daytime

  laican = 0.
  do iv = 1, nrad

      ! Scale for leaf nitrogen profile. If multi-layer code, use explicit
      ! profile. If sun/shade big leaf code, use canopy integrated factor.

      ! Loop through each canopy layer to calculate nitrogen profile using
      ! cumulative lai at the midpoint of the layer
      if (iv == 1) then
          laican = 0.5 * tlai_z(iv)
      else
          laican = laican + 0.5 * (tlai_z(iv-1)+tlai_z(iv))
      end if
      nscaler = exp(-kn * laican)

      ! Maintenance respiration

      lmr25 = lmr25top * nscaler
      if (c3flag) then
          lmr_z(iv) = lmr25 * ft(tveg_z(iv), lmrha) * fth(tveg_z(iv), lmrhd, lmrse, lmrc)
          !lmr_z(iv) = 0.015*60.
      else
          lmr_z(iv) = lmr25 * 2.**((tveg_z(iv)-(tfrz+25.))/10.) &
                            / (1. + exp( 1.3*(tveg_z(iv)-(tfrz+55.)) ))
      end if
      !lmr_z(iv) = lmr_z(iv) * btran  ! Adjust for soil water, move this to ci_func

      if (par_sun_z(iv) <= 0.) then           ! night time

         vcmax_z(iv) = 0.
         jmax_z(iv) = 0.
         tpu_z(iv) = 0.
         kp_z(iv) = 0.

     else                                 ! day time

         vcmax25 = vcmax25top * nscaler
         !vcmax25 = vcmax25 * btran ! Adjust for soil water, move this to ci_func
         if (c3flag) then

             ! Adjust for temperature
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


  end do       ! canopy layer loop

  !==============================================================================!
  ! Leaf-level photosynthesis and stomatal conductance
  !==============================================================================!

  if (c3flag) then
     bbbopt = 10000.
     mbbopt = 9.
     bbbopt = 20000.  ! yulong
     mbbopt = 16.5 ! yulong
  else
     bbbopt = 40000.
     mbbopt = 4.
  end if

  ! Soil water stress applied to Ball-Berry parameters, move this to ci_func
  bbb = max(bbbopt*btran, 1.)
  !bbb = bbbopt
  mbb = mbbopt

  !bbb = max(bbbopt*btran*0.8, 1.)
  !mbb = mbbopt*0.8
  !bbb = max(bbbopt*btran*sc_p(1), 1.)
  !mbb = mbbopt*sc_p(2)

  rsmax0 = 2.5e4
  !rsmax0 = 8.e4
 
  ac_sun_z = 0.
  aj_sun_z = 0.
  ap_sun_z = 0.
  an_sun_z = 0.
  ! Loop through canopy layers (above snow). Only do calculations if daytime
  do iv = 1, nrad

      cf = forc_pbot/(rgas*tair_z(iv))*1.e09  ! 1 s/m = 1.e-9 * R * T/P umol/m**2/s

      if (par_sun_z(iv) <= 0.) then           ! night time

          an_sun_z(iv) = - lmr_z(iv)*btran
          rs_sun_z(iv) = min(rsmax0, 1./bbb * cf)
          ci_sun_z(iv) = 0.

      else                                     ! day time

          ! Leaf boundary layer conductance, umol/m**2/s
          gb_mol = 1./rb_z(iv) * cf

          call QSat (tveg_z(iv), forc_pbot, esat_tv, tmp1, tmp2, tmp3)
          eair = qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198)
          eair = min( eair,  esat_tv )
          !rh_can = eair / esat_tv

          ! Iterative loop for ci beginning with initial guess
          if (c3flag) then
              ci_sun_z(iv) = 0.7 * cair_z(iv)
          else
              ci_sun_z(iv) = 0.4 * cair_z(iv)
          end if

          ! find ci and stomatal conductance gs_mol_z, and an
          call hybrid( ci_sun_z(iv), gs_mol_sun_z(iv), an_sun_z(iv),   &
                       ac_sun_z(iv), aj_sun_z(iv), ap_sun_z(iv),       &
                       vcmax_z(iv), cp_z(iv), kc_z(iv), ko_z(iv),      &
                       jmax_z(iv), par_sun_z(iv), tpu_z(iv), kp_z(iv), &
                       lmr_z(iv), cair_z(iv), oair, eair, esat_tv, forc_pbot,   &
                       gb_mol, mbbopt, bbbopt, btran, c3flag )

          ! Convert gs_mol (umol H2O/m**2/s) to rs (s/m)
          rs_sun_z(iv) = min(cf / gs_mol_sun_z(iv), rsmax0)

      end if    ! night or day if branch


      if (par_sha_z(iv) <= 0.) then           ! night time

          an_sha_z(iv) = - lmr_z(iv)*btran
          rs_sha_z(iv) = min(rsmax0, 1./bbb * cf)
          ci_sha_z(iv) = 0.

      else                                     ! day time

          ! Leaf boundary layer conductance, umol/m**2/s
          gb_mol = 1./rb_z(iv) * cf

          call QSat (tveg_z(iv), forc_pbot, esat_tv, tmp1, tmp2, tmp3)
          eair = qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198)
          eair = min( eair,  esat_tv )
          !rh_can = eair / esat_tv

          ! Iterative loop for ci beginning with initial guess
          if (c3flag) then
              ci_sha_z(iv) = 0.7 * cair_z(iv)
          else
              ci_sha_z(iv) = 0.4 * cair_z(iv)
          end if

          ! find ci and stomatal conductance gs_mol_z, and an
          call hybrid( ci_sha_z(iv), gs_mol_sha_z(iv), an_sha_z(iv),   &
                       ac_sha_z(iv), aj_sha_z(iv), ap_sha_z(iv),       &
                       vcmax_z(iv), cp_z(iv), kc_z(iv), ko_z(iv),      &
                       jmax_z(iv), par_sha_z(iv), tpu_z(iv), kp_z(iv), &
                       lmr_z(iv), cair_z(iv), oair, eair, esat_tv, forc_pbot,   &
                       gb_mol, mbbopt, bbbopt, btran, c3flag )

          ! Convert gs_mol (umol H2O/m**2/s) to rs (s/m)
          rs_sha_z(iv) = min(cf / gs_mol_sha_z(iv), rsmax0)

      end if    ! night or day if branch

  end do        ! canopy layer loop

  end subroutine Photosynthesis

!==============================================================

  subroutine Photosynthesis_new( gs_sun_z, gs_sha_z, An_sun_z, An_sha_z, &
                                 Ag_sun_z, Ag_sha_z, &
                                 forc_pbot, tair_z, qair_z, cair_z, &
                                 tc_sun_z, tc_sha_z, fsun_z, lai_z, rb_z, & !gb_z, &
                                 par_sun_z, par_sha_z, numcan ) 

  use clm_varpar_my  , only : po2, mxlevcan_wrf, rgas, sc_p
  implicit none

  integer, intent(in) :: numcan        ! number of canopy layers, above snow
  real, intent(in) :: forc_pbot       ! atmospheric pressure (Pa)
  real, intent(in) :: tair_z(mxlevcan_wrf)    ! air temperature at canopy layer (kelvin)
  real, intent(in) :: qair_z(mxlevcan_wrf)    ! g/kg
  real, intent(in) :: cair_z(mxlevcan_wrf)    ! Atmospheric CO2 (ppm)
  real, intent(in) :: rb_z(mxlevcan_wrf)      ! boundary layer resistance (s/m)
!  real, intent(in) :: gb_z(mxlevcan_wrf)      ! boundary layer conductance (m/s)
  real, intent(in) :: tc_sun_z(mxlevcan_wrf)
  real, intent(in) :: tc_sha_z(mxlevcan_wrf)
  real, intent(in) :: fsun_z(mxlevcan_wrf)    ! sunlit fraction of canopy layer, 0 - 1.0
  real, intent(in) :: lai_z(mxlevcan_wrf)  ! total leaf area index for canopy layer
  real, intent(in) :: par_sun_z(mxlevcan_wrf) ! par absorbed per unit lai for canopy layer (w/m**2)
  real, intent(in) :: par_sha_z(mxlevcan_wrf) ! par absorbed per unit lai for canopy layer (w/m**2)

  real, intent(out) :: gs_sun_z(mxlevcan_wrf) ! m/s
  real, intent(out) :: gs_sha_z(mxlevcan_wrf) ! m/s
  real, intent(out) :: An_sun_z(mxlevcan_wrf) ! net leaf photosynthesis (umol CO2/m**2/s) 
  real, intent(out) :: An_sha_z(mxlevcan_wrf) ! net leaf photosynthesis (umol CO2/m**2/s)
  real, intent(out) :: Ag_sun_z(mxlevcan_wrf) ! gross leaf photosynthesis (umol CO2/m**2/s)
  real, intent(out) :: Ag_sha_z(mxlevcan_wrf) ! gross leaf photosynthesis (umol CO2/m**2/s)

  !--- local ---
  real :: ci_sun_z(mxlevcan_wrf)   ! Pa
  real :: ci_sha_z(mxlevcan_wrf)   ! Pa


  real :: kn         ! leaf nitrogen decay coefficient
  real :: vcmax25top ! canopy top: maximum rate of carboxylation at 25C (umol CO2/m**2/s)
  real :: lmr25, lmr   !  leaf maintenance respiration rate at 25C (umol CO2/m**2/s)

  real :: vcmax25    ! leaf layer: maximum rate of carboxylation at 25C (umol CO2/m**2/s)

  real :: cf         ! s m**2/mol -> s/m
  real :: g0         ! minimum leaf conductance (mol H2O/m**2/s)
  real :: m          ! gs slope
  real :: tlai
  real :: esat_sun_tv, esat_sha_tv, eair  ! water vapor pressure, Pa
  real :: cair       ! co2 pressure, Pa
  real :: gb_mol, gs_mol, ci, An, Ag

  integer :: iv
  real :: tmp1, tmp2, tmp3

  integer :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn

  ! ---- temp func ----
  real :: ft         ! photosynthesis temperature response (statement function)
  real :: fth        ! photosynthesis temperature inhibition (statement function)
  real :: tc         ! leaf temperature in photosynthesis temperature function (K)
  real :: ha         ! activation energy in photosynthesis temperature function (J/mol)
  real :: hd         ! deactivation energy in photosynthesis temperature function (J/mol)
  real :: se         ! entropy term in photosynthesis temperature function (J/mol/K)

  ft(tc, ha) = exp( ha / (rgas*1.e-3*298.15) * (1. - 298.15/tc) )

  fth(tc, hd, se) = ( 1. + exp((se*298.15 - hd)/(rgas*1.e-3*298.15)) ) / &
                      ( 1. + exp((se*tc - hd)/(rgas*1.e-3*tc)) ) ! Eq. 8.11
  !=======================================

  !opt = 1;  m = 9.;  g0 = 0.01
  !opt = 2;  m = 6.0;   g0 = 0.01
  !opt = 2;  m = 6.2;   g0 = 0.01  
  opt = 2;  m = 4.4;   g0 = 0.02   ! Katul
  !opt = 3;  m = 2.7;  g0 = 0.01
  !opt = 3;  m = 3.;  g0 = 0.01
  !m = sc_p(1)

  !========================
  !vcmax25top = 75.5  ! CHATS
  vcmax25top = 64.  ! Katul
  kn = 0.1

!  TWJ
!  write(*,*) 'In Photosynthesis_new!'

!  write(*,*) numcan, forc_pbot
!  write(*,*) '!!!!! 1'
!  write(*,*) tair_z
!  write(*,*) '!!!!! 2'
!  write(*,*) qair_z
!  write(*,*) '!!!!! 3'
!  write(*,*) cair_z
!  write(*,*) '!!!!! 4'
!!  write(*,*) gb_z
!!  write(*,*) '!!!!! 5'
!  write(*,*) rb_z
!  write(*,*) '!!!!! 5'
!  write(*,*) tc_sun_z
!  write(*,*) '!!!!! 6'
!  write(*,*) tc_sha_z
!  write(*,*) '!!!!! 7'
!  write(*,*) fsun_z
!  write(*,*) '!!!!! 8'
!  write(*,*) lai_z
!  write(*,*) '!!!!! 9'
!  write(*,*) par_sun_z
!  write(*,*) '!!!!! 10'
!  write(*,*) par_sha_z


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

!      write(*,*) 'Done QSat!'

      eair = min( qair_z(iv)*forc_pbot/(qair_z(iv) + 0.62198), esat_sha_tv)
      cair = cair_z(iv) * forc_pbot * 1.e-6 ! ppmv to Pa

!      write(*,*) 'Done eair/cair!'

      cf = forc_pbot/(rgas*tair_z(iv))*1.e03 ! 1 s/m = 1.e-9 * R * T/P umol/m**2/s

!      write(*,*) 'Done cf!'

!      gb_mol = gb_z(iv)*cf  ! m/s  to mol/m^2/s
      gb_mol = (1./rb_z(iv))*cf  ! m/s  to mol/m^2/s
 
      if (par_sun_z(iv) > 0.) then

          call find_ci( ci, gs_mol, An, Ag, &
                        forc_pbot, cair, eair, esat_sun_tv, tc_sun_z(iv), par_sun_z(iv), &
                        gb_mol, g0, m, vcmax25, opt )

          gs_sun_z(iv) = gs_mol/cf  ! mol/m^2/s to m/s
          ci_sun_z(iv) = ci
          An_sun_z(iv) = An
          Ag_sun_z(iv) = Ag
      else
          gs_sun_z(iv) = g0/cf
          ci_sun_z(iv) = 0.

          lmr25 = 0.015*vcmax25  ! Leaf maintenance respiration
          lmr = lmr25 * ft(tc_sun_z(iv), 46390.) * fth(tc_sun_z(iv), 150650., 490.)
          An_sun_z(iv) = - lmr
          Ag_sun_z(iv) = 0.
      endif

      if (par_sha_z(iv) > 0.) then

          call find_ci( ci, gs_mol, An, Ag, &
                        forc_pbot, cair, eair, esat_sha_tv, tc_sha_z(iv), par_sha_z(iv), &
                        gb_mol, g0, m, vcmax25, opt )

          gs_sha_z(iv) = gs_mol/cf  ! mol/m^2/s to m/s
          ci_sha_z(iv) = ci
          An_sha_z(iv) = An
          Ag_sha_z(iv) = Ag
      else
          gs_sha_z(iv) = g0/cf  ! mol/m^2/s to m/s
          ci_sha_z(iv) = 0.

          lmr25 = 0.015*vcmax25  ! Leaf maintenance respiration
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

!==============================================================

  subroutine find_ci( ci, gs_mol, An, Ag, &
                      forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25, opt )

  implicit none

  integer, intent(in) :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn
  real, intent(in) :: forc_pbot, cair, eair, esat_tv  ! Pa
  real, intent(in) :: tc   ! K
  real, intent(in) :: par   ! W/m^2
  real, intent(in) :: gb_mol  ! aerodynamic conductance, mol/m^2/s
  real, intent(in) :: g0  ! min stomatal conductance, mol/m^2/s
  real, intent(in) :: m   ! gs slope
  real, intent(in) :: vcmax25   ! leaf layer: maximum rate of carboxylation (umol CO2/m**2/s)
   
  real, intent(out) :: ci     ! intracellular leaf CO2 (Pa)
  real, intent(out) :: gs_mol ! leaf conductance, mol/m^2/s
  real, intent(out) :: An, Ag     ! umol/m^2/s

  !---- local ----
  real :: eps, eps1
  real :: x1, f0, f1, x ,dx, tol, minx, minf, x0 
  integer :: iter
  integer, parameter :: ITMAX = 20            !maximum number of iterations

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

 !first use the secant approach, then use the brent approach as a backup
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

      !if a root zone is found, use the brent method for a robust backup strategy
      if(f1 * f0 < 0.)then
          call ci_brent( x, x0, x1, f0, f1, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv,&
                         tc, par, gb_mol, g0, m, vcmax25, opt )
          x0 = x
          exit
      endif

      if(iter>itmax)then
          !in case of failing to converge within itmax iterations
          !stop at the minimum function
          !this happens because of some other issues besides the stomatal conductance calculation
          !and it happens usually in very dry places and more likely with c4 plants.
          call ci_func_new( f1, minx, An, Ag, gs_mol, forc_pbot, cair, eair, esat_tv, &
                            tc, par, gb_mol, g0, m, vcmax25, opt )
          x0 = minx
          exit
      endif
  enddo
  ci = x0

  end subroutine find_ci

!==============================================================

  subroutine ci_func_new( fval, ci, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                          tc, par, gb_mol, g0, m, vcmax25, opt )

  implicit none

  real, intent(in) :: ci, forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25
  integer, intent(in) :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn
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
  cs1 = cs/forc_pbot*1.e6  ! pa to umol/mol
  cp1 = cp/forc_pbot*1.e6  ! pa to umol/mol

  call gs_brent(gs, g0, m, gb_mol, An, cs1, eair, esat_tv, cp1, opt)
  
  !-------  Ball-Berry --------
  !aquad = cs
  !bquad = cs*(gb_mol - g0) - m*An*forc_pbot/1.e6
  !cquad = -gb_mol*(cs*g0 + m*an*forc_pbot*eair/esat_tv/1.e6)
  !call quadratic (aquad, bquad, cquad, r1, r2)
  !gs = max(r1,r2)
  !write(*,*) 'gg', gs_mol
  !--------------------------

  fval = (cair - (1.4/gb_mol + 1.6/gs)*An*forc_pbot/1.e6 - ci)/cair

  end subroutine ci_func_new

!==============================================================

  subroutine ci_brent( ci, x1, x2, f1, f2, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                       tc, par, gb_mol, g0, m, vcmax25, opt )
  implicit none

  real, intent(in) :: forc_pbot, cair, eair, esat_tv, tc, par, gb_mol, g0, m, vcmax25
  integer, intent(in) :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn
  real, intent(out) :: ci, gs, An, Ag

  ! --- local ---
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            !maximum number of iterations
  real, parameter :: EPS = 1.e-3       !relative error tolerance

  ! initial guess

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
          c = a   !Rename a, b, c and adjust bounding interval d.
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
      tol1 = 2.*EPS*abs(b)  !Convergence check.
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          ci = b
          call ci_func_new( fval, b, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                            tc, par, gb_mol, g0, m, vcmax25, opt )
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa !Attempt inverse quadratic interpolation.
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q !Check whether in bounds.
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d !Accept interpolation.
              d = p/q
          else
              d = xm  !Interpolation failed, use bisection.
              e = d
          endif
      else !Bounds decreasing too slowly, use bisection.
          d = xm
          e = d
      endif

      a = b !Move last best guess to a.
      fa = fb
      if(abs(d) > tol1) then !Evaluate new trial root.
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call ci_func_new( fb, b, An, Ag, gs, forc_pbot, cair, eair, esat_tv,&
                        tc, par, gb_mol, g0, m, vcmax25, opt )

      if( fb == 0.) exit
  enddo

!  if(iter == ITMAX) write(*,*) 'brent exceeding maximum iterations', b, fb

  ci = b
  fval = fb
  return

  end subroutine ci_brent

!==============================================================

  subroutine gs_brent(gs, g0, m, gb, An, cs, eair, esat_tv, cp, opt)

  implicit none

  real, intent(in) :: g0, m, gb, An, cs, eair, esat_tv, cp
  integer, intent(in) :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn
  real, intent(out) :: gs

  ! --- local ---
  real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm, fval, x1, x2, f1, f2
  integer :: iter
  integer, parameter :: ITMAX = 20            !maximum number of iterations
  real, parameter :: EPS = 1.e-6       !relative error tolerance

  ! initial guess
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
          c = a   !Rename a, b, c and adjust bounding interval d.
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
      tol1 = 2.*EPS*abs(b)  !Convergence check.
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          gs = b
          call gs_func(fval, b, g0, m, gb, An, cs, eair, esat_tv, cp, opt)
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa !Attempt inverse quadratic interpolation.
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q !Check whether in bounds.
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d !Accept interpolation.
              d = p/q
          else
              d = xm  !Interpolation failed, use bisection.
              e = d
          endif
      else !Bounds decreasing too slowly, use bisection.
          d = xm
          e = d
      endif

      a = b !Move last best guess to a.
      fa = fb
      if(abs(d) > tol1) then !Evaluate new trial root.
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call gs_func(fb, b, g0, m, gb, An, cs, eair, esat_tv, cp, opt)

      if( fb == 0.) exit
  enddo

!  if(iter == ITMAX) write(*,*) 'brent exceeding maximum iterations', b, fb

  gs = b
  fval = fb
  return

  end subroutine gs_brent

!==============================================================

  subroutine gs_func(fval, gs, g0, m, gb, An, cs, eair, esat_tv, cp, opt)
  implicit none
  real, intent(in) :: gs, g0, gb, An, cs, eair, esat_tv, cp
  integer, intent(in) :: opt ! 1 = BB, 2 = Leuning, 3 = Medlyn
  real, intent(out) :: fval

  ! cs, cp [umol/mol]  An [umol/m^2/s]  gs, g0 [mol/m^2/s]

  real :: m  ! slope
  real :: es, hs, Ds, D0

  es = (esat_tv*gs + eair*gb)/(gs+gb)
  hs = es/esat_tv  ! leaf rh
  Ds = max( (esat_tv - es)*1.e-3, 0.01 )  ! leaf vapor deficit kpa
  !Ds = max( (es - eair)*1.e-3, 0.01 )  ! leaf vapor deficit kpa
  !Ds = max( (esat_tv - eair)*1.e-3, 0.01 )  ! vapor deficit kpa

  if (opt == 1) then   ! Ball-Berry (1987)
      !m = 9.
      fval = gs - g0 - m*An*hs/cs
  endif

  if (opt == 2) then   ! Leuning et al. 1995
      !m = 6.
      D0 = 1.5  ! kPa
      fval = gs - g0 - m*An/(cs-cp)/(1.+Ds/D0)
  endif

  if (opt == 3) then   ! Medlyn et al. 2011
      !m = 1.5
      fval = gs - g0 - 1.6*(1 + m/sqrt(Ds))*An/cs
  endif

  end subroutine gs_func

!==============================================================

  subroutine Farquhar(an, ag, ci, cp, forc_pbot, tc, par, vcmax25)

  use clm_varpar_my  , only : rgas, sc_p

  implicit none

  real, intent(in) :: ci, forc_pbot, tc, par, vcmax25
  real, intent(out) :: an, ag
  !real, intent(out) :: cp ! used in Leuning model

  real :: jmax25     ! leaf layer: maximum electron transport rate at 25C (umol electrons/m**2/s)
  real :: tpu25      ! leaf layer: triose phosphate utilization rate at 25C (umol CO2/m**2/s)
  real :: lmr25      ! leaf layer: leaf maintenance respiration rate at 25C (umol CO2/m**2/s)
  real :: cp25       ! CO2 compensation point at 25C (Pa)
  real :: kp25       ! leaf layer: Initial slope of CO2 response curve (C4 plants) at 25C
  real :: kc25       ! Michaelis-Menten constant for CO2 at 25C (Pa)
  real :: ko25       ! Michaelis-Menten constant for O2 at 25C (Pa)

  real :: oair, cp, kc, ko  ! Pa
  real :: vcmax, jmax, tpu, lmr  ! umal/m**2/s
  real :: PAR_mol, eff_PAR, je
  real :: alphaj  ! ! initial slope of quantum response curve
  real :: ac, aj, ap, ai, ci1

  ! ---- temp func ----
  real :: ft         ! photosynthesis temperature response (statement function)
  real :: fth        ! photosynthesis temperature inhibition (statement function)
  real :: ha         ! activation energy in photosynthesis temperature function (J/mol)
  real :: hd         ! deactivation energy in photosynthesis temperature function (J/mol)
  real :: se         ! entropy term in photosynthesis temperature function (J/mol/K)

  ft(tc, ha) = exp( ha / (rgas*1.e-3*298.15) * (1. - 298.15/tc) )

  fth(tc, hd, se) = ( 1. + exp((se*298.15 - hd)/(rgas*1.e-3*298.15)) ) / &
                      ( 1. + exp((se*tc - hd)/(rgas*1.e-3*tc)) ) ! Eq. 8.11
  !----------

  jmax25 = 1.97*vcmax25
  tpu25  = 0.167*vcmax25
  lmr25  = 0.015*vcmax25

  oair = 0.21 * forc_pbot  ! Pa

  cp25 = (42.75 * 1.e-6) * forc_pbot    ! Pa, CO2 compensation point
  kc25 = (404.9 * 1.e-6) * forc_pbot    ! Pa
  ko25 = (278.4 * 1.e-3) * forc_pbot    ! Pa

  ! adjust with temperature
  cp = cp25*ft(tc, 37830.)
  kc = kc25*ft(tc, 79430.)
  ko = ko25*ft(tc, 36380.)

  ! Note, this values can change with 10-day mean temprature, see CLM4.5 Tech 8.15
  vcmax = vcmax25 * ft(tc, 65330.) * fth(tc, 149250., 485.)
  jmax = jmax25 * ft(tc, 43540.) * fth(tc, 152040., 495.) 
  tpu = tpu25 * ft(tc, 65330.) * fth(tc, 149250., 485.)
  lmr = lmr25 * ft(tc, 46390.) * fth(tc, 150650., 490.)

  ! --- je ---
  PAR_mol = 4.6*PAR    ! PAR W/m^2 -> 4.6*PAR umol/J
  alphaj = 0.48  != 0.5*0.85,  NOTICE, this vaule can be modified!!! Yulong
  !alphaj = 0.425  != 0.5*0.85,  NOTICE, this vaule can be modified!!! Yulong
  !alphaj = 0.385  !! NOTICE, this vaule can be modified!!! Yulong
  eff_PAR = alphaj * PAR_mol  

  !theta_psii = 0.7   ! curvature parameter
  je =  ( eff_PAR + jmax - sqrt( (eff_PAR + jmax)**2 - 4.*eff_PAR*jmax*0.7 ) )/(2.*0.7)
  ! ---------
  
  ac = vcmax * max(ci-cp, 0.) / (ci + kc*(1.+oair/ko)) ! Rubisco-limited photosynthesis
  aj = 0.25*je * max(ci-cp, 0.) / (ci+2.*cp)           ! RuBP-limited photosynthesis
  ap = 3.*tpu  

  ai = (ac + aj - sqrt( (ac + aj)**2 - 4.*ac*aj*0.98 ) )/(2.*0.98)
  ag = (ai + ap - sqrt( (ai + ap)**2 - 4.*ai*ap*0.95 ) )/(2.*0.95)
 
  ag = max(0., ag)
  an = ag - lmr
  
  end subroutine Farquhar

!==============================================================

  subroutine hybrid( x0, gs_mol, an, ac, aj, ap,                               &
                     vcmax_z, cp, kc, ko, jmax_z, par_z, tpu_z, kp_z,          &
                     lmr_z, cair, oair, eair, esat_tv, forc_pbot,              &
                     gb_mol, mbb, bbb, btran, c3flag )

!! DESCRIPTION:
! use a hybrid solver to find the root of equation
! f(x) = x- h(x),
! we want to find x, s.t. f(x) = 0.
! the hybrid approach combines the strength of the newton secant approach 
! (find the solution domain) and the bisection approach implemented with 
! the Brent's method to guarrantee convergence.

! REVISION HISTORY:
! Dec 14/2012: created by Jinyun Tang

  implicit none
  real, intent(inout) :: x0      ! ci, intracellular leaf CO2 (Pa)
  real, intent(out) :: gs_mol    ! leaf stomatal conductance (umol H2O/m**2/s)
  real, intent(out) :: an        ! net leaf photosynthesis (umol CO2/m**2/s)

  real, intent(in) :: jmax_z     ! maximum electron transport rate (umol electrons/m**2/s)
  real, intent(in) :: lmr_z      ! leaf maintenance respiration rate (umol CO2/m**2/s)
  real, intent(in) :: par_z      ! par absorbed per unit lai for canopy layer (w/m**2)
  real, intent(in) :: gb_mol     ! leaf boundary layer conductance (umol H2O/m**2/s)
  real, intent(in) :: cair       ! Atmospheric CO2 partial pressure (Pa)
  real, intent(in) :: oair       ! Atmospheric O2 partial pressure (Pa)
  real, intent(in) :: eair       ! air vapor pressure at t_veg (Pa)
  real, intent(in) :: esat_tv    ! saturation vapor pressure at t_veg (Pa)
  logical, intent(in) :: c3flag  ! true if C3 and false if C4
  real, intent(in)  :: vcmax_z   ! maximum rate of carboxylation (umol co2/m**2/s)
  real, intent(in)  :: cp        ! CO2 compensation point (Pa)
  real, intent(in)  :: kc        ! Michaelis-Menten constant for CO2 (Pa)
  real, intent(in)  :: ko        ! Michaelis-Menten constant for O2 (Pa)
  real, intent(in)  :: tpu_z     ! triose phosphate utilization rate (umol CO2/m**2/s)
  real, intent(in)  :: kp_z      ! initial slope of CO2 response curve (C4 plants)
  real, intent(in)  :: forc_pbot ! atmospheric pressure (Pa)
  real, intent(in)  :: bbb       ! Ball-Berry minimum leaf conductance (umol H2O/m**2/s)
  real, intent(in)  :: mbb        ! Ball-Berry slope of conductance-photosynthesis relationship
  real, intent(in) :: btran           ! transpiration wetness factor (0 to 1)

  real :: ac   ! Rubisco-limited gross photosynthesis (umol CO2/m**2/s)
  real :: aj   ! RuBP-limited gross photosynthesis (umol CO2/m**2/s)
  real :: ap   ! product-limited (C3) or CO2-limited (C4) gross photosynthes is (umol CO2/m**2/s)

  real :: je          ! electron transport rate (umol electrons/m**2/s)
  real :: fnps        ! fraction of light absorbed by non-photosynthetic pigments
  real :: theta_psii  ! empirical curvature parameter for electron transport rate

  !local variables
  real :: x1, f0, f1, x ,dx, tol, minx, minf
  real, parameter :: eps = 1.e-2      ! relative accuracy
  real, parameter :: eps1= 1.e-4
  integer,  parameter :: itmax = 20   ! maximum number of iterations
  integer :: iter
  real :: qabs, aquad, bquad, cquad  ! terms for quadratic equations
  real :: r1, r2               ! roots of quadratic equation

  ! Electron transport rate je for C3 plants. (umol electrons/m**2/s)
  ! Convert par from W/m2 to umol photons/m**2/s using the factor 4.6
  if (c3flag) then
      !fnps = 0.15
      fnps = 0.85
      theta_psii = 0.7 

      aquad = theta_psii
      qabs  = 0.5 * (1. - fnps) * (par_z * 4.6) ! par absorbed per unit lai
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

 !first use the secant approach, then use the brent approach as a backup
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

      !if a root zone is found, use the brent method for a robust backup strategy
      if(f1 * f0 < 0.)then
          call brent( x, x0, x1, f0, f1, tol, gs_mol, an, ac, aj, ap, &
                      lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                      c3flag, vcmax_z, cp, kc, ko, tpu_z, kp_z, mbb, bbb, btran )
          x0 = x
          exit
      endif

      if(iter>itmax)then
          !in case of failing to converge within itmax iterations
          !stop at the minimum function
          !this happens because of some other issues besides the stomatal conductance calculation
          !and it happens usually in very dry places and more likely with c4 plants.
          call ci_func ( minx, f1, gs_mol, an, ac, aj, ap, &
                         lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                         c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
          x0 = minx
          exit
      endif
  enddo

  end subroutine hybrid

!==============================================================

  subroutine ci_func ( ci, fval, gs_mol, an, ac, aj, ap, &
                       lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                       c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )

  !! DESCRIPTION:
  ! evaluate the function
  ! f(ci)=ci - (ca - (1.4rb+1.6rs))*patm*an

  ! !REVISION HISTORY:
  ! Dec 14, 2012: Created by Jinyun Tang
  
  implicit none
  real, intent(in) :: ci                ! intracellular leaf CO2 (Pa)
  real, intent(out) :: fval              !return function of the value f(ci)
  real, intent(out) :: gs_mol           ! leaf stomatal conductance (umol H2O/m**2/s)
  real, intent(out) :: an               ! net leaf photosynthesis (umol CO2/m**2/s)

  real, intent(in) :: lmr_z  ! leaf maintenance respiration rate (umol CO2/m**2/s)
  real, intent(in) :: par_z  ! par absorbed per unit lai for canopy layer (w/m**2)
  real, intent(in) :: gb_mol ! leaf boundary layer conductance (umol H2O/m**2/s)
  real, intent(in) :: cair   ! Atmospheric CO2 partial pressure (Pa)
  real, intent(in) :: oair   ! Atmospheric O2 partial pressure (Pa)
  real, intent(in) :: eair       ! air vapor pressure at t_veg (Pa)
  real, intent(in) :: esat_tv    ! saturation vapor pressure at t_veg (Pa)

  logical, intent(in) :: c3flag  ! true if C3 and false if C4
  real, intent(in)  :: vcmax_z   ! maximum rate of carboxylation (umol co2/m**2/s)
  real, intent(in)  :: cp        ! CO2 compensation point (Pa)
  real, intent(in)  :: kc        ! Michaelis-Menten constant for CO2 (Pa)
  real, intent(in)  :: ko        ! Michaelis-Menten constant for O2 (Pa)
  real, intent(in)  :: tpu_z     ! triose phosphate utilization rate (umol CO2/m**2/s)
  real, intent(in)  :: kp_z      ! initial slope of CO2 response curve (C4 plants)
  real, intent(in)  :: forc_pbot ! atmospheric pressure (Pa)
  real, intent(in)  :: bbb       ! Ball-Berry minimum leaf conductance (umol H2O/m**2/s)
  real, intent(in)  :: mbb        ! Ball-Berry slope of conductance-photosynthesis relationship
  real, intent(in)  :: btran           ! transpiration wetness factor (0 to 1)
  real, intent(in)  :: je        ! electron transport rate (umol electrons/m**2/s)

  real :: qe         ! quantum efficiency, used only for C4 (mol CO2 / mol photons)
  real :: theta_ip   ! empirical curvature parameter for ap photosynthesis co-limitation
  real :: theta_cj   ! empirical curvature parameter for ac, aj photosynthesis co-limitation

  ! local variables
  real :: ac   ! Rubisco-limited gross photosynthesis (umol CO2/m**2/s)
  real :: aj   ! RuBP-limited gross photosynthesis (umol CO2/m**2/s)
  real :: ap   ! product-limited (C3) or CO2-limited (C4) gross photosynthes is (umol CO2/m**2/s)
  real :: ag   ! co-limited gross leaf photosynthesis (umol CO2/m**2/s)
  real :: ai   ! intermediate co-limited photosynthesis (umol CO2/m**2/s)

  real :: cs   ! CO2 partial pressure at leaf surface (Pa)
  real :: aquad, bquad, cquad  ! terms for quadratic equations
  real :: r1, r2               ! roots of quadratic equation
  real :: vcmax, lmr, b  ! adujust with water stress
  real :: fb, Ds

  real :: sbtran

  ! Miscellaneous parameters, from Bonan et al (2011) JGR, 116, doi:10.1029/2010JG001593

  vcmax = vcmax_z! * (btran+0.01)
  lmr   = lmr_z * btran
  !b = max(bbb*btran, 1.)
  b = bbb

  if (c3flag) then
      ac = vcmax * max(ci-cp, 0.) / (ci+kc*(1.+oair/ko)) ! Rubisco-limited photosynthesis

      !aj = je * max(ci-cp, 0.) / (4.*ci+8.*cp)             ! RuBP-limited photosynthesis
      aj = 0.25*je * max(ci-cp, 0.) / (ci+2.*cp)             ! RuBP-limited photosynthesis

      ap = 3. * tpu_z       ! Product-limited photosynthesis

      theta_cj = 0.98       ! empirical curvature parameter for ac, aj photosynth co-limit

      theta_ip = 0.95       ! empirical curvature parameter for ap photosynth co-limit
 
  else
      ac = vcmax          ! Rubisco-limited photosynthesis

      qe = 0.05             ! quantum efficiency, used only for C4 
      aj = qe * par_z * 4.6 ! RuBP-limited photosynthesis

      ap = kp_z * max(ci, 0.) / forc_pbot ! C4: PEP carboxylase-limited (CO2-limited)

      theta_cj = 0.80       ! empirical curvature parameter for ac, aj photosynth co-limit

      theta_ip = 0.95       ! empirical curvature parameter for ap photosynth co-limit
  end if

  ! Gross photosynthesis. First co-limit ac and aj. Then co-limit ap

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

  ! Net photosynthesis. Exit iteration if an < 0

  an = ag - lmr

  if (an <= 0.) then
      fval = 0.
      gs_mol = b
      return
  endif

  ! Quadratic gs_mol calculation with an known. Valid for an >= 0.
  ! With an <= 0, then gs_mol = bbb

  cs = cair - 1.4/gb_mol * an * forc_pbot
  cs = max(cs,1.e-06)

  !-------  Ball-Berry --------
  aquad = cs
  bquad = cs*(gb_mol - b) - mbb*an*forc_pbot
  cquad = -gb_mol*(cs*b + mbb*an*forc_pbot*eair/esat_tv)
  call quadratic (aquad, bquad, cquad, r1, r2)
  gs_mol = max(r1,r2)
  !write(*,*) 'gg', gs_mol
  !--------------------------

  !--------------------------
! Ds = max(0.01, (esat_tv - eair)*1.e-3)
! gs_mol = 0.01 + 1.0*(1. + 9.3*btran/sqrt(Ds))*an/(10.*cs)
!  !gs_mol = 0.01 + 1.0*(1. + 4.3/sqrt(Ds))*an/(10.*cs)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 1.0*(1. + 9.3*btran/sqrt(Ds))*an/(10.*cs)
  !gs_mol = 0.01 + 1.0*(1. + 4.3/sqrt(Ds))*an/(10.*cs)
!write(*,*) 1.0*(1. + 9.3/sqrt(Ds))*an/(10.*cs)

!  !Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  !Ds = max(0.01, Ds)
!  !gs_mol = 0.02 + 1.6*(1. + 4.1*btran/sqrt(Ds))*an/(cs*1.e-3)
!
!  !write(*,*) 'aa', gb_mol , gs_mol*1.e6, gb_mol/(gb_mol + gs_mol*1.e6)
!  !--------------------------
!
  !-------------------------- Leuning model --------------
!  sbtran = 5.
!  Ds = max(0.01, (esat_tv - eair)*1.e-3)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 + 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!
!  Ds = (esat_tv - eair)*gb_mol/(gb_mol + gs_mol*1.e6)*1.e-3
!  Ds = max(0.01, Ds)
!  gs_mol = 0.01 !+ 16.4*an/(cs/forc_pbot*1.e6 - cp/forc_pbot*1.e6)/(1. + Ds/0.35)*(btran*sbtran)
!!  !--------------------------
!!
!  gs_mol = gs_mol*1.e6
!
  ! Derive new estimate for ci

  fval = ci - cair + an * forc_pbot * (1.4*gs_mol+1.6*gb_mol) / (gb_mol*gs_mol)

  end subroutine ci_func

!==============================================================
!==============================================================

  subroutine brent( x, x1, x2, f1, f2, tol, gs_mol, an, ac, aj, ap, &
                    lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                    c3flag, vcmax_z, cp, kc, ko, tpu_z, kp_z, mbb, bbb, btran )
!!DESCRIPTION:
!Use Brent's method to find the root of a single variable function ci_func, which is known to exist between x1 and x2.
!The found root will be updated until its accuracy is tol.

  implicit none
  real, intent(out) :: x    !indepedent variable of the single value function ci_func(x)
  real, intent(out) :: an   ! net leaf photosynthesis (umol CO2/m**2/s)
  real :: x1, x2, f1, f2    !minimum and maximum of the variable domain to search for the solution ci_func(x1) = f1, ci_func(x2)=f2
  real, intent(out) :: gs_mol           ! leaf stomatal conductance (umol H2O/m**2/s)
  real :: tol               !the error tolerance
  real, intent(in)  :: mbb        ! Ball-Berry slope of conductance-photosynthesis relationship
  real, intent(in) :: btran           ! transpiration wetness factor (0 to 1)

  ! -- used in ci_func
  real :: lmr_z             ! canopy layer: leaf maintenance respiration rate (umol CO2/m    **2/s)
  real :: par_z             ! par absorbed per unit lai for canopy layer (w/m**2)
  real :: gb_mol            ! leaf boundary layer conductance (umol H2O/m**2/s)
  real :: je                ! electron transport rate (umol electrons/m**2/s)
  real :: cair              ! Atmospheric CO2 partial pressure (Pa)
  real :: oair              ! Atmospheric O2 partial pressure (Pa)
  real :: eair       ! air vapor pressure at t_veg (Pa)
  real :: esat_tv    ! saturation vapor pressure at t_veg (Pa)
  real :: forc_pbot          ! atmospheric pressure (Pa)

  logical :: c3flag             ! true if C3 and false if C4
  real :: vcmax_z          ! maximum rate of carboxylation (umol co2/m**2/s)
  real :: cp                 ! CO2 compensation point (Pa)
  real :: kc                 ! Michaelis-Menten constant for CO2 (Pa)
  real :: ko                 ! Michaelis-Menten constant for O2 (Pa)
  real :: tpu_z              ! triose phosphate utilization rate (umol CO2/m**2/s)
  real :: kp_z               ! initial slope of CO2 response curve (C4 plants)
  real :: bbb                ! Ball-Berry minimum leaf conductance (umol H2O/m**2/s)

  real :: ac   ! Rubisco-limited gross photosynthesis (umol CO2/m**2/s)
  real :: aj   ! RuBP-limited gross photosynthesis (umol CO2/m**2/s)
  real :: ap   ! product-limited (C3) or CO2-limited (C4) gross photosynthes is (umol CO2/m**2/s)
  !---------- local 
  integer, parameter :: ITMAX=20            !maximum number of iterations
  real, parameter :: EPS=1.e-2       !relative error tolerance

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
          c = a   !Rename a, b, c and adjust bounding interval d.
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
      tol1 = 2.*EPS*abs(b) + 0.5*tol  !Convergence check.
      xm = 0.5*(c-b)
      if(abs(xm) <= tol1 .or. fb == 0.)then
          x=b
          ! cal. an net leaf photosynthesis (umol CO2/m**2/s)
          call ci_func ( b, fb, gs_mol, an, ac, aj, ap, &
                         lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                         c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
          return
      endif

      if(abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
          s = fb/fa !Attempt inverse quadratic interpolation.
          if(a == c) then
              p = 2.*xm*s
              q = 1.-s
          else
              q = fa/fc
              r = fb/fc
              p = s*(2.*xm*q*(q-r)-(b-a)*(r-1.))
              q = (q-1.)*(r-1.)*(s-1.)
          endif
          if(p > 0.) q = -q !Check whether in bounds.
          p = abs(p)
          if(2.*p < min(3.*xm*q-abs(tol1*q),abs(e*q))) then
              e = d !Accept interpolation.
              d = p/q
          else
              d = xm  !Interpolation failed, use bisection.
              e = d
          endif
      else !Bounds decreasing too slowly, use bisection.
          d = xm
          e = d
      endif

      a = b !Move last best guess to a.
      fa = fb
      if(abs(d) > tol1) then !Evaluate new trial root.
          b = b+d
      else
          b = b+sign(tol1,xm)
      endif

      call ci_func ( b, fb, gs_mol, an, ac, aj, ap, &
                     lmr_z, par_z, gb_mol, je, cair, oair, eair, esat_tv, forc_pbot, &
                     c3flag, vcmax_z, cp, kc, ko ,tpu_z, kp_z, mbb, bbb, btran )
      if( fb == 0.) exit
  enddo

!  if(iter == ITMAX) write(*,*) 'brent exceeding maximum iterations', b, fb

  x = b
  return

  end subroutine brent

!==============================================================

  subroutine quadratic (a, b, c, r1, r2)

! !DESCRIPTION:
!==============================================================================!
!----------------- Solve quadratic equation for its two roots -----------------!
!==============================================================================!
! Solution from Press et al (1986) Numerical Recipes: The Art of Scientific
! Computing (Cambridge University Press, Cambridge), pp. 145.
!
! !CALLED FROM:
! subroutine Photosynthesis in this module
!
! !REVISION HISTORY:
! 4/5/10: Adapted from /home/bonan/ecm/psn/An_gs_iterative.f90 by Keith Oleson

   implicit none

! !ARGUMENTS:
   real, intent(in)  :: a,b,c       ! Terms for quadratic equation
   real, intent(out) :: r1,r2       ! Roots of quadratic equation
!
! !LOCAL VARIABLES:
   real :: q                        ! Temporary term for quadratic solution
!------------------------------------------------------------------------------

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

!==============================================================

  subroutine QSat (T, p, es, esdT, qs, qsdT)
!
! !DESCRIPTION:
! Computes saturation mixing ratio and the change in saturation
! mixing ratio with respect to temperature.
! Reference:  Polynomial approximations from:
!             Piotr J. Flatau, et al.,1992:  Polynomial fits to saturation
!             vapor pressure.  Journal of Applied Meteorology, 31, 1507-1513.
!
  implicit none
  integer,parameter :: r8 = selected_real_kind(12)
  real, intent(in)  :: T        ! temperature (K)
  real, intent(in)  :: p        ! surface atmospheric pressure (pa)
  real, intent(out) :: es       ! vapor pressure (pa)
  real, intent(out) :: esdT     ! d(es)/d(T)
  real, intent(out) :: qs       ! humidity (kg/kg)
  real, intent(out) :: qsdT     ! d(qs)/d(T)

  ! !LOCAL VARIABLES:
  !EOP
  !
  real :: T_limit
  real :: td,vp,vp1,vp2
  !
  ! For water vapor (temperature range 0C-100C)
  !
  real, parameter :: a0 =  6.11213476_r8
  real, parameter :: a1 =  0.444007856_r8
  real, parameter :: a2 =  0.143064234e-01_r8
  real, parameter :: a3 =  0.264461437e-03_r8
  real, parameter :: a4 =  0.305903558e-05_r8
  real, parameter :: a5 =  0.196237241e-07_r8
  real, parameter :: a6 =  0.892344772e-10_r8
  real, parameter :: a7 = -0.373208410e-12_r8
  real, parameter :: a8 =  0.209339997e-15_r8
  !
  ! For derivative:water vapor
  !
  real, parameter :: b0 =  0.444017302_r8
  real, parameter :: b1 =  0.286064092e-01_r8
  real, parameter :: b2 =  0.794683137e-03_r8
  real, parameter :: b3 =  0.121211669e-04_r8
  real, parameter :: b4 =  0.103354611e-06_r8
  real, parameter :: b5 =  0.404125005e-09_r8
  real, parameter :: b6 = -0.788037859e-12_r8
  real, parameter :: b7 = -0.114596802e-13_r8
  real, parameter :: b8 =  0.381294516e-16_r8
  !
  ! For ice (temperature range -75C-0C)
  !
  real, parameter :: c0 =  6.11123516_r8
  real, parameter :: c1 =  0.503109514_r8
  real, parameter :: c2 =  0.188369801e-01_r8
  real, parameter :: c3 =  0.420547422e-03_r8
  real, parameter :: c4 =  0.614396778e-05_r8
  real, parameter :: c5 =  0.602780717e-07_r8
  real, parameter :: c6 =  0.387940929e-09_r8
  real, parameter :: c7 =  0.149436277e-11_r8
  real, parameter :: c8 =  0.262655803e-14_r8
  !
  ! For derivative:ice
  !
  real, parameter :: d0 =  0.503277922_r8
  real, parameter :: d1 =  0.377289173e-01_r8
  real, parameter :: d2 =  0.126801703e-02_r8
  real, parameter :: d3 =  0.249468427e-04_r8
  real, parameter :: d4 =  0.313703411e-06_r8
  real, parameter :: d5 =  0.257180651e-08_r8
  real, parameter :: d6 =  0.133268878e-10_r8
  real, parameter :: d7 =  0.394116744e-13_r8
  real, parameter :: d8 =  0.498070196e-16_r8
 !-----------------------------------------------------------------------

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

  es    = es    * 100.            ! pa
  esdT  = esdT  * 100.            ! pa/K

  vp    = 1.0   / (p - 0.378*es)
  vp1   = 0.622 * vp
  vp2   = vp1   * vp

  qs    = es    * vp1             ! kg/kg
  qsdT  = esdT  * vp2 * p         ! 1 / K

  end subroutine QSat

!==============================================================

  subroutine boundary_layer_resistance_rb( rb_z, wind_z, numcan_wrf, ivt )
  
  USE clm_varpar_my, only : dleaf, mxlevcan_wrf, sc_p
  implicit none
  
  integer, intent(in) :: numcan_wrf, ivt
  real, dimension(mxlevcan_wrf), intent(in)  :: wind_z
  real, dimension(mxlevcan_wrf), intent(out) :: rb_z
  real :: dleaf_CHATS, wind

  real :: Cv = 0.01  ! m/s^(-0/5)
  integer :: i
  
  ! CLM4.5_Tech_Note EQ. 5.123

  dleaf_CHATS = 0.05

!  write(*,*) numcan_wrf, mxlevcan_wrf

  DO i = 1, numcan_wrf

     wind = max(wind_z(i), 0.1)
     !rb_z(i) = 1./Cv*sqrt(dleaf(ivt)/wind_z(i))
     rb_z(i) = 1./0.005*sqrt(dleaf_CHATS/wind)
!     write(*,*) i, dleaf_CHATS, wind, rb_z(i)
     !rb_z(i) = 1./sc_p(1)*sqrt(dleaf_CHATS/wind_z(i))
  ENDDO
  
  end subroutine boundary_layer_resistance_rb

!==============================================================

  subroutine Tridiagonal(N, AA, BB, CC, RR, X)

!     THIS SUBROUTINE SOLVES A TRI-DIAGONAL MATRIX OF THE FORM :
!
!              | B1  C1   0   0  .  .   . | |x1|   |r1|
!              | A2  B2  C2   0  .  .   . | |x2|   |r2|
!              |  0  A3  B3  C3  .  .   . | |x3| = |r3|
!              |  .   .   .   .     .   . | | .|   | .|
!              |  0   0   0   0  . BN  CN | |xN|   |rN|
!
!***********************************************************************
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

!==============================================================
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
      !interp_out = dzm*mdl_data(k1) +  dz*mdl_data(k1+1)
      return
  endif

  end subroutine to_zk2_para

! -------------------------------------------------------------

!============================================

  SUBROUTINE one_to_four_stream_sw_1( coszen, swd, &
                                    sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )
  implicit none
  real, intent(in)  :: coszen, swd
  real, intent(out) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir

  real :: fiv, fv, ru, solar_sine_beta, rdvis, rsvis, &
          wa, rdir, rsdir, rvt, rit, rtt
       
  solar_sine_beta = coszen

    fiv = 0.54   ! NIR
    fv = 0.46    ! PAR
    ru = 1./solar_sine_beta

    ! PAR dir
    rdvis = 624.0 * exp(-.185 * ru) * solar_sine_beta

    ! PAR dis
    rsvis = 0.4 * (624. *solar_sine_beta - rdvis)

    wa = 1373.0 * .077 * (2.*ru)**0.3

    ! NIR dir
    rdir = (748.0 * exp(-.06 * ru) - wa) * solar_sine_beta
    rdir = max(rdir, 0.)

    ! NIR dis
    rsdir = 0.6* (748. -rdvis/solar_sine_beta-wa)*solar_sine_beta
    rsdir = max(rsdir, 0.)

    rvt = rdvis + rsvis
    rit = rdir + rsdir
    rit = max(rit, 0.1)
    rvt = max(rvt, 0.1)

    !ratrad = 0.22  # cloud, clean sky
    !xvalue=(0.9-ratrad)/0.70
    !fvsb = rdvis / rvt * (1. - xvalue**0.67)
    !fvsb = min(1., max(fvsb, 0.))
    !fvd = 1. - fvsb

    rtt = rdvis + rsvis + rdir + rsdir
    rdvis = rdvis/rtt
    rsvis = rsvis/rtt
    rdir = rdir/rtt
    rsdir = rsdir/rtt
    !print rdvis , rsvis , rdir,  rsdir

    sw_dir_vis = rdvis*swd
    sw_dif_vis = rsvis*swd
    sw_dir_nir = rdir*swd
    sw_dif_nir = rsdir*swd

  END SUBROUTINE one_to_four_stream_sw_1

!============================================

  SUBROUTINE one_to_four_stream_sw( swd, swd_top, &
                                    sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )
  implicit none
  real, intent(in)  :: swd, swd_top
  real, intent(out) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir

  ! --- local ---
  real :: kt  ! clearness index
  real :: kd  ! diffuse fraction
  real :: kv  ! vis (PAR) fraction
  real :: a, b, c, d

  kt = swd/max(1e-3, swd_top)

  ! Erbs et al. model, Wong and Chow 2001
  if (kt <= 0.22) then
      kd = 1. - 0.09*kt
  else if (kt <= 0.8) then   ! 0.22 < kt <= 0.8
      kd = 0.9511 - 0.1604*kt + 4.388*kt**2 - 16.638*kt**3 + 12.336*kt**4
  else  ! kt > 0.8
      kd = 0.165
  endif

  !if (kt >= 1. .or. kt <= 0.) write(*,*) 'wrong in clearness index!', kt, kd, swd, swd_top
  kd = min(1., max(0., kd))
!  write(*,*)  kt, kd, swd, swd_top

  ! Escobedo et al. 2008, can't work here
!  if (kt <= 0.35) then
!      kv = 0.51
!  else if (kt <= 0.55) then   ! 0.35 < kt <= 0.55
!      kv = 0.495
!  else if (kt <= 0.65) then   ! 0.55 < kt <= 0.65
!      kv = 0.49
!  else  ! kt > 0.65
!      kv = 0.489
!  endif

  d = 0.01
  c = kd - 0.01
  a = 0.4 * (1 - kd)
  b = 0.6 * (1 - kd)

  !a = 0.
  !b = 1.
  !c = 0.
  !d = 0.

  sw_dir_vis = swd * a
  sw_dir_nir = swd * b
  sw_dif_vis = swd * c
  sw_dif_nir = swd * d

  END SUBROUTINE one_to_four_stream_sw

!============================================

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

!---------------
!=======================================
! modified from WRF rrtmg code
  SUBROUTINE radconst(DECLIN,SOLCON,julday)

  IMPLICIT NONE

  INTEGER, INTENT(IN   )      ::       julday
  REAL, INTENT(OUT  )      ::       DECLIN,SOLCON
  REAL :: PI = 3.1415926535897932384626433
  REAL :: DPD = 360./365.
  REAL :: SXLONG, ARG, OBECL, SINOB, RJUL, ECCFAC, degrad

  degrad = PI/180.

  !DECLIN = 23.45*SIN(360.*(284+julday)/365.*2.*pi/360.)
  !DECLIN = -23.45*COS(360.*(julday+10)/365.*2.*pi/360.)
  !DECLIN = -declin * 2.*pi/360.

 !-----OBECL : OBLIQUITY = 23.5 DEGREE.

  OBECL = 23.45*DEGRAD
  SINOB = SIN(OBECL)

  ! sunmmer positive
  IF(JULDAY.GE.80.)SXLONG=DPD*(JULDAY-80.)
  IF(JULDAY.LT.80.)SXLONG=DPD*(JULDAY+285.)

  SXLONG=SXLONG*DEGRAD
  ARG=SINOB*SIN(SXLONG)
  DECLIN=-ASIN(ARG)

!----SOLAR CONSTANT ECCENTRICITY FACTOR (PALTRIDGE AND PLATT 1976)
  RJUL=2.*pi*(julday-1)/365.
  ECCFAC=1.000110+0.034221*COS(RJUL)+0.001280*SIN(RJUL)+0.000719* &
         COS(2*RJUL)+0.000077*SIN(2*RJUL)
  SOLCON=1367.*ECCFAC

  END SUBROUTINE radconst

!------------------------------

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

!------------------------------

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

!-----------
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


! -------------------------------------------------------------

  subroutine save_mcm_var( mcm_var, WRF_var, bl, nw, kms, kme )

  USE clm_varpar_my, only : mxlevcan_wrf
  implicit none
  
  INTEGER, INTENT( IN )  ::  bl, nw, kms, kme
  REAL, DIMENSION(mxlevcan_wrf), INTENT(IN) :: mcm_var
  REAL, DIMENSION(kms:kme), INTENT(INOUT) :: WRF_var

  ! --- local ---
  INTEGER :: k, tl, ir

  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  ! numcan_wrf = tl - bl + 1
      !write(*,*) ir, k
      WRF_var(k) = mcm_var(ir)
      !write(*,*) mcm_var(ir), WRF_var(k)
  ENDDO

  end subroutine save_mcm_var

! -------------------------------------------------------------

  subroutine save_mcm_var_nan( WRF_var, bl, nw, kms, kme )

  USE clm_varpar_my, only : mxlevcan_wrf
  implicit none

  INTEGER, INTENT( IN )  ::  bl, nw, kms, kme
  REAL, DIMENSION(kms:kme), INTENT(INOUT) :: WRF_var

  ! --- local ---
  INTEGER :: k, tl, ir

  tl = nw + bl - 1
  DO k = bl, tl
      ir = nw - k + bl  ! numcan_wrf = tl - bl + 1
      !write(*,*) ir, k
      WRF_var(k) = -999.
      !write(*,*) mcm_var(ir), WRF_var(k)
  ENDDO

  end subroutine save_mcm_var_nan

! -------------------------------------------------------------

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
  REAL, INTENT(IN) :: dt  ! for soil T and Q

  REAL, INTENT(IN) :: sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, lwd, coszen, &
                      Utop_C, qsoil_C, tsoil_C, G_C

  REAL, DIMENSION(kms:kme),INTENT(IN) ::  P, t, qv, rho, wind
  REAL, INTENT(IN) ::  swvisdir, swnirdir, swvisdif, swnirdif, glw
  REAL, DIMENSION(kms:kme),INTENT(INOUT) ::  co2  ! co2 initial here

  TYPE(canopy_lai), INTENT(IN) :: CLAI
  TYPE(mcm_force), INTENT(OUT) :: MF

  ! ------ local ------
  integer :: k, bl, nw, ir

  bl = CLAI%bl
  nw = CLAI%nw

  MF%dt = dt
  MF%t10 = 25. + 273.15
  MF%dayl_factor = 0.9  ! Eq. 8.24
  MF%surf_pre = P(bl)

  DO k = 1, nw
      ir = nw - k + bl  ! numcan_wrf = tl - bl + 1
      MF%tair(k) = t(ir)
      MF%qair(k) = qv(ir)
      MF%rho(k)  = rho(ir)
      MF%co2(k)  = CO2(ir) ! ppmv
      MF%wind(k) = wind(ir)
! TWJ debug
!      print *, k, ir, t(ir), qv(ir), rho(ir), CO2(ir), wind(ir)
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

! TWJ debug
  !print *, sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C
  !print *, swvisdir, swnirdir, swvisdif, swnirdif, glw, coszen, Utop_C, qsoil_C, tsoil_C, G_C

  end subroutine set_mcm_force

! -------------------------------------------------------------

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

  ! --- local ---
  integer :: i, j, k, bl, tl, nw, ir, iv
  real :: cht, cdz_top, tlai1, tlai2, tsh, SC, rdz
  real :: co2_tend_tmp(kms:kme), co2_tend_re(kms:kme)

  co2_tend = 0.

  if (itimestep >= 5*60*50) then
      DO j = jts, min(jte,jde-1)
      DO i = its, min(ite,ide-1)
          !if (i > 300) co2_tend(i,1,j) = 1.*mut(i,j)
          co2_tend(i,1,j) = 1.
      ENDDO
      ENDDO
  endif

  return
  !co2(:,1,:) = 200.

  SC = 1.  ! total source released at the canopy top
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

          !--  normalize --
          tsh = 0.
          do iv = 1, nw
              tsh = tsh + co2_tend_tmp(iv)
          enddo

          do k = 1, nw
              co2_tend_re(k) = co2_tend_tmp(k) * SC/tsh
          enddo
          !--  normalize --

          DO k = bl, tl
              rdz = 1./(zw(i,k+1,j) - zw(i,k,j))
              iv = nw - k + bl
              co2_tend(i,k,j) = co2_tend_re(iv)*rdz
          ENDDO
      ENDDO
      ENDDO
  endif

  end subroutine simple_scalar_source_NOIBM

! -------------------------------------------------------------
! -------------------------------------------------------------

! -------------------------------------------------------------
! -------------------------------------------------------------
  subroutine flux_to_tendency( qv_tend, t_tend, co2_tend, &
                               q_source, co2_source, &
                               qv_mcm, sh_mcm, an_mcm, CLAI,       & 
                               zw, qv, rho_phy, t_phy, p_phy, dnw, mu, &
                               !cd_pan, & ! test
                               mcm_tau13_t, mcm_tau13_q, mcm_tau13_c, &
                               kms, kme )
                       
 
  USE clm_varpar_my, only : rgas, mxlevcan_wrf, cpair
  USE mcm_data_mod, only : canopy_lai
  implicit none
  
  INTEGER, INTENT( IN )  ::  kms, kme

  TYPE(canopy_lai), INTENT(IN) :: CLAI
  real, intent(in) :: qv_mcm(mxlevcan_wrf)  ! kg/m^2/s, positive to air
  real, intent(in) :: sh_mcm(mxlevcan_wrf)  ! W/m^2, positvie to air
  real, intent(in) :: an_mcm(mxlevcan_wrf)  ! (umol CO2/m**2/s)
  real, dimension(kms:kme), intent(in) :: zw, qv, rho_phy, t_phy, p_phy
  real, dimension(kms:kme), intent(in) :: dnw
  real :: mu

  real, dimension(kms:kme), intent(out) :: qv_tend 
  real, dimension(kms:kme), intent(out) :: t_tend 
  real, dimension(kms:kme), intent(out) :: co2_tend  !, cd_pan
  real, intent(out) :: mcm_tau13_t, mcm_tau13_q, mcm_tau13_c

  real, dimension(kms:kme), intent(out) :: q_source
  real, dimension(kms:kme), intent(out) :: co2_source

  ! --- local ---
  real :: sh_mcm_flux(mxlevcan_wrf)  ! K m/s
  integer :: k, bl, tl, nw, ir
  real, parameter :: g = 9.81
  real, parameter :: hvap   = 2.501e6   ! Latent heat of evap for water [J/kg]
  real :: cpm_eff, rdz, sh_sum, Qtop, sh_grass, sum_an, le_grass, an_grass

  qv_tend = 0.
  t_tend = 0.
  co2_tend = 0.

  q_source = 0.
  co2_source = 0.

  bl = CLAI%bl
  nw = CLAI%nw
  tl = nw + bl - 1

  ! mut/dz = -rho*g/dnw

  ! positive from leaf to air
  ! qv_mcm: kg/m^2/s = W/m^2/hvap
  ! sh_mcm: W/m^2
  ! an_mcm: umol /m^2/s

  if (nw == 0) then
      rdz = 1./(zw(2) - zw(1))

      !le_grass = 50.  ! W/m^2 = J/s/m^2
      le_grass = 50./hvap  ! W/m^2 -> Kg/m^2/s
      ! kg/m^2/s -> kg/kg/s
      !qv_tend(1) = qv_mcm(1)*(-g/dnw(1))
      qv_tend(1) = le_grass*(-g/dnw(1))
      q_source(1) = le_grass*rdz  ! kg/m^3/s

      !sh_grass = 450.  ! 250 W/m^2
      !cpm_eff = cpair  ! [J/kg/K]
      !sh_mcm_flux(1) = sh_mcm(1)/cpm_eff/rho_phy(1)  ! W/m^2 -> Km/s
      !sh_mcm_flux(1) = sh_mcm(1)  ! For grass, the unit is Km/s
      !sh_mcm_flux(1) = 0.2  ! For grass, the unit is Km/s
      !t_tend(1) = sh_mcm_flux(1)*(-rho_phy(1)*g/dnw(1))
      !t_tend(1) = 0.

      ! umol CO2/m^2/s -> ppmv/s
      !an_grass = 5.
      !co2_tend(1) = an_mcm(1)*rdz*8.314*t_phy(1)/p_phy(1)
      co2_tend(1) = 5.5*rdz*8.314*t_phy(1)/p_phy(1)
      co2_source(1) = 5.5*rdz  !umol/m^3/s
      return
  endif

  ! W/m^2/ -> Km/s
  sh_sum = 0.
  DO k = 1, nw
      ir = nw - k + bl  ! nw = tl - bl + 1

      !cpm_eff = 1.00464e3 * (1. + 0.8 *qv(ir)) ! air
      cpm_eff = cpair
      sh_mcm_flux(k) = sh_mcm(k)/cpm_eff/rho_phy(ir)  ! W/m^2 -> Km/s
      sh_sum = sh_sum + sh_mcm_flux(k)
  ENDDO


  !--------  only for testing -----------
  !Qtop = 0.14
  !do k = 1, nw
  !    sh_mcm_flux(k) = sh_mcm_flux(k) * Qtop/sh_sum
  !enddo
  !--------------------------------------

  sum_an = 0.
  DO k = bl, tl
      rdz = 1./(zw(k+1) - zw(k))

      ir = nw - k + bl  ! nw = tl - bl + 1

      ! kg/m^2/s -> kg/kg/s
      !qv_tend(k) = qv_mcm(ir)*rdz/rho_phy(k)*mut  !old
      qv_tend(k) = -qv_mcm(ir)*g/dnw(k)
      q_source(k) = qv_mcm(ir)*rdz  ! kg/m^3/s
      q_source(k) = q_source(k)*mu

      ! W/m^2 -> K/s ! specific heat of air [J/kg/K]
      !cpm_eff = 1.00464e3 * (1. + 0.8 *qv(k)) ! air

      !t_tend(k) = sh_mcm(ir)/rho_phy(k)*rdz/cpm_eff*mut  ! old
      !t_tend(k) = -sh_mcm(ir)/cpm_eff*g/dnw(k)

      t_tend(k) = -sh_mcm_flux(ir)*rho_phy(k)*g/dnw(k)
      t_tend(k) = t_tend(k)*mu

      !t_tend(1) = -2.8*rho_phy(1)*g/dnw(1)  ! test, yulong

      ! umol CO2/m^2/s -> ppmv/s
      co2_tend(k) = an_mcm(ir)*rdz*8.314*t_phy(k)/p_phy(k)
      co2_source(k) = an_mcm(ir)*rdz  !umol/m^3/s
      co2_source(k) = co2_source(k)*mu

      !sum_an = sum_an + an_mcm(ir)
  ENDDO

  mcm_tau13_t = sh_mcm(nw)/(1.00464e3 * (1. + 0.8 *qv(nw)))/rho_phy(nw)
  mcm_tau13_q = qv_mcm(nw)/rho_phy(nw)
  mcm_tau13_c = an_mcm(nw)*8.314*t_phy(nw)/p_phy(nw) 

  end subroutine flux_to_tendency

! -------------------------------------------------------------

  subroutine set_mcm_force_from_chats( dt, CLAI, MF, ntime, &
                                       date_str, us, P_surf, SWD, LWD, CO2, TS, QS, Gsoil, &
                                       SPD, T, Q, xlat, xlon, flag ) 

  USE clm_varpar_my, only : nlevgrnd, mincoszen
  USE mcm_data_mod, only : mcm_force, canopy_lai
  implicit none
  
  INTEGER, INTENT(IN) :: ntime 

  REAL, INTENT(IN) :: dt  ! for soil T and Q
  TYPE(canopy_lai), INTENT(IN) :: CLAI
  TYPE(mcm_force), INTENT(OUT) :: MF
  LOGICAL :: flag

  ! ------ local ------
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

  MF%wind(:) = SPD    ! near surf wind
  MF%tair(:) = T
  MF%qair(:) = Q


  MF%dt = dt
  MF%t10 = 25. + 273.15
  MF%dayl_factor = 0.9  ! Eq. 8.24

  MF%us = us
  MF%Gsoil = Gsoil
  MF%surf_pre = P_surf

  !------------
  MF%lwd    = LWD
  !frac_cloud = 0.1
  !tmp = (1. - .261 * exp(-.000777 * (273.16 - T)**2.) ) * frac_cloud + 1. - frac_cloud
  !MF%lwd = 5.67e-08 * T**4 * tmp 
  !------------


  MF%co2(:)  = CO2   ! ppmv

  MF%rho(:)  = 1.22  ! kg/m^3

  !MF%tsoil(1) = TS
  !MF%qsoil(3) = MF%qsoil(3) + 0.5*( QS - MF%qsoil(3) )

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

  ! --- solar radiation needs four stream value and solar zenith angle,
  ! they are not provided in observation, so use a model to parameterize
  xlat = -38.  ! CHATS
  xlon = -121.

  !xlat = -44.4523
  !xlon = -121.5574
  call solar_flux_at_top(date_str, xlat, xlon, swd_top, coszen, decl)
  MF%coszen = coszen

  !--------------------------------------------------

  if ( swd < -100. ) swd = 0.9*swd_top 
  if ( coszen > mincoszen ) then
      !call one_to_four_stream_sw( swd, swd_top, &
      !                            sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir )  
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

! -------------------------------------------------------------

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


!#----------------------------------
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
  !do while( .TRUE. )
  !    read( 234, *, iostat = io) T(it), S(it), sw_in(it), lw_in(it), tair(it), &
  !                               qair(it), Psurf(it), spd(it), tsoil(it), qsoil(it), G(it),&
  !                               sw_out(it), lw_out(it), Rn(it), LE(it), SH(it), &
  !                               !LEg(it), SHg(it), NEE(it), date_str(it)
  !                               LEg(it), SHg(it), date_str(it)
  !    if (io < 0) exit
  !    it = it + 1
  !ENDDO
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

! -------------------------------------------------------------

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

!=============================================================

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

  !--- local ---
  INTEGER :: i, j, id, jd
  REAL :: tao_xz, tao_yz, V0_u, V0_v, epsilon=0.01
  REAl :: g = 9.81, cd0, z0, z1, rho_1
!
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

!=============================================================

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

  ! --- local ---
  INTEGER :: i, j, k, i1, j1, bl, tl, nw, ir
  REAL ::  pre_tend, pre_test, A_f, speed
  REAL, PARAMETER :: C_d = 0.2
  !REAL, PARAMETER :: C_d = 0.7
  REAL :: C_d1 ! vary with speed (U/A)**B, Pan et al. 2014

  ! -- U --
  DO j = jts, min(jte,jde-1)
  DO i = its, ite

      i1 = min(i, ide - 1)
      if (CLAI(i1,j)%nw > 0 ) then
        bl = CLAI(i1,j)%bl
        nw = CLAI(i1,j)%nw
        tl = nw + bl - 1

        DO k = bl, tl+1
            ir = nw - k + bl  ! nw = tl - bl + 1
            if ( k == tl+1) then
                A_f = CLAI(i1,j)%lad(bl)*0.1 ! additional layer at top
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
            !C_d1 = CLAI(i1,j)%cd(ir)

            pre_tend = - C_d1 * A_f * speed * u(i,k,j)
            pre_test = u(i,k,j) + dt * pre_tend
            IF ( SIGN(pre_test,u(i,k,j)) /= pre_test ) THEN
                pre_tend = - u(i,k,j)/dt
            ENDIF
 
            !ru_tendf(i,k,j) =  ru_tendf(i,k,j) + pre_tend * muu(i,j)/msfuy(i,j)
            ru_tendf(i,k,j) =  ru_tendf(i,k,j) + pre_tend * muu(i,j)
        ENDDO
      endif
  ENDDO
  ENDDO

  !--- V ---
  DO j = jts, jte
  DO i = its, min(ite,ide-1)

      j1 = min(j, jde - 1)
      if (CLAI(i,j1)%nw > 0 ) then
        bl = CLAI(i,j1)%bl
        nw = CLAI(i,j1)%nw
        tl = nw + bl - 1

        DO k = bl, tl+1

            ir = nw - k + bl  ! nw = tl - bl + 1
            if ( k == tl+1) then
                A_f = CLAI(i,j1)%lad(bl)*0.1 ! additional layer at top
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
            !!C_d1 = CLAI(i,j1)%cd(ir)

            pre_tend = - C_d1 * A_f * speed * v(i,k,j)
            pre_test = v(i,k,j) + dt * pre_tend
            IF ( SIGN(pre_test,v(i,k,j)) /= pre_test ) THEN
                pre_tend = - v(i,k,j)/dt
            ENDIF
            !rv_tendf(i,k,j) = rv_tendf(i,k,j) + pre_tend * muv(i,j)/msfvx(i,j)
            rv_tendf(i,k,j) = rv_tendf(i,k,j) + pre_tend * muv(i,j)
        ENDDO
      endif
  ENDDO
  ENDDO

  !--- W ---
  DO j = jts, min(jte,jde-1)
  DO i = its, min(ite,ide-1)
      if (CLAI(i,j)%nw > 0 ) then
        bl = CLAI(i,j)%bl
        nw = CLAI(i,j)%nw
        tl = nw + bl - 1

        DO k = bl+1, tl+1

            ir = nw - k + bl  ! nw = tl - bl + 1
            if ( k == tl+1) then
                A_f = CLAI(i,j1)%lad(bl)*0.1 ! additional layer at top
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

            !C_d1 = min(0.8, (speed/0.29)**-0.74)
            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            C_d1 = C_d
            !C_d1 = CLAI(i,j)%cd(ir)

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

  !--- TKE ---
  DO j = jts, min(jte,jde-1)
  DO i = its, min(ite,ide-1)
      if (CLAI(i,j)%nw > 0 ) then
        bl = CLAI(i,j)%bl
        nw = CLAI(i,j)%nw
        tl = nw + bl - 1

        DO k = bl, tl

            ir = nw - k + bl  ! nw = tl - bl + 1
            A_f = CLAI(i,j)%lad(ir)

!            speed = sqrt( ((u(i,k,j) + u(i+1,k,j) + u(i,k-1,j) + u(i+1,k-1,j))*0.25)**2 + &
!                          ((v(i,k,j) + v(i,k,j+1) + v(i,k-1,j) + v(i,k-1,j+1))*0.25)**2 + &
!                          w(i,k,j)**2 )
! TWJ
            speed = sqrt( ((u(i,k,j) + u(i+1,k,j))*0.5)**2 + &
                          ((v(i,k,j) + v(i,k,j+1))*0.5)**2 + &
                          w(i,k,j)**2 )

            !cd_pan(i,k,j) = min(0.8, (speed/0.29)**-0.74)
            if (k == 1) then
                C_d1 = 0.25
            else
                C_d1 = min(0.8, (speed/0.29)**-0.74)
            endif
            !cd_pan(i,k,j) = C_d
            !cd_pan(i,k,j) = CLAI(i,j)%cd(ir)

            pre_tend = 2.67 * C_d * A_f * speed * tke(i,k,j)
            !pre_test = tke(i,k,j) + dt * pre_tend
            !IF ( pre_test <0 ) THEN
            !    pre_tend = - tke(i,k,j)/dt
            !ENDIF
            tke_tend(i,k,j) =  pre_tend * mut(i,j)

            wind(i,k,j) = speed
         ENDDO
      endif
  ENDDO
  ENDDO

  END SUBROUTINE momentum_drag

!=============================================================

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

   !--------------- local variables
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

!=================================

!=============================================================

END MODULE module_multi_layer_canopy_model_func

!===================================================
! For an offline model, comment the following module
!===================================================
MODULE module_multi_layer_canopy_model

   USE module_state_description
 ! Driver layer modules
   USE module_domain
   USE module_configure
   USE module_tiles
   USE module_machine
 ! Model layer modules
   USE module_bc
!   USE module_function

 CONTAINS

  SUBROUTINE MCM_DRIVER( grid, config_flags, &
                         t_phy, p_phy,       &
                         QV, CO2, QV_tend, CO2_tend,       &
 !                        QV, CO2, CO3, QV_tend, CO2_tend,       &
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

  REAL, DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(IN) :: QV   ! kg/kg
  REAL,DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(INOUT) :: CO2

  REAL, DIMENSION(ims:ime,kms:kme,jms:jme),INTENT(INOUT) :: QV_tend,  &
                                                            CO2_tend, &
                                                            t_tendf, &
                                                            ru_tendf,  &
                                                            rv_tendf,  &
                                                            rw_tendf,  &
                                                            tke_tend
  !--------------------------------------------------------------------------
  ! --- local ---
  REAL,DIMENSION(ims:ime,jms:jme) :: hgt
  REAL,DIMENSION(ims:ime,kms:kme,jms:jme) :: wind
  REAL,DIMENSION(kms:kme) :: tmp_1d
  REAL :: pres_gradient

  !--- local mcm var ---
  real :: qv_out(mxlevcan_wrf)      ! kg/m^2/s, positive to air
  real :: sh_out(mxlevcan_wrf)      ! W/m^2, positvie to air
  real :: an_out(mxlevcan_wrf)      ! (umol CO2/m**2/s)

  real :: sw_can_z(mxlevcan_wrf)    ! absorbed sw at each canopy layer
  real :: lw_can_z(mxlevcan_wrf)    ! absorbed lw at each canopy layer
  real :: efsh_z(mxlevcan_wrf)      ! sensible heat flux from leaf (W/m^2)
  real :: efe_z(mxlevcan_wrf)       ! latent heat flux from leaf (W/m^2)
  real :: sw_grnd                   ! solar radiation absorbed by ground (W/m**2)
  real :: lw_grnd                   ! longwave radiation absorbed by ground (W/m**2)
  real :: eflx_sh_grnd              ! sensible heat flux from ground (W/m**2) [+ to atm]
  real :: qflx_ev_grnd              ! soil evaporation (kg/m**2/s) (+ = to atm)
  real :: SHg, LEg, sw_out, lw_out
  real :: Qtop ! heat flux at canopy top (K m/s)

  REAL :: dt_soil
  REAL :: OBS_interval
  INTEGER :: i, j, k, i_start, i_end, j_start, j_end, dd
  real, save :: sw_dir_vis = 0, sw_dir_nir = 0, sw_dif_vis = 0, sw_dif_nir = 0, &
                lwd = 0, coszen = 0, Utop_C = 0, qsoil_C = 0, tsoil_C = 0, G_C = 0
  real :: s_bdy, roughness_len
  logical, save :: initial_mcm  = .true.
  !logical, save :: first_call_mcm  = .true.
  !integer, save :: first_call_mcm  = 0
  !--------------------------------------------------------------------------
 
!RETURN

  CALL wrf_debug(200, 'Entering MCM_DRIVER')

  !------ MCM must be after IBM initiating the grid height ----
!  IF (first_call_mcm) THEN
!      first_call_mcm = .false.
!      RETURN
!  ENDIF
  !--------------------------------------------------------

  IF (.not. allocated(SP))   allocate(SP(ims:ime,jms:jme))
  IF (.not. allocated(CLAI)) allocate(CLAI(ims:ime,jms:jme))
  IF (.not. allocated(MF))   allocate(MF(ims:ime,jms:jme))

  call get_hgt_twj( hgt, grid%HT, ims, ime, jms, jme )

  IF (initial_mcm) THEN
      initial_mcm = .false.

      CO2 = 0.
      !CO3 = 0.

      DO j = jts, min(jte,jde-1)
      DO i = its, min(ite,ide-1)
          !if (hgt(i,j) > 10. ) then
          !if (i <= 300 .or. i >= 800 ) then
             roughness_len = 0.05 ! unit [m]
             call initiate_mcm_forest( SP(i,j), CLAI(i,j), MF(i,j), &
                                grid%z(i,1:kme-1,j) - hgt(i,j), kme-1, roughness_len )
          !else
          !   roughness_len = 0.1 ! unit [m]
          !   call initiate_mcm_grass( CLAI(i,j), grid%z(i,1:kme-1,j) - hgt(i,j), kme-1, &
          !                            roughness_len )
          !endif

! TWJ
!             call initial_soil_1d( z, dz, zi, rootfr, bsw, watsat, hksat, sucsat, &
!                              csol, tkmg, tkdry, tksatu, ivt, its )
             call initial_soil_1d( SP(i,j), CLAI(i,j) )
      ENDDO
      ENDDO
      CALL wrf_debug(200, 'Done initiate_mcm_forest')
  ENDIF

  !call random_lai()
  !call random_trig()

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

!  pres_gradient = 0.00006  ! S
!  pres_gradient = 0.00010  ! M2
!  pres_gradient = 0.001  ! L
!  CALL constant_pressure_gradient_nudge( pres_gradient,                   &
!                                         ru_tendf, grid%rho,  grid%muu,   &
!                                         ids, ide, jds, jde, kds, kde, &
!                                         ims, ime, jms, jme, kms, kme, &
!                                         its, ite, jts, jte, kts, kte )
  
!  RETURN

! ==========  idealized scalar source, saved in CO2 ============
!  call simple_scalar_source_NOIBM( CO2, grid%mcm_co2_tend, CLAI, grid%z_at_w, &
!                             grid%mut, grid%itimestep, &
!                             ids,ide, jds,jde, kds,kde, &
!                             ims,ime, jms,jme, kms,kme, &
!                             its,ite, jts,jte, kts,kte )
!
!  s_bdy = 200.  ! bdy concentation
!  call IBM_Concentration_BDY(co2, co3, grid%IBM_FS_M, S_bdy, &
!                             grid%itimestep, &
!                             ids,ide, jds,jde, kds,kde, &
!                             ims,ime, jms,jme, kms,kme, &
!                             its,ite, jts,jte, kts,kte )
!
!  CO2_tend = CO2_tend + grid%mcm_co2_tend
! =============================================================

!  RETURN

!=============================================================
!=============================================================
!  The following codes are for full MCANOPY model, 
!  need to provide observation driving force.
!=============================================================

  OBS_interval = 30.  ! observation data time interval [s]
  !OBS_interval = config_flags%mcm_obs_interval
  call read_obs_driving( OBS_interval, grid%itimestep, grid%dt, &
                         sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   ! OBS Driving
                         lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C )     ! OBS Driving
  CALL wrf_debug(200, 'Done read_obs_driving')

  dd = 1
  !dd = config_flags%mcm_skip_nsteps

  i_start = its
  i_end   = MIN(ite,ide-1)
  j_start = jts
  j_end   = MIN(jte,jde-1)

! TWJ: this is likely cause of undesired TKE enhancement at boundaries
! keep upper damping diffusion away from relaxation zones at boundaries if used
!  IF(config_flags%specified .OR. config_flags%nested)THEN
!    i_start = MAX(i_start,ids+config_flags%spec_bdy_width-1)
!    i_end   = MIN(i_end,ide-config_flags%spec_bdy_width)
!    j_start = MAX(j_start,jds+config_flags%spec_bdy_width-1)
!    j_end   = MIN(j_end,jde-config_flags%spec_bdy_width)
!  ENDIF

  IF ( mod(grid%itimestep,dd) .EQ. 0) then
      DO j = j_start, j_end
      DO i = i_start, i_end

! TWJ: run only in regions where we have forest
!      IF ( grid%lu_index(i,j) .EQ. 1   .OR. &  ! Evergreen Needleleaf Forest
!           grid%lu_index(i,j) .EQ. 2   .OR. &  ! Evergreen Broadleaf Forest
!           grid%lu_index(i,j) .EQ. 3   .OR. &  ! Deciduous Needleleaf Forest
!           grid%lu_index(i,j) .EQ. 4   .OR. &  ! Deciduous Broadleaf Forest
!           grid%lu_index(i,j) .EQ. 5 )      &  ! Mixed Forest
!      THEN

      ! --- MCM model ----

          dt_soil = grid%dt*dd

          !tmp_1d = 385.  ! set constant CO2
          call set_mcm_force( config_flags, MF(i,j), CLAI(i,j), grid%restart, dt_soil,                  &
                              sw_dir_vis, sw_dir_nir, sw_dif_vis, sw_dif_nir, &   ! OBS Driving
                              lwd, coszen, Utop_C, qsoil_C, tsoil_C, G_C,     &   ! OBS Driving
                              p_phy(i,:,j), t_phy(i,:,j), qv(i,:,j), grid%rho(i,:,j), &
                              CO2(i,:,j), wind(i,:,j),                               &
                              grid%swvisdir(i,j), grid%swnirdir(i,j), grid%swvisdif(i,j), &
                              grid%swnirdif(i,j), grid%glw(i,j), &
                              !tmp_1d, wind(i,:,j),                               &
                              kms, kme )
          CALL wrf_debug(200, 'Done set_mcm_force')

          !====================================
          !call simple_mcm( qv_out, sh_out, an_out, &
          !                 CLAI(i,j), MF(i,j)%rho )

          !call simple_mcm_heat_profile( sh_out, CLAI(i,j), MF(i,j)%rho, Qtop, &
          !                              grid%mcm_sh(i,:,j), kms, kme )

          CALL multi_layer_canopy( qv_out, sh_out, an_out,             &  ! MCM O        
                                   LEg, SHg, &
                                   CLAI(i,j), SP(i,j), MF(i,j),        &
                                   sw_can_z, lw_can_z, efsh_z, efe_z )
                                   !sw_out, lw_out)
          CALL wrf_debug(200, 'Done multi_layer_canopy')


          ! flux convert to tendency in WRF grid (qv_tend, co2_tend, t_tendf)
          call flux_to_tendency( grid%mcm_qv_tend(i,:,j), grid%mcm_t_tend(i,:,j),    &
                                 grid%mcm_co2_tend(i,:,j),                           &
                                 grid%mcm_q_source(i,:,j),                           &  
                                 grid%mcm_co2_source(i,:,j),                           &
                                 qv_out, sh_out, an_out, CLAI(i,j),                  &
                                 grid%z_at_w(i,:,j), qv(i,:,j), grid%rho(i,:,j), t_phy(i,:,j), &
                                 p_phy(i,:,j), grid%dnw, grid%mut(i,j), &
                                 !grid%cd_pan(i,:,j), & ! test
                                 grid%mcm_tau13_t(i,1,j), grid%mcm_tau13_q(i,1,j), &
                                 grid%mcm_tau13_c(i,1,j), kms, kme )
          CALL wrf_debug(200, 'Done flux_to_tendency')

          call save_mcm_var( CLAI(i,j)%lai, grid%mcm_tlai(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( sw_can_z, grid%mcm_sw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( lw_can_z, grid%mcm_lw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( efsh_z,   grid%mcm_sh(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          call save_mcm_var( efe_z,    grid%mcm_le(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
          !write(*,*) efsh_z
          !write(*,*) '!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          !write(*,*) grid%mcm_sh(i,:,j)
          grid%mcm_sh_grnd(i,j) = SHG
          grid%mcm_le_grnd(i,j) = LEG

          grid%mcm_sw_in(i,j) = MF(i,j)%swd(1) + MF(i,j)%swd(2) + MF(i,j)%swi(1) + MF(i,j)%swi(2)
          !grid%mcm_sw_out(i,j) = sw_out
          grid%mcm_lw_in(i,j) = MF(i,j)%lwd 
          !grid%mcm_lw_out(i,j) = lw_out

      DO k = kts, kte
          grid%www(i,k,j) = grid%ww(i,k,j)/grid%mu_2(i,j)
      ENDDO

! TWJ
!      ELSE  ! MCANOPY inactive

!          call save_mcm_var_nan( grid%mcm_tlai(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
!          call save_mcm_var_nan( grid%mcm_sw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
!          call save_mcm_var_nan( grid%mcm_lw(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
!          call save_mcm_var_nan( grid%mcm_sh(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )
!          call save_mcm_var_nan( grid%mcm_le(i,kms:kme,j), CLAI(i,j)%bl, CLAI(i,j)%nw, kms, kme )

!          grid%mcm_sh_grnd(i,j) = -999.
!          grid%mcm_le_grnd(i,j) = -999.

! TWJ
!      ENDIF

      ENDDO
      ENDDO

  ENDIF


!  if ( grid%itimestep > 100*60*18 ) then
  QV_tend  = QV_tend  + grid%mcm_qv_tend
!  t_tendf   = t_tendf   + grid%mcm_t_tend
  CO2_tend = CO2_tend + grid%mcm_co2_tend
!  endif

  !call set_surface_temp(grid%t_2(:,1:), grid%itimestep, grid%dt,
  !                      ids, ide, jds, jde,     &
  !                      ims, ime, jms, jme,     &
  !                      its, ite, jts, jte      )

  CALL wrf_debug(200, 'Leaving MCM_DRIVER')

  END SUBROUTINE MCM_DRIVER

!================================================================
!================================================================

   ! called in module_first_rk_step_part2.F
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

   !--------------- local variables
   INTEGER :: i, j, k

   plane_sum_s(:) = 0.
   DO i = its, MIN(ite,ide-1)
       if (i == ide-1) then  ! only consider the out bdy
           DO k = kts, kte-1
           DO j = jts, MIN(jte,jde-1)
               plane_sum_s(k) = plane_sum_s(k) + scalar(i,k,j)
           ENDDO
           ENDDO
       endif
   ENDDO

  END SUBROUTINE sum_plane_scalar

! -------------------------------------------------------------

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

   !--------------- local variables
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
               !scalar(i,k,j) = scalar(i,k,j) - coeff*plane_avg_s(k)
               scalar(i,k,j) = scalar(i,k,j) - coeff*(plane_avg_s(k) - scalar_bg)
           ENDDO
           ENDDO
       endif
   ENDDO
  
  END SUBROUTINE scalar_nudge
END MODULE module_multi_layer_canopy_model


!=============================================================
! Main program, MCM 1D version. Yulong Ma 11/21/2016 at WSU
!=============================================================

!PROGRAM MCM_1D
!
!  USE clm_varpar_my, only : nlevgrnd, mxlevcan_wrf, cpair, hvap, sc_p
!  USE mcm_data_mod, only : CLAI1, SP1, MF1
!  USE module_multi_layer_canopy_model_func
!  USE mcm_data_mod,  only : mcm_force
!
!  IMPLICIT NONE
!
!  REAL :: dt_soil
!  INTEGER, PARAMETER :: nz = 50  
!  REAL :: z(nz)
!
!  !--- local mcm var ---
!  real :: qv_out(mxlevcan_wrf)      ! kg/m^2/s, positive to air
!  real :: sh_out(mxlevcan_wrf)      ! W/m^2, positvie to air
!  real :: an_out(mxlevcan_wrf)      ! (umol CO2/m**2/s)
!  real :: ag_out(mxlevcan_wrf)      ! (umol CO2/m**2/s)
!
!  real :: sw_can_z(mxlevcan_wrf)    ! absorbed sw at each canopy layer
!  real :: lw_can_z(mxlevcan_wrf)    ! absorbed lw at each canopy layer
!  real :: efsh_z(mxlevcan_wrf)      ! sensible heat flux from leaf (W/m^2)
!  real :: efe_z(mxlevcan_wrf)       ! latent heat flux from leaf (W/m^2)
!  real :: sw_grnd                   ! solar radiation absorbed by ground (W/m**2)
!  real :: lw_grnd                   ! longwave radiation absorbed by ground (W/m**2)
!  real :: eflx_sh_grnd              ! sensible heat flux from ground (W/m**2) [+ to atm]
!  real :: qflx_ev_grnd              ! soil evaporation (kg/m**2/s) (+ = to atm)
!  real :: tveg_z(mxlevcan_wrf)      ! canopy layer temp. (K)
!
!  real :: rs_sun_z(mxlevcan_wrf)          ! canopy layer: leaf stomatal resistance (s/m)
!  real :: rs_sha_z(mxlevcan_wrf)          ! canopy layer: leaf stomatal resistance (s/m)
!  real :: rb_z(mxlevcan_wrf)  
!
!  real :: ac_sun_z(mxlevcan_wrf)          
!  real :: aj_sun_z(mxlevcan_wrf)          
!  real :: ap_sun_z(mxlevcan_wrf)          
!  real :: an_sun_z(mxlevcan_wrf)          
!  real :: an_sha_z(mxlevcan_wrf)          
!  real :: btran_z(nlevgrnd)
!  real :: lmr_z(mxlevcan_wrf)          
!  real :: parsun_z(mxlevcan_wrf)          
!  real :: parsha_z(mxlevcan_wrf)          
!  real :: LEg, SHg, rsoil
!  !----------------------------------------------
!  integer, parameter :: nl = 7
!  integer, parameter :: mxlen = 20000
!  real :: T(mxlen), S(mxlen), sw_in(mxlen), lw_in(mxlen), tair(mxlen), qair(mxlen), &
!          Psurf(mxlen), spd(mxlen), tsoil(mxlen), qsoil(mxlen), G(mxlen), &
!          sw_out(mxlen), lw_out(mxlen), &
!          LE_OB(mxlen), SH_OB(mxlen), LEg_OB(mxlen), SHg_OB(mxlen), Rn_OB(mxlen), NEE(mxlen)
!  CHARACTER(LEN=24) :: date_str(mxlen)
!  integer :: nt, it
!  real :: us, co2, xlat, xlon
!  !----------------------------------------------
!
!  logical, save :: initial_mcm  = .false.
!  logical, save :: initial_soil = .false.
!
!  integer :: k, nw, ntime, nti
!  real :: t_source(mxlevcan_wrf), t_sum, t_source_ob
!  logical :: flag
!  real :: sw_can_sum, lw_can_sum, efsh_sum, efe_sum, fn, swd, psncan, gscan
!  real :: psncan_ac, psncan_aj
!  real :: sw_out_M, lw_out_M, An_sum, t_grnd, Ag_sum
!
!  real :: cht
!  !----------------------------------------------
!  character(len=30) :: ps(20)
!  integer :: Num_in
!
!  Num_in = command_argument_count()
!  do k = 1, Num_in
!      call get_command_argument(k, ps(k))
!      if (k /= Num_in)  read(ps(k), *) sc_p(k)
!      !write(*,*) ps(k), sc_p(k)
!  enddo
!  !-----------------------------------------------
!
!  IF ( Num_in > 0 ) THEN
!      OPEN ( FILE = ps(Num_in), UNIT = 923)
!  ELSE
!      OPEN ( FILE = 'MCM_1d_out.txt', UNIT = 923)
!      write(UNIT=923, fmt='(A31)' ) "date,LE,SH,LEg,SHg,An,Ag,lw_out"
!  ENDIF
!
!  do k = 1, nz
!      z(k) = 0.25+ 0.5*(k-1)    ! dz
!  enddo
!  call initiate_mcm( SP1, CLAI1, MF1, cht, z, nz, initial_mcm, 2.5, 0.01 )  ! lai = 2.8
!  nw = CLAI1%nw
!  !write(*,*) CLAI%lai(1:nw)
!
!  call read_chats_data_all_toplayer( date_str, T, S, sw_in, lw_in, tair, qair, &
!                                     Psurf, spd, tsoil, qsoil, G,            &
!                                     sw_out, lw_out, LE_OB, SH_OB, LEg_OB, SHg_OB,  &
!                                     Rn_OB, NEE, mxlen, nt ) 
!  dt_soil = 300.
!  us = 0.05
!  co2 = 380.
!  xlat = -38.  ! CHATS
!  xlon = -121.
!
!  do it = 1, nt
!  
!      !write(*,*) Psurf(it), sw_in(it), lw_in(it), tsoil(it), qsoil(it), G(it), tair(it), qair(it)
!      call set_mcm_force_from_chats( dt_soil, CLAI1, MF1, ntime, &
!                   date_str(it), us, Psurf(it), sw_in(it), lw_in(it), &
!                   co2, tsoil(it), qsoil(it), G(it), &
!                   spd(it), tair(it), qair(it), xlat, xlon, flag )
!
!      !MF%qsoil= M1%qsoil
!     
!      if (flag) then
!          call multi_layer_canopy( qv_out, sh_out, an_out, LEg, SHg, CLAI1, SP1, MF1,    &
!                                   sw_can_z, lw_can_z, efsh_z, efe_z,      &
!                                   tveg_z, psncan, psncan_ac, psncan_aj, gscan, rs_sun_z, rs_sha_z, &
!                                   rb_z, t_source, sw_grnd, lw_grnd, lw_out_M, &
!                                   ac_sun_z, aj_sun_z, an_sun_z, an_sha_z, lmr_z, btran_z, &
!                                   eflx_sh_grnd, qflx_ev_grnd, parsun_z, parsha_z, sw_out_M, &
!                                   t_grnd, rsoil )
!      else
!         efsh_z = -9999.
!      endif
!
!      t_sum = 0.
!      sw_can_sum = 0.
!      lw_can_sum = 0.
!      efsh_sum = 0.
!      efe_sum = 0.
!      An_sum = 0.
!      Ag_sum = 0.
!
!      do k = 1, nw
!          sw_can_sum = sw_can_sum + sw_can_z(k)
!          lw_can_sum = lw_can_sum + lw_can_z(k)
!          efsh_sum = efsh_sum - efsh_z(k)
!          efe_sum = efe_sum - efe_z(k)
!          t_sum = t_sum - t_source(k)
!          An_sum = An_sum + an_out(k)
!          Ag_sum = Ag_sum + ag_out(k)
!      enddo
!      !efsh_sum = efsh_sum - eflx_sh_grnd
!      !efe_sum  = efe_sum + qflx_ev_grnd * hvap
!
!      fn = sw_can_sum + lw_can_sum + efsh_sum + efe_sum
!
!!--------------- for SCEM_UA -----------
!      IF ( Num_in > 0 ) THEN
!          write(UNIT=923, FMT='(A19, A, F15.3, A, F15.3)') &
!             date_str(it), ',', efsh_sum + SHg, ',', SH_OB(it) + SHg_OB(it)
!      ELSE
!          write(UNIT=923, FMT='(A19, ",", F18.3, ",", F18.3, ",",     &
!                                F18.4, ",", F18.4, ",", F18.4, ",", &
!                                F18.4, ",", F18.4 )' )   &
!                  date_str(it),  efe_sum, efsh_sum, LEg, SHg, An_sum, Ag_sum, lw_out_M
!        ENDIF
!!      write(*,*) 'r', spd(it), MF1%wind(1)
!
!  enddo
!
!  CLOSE(923)
!
!END PROGRAM MCM_1D
