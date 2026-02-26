!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_7.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_7( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%dzs ) ) THEN 
  DEALLOCATE(grid%dzs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzs. ')
 endif
  NULLIFY(grid%dzs)
ENDIF
IF ( ASSOCIATED( grid%prho_gc ) ) THEN 
  DEALLOCATE(grid%prho_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prho_gc. ')
 endif
  NULLIFY(grid%prho_gc)
ENDIF
IF ( ASSOCIATED( grid%greenfrac ) ) THEN 
  DEALLOCATE(grid%greenfrac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%greenfrac. ')
 endif
  NULLIFY(grid%greenfrac)
ENDIF
IF ( ASSOCIATED( grid%icefrac_gc ) ) THEN 
  DEALLOCATE(grid%icefrac_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icefrac_gc. ')
 endif
  NULLIFY(grid%icefrac_gc)
ENDIF
IF ( ASSOCIATED( grid%qng_gc ) ) THEN 
  DEALLOCATE(grid%qng_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qng_gc. ')
 endif
  NULLIFY(grid%qng_gc)
ENDIF
IF ( ASSOCIATED( grid%pmaxw ) ) THEN 
  DEALLOCATE(grid%pmaxw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pmaxw. ')
 endif
  NULLIFY(grid%pmaxw)
ENDIF
IF ( ASSOCIATED( grid%u_g_tend ) ) THEN 
  DEALLOCATE(grid%u_g_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_g_tend. ')
 endif
  NULLIFY(grid%u_g_tend)
ENDIF
IF ( ASSOCIATED( grid%w_bxs ) ) THEN 
  DEALLOCATE(grid%w_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_bxs. ')
 endif
  NULLIFY(grid%w_bxs)
ENDIF
IF ( ASSOCIATED( grid%w_bxe ) ) THEN 
  DEALLOCATE(grid%w_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_bxe. ')
 endif
  NULLIFY(grid%w_bxe)
ENDIF
IF ( ASSOCIATED( grid%w_bys ) ) THEN 
  DEALLOCATE(grid%w_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_bys. ')
 endif
  NULLIFY(grid%w_bys)
ENDIF
IF ( ASSOCIATED( grid%w_bye ) ) THEN 
  DEALLOCATE(grid%w_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_bye. ')
 endif
  NULLIFY(grid%w_bye)
ENDIF
IF ( ASSOCIATED( grid%w_subs ) ) THEN 
  DEALLOCATE(grid%w_subs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_subs. ')
 endif
  NULLIFY(grid%w_subs)
ENDIF
IF ( ASSOCIATED( grid%th_phy_m_t0 ) ) THEN 
  DEALLOCATE(grid%th_phy_m_t0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_phy_m_t0. ')
 endif
  NULLIFY(grid%th_phy_m_t0)
ENDIF
IF ( ASSOCIATED( grid%th_upstream_y_tend ) ) THEN 
  DEALLOCATE(grid%th_upstream_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_upstream_y_tend. ')
 endif
  NULLIFY(grid%th_upstream_y_tend)
ENDIF
IF ( ASSOCIATED( grid%u_upstream_y_tend ) ) THEN 
  DEALLOCATE(grid%u_upstream_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_upstream_y_tend. ')
 endif
  NULLIFY(grid%u_upstream_y_tend)
ENDIF
IF ( ASSOCIATED( grid%ql_largescale_tend ) ) THEN 
  DEALLOCATE(grid%ql_largescale_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_largescale_tend. ')
 endif
  NULLIFY(grid%ql_largescale_tend)
ENDIF
IF ( ASSOCIATED( grid%t_soil_forcing_tend ) ) THEN 
  DEALLOCATE(grid%t_soil_forcing_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soil_forcing_tend. ')
 endif
  NULLIFY(grid%t_soil_forcing_tend)
ENDIF
IF ( ASSOCIATED( grid%mu_bxs ) ) THEN 
  DEALLOCATE(grid%mu_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_bxs. ')
 endif
  NULLIFY(grid%mu_bxs)
ENDIF
IF ( ASSOCIATED( grid%mu_bxe ) ) THEN 
  DEALLOCATE(grid%mu_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_bxe. ')
 endif
  NULLIFY(grid%mu_bxe)
ENDIF
IF ( ASSOCIATED( grid%mu_bys ) ) THEN 
  DEALLOCATE(grid%mu_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_bys. ')
 endif
  NULLIFY(grid%mu_bys)
ENDIF
IF ( ASSOCIATED( grid%mu_bye ) ) THEN 
  DEALLOCATE(grid%mu_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_bye. ')
 endif
  NULLIFY(grid%mu_bye)
ENDIF
IF ( ASSOCIATED( grid%muts ) ) THEN 
  DEALLOCATE(grid%muts,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%muts. ')
 endif
  NULLIFY(grid%muts)
ENDIF
IF ( ASSOCIATED( grid%gamv ) ) THEN 
  DEALLOCATE(grid%gamv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gamv. ')
 endif
  NULLIFY(grid%gamv)
ENDIF
IF ( ASSOCIATED( grid%rdzw ) ) THEN 
  DEALLOCATE(grid%rdzw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rdzw. ')
 endif
  NULLIFY(grid%rdzw)
ENDIF
IF ( ASSOCIATED( grid%q2 ) ) THEN 
  DEALLOCATE(grid%q2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2. ')
 endif
  NULLIFY(grid%q2)
ENDIF
IF ( ASSOCIATED( grid%imask_xstag ) ) THEN 
  DEALLOCATE(grid%imask_xstag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%imask_xstag. ')
 endif
  NULLIFY(grid%imask_xstag)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_btxs ) ) THEN 
  DEALLOCATE(grid%dfi_moist_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_btxs. ')
 endif
  NULLIFY(grid%dfi_moist_btxs)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_btxe ) ) THEN 
  DEALLOCATE(grid%dfi_moist_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_btxe. ')
 endif
  NULLIFY(grid%dfi_moist_btxe)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_btys ) ) THEN 
  DEALLOCATE(grid%dfi_moist_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_btys. ')
 endif
  NULLIFY(grid%dfi_moist_btys)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_btye ) ) THEN 
  DEALLOCATE(grid%dfi_moist_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_btye. ')
 endif
  NULLIFY(grid%dfi_moist_btye)
ENDIF
IF ( ASSOCIATED( grid%re_rain_gsfc ) ) THEN 
  DEALLOCATE(grid%re_rain_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_rain_gsfc. ')
 endif
  NULLIFY(grid%re_rain_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_graupel_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_graupel_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_graupel_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_graupel_gsfc)
ENDIF
IF ( ASSOCIATED( grid%gcx ) ) THEN 
  DEALLOCATE(grid%gcx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gcx. ')
 endif
  NULLIFY(grid%gcx)
ENDIF
IF ( ASSOCIATED( grid%sm100255 ) ) THEN 
  DEALLOCATE(grid%sm100255,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm100255. ')
 endif
  NULLIFY(grid%sm100255)
ENDIF
IF ( ASSOCIATED( grid%soilm020 ) ) THEN 
  DEALLOCATE(grid%soilm020,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm020. ')
 endif
  NULLIFY(grid%soilm020)
ENDIF
IF ( ASSOCIATED( grid%soilw040 ) ) THEN 
  DEALLOCATE(grid%soilw040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilw040. ')
 endif
  NULLIFY(grid%soilw040)
ENDIF
IF ( ASSOCIATED( grid%soilt160 ) ) THEN 
  DEALLOCATE(grid%soilt160,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt160. ')
 endif
  NULLIFY(grid%soilt160)
ENDIF
IF ( ASSOCIATED( grid%soilctop ) ) THEN 
  DEALLOCATE(grid%soilctop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilctop. ')
 endif
  NULLIFY(grid%soilctop)
ENDIF
IF ( ASSOCIATED( grid%ts_t ) ) THEN 
  DEALLOCATE(grid%ts_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_t. ')
 endif
  NULLIFY(grid%ts_t)
ENDIF
IF ( ASSOCIATED( grid%ts_v_profile ) ) THEN 
  DEALLOCATE(grid%ts_v_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_v_profile. ')
 endif
  NULLIFY(grid%ts_v_profile)
ENDIF
IF ( ASSOCIATED( grid%lb_urb2d ) ) THEN 
  DEALLOCATE(grid%lb_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lb_urb2d. ')
 endif
  NULLIFY(grid%lb_urb2d)
ENDIF
IF ( ASSOCIATED( grid%snowsi ) ) THEN 
  DEALLOCATE(grid%snowsi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowsi. ')
 endif
  NULLIFY(grid%snowsi)
ENDIF
IF ( ASSOCIATED( grid%vegfra ) ) THEN 
  DEALLOCATE(grid%vegfra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vegfra. ')
 endif
  NULLIFY(grid%vegfra)
ENDIF
IF ( ASSOCIATED( grid%dfi_rh ) ) THEN 
  DEALLOCATE(grid%dfi_rh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_rh. ')
 endif
  NULLIFY(grid%dfi_rh)
ENDIF
IF ( ASSOCIATED( grid%dfi_keepfr3dflag ) ) THEN 
  DEALLOCATE(grid%dfi_keepfr3dflag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_keepfr3dflag. ')
 endif
  NULLIFY(grid%dfi_keepfr3dflag)
ENDIF
IF ( ASSOCIATED( grid%xxxc_urb2d ) ) THEN 
  DEALLOCATE(grid%xxxc_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xxxc_urb2d. ')
 endif
  NULLIFY(grid%xxxc_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tgl_urb3d ) ) THEN 
  DEALLOCATE(grid%tgl_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgl_urb3d. ')
 endif
  NULLIFY(grid%tgl_urb3d)
ENDIF
IF ( ASSOCIATED( grid%tlev_urb3d ) ) THEN 
  DEALLOCATE(grid%tlev_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tlev_urb3d. ')
 endif
  NULLIFY(grid%tlev_urb3d)
ENDIF
IF ( ASSOCIATED( grid%sfwin2_urb3d ) ) THEN 
  DEALLOCATE(grid%sfwin2_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfwin2_urb3d. ')
 endif
  NULLIFY(grid%sfwin2_urb3d)
ENDIF
IF ( ASSOCIATED( grid%draingr_urb3d ) ) THEN 
  DEALLOCATE(grid%draingr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%draingr_urb3d. ')
 endif
  NULLIFY(grid%draingr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%chgr_sfcdif ) ) THEN 
  DEALLOCATE(grid%chgr_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chgr_sfcdif. ')
 endif
  NULLIFY(grid%chgr_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%smfr3d ) ) THEN 
  DEALLOCATE(grid%smfr3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smfr3d. ')
 endif
  NULLIFY(grid%smfr3d)
ENDIF
IF ( ASSOCIATED( grid%lai ) ) THEN 
  DEALLOCATE(grid%lai,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lai. ')
 endif
  NULLIFY(grid%lai)
ENDIF
IF ( ASSOCIATED( grid%fmsand_px ) ) THEN 
  DEALLOCATE(grid%fmsand_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmsand_px. ')
 endif
  NULLIFY(grid%fmsand_px)
ENDIF
IF ( ASSOCIATED( grid%pep_pbl ) ) THEN 
  DEALLOCATE(grid%pep_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pep_pbl. ')
 endif
  NULLIFY(grid%pep_pbl)
ENDIF
IF ( ASSOCIATED( grid%kpbl ) ) THEN 
  DEALLOCATE(grid%kpbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kpbl. ')
 endif
  NULLIFY(grid%kpbl)
ENDIF
IF ( ASSOCIATED( grid%detr_edkf ) ) THEN 
  DEALLOCATE(grid%detr_edkf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%detr_edkf. ')
 endif
  NULLIFY(grid%detr_edkf)
ENDIF
IF ( ASSOCIATED( grid%km_temf ) ) THEN 
  DEALLOCATE(grid%km_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%km_temf. ')
 endif
  NULLIFY(grid%km_temf)
ENDIF
IF ( ASSOCIATED( grid%lcl_temf ) ) THEN 
  DEALLOCATE(grid%lcl_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lcl_temf. ')
 endif
  NULLIFY(grid%lcl_temf)
ENDIF
IF ( ASSOCIATED( grid%cov ) ) THEN 
  DEALLOCATE(grid%cov,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cov. ')
 endif
  NULLIFY(grid%cov)
ENDIF
IF ( ASSOCIATED( grid%det_thl3d ) ) THEN 
  DEALLOCATE(grid%det_thl3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%det_thl3d. ')
 endif
  NULLIFY(grid%det_thl3d)
ENDIF
IF ( ASSOCIATED( grid%dvsfcg ) ) THEN 
  DEALLOCATE(grid%dvsfcg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dvsfcg. ')
 endif
  NULLIFY(grid%dvsfcg)
ENDIF
IF ( ASSOCIATED( grid%dtauy3d_ls ) ) THEN 
  DEALLOCATE(grid%dtauy3d_ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtauy3d_ls. ')
 endif
  NULLIFY(grid%dtauy3d_ls)
ENDIF
IF ( ASSOCIATED( grid%dvsfcg_ss ) ) THEN 
  DEALLOCATE(grid%dvsfcg_ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dvsfcg_ss. ')
 endif
  NULLIFY(grid%dvsfcg_ss)
ENDIF
IF ( ASSOCIATED( grid%ol4ls ) ) THEN 
  DEALLOCATE(grid%ol4ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol4ls. ')
 endif
  NULLIFY(grid%ol4ls)
ENDIF
IF ( ASSOCIATED( grid%ctopo2 ) ) THEN 
  DEALLOCATE(grid%ctopo2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ctopo2. ')
 endif
  NULLIFY(grid%ctopo2)
ENDIF
IF ( ASSOCIATED( grid%dl_u_bep ) ) THEN 
  DEALLOCATE(grid%dl_u_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dl_u_bep. ')
 endif
  NULLIFY(grid%dl_u_bep)
ENDIF
IF ( ASSOCIATED( grid%htop ) ) THEN 
  DEALLOCATE(grid%htop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%htop. ')
 endif
  NULLIFY(grid%htop)
ENDIF
IF ( ASSOCIATED( grid%cfrach ) ) THEN 
  DEALLOCATE(grid%cfrach,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cfrach. ')
 endif
  NULLIFY(grid%cfrach)
ENDIF
IF ( ASSOCIATED( grid%aeropcu ) ) THEN 
  DEALLOCATE(grid%aeropcu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aeropcu. ')
 endif
  NULLIFY(grid%aeropcu)
ENDIF
IF ( ASSOCIATED( grid%om_tmp ) ) THEN 
  DEALLOCATE(grid%om_tmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_tmp. ')
 endif
  NULLIFY(grid%om_tmp)
ENDIF
IF ( ASSOCIATED( grid%slopeez ) ) THEN 
  DEALLOCATE(grid%slopeez,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slopeez. ')
 endif
  NULLIFY(grid%slopeez)
ENDIF
IF ( ASSOCIATED( grid%qc_iu_cup ) ) THEN 
  DEALLOCATE(grid%qc_iu_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_iu_cup. ')
 endif
  NULLIFY(grid%qc_iu_cup)
ENDIF
IF ( ASSOCIATED( grid%fcvt_qi_to_pr_cup ) ) THEN 
  DEALLOCATE(grid%fcvt_qi_to_pr_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcvt_qi_to_pr_cup. ')
 endif
  NULLIFY(grid%fcvt_qi_to_pr_cup)
ENDIF
IF ( ASSOCIATED( grid%msfux ) ) THEN 
  DEALLOCATE(grid%msfux,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfux. ')
 endif
  NULLIFY(grid%msfux)
ENDIF
IF ( ASSOCIATED( grid%ht_input ) ) THEN 
  DEALLOCATE(grid%ht_input,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_input. ')
 endif
  NULLIFY(grid%ht_input)
ENDIF
IF ( ASSOCIATED( grid%v_base ) ) THEN 
  DEALLOCATE(grid%v_base,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_base. ')
 endif
  NULLIFY(grid%v_base)
ENDIF
IF ( ASSOCIATED( grid%acphyse ) ) THEN 
  DEALLOCATE(grid%acphyse,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphyse. ')
 endif
  NULLIFY(grid%acphyse)
ENDIF
IF ( ASSOCIATED( grid%slwdn ) ) THEN 
  DEALLOCATE(grid%slwdn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slwdn. ')
 endif
  NULLIFY(grid%slwdn)
ENDIF
IF ( ASSOCIATED( grid%rqrshten ) ) THEN 
  DEALLOCATE(grid%rqrshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqrshten. ')
 endif
  NULLIFY(grid%rqrshten)
ENDIF
IF ( ASSOCIATED( grid%cw_rad ) ) THEN 
  DEALLOCATE(grid%cw_rad,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cw_rad. ')
 endif
  NULLIFY(grid%cw_rad)
ENDIF
IF ( ASSOCIATED( grid%kdcldtop ) ) THEN 
  DEALLOCATE(grid%kdcldtop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kdcldtop. ')
 endif
  NULLIFY(grid%kdcldtop)
ENDIF
IF ( ASSOCIATED( grid%rqscuten ) ) THEN 
  DEALLOCATE(grid%rqscuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqscuten. ')
 endif
  NULLIFY(grid%rqscuten)
ENDIF
IF ( ASSOCIATED( grid%pratec ) ) THEN 
  DEALLOCATE(grid%pratec,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pratec. ')
 endif
  NULLIFY(grid%pratec)
ENDIF
IF ( ASSOCIATED( grid%refl_10cm ) ) THEN 
  DEALLOCATE(grid%refl_10cm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%refl_10cm. ')
 endif
  NULLIFY(grid%refl_10cm)
ENDIF
IF ( ASSOCIATED( grid%vmi3d_3 ) ) THEN 
  DEALLOCATE(grid%vmi3d_3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vmi3d_3. ')
 endif
  NULLIFY(grid%vmi3d_3)
ENDIF
IF ( ASSOCIATED( grid%udr_kf ) ) THEN 
  DEALLOCATE(grid%udr_kf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%udr_kf. ')
 endif
  NULLIFY(grid%udr_kf)
ENDIF
IF ( ASSOCIATED( grid%apr_capmi ) ) THEN 
  DEALLOCATE(grid%apr_capmi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_capmi. ')
 endif
  NULLIFY(grid%apr_capmi)
ENDIF
IF ( ASSOCIATED( grid%cugd_qvten ) ) THEN 
  DEALLOCATE(grid%cugd_qvten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cugd_qvten. ')
 endif
  NULLIFY(grid%cugd_qvten)
ENDIF
IF ( ASSOCIATED( grid%qi_cu ) ) THEN 
  DEALLOCATE(grid%qi_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qi_cu. ')
 endif
  NULLIFY(grid%qi_cu)
ENDIF
IF ( ASSOCIATED( grid%efig ) ) THEN 
  DEALLOCATE(grid%efig,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efig. ')
 endif
  NULLIFY(grid%efig)
ENDIF
IF ( ASSOCIATED( grid%qi_bl ) ) THEN 
  DEALLOCATE(grid%qi_bl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qi_bl. ')
 endif
  NULLIFY(grid%qi_bl)
ENDIF
IF ( ASSOCIATED( grid%ccldfra ) ) THEN 
  DEALLOCATE(grid%ccldfra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccldfra. ')
 endif
  NULLIFY(grid%ccldfra)
ENDIF
IF ( ASSOCIATED( grid%swddir ) ) THEN 
  DEALLOCATE(grid%swddir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddir. ')
 endif
  NULLIFY(grid%swddir)
ENDIF
IF ( ASSOCIATED( grid%bb ) ) THEN 
  DEALLOCATE(grid%bb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bb. ')
 endif
  NULLIFY(grid%bb)
ENDIF
IF ( ASSOCIATED( grid%t2max ) ) THEN 
  DEALLOCATE(grid%t2max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2max. ')
 endif
  NULLIFY(grid%t2max)
ENDIF
IF ( ASSOCIATED( grid%skintempmax ) ) THEN 
  DEALLOCATE(grid%skintempmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%skintempmax. ')
 endif
  NULLIFY(grid%skintempmax)
ENDIF
IF ( ASSOCIATED( grid%u10std ) ) THEN 
  DEALLOCATE(grid%u10std,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10std. ')
 endif
  NULLIFY(grid%u10std)
ENDIF
IF ( ASSOCIATED( grid%acswupt ) ) THEN 
  DEALLOCATE(grid%acswupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswupt. ')
 endif
  NULLIFY(grid%acswupt)
ENDIF
IF ( ASSOCIATED( grid%aclwupb ) ) THEN 
  DEALLOCATE(grid%aclwupb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwupb. ')
 endif
  NULLIFY(grid%aclwupb)
ENDIF
IF ( ASSOCIATED( grid%i_aclwupt ) ) THEN 
  DEALLOCATE(grid%i_aclwupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwupt. ')
 endif
  NULLIFY(grid%i_aclwupt)
ENDIF
IF ( ASSOCIATED( grid%swdntc ) ) THEN 
  DEALLOCATE(grid%swdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdntc. ')
 endif
  NULLIFY(grid%swdntc)
ENDIF
IF ( ASSOCIATED( grid%lwdntc ) ) THEN 
  DEALLOCATE(grid%lwdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdntc. ')
 endif
  NULLIFY(grid%lwdntc)
ENDIF
IF ( ASSOCIATED( grid%xlong_u ) ) THEN 
  DEALLOCATE(grid%xlong_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlong_u. ')
 endif
  NULLIFY(grid%xlong_u)
ENDIF
IF ( ASSOCIATED( grid%rublten ) ) THEN 
  DEALLOCATE(grid%rublten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rublten. ')
 endif
  NULLIFY(grid%rublten)
ENDIF
IF ( ASSOCIATED( grid%qsfc_mosaic ) ) THEN 
  DEALLOCATE(grid%qsfc_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsfc_mosaic. ')
 endif
  NULLIFY(grid%qsfc_mosaic)
ENDIF
IF ( ASSOCIATED( grid%znt_mosaic ) ) THEN 
  DEALLOCATE(grid%znt_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%znt_mosaic. ')
 endif
  NULLIFY(grid%znt_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tc_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%tc_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tc_urb2d_mosaic. ')
 endif
  NULLIFY(grid%tc_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%mosaic_cat_index ) ) THEN 
  DEALLOCATE(grid%mosaic_cat_index,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mosaic_cat_index. ')
 endif
  NULLIFY(grid%mosaic_cat_index)
ENDIF
IF ( ASSOCIATED( grid%tlag ) ) THEN 
  DEALLOCATE(grid%tlag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tlag. ')
 endif
  NULLIFY(grid%tlag)
ENDIF
IF ( ASSOCIATED( grid%flhc ) ) THEN 
  DEALLOCATE(grid%flhc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flhc. ')
 endif
  NULLIFY(grid%flhc)
ENDIF
IF ( ASSOCIATED( grid%snowc ) ) THEN 
  DEALLOCATE(grid%snowc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowc. ')
 endif
  NULLIFY(grid%snowc)
ENDIF
IF ( ASSOCIATED( grid%defor22 ) ) THEN 
  DEALLOCATE(grid%defor22,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%defor22. ')
 endif
  NULLIFY(grid%defor22)
ENDIF
IF ( ASSOCIATED( grid%u10_ndg_new ) ) THEN 
  DEALLOCATE(grid%u10_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10_ndg_new. ')
 endif
  NULLIFY(grid%u10_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%psl_ndg_new ) ) THEN 
  DEALLOCATE(grid%psl_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psl_ndg_new. ')
 endif
  NULLIFY(grid%psl_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%hfx_both ) ) THEN 
  DEALLOCATE(grid%hfx_both,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx_both. ')
 endif
  NULLIFY(grid%hfx_both)
ENDIF
IF ( ASSOCIATED( grid%w_up_max ) ) THEN 
  DEALLOCATE(grid%w_up_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_up_max. ')
 endif
  NULLIFY(grid%w_up_max)
ENDIF
IF ( ASSOCIATED( grid%tmoml ) ) THEN 
  DEALLOCATE(grid%tmoml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tmoml. ')
 endif
  NULLIFY(grid%tmoml)
ENDIF
IF ( ASSOCIATED( grid%track_qrain ) ) THEN 
  DEALLOCATE(grid%track_qrain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_qrain. ')
 endif
  NULLIFY(grid%track_qrain)
ENDIF
IF ( ASSOCIATED( grid%aqvcuten ) ) THEN 
  DEALLOCATE(grid%aqvcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aqvcuten. ')
 endif
  NULLIFY(grid%aqvcuten)
ENDIF
IF ( ASSOCIATED( grid%athratensw ) ) THEN 
  DEALLOCATE(grid%athratensw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athratensw. ')
 endif
  NULLIFY(grid%athratensw)
ENDIF
IF ( ASSOCIATED( grid%hailcast_diam_max ) ) THEN 
  DEALLOCATE(grid%hailcast_diam_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_diam_max. ')
 endif
  NULLIFY(grid%hailcast_diam_max)
ENDIF
IF ( ASSOCIATED( grid%ht_xxx ) ) THEN 
  DEALLOCATE(grid%ht_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_xxx. ')
 endif
  NULLIFY(grid%ht_xxx)
ENDIF
IF ( ASSOCIATED( grid%rqvfrten ) ) THEN 
  DEALLOCATE(grid%rqvfrten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvfrten. ')
 endif
  NULLIFY(grid%rqvfrten)
ENDIF
IF ( ASSOCIATED( grid%lfn_1 ) ) THEN 
  DEALLOCATE(grid%lfn_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_1. ')
 endif
  NULLIFY(grid%lfn_1)
ENDIF
IF ( ASSOCIATED( grid%fcanhfx ) ) THEN 
  DEALLOCATE(grid%fcanhfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcanhfx. ')
 endif
  NULLIFY(grid%fcanhfx)
ENDIF
IF ( ASSOCIATED( grid%rain_old ) ) THEN 
  DEALLOCATE(grid%rain_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rain_old. ')
 endif
  NULLIFY(grid%rain_old)
ENDIF
IF ( ASSOCIATED( grid%fz0 ) ) THEN 
  DEALLOCATE(grid%fz0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fz0. ')
 endif
  NULLIFY(grid%fz0)
ENDIF
IF ( ASSOCIATED( grid%fs_p_id ) ) THEN 
  DEALLOCATE(grid%fs_p_id,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_id. ')
 endif
  NULLIFY(grid%fs_p_id)
ENDIF
IF ( ASSOCIATED( grid%avgflx_rvm ) ) THEN 
  DEALLOCATE(grid%avgflx_rvm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_rvm. ')
 endif
  NULLIFY(grid%avgflx_rvm)
ENDIF
IF ( ASSOCIATED( grid%efu1 ) ) THEN 
  DEALLOCATE(grid%efu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efu1. ')
 endif
  NULLIFY(grid%efu1)
ENDIF
IF ( ASSOCIATED( grid%rt_tendf_stoch ) ) THEN 
  DEALLOCATE(grid%rt_tendf_stoch,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rt_tendf_stoch. ')
 endif
  NULLIFY(grid%rt_tendf_stoch)
ENDIF
IF ( ASSOCIATED( grid%sptforcs ) ) THEN 
  DEALLOCATE(grid%sptforcs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sptforcs. ')
 endif
  NULLIFY(grid%sptforcs)
ENDIF
IF ( ASSOCIATED( grid%spforcs4 ) ) THEN 
  DEALLOCATE(grid%spforcs4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs4. ')
 endif
  NULLIFY(grid%spforcs4)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_rand_pert ) ) THEN 
  DEALLOCATE(grid%iseedarr_rand_pert,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_rand_pert. ')
 endif
  NULLIFY(grid%iseedarr_rand_pert)
ENDIF
IF ( ASSOCIATED( grid%sp_amp3d ) ) THEN 
  DEALLOCATE(grid%sp_amp3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp3d. ')
 endif
  NULLIFY(grid%sp_amp3d)
ENDIF
IF ( ASSOCIATED( grid%wpert2d ) ) THEN 
  DEALLOCATE(grid%wpert2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wpert2d. ')
 endif
  NULLIFY(grid%wpert2d)
ENDIF
IF ( ASSOCIATED( grid%fzsntzm ) ) THEN 
  DEALLOCATE(grid%fzsntzm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fzsntzm. ')
 endif
  NULLIFY(grid%fzsntzm)
ENDIF
IF ( ASSOCIATED( grid%cape ) ) THEN 
  DEALLOCATE(grid%cape,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cape. ')
 endif
  NULLIFY(grid%cape)
ENDIF
IF ( ASSOCIATED( grid%zmicvd ) ) THEN 
  DEALLOCATE(grid%zmicvd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmicvd. ')
 endif
  NULLIFY(grid%zmicvd)
ENDIF
IF ( ASSOCIATED( grid%jt2d ) ) THEN 
  DEALLOCATE(grid%jt2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%jt2d. ')
 endif
  NULLIFY(grid%jt2d)
ENDIF
IF ( ASSOCIATED( grid%rprdsh ) ) THEN 
  DEALLOCATE(grid%rprdsh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rprdsh. ')
 endif
  NULLIFY(grid%rprdsh)
ENDIF
IF ( ASSOCIATED( grid%qvten_cu ) ) THEN 
  DEALLOCATE(grid%qvten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qvten_cu. ')
 endif
  NULLIFY(grid%qvten_cu)
ENDIF
IF ( ASSOCIATED( grid%ppen_cu ) ) THEN 
  DEALLOCATE(grid%ppen_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ppen_cu. ')
 endif
  NULLIFY(grid%ppen_cu)
ENDIF
IF ( ASSOCIATED( grid%riwp_cu ) ) THEN 
  DEALLOCATE(grid%riwp_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%riwp_cu. ')
 endif
  NULLIFY(grid%riwp_cu)
ENDIF
IF ( ASSOCIATED( grid%vu_emf_cu ) ) THEN 
  DEALLOCATE(grid%vu_emf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vu_emf_cu. ')
 endif
  NULLIFY(grid%vu_emf_cu)
ENDIF
IF ( ASSOCIATED( grid%qsten_cu ) ) THEN 
  DEALLOCATE(grid%qsten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsten_cu. ')
 endif
  NULLIFY(grid%qsten_cu)
ENDIF
IF ( ASSOCIATED( grid%bogtop_cu ) ) THEN 
  DEALLOCATE(grid%bogtop_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bogtop_cu. ')
 endif
  NULLIFY(grid%bogtop_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_shcu_cu ) ) THEN 
  DEALLOCATE(grid%limit_shcu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_shcu_cu. ')
 endif
  NULLIFY(grid%limit_shcu_cu)
ENDIF
IF ( ASSOCIATED( grid%cldfra_old_mp ) ) THEN 
  DEALLOCATE(grid%cldfra_old_mp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_old_mp. ')
 endif
  NULLIFY(grid%cldfra_old_mp)
ENDIF
IF ( ASSOCIATED( grid%sabg ) ) THEN 
  DEALLOCATE(grid%sabg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sabg. ')
 endif
  NULLIFY(grid%sabg)
ENDIF
IF ( ASSOCIATED( grid%t_veg24 ) ) THEN 
  DEALLOCATE(grid%t_veg24,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_veg24. ')
 endif
  NULLIFY(grid%t_veg24)
ENDIF
IF ( ASSOCIATED( grid%t2m_max ) ) THEN 
  DEALLOCATE(grid%t2m_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2m_max. ')
 endif
  NULLIFY(grid%t2m_max)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq3 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq3. ')
 endif
  NULLIFY(grid%h2osoi_liq3)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice_s5 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice_s5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice_s5. ')
 endif
  NULLIFY(grid%h2osoi_ice_s5)
ENDIF
IF ( ASSOCIATED( grid%t_soisno_s2 ) ) THEN 
  DEALLOCATE(grid%t_soisno_s2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno_s2. ')
 endif
  NULLIFY(grid%t_soisno_s2)
ENDIF
IF ( ASSOCIATED( grid%t_soisno9 ) ) THEN 
  DEALLOCATE(grid%t_soisno9,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno9. ')
 endif
  NULLIFY(grid%t_soisno9)
ENDIF
IF ( ASSOCIATED( grid%t_lake1 ) ) THEN 
  DEALLOCATE(grid%t_lake1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake1. ')
 endif
  NULLIFY(grid%t_lake1)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol3 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol3. ')
 endif
  NULLIFY(grid%h2osoi_vol3)
ENDIF
IF ( ASSOCIATED( grid%q2subgrid ) ) THEN 
  DEALLOCATE(grid%q2subgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2subgrid. ')
 endif
  NULLIFY(grid%q2subgrid)
ENDIF
IF ( ASSOCIATED( grid%t_lake3d ) ) THEN 
  DEALLOCATE(grid%t_lake3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake3d. ')
 endif
  NULLIFY(grid%t_lake3d)
ENDIF
IF ( ASSOCIATED( grid%csol3d ) ) THEN 
  DEALLOCATE(grid%csol3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%csol3d. ')
 endif
  NULLIFY(grid%csol3d)
ENDIF
IF ( ASSOCIATED( grid%ssibxdd ) ) THEN 
  DEALLOCATE(grid%ssibxdd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssibxdd. ')
 endif
  NULLIFY(grid%ssibxdd)
ENDIF
IF ( ASSOCIATED( grid%ssib_ldn ) ) THEN 
  DEALLOCATE(grid%ssib_ldn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_ldn. ')
 endif
  NULLIFY(grid%ssib_ldn)
ENDIF
IF ( ASSOCIATED( grid%snowdepth ) ) THEN 
  DEALLOCATE(grid%snowdepth,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowdepth. ')
 endif
  NULLIFY(grid%snowdepth)
ENDIF
IF ( ASSOCIATED( grid%blo1 ) ) THEN 
  DEALLOCATE(grid%blo1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%blo1. ')
 endif
  NULLIFY(grid%blo1)
ENDIF
IF ( ASSOCIATED( grid%blo2 ) ) THEN 
  DEALLOCATE(grid%blo2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%blo2. ')
 endif
  NULLIFY(grid%blo2)
ENDIF
IF ( ASSOCIATED( grid%blo3 ) ) THEN 
  DEALLOCATE(grid%blo3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%blo3. ')
 endif
  NULLIFY(grid%blo3)
ENDIF
IF ( ASSOCIATED( grid%blo4 ) ) THEN 
  DEALLOCATE(grid%blo4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%blo4. ')
 endif
  NULLIFY(grid%blo4)
ENDIF
IF ( ASSOCIATED( grid%sneqvoxy ) ) THEN 
  DEALLOCATE(grid%sneqvoxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sneqvoxy. ')
 endif
  NULLIFY(grid%sneqvoxy)
ENDIF
IF ( ASSOCIATED( grid%lfmassxy ) ) THEN 
  DEALLOCATE(grid%lfmassxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfmassxy. ')
 endif
  NULLIFY(grid%lfmassxy)
ENDIF
IF ( ASSOCIATED( grid%tradxy ) ) THEN 
  DEALLOCATE(grid%tradxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tradxy. ')
 endif
  NULLIFY(grid%tradxy)
ENDIF
IF ( ASSOCIATED( grid%firaxy ) ) THEN 
  DEALLOCATE(grid%firaxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%firaxy. ')
 endif
  NULLIFY(grid%firaxy)
ENDIF
IF ( ASSOCIATED( grid%chbxy ) ) THEN 
  DEALLOCATE(grid%chbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chbxy. ')
 endif
  NULLIFY(grid%chbxy)
ENDIF
IF ( ASSOCIATED( grid%evcxy ) ) THEN 
  DEALLOCATE(grid%evcxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evcxy. ')
 endif
  NULLIFY(grid%evcxy)
ENDIF
IF ( ASSOCIATED( grid%qrfxy ) ) THEN 
  DEALLOCATE(grid%qrfxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qrfxy. ')
 endif
  NULLIFY(grid%qrfxy)
ENDIF
IF ( ASSOCIATED( grid%rechclim ) ) THEN 
  DEALLOCATE(grid%rechclim,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rechclim. ')
 endif
  NULLIFY(grid%rechclim)
ENDIF
IF ( ASSOCIATED( grid%qevacxy ) ) THEN 
  DEALLOCATE(grid%qevacxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qevacxy. ')
 endif
  NULLIFY(grid%qevacxy)
ENDIF
IF ( ASSOCIATED( grid%fpicexy ) ) THEN 
  DEALLOCATE(grid%fpicexy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fpicexy. ')
 endif
  NULLIFY(grid%fpicexy)
ENDIF
IF ( ASSOCIATED( grid%acevac ) ) THEN 
  DEALLOCATE(grid%acevac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acevac. ')
 endif
  NULLIFY(grid%acevac)
ENDIF
IF ( ASSOCIATED( grid%acedir ) ) THEN 
  DEALLOCATE(grid%acedir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acedir. ')
 endif
  NULLIFY(grid%acedir)
ENDIF
IF ( ASSOCIATED( grid%acsnsub ) ) THEN 
  DEALLOCATE(grid%acsnsub,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnsub. ')
 endif
  NULLIFY(grid%acsnsub)
ENDIF
IF ( ASSOCIATED( grid%acirg ) ) THEN 
  DEALLOCATE(grid%acirg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acirg. ')
 endif
  NULLIFY(grid%acirg)
ENDIF
IF ( ASSOCIATED( grid%acswuplsm ) ) THEN 
  DEALLOCATE(grid%acswuplsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswuplsm. ')
 endif
  NULLIFY(grid%acswuplsm)
ENDIF
IF ( ASSOCIATED( grid%acc_qseva ) ) THEN 
  DEALLOCATE(grid%acc_qseva,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_qseva. ')
 endif
  NULLIFY(grid%acc_qseva)
ENDIF
IF ( ASSOCIATED( grid%planting ) ) THEN 
  DEALLOCATE(grid%planting,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%planting. ')
 endif
  NULLIFY(grid%planting)
ENDIF
IF ( ASSOCIATED( grid%irnumsi ) ) THEN 
  DEALLOCATE(grid%irnumsi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irnumsi. ')
 endif
  NULLIFY(grid%irnumsi)
ENDIF
IF ( ASSOCIATED( grid%kext_qic ) ) THEN 
  DEALLOCATE(grid%kext_qic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qic. ')
 endif
  NULLIFY(grid%kext_qic)
ENDIF
IF ( ASSOCIATED( grid%height ) ) THEN 
  DEALLOCATE(grid%height,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%height. ')
 endif
  NULLIFY(grid%height)
ENDIF
IF ( ASSOCIATED( grid%echotop ) ) THEN 
  DEALLOCATE(grid%echotop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%echotop. ')
 endif
  NULLIFY(grid%echotop)
ENDIF
IF ( ASSOCIATED( grid%afwa_wchill ) ) THEN 
  DEALLOCATE(grid%afwa_wchill,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_wchill. ')
 endif
  NULLIFY(grid%afwa_wchill)
ENDIF
IF ( ASSOCIATED( grid%afwa_snow ) ) THEN 
  DEALLOCATE(grid%afwa_snow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_snow. ')
 endif
  NULLIFY(grid%afwa_snow)
ENDIF
IF ( ASSOCIATED( grid%afwa_cin_mu ) ) THEN 
  DEALLOCATE(grid%afwa_cin_mu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cin_mu. ')
 endif
  NULLIFY(grid%afwa_cin_mu)
ENDIF
IF ( ASSOCIATED( grid%pmsl_mean ) ) THEN 
  DEALLOCATE(grid%pmsl_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pmsl_mean. ')
 endif
  NULLIFY(grid%pmsl_mean)
ENDIF
IF ( ASSOCIATED( grid%swupt_mean ) ) THEN 
  DEALLOCATE(grid%swupt_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupt_mean. ')
 endif
  NULLIFY(grid%swupt_mean)
ENDIF
IF ( ASSOCIATED( grid%v10_diurn ) ) THEN 
  DEALLOCATE(grid%v10_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10_diurn. ')
 endif
  NULLIFY(grid%v10_diurn)
ENDIF
IF ( ASSOCIATED( grid%lwupb_dtmp ) ) THEN 
  DEALLOCATE(grid%lwupb_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupb_dtmp. ')
 endif
  NULLIFY(grid%lwupb_dtmp)
ENDIF
IF ( ASSOCIATED( grid%elecx ) ) THEN 
  DEALLOCATE(grid%elecx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%elecx. ')
 endif
  NULLIFY(grid%elecx)
ENDIF
IF ( ASSOCIATED( grid%c1h ) ) THEN 
  DEALLOCATE(grid%c1h,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c1h. ')
 endif
  NULLIFY(grid%c1h)
ENDIF
IF ( ASSOCIATED( grid%p_wif_apr ) ) THEN 
  DEALLOCATE(grid%p_wif_apr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_apr. ')
 endif
  NULLIFY(grid%p_wif_apr)
ENDIF
IF ( ASSOCIATED( grid%w_wif_mar ) ) THEN 
  DEALLOCATE(grid%w_wif_mar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_mar. ')
 endif
  NULLIFY(grid%w_wif_mar)
ENDIF
IF ( ASSOCIATED( grid%i_wif_feb ) ) THEN 
  DEALLOCATE(grid%i_wif_feb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_feb. ')
 endif
  NULLIFY(grid%i_wif_feb)
ENDIF
IF ( ASSOCIATED( grid%b_wif_jan ) ) THEN 
  DEALLOCATE(grid%b_wif_jan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_jan. ')
 endif
  NULLIFY(grid%b_wif_jan)
ENDIF
IF ( ASSOCIATED( grid%potential_t ) ) THEN 
  DEALLOCATE(grid%potential_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%potential_t. ')
 endif
  NULLIFY(grid%potential_t)
ENDIF
IF ( ASSOCIATED( grid%iwp_tot ) ) THEN 
  DEALLOCATE(grid%iwp_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iwp_tot. ')
 endif
  NULLIFY(grid%iwp_tot)
ENDIF
IF ( ASSOCIATED( grid%cbaseht ) ) THEN 
  DEALLOCATE(grid%cbaseht,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cbaseht. ')
 endif
  NULLIFY(grid%cbaseht)
ENDIF
IF ( ASSOCIATED( grid%ts_wp_sum ) ) THEN 
  DEALLOCATE(grid%ts_wp_sum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_wp_sum. ')
 endif
  NULLIFY(grid%ts_wp_sum)
ENDIF
IF ( ASSOCIATED( grid%ts_tau_qc_tot ) ) THEN 
  DEALLOCATE(grid%ts_tau_qc_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tau_qc_tot. ')
 endif
  NULLIFY(grid%ts_tau_qc_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_swdownc ) ) THEN 
  DEALLOCATE(grid%ts_swdownc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swdownc. ')
 endif
  NULLIFY(grid%ts_swdownc)
ENDIF
IF ( ASSOCIATED( grid%s_zl ) ) THEN 
  DEALLOCATE(grid%s_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%s_zl. ')
 endif
  NULLIFY(grid%s_zl)
ENDIF
IF ( ASSOCIATED( grid%rswdir_htop_vis ) ) THEN 
  DEALLOCATE(grid%rswdir_htop_vis,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rswdir_htop_vis. ')
 endif
  NULLIFY(grid%rswdir_htop_vis)
ENDIF
IF ( ASSOCIATED( grid%mcm_t_tend ) ) THEN 
  DEALLOCATE(grid%mcm_t_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_t_tend. ')
 endif
  NULLIFY(grid%mcm_t_tend)
ENDIF
IF ( ASSOCIATED( grid%www ) ) THEN 
  DEALLOCATE(grid%www,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%www. ')
 endif
  NULLIFY(grid%www)
ENDIF
END SUBROUTINE deallocs_7
!ENDOFREGISTRYGENERATEDINCLUDE
