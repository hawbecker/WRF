!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_10.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_10( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%traj_k ) ) THEN 
  DEALLOCATE(grid%traj_k,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%traj_k. ')
 endif
  NULLIFY(grid%traj_k)
ENDIF
IF ( ASSOCIATED( grid%ht_gc ) ) THEN 
  DEALLOCATE(grid%ht_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_gc. ')
 endif
  NULLIFY(grid%ht_gc)
ENDIF
IF ( ASSOCIATED( grid%pd_gc ) ) THEN 
  DEALLOCATE(grid%pd_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pd_gc. ')
 endif
  NULLIFY(grid%pd_gc)
ENDIF
IF ( ASSOCIATED( grid%qc_gc ) ) THEN 
  DEALLOCATE(grid%qc_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_gc. ')
 endif
  NULLIFY(grid%qc_gc)
ENDIF
IF ( ASSOCIATED( grid%qntemp2 ) ) THEN 
  DEALLOCATE(grid%qntemp2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qntemp2. ')
 endif
  NULLIFY(grid%qntemp2)
ENDIF
IF ( ASSOCIATED( grid%ptropnn ) ) THEN 
  DEALLOCATE(grid%ptropnn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ptropnn. ')
 endif
  NULLIFY(grid%ptropnn)
ENDIF
IF ( ASSOCIATED( grid%u_btxs ) ) THEN 
  DEALLOCATE(grid%u_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_btxs. ')
 endif
  NULLIFY(grid%u_btxs)
ENDIF
IF ( ASSOCIATED( grid%u_btxe ) ) THEN 
  DEALLOCATE(grid%u_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_btxe. ')
 endif
  NULLIFY(grid%u_btxe)
ENDIF
IF ( ASSOCIATED( grid%u_btys ) ) THEN 
  DEALLOCATE(grid%u_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_btys. ')
 endif
  NULLIFY(grid%u_btys)
ENDIF
IF ( ASSOCIATED( grid%u_btye ) ) THEN 
  DEALLOCATE(grid%u_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_btye. ')
 endif
  NULLIFY(grid%u_btye)
ENDIF
IF ( ASSOCIATED( grid%v_btxs ) ) THEN 
  DEALLOCATE(grid%v_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_btxs. ')
 endif
  NULLIFY(grid%v_btxs)
ENDIF
IF ( ASSOCIATED( grid%v_btxe ) ) THEN 
  DEALLOCATE(grid%v_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_btxe. ')
 endif
  NULLIFY(grid%v_btxe)
ENDIF
IF ( ASSOCIATED( grid%v_btys ) ) THEN 
  DEALLOCATE(grid%v_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_btys. ')
 endif
  NULLIFY(grid%v_btys)
ENDIF
IF ( ASSOCIATED( grid%v_btye ) ) THEN 
  DEALLOCATE(grid%v_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_btye. ')
 endif
  NULLIFY(grid%v_btye)
ENDIF
IF ( ASSOCIATED( grid%rw ) ) THEN 
  DEALLOCATE(grid%rw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rw. ')
 endif
  NULLIFY(grid%rw)
ENDIF
IF ( ASSOCIATED( grid%ph_bxs ) ) THEN 
  DEALLOCATE(grid%ph_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_bxs. ')
 endif
  NULLIFY(grid%ph_bxs)
ENDIF
IF ( ASSOCIATED( grid%ph_bxe ) ) THEN 
  DEALLOCATE(grid%ph_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_bxe. ')
 endif
  NULLIFY(grid%ph_bxe)
ENDIF
IF ( ASSOCIATED( grid%ph_bys ) ) THEN 
  DEALLOCATE(grid%ph_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_bys. ')
 endif
  NULLIFY(grid%ph_bys)
ENDIF
IF ( ASSOCIATED( grid%ph_bye ) ) THEN 
  DEALLOCATE(grid%ph_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_bye. ')
 endif
  NULLIFY(grid%ph_bye)
ENDIF
IF ( ASSOCIATED( grid%t_btxs ) ) THEN 
  DEALLOCATE(grid%t_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_btxs. ')
 endif
  NULLIFY(grid%t_btxs)
ENDIF
IF ( ASSOCIATED( grid%t_btxe ) ) THEN 
  DEALLOCATE(grid%t_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_btxe. ')
 endif
  NULLIFY(grid%t_btxe)
ENDIF
IF ( ASSOCIATED( grid%t_btys ) ) THEN 
  DEALLOCATE(grid%t_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_btys. ')
 endif
  NULLIFY(grid%t_btys)
ENDIF
IF ( ASSOCIATED( grid%t_btye ) ) THEN 
  DEALLOCATE(grid%t_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_btye. ')
 endif
  NULLIFY(grid%t_btye)
ENDIF
IF ( ASSOCIATED( grid%qv_upstream_y ) ) THEN 
  DEALLOCATE(grid%qv_upstream_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_upstream_y. ')
 endif
  NULLIFY(grid%qv_upstream_y)
ENDIF
IF ( ASSOCIATED( grid%v_upstream_y ) ) THEN 
  DEALLOCATE(grid%v_upstream_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_upstream_y. ')
 endif
  NULLIFY(grid%v_upstream_y)
ENDIF
IF ( ASSOCIATED( grid%v_largescale ) ) THEN 
  DEALLOCATE(grid%v_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_largescale. ')
 endif
  NULLIFY(grid%v_largescale)
ENDIF
IF ( ASSOCIATED( grid%tau_soil ) ) THEN 
  DEALLOCATE(grid%tau_soil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_soil. ')
 endif
  NULLIFY(grid%tau_soil)
ENDIF
IF ( ASSOCIATED( grid%mub_fine ) ) THEN 
  DEALLOCATE(grid%mub_fine,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mub_fine. ')
 endif
  NULLIFY(grid%mub_fine)
ENDIF
IF ( ASSOCIATED( grid%elmin ) ) THEN 
  DEALLOCATE(grid%elmin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%elmin. ')
 endif
  NULLIFY(grid%elmin)
ENDIF
IF ( ASSOCIATED( grid%rdnw ) ) THEN 
  DEALLOCATE(grid%rdnw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rdnw. ')
 endif
  NULLIFY(grid%rdnw)
ENDIF
IF ( ASSOCIATED( grid%psfc ) ) THEN 
  DEALLOCATE(grid%psfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc. ')
 endif
  NULLIFY(grid%psfc)
ENDIF
IF ( ASSOCIATED( grid%power ) ) THEN 
  DEALLOCATE(grid%power,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%power. ')
 endif
  NULLIFY(grid%power)
ENDIF
IF ( ASSOCIATED( grid%qnwfa2d ) ) THEN 
  DEALLOCATE(grid%qnwfa2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnwfa2d. ')
 endif
  NULLIFY(grid%qnwfa2d)
ENDIF
IF ( ASSOCIATED( grid%re_graupel_gsfc ) ) THEN 
  DEALLOCATE(grid%re_graupel_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_graupel_gsfc. ')
 endif
  NULLIFY(grid%re_graupel_gsfc)
ENDIF
IF ( ASSOCIATED( grid%soil_levels ) ) THEN 
  DEALLOCATE(grid%soil_levels,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soil_levels. ')
 endif
  NULLIFY(grid%soil_levels)
ENDIF
IF ( ASSOCIATED( grid%st028100 ) ) THEN 
  DEALLOCATE(grid%st028100,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st028100. ')
 endif
  NULLIFY(grid%st028100)
ENDIF
IF ( ASSOCIATED( grid%soilm300 ) ) THEN 
  DEALLOCATE(grid%soilm300,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm300. ')
 endif
  NULLIFY(grid%soilm300)
ENDIF
IF ( ASSOCIATED( grid%st000010 ) ) THEN 
  DEALLOCATE(grid%st000010,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st000010. ')
 endif
  NULLIFY(grid%st000010)
ENDIF
IF ( ASSOCIATED( grid%toposlpx ) ) THEN 
  DEALLOCATE(grid%toposlpx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%toposlpx. ')
 endif
  NULLIFY(grid%toposlpx)
ENDIF
IF ( ASSOCIATED( grid%vegcat ) ) THEN 
  DEALLOCATE(grid%vegcat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vegcat. ')
 endif
  NULLIFY(grid%vegcat)
ENDIF
IF ( ASSOCIATED( grid%ts_gsw ) ) THEN 
  DEALLOCATE(grid%ts_gsw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_gsw. ')
 endif
  NULLIFY(grid%ts_gsw)
ENDIF
IF ( ASSOCIATED( grid%ts_th_profile ) ) THEN 
  DEALLOCATE(grid%ts_th_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_th_profile. ')
 endif
  NULLIFY(grid%ts_th_profile)
ENDIF
IF ( ASSOCIATED( grid%stdh_urb2d ) ) THEN 
  DEALLOCATE(grid%stdh_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%stdh_urb2d. ')
 endif
  NULLIFY(grid%stdh_urb2d)
ENDIF
IF ( ASSOCIATED( grid%soldrain ) ) THEN 
  DEALLOCATE(grid%soldrain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soldrain. ')
 endif
  NULLIFY(grid%soldrain)
ENDIF
IF ( ASSOCIATED( grid%acgrdflx ) ) THEN 
  DEALLOCATE(grid%acgrdflx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acgrdflx. ')
 endif
  NULLIFY(grid%acgrdflx)
ENDIF
IF ( ASSOCIATED( grid%dfi_mu ) ) THEN 
  DEALLOCATE(grid%dfi_mu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_mu. ')
 endif
  NULLIFY(grid%dfi_mu)
ENDIF
IF ( ASSOCIATED( grid%dfi_alt ) ) THEN 
  DEALLOCATE(grid%dfi_alt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_alt. ')
 endif
  NULLIFY(grid%dfi_alt)
ENDIF
IF ( ASSOCIATED( grid%tgr_urb2d ) ) THEN 
  DEALLOCATE(grid%tgr_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgr_urb2d. ')
 endif
  NULLIFY(grid%tgr_urb2d)
ENDIF
IF ( ASSOCIATED( grid%drelb_urb2d ) ) THEN 
  DEALLOCATE(grid%drelb_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%drelb_urb2d. ')
 endif
  NULLIFY(grid%drelb_urb2d)
ENDIF
IF ( ASSOCIATED( grid%g_urb2d ) ) THEN 
  DEALLOCATE(grid%g_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%g_urb2d. ')
 endif
  NULLIFY(grid%g_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tw2lev_urb3d ) ) THEN 
  DEALLOCATE(grid%tw2lev_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tw2lev_urb3d. ')
 endif
  NULLIFY(grid%tw2lev_urb3d)
ENDIF
IF ( ASSOCIATED( grid%sfr_urb3d ) ) THEN 
  DEALLOCATE(grid%sfr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfr_urb3d. ')
 endif
  NULLIFY(grid%sfr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%dgr_urb3d ) ) THEN 
  DEALLOCATE(grid%dgr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dgr_urb3d. ')
 endif
  NULLIFY(grid%dgr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%swvisdif ) ) THEN 
  DEALLOCATE(grid%swvisdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swvisdif. ')
 endif
  NULLIFY(grid%swvisdif)
ENDIF
IF ( ASSOCIATED( grid%q2obs ) ) THEN 
  DEALLOCATE(grid%q2obs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2obs. ')
 endif
  NULLIFY(grid%q2obs)
ENDIF
IF ( ASSOCIATED( grid%fm ) ) THEN 
  DEALLOCATE(grid%fm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fm. ')
 endif
  NULLIFY(grid%fm)
ENDIF
IF ( ASSOCIATED( grid%ct ) ) THEN 
  DEALLOCATE(grid%ct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ct. ')
 endif
  NULLIFY(grid%ct)
ENDIF
IF ( ASSOCIATED( grid%akpbl ) ) THEN 
  DEALLOCATE(grid%akpbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%akpbl. ')
 endif
  NULLIFY(grid%akpbl)
ENDIF
IF ( ASSOCIATED( grid%rv_up ) ) THEN 
  DEALLOCATE(grid%rv_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv_up. ')
 endif
  NULLIFY(grid%rv_up)
ENDIF
IF ( ASSOCIATED( grid%uw_temf ) ) THEN 
  DEALLOCATE(grid%uw_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uw_temf. ')
 endif
  NULLIFY(grid%uw_temf)
ENDIF
IF ( ASSOCIATED( grid%wm_temf ) ) THEN 
  DEALLOCATE(grid%wm_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wm_temf. ')
 endif
  NULLIFY(grid%wm_temf)
ENDIF
IF ( ASSOCIATED( grid%ch ) ) THEN 
  DEALLOCATE(grid%ch,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ch. ')
 endif
  NULLIFY(grid%ch)
ENDIF
IF ( ASSOCIATED( grid%ktop_plume ) ) THEN 
  DEALLOCATE(grid%ktop_plume,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ktop_plume. ')
 endif
  NULLIFY(grid%ktop_plume)
ENDIF
IF ( ASSOCIATED( grid%oa1 ) ) THEN 
  DEALLOCATE(grid%oa1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa1. ')
 endif
  NULLIFY(grid%oa1)
ENDIF
IF ( ASSOCIATED( grid%dtaux3d_ss ) ) THEN 
  DEALLOCATE(grid%dtaux3d_ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtaux3d_ss. ')
 endif
  NULLIFY(grid%dtaux3d_ss)
ENDIF
IF ( ASSOCIATED( grid%var2dls ) ) THEN 
  DEALLOCATE(grid%var2dls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%var2dls. ')
 endif
  NULLIFY(grid%var2dls)
ENDIF
IF ( ASSOCIATED( grid%oa1ss ) ) THEN 
  DEALLOCATE(grid%oa1ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa1ss. ')
 endif
  NULLIFY(grid%oa1ss)
ENDIF
IF ( ASSOCIATED( grid%a_t_bep ) ) THEN 
  DEALLOCATE(grid%a_t_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%a_t_bep. ')
 endif
  NULLIFY(grid%a_t_bep)
ENDIF
IF ( ASSOCIATED( grid%tke_pbl ) ) THEN 
  DEALLOCATE(grid%tke_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tke_pbl. ')
 endif
  NULLIFY(grid%tke_pbl)
ENDIF
IF ( ASSOCIATED( grid%hbotr ) ) THEN 
  DEALLOCATE(grid%hbotr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hbotr. ')
 endif
  NULLIFY(grid%hbotr)
ENDIF
IF ( ASSOCIATED( grid%acfrcv ) ) THEN 
  DEALLOCATE(grid%acfrcv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acfrcv. ')
 endif
  NULLIFY(grid%acfrcv)
ENDIF
IF ( ASSOCIATED( grid%ozmixm ) ) THEN 
  DEALLOCATE(grid%ozmixm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ozmixm. ')
 endif
  NULLIFY(grid%ozmixm)
ENDIF
IF ( ASSOCIATED( grid%om_u ) ) THEN 
  DEALLOCATE(grid%om_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_u. ')
 endif
  NULLIFY(grid%om_u)
ENDIF
IF ( ASSOCIATED( grid%shall ) ) THEN 
  DEALLOCATE(grid%shall,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shall. ')
 endif
  NULLIFY(grid%shall)
ENDIF
IF ( ASSOCIATED( grid%wup_cup ) ) THEN 
  DEALLOCATE(grid%wup_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wup_cup. ')
 endif
  NULLIFY(grid%wup_cup)
ENDIF
IF ( ASSOCIATED( grid%lnint ) ) THEN 
  DEALLOCATE(grid%lnint,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lnint. ')
 endif
  NULLIFY(grid%lnint)
ENDIF
IF ( ASSOCIATED( grid%msfvx_inv ) ) THEN 
  DEALLOCATE(grid%msfvx_inv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfvx_inv. ')
 endif
  NULLIFY(grid%msfvx_inv)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_bxs ) ) THEN 
  DEALLOCATE(grid%ht_shad_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_bxs. ')
 endif
  NULLIFY(grid%ht_shad_bxs)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_bxe ) ) THEN 
  DEALLOCATE(grid%ht_shad_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_bxe. ')
 endif
  NULLIFY(grid%ht_shad_bxe)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_bys ) ) THEN 
  DEALLOCATE(grid%ht_shad_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_bys. ')
 endif
  NULLIFY(grid%ht_shad_bys)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_bye ) ) THEN 
  DEALLOCATE(grid%ht_shad_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_bye. ')
 endif
  NULLIFY(grid%ht_shad_bye)
ENDIF
IF ( ASSOCIATED( grid%phys_tot ) ) THEN 
  DEALLOCATE(grid%phys_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phys_tot. ')
 endif
  NULLIFY(grid%phys_tot)
ENDIF
IF ( ASSOCIATED( grid%acphysm ) ) THEN 
  DEALLOCATE(grid%acphysm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphysm. ')
 endif
  NULLIFY(grid%acphysm)
ENDIF
IF ( ASSOCIATED( grid%tswup ) ) THEN 
  DEALLOCATE(grid%tswup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tswup. ')
 endif
  NULLIFY(grid%tswup)
ENDIF
IF ( ASSOCIATED( grid%rqishten ) ) THEN 
  DEALLOCATE(grid%rqishten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqishten. ')
 endif
  NULLIFY(grid%rqishten)
ENDIF
IF ( ASSOCIATED( grid%clddpthb ) ) THEN 
  DEALLOCATE(grid%clddpthb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%clddpthb. ')
 endif
  NULLIFY(grid%clddpthb)
ENDIF
IF ( ASSOCIATED( grid%pblhavg ) ) THEN 
  DEALLOCATE(grid%pblhavg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pblhavg. ')
 endif
  NULLIFY(grid%pblhavg)
ENDIF
IF ( ASSOCIATED( grid%rqincuten ) ) THEN 
  DEALLOCATE(grid%rqincuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqincuten. ')
 endif
  NULLIFY(grid%rqincuten)
ENDIF
IF ( ASSOCIATED( grid%rainshv ) ) THEN 
  DEALLOCATE(grid%rainshv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainshv. ')
 endif
  NULLIFY(grid%rainshv)
ENDIF
IF ( ASSOCIATED( grid%qv_old ) ) THEN 
  DEALLOCATE(grid%qv_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_old. ')
 endif
  NULLIFY(grid%qv_old)
ENDIF
IF ( ASSOCIATED( grid%phii3d_3 ) ) THEN 
  DEALLOCATE(grid%phii3d_3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phii3d_3. ')
 endif
  NULLIFY(grid%phii3d_3)
ENDIF
IF ( ASSOCIATED( grid%der_kf ) ) THEN 
  DEALLOCATE(grid%der_kf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%der_kf. ')
 endif
  NULLIFY(grid%der_kf)
ENDIF
IF ( ASSOCIATED( grid%k22_shallow ) ) THEN 
  DEALLOCATE(grid%k22_shallow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%k22_shallow. ')
 endif
  NULLIFY(grid%k22_shallow)
ENDIF
IF ( ASSOCIATED( grid%cugd_qcten ) ) THEN 
  DEALLOCATE(grid%cugd_qcten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cugd_qcten. ')
 endif
  NULLIFY(grid%cugd_qcten)
ENDIF
IF ( ASSOCIATED( grid%nc_cu ) ) THEN 
  DEALLOCATE(grid%nc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nc_cu. ')
 endif
  NULLIFY(grid%nc_cu)
ENDIF
IF ( ASSOCIATED( grid%wact ) ) THEN 
  DEALLOCATE(grid%wact,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wact. ')
 endif
  NULLIFY(grid%wact)
ENDIF
IF ( ASSOCIATED( grid%rqvften ) ) THEN 
  DEALLOCATE(grid%rqvften,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvften. ')
 endif
  NULLIFY(grid%rqvften)
ENDIF
IF ( ASSOCIATED( grid%cldt ) ) THEN 
  DEALLOCATE(grid%cldt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldt. ')
 endif
  NULLIFY(grid%cldt)
ENDIF
IF ( ASSOCIATED( grid%swddni ) ) THEN 
  DEALLOCATE(grid%swddni,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddni. ')
 endif
  NULLIFY(grid%swddni)
ENDIF
IF ( ASSOCIATED( grid%swddir_ref ) ) THEN 
  DEALLOCATE(grid%swddir_ref,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddir_ref. ')
 endif
  NULLIFY(grid%swddir_ref)
ENDIF
IF ( ASSOCIATED( grid%t2mean ) ) THEN 
  DEALLOCATE(grid%t2mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2mean. ')
 endif
  NULLIFY(grid%t2mean)
ENDIF
IF ( ASSOCIATED( grid%skintempmean ) ) THEN 
  DEALLOCATE(grid%skintempmean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%skintempmean. ')
 endif
  NULLIFY(grid%skintempmean)
ENDIF
IF ( ASSOCIATED( grid%raincvmax ) ) THEN 
  DEALLOCATE(grid%raincvmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%raincvmax. ')
 endif
  NULLIFY(grid%raincvmax)
ENDIF
IF ( ASSOCIATED( grid%acswdntc ) ) THEN 
  DEALLOCATE(grid%acswdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswdntc. ')
 endif
  NULLIFY(grid%acswdntc)
ENDIF
IF ( ASSOCIATED( grid%aclwdnbc ) ) THEN 
  DEALLOCATE(grid%aclwdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwdnbc. ')
 endif
  NULLIFY(grid%aclwdnbc)
ENDIF
IF ( ASSOCIATED( grid%i_aclwdntc ) ) THEN 
  DEALLOCATE(grid%i_aclwdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwdntc. ')
 endif
  NULLIFY(grid%i_aclwdntc)
ENDIF
IF ( ASSOCIATED( grid%swupbc ) ) THEN 
  DEALLOCATE(grid%swupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupbc. ')
 endif
  NULLIFY(grid%swupbc)
ENDIF
IF ( ASSOCIATED( grid%lwupbc ) ) THEN 
  DEALLOCATE(grid%lwupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupbc. ')
 endif
  NULLIFY(grid%lwupbc)
ENDIF
IF ( ASSOCIATED( grid%albedo ) ) THEN 
  DEALLOCATE(grid%albedo,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albedo. ')
 endif
  NULLIFY(grid%albedo)
ENDIF
IF ( ASSOCIATED( grid%rqvblten ) ) THEN 
  DEALLOCATE(grid%rqvblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvblten. ')
 endif
  NULLIFY(grid%rqvblten)
ENDIF
IF ( ASSOCIATED( grid%sh2o_mosaic ) ) THEN 
  DEALLOCATE(grid%sh2o_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh2o_mosaic. ')
 endif
  NULLIFY(grid%sh2o_mosaic)
ENDIF
IF ( ASSOCIATED( grid%rs_mosaic ) ) THEN 
  DEALLOCATE(grid%rs_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rs_mosaic. ')
 endif
  NULLIFY(grid%rs_mosaic)
ENDIF
IF ( ASSOCIATED( grid%qc_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%qc_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_urb2d_mosaic. ')
 endif
  NULLIFY(grid%qc_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tbpvs_state ) ) THEN 
  DEALLOCATE(grid%tbpvs_state,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tbpvs_state. ')
 endif
  NULLIFY(grid%tbpvs_state)
ENDIF
IF ( ASSOCIATED( grid%v_phy ) ) THEN 
  DEALLOCATE(grid%v_phy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_phy. ')
 endif
  NULLIFY(grid%v_phy)
ENDIF
IF ( ASSOCIATED( grid%xland ) ) THEN 
  DEALLOCATE(grid%xland,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xland. ')
 endif
  NULLIFY(grid%xland)
ENDIF
IF ( ASSOCIATED( grid%pblh ) ) THEN 
  DEALLOCATE(grid%pblh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pblh. ')
 endif
  NULLIFY(grid%pblh)
ENDIF
IF ( ASSOCIATED( grid%qvg ) ) THEN 
  DEALLOCATE(grid%qvg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qvg. ')
 endif
  NULLIFY(grid%qvg)
ENDIF
IF ( ASSOCIATED( grid%tkesfcf ) ) THEN 
  DEALLOCATE(grid%tkesfcf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tkesfcf. ')
 endif
  NULLIFY(grid%tkesfcf)
ENDIF
IF ( ASSOCIATED( grid%defor13 ) ) THEN 
  DEALLOCATE(grid%defor13,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%defor13. ')
 endif
  NULLIFY(grid%defor13)
ENDIF
IF ( ASSOCIATED( grid%rundgdten ) ) THEN 
  DEALLOCATE(grid%rundgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rundgdten. ')
 endif
  NULLIFY(grid%rundgdten)
ENDIF
IF ( ASSOCIATED( grid%t2_ndg_old ) ) THEN 
  DEALLOCATE(grid%t2_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_ndg_old. ')
 endif
  NULLIFY(grid%t2_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%tob_ndg_old ) ) THEN 
  DEALLOCATE(grid%tob_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tob_ndg_old. ')
 endif
  NULLIFY(grid%tob_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%up_heli_max ) ) THEN 
  DEALLOCATE(grid%up_heli_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%up_heli_max. ')
 endif
  NULLIFY(grid%up_heli_max)
ENDIF
IF ( ASSOCIATED( grid%snow_acc_nc ) ) THEN 
  DEALLOCATE(grid%snow_acc_nc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snow_acc_nc. ')
 endif
  NULLIFY(grid%snow_acc_nc)
ENDIF
IF ( ASSOCIATED( grid%track_p ) ) THEN 
  DEALLOCATE(grid%track_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_p. ')
 endif
  NULLIFY(grid%track_p)
ENDIF
IF ( ASSOCIATED( grid%track_qgraup ) ) THEN 
  DEALLOCATE(grid%track_qgraup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_qgraup. ')
 endif
  NULLIFY(grid%track_qgraup)
ENDIF
IF ( ASSOCIATED( grid%athshten ) ) THEN 
  DEALLOCATE(grid%athshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athshten. ')
 endif
  NULLIFY(grid%athshten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_wup_mask ) ) THEN 
  DEALLOCATE(grid%hailcast_wup_mask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_wup_mask. ')
 endif
  NULLIFY(grid%hailcast_wup_mask)
ENDIF
IF ( ASSOCIATED( grid%ru_xxx ) ) THEN 
  DEALLOCATE(grid%ru_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ru_xxx. ')
 endif
  NULLIFY(grid%ru_xxx)
ENDIF
IF ( ASSOCIATED( grid%dif_xxx ) ) THEN 
  DEALLOCATE(grid%dif_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dif_xxx. ')
 endif
  NULLIFY(grid%dif_xxx)
ENDIF
IF ( ASSOCIATED( grid%grnqfx ) ) THEN 
  DEALLOCATE(grid%grnqfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grnqfx. ')
 endif
  NULLIFY(grid%grnqfx)
ENDIF
IF ( ASSOCIATED( grid%lfn_s1 ) ) THEN 
  DEALLOCATE(grid%lfn_s1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_s1. ')
 endif
  NULLIFY(grid%lfn_s1)
ENDIF
IF ( ASSOCIATED( grid%burnt_area_dt ) ) THEN 
  DEALLOCATE(grid%burnt_area_dt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%burnt_area_dt. ')
 endif
  NULLIFY(grid%burnt_area_dt)
ENDIF
IF ( ASSOCIATED( grid%psfc_old ) ) THEN 
  DEALLOCATE(grid%psfc_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc_old. ')
 endif
  NULLIFY(grid%psfc_old)
ENDIF
IF ( ASSOCIATED( grid%fxlong ) ) THEN 
  DEALLOCATE(grid%fxlong,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fxlong. ')
 endif
  NULLIFY(grid%fxlong)
ENDIF
IF ( ASSOCIATED( grid%tracer ) ) THEN 
  DEALLOCATE(grid%tracer,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer. ')
 endif
  NULLIFY(grid%tracer)
ENDIF
IF ( ASSOCIATED( grid%fs_fire_rosdt ) ) THEN 
  DEALLOCATE(grid%fs_fire_rosdt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_fire_rosdt. ')
 endif
  NULLIFY(grid%fs_fire_rosdt)
ENDIF
IF ( ASSOCIATED( grid%fs_p_x ) ) THEN 
  DEALLOCATE(grid%fs_p_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_x. ')
 endif
  NULLIFY(grid%fs_p_x)
ENDIF
IF ( ASSOCIATED( grid%avgflx_cfu1 ) ) THEN 
  DEALLOCATE(grid%avgflx_cfu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_cfu1. ')
 endif
  NULLIFY(grid%avgflx_cfu1)
ENDIF
IF ( ASSOCIATED( grid%pattern_spp_pbl ) ) THEN 
  DEALLOCATE(grid%pattern_spp_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pattern_spp_pbl. ')
 endif
  NULLIFY(grid%pattern_spp_pbl)
ENDIF
IF ( ASSOCIATED( grid%spforcs ) ) THEN 
  DEALLOCATE(grid%spforcs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs. ')
 endif
  NULLIFY(grid%spforcs)
ENDIF
IF ( ASSOCIATED( grid%spforcs5 ) ) THEN 
  DEALLOCATE(grid%spforcs5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs5. ')
 endif
  NULLIFY(grid%spforcs5)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_spp_lsm ) ) THEN 
  DEALLOCATE(grid%iseedarr_spp_lsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_spp_lsm. ')
 endif
  NULLIFY(grid%iseedarr_spp_lsm)
ENDIF
IF ( ASSOCIATED( grid%vertstrucs3d ) ) THEN 
  DEALLOCATE(grid%vertstrucs3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertstrucs3d. ')
 endif
  NULLIFY(grid%vertstrucs3d)
ENDIF
IF ( ASSOCIATED( grid%wsedl3d ) ) THEN 
  DEALLOCATE(grid%wsedl3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wsedl3d. ')
 endif
  NULLIFY(grid%wsedl3d)
ENDIF
IF ( ASSOCIATED( grid%zmflxprc ) ) THEN 
  DEALLOCATE(grid%zmflxprc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmflxprc. ')
 endif
  NULLIFY(grid%zmflxprc)
ENDIF
IF ( ASSOCIATED( grid%zmmu ) ) THEN 
  DEALLOCATE(grid%zmmu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmmu. ')
 endif
  NULLIFY(grid%zmmu)
ENDIF
IF ( ASSOCIATED( grid%rprddp3d ) ) THEN 
  DEALLOCATE(grid%rprddp3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rprddp3d. ')
 endif
  NULLIFY(grid%rprddp3d)
ENDIF
IF ( ASSOCIATED( grid%cmfsl ) ) THEN 
  DEALLOCATE(grid%cmfsl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmfsl. ')
 endif
  NULLIFY(grid%cmfsl)
ENDIF
IF ( ASSOCIATED( grid%shfrc3d ) ) THEN 
  DEALLOCATE(grid%shfrc3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shfrc3d. ')
 endif
  NULLIFY(grid%shfrc3d)
ENDIF
IF ( ASSOCIATED( grid%cbmf_cu ) ) THEN 
  DEALLOCATE(grid%cbmf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cbmf_cu. ')
 endif
  NULLIFY(grid%cbmf_cu)
ENDIF
IF ( ASSOCIATED( grid%thvlsrc_cu ) ) THEN 
  DEALLOCATE(grid%thvlsrc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thvlsrc_cu. ')
 endif
  NULLIFY(grid%thvlsrc_cu)
ENDIF
IF ( ASSOCIATED( grid%ufrc_cu ) ) THEN 
  DEALLOCATE(grid%ufrc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ufrc_cu. ')
 endif
  NULLIFY(grid%ufrc_cu)
ENDIF
IF ( ASSOCIATED( grid%qcu_cu ) ) THEN 
  DEALLOCATE(grid%qcu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qcu_cu. ')
 endif
  NULLIFY(grid%qcu_cu)
ENDIF
IF ( ASSOCIATED( grid%ntraprd_cu ) ) THEN 
  DEALLOCATE(grid%ntraprd_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ntraprd_cu. ')
 endif
  NULLIFY(grid%ntraprd_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_klclmkx_cu ) ) THEN 
  DEALLOCATE(grid%exit_klclmkx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_klclmkx_cu. ')
 endif
  NULLIFY(grid%exit_klclmkx_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_ppen_cu ) ) THEN 
  DEALLOCATE(grid%limit_ppen_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_ppen_cu. ')
 endif
  NULLIFY(grid%limit_ppen_cu)
ENDIF
IF ( ASSOCIATED( grid%iradius ) ) THEN 
  DEALLOCATE(grid%iradius,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iradius. ')
 endif
  NULLIFY(grid%iradius)
ENDIF
IF ( ASSOCIATED( grid%lhveg ) ) THEN 
  DEALLOCATE(grid%lhveg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lhveg. ')
 endif
  NULLIFY(grid%lhveg)
ENDIF
IF ( ASSOCIATED( grid%fsun24 ) ) THEN 
  DEALLOCATE(grid%fsun24,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsun24. ')
 endif
  NULLIFY(grid%fsun24)
ENDIF
IF ( ASSOCIATED( grid%t_ref2m ) ) THEN 
  DEALLOCATE(grid%t_ref2m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_ref2m. ')
 endif
  NULLIFY(grid%t_ref2m)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq6 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq6,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq6. ')
 endif
  NULLIFY(grid%h2osoi_liq6)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice3 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice3. ')
 endif
  NULLIFY(grid%h2osoi_ice3)
ENDIF
IF ( ASSOCIATED( grid%t_soisno_s5 ) ) THEN 
  DEALLOCATE(grid%t_soisno_s5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno_s5. ')
 endif
  NULLIFY(grid%t_soisno_s5)
ENDIF
IF ( ASSOCIATED( grid%dzsnow2 ) ) THEN 
  DEALLOCATE(grid%dzsnow2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzsnow2. ')
 endif
  NULLIFY(grid%dzsnow2)
ENDIF
IF ( ASSOCIATED( grid%t_lake4 ) ) THEN 
  DEALLOCATE(grid%t_lake4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake4. ')
 endif
  NULLIFY(grid%t_lake4)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol6 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol6,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol6. ')
 endif
  NULLIFY(grid%h2osoi_vol6)
ENDIF
IF ( ASSOCIATED( grid%nrasubgrid ) ) THEN 
  DEALLOCATE(grid%nrasubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nrasubgrid. ')
 endif
  NULLIFY(grid%nrasubgrid)
ENDIF
IF ( ASSOCIATED( grid%dz_lake3d ) ) THEN 
  DEALLOCATE(grid%dz_lake3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dz_lake3d. ')
 endif
  NULLIFY(grid%dz_lake3d)
ENDIF
IF ( ASSOCIATED( grid%tksatu3d ) ) THEN 
  DEALLOCATE(grid%tksatu3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tksatu3d. ')
 endif
  NULLIFY(grid%tksatu3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_shf ) ) THEN 
  DEALLOCATE(grid%ssib_shf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_shf. ')
 endif
  NULLIFY(grid%ssib_shf)
ENDIF
IF ( ASSOCIATED( grid%ssib_shc ) ) THEN 
  DEALLOCATE(grid%ssib_shc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_shc. ')
 endif
  NULLIFY(grid%ssib_shc)
ENDIF
IF ( ASSOCIATED( grid%wo1 ) ) THEN 
  DEALLOCATE(grid%wo1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wo1. ')
 endif
  NULLIFY(grid%wo1)
ENDIF
IF ( ASSOCIATED( grid%wo2 ) ) THEN 
  DEALLOCATE(grid%wo2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wo2. ')
 endif
  NULLIFY(grid%wo2)
ENDIF
IF ( ASSOCIATED( grid%wo3 ) ) THEN 
  DEALLOCATE(grid%wo3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wo3. ')
 endif
  NULLIFY(grid%wo3)
ENDIF
IF ( ASSOCIATED( grid%wo4 ) ) THEN 
  DEALLOCATE(grid%wo4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wo4. ')
 endif
  NULLIFY(grid%wo4)
ENDIF
IF ( ASSOCIATED( grid%tvxy ) ) THEN 
  DEALLOCATE(grid%tvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tvxy. ')
 endif
  NULLIFY(grid%tvxy)
ENDIF
IF ( ASSOCIATED( grid%qrainxy ) ) THEN 
  DEALLOCATE(grid%qrainxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qrainxy. ')
 endif
  NULLIFY(grid%qrainxy)
ENDIF
IF ( ASSOCIATED( grid%woodxy ) ) THEN 
  DEALLOCATE(grid%woodxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%woodxy. ')
 endif
  NULLIFY(grid%woodxy)
ENDIF
IF ( ASSOCIATED( grid%nppxy ) ) THEN 
  DEALLOCATE(grid%nppxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nppxy. ')
 endif
  NULLIFY(grid%nppxy)
ENDIF
IF ( ASSOCIATED( grid%savxy ) ) THEN 
  DEALLOCATE(grid%savxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%savxy. ')
 endif
  NULLIFY(grid%savxy)
ENDIF
IF ( ASSOCIATED( grid%shbxy ) ) THEN 
  DEALLOCATE(grid%shbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shbxy. ')
 endif
  NULLIFY(grid%shbxy)
ENDIF
IF ( ASSOCIATED( grid%chv2xy ) ) THEN 
  DEALLOCATE(grid%chv2xy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chv2xy. ')
 endif
  NULLIFY(grid%chv2xy)
ENDIF
IF ( ASSOCIATED( grid%qspringsxy ) ) THEN 
  DEALLOCATE(grid%qspringsxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qspringsxy. ')
 endif
  NULLIFY(grid%qspringsxy)
ENDIF
IF ( ASSOCIATED( grid%qintrxy ) ) THEN 
  DEALLOCATE(grid%qintrxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qintrxy. ')
 endif
  NULLIFY(grid%qintrxy)
ENDIF
IF ( ASSOCIATED( grid%qmeltcxy ) ) THEN 
  DEALLOCATE(grid%qmeltcxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qmeltcxy. ')
 endif
  NULLIFY(grid%qmeltcxy)
ENDIF
IF ( ASSOCIATED( grid%soilcomp ) ) THEN 
  DEALLOCATE(grid%soilcomp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcomp. ')
 endif
  NULLIFY(grid%soilcomp)
ENDIF
IF ( ASSOCIATED( grid%forcqlsm ) ) THEN 
  DEALLOCATE(grid%forcqlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%forcqlsm. ')
 endif
  NULLIFY(grid%forcqlsm)
ENDIF
IF ( ASSOCIATED( grid%acetlsm ) ) THEN 
  DEALLOCATE(grid%acetlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acetlsm. ')
 endif
  NULLIFY(grid%acetlsm)
ENDIF
IF ( ASSOCIATED( grid%acdrips ) ) THEN 
  DEALLOCATE(grid%acdrips,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acdrips. ')
 endif
  NULLIFY(grid%acdrips)
ENDIF
IF ( ASSOCIATED( grid%acghv ) ) THEN 
  DEALLOCATE(grid%acghv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acghv. ')
 endif
  NULLIFY(grid%acghv)
ENDIF
IF ( ASSOCIATED( grid%acshflsm ) ) THEN 
  DEALLOCATE(grid%acshflsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acshflsm. ')
 endif
  NULLIFY(grid%acshflsm)
ENDIF
IF ( ASSOCIATED( grid%eflxbxy ) ) THEN 
  DEALLOCATE(grid%eflxbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%eflxbxy. ')
 endif
  NULLIFY(grid%eflxbxy)
ENDIF
IF ( ASSOCIATED( grid%cropcat ) ) THEN 
  DEALLOCATE(grid%cropcat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cropcat. ')
 endif
  NULLIFY(grid%cropcat)
ENDIF
IF ( ASSOCIATED( grid%irwatsi ) ) THEN 
  DEALLOCATE(grid%irwatsi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irwatsi. ')
 endif
  NULLIFY(grid%irwatsi)
ENDIF
IF ( ASSOCIATED( grid%kext_qs ) ) THEN 
  DEALLOCATE(grid%kext_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qs. ')
 endif
  NULLIFY(grid%kext_qs)
ENDIF
IF ( ASSOCIATED( grid%sbmradar ) ) THEN 
  DEALLOCATE(grid%sbmradar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sbmradar. ')
 endif
  NULLIFY(grid%sbmradar)
ENDIF
IF ( ASSOCIATED( grid%icingbot ) ) THEN 
  DEALLOCATE(grid%icingbot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icingbot. ')
 endif
  NULLIFY(grid%icingbot)
ENDIF
IF ( ASSOCIATED( grid%afwa_tlyrtop ) ) THEN 
  DEALLOCATE(grid%afwa_tlyrtop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_tlyrtop. ')
 endif
  NULLIFY(grid%afwa_tlyrtop)
ENDIF
IF ( ASSOCIATED( grid%afwa_snowfall ) ) THEN 
  DEALLOCATE(grid%afwa_snowfall,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_snowfall. ')
 endif
  NULLIFY(grid%afwa_snowfall)
ENDIF
IF ( ASSOCIATED( grid%afwa_lidx ) ) THEN 
  DEALLOCATE(grid%afwa_lidx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_lidx. ')
 endif
  NULLIFY(grid%afwa_lidx)
ENDIF
IF ( ASSOCIATED( grid%q2_mean ) ) THEN 
  DEALLOCATE(grid%q2_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2_mean. ')
 endif
  NULLIFY(grid%q2_mean)
ENDIF
IF ( ASSOCIATED( grid%lwdnt_mean ) ) THEN 
  DEALLOCATE(grid%lwdnt_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnt_mean. ')
 endif
  NULLIFY(grid%lwdnt_mean)
ENDIF
IF ( ASSOCIATED( grid%swdnb_diurn ) ) THEN 
  DEALLOCATE(grid%swdnb_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnb_diurn. ')
 endif
  NULLIFY(grid%swdnb_diurn)
ENDIF
IF ( ASSOCIATED( grid%t2_dtmp ) ) THEN 
  DEALLOCATE(grid%t2_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_dtmp. ')
 endif
  NULLIFY(grid%t2_dtmp)
ENDIF
IF ( ASSOCIATED( grid%swdnt_dtmp ) ) THEN 
  DEALLOCATE(grid%swdnt_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnt_dtmp. ')
 endif
  NULLIFY(grid%swdnt_dtmp)
ENDIF
IF ( ASSOCIATED( grid%pot ) ) THEN 
  DEALLOCATE(grid%pot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pot. ')
 endif
  NULLIFY(grid%pot)
ENDIF
IF ( ASSOCIATED( grid%c2f ) ) THEN 
  DEALLOCATE(grid%c2f,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c2f. ')
 endif
  NULLIFY(grid%c2f)
ENDIF
IF ( ASSOCIATED( grid%p_wif_jul ) ) THEN 
  DEALLOCATE(grid%p_wif_jul,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_jul. ')
 endif
  NULLIFY(grid%p_wif_jul)
ENDIF
IF ( ASSOCIATED( grid%w_wif_jun ) ) THEN 
  DEALLOCATE(grid%w_wif_jun,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_jun. ')
 endif
  NULLIFY(grid%w_wif_jun)
ENDIF
IF ( ASSOCIATED( grid%i_wif_may ) ) THEN 
  DEALLOCATE(grid%i_wif_may,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_may. ')
 endif
  NULLIFY(grid%i_wif_may)
ENDIF
IF ( ASSOCIATED( grid%b_wif_apr ) ) THEN 
  DEALLOCATE(grid%b_wif_apr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_apr. ')
 endif
  NULLIFY(grid%b_wif_apr)
ENDIF
IF ( ASSOCIATED( grid%geoheight ) ) THEN 
  DEALLOCATE(grid%geoheight,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%geoheight. ')
 endif
  NULLIFY(grid%geoheight)
ENDIF
IF ( ASSOCIATED( grid%qc_tot ) ) THEN 
  DEALLOCATE(grid%qc_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_tot. ')
 endif
  NULLIFY(grid%qc_tot)
ENDIF
IF ( ASSOCIATED( grid%re_qi ) ) THEN 
  DEALLOCATE(grid%re_qi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_qi. ')
 endif
  NULLIFY(grid%re_qi)
ENDIF
IF ( ASSOCIATED( grid%ctopht_tot ) ) THEN 
  DEALLOCATE(grid%ctopht_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ctopht_tot. ')
 endif
  NULLIFY(grid%ctopht_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_wp_tot_sum ) ) THEN 
  DEALLOCATE(grid%ts_wp_tot_sum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_wp_tot_sum. ')
 endif
  NULLIFY(grid%ts_wp_tot_sum)
ENDIF
IF ( ASSOCIATED( grid%ts_ctopht ) ) THEN 
  DEALLOCATE(grid%ts_ctopht,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_ctopht. ')
 endif
  NULLIFY(grid%ts_ctopht)
ENDIF
IF ( ASSOCIATED( grid%ts_swddni2 ) ) THEN 
  DEALLOCATE(grid%ts_swddni2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddni2. ')
 endif
  NULLIFY(grid%ts_swddni2)
ENDIF
IF ( ASSOCIATED( grid%p_pl ) ) THEN 
  DEALLOCATE(grid%p_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_pl. ')
 endif
  NULLIFY(grid%p_pl)
ENDIF
IF ( ASSOCIATED( grid%p_zl ) ) THEN 
  DEALLOCATE(grid%p_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_zl. ')
 endif
  NULLIFY(grid%p_zl)
ENDIF
IF ( ASSOCIATED( grid%rswdif_htop_red ) ) THEN 
  DEALLOCATE(grid%rswdif_htop_red,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rswdif_htop_red. ')
 endif
  NULLIFY(grid%rswdif_htop_red)
ENDIF
IF ( ASSOCIATED( grid%mcm_le_grnd ) ) THEN 
  DEALLOCATE(grid%mcm_le_grnd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_le_grnd. ')
 endif
  NULLIFY(grid%mcm_le_grnd)
ENDIF
END SUBROUTINE deallocs_10
!ENDOFREGISTRYGENERATEDINCLUDE
