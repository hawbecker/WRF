!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_1.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_1( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%xlong ) ) THEN 
  DEALLOCATE(grid%xlong,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlong. ')
 endif
  NULLIFY(grid%xlong)
ENDIF
IF ( ASSOCIATED( grid%u_gc ) ) THEN 
  DEALLOCATE(grid%u_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_gc. ')
 endif
  NULLIFY(grid%u_gc)
ENDIF
IF ( ASSOCIATED( grid%tsk_gc ) ) THEN 
  DEALLOCATE(grid%tsk_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_gc. ')
 endif
  NULLIFY(grid%tsk_gc)
ENDIF
IF ( ASSOCIATED( grid%intq_gc ) ) THEN 
  DEALLOCATE(grid%intq_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%intq_gc. ')
 endif
  NULLIFY(grid%intq_gc)
ENDIF
IF ( ASSOCIATED( grid%qg_gc ) ) THEN 
  DEALLOCATE(grid%qg_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qg_gc. ')
 endif
  NULLIFY(grid%qg_gc)
ENDIF
IF ( ASSOCIATED( grid%max_p ) ) THEN 
  DEALLOCATE(grid%max_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%max_p. ')
 endif
  NULLIFY(grid%max_p)
ENDIF
IF ( ASSOCIATED( grid%umaxw ) ) THEN 
  DEALLOCATE(grid%umaxw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%umaxw. ')
 endif
  NULLIFY(grid%umaxw)
ENDIF
IF ( ASSOCIATED( grid%ru_tend ) ) THEN 
  DEALLOCATE(grid%ru_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ru_tend. ')
 endif
  NULLIFY(grid%ru_tend)
ENDIF
IF ( ASSOCIATED( grid%rv_tend ) ) THEN 
  DEALLOCATE(grid%rv_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv_tend. ')
 endif
  NULLIFY(grid%rv_tend)
ENDIF
IF ( ASSOCIATED( grid%phb_fine ) ) THEN 
  DEALLOCATE(grid%phb_fine,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phb_fine. ')
 endif
  NULLIFY(grid%phb_fine)
ENDIF
IF ( ASSOCIATED( grid%ql_upstream_x_tend ) ) THEN 
  DEALLOCATE(grid%ql_upstream_x_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_upstream_x_tend. ')
 endif
  NULLIFY(grid%ql_upstream_x_tend)
ENDIF
IF ( ASSOCIATED( grid%qv_t_tend ) ) THEN 
  DEALLOCATE(grid%qv_t_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_t_tend. ')
 endif
  NULLIFY(grid%qv_t_tend)
ENDIF
IF ( ASSOCIATED( grid%tau_largescale_tend ) ) THEN 
  DEALLOCATE(grid%tau_largescale_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_largescale_tend. ')
 endif
  NULLIFY(grid%tau_largescale_tend)
ENDIF
IF ( ASSOCIATED( grid%mudf ) ) THEN 
  DEALLOCATE(grid%mudf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mudf. ')
 endif
  NULLIFY(grid%mudf)
ENDIF
IF ( ASSOCIATED( grid%nest_mask ) ) THEN 
  DEALLOCATE(grid%nest_mask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nest_mask. ')
 endif
  NULLIFY(grid%nest_mask)
ENDIF
IF ( ASSOCIATED( grid%al ) ) THEN 
  DEALLOCATE(grid%al,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%al. ')
 endif
  NULLIFY(grid%al)
ENDIF
IF ( ASSOCIATED( grid%dn ) ) THEN 
  DEALLOCATE(grid%dn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dn. ')
 endif
  NULLIFY(grid%dn)
ENDIF
IF ( ASSOCIATED( grid%lpi ) ) THEN 
  DEALLOCATE(grid%lpi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lpi. ')
 endif
  NULLIFY(grid%lpi)
ENDIF
IF ( ASSOCIATED( grid%qnocbb2d ) ) THEN 
  DEALLOCATE(grid%qnocbb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnocbb2d. ')
 endif
  NULLIFY(grid%qnocbb2d)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_ice ) ) THEN 
  DEALLOCATE(grid%dfi_re_ice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_ice. ')
 endif
  NULLIFY(grid%dfi_re_ice)
ENDIF
IF ( ASSOCIATED( grid%scalar_bxs ) ) THEN 
  DEALLOCATE(grid%scalar_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_bxs. ')
 endif
  NULLIFY(grid%scalar_bxs)
ENDIF
IF ( ASSOCIATED( grid%scalar_bxe ) ) THEN 
  DEALLOCATE(grid%scalar_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_bxe. ')
 endif
  NULLIFY(grid%scalar_bxe)
ENDIF
IF ( ASSOCIATED( grid%scalar_bys ) ) THEN 
  DEALLOCATE(grid%scalar_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_bys. ')
 endif
  NULLIFY(grid%scalar_bys)
ENDIF
IF ( ASSOCIATED( grid%scalar_bye ) ) THEN 
  DEALLOCATE(grid%scalar_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_bye. ')
 endif
  NULLIFY(grid%scalar_bye)
ENDIF
IF ( ASSOCIATED( grid%sw ) ) THEN 
  DEALLOCATE(grid%sw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw. ')
 endif
  NULLIFY(grid%sw)
ENDIF
IF ( ASSOCIATED( grid%sm010040 ) ) THEN 
  DEALLOCATE(grid%sm010040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm010040. ')
 endif
  NULLIFY(grid%sm010040)
ENDIF
IF ( ASSOCIATED( grid%sw040100 ) ) THEN 
  DEALLOCATE(grid%sw040100,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw040100. ')
 endif
  NULLIFY(grid%sw040100)
ENDIF
IF ( ASSOCIATED( grid%st100200 ) ) THEN 
  DEALLOCATE(grid%st100200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st100200. ')
 endif
  NULLIFY(grid%st100200)
ENDIF
IF ( ASSOCIATED( grid%slp_azi ) ) THEN 
  DEALLOCATE(grid%slp_azi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slp_azi. ')
 endif
  NULLIFY(grid%slp_azi)
ENDIF
IF ( ASSOCIATED( grid%irr_rand_field ) ) THEN 
  DEALLOCATE(grid%irr_rand_field,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irr_rand_field. ')
 endif
  NULLIFY(grid%irr_rand_field)
ENDIF
IF ( ASSOCIATED( grid%ts_tsk ) ) THEN 
  DEALLOCATE(grid%ts_tsk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tsk. ')
 endif
  NULLIFY(grid%ts_tsk)
ENDIF
IF ( ASSOCIATED( grid%dzr ) ) THEN 
  DEALLOCATE(grid%dzr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzr. ')
 endif
  NULLIFY(grid%dzr)
ENDIF
IF ( ASSOCIATED( grid%sh2o ) ) THEN 
  DEALLOCATE(grid%sh2o,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh2o. ')
 endif
  NULLIFY(grid%sh2o)
ENDIF
IF ( ASSOCIATED( grid%qtiledrain ) ) THEN 
  DEALLOCATE(grid%qtiledrain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtiledrain. ')
 endif
  NULLIFY(grid%qtiledrain)
ENDIF
IF ( ASSOCIATED( grid%acrunoff ) ) THEN 
  DEALLOCATE(grid%acrunoff,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acrunoff. ')
 endif
  NULLIFY(grid%acrunoff)
ENDIF
IF ( ASSOCIATED( grid%lake_depth ) ) THEN 
  DEALLOCATE(grid%lake_depth,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lake_depth. ')
 endif
  NULLIFY(grid%lake_depth)
ENDIF
IF ( ASSOCIATED( grid%dfi_php ) ) THEN 
  DEALLOCATE(grid%dfi_php,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_php. ')
 endif
  NULLIFY(grid%dfi_php)
ENDIF
IF ( ASSOCIATED( grid%dfi_tslb ) ) THEN 
  DEALLOCATE(grid%dfi_tslb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_tslb. ')
 endif
  NULLIFY(grid%dfi_tslb)
ENDIF
IF ( ASSOCIATED( grid%tc_urb2d ) ) THEN 
  DEALLOCATE(grid%tc_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tc_urb2d. ')
 endif
  NULLIFY(grid%tc_urb2d)
ENDIF
IF ( ASSOCIATED( grid%flxhumb_urb2d ) ) THEN 
  DEALLOCATE(grid%flxhumb_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flxhumb_urb2d. ')
 endif
  NULLIFY(grid%flxhumb_urb2d)
ENDIF
IF ( ASSOCIATED( grid%frc_urb2d ) ) THEN 
  DEALLOCATE(grid%frc_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%frc_urb2d. ')
 endif
  NULLIFY(grid%frc_urb2d)
ENDIF
IF ( ASSOCIATED( grid%sf_ac_urb3d ) ) THEN 
  DEALLOCATE(grid%sf_ac_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sf_ac_urb3d. ')
 endif
  NULLIFY(grid%sf_ac_urb3d)
ENDIF
IF ( ASSOCIATED( grid%t_pv_urb3d ) ) THEN 
  DEALLOCATE(grid%t_pv_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_pv_urb3d. ')
 endif
  NULLIFY(grid%t_pv_urb3d)
ENDIF
IF ( ASSOCIATED( grid%lfg_urb3d ) ) THEN 
  DEALLOCATE(grid%lfg_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfg_urb3d. ')
 endif
  NULLIFY(grid%lfg_urb3d)
ENDIF
IF ( ASSOCIATED( grid%hrang ) ) THEN 
  DEALLOCATE(grid%hrang,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hrang. ')
 endif
  NULLIFY(grid%hrang)
ENDIF
IF ( ASSOCIATED( grid%alswvisdir ) ) THEN 
  DEALLOCATE(grid%alswvisdir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alswvisdir. ')
 endif
  NULLIFY(grid%alswvisdir)
ENDIF
IF ( ASSOCIATED( grid%lai_px ) ) THEN 
  DEALLOCATE(grid%lai_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lai_px. ')
 endif
  NULLIFY(grid%lai_px)
ENDIF
IF ( ASSOCIATED( grid%qz0 ) ) THEN 
  DEALLOCATE(grid%qz0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qz0. ')
 endif
  NULLIFY(grid%qz0)
ENDIF
IF ( ASSOCIATED( grid%pshltr ) ) THEN 
  DEALLOCATE(grid%pshltr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pshltr. ')
 endif
  NULLIFY(grid%pshltr)
ENDIF
IF ( ASSOCIATED( grid%u_up ) ) THEN 
  DEALLOCATE(grid%u_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_up. ')
 endif
  NULLIFY(grid%u_up)
ENDIF
IF ( ASSOCIATED( grid%mf_temf ) ) THEN 
  DEALLOCATE(grid%mf_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mf_temf. ')
 endif
  NULLIFY(grid%mf_temf)
ENDIF
IF ( ASSOCIATED( grid%qbuoy ) ) THEN 
  DEALLOCATE(grid%qbuoy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qbuoy. ')
 endif
  NULLIFY(grid%qbuoy)
ENDIF
IF ( ASSOCIATED( grid%edmf_thl ) ) THEN 
  DEALLOCATE(grid%edmf_thl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_thl. ')
 endif
  NULLIFY(grid%edmf_thl)
ENDIF
IF ( ASSOCIATED( grid%dfgdp ) ) THEN 
  DEALLOCATE(grid%dfgdp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfgdp. ')
 endif
  NULLIFY(grid%dfgdp)
ENDIF
IF ( ASSOCIATED( grid%oa4 ) ) THEN 
  DEALLOCATE(grid%oa4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa4. ')
 endif
  NULLIFY(grid%oa4)
ENDIF
IF ( ASSOCIATED( grid%dtauy3d_fd ) ) THEN 
  DEALLOCATE(grid%dtauy3d_fd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtauy3d_fd. ')
 endif
  NULLIFY(grid%dtauy3d_fd)
ENDIF
IF ( ASSOCIATED( grid%oa2ls ) ) THEN 
  DEALLOCATE(grid%oa2ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa2ls. ')
 endif
  NULLIFY(grid%oa2ls)
ENDIF
IF ( ASSOCIATED( grid%oa4ss ) ) THEN 
  DEALLOCATE(grid%oa4ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa4ss. ')
 endif
  NULLIFY(grid%oa4ss)
ENDIF
IF ( ASSOCIATED( grid%b_u_bep ) ) THEN 
  DEALLOCATE(grid%b_u_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_u_bep. ')
 endif
  NULLIFY(grid%b_u_bep)
ENDIF
IF ( ASSOCIATED( grid%tpe_pbl ) ) THEN 
  DEALLOCATE(grid%tpe_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tpe_pbl. ')
 endif
  NULLIFY(grid%tpe_pbl)
ENDIF
IF ( ASSOCIATED( grid%cuppt ) ) THEN 
  DEALLOCATE(grid%cuppt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cuppt. ')
 endif
  NULLIFY(grid%cuppt)
ENDIF
IF ( ASSOCIATED( grid%o3_gfs_du ) ) THEN 
  DEALLOCATE(grid%o3_gfs_du,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%o3_gfs_du. ')
 endif
  NULLIFY(grid%o3_gfs_du)
ENDIF
IF ( ASSOCIATED( grid%aerosolc_1 ) ) THEN 
  DEALLOCATE(grid%aerosolc_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerosolc_1. ')
 endif
  NULLIFY(grid%aerosolc_1)
ENDIF
IF ( ASSOCIATED( grid%aerosolc_2 ) ) THEN 
  DEALLOCATE(grid%aerosolc_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerosolc_2. ')
 endif
  NULLIFY(grid%aerosolc_2)
ENDIF
IF ( ASSOCIATED( grid%om_lon ) ) THEN 
  DEALLOCATE(grid%om_lon,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_lon. ')
 endif
  NULLIFY(grid%om_lon)
ENDIF
IF ( ASSOCIATED( grid%tcloud_cup ) ) THEN 
  DEALLOCATE(grid%tcloud_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tcloud_cup. ')
 endif
  NULLIFY(grid%tcloud_cup)
ENDIF
IF ( ASSOCIATED( grid%mfup_cup ) ) THEN 
  DEALLOCATE(grid%mfup_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mfup_cup. ')
 endif
  NULLIFY(grid%mfup_cup)
ENDIF
IF ( ASSOCIATED( grid%qc_diabatic ) ) THEN 
  DEALLOCATE(grid%qc_diabatic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_diabatic. ')
 endif
  NULLIFY(grid%qc_diabatic)
ENDIF
IF ( ASSOCIATED( grid%e ) ) THEN 
  DEALLOCATE(grid%e,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%e. ')
 endif
  NULLIFY(grid%e)
ENDIF
IF ( ASSOCIATED( grid%shadowmask ) ) THEN 
  DEALLOCATE(grid%shadowmask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shadowmask. ')
 endif
  NULLIFY(grid%shadowmask)
ENDIF
IF ( ASSOCIATED( grid%physd ) ) THEN 
  DEALLOCATE(grid%physd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physd. ')
 endif
  NULLIFY(grid%physd)
ENDIF
IF ( ASSOCIATED( grid%precs3d ) ) THEN 
  DEALLOCATE(grid%precs3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%precs3d. ')
 endif
  NULLIFY(grid%precs3d)
ENDIF
IF ( ASSOCIATED( grid%cod2d_out ) ) THEN 
  DEALLOCATE(grid%cod2d_out,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cod2d_out. ')
 endif
  NULLIFY(grid%cod2d_out)
ENDIF
IF ( ASSOCIATED( grid%rqinshten ) ) THEN 
  DEALLOCATE(grid%rqinshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqinshten. ')
 endif
  NULLIFY(grid%rqinshten)
ENDIF
IF ( ASSOCIATED( grid%wub ) ) THEN 
  DEALLOCATE(grid%wub,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wub. ')
 endif
  NULLIFY(grid%wub)
ENDIF
IF ( ASSOCIATED( grid%rucuten ) ) THEN 
  DEALLOCATE(grid%rucuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rucuten. ')
 endif
  NULLIFY(grid%rucuten)
ENDIF
IF ( ASSOCIATED( grid%qiconv ) ) THEN 
  DEALLOCATE(grid%qiconv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qiconv. ')
 endif
  NULLIFY(grid%qiconv)
ENDIF
IF ( ASSOCIATED( grid%snownc ) ) THEN 
  DEALLOCATE(grid%snownc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snownc. ')
 endif
  NULLIFY(grid%snownc)
ENDIF
IF ( ASSOCIATED( grid%rhopo3d ) ) THEN 
  DEALLOCATE(grid%rhopo3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rhopo3d. ')
 endif
  NULLIFY(grid%rhopo3d)
ENDIF
IF ( ASSOCIATED( grid%itype_3 ) ) THEN 
  DEALLOCATE(grid%itype_3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%itype_3. ')
 endif
  NULLIFY(grid%itype_3)
ENDIF
IF ( ASSOCIATED( grid%apr_w ) ) THEN 
  DEALLOCATE(grid%apr_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_w. ')
 endif
  NULLIFY(grid%apr_w)
ENDIF
IF ( ASSOCIATED( grid%k22_deep ) ) THEN 
  DEALLOCATE(grid%k22_deep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%k22_deep. ')
 endif
  NULLIFY(grid%k22_deep)
ENDIF
IF ( ASSOCIATED( grid%gd_cldfr ) ) THEN 
  DEALLOCATE(grid%gd_cldfr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gd_cldfr. ')
 endif
  NULLIFY(grid%gd_cldfr)
ENDIF
IF ( ASSOCIATED( grid%ns_cu ) ) THEN 
  DEALLOCATE(grid%ns_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ns_cu. ')
 endif
  NULLIFY(grid%ns_cu)
ENDIF
IF ( ASSOCIATED( grid%ccn3_gs ) ) THEN 
  DEALLOCATE(grid%ccn3_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn3_gs. ')
 endif
  NULLIFY(grid%ccn3_gs)
ENDIF
IF ( ASSOCIATED( grid%rthratenlw ) ) THEN 
  DEALLOCATE(grid%rthratenlw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthratenlw. ')
 endif
  NULLIFY(grid%rthratenlw)
ENDIF
IF ( ASSOCIATED( grid%swdownc ) ) THEN 
  DEALLOCATE(grid%swdownc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdownc. ')
 endif
  NULLIFY(grid%swdownc)
ENDIF
IF ( ASSOCIATED( grid%swddnic2 ) ) THEN 
  DEALLOCATE(grid%swddnic2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddnic2. ')
 endif
  NULLIFY(grid%swddnic2)
ENDIF
IF ( ASSOCIATED( grid%aerssa2d ) ) THEN 
  DEALLOCATE(grid%aerssa2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerssa2d. ')
 endif
  NULLIFY(grid%aerssa2d)
ENDIF
IF ( ASSOCIATED( grid%q2max ) ) THEN 
  DEALLOCATE(grid%q2max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2max. ')
 endif
  NULLIFY(grid%q2max)
ENDIF
IF ( ASSOCIATED( grid%v10max ) ) THEN 
  DEALLOCATE(grid%v10max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10max. ')
 endif
  NULLIFY(grid%v10max)
ENDIF
IF ( ASSOCIATED( grid%trainncvmax ) ) THEN 
  DEALLOCATE(grid%trainncvmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trainncvmax. ')
 endif
  NULLIFY(grid%trainncvmax)
ENDIF
IF ( ASSOCIATED( grid%acswdnb ) ) THEN 
  DEALLOCATE(grid%acswdnb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswdnb. ')
 endif
  NULLIFY(grid%acswdnb)
ENDIF
IF ( ASSOCIATED( grid%i_acswdnt ) ) THEN 
  DEALLOCATE(grid%i_acswdnt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswdnt. ')
 endif
  NULLIFY(grid%i_acswdnt)
ENDIF
IF ( ASSOCIATED( grid%i_aclwdnb ) ) THEN 
  DEALLOCATE(grid%i_aclwdnb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwdnb. ')
 endif
  NULLIFY(grid%i_aclwdnb)
ENDIF
IF ( ASSOCIATED( grid%swdnbc ) ) THEN 
  DEALLOCATE(grid%swdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnbc. ')
 endif
  NULLIFY(grid%swdnbc)
ENDIF
IF ( ASSOCIATED( grid%lwdnbc ) ) THEN 
  DEALLOCATE(grid%lwdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnbc. ')
 endif
  NULLIFY(grid%lwdnbc)
ENDIF
IF ( ASSOCIATED( grid%embck ) ) THEN 
  DEALLOCATE(grid%embck,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%embck. ')
 endif
  NULLIFY(grid%embck)
ENDIF
IF ( ASSOCIATED( grid%rqniblten ) ) THEN 
  DEALLOCATE(grid%rqniblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqniblten. ')
 endif
  NULLIFY(grid%rqniblten)
ENDIF
IF ( ASSOCIATED( grid%snowh_mosaic ) ) THEN 
  DEALLOCATE(grid%snowh_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowh_mosaic. ')
 endif
  NULLIFY(grid%snowh_mosaic)
ENDIF
IF ( ASSOCIATED( grid%lh_mosaic ) ) THEN 
  DEALLOCATE(grid%lh_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lh_mosaic. ')
 endif
  NULLIFY(grid%lh_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tbl_urb3d_mosaic ) ) THEN 
  DEALLOCATE(grid%tbl_urb3d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tbl_urb3d_mosaic. ')
 endif
  NULLIFY(grid%tbl_urb3d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%ck ) ) THEN 
  DEALLOCATE(grid%ck,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ck. ')
 endif
  NULLIFY(grid%ck)
ENDIF
IF ( ASSOCIATED( grid%hfx ) ) THEN 
  DEALLOCATE(grid%hfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx. ')
 endif
  NULLIFY(grid%hfx)
ENDIF
IF ( ASSOCIATED( grid%dew ) ) THEN 
  DEALLOCATE(grid%dew,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dew. ')
 endif
  NULLIFY(grid%dew)
ENDIF
IF ( ASSOCIATED( grid%snopcx ) ) THEN 
  DEALLOCATE(grid%snopcx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snopcx. ')
 endif
  NULLIFY(grid%snopcx)
ENDIF
IF ( ASSOCIATED( grid%xkmh ) ) THEN 
  DEALLOCATE(grid%xkmh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xkmh. ')
 endif
  NULLIFY(grid%xkmh)
ENDIF
IF ( ASSOCIATED( grid%rphndgdten ) ) THEN 
  DEALLOCATE(grid%rphndgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rphndgdten. ')
 endif
  NULLIFY(grid%rphndgdten)
ENDIF
IF ( ASSOCIATED( grid%th2_ndg_new ) ) THEN 
  DEALLOCATE(grid%th2_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th2_ndg_new. ')
 endif
  NULLIFY(grid%th2_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%odis_ndg_new ) ) THEN 
  DEALLOCATE(grid%odis_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%odis_ndg_new. ')
 endif
  NULLIFY(grid%odis_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%emstot ) ) THEN 
  DEALLOCATE(grid%emstot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%emstot. ')
 endif
  NULLIFY(grid%emstot)
ENDIF
IF ( ASSOCIATED( grid%uh ) ) THEN 
  DEALLOCATE(grid%uh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uh. ')
 endif
  NULLIFY(grid%uh)
ENDIF
IF ( ASSOCIATED( grid%tml ) ) THEN 
  DEALLOCATE(grid%tml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tml. ')
 endif
  NULLIFY(grid%tml)
ENDIF
IF ( ASSOCIATED( grid%track_w ) ) THEN 
  DEALLOCATE(grid%track_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_w. ')
 endif
  NULLIFY(grid%track_w)
ENDIF
IF ( ASSOCIATED( grid%cldmask ) ) THEN 
  DEALLOCATE(grid%cldmask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldmask. ')
 endif
  NULLIFY(grid%cldmask)
ENDIF
IF ( ASSOCIATED( grid%avshten ) ) THEN 
  DEALLOCATE(grid%avshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avshten. ')
 endif
  NULLIFY(grid%avshten)
ENDIF
IF ( ASSOCIATED( grid%w_xxx ) ) THEN 
  DEALLOCATE(grid%w_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_xxx. ')
 endif
  NULLIFY(grid%w_xxx)
ENDIF
IF ( ASSOCIATED( grid%nfuel_cat ) ) THEN 
  DEALLOCATE(grid%nfuel_cat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nfuel_cat. ')
 endif
  NULLIFY(grid%nfuel_cat)
ENDIF
IF ( ASSOCIATED( grid%uah ) ) THEN 
  DEALLOCATE(grid%uah,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uah. ')
 endif
  NULLIFY(grid%uah)
ENDIF
IF ( ASSOCIATED( grid%fuel_frac ) ) THEN 
  DEALLOCATE(grid%fuel_frac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fuel_frac. ')
 endif
  NULLIFY(grid%fuel_frac)
ENDIF
IF ( ASSOCIATED( grid%fmc_g ) ) THEN 
  DEALLOCATE(grid%fmc_g,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmc_g. ')
 endif
  NULLIFY(grid%fmc_g)
ENDIF
IF ( ASSOCIATED( grid%bbb ) ) THEN 
  DEALLOCATE(grid%bbb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bbb. ')
 endif
  NULLIFY(grid%bbb)
ENDIF
IF ( ASSOCIATED( grid%fs_count_landed_all ) ) THEN 
  DEALLOCATE(grid%fs_count_landed_all,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_count_landed_all. ')
 endif
  NULLIFY(grid%fs_count_landed_all)
ENDIF
IF ( ASSOCIATED( grid%fs_p_mass ) ) THEN 
  DEALLOCATE(grid%fs_p_mass,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_mass. ')
 endif
  NULLIFY(grid%fs_p_mass)
ENDIF
IF ( ASSOCIATED( grid%avgflx_efu1 ) ) THEN 
  DEALLOCATE(grid%avgflx_efu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_efu1. ')
 endif
  NULLIFY(grid%avgflx_efu1)
ENDIF
IF ( ASSOCIATED( grid%vertstrucs ) ) THEN 
  DEALLOCATE(grid%vertstrucs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertstrucs. ')
 endif
  NULLIFY(grid%vertstrucs)
ENDIF
IF ( ASSOCIATED( grid%rand_real ) ) THEN 
  DEALLOCATE(grid%rand_real,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_real. ')
 endif
  NULLIFY(grid%rand_real)
ENDIF
IF ( ASSOCIATED( grid%spforcs2 ) ) THEN 
  DEALLOCATE(grid%spforcs2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs2. ')
 endif
  NULLIFY(grid%spforcs2)
ENDIF
IF ( ASSOCIATED( grid%spptforcs ) ) THEN 
  DEALLOCATE(grid%spptforcs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spptforcs. ')
 endif
  NULLIFY(grid%spptforcs)
ENDIF
IF ( ASSOCIATED( grid%rand_imag_xxx ) ) THEN 
  DEALLOCATE(grid%rand_imag_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_imag_xxx. ')
 endif
  NULLIFY(grid%rand_imag_xxx)
ENDIF
IF ( ASSOCIATED( grid%lengthscale_mult3d ) ) THEN 
  DEALLOCATE(grid%lengthscale_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lengthscale_mult3d. ')
 endif
  NULLIFY(grid%lengthscale_mult3d)
ENDIF
IF ( ASSOCIATED( grid%precz ) ) THEN 
  DEALLOCATE(grid%precz,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%precz. ')
 endif
  NULLIFY(grid%precz)
ENDIF
IF ( ASSOCIATED( grid%zmntsnpd ) ) THEN 
  DEALLOCATE(grid%zmntsnpd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmntsnpd. ')
 endif
  NULLIFY(grid%zmntsnpd)
ENDIF
IF ( ASSOCIATED( grid%zmupgd ) ) THEN 
  DEALLOCATE(grid%zmupgd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmupgd. ')
 endif
  NULLIFY(grid%zmupgd)
ENDIF
IF ( ASSOCIATED( grid%ed3d ) ) THEN 
  DEALLOCATE(grid%ed3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ed3d. ')
 endif
  NULLIFY(grid%ed3d)
ENDIF
IF ( ASSOCIATED( grid%cmfmc2 ) ) THEN 
  DEALLOCATE(grid%cmfmc2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmfmc2. ')
 endif
  NULLIFY(grid%cmfmc2)
ENDIF
IF ( ASSOCIATED( grid%uflx_cu ) ) THEN 
  DEALLOCATE(grid%uflx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uflx_cu. ')
 endif
  NULLIFY(grid%uflx_cu)
ENDIF
IF ( ASSOCIATED( grid%winvbase_cu ) ) THEN 
  DEALLOCATE(grid%winvbase_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%winvbase_cu. ')
 endif
  NULLIFY(grid%winvbase_cu)
ENDIF
IF ( ASSOCIATED( grid%cinlcl_cu ) ) THEN 
  DEALLOCATE(grid%cinlcl_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cinlcl_cu. ')
 endif
  NULLIFY(grid%cinlcl_cu)
ENDIF
IF ( ASSOCIATED( grid%thvu_cu ) ) THEN 
  DEALLOCATE(grid%thvu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thvu_cu. ')
 endif
  NULLIFY(grid%thvu_cu)
ENDIF
IF ( ASSOCIATED( grid%cufrc_cu ) ) THEN 
  DEALLOCATE(grid%cufrc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cufrc_cu. ')
 endif
  NULLIFY(grid%cufrc_cu)
ENDIF
IF ( ASSOCIATED( grid%excessu0_cu ) ) THEN 
  DEALLOCATE(grid%excessu0_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%excessu0_cu. ')
 endif
  NULLIFY(grid%excessu0_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_wtw_cu ) ) THEN 
  DEALLOCATE(grid%exit_wtw_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_wtw_cu. ')
 endif
  NULLIFY(grid%exit_wtw_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_cin_cu ) ) THEN 
  DEALLOCATE(grid%limit_cin_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_cin_cu. ')
 endif
  NULLIFY(grid%limit_cin_cu)
ENDIF
IF ( ASSOCIATED( grid%cldfrai ) ) THEN 
  DEALLOCATE(grid%cldfrai,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfrai. ')
 endif
  NULLIFY(grid%cldfrai)
ENDIF
IF ( ASSOCIATED( grid%snowdp ) ) THEN 
  DEALLOCATE(grid%snowdp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowdp. ')
 endif
  NULLIFY(grid%snowdp)
ENDIF
IF ( ASSOCIATED( grid%fsd240 ) ) THEN 
  DEALLOCATE(grid%fsd240,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsd240. ')
 endif
  NULLIFY(grid%fsd240)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq_s2 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq_s2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq_s2. ')
 endif
  NULLIFY(grid%h2osoi_liq_s2)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq9 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq9,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq9. ')
 endif
  NULLIFY(grid%h2osoi_liq9)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice6 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice6,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice6. ')
 endif
  NULLIFY(grid%h2osoi_ice6)
ENDIF
IF ( ASSOCIATED( grid%t_soisno3 ) ) THEN 
  DEALLOCATE(grid%t_soisno3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno3. ')
 endif
  NULLIFY(grid%t_soisno3)
ENDIF
IF ( ASSOCIATED( grid%dzsnow5 ) ) THEN 
  DEALLOCATE(grid%dzsnow5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzsnow5. ')
 endif
  NULLIFY(grid%dzsnow5)
ENDIF
IF ( ASSOCIATED( grid%t_lake7 ) ) THEN 
  DEALLOCATE(grid%t_lake7,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake7. ')
 endif
  NULLIFY(grid%t_lake7)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol9 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol9,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol9. ')
 endif
  NULLIFY(grid%h2osoi_vol9)
ENDIF
IF ( ASSOCIATED( grid%lakedepth2d ) ) THEN 
  DEALLOCATE(grid%lakedepth2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lakedepth2d. ')
 endif
  NULLIFY(grid%lakedepth2d)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq3d ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq3d. ')
 endif
  NULLIFY(grid%h2osoi_liq3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_eci ) ) THEN 
  DEALLOCATE(grid%ssib_eci,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_eci. ')
 endif
  NULLIFY(grid%ssib_eci)
ENDIF
IF ( ASSOCIATED( grid%ssib_vcf ) ) THEN 
  DEALLOCATE(grid%ssib_vcf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_vcf. ')
 endif
  NULLIFY(grid%ssib_vcf)
ENDIF
IF ( ASSOCIATED( grid%bwo1 ) ) THEN 
  DEALLOCATE(grid%bwo1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bwo1. ')
 endif
  NULLIFY(grid%bwo1)
ENDIF
IF ( ASSOCIATED( grid%bwo2 ) ) THEN 
  DEALLOCATE(grid%bwo2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bwo2. ')
 endif
  NULLIFY(grid%bwo2)
ENDIF
IF ( ASSOCIATED( grid%bwo3 ) ) THEN 
  DEALLOCATE(grid%bwo3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bwo3. ')
 endif
  NULLIFY(grid%bwo3)
ENDIF
IF ( ASSOCIATED( grid%bwo4 ) ) THEN 
  DEALLOCATE(grid%bwo4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bwo4. ')
 endif
  NULLIFY(grid%bwo4)
ENDIF
IF ( ASSOCIATED( grid%canliqxy ) ) THEN 
  DEALLOCATE(grid%canliqxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canliqxy. ')
 endif
  NULLIFY(grid%canliqxy)
ENDIF
IF ( ASSOCIATED( grid%waxy ) ) THEN 
  DEALLOCATE(grid%waxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%waxy. ')
 endif
  NULLIFY(grid%waxy)
ENDIF
IF ( ASSOCIATED( grid%xsaixy ) ) THEN 
  DEALLOCATE(grid%xsaixy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xsaixy. ')
 endif
  NULLIFY(grid%xsaixy)
ENDIF
IF ( ASSOCIATED( grid%runsfxy ) ) THEN 
  DEALLOCATE(grid%runsfxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%runsfxy. ')
 endif
  NULLIFY(grid%runsfxy)
ENDIF
IF ( ASSOCIATED( grid%rsshaxy ) ) THEN 
  DEALLOCATE(grid%rsshaxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rsshaxy. ')
 endif
  NULLIFY(grid%rsshaxy)
ENDIF
IF ( ASSOCIATED( grid%ghvxy ) ) THEN 
  DEALLOCATE(grid%ghvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ghvxy. ')
 endif
  NULLIFY(grid%ghvxy)
ENDIF
IF ( ASSOCIATED( grid%smoiseq ) ) THEN 
  DEALLOCATE(grid%smoiseq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smoiseq. ')
 endif
  NULLIFY(grid%smoiseq)
ENDIF
IF ( ASSOCIATED( grid%qlatxy ) ) THEN 
  DEALLOCATE(grid%qlatxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qlatxy. ')
 endif
  NULLIFY(grid%qlatxy)
ENDIF
IF ( ASSOCIATED( grid%qthrosxy ) ) THEN 
  DEALLOCATE(grid%qthrosxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qthrosxy. ')
 endif
  NULLIFY(grid%qthrosxy)
ENDIF
IF ( ASSOCIATED( grid%pondingxy ) ) THEN 
  DEALLOCATE(grid%pondingxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pondingxy. ')
 endif
  NULLIFY(grid%pondingxy)
ENDIF
IF ( ASSOCIATED( grid%soilcl3 ) ) THEN 
  DEALLOCATE(grid%soilcl3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcl3. ')
 endif
  NULLIFY(grid%soilcl3)
ENDIF
IF ( ASSOCIATED( grid%forcwlsm ) ) THEN 
  DEALLOCATE(grid%forcwlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%forcwlsm. ')
 endif
  NULLIFY(grid%forcwlsm)
ENDIF
IF ( ASSOCIATED( grid%acfroc ) ) THEN 
  DEALLOCATE(grid%acfroc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acfroc. ')
 endif
  NULLIFY(grid%acfroc)
ENDIF
IF ( ASSOCIATED( grid%acirb ) ) THEN 
  DEALLOCATE(grid%acirb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acirb. ')
 endif
  NULLIFY(grid%acirb)
ENDIF
IF ( ASSOCIATED( grid%acirc ) ) THEN 
  DEALLOCATE(grid%acirc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acirc. ')
 endif
  NULLIFY(grid%acirc)
ENDIF
IF ( ASSOCIATED( grid%acpahlsm ) ) THEN 
  DEALLOCATE(grid%acpahlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acpahlsm. ')
 endif
  NULLIFY(grid%acpahlsm)
ENDIF
IF ( ASSOCIATED( grid%acc_ecanxy ) ) THEN 
  DEALLOCATE(grid%acc_ecanxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_ecanxy. ')
 endif
  NULLIFY(grid%acc_ecanxy)
ENDIF
IF ( ASSOCIATED( grid%td_fraction ) ) THEN 
  DEALLOCATE(grid%td_fraction,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%td_fraction. ')
 endif
  NULLIFY(grid%td_fraction)
ENDIF
IF ( ASSOCIATED( grid%irsivol ) ) THEN 
  DEALLOCATE(grid%irsivol,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irsivol. ')
 endif
  NULLIFY(grid%irsivol)
ENDIF
IF ( ASSOCIATED( grid%kext_qa ) ) THEN 
  DEALLOCATE(grid%kext_qa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qa. ')
 endif
  NULLIFY(grid%kext_qa)
ENDIF
IF ( ASSOCIATED( grid%tcoli_max ) ) THEN 
  DEALLOCATE(grid%tcoli_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tcoli_max. ')
 endif
  NULLIFY(grid%tcoli_max)
ENDIF
IF ( ASSOCIATED( grid%qicing_lg_max ) ) THEN 
  DEALLOCATE(grid%qicing_lg_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qicing_lg_max. ')
 endif
  NULLIFY(grid%qicing_lg_max)
ENDIF
IF ( ASSOCIATED( grid%afwa_llturblgt ) ) THEN 
  DEALLOCATE(grid%afwa_llturblgt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_llturblgt. ')
 endif
  NULLIFY(grid%afwa_llturblgt)
ENDIF
IF ( ASSOCIATED( grid%afwa_vis_dust ) ) THEN 
  DEALLOCATE(grid%afwa_vis_dust,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_vis_dust. ')
 endif
  NULLIFY(grid%afwa_vis_dust)
ENDIF
IF ( ASSOCIATED( grid%midrh_min_old ) ) THEN 
  DEALLOCATE(grid%midrh_min_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%midrh_min_old. ')
 endif
  NULLIFY(grid%midrh_min_old)
ENDIF
IF ( ASSOCIATED( grid%hfx_mean ) ) THEN 
  DEALLOCATE(grid%hfx_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx_mean. ')
 endif
  NULLIFY(grid%hfx_mean)
ENDIF
IF ( ASSOCIATED( grid%psfc_diurn ) ) THEN 
  DEALLOCATE(grid%psfc_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc_diurn. ')
 endif
  NULLIFY(grid%psfc_diurn)
ENDIF
IF ( ASSOCIATED( grid%swupb_diurn ) ) THEN 
  DEALLOCATE(grid%swupb_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupb_diurn. ')
 endif
  NULLIFY(grid%swupb_diurn)
ENDIF
IF ( ASSOCIATED( grid%u10_dtmp ) ) THEN 
  DEALLOCATE(grid%u10_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10_dtmp. ')
 endif
  NULLIFY(grid%u10_dtmp)
ENDIF
IF ( ASSOCIATED( grid%lightdis ) ) THEN 
  DEALLOCATE(grid%lightdis,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lightdis. ')
 endif
  NULLIFY(grid%lightdis)
ENDIF
IF ( ASSOCIATED( grid%c3f ) ) THEN 
  DEALLOCATE(grid%c3f,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c3f. ')
 endif
  NULLIFY(grid%c3f)
ENDIF
IF ( ASSOCIATED( grid%qnbca_gc ) ) THEN 
  DEALLOCATE(grid%qnbca_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnbca_gc. ')
 endif
  NULLIFY(grid%qnbca_gc)
ENDIF
IF ( ASSOCIATED( grid%p_wif_oct ) ) THEN 
  DEALLOCATE(grid%p_wif_oct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_oct. ')
 endif
  NULLIFY(grid%p_wif_oct)
ENDIF
IF ( ASSOCIATED( grid%w_wif_sep ) ) THEN 
  DEALLOCATE(grid%w_wif_sep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_sep. ')
 endif
  NULLIFY(grid%w_wif_sep)
ENDIF
IF ( ASSOCIATED( grid%i_wif_aug ) ) THEN 
  DEALLOCATE(grid%i_wif_aug,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_aug. ')
 endif
  NULLIFY(grid%i_wif_aug)
ENDIF
IF ( ASSOCIATED( grid%b_wif_jul ) ) THEN 
  DEALLOCATE(grid%b_wif_jul,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_jul. ')
 endif
  NULLIFY(grid%b_wif_jul)
ENDIF
IF ( ASSOCIATED( grid%vmet ) ) THEN 
  DEALLOCATE(grid%vmet,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vmet. ')
 endif
  NULLIFY(grid%vmet)
ENDIF
IF ( ASSOCIATED( grid%wvp ) ) THEN 
  DEALLOCATE(grid%wvp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wvp. ')
 endif
  NULLIFY(grid%wvp)
ENDIF
IF ( ASSOCIATED( grid%re_qi_tot ) ) THEN 
  DEALLOCATE(grid%re_qi_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_qi_tot. ')
 endif
  NULLIFY(grid%re_qi_tot)
ENDIF
IF ( ASSOCIATED( grid%ghi_accum ) ) THEN 
  DEALLOCATE(grid%ghi_accum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ghi_accum. ')
 endif
  NULLIFY(grid%ghi_accum)
ENDIF
IF ( ASSOCIATED( grid%ts_re_qs ) ) THEN 
  DEALLOCATE(grid%ts_re_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_re_qs. ')
 endif
  NULLIFY(grid%ts_re_qs)
ENDIF
IF ( ASSOCIATED( grid%ts_clrnidx ) ) THEN 
  DEALLOCATE(grid%ts_clrnidx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_clrnidx. ')
 endif
  NULLIFY(grid%ts_clrnidx)
ENDIF
IF ( ASSOCIATED( grid%ts_swddnic2 ) ) THEN 
  DEALLOCATE(grid%ts_swddnic2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddnic2. ')
 endif
  NULLIFY(grid%ts_swddnic2)
ENDIF
IF ( ASSOCIATED( grid%t_pl ) ) THEN 
  DEALLOCATE(grid%t_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_pl. ')
 endif
  NULLIFY(grid%t_pl)
ENDIF
IF ( ASSOCIATED( grid%z_zl ) ) THEN 
  DEALLOCATE(grid%z_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z_zl. ')
 endif
  NULLIFY(grid%z_zl)
ENDIF
IF ( ASSOCIATED( grid%mcm_sw ) ) THEN 
  DEALLOCATE(grid%mcm_sw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_sw. ')
 endif
  NULLIFY(grid%mcm_sw)
ENDIF
IF ( ASSOCIATED( grid%mcm_sw_out ) ) THEN 
  DEALLOCATE(grid%mcm_sw_out,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_sw_out. ')
 endif
  NULLIFY(grid%mcm_sw_out)
ENDIF
IF ( ASSOCIATED( grid%prtdt ) ) THEN 
  DEALLOCATE(grid%prtdt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prtdt. ')
 endif
  NULLIFY(grid%prtdt)
ENDIF
IF ( ASSOCIATED( grid%landmask ) ) THEN 
  DEALLOCATE(grid%landmask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%landmask. ')
 endif
  NULLIFY(grid%landmask)
ENDIF
END SUBROUTINE deallocs_1
!ENDOFREGISTRYGENERATEDINCLUDE
