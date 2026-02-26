!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_5.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_5( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%znw ) ) THEN 
  DEALLOCATE(grid%znw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%znw. ')
 endif
  NULLIFY(grid%znw)
ENDIF
IF ( ASSOCIATED( grid%ght_gc ) ) THEN 
  DEALLOCATE(grid%ght_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ght_gc. ')
 endif
  NULLIFY(grid%ght_gc)
ENDIF
IF ( ASSOCIATED( grid%sct_dom_gc ) ) THEN 
  DEALLOCATE(grid%sct_dom_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sct_dom_gc. ')
 endif
  NULLIFY(grid%sct_dom_gc)
ENDIF
IF ( ASSOCIATED( grid%cl_gc ) ) THEN 
  DEALLOCATE(grid%cl_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cl_gc. ')
 endif
  NULLIFY(grid%cl_gc)
ENDIF
IF ( ASSOCIATED( grid%qnr_gc ) ) THEN 
  DEALLOCATE(grid%qnr_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnr_gc. ')
 endif
  NULLIFY(grid%qnr_gc)
ENDIF
IF ( ASSOCIATED( grid%hgtmaxw ) ) THEN 
  DEALLOCATE(grid%hgtmaxw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hgtmaxw. ')
 endif
  NULLIFY(grid%hgtmaxw)
ENDIF
IF ( ASSOCIATED( grid%erod ) ) THEN 
  DEALLOCATE(grid%erod,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%erod. ')
 endif
  NULLIFY(grid%erod)
ENDIF
IF ( ASSOCIATED( grid%z_force_tend ) ) THEN 
  DEALLOCATE(grid%z_force_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z_force_tend. ')
 endif
  NULLIFY(grid%z_force_tend)
ENDIF
IF ( ASSOCIATED( grid%v_g_tend ) ) THEN 
  DEALLOCATE(grid%v_g_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_g_tend. ')
 endif
  NULLIFY(grid%v_g_tend)
ENDIF
IF ( ASSOCIATED( grid%th_upstream_x_tend ) ) THEN 
  DEALLOCATE(grid%th_upstream_x_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_upstream_x_tend. ')
 endif
  NULLIFY(grid%th_upstream_x_tend)
ENDIF
IF ( ASSOCIATED( grid%u_upstream_x_tend ) ) THEN 
  DEALLOCATE(grid%u_upstream_x_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_upstream_x_tend. ')
 endif
  NULLIFY(grid%u_upstream_x_tend)
ENDIF
IF ( ASSOCIATED( grid%qv_largescale_tend ) ) THEN 
  DEALLOCATE(grid%qv_largescale_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_largescale_tend. ')
 endif
  NULLIFY(grid%qv_largescale_tend)
ENDIF
IF ( ASSOCIATED( grid%tau_y_tend ) ) THEN 
  DEALLOCATE(grid%tau_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_y_tend. ')
 endif
  NULLIFY(grid%tau_y_tend)
ENDIF
IF ( ASSOCIATED( grid%muvs ) ) THEN 
  DEALLOCATE(grid%muvs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%muvs. ')
 endif
  NULLIFY(grid%muvs)
ENDIF
IF ( ASSOCIATED( grid%nlflux ) ) THEN 
  DEALLOCATE(grid%nlflux,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nlflux. ')
 endif
  NULLIFY(grid%nlflux)
ENDIF
IF ( ASSOCIATED( grid%zy ) ) THEN 
  DEALLOCATE(grid%zy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zy. ')
 endif
  NULLIFY(grid%zy)
ENDIF
IF ( ASSOCIATED( grid%p_hyd ) ) THEN 
  DEALLOCATE(grid%p_hyd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_hyd. ')
 endif
  NULLIFY(grid%p_hyd)
ENDIF
IF ( ASSOCIATED( grid%obs_savwt ) ) THEN 
  DEALLOCATE(grid%obs_savwt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%obs_savwt. ')
 endif
  NULLIFY(grid%obs_savwt)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist ) ) THEN 
  DEALLOCATE(grid%dfi_moist,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist. ')
 endif
  NULLIFY(grid%dfi_moist)
ENDIF
IF ( ASSOCIATED( grid%re_snow ) ) THEN 
  DEALLOCATE(grid%re_snow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_snow. ')
 endif
  NULLIFY(grid%re_snow)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_ice_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_ice_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_ice_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_ice_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_btxs ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_btxs. ')
 endif
  NULLIFY(grid%dfi_scalar_btxs)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_btxe ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_btxe. ')
 endif
  NULLIFY(grid%dfi_scalar_btxe)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_btys ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_btys. ')
 endif
  NULLIFY(grid%dfi_scalar_btys)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_btye ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_btye. ')
 endif
  NULLIFY(grid%dfi_scalar_btye)
ENDIF
IF ( ASSOCIATED( grid%sm007028 ) ) THEN 
  DEALLOCATE(grid%sm007028,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm007028. ')
 endif
  NULLIFY(grid%sm007028)
ENDIF
IF ( ASSOCIATED( grid%soilm000 ) ) THEN 
  DEALLOCATE(grid%soilm000,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm000. ')
 endif
  NULLIFY(grid%soilm000)
ENDIF
IF ( ASSOCIATED( grid%soilw005 ) ) THEN 
  DEALLOCATE(grid%soilw005,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilw005. ')
 endif
  NULLIFY(grid%soilw005)
ENDIF
IF ( ASSOCIATED( grid%soilt020 ) ) THEN 
  DEALLOCATE(grid%soilt020,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt020. ')
 endif
  NULLIFY(grid%soilt020)
ENDIF
IF ( ASSOCIATED( grid%toposoil ) ) THEN 
  DEALLOCATE(grid%toposoil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%toposoil. ')
 endif
  NULLIFY(grid%toposoil)
ENDIF
IF ( ASSOCIATED( grid%ts_v ) ) THEN 
  DEALLOCATE(grid%ts_v,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_v. ')
 endif
  NULLIFY(grid%ts_v)
ENDIF
IF ( ASSOCIATED( grid%ts_rainnc ) ) THEN 
  DEALLOCATE(grid%ts_rainnc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_rainnc. ')
 endif
  NULLIFY(grid%ts_rainnc)
ENDIF
IF ( ASSOCIATED( grid%lp_urb2d ) ) THEN 
  DEALLOCATE(grid%lp_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lp_urb2d. ')
 endif
  NULLIFY(grid%lp_urb2d)
ENDIF
IF ( ASSOCIATED( grid%xicem ) ) THEN 
  DEALLOCATE(grid%xicem,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xicem. ')
 endif
  NULLIFY(grid%xicem)
ENDIF
IF ( ASSOCIATED( grid%ivgtyp ) ) THEN 
  DEALLOCATE(grid%ivgtyp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ivgtyp. ')
 endif
  NULLIFY(grid%ivgtyp)
ENDIF
IF ( ASSOCIATED( grid%canwat ) ) THEN 
  DEALLOCATE(grid%canwat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canwat. ')
 endif
  NULLIFY(grid%canwat)
ENDIF
IF ( ASSOCIATED( grid%voce ) ) THEN 
  DEALLOCATE(grid%voce,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%voce. ')
 endif
  NULLIFY(grid%voce)
ENDIF
IF ( ASSOCIATED( grid%dfi_ww ) ) THEN 
  DEALLOCATE(grid%dfi_ww,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_ww. ')
 endif
  NULLIFY(grid%dfi_ww)
ENDIF
IF ( ASSOCIATED( grid%dfi_canwat ) ) THEN 
  DEALLOCATE(grid%dfi_canwat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_canwat. ')
 endif
  NULLIFY(grid%dfi_canwat)
ENDIF
IF ( ASSOCIATED( grid%xxxb_urb2d ) ) THEN 
  DEALLOCATE(grid%xxxb_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xxxb_urb2d. ')
 endif
  NULLIFY(grid%xxxb_urb2d)
ENDIF
IF ( ASSOCIATED( grid%trl_urb3d ) ) THEN 
  DEALLOCATE(grid%trl_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trl_urb3d. ')
 endif
  NULLIFY(grid%trl_urb3d)
ENDIF
IF ( ASSOCIATED( grid%tw2_urb4d ) ) THEN 
  DEALLOCATE(grid%tw2_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tw2_urb4d. ')
 endif
  NULLIFY(grid%tw2_urb4d)
ENDIF
IF ( ASSOCIATED( grid%lfvent_urb3d ) ) THEN 
  DEALLOCATE(grid%lfvent_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfvent_urb3d. ')
 endif
  NULLIFY(grid%lfvent_urb3d)
ENDIF
IF ( ASSOCIATED( grid%tgr_urb3d ) ) THEN 
  DEALLOCATE(grid%tgr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgr_urb3d. ')
 endif
  NULLIFY(grid%tgr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%chc_sfcdif ) ) THEN 
  DEALLOCATE(grid%chc_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chc_sfcdif. ')
 endif
  NULLIFY(grid%chc_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%snowfallac ) ) THEN 
  DEALLOCATE(grid%snowfallac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowfallac. ')
 endif
  NULLIFY(grid%snowfallac)
ENDIF
IF ( ASSOCIATED( grid%ra ) ) THEN 
  DEALLOCATE(grid%ra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ra. ')
 endif
  NULLIFY(grid%ra)
ENDIF
IF ( ASSOCIATED( grid%clay_px ) ) THEN 
  DEALLOCATE(grid%clay_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%clay_px. ')
 endif
  NULLIFY(grid%clay_px)
ENDIF
IF ( ASSOCIATED( grid%delta_ysu ) ) THEN 
  DEALLOCATE(grid%delta_ysu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%delta_ysu. ')
 endif
  NULLIFY(grid%delta_ysu)
ENDIF
IF ( ASSOCIATED( grid%akhs ) ) THEN 
  DEALLOCATE(grid%akhs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%akhs. ')
 endif
  NULLIFY(grid%akhs)
ENDIF
IF ( ASSOCIATED( grid%massflux_edkf ) ) THEN 
  DEALLOCATE(grid%massflux_edkf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%massflux_edkf. ')
 endif
  NULLIFY(grid%massflux_edkf)
ENDIF
IF ( ASSOCIATED( grid%te_temf ) ) THEN 
  DEALLOCATE(grid%te_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%te_temf. ')
 endif
  NULLIFY(grid%te_temf)
ENDIF
IF ( ASSOCIATED( grid%cf3d_temf ) ) THEN 
  DEALLOCATE(grid%cf3d_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cf3d_temf. ')
 endif
  NULLIFY(grid%cf3d_temf)
ENDIF
IF ( ASSOCIATED( grid%tsq ) ) THEN 
  DEALLOCATE(grid%tsq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsq. ')
 endif
  NULLIFY(grid%tsq)
ENDIF
IF ( ASSOCIATED( grid%sub_thl3d ) ) THEN 
  DEALLOCATE(grid%sub_thl3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sub_thl3d. ')
 endif
  NULLIFY(grid%sub_thl3d)
ENDIF
IF ( ASSOCIATED( grid%dtauy3d ) ) THEN 
  DEALLOCATE(grid%dtauy3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtauy3d. ')
 endif
  NULLIFY(grid%dtauy3d)
ENDIF
IF ( ASSOCIATED( grid%ol4 ) ) THEN 
  DEALLOCATE(grid%ol4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol4. ')
 endif
  NULLIFY(grid%ol4)
ENDIF
IF ( ASSOCIATED( grid%dvsfcg_bl ) ) THEN 
  DEALLOCATE(grid%dvsfcg_bl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dvsfcg_bl. ')
 endif
  NULLIFY(grid%dvsfcg_bl)
ENDIF
IF ( ASSOCIATED( grid%ol2ls ) ) THEN 
  DEALLOCATE(grid%ol2ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol2ls. ')
 endif
  NULLIFY(grid%ol2ls)
ENDIF
IF ( ASSOCIATED( grid%ol4ss ) ) THEN 
  DEALLOCATE(grid%ol4ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol4ss. ')
 endif
  NULLIFY(grid%ol4ss)
ENDIF
IF ( ASSOCIATED( grid%b_e_bep ) ) THEN 
  DEALLOCATE(grid%b_e_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_e_bep. ')
 endif
  NULLIFY(grid%b_e_bep)
ENDIF
IF ( ASSOCIATED( grid%wt_tur ) ) THEN 
  DEALLOCATE(grid%wt_tur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wt_tur. ')
 endif
  NULLIFY(grid%wt_tur)
ENDIF
IF ( ASSOCIATED( grid%cfracl ) ) THEN 
  DEALLOCATE(grid%cfracl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cfracl. ')
 endif
  NULLIFY(grid%cfracl)
ENDIF
IF ( ASSOCIATED( grid%aodtot ) ) THEN 
  DEALLOCATE(grid%aodtot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aodtot. ')
 endif
  NULLIFY(grid%aodtot)
ENDIF
IF ( ASSOCIATED( grid%f_rimef_phy ) ) THEN 
  DEALLOCATE(grid%f_rimef_phy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%f_rimef_phy. ')
 endif
  NULLIFY(grid%f_rimef_phy)
ENDIF
IF ( ASSOCIATED( grid%cupflag ) ) THEN 
  DEALLOCATE(grid%cupflag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cupflag. ')
 endif
  NULLIFY(grid%cupflag)
ENDIF
IF ( ASSOCIATED( grid%cldfra_cup ) ) THEN 
  DEALLOCATE(grid%cldfra_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_cup. ')
 endif
  NULLIFY(grid%cldfra_cup)
ENDIF
IF ( ASSOCIATED( grid%fcvt_qc_to_pr_cup ) ) THEN 
  DEALLOCATE(grid%fcvt_qc_to_pr_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcvt_qc_to_pr_cup. ')
 endif
  NULLIFY(grid%fcvt_qc_to_pr_cup)
ENDIF
IF ( ASSOCIATED( grid%msftx ) ) THEN 
  DEALLOCATE(grid%msftx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msftx. ')
 endif
  NULLIFY(grid%msftx)
ENDIF
IF ( ASSOCIATED( grid%ht_fine ) ) THEN 
  DEALLOCATE(grid%ht_fine,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_fine. ')
 endif
  NULLIFY(grid%ht_fine)
ENDIF
IF ( ASSOCIATED( grid%tsk_save ) ) THEN 
  DEALLOCATE(grid%tsk_save,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_save. ')
 endif
  NULLIFY(grid%tsk_save)
ENDIF
IF ( ASSOCIATED( grid%acphys_tot ) ) THEN 
  DEALLOCATE(grid%acphys_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphys_tot. ')
 endif
  NULLIFY(grid%acphys_tot)
ENDIF
IF ( ASSOCIATED( grid%tlwdn ) ) THEN 
  DEALLOCATE(grid%tlwdn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tlwdn. ')
 endif
  NULLIFY(grid%tlwdn)
ENDIF
IF ( ASSOCIATED( grid%rthshten ) ) THEN 
  DEALLOCATE(grid%rthshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthshten. ')
 endif
  NULLIFY(grid%rthshten)
ENDIF
IF ( ASSOCIATED( grid%cldareab ) ) THEN 
  DEALLOCATE(grid%cldareab,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldareab. ')
 endif
  NULLIFY(grid%cldareab)
ENDIF
IF ( ASSOCIATED( grid%ainckfsa ) ) THEN 
  DEALLOCATE(grid%ainckfsa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ainckfsa. ')
 endif
  NULLIFY(grid%ainckfsa)
ENDIF
IF ( ASSOCIATED( grid%rqrcuten ) ) THEN 
  DEALLOCATE(grid%rqrcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqrcuten. ')
 endif
  NULLIFY(grid%rqrcuten)
ENDIF
IF ( ASSOCIATED( grid%i_rainc ) ) THEN 
  DEALLOCATE(grid%i_rainc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_rainc. ')
 endif
  NULLIFY(grid%i_rainc)
ENDIF
IF ( ASSOCIATED( grid%graupelncv ) ) THEN 
  DEALLOCATE(grid%graupelncv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%graupelncv. ')
 endif
  NULLIFY(grid%graupelncv)
ENDIF
IF ( ASSOCIATED( grid%rhopo3d_2 ) ) THEN 
  DEALLOCATE(grid%rhopo3d_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rhopo3d_2. ')
 endif
  NULLIFY(grid%rhopo3d_2)
ENDIF
IF ( ASSOCIATED( grid%cldfra_dp ) ) THEN 
  DEALLOCATE(grid%cldfra_dp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_dp. ')
 endif
  NULLIFY(grid%cldfra_dp)
ENDIF
IF ( ASSOCIATED( grid%apr_capma ) ) THEN 
  DEALLOCATE(grid%apr_capma,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_capma. ')
 endif
  NULLIFY(grid%apr_capma)
ENDIF
IF ( ASSOCIATED( grid%pr_ens ) ) THEN 
  DEALLOCATE(grid%pr_ens,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pr_ens. ')
 endif
  NULLIFY(grid%pr_ens)
ENDIF
IF ( ASSOCIATED( grid%gd_cloud2_a ) ) THEN 
  DEALLOCATE(grid%gd_cloud2_a,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gd_cloud2_a. ')
 endif
  NULLIFY(grid%gd_cloud2_a)
ENDIF
IF ( ASSOCIATED( grid%efis ) ) THEN 
  DEALLOCATE(grid%efis,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efis. ')
 endif
  NULLIFY(grid%efis)
ENDIF
IF ( ASSOCIATED( grid%ccn7_gs ) ) THEN 
  DEALLOCATE(grid%ccn7_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn7_gs. ')
 endif
  NULLIFY(grid%ccn7_gs)
ENDIF
IF ( ASSOCIATED( grid%cldfra ) ) THEN 
  DEALLOCATE(grid%cldfra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra. ')
 endif
  NULLIFY(grid%cldfra)
ENDIF
IF ( ASSOCIATED( grid%swnorm ) ) THEN 
  DEALLOCATE(grid%swnorm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swnorm. ')
 endif
  NULLIFY(grid%swnorm)
ENDIF
IF ( ASSOCIATED( grid%bx ) ) THEN 
  DEALLOCATE(grid%bx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bx. ')
 endif
  NULLIFY(grid%bx)
ENDIF
IF ( ASSOCIATED( grid%taod5502d ) ) THEN 
  DEALLOCATE(grid%taod5502d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taod5502d. ')
 endif
  NULLIFY(grid%taod5502d)
ENDIF
IF ( ASSOCIATED( grid%q2std ) ) THEN 
  DEALLOCATE(grid%q2std,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2std. ')
 endif
  NULLIFY(grid%q2std)
ENDIF
IF ( ASSOCIATED( grid%v10mean ) ) THEN 
  DEALLOCATE(grid%v10mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10mean. ')
 endif
  NULLIFY(grid%v10mean)
ENDIF
IF ( ASSOCIATED( grid%rainncvstd ) ) THEN 
  DEALLOCATE(grid%rainncvstd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainncvstd. ')
 endif
  NULLIFY(grid%rainncvstd)
ENDIF
IF ( ASSOCIATED( grid%aclwdnt ) ) THEN 
  DEALLOCATE(grid%aclwdnt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwdnt. ')
 endif
  NULLIFY(grid%aclwdnt)
ENDIF
IF ( ASSOCIATED( grid%i_acswdnb ) ) THEN 
  DEALLOCATE(grid%i_acswdnb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswdnb. ')
 endif
  NULLIFY(grid%i_acswdnb)
ENDIF
IF ( ASSOCIATED( grid%swuptcln ) ) THEN 
  DEALLOCATE(grid%swuptcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swuptcln. ')
 endif
  NULLIFY(grid%swuptcln)
ENDIF
IF ( ASSOCIATED( grid%lwuptcln ) ) THEN 
  DEALLOCATE(grid%lwuptcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwuptcln. ')
 endif
  NULLIFY(grid%lwuptcln)
ENDIF
IF ( ASSOCIATED( grid%olr ) ) THEN 
  DEALLOCATE(grid%olr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%olr. ')
 endif
  NULLIFY(grid%olr)
ENDIF
IF ( ASSOCIATED( grid%cldefi ) ) THEN 
  DEALLOCATE(grid%cldefi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldefi. ')
 endif
  NULLIFY(grid%cldefi)
ENDIF
IF ( ASSOCIATED( grid%fgsn ) ) THEN 
  DEALLOCATE(grid%fgsn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fgsn. ')
 endif
  NULLIFY(grid%fgsn)
ENDIF
IF ( ASSOCIATED( grid%emiss_mosaic ) ) THEN 
  DEALLOCATE(grid%emiss_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%emiss_mosaic. ')
 endif
  NULLIFY(grid%emiss_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tb_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%tb_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tb_urb2d_mosaic. ')
 endif
  NULLIFY(grid%tb_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%g_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%g_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%g_urb2d_mosaic. ')
 endif
  NULLIFY(grid%g_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tyra ) ) THEN 
  DEALLOCATE(grid%tyra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tyra. ')
 endif
  NULLIFY(grid%tyra)
ENDIF
IF ( ASSOCIATED( grid%ust ) ) THEN 
  DEALLOCATE(grid%ust,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ust. ')
 endif
  NULLIFY(grid%ust)
ENDIF
IF ( ASSOCIATED( grid%wstar ) ) THEN 
  DEALLOCATE(grid%wstar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wstar. ')
 endif
  NULLIFY(grid%wstar)
ENDIF
IF ( ASSOCIATED( grid%dfi_tsnav ) ) THEN 
  DEALLOCATE(grid%dfi_tsnav,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_tsnav. ')
 endif
  NULLIFY(grid%dfi_tsnav)
ENDIF
IF ( ASSOCIATED( grid%taucldc ) ) THEN 
  DEALLOCATE(grid%taucldc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taucldc. ')
 endif
  NULLIFY(grid%taucldc)
ENDIF
IF ( ASSOCIATED( grid%bn2 ) ) THEN 
  DEALLOCATE(grid%bn2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bn2. ')
 endif
  NULLIFY(grid%bn2)
ENDIF
IF ( ASSOCIATED( grid%fdda2d ) ) THEN 
  DEALLOCATE(grid%fdda2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fdda2d. ')
 endif
  NULLIFY(grid%fdda2d)
ENDIF
IF ( ASSOCIATED( grid%rh_ndg_new ) ) THEN 
  DEALLOCATE(grid%rh_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_ndg_new. ')
 endif
  NULLIFY(grid%rh_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%sda_qfx ) ) THEN 
  DEALLOCATE(grid%sda_qfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sda_qfx. ')
 endif
  NULLIFY(grid%sda_qfx)
ENDIF
IF ( ASSOCIATED( grid%mu_2m ) ) THEN 
  DEALLOCATE(grid%mu_2m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_2m. ')
 endif
  NULLIFY(grid%mu_2m)
ENDIF
IF ( ASSOCIATED( grid%hail_maxk1 ) ) THEN 
  DEALLOCATE(grid%hail_maxk1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hail_maxk1. ')
 endif
  NULLIFY(grid%hail_maxk1)
ENDIF
IF ( ASSOCIATED( grid%huml ) ) THEN 
  DEALLOCATE(grid%huml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%huml. ')
 endif
  NULLIFY(grid%huml)
ENDIF
IF ( ASSOCIATED( grid%track_aircraft ) ) THEN 
  DEALLOCATE(grid%track_aircraft,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_aircraft. ')
 endif
  NULLIFY(grid%track_aircraft)
ENDIF
IF ( ASSOCIATED( grid%aqvmpten ) ) THEN 
  DEALLOCATE(grid%aqvmpten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aqvmpten. ')
 endif
  NULLIFY(grid%aqvmpten)
ENDIF
IF ( ASSOCIATED( grid%avblten ) ) THEN 
  DEALLOCATE(grid%avblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avblten. ')
 endif
  NULLIFY(grid%avblten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_dhail4 ) ) THEN 
  DEALLOCATE(grid%hailcast_dhail4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_dhail4. ')
 endif
  NULLIFY(grid%hailcast_dhail4)
ENDIF
IF ( ASSOCIATED( grid%cg_flashcount ) ) THEN 
  DEALLOCATE(grid%cg_flashcount,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cg_flashcount. ')
 endif
  NULLIFY(grid%cg_flashcount)
ENDIF
IF ( ASSOCIATED( grid%iccg_in_num ) ) THEN 
  DEALLOCATE(grid%iccg_in_num,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iccg_in_num. ')
 endif
  NULLIFY(grid%iccg_in_num)
ENDIF
IF ( ASSOCIATED( grid%fourd_xxx ) ) THEN 
  DEALLOCATE(grid%fourd_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fourd_xxx. ')
 endif
  NULLIFY(grid%fourd_xxx)
ENDIF
IF ( ASSOCIATED( grid%tign_g ) ) THEN 
  DEALLOCATE(grid%tign_g,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tign_g. ')
 endif
  NULLIFY(grid%tign_g)
ENDIF
IF ( ASSOCIATED( grid%lfn ) ) THEN 
  DEALLOCATE(grid%lfn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn. ')
 endif
  NULLIFY(grid%lfn)
ENDIF
IF ( ASSOCIATED( grid%fgrnhfx ) ) THEN 
  DEALLOCATE(grid%fgrnhfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fgrnhfx. ')
 endif
  NULLIFY(grid%fgrnhfx)
ENDIF
IF ( ASSOCIATED( grid%fmc_equi ) ) THEN 
  DEALLOCATE(grid%fmc_equi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmc_equi. ')
 endif
  NULLIFY(grid%fmc_equi)
ENDIF
IF ( ASSOCIATED( grid%fgip ) ) THEN 
  DEALLOCATE(grid%fgip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fgip. ')
 endif
  NULLIFY(grid%fgip)
ENDIF
IF ( ASSOCIATED( grid%fs_frac_landed ) ) THEN 
  DEALLOCATE(grid%fs_frac_landed,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_frac_landed. ')
 endif
  NULLIFY(grid%fs_frac_landed)
ENDIF
IF ( ASSOCIATED( grid%fs_p_tvel ) ) THEN 
  DEALLOCATE(grid%fs_p_tvel,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_tvel. ')
 endif
  NULLIFY(grid%fs_p_tvel)
ENDIF
IF ( ASSOCIATED( grid%cfd1 ) ) THEN 
  DEALLOCATE(grid%cfd1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cfd1. ')
 endif
  NULLIFY(grid%cfd1)
ENDIF
IF ( ASSOCIATED( grid%ru_tendf_stoch ) ) THEN 
  DEALLOCATE(grid%ru_tendf_stoch,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ru_tendf_stoch. ')
 endif
  NULLIFY(grid%ru_tendf_stoch)
ENDIF
IF ( ASSOCIATED( grid%spstream_amp ) ) THEN 
  DEALLOCATE(grid%spstream_amp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spstream_amp. ')
 endif
  NULLIFY(grid%spstream_amp)
ENDIF
IF ( ASSOCIATED( grid%sp_amp3 ) ) THEN 
  DEALLOCATE(grid%sp_amp3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp3. ')
 endif
  NULLIFY(grid%sp_amp3)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_sppt ) ) THEN 
  DEALLOCATE(grid%iseedarr_sppt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_sppt. ')
 endif
  NULLIFY(grid%iseedarr_sppt)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_mult3d ) ) THEN 
  DEALLOCATE(grid%iseedarr_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_mult3d. ')
 endif
  NULLIFY(grid%iseedarr_mult3d)
ENDIF
IF ( ASSOCIATED( grid%spforcc3d ) ) THEN 
  DEALLOCATE(grid%spforcc3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcc3d. ')
 endif
  NULLIFY(grid%spforcc3d)
ENDIF
IF ( ASSOCIATED( grid%tpert2d ) ) THEN 
  DEALLOCATE(grid%tpert2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tpert2d. ')
 endif
  NULLIFY(grid%tpert2d)
ENDIF
IF ( ASSOCIATED( grid%zmdliq ) ) THEN 
  DEALLOCATE(grid%zmdliq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmdliq. ')
 endif
  NULLIFY(grid%zmdliq)
ENDIF
IF ( ASSOCIATED( grid%pconvb ) ) THEN 
  DEALLOCATE(grid%pconvb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pconvb. ')
 endif
  NULLIFY(grid%pconvb)
ENDIF
IF ( ASSOCIATED( grid%zmicud ) ) THEN 
  DEALLOCATE(grid%zmicud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmicud. ')
 endif
  NULLIFY(grid%zmicud)
ENDIF
IF ( ASSOCIATED( grid%dsubcld2d ) ) THEN 
  DEALLOCATE(grid%dsubcld2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dsubcld2d. ')
 endif
  NULLIFY(grid%dsubcld2d)
ENDIF
IF ( ASSOCIATED( grid%icwmrsh ) ) THEN 
  DEALLOCATE(grid%icwmrsh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icwmrsh. ')
 endif
  NULLIFY(grid%icwmrsh)
ENDIF
IF ( ASSOCIATED( grid%uten_cu ) ) THEN 
  DEALLOCATE(grid%uten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uten_cu. ')
 endif
  NULLIFY(grid%uten_cu)
ENDIF
IF ( ASSOCIATED( grid%plfc_cu ) ) THEN 
  DEALLOCATE(grid%plfc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%plfc_cu. ')
 endif
  NULLIFY(grid%plfc_cu)
ENDIF
IF ( ASSOCIATED( grid%rcwp_cu ) ) THEN 
  DEALLOCATE(grid%rcwp_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rcwp_cu. ')
 endif
  NULLIFY(grid%rcwp_cu)
ENDIF
IF ( ASSOCIATED( grid%thlu_emf_cu ) ) THEN 
  DEALLOCATE(grid%thlu_emf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thlu_emf_cu. ')
 endif
  NULLIFY(grid%thlu_emf_cu)
ENDIF
IF ( ASSOCIATED( grid%diten_cu ) ) THEN 
  DEALLOCATE(grid%diten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%diten_cu. ')
 endif
  NULLIFY(grid%diten_cu)
ENDIF
IF ( ASSOCIATED( grid%cquad_cu ) ) THEN 
  DEALLOCATE(grid%cquad_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cquad_cu. ')
 endif
  NULLIFY(grid%cquad_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_kinv1_cu ) ) THEN 
  DEALLOCATE(grid%exit_kinv1_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_kinv1_cu. ')
 endif
  NULLIFY(grid%exit_kinv1_cu)
ENDIF
IF ( ASSOCIATED( grid%rh_old_mp ) ) THEN 
  DEALLOCATE(grid%rh_old_mp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_old_mp. ')
 endif
  NULLIFY(grid%rh_old_mp)
ENDIF
IF ( ASSOCIATED( grid%nump ) ) THEN 
  DEALLOCATE(grid%nump,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nump. ')
 endif
  NULLIFY(grid%nump)
ENDIF
IF ( ASSOCIATED( grid%t_grnd ) ) THEN 
  DEALLOCATE(grid%t_grnd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_grnd. ')
 endif
  NULLIFY(grid%t_grnd)
ENDIF
IF ( ASSOCIATED( grid%h2ocan ) ) THEN 
  DEALLOCATE(grid%h2ocan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2ocan. ')
 endif
  NULLIFY(grid%h2ocan)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq1 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq1. ')
 endif
  NULLIFY(grid%h2osoi_liq1)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice_s3 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice_s3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice_s3. ')
 endif
  NULLIFY(grid%h2osoi_ice_s3)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice10 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice10. ')
 endif
  NULLIFY(grid%h2osoi_ice10)
ENDIF
IF ( ASSOCIATED( grid%t_soisno7 ) ) THEN 
  DEALLOCATE(grid%t_soisno7,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno7. ')
 endif
  NULLIFY(grid%t_soisno7)
ENDIF
IF ( ASSOCIATED( grid%snowrds4 ) ) THEN 
  DEALLOCATE(grid%snowrds4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowrds4. ')
 endif
  NULLIFY(grid%snowrds4)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol1 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol1. ')
 endif
  NULLIFY(grid%h2osoi_vol1)
ENDIF
IF ( ASSOCIATED( grid%hfxsubgrid ) ) THEN 
  DEALLOCATE(grid%hfxsubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfxsubgrid. ')
 endif
  NULLIFY(grid%hfxsubgrid)
ENDIF
IF ( ASSOCIATED( grid%snl2d ) ) THEN 
  DEALLOCATE(grid%snl2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snl2d. ')
 endif
  NULLIFY(grid%snl2d)
ENDIF
IF ( ASSOCIATED( grid%zi3d ) ) THEN 
  DEALLOCATE(grid%zi3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zi3d. ')
 endif
  NULLIFY(grid%zi3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_fh ) ) THEN 
  DEALLOCATE(grid%ssib_fh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_fh. ')
 endif
  NULLIFY(grid%ssib_fh)
ENDIF
IF ( ASSOCIATED( grid%ssib_sdn ) ) THEN 
  DEALLOCATE(grid%ssib_sdn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_sdn. ')
 endif
  NULLIFY(grid%ssib_sdn)
ENDIF
IF ( ASSOCIATED( grid%swe ) ) THEN 
  DEALLOCATE(grid%swe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swe. ')
 endif
  NULLIFY(grid%swe)
ENDIF
IF ( ASSOCIATED( grid%flo1 ) ) THEN 
  DEALLOCATE(grid%flo1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flo1. ')
 endif
  NULLIFY(grid%flo1)
ENDIF
IF ( ASSOCIATED( grid%flo2 ) ) THEN 
  DEALLOCATE(grid%flo2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flo2. ')
 endif
  NULLIFY(grid%flo2)
ENDIF
IF ( ASSOCIATED( grid%flo3 ) ) THEN 
  DEALLOCATE(grid%flo3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flo3. ')
 endif
  NULLIFY(grid%flo3)
ENDIF
IF ( ASSOCIATED( grid%flo4 ) ) THEN 
  DEALLOCATE(grid%flo4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flo4. ')
 endif
  NULLIFY(grid%flo4)
ENDIF
IF ( ASSOCIATED( grid%chxy ) ) THEN 
  DEALLOCATE(grid%chxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chxy. ')
 endif
  NULLIFY(grid%chxy)
ENDIF
IF ( ASSOCIATED( grid%snicexy ) ) THEN 
  DEALLOCATE(grid%snicexy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snicexy. ')
 endif
  NULLIFY(grid%snicexy)
ENDIF
IF ( ASSOCIATED( grid%q2mvxy ) ) THEN 
  DEALLOCATE(grid%q2mvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2mvxy. ')
 endif
  NULLIFY(grid%q2mvxy)
ENDIF
IF ( ASSOCIATED( grid%etranxy ) ) THEN 
  DEALLOCATE(grid%etranxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%etranxy. ')
 endif
  NULLIFY(grid%etranxy)
ENDIF
IF ( ASSOCIATED( grid%tgbxy ) ) THEN 
  DEALLOCATE(grid%tgbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgbxy. ')
 endif
  NULLIFY(grid%tgbxy)
ENDIF
IF ( ASSOCIATED( grid%irbxy ) ) THEN 
  DEALLOCATE(grid%irbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irbxy. ')
 endif
  NULLIFY(grid%irbxy)
ENDIF
IF ( ASSOCIATED( grid%acrech ) ) THEN 
  DEALLOCATE(grid%acrech,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acrech. ')
 endif
  NULLIFY(grid%acrech)
ENDIF
IF ( ASSOCIATED( grid%fdepthxy ) ) THEN 
  DEALLOCATE(grid%fdepthxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fdepthxy. ')
 endif
  NULLIFY(grid%fdepthxy)
ENDIF
IF ( ASSOCIATED( grid%qsubcxy ) ) THEN 
  DEALLOCATE(grid%qsubcxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsubcxy. ')
 endif
  NULLIFY(grid%qsubcxy)
ENDIF
IF ( ASSOCIATED( grid%pahbxy ) ) THEN 
  DEALLOCATE(grid%pahbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pahbxy. ')
 endif
  NULLIFY(grid%pahbxy)
ENDIF
IF ( ASSOCIATED( grid%acdripr ) ) THEN 
  DEALLOCATE(grid%acdripr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acdripr. ')
 endif
  NULLIFY(grid%acdripr)
ENDIF
IF ( ASSOCIATED( grid%acecan ) ) THEN 
  DEALLOCATE(grid%acecan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acecan. ')
 endif
  NULLIFY(grid%acecan)
ENDIF
IF ( ASSOCIATED( grid%acsnmelt ) ) THEN 
  DEALLOCATE(grid%acsnmelt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnmelt. ')
 endif
  NULLIFY(grid%acsnmelt)
ENDIF
IF ( ASSOCIATED( grid%acpahb ) ) THEN 
  DEALLOCATE(grid%acpahb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acpahb. ')
 endif
  NULLIFY(grid%acpahb)
ENDIF
IF ( ASSOCIATED( grid%acpahv ) ) THEN 
  DEALLOCATE(grid%acpahv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acpahv. ')
 endif
  NULLIFY(grid%acpahv)
ENDIF
IF ( ASSOCIATED( grid%acc_ssoil ) ) THEN 
  DEALLOCATE(grid%acc_ssoil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_ssoil. ')
 endif
  NULLIFY(grid%acc_ssoil)
ENDIF
IF ( ASSOCIATED( grid%gddxy ) ) THEN 
  DEALLOCATE(grid%gddxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gddxy. ')
 endif
  NULLIFY(grid%gddxy)
ENDIF
IF ( ASSOCIATED( grid%mifract ) ) THEN 
  DEALLOCATE(grid%mifract,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mifract. ')
 endif
  NULLIFY(grid%mifract)
ENDIF
IF ( ASSOCIATED( grid%irrsplh ) ) THEN 
  DEALLOCATE(grid%irrsplh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irrsplh. ')
 endif
  NULLIFY(grid%irrsplh)
ENDIF
IF ( ASSOCIATED( grid%kext_ft_qs ) ) THEN 
  DEALLOCATE(grid%kext_ft_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ft_qs. ')
 endif
  NULLIFY(grid%kext_ft_qs)
ENDIF
IF ( ASSOCIATED( grid%vil ) ) THEN 
  DEALLOCATE(grid%vil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vil. ')
 endif
  NULLIFY(grid%vil)
ENDIF
IF ( ASSOCIATED( grid%afwa_mslp ) ) THEN 
  DEALLOCATE(grid%afwa_mslp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_mslp. ')
 endif
  NULLIFY(grid%afwa_mslp)
ENDIF
IF ( ASSOCIATED( grid%afwa_totprecip ) ) THEN 
  DEALLOCATE(grid%afwa_totprecip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_totprecip. ')
 endif
  NULLIFY(grid%afwa_totprecip)
ENDIF
IF ( ASSOCIATED( grid%afwa_cin ) ) THEN 
  DEALLOCATE(grid%afwa_cin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cin. ')
 endif
  NULLIFY(grid%afwa_cin)
ENDIF
IF ( ASSOCIATED( grid%tornado_mask ) ) THEN 
  DEALLOCATE(grid%tornado_mask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tornado_mask. ')
 endif
  NULLIFY(grid%tornado_mask)
ENDIF
IF ( ASSOCIATED( grid%psfc_mean ) ) THEN 
  DEALLOCATE(grid%psfc_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc_mean. ')
 endif
  NULLIFY(grid%psfc_mean)
ENDIF
IF ( ASSOCIATED( grid%lwupb_mean ) ) THEN 
  DEALLOCATE(grid%lwupb_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupb_mean. ')
 endif
  NULLIFY(grid%lwupb_mean)
ENDIF
IF ( ASSOCIATED( grid%q2_diurn ) ) THEN 
  DEALLOCATE(grid%q2_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2_diurn. ')
 endif
  NULLIFY(grid%q2_diurn)
ENDIF
IF ( ASSOCIATED( grid%lwdnt_diurn ) ) THEN 
  DEALLOCATE(grid%lwdnt_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnt_diurn. ')
 endif
  NULLIFY(grid%lwdnt_diurn)
ENDIF
IF ( ASSOCIATED( grid%swdnb_dtmp ) ) THEN 
  DEALLOCATE(grid%swdnb_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnb_dtmp. ')
 endif
  NULLIFY(grid%swdnb_dtmp)
ENDIF
IF ( ASSOCIATED( grid%sctot ) ) THEN 
  DEALLOCATE(grid%sctot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sctot. ')
 endif
  NULLIFY(grid%sctot)
ENDIF
IF ( ASSOCIATED( grid%pc_bxs ) ) THEN 
  DEALLOCATE(grid%pc_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_bxs. ')
 endif
  NULLIFY(grid%pc_bxs)
ENDIF
IF ( ASSOCIATED( grid%pc_bxe ) ) THEN 
  DEALLOCATE(grid%pc_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_bxe. ')
 endif
  NULLIFY(grid%pc_bxe)
ENDIF
IF ( ASSOCIATED( grid%pc_bys ) ) THEN 
  DEALLOCATE(grid%pc_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_bys. ')
 endif
  NULLIFY(grid%pc_bys)
ENDIF
IF ( ASSOCIATED( grid%pc_bye ) ) THEN 
  DEALLOCATE(grid%pc_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_bye. ')
 endif
  NULLIFY(grid%pc_bye)
ENDIF
IF ( ASSOCIATED( grid%p_wif_feb ) ) THEN 
  DEALLOCATE(grid%p_wif_feb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_feb. ')
 endif
  NULLIFY(grid%p_wif_feb)
ENDIF
IF ( ASSOCIATED( grid%w_wif_jan ) ) THEN 
  DEALLOCATE(grid%w_wif_jan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_jan. ')
 endif
  NULLIFY(grid%w_wif_jan)
ENDIF
IF ( ASSOCIATED( grid%i_wif_now ) ) THEN 
  DEALLOCATE(grid%i_wif_now,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_now. ')
 endif
  NULLIFY(grid%i_wif_now)
ENDIF
IF ( ASSOCIATED( grid%i_wif_dec ) ) THEN 
  DEALLOCATE(grid%i_wif_dec,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_dec. ')
 endif
  NULLIFY(grid%i_wif_dec)
ENDIF
IF ( ASSOCIATED( grid%b_wif_nov ) ) THEN 
  DEALLOCATE(grid%b_wif_nov,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_nov. ')
 endif
  NULLIFY(grid%b_wif_nov)
ENDIF
IF ( ASSOCIATED( grid%liqrain ) ) THEN 
  DEALLOCATE(grid%liqrain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%liqrain. ')
 endif
  NULLIFY(grid%liqrain)
ENDIF
IF ( ASSOCIATED( grid%wp_sum ) ) THEN 
  DEALLOCATE(grid%wp_sum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wp_sum. ')
 endif
  NULLIFY(grid%wp_sum)
ENDIF
IF ( ASSOCIATED( grid%tau_qc_tot ) ) THEN 
  DEALLOCATE(grid%tau_qc_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_qc_tot. ')
 endif
  NULLIFY(grid%tau_qc_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_iwp ) ) THEN 
  DEALLOCATE(grid%ts_iwp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_iwp. ')
 endif
  NULLIFY(grid%ts_iwp)
ENDIF
IF ( ASSOCIATED( grid%ts_tau_qi ) ) THEN 
  DEALLOCATE(grid%ts_tau_qi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tau_qi. ')
 endif
  NULLIFY(grid%ts_tau_qi)
ENDIF
IF ( ASSOCIATED( grid%ts_swddni ) ) THEN 
  DEALLOCATE(grid%ts_swddni,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddni. ')
 endif
  NULLIFY(grid%ts_swddni)
ENDIF
IF ( ASSOCIATED( grid%td_pl ) ) THEN 
  DEALLOCATE(grid%td_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%td_pl. ')
 endif
  NULLIFY(grid%td_pl)
ENDIF
IF ( ASSOCIATED( grid%rh_zl ) ) THEN 
  DEALLOCATE(grid%rh_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_zl. ')
 endif
  NULLIFY(grid%rh_zl)
ENDIF
IF ( ASSOCIATED( grid%mcm_co2_tend ) ) THEN 
  DEALLOCATE(grid%mcm_co2_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_co2_tend. ')
 endif
  NULLIFY(grid%mcm_co2_tend)
ENDIF
IF ( ASSOCIATED( grid%mcm_tau13_q ) ) THEN 
  DEALLOCATE(grid%mcm_tau13_q,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_tau13_q. ')
 endif
  NULLIFY(grid%mcm_tau13_q)
ENDIF
IF ( ASSOCIATED( grid%prtseed ) ) THEN 
  DEALLOCATE(grid%prtseed,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prtseed. ')
 endif
  NULLIFY(grid%prtseed)
ENDIF
END SUBROUTINE deallocs_5
!ENDOFREGISTRYGENERATEDINCLUDE
