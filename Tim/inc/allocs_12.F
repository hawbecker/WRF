!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_12.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_12( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
         sd31, ed31, sd32, ed32, sd33, ed33, &
         sm31 , em31 , sm32 , em32 , sm33 , em33 , &
         sp31 , ep31 , sp32 , ep32 , sp33 , ep33 , &
         sp31x, ep31x, sp32x, ep32x, sp33x, ep33x, &
         sp31y, ep31y, sp32y, ep32y, sp33y, ep33y, &
         sm31x, em31x, sm32x, em32x, sm33x, em33x, &
         sm31y, em31y, sm32y, em32y, sm33y, em33y )
  USE module_domain_type
  USE module_configure, ONLY : model_config_rec, grid_config_rec_type, in_use_for_config, model_to_grid_config_rec
  USE module_scalar_tables ! this includes module_state_description too
  IMPLICIT NONE
  !  Input data.

  TYPE(domain)               , POINTER          :: grid
  INTEGER , INTENT(IN)            :: id
  INTEGER , INTENT(IN)            :: setinitval_in   ! 3 = everything, 1 = arrays only, 0 = none
  INTEGER , INTENT(IN)            :: sd31, ed31, sd32, ed32, sd33, ed33
  INTEGER , INTENT(IN)            :: sm31, em31, sm32, em32, sm33, em33
  INTEGER , INTENT(IN)            :: sp31, ep31, sp32, ep32, sp33, ep33
  INTEGER , INTENT(IN)            :: sp31x, ep31x, sp32x, ep32x, sp33x, ep33x
  INTEGER , INTENT(IN)            :: sp31y, ep31y, sp32y, ep32y, sp33y, ep33y
  INTEGER , INTENT(IN)            :: sm31x, em31x, sm32x, em32x, sm33x, em33x
  INTEGER , INTENT(IN)            :: sm31y, em31y, sm32y, em32y, sm33y, em33y

  ! this argument is a bitmask. First bit is time level 1, second is time level 2, and so on.
  ! e.g. to set both 1st and second time level, use 3
  !      to set only 1st                        use 1
  !      to set only 2st                        use 2
  INTEGER , INTENT(IN)            :: tl_in

  ! true if the allocation is for an intermediate domain (for nesting); only certain fields allocated
  ! false otherwise (all allocated, modulo tl above)
  LOGICAL , INTENT(IN)            :: inter_domain_in, okay_to_alloc_in

  INTEGER(KIND=8) , INTENT(INOUT)         :: num_bytes_allocated
  !  Local data.
  INTEGER idum1, idum2, spec_bdy_width
  REAL    initial_data_value
  CHARACTER (LEN=256) message
  INTEGER tl
  LOGICAL inter_domain, okay_to_alloc
  INTEGER setinitval
  INTEGER sr_x, sr_y

  !declare ierr variable for error checking ALLOCATE calls
  INTEGER ierr

  INTEGER                              :: loop
  INTEGER(KIND=8)                      :: nba ! number of bytes allocated per variable
  CHARACTER(LEN=256)                   :: message_string

  ! Local data

  TYPE ( grid_config_rec_type ) :: config_flags

  INTEGER                         :: k_start , k_end, its, ite, jts, jte
  INTEGER                         :: ids , ide , jds , jde , kds , kde , &
                                    ims , ime , jms , jme , kms , kme , &
                                    ips , ipe , jps , jpe , kps , kpe

  INTEGER                         :: sids , side , sjds , sjde , skds , skde , &
                                    sims , sime , sjms , sjme , skms , skme , &
                                    sips , sipe , sjps , sjpe , skps , skpe

  INTEGER ::              imsx, imex, jmsx, jmex, kmsx, kmex,    &
                          ipsx, ipex, jpsx, jpex, kpsx, kpex,    &
                          imsy, imey, jmsy, jmey, kmsy, kmey,    &
                          ipsy, ipey, jpsy, jpey, kpsy, kpey

  data_ordering : SELECT CASE ( model_data_order )
    CASE  ( DATA_ORDER_XYZ )
        ids = sd31 ; ide = ed31 ; jds = sd32 ; jde = ed32 ; kds = sd33 ; kde = ed33 ;
        ims = sm31 ; ime = em31 ; jms = sm32 ; jme = em32 ; kms = sm33 ; kme = em33 ;
        ips = sp31 ; ipe = ep31 ; jps = sp32 ; jpe = ep32 ; kps = sp33 ; kpe = ep33 ;
        imsx = sm31x ; imex = em31x ; jmsx = sm32x ; jmex = em32x ; kmsx = sm33x ; kmex = em33x ;
        ipsx = sp31x ; ipex = ep31x ; jpsx = sp32x ; jpex = ep32x ; kpsx = sp33x ; kpex = ep33x ;
        imsy = sm31y ; imey = em31y ; jmsy = sm32y ; jmey = em32y ; kmsy = sm33y ; kmey = em33y ;
        ipsy = sp31y ; ipey = ep31y ; jpsy = sp32y ; jpey = ep32y ; kpsy = sp33y ; kpey = ep33y ;
    CASE  ( DATA_ORDER_YXZ )
        ids = sd32  ; ide = ed32  ; jds = sd31  ; jde = ed31  ; kds = sd33  ; kde = ed33  ;
        ims = sm32  ; ime = em32  ; jms = sm31  ; jme = em31  ; kms = sm33  ; kme = em33  ;
        ips = sp32  ; ipe = ep32  ; jps = sp31  ; jpe = ep31  ; kps = sp33  ; kpe = ep33  ;
        imsx = sm32x  ; imex = em32x  ; jmsx = sm31x  ; jmex = em31x  ; kmsx = sm33x  ; kmex = em33x  ;
        ipsx = sp32x  ; ipex = ep32x  ; jpsx = sp31x  ; jpex = ep31x  ; kpsx = sp33x  ; kpex = ep33x  ;
        imsy = sm32y  ; imey = em32y  ; jmsy = sm31y  ; jmey = em31y  ; kmsy = sm33y  ; kmey = em33y  ;
        ipsy = sp32y  ; ipey = ep32y  ; jpsy = sp31y  ; jpey = ep31y  ; kpsy = sp33y  ; kpey = ep33y  ;
    CASE  ( DATA_ORDER_ZXY )
        ids = sd32  ; ide = ed32  ; jds = sd33  ; jde = ed33  ; kds = sd31  ; kde = ed31  ;
        ims = sm32  ; ime = em32  ; jms = sm33  ; jme = em33  ; kms = sm31  ; kme = em31  ;
        ips = sp32  ; ipe = ep32  ; jps = sp33  ; jpe = ep33  ; kps = sp31  ; kpe = ep31  ;
        imsx = sm32x  ; imex = em32x  ; jmsx = sm33x  ; jmex = em33x  ; kmsx = sm31x  ; kmex = em31x  ;
        ipsx = sp32x  ; ipex = ep32x  ; jpsx = sp33x  ; jpex = ep33x  ; kpsx = sp31x  ; kpex = ep31x  ;
        imsy = sm32y  ; imey = em32y  ; jmsy = sm33y  ; jmey = em33y  ; kmsy = sm31y  ; kmey = em31y  ;
        ipsy = sp32y  ; ipey = ep32y  ; jpsy = sp33y  ; jpey = ep33y  ; kpsy = sp31y  ; kpey = ep31y  ;
    CASE  ( DATA_ORDER_ZYX )
        ids = sd33  ; ide = ed33  ; jds = sd32  ; jde = ed32  ; kds = sd31  ; kde = ed31  ;
        ims = sm33  ; ime = em33  ; jms = sm32  ; jme = em32  ; kms = sm31  ; kme = em31  ;
        ips = sp33  ; ipe = ep33  ; jps = sp32  ; jpe = ep32  ; kps = sp31  ; kpe = ep31  ;
        imsx = sm33x  ; imex = em33x  ; jmsx = sm32x  ; jmex = em32x  ; kmsx = sm31x  ; kmex = em31x  ;
        ipsx = sp33x  ; ipex = ep33x  ; jpsx = sp32x  ; jpex = ep32x  ; kpsx = sp31x  ; kpex = ep31x  ;
        imsy = sm33y  ; imey = em33y  ; jmsy = sm32y  ; jmey = em32y  ; kmsy = sm31y  ; kmey = em31y  ;
        ipsy = sp33y  ; ipey = ep33y  ; jpsy = sp32y  ; jpey = ep32y  ; kpsy = sp31y  ; kpey = ep31y  ;
    CASE  ( DATA_ORDER_XZY )
        ids = sd31  ; ide = ed31  ; jds = sd33  ; jde = ed33  ; kds = sd32  ; kde = ed32  ;
        ims = sm31  ; ime = em31  ; jms = sm33  ; jme = em33  ; kms = sm32  ; kme = em32  ;
        ips = sp31  ; ipe = ep31  ; jps = sp33  ; jpe = ep33  ; kps = sp32  ; kpe = ep32  ;
        imsx = sm31x  ; imex = em31x  ; jmsx = sm33x  ; jmex = em33x  ; kmsx = sm32x  ; kmex = em32x  ;
        ipsx = sp31x  ; ipex = ep31x  ; jpsx = sp33x  ; jpex = ep33x  ; kpsx = sp32x  ; kpex = ep32x  ;
        imsy = sm31y  ; imey = em31y  ; jmsy = sm33y  ; jmey = em33y  ; kmsy = sm32y  ; kmey = em32y  ;
        ipsy = sp31y  ; ipey = ep31y  ; jpsy = sp33y  ; jpey = ep33y  ; kpsy = sp32y  ; kpey = ep32y  ;
    CASE  ( DATA_ORDER_YZX )
        ids = sd33  ; ide = ed33  ; jds = sd31  ; jde = ed31  ; kds = sd32  ; kde = ed32  ;
        ims = sm33  ; ime = em33  ; jms = sm31  ; jme = em31  ; kms = sm32  ; kme = em32  ;
        ips = sp33  ; ipe = ep33  ; jps = sp31  ; jpe = ep31  ; kps = sp32  ; kpe = ep32  ;
        imsx = sm33x  ; imex = em33x  ; jmsx = sm31x  ; jmex = em31x  ; kmsx = sm32x  ; kmex = em32x  ;
        ipsx = sp33x  ; ipex = ep33x  ; jpsx = sp31x  ; jpex = ep31x  ; kpsx = sp32x  ; kpex = ep32x  ;
        imsy = sm33y  ; imey = em33y  ; jmsy = sm31y  ; jmey = em31y  ; kmsy = sm32y  ; kmey = em32y  ;
        ipsy = sp33y  ; ipey = ep33y  ; jpsy = sp31y  ; jpey = ep31y  ; kpsy = sp32y  ; kpey = ep32y  ;
  END SELECT data_ordering

  CALL model_to_grid_config_rec ( id , model_config_rec , config_flags )

  CALL nl_get_sr_x( id , sr_x )
  CALL nl_get_sr_y( id , sr_y )

  tl = tl_in
  inter_domain = inter_domain_in
  okay_to_alloc = okay_to_alloc_in

#if ( RWORDSIZE == 8 )
  initial_data_value = 0.
#else
  CALL get_initial_data_value ( initial_data_value )
#endif

#ifdef NO_INITIAL_DATA_VALUE
  setinitval = 0
#else
  setinitval = setinitval_in
#endif

  CALL nl_get_spec_bdy_width( 1, spec_bdy_width )

IF ( setinitval .EQ. 3 ) grid%aer_ssa_opt=0
IF ( setinitval .EQ. 3 ) grid%aer_asy_opt=0
IF ( setinitval .EQ. 3 ) grid%aer_aod550_val=initial_data_value
IF ( setinitval .EQ. 3 ) grid%aer_angexp_val=initial_data_value
IF ( setinitval .EQ. 3 ) grid%aer_ssa_val=initial_data_value
IF ( setinitval .EQ. 3 ) grid%aer_asy_val=initial_data_value
IF ( setinitval .EQ. 3 ) grid%cu_rad_feedback=.FALSE.
IF ( setinitval .EQ. 3 ) grid%dust_emis=0
IF ( setinitval .EQ. 3 ) grid%erosion_dim=0
IF ( setinitval .EQ. 3 ) grid%no_src_types_cu=0
IF ( setinitval .EQ. 3 ) grid%alevsiz_cu=0
IF ( setinitval .EQ. 3 ) grid%aercu_opt=0
IF ( setinitval .EQ. 3 ) grid%aercu_fct=initial_data_value
IF ( setinitval .EQ. 3 ) grid%aercu_used=0
IF ( setinitval .EQ. 3 ) grid%couple_farms=.FALSE.
IF ( setinitval .EQ. 3 ) grid%shallowcu_forced_ra=.FALSE.
IF ( setinitval .EQ. 3 ) grid%numbins=0
IF ( setinitval .EQ. 3 ) grid%thbinsize=initial_data_value
IF ( setinitval .EQ. 3 ) grid%rbinsize=initial_data_value
IF ( setinitval .EQ. 3 ) grid%mindeepfreq=initial_data_value
IF ( setinitval .EQ. 3 ) grid%minshallowfreq=initial_data_value
IF ( setinitval .EQ. 3 ) grid%shcu_aerosols_opt=0
IF ( setinitval .EQ. 3 ) grid%icloud_cu=0
IF ( setinitval .EQ. 3 ) grid%pxlsm_smois_init=0
IF ( setinitval .EQ. 3 ) grid%pxlsm_modis_veg=0
IF ( setinitval .EQ. 3 ) grid%omlcall=0
IF ( setinitval .EQ. 3 ) grid%sf_ocean_physics=0
IF ( setinitval .EQ. 3 ) grid%traj_opt=0
IF ( setinitval .EQ. 3 ) grid%dm_has_traj=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tracercall=0
IF ( setinitval .EQ. 3 ) grid%shalwater_z0=0
IF ( setinitval .EQ. 3 ) grid%shalwater_depth=initial_data_value
IF ( setinitval .EQ. 3 ) grid%omdt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%oml_hml0=initial_data_value
IF ( setinitval .EQ. 3 ) grid%oml_gamma=initial_data_value
IF ( setinitval .EQ. 3 ) grid%oml_relaxation_time=initial_data_value
IF ( setinitval .EQ. 3 ) grid%isftcflx=0
IF ( setinitval .EQ. 3 ) grid%iz0tlnd=0
IF ( setinitval .EQ. 3 ) grid%shadlen=initial_data_value
IF ( setinitval .EQ. 3 ) grid%slope_rad=0
IF ( setinitval .EQ. 3 ) grid%topo_shading=0
IF ( setinitval .EQ. 3 ) grid%topo_wind=0
IF ( setinitval .EQ. 3 ) grid%no_mp_heating=0
IF ( setinitval .EQ. 3 ) grid%fractional_seaice=0
IF ( setinitval .EQ. 3 ) grid%seaice_snowdepth_opt=0
IF ( setinitval .EQ. 3 ) grid%seaice_snowdepth_max=initial_data_value
IF ( setinitval .EQ. 3 ) grid%seaice_snowdepth_min=initial_data_value
IF ( setinitval .EQ. 3 ) grid%seaice_albedo_opt=0
IF ( setinitval .EQ. 3 ) grid%seaice_albedo_default=initial_data_value
IF ( setinitval .EQ. 3 ) grid%seaice_thickness_opt=0
IF ( setinitval .EQ. 3 ) grid%seaice_thickness_default=initial_data_value
IF ( setinitval .EQ. 3 ) grid%tice2tsk_if2cold=.FALSE.
IF ( setinitval .EQ. 3 ) grid%bucket_mm=initial_data_value
IF ( setinitval .EQ. 3 ) grid%bucket_j=initial_data_value
IF ( setinitval .EQ. 3 ) grid%mp_tend_lim=initial_data_value
IF ( setinitval .EQ. 3 ) grid%prec_acc_dt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%prec_acc_opt=0
IF ( setinitval .EQ. 3 ) grid%bucketr_opt=0
IF ( setinitval .EQ. 3 ) grid%bucketf_opt=0
IF ( setinitval .EQ. 3 ) grid%process_time_series=0
IF ( setinitval .EQ. 3 ) grid%grav_settling=0
IF ( setinitval .EQ. 3 ) grid%sas_pgcon=initial_data_value
IF ( setinitval .EQ. 3 ) grid%scalar_pblmix=0
IF ( setinitval .EQ. 3 ) grid%tracer_pblmix=0
IF ( setinitval .EQ. 3 ) grid%use_aero_icbc=.FALSE.
IF ( setinitval .EQ. 3 ) grid%use_rap_aero_icbc=.FALSE.
IF ( setinitval .EQ. 3 ) grid%aer_init_opt=0
IF ( setinitval .EQ. 3 ) grid%wif_fire_emit=.FALSE.
IF ( setinitval .EQ. 3 ) grid%aer_fire_emit_opt=0
IF ( setinitval .EQ. 3 ) grid%wif_fire_inj=0
IF ( setinitval .EQ. 3 ) grid%use_mp_re=0
IF ( setinitval .EQ. 3 ) grid%insert_init_cloud=.FALSE.
IF ( setinitval .EQ. 3 ) grid%ccn_conc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%hail_opt=0
IF ( setinitval .EQ. 3 ) grid%morr_rimed_ice=0
IF ( setinitval .EQ. 3 ) grid%clean_atm_diag=0
IF ( setinitval .EQ. 3 ) grid%calc_clean_atm_diag=0
IF ( setinitval .EQ. 3 ) grid%acc_phy_tend=0
IF ( setinitval .EQ. 3 ) grid%madwrf_opt=0
IF ( setinitval .EQ. 3 ) grid%madwrf_dt_relax=initial_data_value
IF ( setinitval .EQ. 3 ) grid%madwrf_dt_nudge=initial_data_value
IF ( setinitval .EQ. 3 ) grid%madwrf_cldinit=0
IF ( setinitval .EQ. 3 ) grid%dveg=0
IF ( setinitval .EQ. 3 ) grid%opt_crs=0
IF ( setinitval .EQ. 3 ) grid%opt_btr=0
IF ( setinitval .EQ. 3 ) grid%opt_run=0
IF ( setinitval .EQ. 3 ) grid%opt_sfc=0
IF ( setinitval .EQ. 3 ) grid%opt_frz=0
IF ( setinitval .EQ. 3 ) grid%opt_inf=0
IF ( setinitval .EQ. 3 ) grid%opt_rad=0
IF ( setinitval .EQ. 3 ) grid%opt_alb=0
IF ( setinitval .EQ. 3 ) grid%opt_snf=0
IF ( setinitval .EQ. 3 ) grid%opt_tbot=0
IF ( setinitval .EQ. 3 ) grid%opt_stc=0
IF ( setinitval .EQ. 3 ) grid%opt_gla=0
IF ( setinitval .EQ. 3 ) grid%opt_rsf=0
IF ( setinitval .EQ. 3 ) grid%opt_soil=0
IF ( setinitval .EQ. 3 ) grid%opt_pedo=0
IF ( setinitval .EQ. 3 ) grid%opt_crop=0
IF ( setinitval .EQ. 3 ) grid%opt_irr=0
IF ( setinitval .EQ. 3 ) grid%opt_irrm=0
IF ( setinitval .EQ. 3 ) grid%opt_infdv=0
IF ( setinitval .EQ. 3 ) grid%opt_tdrn=0
IF ( setinitval .EQ. 3 ) grid%soiltstep=initial_data_value
IF ( setinitval .EQ. 3 ) grid%wtddt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%noahmp_acc_dt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%noahmp_output=0
IF ( setinitval .EQ. 3 ) grid%wrf_hydro=0
IF ( setinitval .EQ. 3 ) grid%fgdt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%fgdtzero=0
IF ( setinitval .EQ. 3 ) grid%grid_fdda=0
IF ( setinitval .EQ. 3 ) grid%grid_sfdda=0
IF ( setinitval .EQ. 3 ) grid%if_no_pbl_nudging_uv=0
IF ( setinitval .EQ. 3 ) grid%if_no_pbl_nudging_t=0
IF ( setinitval .EQ. 3 ) grid%if_no_pbl_nudging_ph=0
IF ( setinitval .EQ. 3 ) grid%if_no_pbl_nudging_q=0
IF ( setinitval .EQ. 3 ) grid%if_zfac_uv=0
IF ( setinitval .EQ. 3 ) grid%k_zfac_uv=0
IF ( setinitval .EQ. 3 ) grid%if_zfac_t=0
IF ( setinitval .EQ. 3 ) grid%k_zfac_t=0
IF ( setinitval .EQ. 3 ) grid%if_zfac_ph=0
IF ( setinitval .EQ. 3 ) grid%k_zfac_ph=0
IF ( setinitval .EQ. 3 ) grid%if_zfac_q=0
IF ( setinitval .EQ. 3 ) grid%k_zfac_q=0
IF ( setinitval .EQ. 3 ) grid%dk_zfac_uv=0
IF ( setinitval .EQ. 3 ) grid%dk_zfac_t=0
IF ( setinitval .EQ. 3 ) grid%dk_zfac_ph=0
IF ( setinitval .EQ. 3 ) grid%dk_zfac_q=0
IF ( setinitval .EQ. 3 ) grid%ktrop=0
IF ( setinitval .EQ. 3 ) grid%guv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%guv_sfc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gt_sfc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gq=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gq_sfc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gph=initial_data_value
IF ( setinitval .EQ. 3 ) grid%dtramp_min=initial_data_value
IF ( setinitval .EQ. 3 ) grid%if_ramping=0
IF ( setinitval .EQ. 3 ) grid%rinblw=initial_data_value
IF ( setinitval .EQ. 3 ) grid%xwavenum=0
IF ( setinitval .EQ. 3 ) grid%ywavenum=0
IF ( setinitval .EQ. 3 ) grid%pxlsm_soil_nudge=0
IF ( setinitval .EQ. 3 ) grid%fasdas=0
IF ( setinitval .EQ. 3 ) grid%obs_nudge_opt=0
IF ( setinitval .EQ. 3 ) grid%max_obs=0
IF ( setinitval .EQ. 3 ) grid%fdda_start=initial_data_value
IF ( setinitval .EQ. 3 ) grid%fdda_end=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudge_wind=0
IF ( setinitval .EQ. 3 ) grid%obs_coef_wind=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudge_temp=0
IF ( setinitval .EQ. 3 ) grid%obs_coef_temp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudge_mois=0
IF ( setinitval .EQ. 3 ) grid%obs_coef_mois=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudge_pstr=0
IF ( setinitval .EQ. 3 ) grid%obs_coef_pstr=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_no_pbl_nudge_uv=0
IF ( setinitval .EQ. 3 ) grid%obs_no_pbl_nudge_t=0
END SUBROUTINE allocs_12
