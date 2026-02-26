!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_11.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_11( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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

IF ( setinitval .EQ. 3 ) grid%vmax_ratio=initial_data_value
IF ( setinitval .EQ. 3 ) grid%rankine_lid=initial_data_value
IF ( setinitval .EQ. 3 ) grid%force_read_thompson=.FALSE.
IF ( setinitval .EQ. 3 ) grid%write_thompson_tables=.FALSE.
IF ( setinitval .EQ. 3 ) grid%write_thompson_mp38table=.FALSE.
IF ( setinitval .EQ. 3 ) grid%mp_physics=0
IF ( setinitval .EQ. 3 ) grid%nssl_cccn=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_alphah=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_alphahl=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_cnoh=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_cnohl=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_cnor=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_cnos=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_rho_qh=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_rho_qhl=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_rho_qs=initial_data_value
IF ( setinitval .EQ. 3 ) grid%ccnty=0
IF ( setinitval .EQ. 3 ) grid%nudge_lightning=0
IF ( setinitval .EQ. 3 ) grid%nudge_light_times=0
IF ( setinitval .EQ. 3 ) grid%nudge_light_timee=0
IF ( setinitval .EQ. 3 ) grid%nudge_light_int=0
IF ( setinitval .EQ. 3 ) grid%gsfcgce_hail=0
IF ( setinitval .EQ. 3 ) grid%gsfcgce_2ice=0
IF ( setinitval .EQ. 3 ) grid%progn=0
IF ( setinitval .EQ. 3 ) grid%accum_mode=initial_data_value
IF ( setinitval .EQ. 3 ) grid%aitken_mode=initial_data_value
IF ( setinitval .EQ. 3 ) grid%coarse_mode=initial_data_value
IF ( setinitval .EQ. 3 ) grid%do_radar_ref=0
IF ( setinitval .EQ. 3 ) grid%compute_radar_ref=0
IF ( setinitval .EQ. 3 ) grid%ra_lw_physics=0
IF ( setinitval .EQ. 3 ) grid%ra_sw_physics=0
IF ( setinitval .EQ. 3 ) grid%ra_sw_eclipse=0
IF ( setinitval .EQ. 3 ) grid%ghg_input=0
IF ( setinitval .EQ. 3 ) grid%radt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%naer=initial_data_value
IF ( setinitval .EQ. 3 ) grid%sf_sfclay_physics=0
IF ( setinitval .EQ. 3 ) grid%sf_surf_irr_scheme=0
IF ( setinitval .EQ. 3 ) grid%sf_surf_irr_alloc=0
IF ( setinitval .EQ. 3 ) grid%irr_daily_amount=initial_data_value
IF ( setinitval .EQ. 3 ) grid%irr_start_hour=0
IF ( setinitval .EQ. 3 ) grid%irr_num_hours=0
IF ( setinitval .EQ. 3 ) grid%irr_start_julianday=0
IF ( setinitval .EQ. 3 ) grid%irr_end_julianday=0
IF ( setinitval .EQ. 3 ) grid%irr_freq=0
IF ( setinitval .EQ. 3 ) grid%irr_ph=0
IF ( setinitval .EQ. 3 ) grid%sf_surface_physics=0
IF ( setinitval .EQ. 3 ) grid%bl_pbl_physics=0
IF ( setinitval .EQ. 3 ) grid%tke_budget=0
IF ( setinitval .EQ. 3 ) grid%ysu_topdown_pblmix=0
IF ( setinitval .EQ. 3 ) grid%shinhong_tke_diag=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_tkeadvect=.FALSE.
IF ( setinitval .EQ. 3 ) grid%bl_mynn_cloudpdf=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_mixlength=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_edmf=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_edmf_mom=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_edmf_tke=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_mixscalars=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_output=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_cloudmix=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_mixqt=0
IF ( setinitval .EQ. 3 ) grid%icloud_bl=0
IF ( setinitval .EQ. 3 ) grid%bl_mynn_closure=initial_data_value
IF ( setinitval .EQ. 3 ) grid%mfshconv=0
IF ( setinitval .EQ. 3 ) grid%sf_urban_physics=0
IF ( setinitval .EQ. 3 ) grid%bldt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%cu_physics=0
IF ( setinitval .EQ. 3 ) grid%shcu_physics=0
IF ( setinitval .EQ. 3 ) grid%cu_diag=0
IF ( setinitval .EQ. 3 ) grid%kf_edrates=0
IF ( setinitval .EQ. 3 ) grid%kfeta_trigger=0
IF ( setinitval .EQ. 3 ) grid%nsas_dx_factor=0
IF ( setinitval .EQ. 3 ) grid%cudt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%gsmdt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%isfflx=0
IF ( setinitval .EQ. 3 ) grid%ifsnow=0
IF ( setinitval .EQ. 3 ) grid%icloud=0
IF ( setinitval .EQ. 3 ) grid%cldovrlp=0
IF ( setinitval .EQ. 3 ) grid%idcor=0
IF ( setinitval .EQ. 3 ) grid%ideal_xland=0
IF ( setinitval .EQ. 3 ) grid%swrad_scat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%surface_input_source=0
IF ( setinitval .EQ. 3 ) grid%num_soil_layers=0
IF ( setinitval .EQ. 3 ) grid%num_pft_clm=0
IF ( setinitval .EQ. 3 ) grid%input_pft=.FALSE.
IF ( setinitval .EQ. 3 ) grid%maxpatch=0
IF ( setinitval .EQ. 3 ) grid%num_snow_layers=0
IF ( setinitval .EQ. 3 ) grid%num_snso_layers=0
IF ( setinitval .EQ. 3 ) grid%num_urban_ndm=0
IF ( setinitval .EQ. 3 ) grid%num_urban_ng=0
IF ( setinitval .EQ. 3 ) grid%num_urban_nwr=0
IF ( setinitval .EQ. 3 ) grid%num_urban_ngb=0
IF ( setinitval .EQ. 3 ) grid%num_urban_nf=0
IF ( setinitval .EQ. 3 ) grid%num_urban_nz=0
IF ( setinitval .EQ. 3 ) grid%num_urban_nbui=0
IF ( setinitval .EQ. 3 ) grid%num_urban_ngr=0
IF ( setinitval .EQ. 3 ) grid%urban_map_zrd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_zwd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_gd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_zd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_zdf=0
IF ( setinitval .EQ. 3 ) grid%urban_map_bd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_wd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_gbd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_fbd=0
IF ( setinitval .EQ. 3 ) grid%urban_map_zgrd=0
IF ( setinitval .EQ. 3 ) grid%num_urban_hi=0
IF ( setinitval .EQ. 3 ) grid%num_months=0
IF ( setinitval .EQ. 3 ) grid%sf_surface_mosaic=0
IF ( setinitval .EQ. 3 ) grid%mosaic_cat=0
IF ( setinitval .EQ. 3 ) grid%mosaic_cat_soil=0
IF ( setinitval .EQ. 3 ) grid%mosaic_lu=0
IF ( setinitval .EQ. 3 ) grid%mosaic_soil=0
IF ( setinitval .EQ. 3 ) grid%flag_sm_adj=0
IF ( setinitval .EQ. 3 ) grid%maxiens=0
IF ( setinitval .EQ. 3 ) grid%maxens=0
IF ( setinitval .EQ. 3 ) grid%maxens2=0
IF ( setinitval .EQ. 3 ) grid%maxens3=0
IF ( setinitval .EQ. 3 ) grid%ensdim=0
IF ( setinitval .EQ. 3 ) grid%cugd_avedx=0
IF ( setinitval .EQ. 3 ) grid%clos_choice=0
IF ( setinitval .EQ. 3 ) grid%imomentum=0
IF ( setinitval .EQ. 3 ) grid%ishallow=0
IF ( setinitval .EQ. 3 ) grid%convtrans_avglen_m=initial_data_value
IF ( setinitval .EQ. 3 ) grid%num_land_cat=0
IF ( setinitval .EQ. 3 ) grid%use_wudapt_lcz=0
IF ( setinitval .EQ. 3 ) grid%num_soil_cat=0
IF ( setinitval .EQ. 3 ) grid%mp_zero_out=0
IF ( setinitval .EQ. 3 ) grid%mp_zero_out_thresh=initial_data_value
IF ( setinitval .EQ. 3 ) grid%seaice_threshold=initial_data_value
IF ( setinitval .EQ. 3 ) grid%bmj_rad_feedback=.FALSE.
IF ( setinitval .EQ. 3 ) grid%sst_update=0
IF ( setinitval .EQ. 3 ) grid%qna_update=0
IF ( setinitval .EQ. 3 ) grid%sst_skin=0
IF ( setinitval .EQ. 3 ) grid%tmn_update=0
IF ( setinitval .EQ. 3 ) grid%usemonalb=.FALSE.
IF ( setinitval .EQ. 3 ) grid%rdmaxalb=.FALSE.
IF ( setinitval .EQ. 3 ) grid%rdlai2d=.FALSE.
IF ( setinitval .EQ. 3 ) grid%ua_phys=.FALSE.
IF ( setinitval .EQ. 3 ) grid%opt_thcnd=0
IF ( setinitval .EQ. 3 ) grid%co2tf=0
IF ( setinitval .EQ. 3 ) grid%ra_call_offset=0
IF ( setinitval .EQ. 3 ) grid%cam_abs_freq_s=initial_data_value
IF ( setinitval .EQ. 3 ) grid%levsiz=0
IF ( setinitval .EQ. 3 ) grid%paerlev=0
IF ( setinitval .EQ. 3 ) grid%cam_abs_dim1=0
IF ( setinitval .EQ. 3 ) grid%cam_abs_dim2=0
IF ( setinitval .EQ. 3 ) grid%lagday=0
IF ( setinitval .EQ. 3 ) grid%no_src_types=0
IF ( setinitval .EQ. 3 ) grid%alevsiz=0
IF ( setinitval .EQ. 3 ) grid%o3input=0
IF ( setinitval .EQ. 3 ) grid%aer_opt=0
IF ( setinitval .EQ. 3 ) grid%swint_opt=0
IF ( setinitval .EQ. 3 ) grid%aer_type=0
IF ( setinitval .EQ. 3 ) grid%aer_aod550_opt=0
IF ( setinitval .EQ. 3 ) grid%aer_angexp_opt=0
END SUBROUTINE allocs_11
