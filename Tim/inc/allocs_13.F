!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_13.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_13( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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

IF ( setinitval .EQ. 3 ) grid%obs_no_pbl_nudge_q=0
IF ( setinitval .EQ. 3 ) grid%obs_sfc_scheme_horiz=0
IF ( setinitval .EQ. 3 ) grid%obs_sfc_scheme_vert=0
IF ( setinitval .EQ. 3 ) grid%obs_max_sndng_gap=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr1_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr1_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr2_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr2_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr4_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr4_uv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr1_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr1_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr2_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr2_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr4_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr4_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr1_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr1_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr2_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr2_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullr4_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampr4_q=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezfullmin=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezrampmin=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_nudgezmax=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_sfcfact=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_sfcfacr=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_dpsmx=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_rinxy=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_rinsig=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_twindo=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_npfi=0
IF ( setinitval .EQ. 3 ) grid%obs_ionf=0
IF ( setinitval .EQ. 3 ) grid%obs_idynin=0
IF ( setinitval .EQ. 3 ) grid%obs_dtramp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%obs_prt_max=0
IF ( setinitval .EQ. 3 ) grid%obs_prt_freq=0
IF ( setinitval .EQ. 3 ) grid%obs_ipf_in4dob=.FALSE.
IF ( setinitval .EQ. 3 ) grid%obs_ipf_errob=.FALSE.
IF ( setinitval .EQ. 3 ) grid%obs_ipf_nudob=.FALSE.
IF ( setinitval .EQ. 3 ) grid%obs_ipf_init=.FALSE.
IF ( setinitval .EQ. 3 ) grid%obs_scl_neg_qv_innov=0
IF ( setinitval .EQ. 3 ) grid%scm_force=0
IF ( setinitval .EQ. 3 ) grid%scm_force_dx=initial_data_value
IF ( setinitval .EQ. 3 ) grid%num_force_layers=0
IF ( setinitval .EQ. 3 ) grid%scm_lu_index=0
IF ( setinitval .EQ. 3 ) grid%scm_isltyp=0
IF ( setinitval .EQ. 3 ) grid%scm_vegfra=initial_data_value
IF ( setinitval .EQ. 3 ) grid%scm_canwat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%scm_lat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%scm_lon=initial_data_value
IF ( setinitval .EQ. 3 ) grid%scm_th_t_tend=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_qv_t_tend=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_th_adv=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_wind_adv=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_qv_adv=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_ql_adv=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_vert_adv=.FALSE.
IF ( setinitval .EQ. 3 ) grid%num_force_soil_layers=0
IF ( setinitval .EQ. 3 ) grid%scm_soilt_force=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_soilq_force=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_force_th_largescale=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_force_qv_largescale=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_force_ql_largescale=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_force_wind_largescale=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scm_force_skintemp=0
IF ( setinitval .EQ. 3 ) grid%scm_force_flux=0
IF ( setinitval .EQ. 3 ) grid%dyn_opt=0
IF ( setinitval .EQ. 3 ) grid%rk_ord=0
IF ( setinitval .EQ. 3 ) grid%w_damping=0
IF ( setinitval .EQ. 3 ) grid%w_crit_cfl=initial_data_value
IF ( setinitval .EQ. 3 ) grid%zadvect_implicit=0
IF ( setinitval .EQ. 3 ) grid%diff_opt=0
IF ( setinitval .EQ. 3 ) grid%diff_opt_dfi=0
IF ( setinitval .EQ. 3 ) grid%km_opt=0
IF ( setinitval .EQ. 3 ) grid%km_opt_dfi=0
IF ( setinitval .EQ. 3 ) grid%damp_opt=0
IF ( setinitval .EQ. 3 ) grid%rad_nudge=0
IF ( setinitval .EQ. 3 ) grid%gwd_opt=0
IF ( setinitval .EQ. 3 ) grid%gwd_diags=0
IF ( setinitval .EQ. 3 ) grid%zdamp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%dampcoef=initial_data_value
IF ( setinitval .EQ. 3 ) grid%khdif=initial_data_value
IF ( setinitval .EQ. 3 ) grid%kvdif=initial_data_value
IF ( setinitval .EQ. 3 ) grid%diff_6th_factor=initial_data_value
IF ( setinitval .EQ. 3 ) grid%diff_6th_opt=0
IF ( setinitval .EQ. 3 ) grid%diff_6th_slopeopt=0
IF ( setinitval .EQ. 3 ) grid%diff_6th_thresh=initial_data_value
IF ( setinitval .EQ. 3 ) grid%use_theta_m=0
IF ( setinitval .EQ. 3 ) grid%use_q_diabatic=0
IF ( setinitval .EQ. 3 ) grid%c_s=initial_data_value
IF ( setinitval .EQ. 3 ) grid%c_k=initial_data_value
IF ( setinitval .EQ. 3 ) grid%smdiv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%emdiv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%epssm=initial_data_value
IF ( setinitval .EQ. 3 ) grid%non_hydrostatic=.FALSE.
IF ( setinitval .EQ. 3 ) grid%use_input_w=.FALSE.
IF ( setinitval .EQ. 3 ) grid%time_step_sound=0
IF ( setinitval .EQ. 3 ) grid%h_mom_adv_order=0
IF ( setinitval .EQ. 3 ) grid%v_mom_adv_order=0
IF ( setinitval .EQ. 3 ) grid%h_sca_adv_order=0
IF ( setinitval .EQ. 3 ) grid%v_sca_adv_order=0
IF ( setinitval .EQ. 3 ) grid%momentum_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%moist_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%moist_adv_dfi_opt=0
IF ( setinitval .EQ. 3 ) grid%chem_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%tracer_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%scalar_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%tke_adv_opt=0
IF ( setinitval .EQ. 3 ) grid%phi_adv_z=0
IF ( setinitval .EQ. 3 ) grid%moist_mix2_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%chem_mix2_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tracer_mix2_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scalar_mix2_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tke_mix2_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%moist_mix6_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%chem_mix6_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tracer_mix6_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%scalar_mix6_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tke_mix6_off=.FALSE.
IF ( setinitval .EQ. 3 ) grid%top_radiation=.FALSE.
IF ( setinitval .EQ. 3 ) grid%mix_isotropic=0
IF ( setinitval .EQ. 3 ) grid%mix_upper_bound=initial_data_value
IF ( setinitval .EQ. 3 ) grid%top_lid=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tke_upper_bound=initial_data_value
IF ( setinitval .EQ. 3 ) grid%tke_drag_coefficient=initial_data_value
IF ( setinitval .EQ. 3 ) grid%tke_heat_flux=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_coriolis=.FALSE.
IF ( setinitval .EQ. 3 ) grid%coriolis2d=.FALSE.
IF ( setinitval .EQ. 3 ) grid%mix_full_fields=.FALSE.
IF ( setinitval .EQ. 3 ) grid%base_pres=initial_data_value
IF ( setinitval .EQ. 3 ) grid%base_temp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%base_lapse=initial_data_value
IF ( setinitval .EQ. 3 ) grid%iso_temp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%base_pres_strat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%base_lapse_strat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%use_baseparam_fr_nml=.FALSE.
IF ( setinitval .EQ. 3 ) grid%fft_filter_lat=initial_data_value
IF ( setinitval .EQ. 3 ) grid%coupled_filtering=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pos_def=.FALSE.
IF ( setinitval .EQ. 3 ) grid%swap_pole_with_next_j=.FALSE.
IF ( setinitval .EQ. 3 ) grid%actual_distance_average=.FALSE.
IF ( setinitval .EQ. 3 ) grid%rotated_pole=.FALSE.
IF ( setinitval .EQ. 3 ) grid%do_coriolis=.FALSE.
IF ( setinitval .EQ. 3 ) grid%do_curvature=.FALSE.
IF ( setinitval .EQ. 3 ) grid%do_gradp=.FALSE.
IF ( setinitval .EQ. 3 ) grid%tracer_opt=0
IF ( setinitval .EQ. 3 ) grid%tenddiag=0
IF ( setinitval .EQ. 3 ) grid%spec_bdy_width=0
IF ( setinitval .EQ. 3 ) grid%spec_zone=0
IF ( setinitval .EQ. 3 ) grid%relax_zone=0
IF ( setinitval .EQ. 3 ) grid%specified=.FALSE.
IF ( setinitval .EQ. 3 ) grid%constant_bc=.FALSE.
IF ( setinitval .EQ. 3 ) grid%periodic_x=.FALSE.
IF ( setinitval .EQ. 3 ) grid%symmetric_xs=.FALSE.
IF ( setinitval .EQ. 3 ) grid%symmetric_xe=.FALSE.
IF ( setinitval .EQ. 3 ) grid%open_xs=.FALSE.
END SUBROUTINE allocs_13
