!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_0.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_0( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%xlat ) ) THEN 
  DEALLOCATE(grid%xlat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlat. ')
 endif
  NULLIFY(grid%xlat)
ENDIF
IF ( ASSOCIATED( grid%traj_lat ) ) THEN 
  DEALLOCATE(grid%traj_lat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%traj_lat. ')
 endif
  NULLIFY(grid%traj_lat)
ENDIF
IF ( ASSOCIATED( grid%lap_hgt ) ) THEN 
  DEALLOCATE(grid%lap_hgt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lap_hgt. ')
 endif
  NULLIFY(grid%lap_hgt)
ENDIF
IF ( ASSOCIATED( grid%psfc_gc ) ) THEN 
  DEALLOCATE(grid%psfc_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc_gc. ')
 endif
  NULLIFY(grid%psfc_gc)
ENDIF
IF ( ASSOCIATED( grid%qi_gc ) ) THEN 
  DEALLOCATE(grid%qi_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qi_gc. ')
 endif
  NULLIFY(grid%qi_gc)
ENDIF
IF ( ASSOCIATED( grid%ght_max_p ) ) THEN 
  DEALLOCATE(grid%ght_max_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ght_max_p. ')
 endif
  NULLIFY(grid%ght_max_p)
ENDIF
IF ( ASSOCIATED( grid%ttrop ) ) THEN 
  DEALLOCATE(grid%ttrop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ttrop. ')
 endif
  NULLIFY(grid%ttrop)
ENDIF
IF ( ASSOCIATED( grid%ru_m ) ) THEN 
  DEALLOCATE(grid%ru_m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ru_m. ')
 endif
  NULLIFY(grid%ru_m)
ENDIF
IF ( ASSOCIATED( grid%rv_m ) ) THEN 
  DEALLOCATE(grid%rv_m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv_m. ')
 endif
  NULLIFY(grid%rv_m)
ENDIF
IF ( ASSOCIATED( grid%phb ) ) THEN 
  DEALLOCATE(grid%phb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phb. ')
 endif
  NULLIFY(grid%phb)
ENDIF
IF ( ASSOCIATED( grid%ql_upstream_x ) ) THEN 
  DEALLOCATE(grid%ql_upstream_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_upstream_x. ')
 endif
  NULLIFY(grid%ql_upstream_x)
ENDIF
IF ( ASSOCIATED( grid%th_t_tend ) ) THEN 
  DEALLOCATE(grid%th_t_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_t_tend. ')
 endif
  NULLIFY(grid%th_t_tend)
ENDIF
IF ( ASSOCIATED( grid%tau_largescale ) ) THEN 
  DEALLOCATE(grid%tau_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_largescale. ')
 endif
  NULLIFY(grid%tau_largescale)
ENDIF
IF ( ASSOCIATED( grid%mu0 ) ) THEN 
  DEALLOCATE(grid%mu0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu0. ')
 endif
  NULLIFY(grid%mu0)
ENDIF
IF ( ASSOCIATED( grid%nest_pos ) ) THEN 
  DEALLOCATE(grid%nest_pos,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nest_pos. ')
 endif
  NULLIFY(grid%nest_pos)
ENDIF
IF ( ASSOCIATED( grid%p ) ) THEN 
  DEALLOCATE(grid%p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p. ')
 endif
  NULLIFY(grid%p)
ENDIF
IF ( ASSOCIATED( grid%dnw ) ) THEN 
  DEALLOCATE(grid%dnw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dnw. ')
 endif
  NULLIFY(grid%dnw)
ENDIF
IF ( ASSOCIATED( grid%v10 ) ) THEN 
  DEALLOCATE(grid%v10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10. ')
 endif
  NULLIFY(grid%v10)
ENDIF
IF ( ASSOCIATED( grid%qnbca2d ) ) THEN 
  DEALLOCATE(grid%qnbca2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnbca2d. ')
 endif
  NULLIFY(grid%qnbca2d)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_cloud ) ) THEN 
  DEALLOCATE(grid%dfi_re_cloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_cloud. ')
 endif
  NULLIFY(grid%dfi_re_cloud)
ENDIF
IF ( ASSOCIATED( grid%scalar ) ) THEN 
  DEALLOCATE(grid%scalar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar. ')
 endif
  NULLIFY(grid%scalar)
ENDIF
IF ( ASSOCIATED( grid%sm ) ) THEN 
  DEALLOCATE(grid%sm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm. ')
 endif
  NULLIFY(grid%sm)
ENDIF
IF ( ASSOCIATED( grid%sm000010 ) ) THEN 
  DEALLOCATE(grid%sm000010,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm000010. ')
 endif
  NULLIFY(grid%sm000010)
ENDIF
IF ( ASSOCIATED( grid%sw010040 ) ) THEN 
  DEALLOCATE(grid%sw010040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw010040. ')
 endif
  NULLIFY(grid%sw010040)
ENDIF
IF ( ASSOCIATED( grid%st040100 ) ) THEN 
  DEALLOCATE(grid%st040100,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st040100. ')
 endif
  NULLIFY(grid%st040100)
ENDIF
IF ( ASSOCIATED( grid%slope ) ) THEN 
  DEALLOCATE(grid%slope,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slope. ')
 endif
  NULLIFY(grid%slope)
ENDIF
IF ( ASSOCIATED( grid%irrigation ) ) THEN 
  DEALLOCATE(grid%irrigation,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irrigation. ')
 endif
  NULLIFY(grid%irrigation)
ENDIF
IF ( ASSOCIATED( grid%ts_lh ) ) THEN 
  DEALLOCATE(grid%ts_lh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_lh. ')
 endif
  NULLIFY(grid%ts_lh)
ENDIF
IF ( ASSOCIATED( grid%ts_p_profile ) ) THEN 
  DEALLOCATE(grid%ts_p_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_p_profile. ')
 endif
  NULLIFY(grid%ts_p_profile)
ENDIF
IF ( ASSOCIATED( grid%smois ) ) THEN 
  DEALLOCATE(grid%smois,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smois. ')
 endif
  NULLIFY(grid%smois)
ENDIF
IF ( ASSOCIATED( grid%infxsrt ) ) THEN 
  DEALLOCATE(grid%infxsrt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%infxsrt. ')
 endif
  NULLIFY(grid%infxsrt)
ENDIF
IF ( ASSOCIATED( grid%acsnow ) ) THEN 
  DEALLOCATE(grid%acsnow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnow. ')
 endif
  NULLIFY(grid%acsnow)
ENDIF
IF ( ASSOCIATED( grid%sstsk ) ) THEN 
  DEALLOCATE(grid%sstsk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sstsk. ')
 endif
  NULLIFY(grid%sstsk)
ENDIF
IF ( ASSOCIATED( grid%dfi_ph0 ) ) THEN 
  DEALLOCATE(grid%dfi_ph0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_ph0. ')
 endif
  NULLIFY(grid%dfi_ph0)
ENDIF
IF ( ASSOCIATED( grid%dfi_tten_rad ) ) THEN 
  DEALLOCATE(grid%dfi_tten_rad,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_tten_rad. ')
 endif
  NULLIFY(grid%dfi_tten_rad)
ENDIF
IF ( ASSOCIATED( grid%tg_urb2d ) ) THEN 
  DEALLOCATE(grid%tg_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tg_urb2d. ')
 endif
  NULLIFY(grid%tg_urb2d)
ENDIF
IF ( ASSOCIATED( grid%flxhumr_urb2d ) ) THEN 
  DEALLOCATE(grid%flxhumr_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flxhumr_urb2d. ')
 endif
  NULLIFY(grid%flxhumr_urb2d)
ENDIF
IF ( ASSOCIATED( grid%ts_urb2d ) ) THEN 
  DEALLOCATE(grid%ts_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_urb2d. ')
 endif
  NULLIFY(grid%ts_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tflev_urb3d ) ) THEN 
  DEALLOCATE(grid%tflev_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tflev_urb3d. ')
 endif
  NULLIFY(grid%tflev_urb3d)
ENDIF
IF ( ASSOCIATED( grid%ep_pv_urb3d ) ) THEN 
  DEALLOCATE(grid%ep_pv_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ep_pv_urb3d. ')
 endif
  NULLIFY(grid%ep_pv_urb3d)
ENDIF
IF ( ASSOCIATED( grid%lfr_urb3d ) ) THEN 
  DEALLOCATE(grid%lfr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfr_urb3d. ')
 endif
  NULLIFY(grid%lfr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%coszen ) ) THEN 
  DEALLOCATE(grid%coszen,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%coszen. ')
 endif
  NULLIFY(grid%coszen)
ENDIF
IF ( ASSOCIATED( grid%swnirdif ) ) THEN 
  DEALLOCATE(grid%swnirdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swnirdif. ')
 endif
  NULLIFY(grid%swnirdif)
ENDIF
IF ( ASSOCIATED( grid%canfra ) ) THEN 
  DEALLOCATE(grid%canfra,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canfra. ')
 endif
  NULLIFY(grid%canfra)
ENDIF
IF ( ASSOCIATED( grid%wspd ) ) THEN 
  DEALLOCATE(grid%wspd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wspd. ')
 endif
  NULLIFY(grid%wspd)
ENDIF
IF ( ASSOCIATED( grid%z0 ) ) THEN 
  DEALLOCATE(grid%z0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z0. ')
 endif
  NULLIFY(grid%z0)
ENDIF
IF ( ASSOCIATED( grid%qshltr ) ) THEN 
  DEALLOCATE(grid%qshltr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qshltr. ')
 endif
  NULLIFY(grid%qshltr)
ENDIF
IF ( ASSOCIATED( grid%rc_up ) ) THEN 
  DEALLOCATE(grid%rc_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rc_up. ')
 endif
  NULLIFY(grid%rc_up)
ENDIF
IF ( ASSOCIATED( grid%wupd_temf ) ) THEN 
  DEALLOCATE(grid%wupd_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wupd_temf. ')
 endif
  NULLIFY(grid%wupd_temf)
ENDIF
IF ( ASSOCIATED( grid%qshear ) ) THEN 
  DEALLOCATE(grid%qshear,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qshear. ')
 endif
  NULLIFY(grid%qshear)
ENDIF
IF ( ASSOCIATED( grid%edmf_w ) ) THEN 
  DEALLOCATE(grid%edmf_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_w. ')
 endif
  NULLIFY(grid%edmf_w)
ENDIF
IF ( ASSOCIATED( grid%fgdp ) ) THEN 
  DEALLOCATE(grid%fgdp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fgdp. ')
 endif
  NULLIFY(grid%fgdp)
ENDIF
IF ( ASSOCIATED( grid%oa3 ) ) THEN 
  DEALLOCATE(grid%oa3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa3. ')
 endif
  NULLIFY(grid%oa3)
ENDIF
IF ( ASSOCIATED( grid%dtaux3d_fd ) ) THEN 
  DEALLOCATE(grid%dtaux3d_fd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtaux3d_fd. ')
 endif
  NULLIFY(grid%dtaux3d_fd)
ENDIF
IF ( ASSOCIATED( grid%oa1ls ) ) THEN 
  DEALLOCATE(grid%oa1ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa1ls. ')
 endif
  NULLIFY(grid%oa1ls)
ENDIF
IF ( ASSOCIATED( grid%oa3ss ) ) THEN 
  DEALLOCATE(grid%oa3ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa3ss. ')
 endif
  NULLIFY(grid%oa3ss)
ENDIF
IF ( ASSOCIATED( grid%a_e_bep ) ) THEN 
  DEALLOCATE(grid%a_e_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%a_e_bep. ')
 endif
  NULLIFY(grid%a_e_bep)
ENDIF
IF ( ASSOCIATED( grid%diss_pbl ) ) THEN 
  DEALLOCATE(grid%diss_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%diss_pbl. ')
 endif
  NULLIFY(grid%diss_pbl)
ENDIF
IF ( ASSOCIATED( grid%cubot ) ) THEN 
  DEALLOCATE(grid%cubot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cubot. ')
 endif
  NULLIFY(grid%cubot)
ENDIF
IF ( ASSOCIATED( grid%o3rad ) ) THEN 
  DEALLOCATE(grid%o3rad,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%o3rad. ')
 endif
  NULLIFY(grid%o3rad)
ENDIF
IF ( ASSOCIATED( grid%m_ps_1 ) ) THEN 
  DEALLOCATE(grid%m_ps_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%m_ps_1. ')
 endif
  NULLIFY(grid%m_ps_1)
ENDIF
IF ( ASSOCIATED( grid%m_ps_2 ) ) THEN 
  DEALLOCATE(grid%m_ps_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%m_ps_2. ')
 endif
  NULLIFY(grid%m_ps_2)
ENDIF
IF ( ASSOCIATED( grid%om_lat ) ) THEN 
  DEALLOCATE(grid%om_lat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_lat. ')
 endif
  NULLIFY(grid%om_lat)
ENDIF
IF ( ASSOCIATED( grid%tactive ) ) THEN 
  DEALLOCATE(grid%tactive,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tactive. ')
 endif
  NULLIFY(grid%tactive)
ENDIF
IF ( ASSOCIATED( grid%wulcl_cup ) ) THEN 
  DEALLOCATE(grid%wulcl_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wulcl_cup. ')
 endif
  NULLIFY(grid%wulcl_cup)
ENDIF
IF ( ASSOCIATED( grid%qv_diabatic ) ) THEN 
  DEALLOCATE(grid%qv_diabatic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_diabatic. ')
 endif
  NULLIFY(grid%qv_diabatic)
ENDIF
IF ( ASSOCIATED( grid%f ) ) THEN 
  DEALLOCATE(grid%f,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%f. ')
 endif
  NULLIFY(grid%f)
ENDIF
IF ( ASSOCIATED( grid%physe ) ) THEN 
  DEALLOCATE(grid%physe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physe. ')
 endif
  NULLIFY(grid%physe)
ENDIF
IF ( ASSOCIATED( grid%preci3d ) ) THEN 
  DEALLOCATE(grid%preci3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%preci3d. ')
 endif
  NULLIFY(grid%preci3d)
ENDIF
IF ( ASSOCIATED( grid%sswup ) ) THEN 
  DEALLOCATE(grid%sswup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sswup. ')
 endif
  NULLIFY(grid%sswup)
ENDIF
IF ( ASSOCIATED( grid%rqcnshten ) ) THEN 
  DEALLOCATE(grid%rqcnshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqcnshten. ')
 endif
  NULLIFY(grid%rqcnshten)
ENDIF
IF ( ASSOCIATED( grid%pblmax ) ) THEN 
  DEALLOCATE(grid%pblmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pblmax. ')
 endif
  NULLIFY(grid%pblmax)
ENDIF
IF ( ASSOCIATED( grid%wsubsid ) ) THEN 
  DEALLOCATE(grid%wsubsid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wsubsid. ')
 endif
  NULLIFY(grid%wsubsid)
ENDIF
IF ( ASSOCIATED( grid%qcconv ) ) THEN 
  DEALLOCATE(grid%qcconv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qcconv. ')
 endif
  NULLIFY(grid%qcconv)
ENDIF
IF ( ASSOCIATED( grid%rainbl ) ) THEN 
  DEALLOCATE(grid%rainbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainbl. ')
 endif
  NULLIFY(grid%rainbl)
ENDIF
IF ( ASSOCIATED( grid%di3d ) ) THEN 
  DEALLOCATE(grid%di3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%di3d. ')
 endif
  NULLIFY(grid%di3d)
ENDIF
IF ( ASSOCIATED( grid%itype_2 ) ) THEN 
  DEALLOCATE(grid%itype_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%itype_2. ')
 endif
  NULLIFY(grid%itype_2)
ENDIF
IF ( ASSOCIATED( grid%apr_gr ) ) THEN 
  DEALLOCATE(grid%apr_gr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_gr. ')
 endif
  NULLIFY(grid%apr_gr)
ENDIF
IF ( ASSOCIATED( grid%ktop_shallow ) ) THEN 
  DEALLOCATE(grid%ktop_shallow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ktop_shallow. ')
 endif
  NULLIFY(grid%ktop_shallow)
ENDIF
IF ( ASSOCIATED( grid%gd_cloud2 ) ) THEN 
  DEALLOCATE(grid%gd_cloud2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gd_cloud2. ')
 endif
  NULLIFY(grid%gd_cloud2)
ENDIF
IF ( ASSOCIATED( grid%nr_cu ) ) THEN 
  DEALLOCATE(grid%nr_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nr_cu. ')
 endif
  NULLIFY(grid%nr_cu)
ENDIF
IF ( ASSOCIATED( grid%ccn2_gs ) ) THEN 
  DEALLOCATE(grid%ccn2_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn2_gs. ')
 endif
  NULLIFY(grid%ccn2_gs)
ENDIF
IF ( ASSOCIATED( grid%rthraten ) ) THEN 
  DEALLOCATE(grid%rthraten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthraten. ')
 endif
  NULLIFY(grid%rthraten)
ENDIF
IF ( ASSOCIATED( grid%swdown2 ) ) THEN 
  DEALLOCATE(grid%swdown2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdown2. ')
 endif
  NULLIFY(grid%swdown2)
ENDIF
IF ( ASSOCIATED( grid%swddnic ) ) THEN 
  DEALLOCATE(grid%swddnic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddnic. ')
 endif
  NULLIFY(grid%swddnic)
ENDIF
IF ( ASSOCIATED( grid%angexp2d ) ) THEN 
  DEALLOCATE(grid%angexp2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%angexp2d. ')
 endif
  NULLIFY(grid%angexp2d)
ENDIF
IF ( ASSOCIATED( grid%q2min ) ) THEN 
  DEALLOCATE(grid%q2min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2min. ')
 endif
  NULLIFY(grid%q2min)
ENDIF
IF ( ASSOCIATED( grid%u10max ) ) THEN 
  DEALLOCATE(grid%u10max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10max. ')
 endif
  NULLIFY(grid%u10max)
ENDIF
IF ( ASSOCIATED( grid%traincvmax ) ) THEN 
  DEALLOCATE(grid%traincvmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%traincvmax. ')
 endif
  NULLIFY(grid%traincvmax)
ENDIF
IF ( ASSOCIATED( grid%acswupbc ) ) THEN 
  DEALLOCATE(grid%acswupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswupbc. ')
 endif
  NULLIFY(grid%acswupbc)
ENDIF
IF ( ASSOCIATED( grid%i_acswuptc ) ) THEN 
  DEALLOCATE(grid%i_acswuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswuptc. ')
 endif
  NULLIFY(grid%i_acswuptc)
ENDIF
IF ( ASSOCIATED( grid%i_aclwupbc ) ) THEN 
  DEALLOCATE(grid%i_aclwupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwupbc. ')
 endif
  NULLIFY(grid%i_aclwupbc)
ENDIF
IF ( ASSOCIATED( grid%swdnb ) ) THEN 
  DEALLOCATE(grid%swdnb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnb. ')
 endif
  NULLIFY(grid%swdnb)
ENDIF
IF ( ASSOCIATED( grid%lwdnb ) ) THEN 
  DEALLOCATE(grid%lwdnb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnb. ')
 endif
  NULLIFY(grid%lwdnb)
ENDIF
IF ( ASSOCIATED( grid%albbck ) ) THEN 
  DEALLOCATE(grid%albbck,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albbck. ')
 endif
  NULLIFY(grid%albbck)
ENDIF
IF ( ASSOCIATED( grid%rqiblten ) ) THEN 
  DEALLOCATE(grid%rqiblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqiblten. ')
 endif
  NULLIFY(grid%rqiblten)
ENDIF
IF ( ASSOCIATED( grid%snow_mosaic ) ) THEN 
  DEALLOCATE(grid%snow_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snow_mosaic. ')
 endif
  NULLIFY(grid%snow_mosaic)
ENDIF
IF ( ASSOCIATED( grid%qfx_mosaic ) ) THEN 
  DEALLOCATE(grid%qfx_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qfx_mosaic. ')
 endif
  NULLIFY(grid%qfx_mosaic)
ENDIF
IF ( ASSOCIATED( grid%trl_urb3d_mosaic ) ) THEN 
  DEALLOCATE(grid%trl_urb3d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trl_urb3d_mosaic. ')
 endif
  NULLIFY(grid%trl_urb3d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%znt ) ) THEN 
  DEALLOCATE(grid%znt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%znt. ')
 endif
  NULLIFY(grid%znt)
ENDIF
IF ( ASSOCIATED( grid%thc ) ) THEN 
  DEALLOCATE(grid%thc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thc. ')
 endif
  NULLIFY(grid%thc)
ENDIF
IF ( ASSOCIATED( grid%qcg ) ) THEN 
  DEALLOCATE(grid%qcg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qcg. ')
 endif
  NULLIFY(grid%qcg)
ENDIF
IF ( ASSOCIATED( grid%potevp ) ) THEN 
  DEALLOCATE(grid%potevp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%potevp. ')
 endif
  NULLIFY(grid%potevp)
ENDIF
IF ( ASSOCIATED( grid%xkmv ) ) THEN 
  DEALLOCATE(grid%xkmv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xkmv. ')
 endif
  NULLIFY(grid%xkmv)
ENDIF
IF ( ASSOCIATED( grid%rthndgdten ) ) THEN 
  DEALLOCATE(grid%rthndgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthndgdten. ')
 endif
  NULLIFY(grid%rthndgdten)
ENDIF
IF ( ASSOCIATED( grid%th2_ndg_old ) ) THEN 
  DEALLOCATE(grid%th2_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th2_ndg_old. ')
 endif
  NULLIFY(grid%th2_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%tob_ndg_new ) ) THEN 
  DEALLOCATE(grid%tob_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tob_ndg_new. ')
 endif
  NULLIFY(grid%tob_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%absnxt ) ) THEN 
  DEALLOCATE(grid%absnxt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%absnxt. ')
 endif
  NULLIFY(grid%absnxt)
ENDIF
IF ( ASSOCIATED( grid%grpl_max ) ) THEN 
  DEALLOCATE(grid%grpl_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grpl_max. ')
 endif
  NULLIFY(grid%grpl_max)
ENDIF
IF ( ASSOCIATED( grid%advz_t ) ) THEN 
  DEALLOCATE(grid%advz_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%advz_t. ')
 endif
  NULLIFY(grid%advz_t)
ENDIF
IF ( ASSOCIATED( grid%track_v ) ) THEN 
  DEALLOCATE(grid%track_v,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_v. ')
 endif
  NULLIFY(grid%track_v)
ENDIF
IF ( ASSOCIATED( grid%brtemp ) ) THEN 
  DEALLOCATE(grid%brtemp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%brtemp. ')
 endif
  NULLIFY(grid%brtemp)
ENDIF
IF ( ASSOCIATED( grid%aushten ) ) THEN 
  DEALLOCATE(grid%aushten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aushten. ')
 endif
  NULLIFY(grid%aushten)
ENDIF
IF ( ASSOCIATED( grid%haildtacttime ) ) THEN 
  DEALLOCATE(grid%haildtacttime,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%haildtacttime. ')
 endif
  NULLIFY(grid%haildtacttime)
ENDIF
IF ( ASSOCIATED( grid%rv_xxx ) ) THEN 
  DEALLOCATE(grid%rv_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv_xxx. ')
 endif
  NULLIFY(grid%rv_xxx)
ENDIF
IF ( ASSOCIATED( grid%lfn_time ) ) THEN 
  DEALLOCATE(grid%lfn_time,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_time. ')
 endif
  NULLIFY(grid%lfn_time)
ENDIF
IF ( ASSOCIATED( grid%canqfx ) ) THEN 
  DEALLOCATE(grid%canqfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canqfx. ')
 endif
  NULLIFY(grid%canqfx)
ENDIF
IF ( ASSOCIATED( grid%lfn_s3 ) ) THEN 
  DEALLOCATE(grid%lfn_s3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_s3. ')
 endif
  NULLIFY(grid%lfn_s3)
ENDIF
IF ( ASSOCIATED( grid%ros_front ) ) THEN 
  DEALLOCATE(grid%ros_front,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ros_front. ')
 endif
  NULLIFY(grid%ros_front)
ENDIF
IF ( ASSOCIATED( grid%fuel_time ) ) THEN 
  DEALLOCATE(grid%fuel_time,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fuel_time. ')
 endif
  NULLIFY(grid%fuel_time)
ENDIF
IF ( ASSOCIATED( grid%tracer_btxs ) ) THEN 
  DEALLOCATE(grid%tracer_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_btxs. ')
 endif
  NULLIFY(grid%tracer_btxs)
ENDIF
IF ( ASSOCIATED( grid%tracer_btxe ) ) THEN 
  DEALLOCATE(grid%tracer_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_btxe. ')
 endif
  NULLIFY(grid%tracer_btxe)
ENDIF
IF ( ASSOCIATED( grid%tracer_btys ) ) THEN 
  DEALLOCATE(grid%tracer_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_btys. ')
 endif
  NULLIFY(grid%tracer_btys)
ENDIF
IF ( ASSOCIATED( grid%tracer_btye ) ) THEN 
  DEALLOCATE(grid%tracer_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tracer_btye. ')
 endif
  NULLIFY(grid%tracer_btye)
ENDIF
IF ( ASSOCIATED( grid%fs_fuel_spotting_risk ) ) THEN 
  DEALLOCATE(grid%fs_fuel_spotting_risk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_fuel_spotting_risk. ')
 endif
  NULLIFY(grid%fs_fuel_spotting_risk)
ENDIF
IF ( ASSOCIATED( grid%fs_p_z ) ) THEN 
  DEALLOCATE(grid%fs_p_z,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_z. ')
 endif
  NULLIFY(grid%fs_p_z)
ENDIF
IF ( ASSOCIATED( grid%avgflx_dfu1 ) ) THEN 
  DEALLOCATE(grid%avgflx_dfu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_dfu1. ')
 endif
  NULLIFY(grid%avgflx_dfu1)
ENDIF
IF ( ASSOCIATED( grid%vertstrucc ) ) THEN 
  DEALLOCATE(grid%vertstrucc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertstrucc. ')
 endif
  NULLIFY(grid%vertstrucc)
ENDIF
IF ( ASSOCIATED( grid%rstoch ) ) THEN 
  DEALLOCATE(grid%rstoch,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rstoch. ')
 endif
  NULLIFY(grid%rstoch)
ENDIF
IF ( ASSOCIATED( grid%spforcc2 ) ) THEN 
  DEALLOCATE(grid%spforcc2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcc2. ')
 endif
  NULLIFY(grid%spforcc2)
ENDIF
IF ( ASSOCIATED( grid%spptforcc ) ) THEN 
  DEALLOCATE(grid%spptforcc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spptforcc. ')
 endif
  NULLIFY(grid%spptforcc)
ENDIF
IF ( ASSOCIATED( grid%rand_real_yyy ) ) THEN 
  DEALLOCATE(grid%rand_real_yyy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_real_yyy. ')
 endif
  NULLIFY(grid%rand_real_yyy)
ENDIF
IF ( ASSOCIATED( grid%stddev_cutoff_mult3d ) ) THEN 
  DEALLOCATE(grid%stddev_cutoff_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%stddev_cutoff_mult3d. ')
 endif
  NULLIFY(grid%stddev_cutoff_mult3d)
ENDIF
IF ( ASSOCIATED( grid%pert3d ) ) THEN 
  DEALLOCATE(grid%pert3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pert3d. ')
 endif
  NULLIFY(grid%pert3d)
ENDIF
IF ( ASSOCIATED( grid%nba_rij ) ) THEN 
  DEALLOCATE(grid%nba_rij,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nba_rij. ')
 endif
  NULLIFY(grid%nba_rij)
ENDIF
IF ( ASSOCIATED( grid%dlf ) ) THEN 
  DEALLOCATE(grid%dlf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dlf. ')
 endif
  NULLIFY(grid%dlf)
ENDIF
IF ( ASSOCIATED( grid%zmntprpd ) ) THEN 
  DEALLOCATE(grid%zmntprpd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmntprpd. ')
 endif
  NULLIFY(grid%zmntprpd)
ENDIF
IF ( ASSOCIATED( grid%zmupgu ) ) THEN 
  DEALLOCATE(grid%zmupgu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmupgu. ')
 endif
  NULLIFY(grid%zmupgu)
ENDIF
IF ( ASSOCIATED( grid%du3d ) ) THEN 
  DEALLOCATE(grid%du3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%du3d. ')
 endif
  NULLIFY(grid%du3d)
ENDIF
IF ( ASSOCIATED( grid%cmfmc ) ) THEN 
  DEALLOCATE(grid%cmfmc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmfmc. ')
 endif
  NULLIFY(grid%cmfmc)
ENDIF
IF ( ASSOCIATED( grid%slflx_cu ) ) THEN 
  DEALLOCATE(grid%slflx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slflx_cu. ')
 endif
  NULLIFY(grid%slflx_cu)
ENDIF
IF ( ASSOCIATED( grid%ufrclcl_cu ) ) THEN 
  DEALLOCATE(grid%ufrclcl_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ufrclcl_cu. ')
 endif
  NULLIFY(grid%ufrclcl_cu)
ENDIF
IF ( ASSOCIATED( grid%cin_cu ) ) THEN 
  DEALLOCATE(grid%cin_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cin_cu. ')
 endif
  NULLIFY(grid%cin_cu)
ENDIF
IF ( ASSOCIATED( grid%thlu_cu ) ) THEN 
  DEALLOCATE(grid%thlu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thlu_cu. ')
 endif
  NULLIFY(grid%thlu_cu)
ENDIF
IF ( ASSOCIATED( grid%qiu_cu ) ) THEN 
  DEALLOCATE(grid%qiu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qiu_cu. ')
 endif
  NULLIFY(grid%qiu_cu)
ENDIF
IF ( ASSOCIATED( grid%excessu_cu ) ) THEN 
  DEALLOCATE(grid%excessu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%excessu_cu. ')
 endif
  NULLIFY(grid%excessu_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_ufrc_cu ) ) THEN 
  DEALLOCATE(grid%exit_ufrc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_ufrc_cu. ')
 endif
  NULLIFY(grid%exit_ufrc_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_cinlcl_cu ) ) THEN 
  DEALLOCATE(grid%limit_cinlcl_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_cinlcl_cu. ')
 endif
  NULLIFY(grid%limit_cinlcl_cu)
ENDIF
IF ( ASSOCIATED( grid%cldfra_conv ) ) THEN 
  DEALLOCATE(grid%cldfra_conv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_conv. ')
 endif
  NULLIFY(grid%cldfra_conv)
ENDIF
IF ( ASSOCIATED( grid%snl ) ) THEN 
  DEALLOCATE(grid%snl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snl. ')
 endif
  NULLIFY(grid%snl)
ENDIF
IF ( ASSOCIATED( grid%fsd24 ) ) THEN 
  DEALLOCATE(grid%fsd24,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsd24. ')
 endif
  NULLIFY(grid%fsd24)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq_s1 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq_s1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq_s1. ')
 endif
  NULLIFY(grid%h2osoi_liq_s1)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq8 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq8,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq8. ')
 endif
  NULLIFY(grid%h2osoi_liq8)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice5 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice5. ')
 endif
  NULLIFY(grid%h2osoi_ice5)
ENDIF
IF ( ASSOCIATED( grid%t_soisno2 ) ) THEN 
  DEALLOCATE(grid%t_soisno2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno2. ')
 endif
  NULLIFY(grid%t_soisno2)
ENDIF
IF ( ASSOCIATED( grid%dzsnow4 ) ) THEN 
  DEALLOCATE(grid%dzsnow4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzsnow4. ')
 endif
  NULLIFY(grid%dzsnow4)
ENDIF
IF ( ASSOCIATED( grid%t_lake6 ) ) THEN 
  DEALLOCATE(grid%t_lake6,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake6. ')
 endif
  NULLIFY(grid%t_lake6)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol8 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol8,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol8. ')
 endif
  NULLIFY(grid%h2osoi_vol8)
ENDIF
IF ( ASSOCIATED( grid%lake2d ) ) THEN 
  DEALLOCATE(grid%lake2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lake2d. ')
 endif
  NULLIFY(grid%lake2d)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice3d ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice3d. ')
 endif
  NULLIFY(grid%h2osoi_ice3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_egs ) ) THEN 
  DEALLOCATE(grid%ssib_egs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_egs. ')
 endif
  NULLIFY(grid%ssib_egs)
ENDIF
IF ( ASSOCIATED( grid%ssib_lai ) ) THEN 
  DEALLOCATE(grid%ssib_lai,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_lai. ')
 endif
  NULLIFY(grid%ssib_lai)
ENDIF
IF ( ASSOCIATED( grid%tssno1 ) ) THEN 
  DEALLOCATE(grid%tssno1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssno1. ')
 endif
  NULLIFY(grid%tssno1)
ENDIF
IF ( ASSOCIATED( grid%tssno2 ) ) THEN 
  DEALLOCATE(grid%tssno2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssno2. ')
 endif
  NULLIFY(grid%tssno2)
ENDIF
IF ( ASSOCIATED( grid%tssno3 ) ) THEN 
  DEALLOCATE(grid%tssno3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssno3. ')
 endif
  NULLIFY(grid%tssno3)
ENDIF
IF ( ASSOCIATED( grid%tssno4 ) ) THEN 
  DEALLOCATE(grid%tssno4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tssno4. ')
 endif
  NULLIFY(grid%tssno4)
ENDIF
IF ( ASSOCIATED( grid%canicexy ) ) THEN 
  DEALLOCATE(grid%canicexy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canicexy. ')
 endif
  NULLIFY(grid%canicexy)
ENDIF
IF ( ASSOCIATED( grid%zwtxy ) ) THEN 
  DEALLOCATE(grid%zwtxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zwtxy. ')
 endif
  NULLIFY(grid%zwtxy)
ENDIF
IF ( ASSOCIATED( grid%fastcpxy ) ) THEN 
  DEALLOCATE(grid%fastcpxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fastcpxy. ')
 endif
  NULLIFY(grid%fastcpxy)
ENDIF
IF ( ASSOCIATED( grid%qinxy ) ) THEN 
  DEALLOCATE(grid%qinxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qinxy. ')
 endif
  NULLIFY(grid%qinxy)
ENDIF
IF ( ASSOCIATED( grid%rssunxy ) ) THEN 
  DEALLOCATE(grid%rssunxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rssunxy. ')
 endif
  NULLIFY(grid%rssunxy)
ENDIF
IF ( ASSOCIATED( grid%evbxy ) ) THEN 
  DEALLOCATE(grid%evbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evbxy. ')
 endif
  NULLIFY(grid%evbxy)
ENDIF
IF ( ASSOCIATED( grid%chstarxy ) ) THEN 
  DEALLOCATE(grid%chstarxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chstarxy. ')
 endif
  NULLIFY(grid%chstarxy)
ENDIF
IF ( ASSOCIATED( grid%qslatxy ) ) THEN 
  DEALLOCATE(grid%qslatxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qslatxy. ')
 endif
  NULLIFY(grid%qslatxy)
ENDIF
IF ( ASSOCIATED( grid%qdriprxy ) ) THEN 
  DEALLOCATE(grid%qdriprxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qdriprxy. ')
 endif
  NULLIFY(grid%qdriprxy)
ENDIF
IF ( ASSOCIATED( grid%qmeltxy ) ) THEN 
  DEALLOCATE(grid%qmeltxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qmeltxy. ')
 endif
  NULLIFY(grid%qmeltxy)
ENDIF
IF ( ASSOCIATED( grid%soilcl2 ) ) THEN 
  DEALLOCATE(grid%soilcl2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcl2. ')
 endif
  NULLIFY(grid%soilcl2)
ENDIF
IF ( ASSOCIATED( grid%forczlsm ) ) THEN 
  DEALLOCATE(grid%forczlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%forczlsm. ')
 endif
  NULLIFY(grid%forczlsm)
ENDIF
IF ( ASSOCIATED( grid%acsubc ) ) THEN 
  DEALLOCATE(grid%acsubc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsubc. ')
 endif
  NULLIFY(grid%acsubc)
ENDIF
IF ( ASSOCIATED( grid%acsagb ) ) THEN 
  DEALLOCATE(grid%acsagb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsagb. ')
 endif
  NULLIFY(grid%acsagb)
ENDIF
IF ( ASSOCIATED( grid%acsav ) ) THEN 
  DEALLOCATE(grid%acsav,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsav. ')
 endif
  NULLIFY(grid%acsav)
ENDIF
IF ( ASSOCIATED( grid%acghflsm ) ) THEN 
  DEALLOCATE(grid%acghflsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acghflsm. ')
 endif
  NULLIFY(grid%acghflsm)
ENDIF
IF ( ASSOCIATED( grid%acc_prcpxy ) ) THEN 
  DEALLOCATE(grid%acc_prcpxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_prcpxy. ')
 endif
  NULLIFY(grid%acc_prcpxy)
ENDIF
IF ( ASSOCIATED( grid%gecros_state ) ) THEN 
  DEALLOCATE(grid%gecros_state,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gecros_state. ')
 endif
  NULLIFY(grid%gecros_state)
ENDIF
IF ( ASSOCIATED( grid%irwatfi ) ) THEN 
  DEALLOCATE(grid%irwatfi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irwatfi. ')
 endif
  NULLIFY(grid%irwatfi)
ENDIF
IF ( ASSOCIATED( grid%kext_qh ) ) THEN 
  DEALLOCATE(grid%kext_qh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qh. ')
 endif
  NULLIFY(grid%kext_qh)
ENDIF
IF ( ASSOCIATED( grid%qicing_sm ) ) THEN 
  DEALLOCATE(grid%qicing_sm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qicing_sm. ')
 endif
  NULLIFY(grid%qicing_sm)
ENDIF
IF ( ASSOCIATED( grid%afwa_llturb ) ) THEN 
  DEALLOCATE(grid%afwa_llturb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_llturb. ')
 endif
  NULLIFY(grid%afwa_llturb)
ENDIF
IF ( ASSOCIATED( grid%afwa_vis_alpha ) ) THEN 
  DEALLOCATE(grid%afwa_vis_alpha,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_vis_alpha. ')
 endif
  NULLIFY(grid%afwa_vis_alpha)
ENDIF
IF ( ASSOCIATED( grid%midrh_min ) ) THEN 
  DEALLOCATE(grid%midrh_min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%midrh_min. ')
 endif
  NULLIFY(grid%midrh_min)
ENDIF
IF ( ASSOCIATED( grid%v10_mean ) ) THEN 
  DEALLOCATE(grid%v10_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10_mean. ')
 endif
  NULLIFY(grid%v10_mean)
ENDIF
IF ( ASSOCIATED( grid%lwupb_diurn ) ) THEN 
  DEALLOCATE(grid%lwupb_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupb_diurn. ')
 endif
  NULLIFY(grid%lwupb_diurn)
ENDIF
IF ( ASSOCIATED( grid%q2_dtmp ) ) THEN 
  DEALLOCATE(grid%q2_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2_dtmp. ')
 endif
  NULLIFY(grid%q2_dtmp)
ENDIF
IF ( ASSOCIATED( grid%lwdnt_dtmp ) ) THEN 
  DEALLOCATE(grid%lwdnt_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnt_dtmp. ')
 endif
  NULLIFY(grid%lwdnt_dtmp)
ENDIF
IF ( ASSOCIATED( grid%lightdens ) ) THEN 
  DEALLOCATE(grid%lightdens,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lightdens. ')
 endif
  NULLIFY(grid%lightdens)
ENDIF
IF ( ASSOCIATED( grid%c4h ) ) THEN 
  DEALLOCATE(grid%c4h,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c4h. ')
 endif
  NULLIFY(grid%c4h)
ENDIF
IF ( ASSOCIATED( grid%qnifa_gc ) ) THEN 
  DEALLOCATE(grid%qnifa_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnifa_gc. ')
 endif
  NULLIFY(grid%qnifa_gc)
ENDIF
IF ( ASSOCIATED( grid%p_wif_sep ) ) THEN 
  DEALLOCATE(grid%p_wif_sep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_sep. ')
 endif
  NULLIFY(grid%p_wif_sep)
ENDIF
IF ( ASSOCIATED( grid%w_wif_aug ) ) THEN 
  DEALLOCATE(grid%w_wif_aug,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_aug. ')
 endif
  NULLIFY(grid%w_wif_aug)
ENDIF
IF ( ASSOCIATED( grid%i_wif_jul ) ) THEN 
  DEALLOCATE(grid%i_wif_jul,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_jul. ')
 endif
  NULLIFY(grid%i_wif_jul)
ENDIF
IF ( ASSOCIATED( grid%b_wif_jun ) ) THEN 
  DEALLOCATE(grid%b_wif_jun,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_jun. ')
 endif
  NULLIFY(grid%b_wif_jun)
ENDIF
IF ( ASSOCIATED( grid%umet ) ) THEN 
  DEALLOCATE(grid%umet,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%umet. ')
 endif
  NULLIFY(grid%umet)
ENDIF
IF ( ASSOCIATED( grid%cldfrac2d ) ) THEN 
  DEALLOCATE(grid%cldfrac2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfrac2d. ')
 endif
  NULLIFY(grid%cldfrac2d)
ENDIF
IF ( ASSOCIATED( grid%re_qc_tot ) ) THEN 
  DEALLOCATE(grid%re_qc_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_qc_tot. ')
 endif
  NULLIFY(grid%re_qc_tot)
ENDIF
IF ( ASSOCIATED( grid%sza ) ) THEN 
  DEALLOCATE(grid%sza,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sza. ')
 endif
  NULLIFY(grid%sza)
ENDIF
IF ( ASSOCIATED( grid%ts_re_qi ) ) THEN 
  DEALLOCATE(grid%ts_re_qi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_re_qi. ')
 endif
  NULLIFY(grid%ts_re_qi)
ENDIF
IF ( ASSOCIATED( grid%ts_ctopht_tot ) ) THEN 
  DEALLOCATE(grid%ts_ctopht_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_ctopht_tot. ')
 endif
  NULLIFY(grid%ts_ctopht_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_swdownc2 ) ) THEN 
  DEALLOCATE(grid%ts_swdownc2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swdownc2. ')
 endif
  NULLIFY(grid%ts_swdownc2)
ENDIF
IF ( ASSOCIATED( grid%v_pl ) ) THEN 
  DEALLOCATE(grid%v_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_pl. ')
 endif
  NULLIFY(grid%v_pl)
ENDIF
IF ( ASSOCIATED( grid%mcm_tlai ) ) THEN 
  DEALLOCATE(grid%mcm_tlai,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_tlai. ')
 endif
  NULLIFY(grid%mcm_tlai)
ENDIF
IF ( ASSOCIATED( grid%mcm_sw_in ) ) THEN 
  DEALLOCATE(grid%mcm_sw_in,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_sw_in. ')
 endif
  NULLIFY(grid%mcm_sw_in)
ENDIF
IF ( ASSOCIATED( grid%prttms ) ) THEN 
  DEALLOCATE(grid%prttms,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prttms. ')
 endif
  NULLIFY(grid%prttms)
ENDIF
END SUBROUTINE deallocs_0
!ENDOFREGISTRYGENERATEDINCLUDE
