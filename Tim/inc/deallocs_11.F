!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_11.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_11( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%traj_long ) ) THEN 
  DEALLOCATE(grid%traj_long,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%traj_long. ')
 endif
  NULLIFY(grid%traj_long)
ENDIF
IF ( ASSOCIATED( grid%var_sso ) ) THEN 
  DEALLOCATE(grid%var_sso,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%var_sso. ')
 endif
  NULLIFY(grid%var_sso)
ENDIF
IF ( ASSOCIATED( grid%pdrho_gc ) ) THEN 
  DEALLOCATE(grid%pdrho_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pdrho_gc. ')
 endif
  NULLIFY(grid%pdrho_gc)
ENDIF
IF ( ASSOCIATED( grid%qs_gc ) ) THEN 
  DEALLOCATE(grid%qs_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qs_gc. ')
 endif
  NULLIFY(grid%qs_gc)
ENDIF
IF ( ASSOCIATED( grid%t_max_p ) ) THEN 
  DEALLOCATE(grid%t_max_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_max_p. ')
 endif
  NULLIFY(grid%t_max_p)
ENDIF
IF ( ASSOCIATED( grid%tmaxw ) ) THEN 
  DEALLOCATE(grid%tmaxw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tmaxw. ')
 endif
  NULLIFY(grid%tmaxw)
ENDIF
IF ( ASSOCIATED( grid%ru ) ) THEN 
  DEALLOCATE(grid%ru,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ru. ')
 endif
  NULLIFY(grid%ru)
ENDIF
IF ( ASSOCIATED( grid%rv ) ) THEN 
  DEALLOCATE(grid%rv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv. ')
 endif
  NULLIFY(grid%rv)
ENDIF
IF ( ASSOCIATED( grid%ph_btxs ) ) THEN 
  DEALLOCATE(grid%ph_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_btxs. ')
 endif
  NULLIFY(grid%ph_btxs)
ENDIF
IF ( ASSOCIATED( grid%ph_btxe ) ) THEN 
  DEALLOCATE(grid%ph_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_btxe. ')
 endif
  NULLIFY(grid%ph_btxe)
ENDIF
IF ( ASSOCIATED( grid%ph_btys ) ) THEN 
  DEALLOCATE(grid%ph_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_btys. ')
 endif
  NULLIFY(grid%ph_btys)
ENDIF
IF ( ASSOCIATED( grid%ph_btye ) ) THEN 
  DEALLOCATE(grid%ph_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_btye. ')
 endif
  NULLIFY(grid%ph_btye)
ENDIF
IF ( ASSOCIATED( grid%t_init ) ) THEN 
  DEALLOCATE(grid%t_init,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_init. ')
 endif
  NULLIFY(grid%t_init)
ENDIF
IF ( ASSOCIATED( grid%qv_upstream_y_tend ) ) THEN 
  DEALLOCATE(grid%qv_upstream_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_upstream_y_tend. ')
 endif
  NULLIFY(grid%qv_upstream_y_tend)
ENDIF
IF ( ASSOCIATED( grid%v_upstream_y_tend ) ) THEN 
  DEALLOCATE(grid%v_upstream_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_upstream_y_tend. ')
 endif
  NULLIFY(grid%v_upstream_y_tend)
ENDIF
IF ( ASSOCIATED( grid%v_largescale_tend ) ) THEN 
  DEALLOCATE(grid%v_largescale_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_largescale_tend. ')
 endif
  NULLIFY(grid%v_largescale_tend)
ENDIF
IF ( ASSOCIATED( grid%soil_depth_force ) ) THEN 
  DEALLOCATE(grid%soil_depth_force,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soil_depth_force. ')
 endif
  NULLIFY(grid%soil_depth_force)
ENDIF
IF ( ASSOCIATED( grid%mub_save ) ) THEN 
  DEALLOCATE(grid%mub_save,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mub_save. ')
 endif
  NULLIFY(grid%mub_save)
ENDIF
IF ( ASSOCIATED( grid%xkmv_meso ) ) THEN 
  DEALLOCATE(grid%xkmv_meso,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xkmv_meso. ')
 endif
  NULLIFY(grid%xkmv_meso)
ENDIF
IF ( ASSOCIATED( grid%rdn ) ) THEN 
  DEALLOCATE(grid%rdn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rdn. ')
 endif
  NULLIFY(grid%rdn)
ENDIF
IF ( ASSOCIATED( grid%u10 ) ) THEN 
  DEALLOCATE(grid%u10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10. ')
 endif
  NULLIFY(grid%u10)
ENDIF
IF ( ASSOCIATED( grid%qnifa2d ) ) THEN 
  DEALLOCATE(grid%qnifa2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnifa2d. ')
 endif
  NULLIFY(grid%qnifa2d)
ENDIF
IF ( ASSOCIATED( grid%re_hail_gsfc ) ) THEN 
  DEALLOCATE(grid%re_hail_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_hail_gsfc. ')
 endif
  NULLIFY(grid%re_hail_gsfc)
ENDIF
IF ( ASSOCIATED( grid%st ) ) THEN 
  DEALLOCATE(grid%st,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st. ')
 endif
  NULLIFY(grid%st)
ENDIF
IF ( ASSOCIATED( grid%st100255 ) ) THEN 
  DEALLOCATE(grid%st100255,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st100255. ')
 endif
  NULLIFY(grid%st100255)
ENDIF
IF ( ASSOCIATED( grid%sw000010 ) ) THEN 
  DEALLOCATE(grid%sw000010,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw000010. ')
 endif
  NULLIFY(grid%sw000010)
ENDIF
IF ( ASSOCIATED( grid%st010040 ) ) THEN 
  DEALLOCATE(grid%st010040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st010040. ')
 endif
  NULLIFY(grid%st010040)
ENDIF
IF ( ASSOCIATED( grid%toposlpy ) ) THEN 
  DEALLOCATE(grid%toposlpy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%toposlpy. ')
 endif
  NULLIFY(grid%toposlpy)
ENDIF
IF ( ASSOCIATED( grid%pct_pft_input ) ) THEN 
  DEALLOCATE(grid%pct_pft_input,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pct_pft_input. ')
 endif
  NULLIFY(grid%pct_pft_input)
ENDIF
IF ( ASSOCIATED( grid%ts_hfx ) ) THEN 
  DEALLOCATE(grid%ts_hfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_hfx. ')
 endif
  NULLIFY(grid%ts_hfx)
ENDIF
IF ( ASSOCIATED( grid%ts_qv_profile ) ) THEN 
  DEALLOCATE(grid%ts_qv_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_qv_profile. ')
 endif
  NULLIFY(grid%ts_qv_profile)
ENDIF
IF ( ASSOCIATED( grid%lf_urb2d ) ) THEN 
  DEALLOCATE(grid%lf_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lf_urb2d. ')
 endif
  NULLIFY(grid%lf_urb2d)
ENDIF
IF ( ASSOCIATED( grid%sfcheadrt ) ) THEN 
  DEALLOCATE(grid%sfcheadrt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfcheadrt. ')
 endif
  NULLIFY(grid%sfcheadrt)
ENDIF
IF ( ASSOCIATED( grid%sfcexc ) ) THEN 
  DEALLOCATE(grid%sfcexc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfcexc. ')
 endif
  NULLIFY(grid%sfcexc)
ENDIF
IF ( ASSOCIATED( grid%xlaidyn ) ) THEN 
  DEALLOCATE(grid%xlaidyn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlaidyn. ')
 endif
  NULLIFY(grid%xlaidyn)
ENDIF
IF ( ASSOCIATED( grid%dfi_phb ) ) THEN 
  DEALLOCATE(grid%dfi_phb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_phb. ')
 endif
  NULLIFY(grid%dfi_phb)
ENDIF
IF ( ASSOCIATED( grid%dfi_tke ) ) THEN 
  DEALLOCATE(grid%dfi_tke,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_tke. ')
 endif
  NULLIFY(grid%dfi_tke)
ENDIF
IF ( ASSOCIATED( grid%tb_urb2d ) ) THEN 
  DEALLOCATE(grid%tb_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tb_urb2d. ')
 endif
  NULLIFY(grid%tb_urb2d)
ENDIF
IF ( ASSOCIATED( grid%drelg_urb2d ) ) THEN 
  DEALLOCATE(grid%drelg_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%drelg_urb2d. ')
 endif
  NULLIFY(grid%drelg_urb2d)
ENDIF
IF ( ASSOCIATED( grid%rn_urb2d ) ) THEN 
  DEALLOCATE(grid%rn_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rn_urb2d. ')
 endif
  NULLIFY(grid%rn_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tglev_urb3d ) ) THEN 
  DEALLOCATE(grid%tglev_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tglev_urb3d. ')
 endif
  NULLIFY(grid%tglev_urb3d)
ENDIF
IF ( ASSOCIATED( grid%sfg_urb3d ) ) THEN 
  DEALLOCATE(grid%sfg_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfg_urb3d. ')
 endif
  NULLIFY(grid%sfg_urb3d)
ENDIF
IF ( ASSOCIATED( grid%dg_urb3d ) ) THEN 
  DEALLOCATE(grid%dg_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dg_urb3d. ')
 endif
  NULLIFY(grid%dg_urb3d)
ENDIF
IF ( ASSOCIATED( grid%swnirdir ) ) THEN 
  DEALLOCATE(grid%swnirdir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swnirdir. ')
 endif
  NULLIFY(grid%swnirdir)
ENDIF
IF ( ASSOCIATED( grid%imperv ) ) THEN 
  DEALLOCATE(grid%imperv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%imperv. ')
 endif
  NULLIFY(grid%imperv)
ENDIF
IF ( ASSOCIATED( grid%fh ) ) THEN 
  DEALLOCATE(grid%fh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fh. ')
 endif
  NULLIFY(grid%fh)
ENDIF
IF ( ASSOCIATED( grid%thz0 ) ) THEN 
  DEALLOCATE(grid%thz0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thz0. ')
 endif
  NULLIFY(grid%thz0)
ENDIF
IF ( ASSOCIATED( grid%tshltr ) ) THEN 
  DEALLOCATE(grid%tshltr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tshltr. ')
 endif
  NULLIFY(grid%tshltr)
ENDIF
IF ( ASSOCIATED( grid%rt_up ) ) THEN 
  DEALLOCATE(grid%rt_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rt_up. ')
 endif
  NULLIFY(grid%rt_up)
ENDIF
IF ( ASSOCIATED( grid%vw_temf ) ) THEN 
  DEALLOCATE(grid%vw_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vw_temf. ')
 endif
  NULLIFY(grid%vw_temf)
ENDIF
IF ( ASSOCIATED( grid%qke ) ) THEN 
  DEALLOCATE(grid%qke,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qke. ')
 endif
  NULLIFY(grid%qke)
ENDIF
IF ( ASSOCIATED( grid%edmf_a ) ) THEN 
  DEALLOCATE(grid%edmf_a,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_a. ')
 endif
  NULLIFY(grid%edmf_a)
ENDIF
IF ( ASSOCIATED( grid%maxmf ) ) THEN 
  DEALLOCATE(grid%maxmf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%maxmf. ')
 endif
  NULLIFY(grid%maxmf)
ENDIF
IF ( ASSOCIATED( grid%oa2 ) ) THEN 
  DEALLOCATE(grid%oa2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa2. ')
 endif
  NULLIFY(grid%oa2)
ENDIF
IF ( ASSOCIATED( grid%dtauy3d_ss ) ) THEN 
  DEALLOCATE(grid%dtauy3d_ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtauy3d_ss. ')
 endif
  NULLIFY(grid%dtauy3d_ss)
ENDIF
IF ( ASSOCIATED( grid%oc12dls ) ) THEN 
  DEALLOCATE(grid%oc12dls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oc12dls. ')
 endif
  NULLIFY(grid%oc12dls)
ENDIF
IF ( ASSOCIATED( grid%oa2ss ) ) THEN 
  DEALLOCATE(grid%oa2ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa2ss. ')
 endif
  NULLIFY(grid%oa2ss)
ENDIF
IF ( ASSOCIATED( grid%a_q_bep ) ) THEN 
  DEALLOCATE(grid%a_q_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%a_q_bep. ')
 endif
  NULLIFY(grid%a_q_bep)
ENDIF
IF ( ASSOCIATED( grid%el_pbl ) ) THEN 
  DEALLOCATE(grid%el_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%el_pbl. ')
 endif
  NULLIFY(grid%el_pbl)
ENDIF
IF ( ASSOCIATED( grid%cutop ) ) THEN 
  DEALLOCATE(grid%cutop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cutop. ')
 endif
  NULLIFY(grid%cutop)
ENDIF
IF ( ASSOCIATED( grid%ncfrcv ) ) THEN 
  DEALLOCATE(grid%ncfrcv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ncfrcv. ')
 endif
  NULLIFY(grid%ncfrcv)
ENDIF
IF ( ASSOCIATED( grid%pin ) ) THEN 
  DEALLOCATE(grid%pin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pin. ')
 endif
  NULLIFY(grid%pin)
ENDIF
IF ( ASSOCIATED( grid%om_v ) ) THEN 
  DEALLOCATE(grid%om_v,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_v. ')
 endif
  NULLIFY(grid%om_v)
ENDIF
IF ( ASSOCIATED( grid%taucloud ) ) THEN 
  DEALLOCATE(grid%taucloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taucloud. ')
 endif
  NULLIFY(grid%taucloud)
ENDIF
IF ( ASSOCIATED( grid%wact_cup ) ) THEN 
  DEALLOCATE(grid%wact_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wact_cup. ')
 endif
  NULLIFY(grid%wact_cup)
ENDIF
IF ( ASSOCIATED( grid%h_diabatic ) ) THEN 
  DEALLOCATE(grid%h_diabatic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h_diabatic. ')
 endif
  NULLIFY(grid%h_diabatic)
ENDIF
IF ( ASSOCIATED( grid%msfvy ) ) THEN 
  DEALLOCATE(grid%msfvy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfvy. ')
 endif
  NULLIFY(grid%msfvy)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_btxs ) ) THEN 
  DEALLOCATE(grid%ht_shad_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_btxs. ')
 endif
  NULLIFY(grid%ht_shad_btxs)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_btxe ) ) THEN 
  DEALLOCATE(grid%ht_shad_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_btxe. ')
 endif
  NULLIFY(grid%ht_shad_btxe)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_btys ) ) THEN 
  DEALLOCATE(grid%ht_shad_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_btys. ')
 endif
  NULLIFY(grid%ht_shad_btys)
ENDIF
IF ( ASSOCIATED( grid%ht_shad_btye ) ) THEN 
  DEALLOCATE(grid%ht_shad_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_shad_btye. ')
 endif
  NULLIFY(grid%ht_shad_btye)
ENDIF
IF ( ASSOCIATED( grid%physc ) ) THEN 
  DEALLOCATE(grid%physc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physc. ')
 endif
  NULLIFY(grid%physc)
ENDIF
IF ( ASSOCIATED( grid%acphysf ) ) THEN 
  DEALLOCATE(grid%acphysf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphysf. ')
 endif
  NULLIFY(grid%acphysf)
ENDIF
IF ( ASSOCIATED( grid%sswdn ) ) THEN 
  DEALLOCATE(grid%sswdn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sswdn. ')
 endif
  NULLIFY(grid%sswdn)
ENDIF
IF ( ASSOCIATED( grid%rqgshten ) ) THEN 
  DEALLOCATE(grid%rqgshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqgshten. ')
 endif
  NULLIFY(grid%rqgshten)
ENDIF
IF ( ASSOCIATED( grid%cldtopb ) ) THEN 
  DEALLOCATE(grid%cldtopb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldtopb. ')
 endif
  NULLIFY(grid%cldtopb)
ENDIF
IF ( ASSOCIATED( grid%tkeavg ) ) THEN 
  DEALLOCATE(grid%tkeavg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tkeavg. ')
 endif
  NULLIFY(grid%tkeavg)
ENDIF
IF ( ASSOCIATED( grid%w0avg ) ) THEN 
  DEALLOCATE(grid%w0avg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w0avg. ')
 endif
  NULLIFY(grid%w0avg)
ENDIF
IF ( ASSOCIATED( grid%rainncv ) ) THEN 
  DEALLOCATE(grid%rainncv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainncv. ')
 endif
  NULLIFY(grid%rainncv)
ENDIF
IF ( ASSOCIATED( grid%vmi3d ) ) THEN 
  DEALLOCATE(grid%vmi3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vmi3d. ')
 endif
  NULLIFY(grid%vmi3d)
ENDIF
IF ( ASSOCIATED( grid%itype ) ) THEN 
  DEALLOCATE(grid%itype,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%itype. ')
 endif
  NULLIFY(grid%itype)
ENDIF
IF ( ASSOCIATED( grid%timec_kf ) ) THEN 
  DEALLOCATE(grid%timec_kf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%timec_kf. ')
 endif
  NULLIFY(grid%timec_kf)
ENDIF
IF ( ASSOCIATED( grid%kbcon_shallow ) ) THEN 
  DEALLOCATE(grid%kbcon_shallow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kbcon_shallow. ')
 endif
  NULLIFY(grid%kbcon_shallow)
ENDIF
IF ( ASSOCIATED( grid%gd_cloud ) ) THEN 
  DEALLOCATE(grid%gd_cloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gd_cloud. ')
 endif
  NULLIFY(grid%gd_cloud)
ENDIF
IF ( ASSOCIATED( grid%ni_cu ) ) THEN 
  DEALLOCATE(grid%ni_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ni_cu. ')
 endif
  NULLIFY(grid%ni_cu)
ENDIF
IF ( ASSOCIATED( grid%ccn1_gs ) ) THEN 
  DEALLOCATE(grid%ccn1_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn1_gs. ')
 endif
  NULLIFY(grid%ccn1_gs)
ENDIF
IF ( ASSOCIATED( grid%swdown ) ) THEN 
  DEALLOCATE(grid%swdown,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdown. ')
 endif
  NULLIFY(grid%swdown)
ENDIF
IF ( ASSOCIATED( grid%swddni2 ) ) THEN 
  DEALLOCATE(grid%swddni2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddni2. ')
 endif
  NULLIFY(grid%swddni2)
ENDIF
IF ( ASSOCIATED( grid%aod5502d ) ) THEN 
  DEALLOCATE(grid%aod5502d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aod5502d. ')
 endif
  NULLIFY(grid%aod5502d)
ENDIF
IF ( ASSOCIATED( grid%t2std ) ) THEN 
  DEALLOCATE(grid%t2std,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2std. ')
 endif
  NULLIFY(grid%t2std)
ENDIF
IF ( ASSOCIATED( grid%skintempstd ) ) THEN 
  DEALLOCATE(grid%skintempstd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%skintempstd. ')
 endif
  NULLIFY(grid%skintempstd)
ENDIF
IF ( ASSOCIATED( grid%rainncvmax ) ) THEN 
  DEALLOCATE(grid%rainncvmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainncvmax. ')
 endif
  NULLIFY(grid%rainncvmax)
ENDIF
IF ( ASSOCIATED( grid%acswupb ) ) THEN 
  DEALLOCATE(grid%acswupb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswupb. ')
 endif
  NULLIFY(grid%acswupb)
ENDIF
IF ( ASSOCIATED( grid%i_acswupt ) ) THEN 
  DEALLOCATE(grid%i_acswupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswupt. ')
 endif
  NULLIFY(grid%i_acswupt)
ENDIF
IF ( ASSOCIATED( grid%i_aclwupb ) ) THEN 
  DEALLOCATE(grid%i_aclwupb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwupb. ')
 endif
  NULLIFY(grid%i_aclwupb)
ENDIF
IF ( ASSOCIATED( grid%swupbcln ) ) THEN 
  DEALLOCATE(grid%swupbcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupbcln. ')
 endif
  NULLIFY(grid%swupbcln)
ENDIF
IF ( ASSOCIATED( grid%lwupbcln ) ) THEN 
  DEALLOCATE(grid%lwupbcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupbcln. ')
 endif
  NULLIFY(grid%lwupbcln)
ENDIF
IF ( ASSOCIATED( grid%clat ) ) THEN 
  DEALLOCATE(grid%clat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%clat. ')
 endif
  NULLIFY(grid%clat)
ENDIF
IF ( ASSOCIATED( grid%rqcblten ) ) THEN 
  DEALLOCATE(grid%rqcblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqcblten. ')
 endif
  NULLIFY(grid%rqcblten)
ENDIF
IF ( ASSOCIATED( grid%canwat_mosaic ) ) THEN 
  DEALLOCATE(grid%canwat_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canwat_mosaic. ')
 endif
  NULLIFY(grid%canwat_mosaic)
ENDIF
IF ( ASSOCIATED( grid%hfx_mosaic ) ) THEN 
  DEALLOCATE(grid%hfx_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx_mosaic. ')
 endif
  NULLIFY(grid%hfx_mosaic)
ENDIF
IF ( ASSOCIATED( grid%uc_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%uc_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uc_urb2d_mosaic. ')
 endif
  NULLIFY(grid%uc_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tbpvs0_state ) ) THEN 
  DEALLOCATE(grid%tbpvs0_state,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tbpvs0_state. ')
 endif
  NULLIFY(grid%tbpvs0_state)
ENDIF
IF ( ASSOCIATED( grid%cplmask ) ) THEN 
  DEALLOCATE(grid%cplmask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cplmask. ')
 endif
  NULLIFY(grid%cplmask)
ENDIF
IF ( ASSOCIATED( grid%capg ) ) THEN 
  DEALLOCATE(grid%capg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%capg. ')
 endif
  NULLIFY(grid%capg)
ENDIF
IF ( ASSOCIATED( grid%dfi_qvg ) ) THEN 
  DEALLOCATE(grid%dfi_qvg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_qvg. ')
 endif
  NULLIFY(grid%dfi_qvg)
ENDIF
IF ( ASSOCIATED( grid%sr ) ) THEN 
  DEALLOCATE(grid%sr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sr. ')
 endif
  NULLIFY(grid%sr)
ENDIF
IF ( ASSOCIATED( grid%defor23 ) ) THEN 
  DEALLOCATE(grid%defor23,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%defor23. ')
 endif
  NULLIFY(grid%defor23)
ENDIF
IF ( ASSOCIATED( grid%rvndgdten ) ) THEN 
  DEALLOCATE(grid%rvndgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rvndgdten. ')
 endif
  NULLIFY(grid%rvndgdten)
ENDIF
IF ( ASSOCIATED( grid%t2_ndg_new ) ) THEN 
  DEALLOCATE(grid%t2_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_ndg_new. ')
 endif
  NULLIFY(grid%t2_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%odis_ndg_old ) ) THEN 
  DEALLOCATE(grid%odis_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%odis_ndg_old. ')
 endif
  NULLIFY(grid%odis_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%abstot ) ) THEN 
  DEALLOCATE(grid%abstot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%abstot. ')
 endif
  NULLIFY(grid%abstot)
ENDIF
IF ( ASSOCIATED( grid%w_mean ) ) THEN 
  DEALLOCATE(grid%w_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_mean. ')
 endif
  NULLIFY(grid%w_mean)
ENDIF
IF ( ASSOCIATED( grid%advh_t ) ) THEN 
  DEALLOCATE(grid%advh_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%advh_t. ')
 endif
  NULLIFY(grid%advh_t)
ENDIF
IF ( ASSOCIATED( grid%track_u ) ) THEN 
  DEALLOCATE(grid%track_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_u. ')
 endif
  NULLIFY(grid%track_u)
ENDIF
IF ( ASSOCIATED( grid%track_qvapor ) ) THEN 
  DEALLOCATE(grid%track_qvapor,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_qvapor. ')
 endif
  NULLIFY(grid%track_qvapor)
ENDIF
IF ( ASSOCIATED( grid%aqvshten ) ) THEN 
  DEALLOCATE(grid%aqvshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aqvshten. ')
 endif
  NULLIFY(grid%aqvshten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_wdur ) ) THEN 
  DEALLOCATE(grid%hailcast_wdur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_wdur. ')
 endif
  NULLIFY(grid%hailcast_wdur)
ENDIF
IF ( ASSOCIATED( grid%v_xxx ) ) THEN 
  DEALLOCATE(grid%v_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_xxx. ')
 endif
  NULLIFY(grid%v_xxx)
ENDIF
IF ( ASSOCIATED( grid%dif_yyy ) ) THEN 
  DEALLOCATE(grid%dif_yyy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dif_yyy. ')
 endif
  NULLIFY(grid%dif_yyy)
ENDIF
IF ( ASSOCIATED( grid%lfn_hist ) ) THEN 
  DEALLOCATE(grid%lfn_hist,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_hist. ')
 endif
  NULLIFY(grid%lfn_hist)
ENDIF
IF ( ASSOCIATED( grid%canhfx ) ) THEN 
  DEALLOCATE(grid%canhfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canhfx. ')
 endif
  NULLIFY(grid%canhfx)
ENDIF
IF ( ASSOCIATED( grid%lfn_s2 ) ) THEN 
  DEALLOCATE(grid%lfn_s2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_s2. ')
 endif
  NULLIFY(grid%lfn_s2)
ENDIF
IF ( ASSOCIATED( grid%flame_length ) ) THEN 
  DEALLOCATE(grid%flame_length,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flame_length. ')
 endif
  NULLIFY(grid%flame_length)
ENDIF
IF ( ASSOCIATED( grid%rh_fire ) ) THEN 
  DEALLOCATE(grid%rh_fire,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_fire. ')
 endif
  NULLIFY(grid%rh_fire)
ENDIF
IF ( ASSOCIATED( grid%fxlat ) ) THEN 
  DEALLOCATE(grid%fxlat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fxlat. ')
 endif
  NULLIFY(grid%fxlat)
ENDIF
IF ( ASSOCIATED( grid%tracer_bxs ) ) THEN 
  DEALLOCATE(grid%tracer_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_bxs. ')
 endif
  NULLIFY(grid%tracer_bxs)
ENDIF
IF ( ASSOCIATED( grid%tracer_bxe ) ) THEN 
  DEALLOCATE(grid%tracer_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_bxe. ')
 endif
  NULLIFY(grid%tracer_bxe)
ENDIF
IF ( ASSOCIATED( grid%tracer_bys ) ) THEN 
  DEALLOCATE(grid%tracer_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_bys. ')
 endif
  NULLIFY(grid%tracer_bys)
ENDIF
IF ( ASSOCIATED( grid%tracer_bye ) ) THEN 
  DEALLOCATE(grid%tracer_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_bye. ')
 endif
  NULLIFY(grid%tracer_bye)
ENDIF
IF ( ASSOCIATED( grid%fs_fire_area ) ) THEN 
  DEALLOCATE(grid%fs_fire_area,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_fire_area. ')
 endif
  NULLIFY(grid%fs_fire_area)
ENDIF
IF ( ASSOCIATED( grid%fs_p_y ) ) THEN 
  DEALLOCATE(grid%fs_p_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_y. ')
 endif
  NULLIFY(grid%fs_p_y)
ENDIF
IF ( ASSOCIATED( grid%avgflx_cfd1 ) ) THEN 
  DEALLOCATE(grid%avgflx_cfd1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_cfd1. ')
 endif
  NULLIFY(grid%avgflx_cfd1)
ENDIF
IF ( ASSOCIATED( grid%pattern_spp_lsm ) ) THEN 
  DEALLOCATE(grid%pattern_spp_lsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pattern_spp_lsm. ')
 endif
  NULLIFY(grid%pattern_spp_lsm)
ENDIF
IF ( ASSOCIATED( grid%sp_amp ) ) THEN 
  DEALLOCATE(grid%sp_amp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp. ')
 endif
  NULLIFY(grid%sp_amp)
ENDIF
IF ( ASSOCIATED( grid%sp_amp5 ) ) THEN 
  DEALLOCATE(grid%sp_amp5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp5. ')
 endif
  NULLIFY(grid%sp_amp5)
ENDIF
IF ( ASSOCIATED( grid%rand_real_xxx ) ) THEN 
  DEALLOCATE(grid%rand_real_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_real_xxx. ')
 endif
  NULLIFY(grid%rand_real_xxx)
ENDIF
IF ( ASSOCIATED( grid%gridpt_stddev_mult3d ) ) THEN 
  DEALLOCATE(grid%gridpt_stddev_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gridpt_stddev_mult3d. ')
 endif
  NULLIFY(grid%gridpt_stddev_mult3d)
ENDIF
IF ( ASSOCIATED( grid%vertampt3d ) ) THEN 
  DEALLOCATE(grid%vertampt3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertampt3d. ')
 endif
  NULLIFY(grid%vertampt3d)
ENDIF
IF ( ASSOCIATED( grid%nba_mij ) ) THEN 
  DEALLOCATE(grid%nba_mij,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nba_mij. ')
 endif
  NULLIFY(grid%nba_mij)
ENDIF
IF ( ASSOCIATED( grid%rliq ) ) THEN 
  DEALLOCATE(grid%rliq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rliq. ')
 endif
  NULLIFY(grid%rliq)
ENDIF
IF ( ASSOCIATED( grid%zmflxsnw ) ) THEN 
  DEALLOCATE(grid%zmflxsnw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmflxsnw. ')
 endif
  NULLIFY(grid%zmflxsnw)
ENDIF
IF ( ASSOCIATED( grid%zmmd ) ) THEN 
  DEALLOCATE(grid%zmmd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmmd. ')
 endif
  NULLIFY(grid%zmmd)
ENDIF
IF ( ASSOCIATED( grid%dp3d ) ) THEN 
  DEALLOCATE(grid%dp3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dp3d. ')
 endif
  NULLIFY(grid%dp3d)
ENDIF
IF ( ASSOCIATED( grid%cmflq ) ) THEN 
  DEALLOCATE(grid%cmflq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmflq. ')
 endif
  NULLIFY(grid%cmflq)
ENDIF
IF ( ASSOCIATED( grid%qtflx_cu ) ) THEN 
  DEALLOCATE(grid%qtflx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtflx_cu. ')
 endif
  NULLIFY(grid%qtflx_cu)
ENDIF
IF ( ASSOCIATED( grid%ufrcinvbase_cu ) ) THEN 
  DEALLOCATE(grid%ufrcinvbase_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ufrcinvbase_cu. ')
 endif
  NULLIFY(grid%ufrcinvbase_cu)
ENDIF
IF ( ASSOCIATED( grid%emkfbup_cu ) ) THEN 
  DEALLOCATE(grid%emkfbup_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%emkfbup_cu. ')
 endif
  NULLIFY(grid%emkfbup_cu)
ENDIF
IF ( ASSOCIATED( grid%qtu_cu ) ) THEN 
  DEALLOCATE(grid%qtu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtu_cu. ')
 endif
  NULLIFY(grid%qtu_cu)
ENDIF
IF ( ASSOCIATED( grid%qlu_cu ) ) THEN 
  DEALLOCATE(grid%qlu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qlu_cu. ')
 endif
  NULLIFY(grid%qlu_cu)
ENDIF
IF ( ASSOCIATED( grid%ntsnprd_cu ) ) THEN 
  DEALLOCATE(grid%ntsnprd_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ntsnprd_cu. ')
 endif
  NULLIFY(grid%ntsnprd_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_klfcmkx_cu ) ) THEN 
  DEALLOCATE(grid%exit_klfcmkx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_klfcmkx_cu. ')
 endif
  NULLIFY(grid%exit_klfcmkx_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_emf_cu ) ) THEN 
  DEALLOCATE(grid%limit_emf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_emf_cu. ')
 endif
  NULLIFY(grid%limit_emf_cu)
ENDIF
IF ( ASSOCIATED( grid%lradius ) ) THEN 
  DEALLOCATE(grid%lradius,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lradius. ')
 endif
  NULLIFY(grid%lradius)
ENDIF
IF ( ASSOCIATED( grid%lhtran ) ) THEN 
  DEALLOCATE(grid%lhtran,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lhtran. ')
 endif
  NULLIFY(grid%lhtran)
ENDIF
IF ( ASSOCIATED( grid%fsun240 ) ) THEN 
  DEALLOCATE(grid%fsun240,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsun240. ')
 endif
  NULLIFY(grid%fsun240)
ENDIF
IF ( ASSOCIATED( grid%q_ref2m ) ) THEN 
  DEALLOCATE(grid%q_ref2m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q_ref2m. ')
 endif
  NULLIFY(grid%q_ref2m)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq7 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq7,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq7. ')
 endif
  NULLIFY(grid%h2osoi_liq7)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice4 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice4. ')
 endif
  NULLIFY(grid%h2osoi_ice4)
ENDIF
IF ( ASSOCIATED( grid%t_soisno1 ) ) THEN 
  DEALLOCATE(grid%t_soisno1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno1. ')
 endif
  NULLIFY(grid%t_soisno1)
ENDIF
IF ( ASSOCIATED( grid%dzsnow3 ) ) THEN 
  DEALLOCATE(grid%dzsnow3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzsnow3. ')
 endif
  NULLIFY(grid%dzsnow3)
ENDIF
IF ( ASSOCIATED( grid%t_lake5 ) ) THEN 
  DEALLOCATE(grid%t_lake5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake5. ')
 endif
  NULLIFY(grid%t_lake5)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol7 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol7,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol7. ')
 endif
  NULLIFY(grid%h2osoi_vol7)
ENDIF
IF ( ASSOCIATED( grid%swupsubgrid ) ) THEN 
  DEALLOCATE(grid%swupsubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupsubgrid. ')
 endif
  NULLIFY(grid%swupsubgrid)
ENDIF
IF ( ASSOCIATED( grid%t_soisno3d ) ) THEN 
  DEALLOCATE(grid%t_soisno3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno3d. ')
 endif
  NULLIFY(grid%t_soisno3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_ghf ) ) THEN 
  DEALLOCATE(grid%ssib_ghf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_ghf. ')
 endif
  NULLIFY(grid%ssib_ghf)
ENDIF
IF ( ASSOCIATED( grid%ssib_shg ) ) THEN 
  DEALLOCATE(grid%ssib_shg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_shg. ')
 endif
  NULLIFY(grid%ssib_shg)
ENDIF
IF ( ASSOCIATED( grid%tssn1 ) ) THEN 
  DEALLOCATE(grid%tssn1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssn1. ')
 endif
  NULLIFY(grid%tssn1)
ENDIF
IF ( ASSOCIATED( grid%tssn2 ) ) THEN 
  DEALLOCATE(grid%tssn2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssn2. ')
 endif
  NULLIFY(grid%tssn2)
ENDIF
IF ( ASSOCIATED( grid%tssn3 ) ) THEN 
  DEALLOCATE(grid%tssn3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssn3. ')
 endif
  NULLIFY(grid%tssn3)
ENDIF
IF ( ASSOCIATED( grid%tssn4 ) ) THEN 
  DEALLOCATE(grid%tssn4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssn4. ')
 endif
  NULLIFY(grid%tssn4)
ENDIF
IF ( ASSOCIATED( grid%tgxy ) ) THEN 
  DEALLOCATE(grid%tgxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgxy. ')
 endif
  NULLIFY(grid%tgxy)
ENDIF
IF ( ASSOCIATED( grid%wslakexy ) ) THEN 
  DEALLOCATE(grid%wslakexy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wslakexy. ')
 endif
  NULLIFY(grid%wslakexy)
ENDIF
IF ( ASSOCIATED( grid%stblcpxy ) ) THEN 
  DEALLOCATE(grid%stblcpxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%stblcpxy. ')
 endif
  NULLIFY(grid%stblcpxy)
ENDIF
IF ( ASSOCIATED( grid%fvegxy ) ) THEN 
  DEALLOCATE(grid%fvegxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fvegxy. ')
 endif
  NULLIFY(grid%fvegxy)
ENDIF
IF ( ASSOCIATED( grid%sagxy ) ) THEN 
  DEALLOCATE(grid%sagxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sagxy. ')
 endif
  NULLIFY(grid%sagxy)
ENDIF
IF ( ASSOCIATED( grid%evgxy ) ) THEN 
  DEALLOCATE(grid%evgxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evgxy. ')
 endif
  NULLIFY(grid%evgxy)
ENDIF
IF ( ASSOCIATED( grid%chb2xy ) ) THEN 
  DEALLOCATE(grid%chb2xy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chb2xy. ')
 endif
  NULLIFY(grid%chb2xy)
ENDIF
IF ( ASSOCIATED( grid%acqspring ) ) THEN 
  DEALLOCATE(grid%acqspring,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acqspring. ')
 endif
  NULLIFY(grid%acqspring)
ENDIF
IF ( ASSOCIATED( grid%qdripsxy ) ) THEN 
  DEALLOCATE(grid%qdripsxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qdripsxy. ')
 endif
  NULLIFY(grid%qdripsxy)
ENDIF
IF ( ASSOCIATED( grid%qsnbotxy ) ) THEN 
  DEALLOCATE(grid%qsnbotxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsnbotxy. ')
 endif
  NULLIFY(grid%qsnbotxy)
ENDIF
IF ( ASSOCIATED( grid%soilcl1 ) ) THEN 
  DEALLOCATE(grid%soilcl1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcl1. ')
 endif
  NULLIFY(grid%soilcl1)
ENDIF
IF ( ASSOCIATED( grid%forcplsm ) ) THEN 
  DEALLOCATE(grid%forcplsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%forcplsm. ')
 endif
  NULLIFY(grid%forcplsm)
ENDIF
IF ( ASSOCIATED( grid%acsnowlsm ) ) THEN 
  DEALLOCATE(grid%acsnowlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnowlsm. ')
 endif
  NULLIFY(grid%acsnowlsm)
ENDIF
IF ( ASSOCIATED( grid%acthros ) ) THEN 
  DEALLOCATE(grid%acthros,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acthros. ')
 endif
  NULLIFY(grid%acthros)
ENDIF
IF ( ASSOCIATED( grid%acpahg ) ) THEN 
  DEALLOCATE(grid%acpahg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acpahg. ')
 endif
  NULLIFY(grid%acpahg)
ENDIF
IF ( ASSOCIATED( grid%aclhflsm ) ) THEN 
  DEALLOCATE(grid%aclhflsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclhflsm. ')
 endif
  NULLIFY(grid%aclhflsm)
ENDIF
IF ( ASSOCIATED( grid%acc_dwaterxy ) ) THEN 
  DEALLOCATE(grid%acc_dwaterxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_dwaterxy. ')
 endif
  NULLIFY(grid%acc_dwaterxy)
ENDIF
IF ( ASSOCIATED( grid%pgsxy ) ) THEN 
  DEALLOCATE(grid%pgsxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pgsxy. ')
 endif
  NULLIFY(grid%pgsxy)
ENDIF
IF ( ASSOCIATED( grid%irwatmi ) ) THEN 
  DEALLOCATE(grid%irwatmi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irwatmi. ')
 endif
  NULLIFY(grid%irwatmi)
ENDIF
IF ( ASSOCIATED( grid%kext_qg ) ) THEN 
  DEALLOCATE(grid%kext_qg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qg. ')
 endif
  NULLIFY(grid%kext_qg)
ENDIF
IF ( ASSOCIATED( grid%qicing_lg ) ) THEN 
  DEALLOCATE(grid%qicing_lg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qicing_lg. ')
 endif
  NULLIFY(grid%qicing_lg)
ENDIF
IF ( ASSOCIATED( grid%afwa_turb ) ) THEN 
  DEALLOCATE(grid%afwa_turb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_turb. ')
 endif
  NULLIFY(grid%afwa_turb)
ENDIF
IF ( ASSOCIATED( grid%afwa_vis ) ) THEN 
  DEALLOCATE(grid%afwa_vis,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_vis. ')
 endif
  NULLIFY(grid%afwa_vis)
ENDIF
IF ( ASSOCIATED( grid%afwa_pwat ) ) THEN 
  DEALLOCATE(grid%afwa_pwat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_pwat. ')
 endif
  NULLIFY(grid%afwa_pwat)
ENDIF
IF ( ASSOCIATED( grid%u10_mean ) ) THEN 
  DEALLOCATE(grid%u10_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10_mean. ')
 endif
  NULLIFY(grid%u10_mean)
ENDIF
IF ( ASSOCIATED( grid%glw_diurn ) ) THEN 
  DEALLOCATE(grid%glw_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%glw_diurn. ')
 endif
  NULLIFY(grid%glw_diurn)
ENDIF
IF ( ASSOCIATED( grid%th2_dtmp ) ) THEN 
  DEALLOCATE(grid%th2_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th2_dtmp. ')
 endif
  NULLIFY(grid%th2_dtmp)
ENDIF
IF ( ASSOCIATED( grid%lwupt_dtmp ) ) THEN 
  DEALLOCATE(grid%lwupt_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupt_dtmp. ')
 endif
  NULLIFY(grid%lwupt_dtmp)
ENDIF
IF ( ASSOCIATED( grid%light ) ) THEN 
  DEALLOCATE(grid%light,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%light. ')
 endif
  NULLIFY(grid%light)
ENDIF
IF ( ASSOCIATED( grid%c3h ) ) THEN 
  DEALLOCATE(grid%c3h,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c3h. ')
 endif
  NULLIFY(grid%c3h)
ENDIF
IF ( ASSOCIATED( grid%qnwfa_gc ) ) THEN 
  DEALLOCATE(grid%qnwfa_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnwfa_gc. ')
 endif
  NULLIFY(grid%qnwfa_gc)
ENDIF
IF ( ASSOCIATED( grid%p_wif_aug ) ) THEN 
  DEALLOCATE(grid%p_wif_aug,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_aug. ')
 endif
  NULLIFY(grid%p_wif_aug)
ENDIF
IF ( ASSOCIATED( grid%w_wif_jul ) ) THEN 
  DEALLOCATE(grid%w_wif_jul,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_jul. ')
 endif
  NULLIFY(grid%w_wif_jul)
ENDIF
IF ( ASSOCIATED( grid%i_wif_jun ) ) THEN 
  DEALLOCATE(grid%i_wif_jun,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_jun. ')
 endif
  NULLIFY(grid%i_wif_jun)
ENDIF
IF ( ASSOCIATED( grid%b_wif_may ) ) THEN 
  DEALLOCATE(grid%b_wif_may,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_may. ')
 endif
  NULLIFY(grid%b_wif_may)
ENDIF
IF ( ASSOCIATED( grid%pressure ) ) THEN 
  DEALLOCATE(grid%pressure,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pressure. ')
 endif
  NULLIFY(grid%pressure)
ENDIF
IF ( ASSOCIATED( grid%qi_tot ) ) THEN 
  DEALLOCATE(grid%qi_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qi_tot. ')
 endif
  NULLIFY(grid%qi_tot)
ENDIF
IF ( ASSOCIATED( grid%re_qs ) ) THEN 
  DEALLOCATE(grid%re_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_qs. ')
 endif
  NULLIFY(grid%re_qs)
ENDIF
IF ( ASSOCIATED( grid%clrnidx ) ) THEN 
  DEALLOCATE(grid%clrnidx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%clrnidx. ')
 endif
  NULLIFY(grid%clrnidx)
ENDIF
IF ( ASSOCIATED( grid%ts_re_qc ) ) THEN 
  DEALLOCATE(grid%ts_re_qc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_re_qc. ')
 endif
  NULLIFY(grid%ts_re_qc)
ENDIF
IF ( ASSOCIATED( grid%ts_cbaseht_tot ) ) THEN 
  DEALLOCATE(grid%ts_cbaseht_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_cbaseht_tot. ')
 endif
  NULLIFY(grid%ts_cbaseht_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_swddif2 ) ) THEN 
  DEALLOCATE(grid%ts_swddif2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddif2. ')
 endif
  NULLIFY(grid%ts_swddif2)
ENDIF
IF ( ASSOCIATED( grid%u_pl ) ) THEN 
  DEALLOCATE(grid%u_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_pl. ')
 endif
  NULLIFY(grid%u_pl)
ENDIF
IF ( ASSOCIATED( grid%rlwd_htop ) ) THEN 
  DEALLOCATE(grid%rlwd_htop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rlwd_htop. ')
 endif
  NULLIFY(grid%rlwd_htop)
ENDIF
IF ( ASSOCIATED( grid%mcm_sh_grnd ) ) THEN 
  DEALLOCATE(grid%mcm_sh_grnd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_sh_grnd. ')
 endif
  NULLIFY(grid%mcm_sh_grnd)
ENDIF
IF ( ASSOCIATED( grid%pert_t ) ) THEN 
  DEALLOCATE(grid%pert_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pert_t. ')
 endif
  NULLIFY(grid%pert_t)
ENDIF
END SUBROUTINE deallocs_11
!ENDOFREGISTRYGENERATEDINCLUDE
