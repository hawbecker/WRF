!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_4.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_4( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%znu ) ) THEN 
  DEALLOCATE(grid%znu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%znu. ')
 endif
  NULLIFY(grid%znu)
ENDIF
IF ( ASSOCIATED( grid%rh_gc ) ) THEN 
  DEALLOCATE(grid%rh_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_gc. ')
 endif
  NULLIFY(grid%rh_gc)
ENDIF
IF ( ASSOCIATED( grid%pslv_gc ) ) THEN 
  DEALLOCATE(grid%pslv_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pslv_gc. ')
 endif
  NULLIFY(grid%pslv_gc)
ENDIF
IF ( ASSOCIATED( grid%sh_gc ) ) THEN 
  DEALLOCATE(grid%sh_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh_gc. ')
 endif
  NULLIFY(grid%sh_gc)
ENDIF
IF ( ASSOCIATED( grid%qnc_gc ) ) THEN 
  DEALLOCATE(grid%qnc_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnc_gc. ')
 endif
  NULLIFY(grid%qnc_gc)
ENDIF
IF ( ASSOCIATED( grid%min_p ) ) THEN 
  DEALLOCATE(grid%min_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%min_p. ')
 endif
  NULLIFY(grid%min_p)
ENDIF
IF ( ASSOCIATED( grid%vtrop ) ) THEN 
  DEALLOCATE(grid%vtrop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vtrop. ')
 endif
  NULLIFY(grid%vtrop)
ENDIF
IF ( ASSOCIATED( grid%z_force ) ) THEN 
  DEALLOCATE(grid%z_force,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z_force. ')
 endif
  NULLIFY(grid%z_force)
ENDIF
IF ( ASSOCIATED( grid%v_g ) ) THEN 
  DEALLOCATE(grid%v_g,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_g. ')
 endif
  NULLIFY(grid%v_g)
ENDIF
IF ( ASSOCIATED( grid%th_upstream_x ) ) THEN 
  DEALLOCATE(grid%th_upstream_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_upstream_x. ')
 endif
  NULLIFY(grid%th_upstream_x)
ENDIF
IF ( ASSOCIATED( grid%u_upstream_x ) ) THEN 
  DEALLOCATE(grid%u_upstream_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_upstream_x. ')
 endif
  NULLIFY(grid%u_upstream_x)
ENDIF
IF ( ASSOCIATED( grid%qv_largescale ) ) THEN 
  DEALLOCATE(grid%qv_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_largescale. ')
 endif
  NULLIFY(grid%qv_largescale)
ENDIF
IF ( ASSOCIATED( grid%tau_y ) ) THEN 
  DEALLOCATE(grid%tau_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_y. ')
 endif
  NULLIFY(grid%tau_y)
ENDIF
IF ( ASSOCIATED( grid%muv ) ) THEN 
  DEALLOCATE(grid%muv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%muv. ')
 endif
  NULLIFY(grid%muv)
ENDIF
IF ( ASSOCIATED( grid%zx ) ) THEN 
  DEALLOCATE(grid%zx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zx. ')
 endif
  NULLIFY(grid%zx)
ENDIF
IF ( ASSOCIATED( grid%z_at_w ) ) THEN 
  DEALLOCATE(grid%z_at_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z_at_w. ')
 endif
  NULLIFY(grid%z_at_w)
ENDIF
IF ( ASSOCIATED( grid%tratx ) ) THEN 
  DEALLOCATE(grid%tratx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tratx. ')
 endif
  NULLIFY(grid%tratx)
ENDIF
IF ( ASSOCIATED( grid%moist_btxs ) ) THEN 
  DEALLOCATE(grid%moist_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_btxs. ')
 endif
  NULLIFY(grid%moist_btxs)
ENDIF
IF ( ASSOCIATED( grid%moist_btxe ) ) THEN 
  DEALLOCATE(grid%moist_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_btxe. ')
 endif
  NULLIFY(grid%moist_btxe)
ENDIF
IF ( ASSOCIATED( grid%moist_btys ) ) THEN 
  DEALLOCATE(grid%moist_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_btys. ')
 endif
  NULLIFY(grid%moist_btys)
ENDIF
IF ( ASSOCIATED( grid%moist_btye ) ) THEN 
  DEALLOCATE(grid%moist_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_btye. ')
 endif
  NULLIFY(grid%moist_btye)
ENDIF
IF ( ASSOCIATED( grid%re_ice ) ) THEN 
  DEALLOCATE(grid%re_ice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_ice. ')
 endif
  NULLIFY(grid%re_ice)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_rain_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_rain_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_rain_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_rain_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_bxs ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_bxs. ')
 endif
  NULLIFY(grid%dfi_scalar_bxs)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_bxe ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_bxe. ')
 endif
  NULLIFY(grid%dfi_scalar_bxe)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_bys ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_bys. ')
 endif
  NULLIFY(grid%dfi_scalar_bys)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar_bye ) ) THEN 
  DEALLOCATE(grid%dfi_scalar_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar_bye. ')
 endif
  NULLIFY(grid%dfi_scalar_bye)
ENDIF
IF ( ASSOCIATED( grid%sm000007 ) ) THEN 
  DEALLOCATE(grid%sm000007,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm000007. ')
 endif
  NULLIFY(grid%sm000007)
ENDIF
IF ( ASSOCIATED( grid%sm010200 ) ) THEN 
  DEALLOCATE(grid%sm010200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm010200. ')
 endif
  NULLIFY(grid%sm010200)
ENDIF
IF ( ASSOCIATED( grid%soilw000 ) ) THEN 
  DEALLOCATE(grid%soilw000,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilw000. ')
 endif
  NULLIFY(grid%soilw000)
ENDIF
IF ( ASSOCIATED( grid%soilt005 ) ) THEN 
  DEALLOCATE(grid%soilt005,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt005. ')
 endif
  NULLIFY(grid%soilt005)
ENDIF
IF ( ASSOCIATED( grid%snoalb ) ) THEN 
  DEALLOCATE(grid%snoalb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snoalb. ')
 endif
  NULLIFY(grid%snoalb)
ENDIF
IF ( ASSOCIATED( grid%ts_u ) ) THEN 
  DEALLOCATE(grid%ts_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_u. ')
 endif
  NULLIFY(grid%ts_u)
ENDIF
IF ( ASSOCIATED( grid%ts_rainc ) ) THEN 
  DEALLOCATE(grid%ts_rainc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_rainc. ')
 endif
  NULLIFY(grid%ts_rainc)
ENDIF
IF ( ASSOCIATED( grid%urb_param ) ) THEN 
  DEALLOCATE(grid%urb_param,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%urb_param. ')
 endif
  NULLIFY(grid%urb_param)
ENDIF
IF ( ASSOCIATED( grid%icedepth ) ) THEN 
  DEALLOCATE(grid%icedepth,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icedepth. ')
 endif
  NULLIFY(grid%icedepth)
ENDIF
IF ( ASSOCIATED( grid%udrunoff ) ) THEN 
  DEALLOCATE(grid%udrunoff,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%udrunoff. ')
 endif
  NULLIFY(grid%udrunoff)
ENDIF
IF ( ASSOCIATED( grid%snowh ) ) THEN 
  DEALLOCATE(grid%snowh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowh. ')
 endif
  NULLIFY(grid%snowh)
ENDIF
IF ( ASSOCIATED( grid%uoce ) ) THEN 
  DEALLOCATE(grid%uoce,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uoce. ')
 endif
  NULLIFY(grid%uoce)
ENDIF
IF ( ASSOCIATED( grid%dfi_w ) ) THEN 
  DEALLOCATE(grid%dfi_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_w. ')
 endif
  NULLIFY(grid%dfi_w)
ENDIF
IF ( ASSOCIATED( grid%dfi_snowh ) ) THEN 
  DEALLOCATE(grid%dfi_snowh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_snowh. ')
 endif
  NULLIFY(grid%dfi_snowh)
ENDIF
IF ( ASSOCIATED( grid%xxxr_urb2d ) ) THEN 
  DEALLOCATE(grid%xxxr_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xxxr_urb2d. ')
 endif
  NULLIFY(grid%xxxr_urb2d)
ENDIF
IF ( ASSOCIATED( grid%smr_urb3d ) ) THEN 
  DEALLOCATE(grid%smr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smr_urb3d. ')
 endif
  NULLIFY(grid%smr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%tw1_urb4d ) ) THEN 
  DEALLOCATE(grid%tw1_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tw1_urb4d. ')
 endif
  NULLIFY(grid%tw1_urb4d)
ENDIF
IF ( ASSOCIATED( grid%sfvent_urb3d ) ) THEN 
  DEALLOCATE(grid%sfvent_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfvent_urb3d. ')
 endif
  NULLIFY(grid%sfvent_urb3d)
ENDIF
IF ( ASSOCIATED( grid%qgr_urb3d ) ) THEN 
  DEALLOCATE(grid%qgr_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qgr_urb3d. ')
 endif
  NULLIFY(grid%qgr_urb3d)
ENDIF
IF ( ASSOCIATED( grid%cmc_sfcdif ) ) THEN 
  DEALLOCATE(grid%cmc_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmc_sfcdif. ')
 endif
  NULLIFY(grid%cmc_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%rhosnf ) ) THEN 
  DEALLOCATE(grid%rhosnf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rhosnf. ')
 endif
  NULLIFY(grid%rhosnf)
ENDIF
IF ( ASSOCIATED( grid%alswnirdif ) ) THEN 
  DEALLOCATE(grid%alswnirdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alswnirdif. ')
 endif
  NULLIFY(grid%alswnirdif)
ENDIF
IF ( ASSOCIATED( grid%wsat_px ) ) THEN 
  DEALLOCATE(grid%wsat_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wsat_px. ')
 endif
  NULLIFY(grid%wsat_px)
ENDIF
IF ( ASSOCIATED( grid%wstar_ysu ) ) THEN 
  DEALLOCATE(grid%wstar_ysu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wstar_ysu. ')
 endif
  NULLIFY(grid%wstar_ysu)
ENDIF
IF ( ASSOCIATED( grid%qsfc ) ) THEN 
  DEALLOCATE(grid%qsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsfc. ')
 endif
  NULLIFY(grid%qsfc)
ENDIF
IF ( ASSOCIATED( grid%rc_mf ) ) THEN 
  DEALLOCATE(grid%rc_mf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rc_mf. ')
 endif
  NULLIFY(grid%rc_mf)
ENDIF
IF ( ASSOCIATED( grid%qlup_temf ) ) THEN 
  DEALLOCATE(grid%qlup_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qlup_temf. ')
 endif
  NULLIFY(grid%qlup_temf)
ENDIF
IF ( ASSOCIATED( grid%dqke ) ) THEN 
  DEALLOCATE(grid%dqke,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dqke. ')
 endif
  NULLIFY(grid%dqke)
ENDIF
IF ( ASSOCIATED( grid%edmf_qc ) ) THEN 
  DEALLOCATE(grid%edmf_qc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_qc. ')
 endif
  NULLIFY(grid%edmf_qc)
ENDIF
IF ( ASSOCIATED( grid%dtaux3d ) ) THEN 
  DEALLOCATE(grid%dtaux3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtaux3d. ')
 endif
  NULLIFY(grid%dtaux3d)
ENDIF
IF ( ASSOCIATED( grid%ol3 ) ) THEN 
  DEALLOCATE(grid%ol3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol3. ')
 endif
  NULLIFY(grid%ol3)
ENDIF
IF ( ASSOCIATED( grid%dusfcg_bl ) ) THEN 
  DEALLOCATE(grid%dusfcg_bl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dusfcg_bl. ')
 endif
  NULLIFY(grid%dusfcg_bl)
ENDIF
IF ( ASSOCIATED( grid%ol1ls ) ) THEN 
  DEALLOCATE(grid%ol1ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol1ls. ')
 endif
  NULLIFY(grid%ol1ls)
ENDIF
IF ( ASSOCIATED( grid%ol3ss ) ) THEN 
  DEALLOCATE(grid%ol3ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol3ss. ')
 endif
  NULLIFY(grid%ol3ss)
ENDIF
IF ( ASSOCIATED( grid%b_q_bep ) ) THEN 
  DEALLOCATE(grid%b_q_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_q_bep. ')
 endif
  NULLIFY(grid%b_q_bep)
ENDIF
IF ( ASSOCIATED( grid%wv_tur ) ) THEN 
  DEALLOCATE(grid%wv_tur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wv_tur. ')
 endif
  NULLIFY(grid%wv_tur)
ENDIF
IF ( ASSOCIATED( grid%czmean ) ) THEN 
  DEALLOCATE(grid%czmean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%czmean. ')
 endif
  NULLIFY(grid%czmean)
ENDIF
IF ( ASSOCIATED( grid%aerod ) ) THEN 
  DEALLOCATE(grid%aerod,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerod. ')
 endif
  NULLIFY(grid%aerod)
ENDIF
IF ( ASSOCIATED( grid%f_rain_phy ) ) THEN 
  DEALLOCATE(grid%f_rain_phy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%f_rain_phy. ')
 endif
  NULLIFY(grid%f_rain_phy)
ENDIF
IF ( ASSOCIATED( grid%om_sini ) ) THEN 
  DEALLOCATE(grid%om_sini,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_sini. ')
 endif
  NULLIFY(grid%om_sini)
ENDIF
IF ( ASSOCIATED( grid%cldfratend_cup ) ) THEN 
  DEALLOCATE(grid%cldfratend_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfratend_cup. ')
 endif
  NULLIFY(grid%cldfratend_cup)
ENDIF
IF ( ASSOCIATED( grid%mfdn_ent_cup ) ) THEN 
  DEALLOCATE(grid%mfdn_ent_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mfdn_ent_cup. ')
 endif
  NULLIFY(grid%mfdn_ent_cup)
ENDIF
IF ( ASSOCIATED( grid%msfv ) ) THEN 
  DEALLOCATE(grid%msfv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfv. ')
 endif
  NULLIFY(grid%msfv)
ENDIF
IF ( ASSOCIATED( grid%ht ) ) THEN 
  DEALLOCATE(grid%ht,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht. ')
 endif
  NULLIFY(grid%ht)
ENDIF
IF ( ASSOCIATED( grid%dfi_tsk ) ) THEN 
  DEALLOCATE(grid%dfi_tsk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_tsk. ')
 endif
  NULLIFY(grid%dfi_tsk)
ENDIF
IF ( ASSOCIATED( grid%physf ) ) THEN 
  DEALLOCATE(grid%physf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physf. ')
 endif
  NULLIFY(grid%physf)
ENDIF
IF ( ASSOCIATED( grid%precr3d ) ) THEN 
  DEALLOCATE(grid%precr3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%precr3d. ')
 endif
  NULLIFY(grid%precr3d)
ENDIF
IF ( ASSOCIATED( grid%rvshten ) ) THEN 
  DEALLOCATE(grid%rvshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rvshten. ')
 endif
  NULLIFY(grid%rvshten)
ENDIF
IF ( ASSOCIATED( grid%cldareaa ) ) THEN 
  DEALLOCATE(grid%cldareaa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldareaa. ')
 endif
  NULLIFY(grid%cldareaa)
ENDIF
IF ( ASSOCIATED( grid%radsave ) ) THEN 
  DEALLOCATE(grid%radsave,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%radsave. ')
 endif
  NULLIFY(grid%radsave)
ENDIF
IF ( ASSOCIATED( grid%rqvcuten ) ) THEN 
  DEALLOCATE(grid%rqvcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvcuten. ')
 endif
  NULLIFY(grid%rqvcuten)
ENDIF
IF ( ASSOCIATED( grid%rainnc ) ) THEN 
  DEALLOCATE(grid%rainnc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainnc. ')
 endif
  NULLIFY(grid%rainnc)
ENDIF
IF ( ASSOCIATED( grid%snowncv ) ) THEN 
  DEALLOCATE(grid%snowncv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowncv. ')
 endif
  NULLIFY(grid%snowncv)
ENDIF
IF ( ASSOCIATED( grid%di3d_2 ) ) THEN 
  DEALLOCATE(grid%di3d_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%di3d_2. ')
 endif
  NULLIFY(grid%di3d_2)
ENDIF
IF ( ASSOCIATED( grid%mass_flux ) ) THEN 
  DEALLOCATE(grid%mass_flux,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mass_flux. ')
 endif
  NULLIFY(grid%mass_flux)
ENDIF
IF ( ASSOCIATED( grid%apr_as ) ) THEN 
  DEALLOCATE(grid%apr_as,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_as. ')
 endif
  NULLIFY(grid%apr_as)
ENDIF
IF ( ASSOCIATED( grid%xf_ens ) ) THEN 
  DEALLOCATE(grid%xf_ens,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xf_ens. ')
 endif
  NULLIFY(grid%xf_ens)
ENDIF
IF ( ASSOCIATED( grid%gd_cloud_a ) ) THEN 
  DEALLOCATE(grid%gd_cloud_a,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gd_cloud_a. ')
 endif
  NULLIFY(grid%gd_cloud_a)
ENDIF
IF ( ASSOCIATED( grid%efcs ) ) THEN 
  DEALLOCATE(grid%efcs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efcs. ')
 endif
  NULLIFY(grid%efcs)
ENDIF
IF ( ASSOCIATED( grid%ccn6_gs ) ) THEN 
  DEALLOCATE(grid%ccn6_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn6_gs. ')
 endif
  NULLIFY(grid%ccn6_gs)
ENDIF
IF ( ASSOCIATED( grid%rthratenswc ) ) THEN 
  DEALLOCATE(grid%rthratenswc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthratenswc. ')
 endif
  NULLIFY(grid%rthratenswc)
ENDIF
IF ( ASSOCIATED( grid%glw ) ) THEN 
  DEALLOCATE(grid%glw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%glw. ')
 endif
  NULLIFY(grid%glw)
ENDIF
IF ( ASSOCIATED( grid%gx ) ) THEN 
  DEALLOCATE(grid%gx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gx. ')
 endif
  NULLIFY(grid%gx)
ENDIF
IF ( ASSOCIATED( grid%taod5503d ) ) THEN 
  DEALLOCATE(grid%taod5503d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taod5503d. ')
 endif
  NULLIFY(grid%taod5503d)
ENDIF
IF ( ASSOCIATED( grid%q2mean ) ) THEN 
  DEALLOCATE(grid%q2mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2mean. ')
 endif
  NULLIFY(grid%q2mean)
ENDIF
IF ( ASSOCIATED( grid%u10mean ) ) THEN 
  DEALLOCATE(grid%u10mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10mean. ')
 endif
  NULLIFY(grid%u10mean)
ENDIF
IF ( ASSOCIATED( grid%raincvstd ) ) THEN 
  DEALLOCATE(grid%raincvstd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%raincvstd. ')
 endif
  NULLIFY(grid%raincvstd)
ENDIF
IF ( ASSOCIATED( grid%aclwuptc ) ) THEN 
  DEALLOCATE(grid%aclwuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwuptc. ')
 endif
  NULLIFY(grid%aclwuptc)
ENDIF
IF ( ASSOCIATED( grid%i_acswupbc ) ) THEN 
  DEALLOCATE(grid%i_acswupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswupbc. ')
 endif
  NULLIFY(grid%i_acswupbc)
ENDIF
IF ( ASSOCIATED( grid%swuptc ) ) THEN 
  DEALLOCATE(grid%swuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swuptc. ')
 endif
  NULLIFY(grid%swuptc)
ENDIF
IF ( ASSOCIATED( grid%lwuptc ) ) THEN 
  DEALLOCATE(grid%lwuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwuptc. ')
 endif
  NULLIFY(grid%lwuptc)
ENDIF
IF ( ASSOCIATED( grid%lwcf ) ) THEN 
  DEALLOCATE(grid%lwcf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwcf. ')
 endif
  NULLIFY(grid%lwcf)
ENDIF
IF ( ASSOCIATED( grid%noahres ) ) THEN 
  DEALLOCATE(grid%noahres,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%noahres. ')
 endif
  NULLIFY(grid%noahres)
ENDIF
IF ( ASSOCIATED( grid%fbur ) ) THEN 
  DEALLOCATE(grid%fbur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fbur. ')
 endif
  NULLIFY(grid%fbur)
ENDIF
IF ( ASSOCIATED( grid%albbck_mosaic ) ) THEN 
  DEALLOCATE(grid%albbck_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albbck_mosaic. ')
 endif
  NULLIFY(grid%albbck_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tr_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%tr_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tr_urb2d_mosaic. ')
 endif
  NULLIFY(grid%tr_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%lh_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%lh_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lh_urb2d_mosaic. ')
 endif
  NULLIFY(grid%lh_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%lu_state ) ) THEN 
  DEALLOCATE(grid%lu_state,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lu_state. ')
 endif
  NULLIFY(grid%lu_state)
ENDIF
IF ( ASSOCIATED( grid%tyr ) ) THEN 
  DEALLOCATE(grid%tyr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tyr. ')
 endif
  NULLIFY(grid%tyr)
ENDIF
IF ( ASSOCIATED( grid%cda ) ) THEN 
  DEALLOCATE(grid%cda,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cda. ')
 endif
  NULLIFY(grid%cda)
ENDIF
IF ( ASSOCIATED( grid%achfx ) ) THEN 
  DEALLOCATE(grid%achfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%achfx. ')
 endif
  NULLIFY(grid%achfx)
ENDIF
IF ( ASSOCIATED( grid%tsnav ) ) THEN 
  DEALLOCATE(grid%tsnav,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsnav. ')
 endif
  NULLIFY(grid%tsnav)
ENDIF
IF ( ASSOCIATED( grid%taucldi ) ) THEN 
  DEALLOCATE(grid%taucldi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taucldi. ')
 endif
  NULLIFY(grid%taucldi)
ENDIF
IF ( ASSOCIATED( grid%div ) ) THEN 
  DEALLOCATE(grid%div,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%div. ')
 endif
  NULLIFY(grid%div)
ENDIF
IF ( ASSOCIATED( grid%fdda3d ) ) THEN 
  DEALLOCATE(grid%fdda3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fdda3d. ')
 endif
  NULLIFY(grid%fdda3d)
ENDIF
IF ( ASSOCIATED( grid%rh_ndg_old ) ) THEN 
  DEALLOCATE(grid%rh_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_ndg_old. ')
 endif
  NULLIFY(grid%rh_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%sda_hfx ) ) THEN 
  DEALLOCATE(grid%sda_hfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sda_hfx. ')
 endif
  NULLIFY(grid%sda_hfx)
ENDIF
IF ( ASSOCIATED( grid%pk1m ) ) THEN 
  DEALLOCATE(grid%pk1m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pk1m. ')
 endif
  NULLIFY(grid%pk1m)
ENDIF
IF ( ASSOCIATED( grid%grpl_colint ) ) THEN 
  DEALLOCATE(grid%grpl_colint,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grpl_colint. ')
 endif
  NULLIFY(grid%grpl_colint)
ENDIF
IF ( ASSOCIATED( grid%h0ml ) ) THEN 
  DEALLOCATE(grid%h0ml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h0ml. ')
 endif
  NULLIFY(grid%h0ml)
ENDIF
IF ( ASSOCIATED( grid%track_ele ) ) THEN 
  DEALLOCATE(grid%track_ele,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_ele. ')
 endif
  NULLIFY(grid%track_ele)
ENDIF
IF ( ASSOCIATED( grid%athmpten ) ) THEN 
  DEALLOCATE(grid%athmpten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athmpten. ')
 endif
  NULLIFY(grid%athmpten)
ENDIF
IF ( ASSOCIATED( grid%aublten ) ) THEN 
  DEALLOCATE(grid%aublten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aublten. ')
 endif
  NULLIFY(grid%aublten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_dhail3 ) ) THEN 
  DEALLOCATE(grid%hailcast_dhail3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_dhail3. ')
 endif
  NULLIFY(grid%hailcast_dhail3)
ENDIF
IF ( ASSOCIATED( grid%ic_flashrate ) ) THEN 
  DEALLOCATE(grid%ic_flashrate,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ic_flashrate. ')
 endif
  NULLIFY(grid%ic_flashrate)
ENDIF
IF ( ASSOCIATED( grid%dum_yyy ) ) THEN 
  DEALLOCATE(grid%dum_yyy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dum_yyy. ')
 endif
  NULLIFY(grid%dum_yyy)
ENDIF
IF ( ASSOCIATED( grid%dzdyf ) ) THEN 
  DEALLOCATE(grid%dzdyf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzdyf. ')
 endif
  NULLIFY(grid%dzdyf)
ENDIF
IF ( ASSOCIATED( grid%grnqfx_fu ) ) THEN 
  DEALLOCATE(grid%grnqfx_fu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grnqfx_fu. ')
 endif
  NULLIFY(grid%grnqfx_fu)
ENDIF
IF ( ASSOCIATED( grid%vf ) ) THEN 
  DEALLOCATE(grid%vf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vf. ')
 endif
  NULLIFY(grid%vf)
ENDIF
IF ( ASSOCIATED( grid%fmep ) ) THEN 
  DEALLOCATE(grid%fmep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmep. ')
 endif
  NULLIFY(grid%fmep)
ENDIF
IF ( ASSOCIATED( grid%r_0 ) ) THEN 
  DEALLOCATE(grid%r_0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%r_0. ')
 endif
  NULLIFY(grid%r_0)
ENDIF
IF ( ASSOCIATED( grid%fs_gen_inst ) ) THEN 
  DEALLOCATE(grid%fs_gen_inst,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_gen_inst. ')
 endif
  NULLIFY(grid%fs_gen_inst)
ENDIF
IF ( ASSOCIATED( grid%fs_p_temp ) ) THEN 
  DEALLOCATE(grid%fs_p_temp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_temp. ')
 endif
  NULLIFY(grid%fs_p_temp)
ENDIF
IF ( ASSOCIATED( grid%cfu1 ) ) THEN 
  DEALLOCATE(grid%cfu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cfu1. ')
 endif
  NULLIFY(grid%cfu1)
ENDIF
IF ( ASSOCIATED( grid%field_conv ) ) THEN 
  DEALLOCATE(grid%field_conv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_conv. ')
 endif
  NULLIFY(grid%field_conv)
ENDIF
IF ( ASSOCIATED( grid%spstreamforcs ) ) THEN 
  DEALLOCATE(grid%spstreamforcs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spstreamforcs. ')
 endif
  NULLIFY(grid%spstreamforcs)
ENDIF
IF ( ASSOCIATED( grid%spforcs3 ) ) THEN 
  DEALLOCATE(grid%spforcs3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs3. ')
 endif
  NULLIFY(grid%spforcs3)
ENDIF
IF ( ASSOCIATED( grid%vertampuv ) ) THEN 
  DEALLOCATE(grid%vertampuv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertampuv. ')
 endif
  NULLIFY(grid%vertampuv)
ENDIF
IF ( ASSOCIATED( grid%iseed_mult3d ) ) THEN 
  DEALLOCATE(grid%iseed_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseed_mult3d. ')
 endif
  NULLIFY(grid%iseed_mult3d)
ENDIF
IF ( ASSOCIATED( grid%tauresy2d ) ) THEN 
  DEALLOCATE(grid%tauresy2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tauresy2d. ')
 endif
  NULLIFY(grid%tauresy2d)
ENDIF
IF ( ASSOCIATED( grid%zmdice ) ) THEN 
  DEALLOCATE(grid%zmdice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmdice. ')
 endif
  NULLIFY(grid%zmdice)
ENDIF
IF ( ASSOCIATED( grid%preccdzm ) ) THEN 
  DEALLOCATE(grid%preccdzm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%preccdzm. ')
 endif
  NULLIFY(grid%preccdzm)
ENDIF
IF ( ASSOCIATED( grid%zmicuu ) ) THEN 
  DEALLOCATE(grid%zmicuu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmicuu. ')
 endif
  NULLIFY(grid%zmicuu)
ENDIF
IF ( ASSOCIATED( grid%mu3d ) ) THEN 
  DEALLOCATE(grid%mu3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu3d. ')
 endif
  NULLIFY(grid%mu3d)
ENDIF
IF ( ASSOCIATED( grid%evapcsh ) ) THEN 
  DEALLOCATE(grid%evapcsh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evapcsh. ')
 endif
  NULLIFY(grid%evapcsh)
ENDIF
IF ( ASSOCIATED( grid%slten_cu ) ) THEN 
  DEALLOCATE(grid%slten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slten_cu. ')
 endif
  NULLIFY(grid%slten_cu)
ENDIF
IF ( ASSOCIATED( grid%pinv_cu ) ) THEN 
  DEALLOCATE(grid%pinv_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pinv_cu. ')
 endif
  NULLIFY(grid%pinv_cu)
ENDIF
IF ( ASSOCIATED( grid%zinv_cu ) ) THEN 
  DEALLOCATE(grid%zinv_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zinv_cu. ')
 endif
  NULLIFY(grid%zinv_cu)
ENDIF
IF ( ASSOCIATED( grid%qtu_emf_cu ) ) THEN 
  DEALLOCATE(grid%qtu_emf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtu_emf_cu. ')
 endif
  NULLIFY(grid%qtu_emf_cu)
ENDIF
IF ( ASSOCIATED( grid%dwten_cu ) ) THEN 
  DEALLOCATE(grid%dwten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dwten_cu. ')
 endif
  NULLIFY(grid%dwten_cu)
ENDIF
IF ( ASSOCIATED( grid%bquad_cu ) ) THEN 
  DEALLOCATE(grid%bquad_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bquad_cu. ')
 endif
  NULLIFY(grid%bquad_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_cufliter_cu ) ) THEN 
  DEALLOCATE(grid%exit_cufliter_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_cufliter_cu. ')
 endif
  NULLIFY(grid%exit_cufliter_cu)
ENDIF
IF ( ASSOCIATED( grid%ind_delcin_cu ) ) THEN 
  DEALLOCATE(grid%ind_delcin_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ind_delcin_cu. ')
 endif
  NULLIFY(grid%ind_delcin_cu)
ENDIF
IF ( ASSOCIATED( grid%numc ) ) THEN 
  DEALLOCATE(grid%numc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%numc. ')
 endif
  NULLIFY(grid%numc)
ENDIF
IF ( ASSOCIATED( grid%h2osno ) ) THEN 
  DEALLOCATE(grid%h2osno,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osno. ')
 endif
  NULLIFY(grid%h2osno)
ENDIF
IF ( ASSOCIATED( grid%laip ) ) THEN 
  DEALLOCATE(grid%laip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%laip. ')
 endif
  NULLIFY(grid%laip)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq_s5 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq_s5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq_s5. ')
 endif
  NULLIFY(grid%h2osoi_liq_s5)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice_s2 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice_s2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice_s2. ')
 endif
  NULLIFY(grid%h2osoi_ice_s2)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice9 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice9,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice9. ')
 endif
  NULLIFY(grid%h2osoi_ice9)
ENDIF
IF ( ASSOCIATED( grid%t_soisno6 ) ) THEN 
  DEALLOCATE(grid%t_soisno6,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno6. ')
 endif
  NULLIFY(grid%t_soisno6)
ENDIF
IF ( ASSOCIATED( grid%snowrds3 ) ) THEN 
  DEALLOCATE(grid%snowrds3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowrds3. ')
 endif
  NULLIFY(grid%snowrds3)
ENDIF
IF ( ASSOCIATED( grid%t_lake10 ) ) THEN 
  DEALLOCATE(grid%t_lake10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake10. ')
 endif
  NULLIFY(grid%t_lake10)
ENDIF
IF ( ASSOCIATED( grid%lhsubgrid ) ) THEN 
  DEALLOCATE(grid%lhsubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lhsubgrid. ')
 endif
  NULLIFY(grid%lhsubgrid)
ENDIF
IF ( ASSOCIATED( grid%h2osno2d ) ) THEN 
  DEALLOCATE(grid%h2osno2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osno2d. ')
 endif
  NULLIFY(grid%h2osno2d)
ENDIF
IF ( ASSOCIATED( grid%dz3d ) ) THEN 
  DEALLOCATE(grid%dz3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dz3d. ')
 endif
  NULLIFY(grid%dz3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_fm ) ) THEN 
  DEALLOCATE(grid%ssib_fm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_fm. ')
 endif
  NULLIFY(grid%ssib_fm)
ENDIF
IF ( ASSOCIATED( grid%ssib_egt ) ) THEN 
  DEALLOCATE(grid%ssib_egt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_egt. ')
 endif
  NULLIFY(grid%ssib_egt)
ENDIF
IF ( ASSOCIATED( grid%isnow ) ) THEN 
  DEALLOCATE(grid%isnow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%isnow. ')
 endif
  NULLIFY(grid%isnow)
ENDIF
IF ( ASSOCIATED( grid%fio1 ) ) THEN 
  DEALLOCATE(grid%fio1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fio1. ')
 endif
  NULLIFY(grid%fio1)
ENDIF
IF ( ASSOCIATED( grid%fio2 ) ) THEN 
  DEALLOCATE(grid%fio2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fio2. ')
 endif
  NULLIFY(grid%fio2)
ENDIF
IF ( ASSOCIATED( grid%fio3 ) ) THEN 
  DEALLOCATE(grid%fio3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fio3. ')
 endif
  NULLIFY(grid%fio3)
ENDIF
IF ( ASSOCIATED( grid%fio4 ) ) THEN 
  DEALLOCATE(grid%fio4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fio4. ')
 endif
  NULLIFY(grid%fio4)
ENDIF
IF ( ASSOCIATED( grid%cmxy ) ) THEN 
  DEALLOCATE(grid%cmxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmxy. ')
 endif
  NULLIFY(grid%cmxy)
ENDIF
IF ( ASSOCIATED( grid%zsnsoxy ) ) THEN 
  DEALLOCATE(grid%zsnsoxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zsnsoxy. ')
 endif
  NULLIFY(grid%zsnsoxy)
ENDIF
IF ( ASSOCIATED( grid%t2mbxy ) ) THEN 
  DEALLOCATE(grid%t2mbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2mbxy. ')
 endif
  NULLIFY(grid%t2mbxy)
ENDIF
IF ( ASSOCIATED( grid%edirxy ) ) THEN 
  DEALLOCATE(grid%edirxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edirxy. ')
 endif
  NULLIFY(grid%edirxy)
ENDIF
IF ( ASSOCIATED( grid%tgvxy ) ) THEN 
  DEALLOCATE(grid%tgvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgvxy. ')
 endif
  NULLIFY(grid%tgvxy)
ENDIF
IF ( ASSOCIATED( grid%ircxy ) ) THEN 
  DEALLOCATE(grid%ircxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ircxy. ')
 endif
  NULLIFY(grid%ircxy)
ENDIF
IF ( ASSOCIATED( grid%deeprechxy ) ) THEN 
  DEALLOCATE(grid%deeprechxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%deeprechxy. ')
 endif
  NULLIFY(grid%deeprechxy)
ENDIF
IF ( ASSOCIATED( grid%rivercondxy ) ) THEN 
  DEALLOCATE(grid%rivercondxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rivercondxy. ')
 endif
  NULLIFY(grid%rivercondxy)
ENDIF
IF ( ASSOCIATED( grid%qsnfroxy ) ) THEN 
  DEALLOCATE(grid%qsnfroxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsnfroxy. ')
 endif
  NULLIFY(grid%qsnfroxy)
ENDIF
IF ( ASSOCIATED( grid%pahvxy ) ) THEN 
  DEALLOCATE(grid%pahvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pahvxy. ')
 endif
  NULLIFY(grid%pahvxy)
ENDIF
IF ( ASSOCIATED( grid%acintr ) ) THEN 
  DEALLOCATE(grid%acintr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acintr. ')
 endif
  NULLIFY(grid%acintr)
ENDIF
IF ( ASSOCIATED( grid%acrunsf ) ) THEN 
  DEALLOCATE(grid%acrunsf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acrunsf. ')
 endif
  NULLIFY(grid%acrunsf)
ENDIF
IF ( ASSOCIATED( grid%acsnbot ) ) THEN 
  DEALLOCATE(grid%acsnbot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnbot. ')
 endif
  NULLIFY(grid%acsnbot)
ENDIF
IF ( ASSOCIATED( grid%acghb ) ) THEN 
  DEALLOCATE(grid%acghb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acghb. ')
 endif
  NULLIFY(grid%acghb)
ENDIF
IF ( ASSOCIATED( grid%actr ) ) THEN 
  DEALLOCATE(grid%actr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%actr. ')
 endif
  NULLIFY(grid%actr)
ENDIF
IF ( ASSOCIATED( grid%snowenergy ) ) THEN 
  DEALLOCATE(grid%snowenergy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowenergy. ')
 endif
  NULLIFY(grid%snowenergy)
ENDIF
IF ( ASSOCIATED( grid%grainxy ) ) THEN 
  DEALLOCATE(grid%grainxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grainxy. ')
 endif
  NULLIFY(grid%grainxy)
ENDIF
IF ( ASSOCIATED( grid%sifract ) ) THEN 
  DEALLOCATE(grid%sifract,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sifract. ')
 endif
  NULLIFY(grid%sifract)
ENDIF
IF ( ASSOCIATED( grid%ireloss ) ) THEN 
  DEALLOCATE(grid%ireloss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ireloss. ')
 endif
  NULLIFY(grid%ireloss)
ENDIF
IF ( ASSOCIATED( grid%kext_ft_qid ) ) THEN 
  DEALLOCATE(grid%kext_ft_qid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ft_qid. ')
 endif
  NULLIFY(grid%kext_ft_qid)
ENDIF
IF ( ASSOCIATED( grid%refd ) ) THEN 
  DEALLOCATE(grid%refd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%refd. ')
 endif
  NULLIFY(grid%refd)
ENDIF
IF ( ASSOCIATED( grid%icing_sm ) ) THEN 
  DEALLOCATE(grid%icing_sm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icing_sm. ')
 endif
  NULLIFY(grid%icing_sm)
ENDIF
IF ( ASSOCIATED( grid%afwa_precip ) ) THEN 
  DEALLOCATE(grid%afwa_precip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_precip. ')
 endif
  NULLIFY(grid%afwa_precip)
ENDIF
IF ( ASSOCIATED( grid%afwa_cape ) ) THEN 
  DEALLOCATE(grid%afwa_cape,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cape. ')
 endif
  NULLIFY(grid%afwa_cape)
ENDIF
IF ( ASSOCIATED( grid%afwa_tornado ) ) THEN 
  DEALLOCATE(grid%afwa_tornado,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_tornado. ')
 endif
  NULLIFY(grid%afwa_tornado)
ENDIF
IF ( ASSOCIATED( grid%glw_mean ) ) THEN 
  DEALLOCATE(grid%glw_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%glw_mean. ')
 endif
  NULLIFY(grid%glw_mean)
ENDIF
IF ( ASSOCIATED( grid%th2_diurn ) ) THEN 
  DEALLOCATE(grid%th2_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th2_diurn. ')
 endif
  NULLIFY(grid%th2_diurn)
ENDIF
IF ( ASSOCIATED( grid%lwupt_diurn ) ) THEN 
  DEALLOCATE(grid%lwupt_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupt_diurn. ')
 endif
  NULLIFY(grid%lwupt_diurn)
ENDIF
IF ( ASSOCIATED( grid%lh_dtmp ) ) THEN 
  DEALLOCATE(grid%lh_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lh_dtmp. ')
 endif
  NULLIFY(grid%lh_dtmp)
ENDIF
IF ( ASSOCIATED( grid%noninduc ) ) THEN 
  DEALLOCATE(grid%noninduc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%noninduc. ')
 endif
  NULLIFY(grid%noninduc)
ENDIF
IF ( ASSOCIATED( grid%flshp ) ) THEN 
  DEALLOCATE(grid%flshp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flshp. ')
 endif
  NULLIFY(grid%flshp)
ENDIF
IF ( ASSOCIATED( grid%field_t_tend_perturb ) ) THEN 
  DEALLOCATE(grid%field_t_tend_perturb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_t_tend_perturb. ')
 endif
  NULLIFY(grid%field_t_tend_perturb)
ENDIF
IF ( ASSOCIATED( grid%pc_1 ) ) THEN 
  DEALLOCATE(grid%pc_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_1. ')
 endif
  NULLIFY(grid%pc_1)
ENDIF
IF ( ASSOCIATED( grid%pc_2 ) ) THEN 
  DEALLOCATE(grid%pc_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_2. ')
 endif
  NULLIFY(grid%pc_2)
ENDIF
IF ( ASSOCIATED( grid%p_wif_jan ) ) THEN 
  DEALLOCATE(grid%p_wif_jan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_jan. ')
 endif
  NULLIFY(grid%p_wif_jan)
ENDIF
IF ( ASSOCIATED( grid%w_wif_now ) ) THEN 
  DEALLOCATE(grid%w_wif_now,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_now. ')
 endif
  NULLIFY(grid%w_wif_now)
ENDIF
IF ( ASSOCIATED( grid%w_wif_dec ) ) THEN 
  DEALLOCATE(grid%w_wif_dec,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_dec. ')
 endif
  NULLIFY(grid%w_wif_dec)
ENDIF
IF ( ASSOCIATED( grid%i_wif_nov ) ) THEN 
  DEALLOCATE(grid%i_wif_nov,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_nov. ')
 endif
  NULLIFY(grid%i_wif_nov)
ENDIF
IF ( ASSOCIATED( grid%b_wif_oct ) ) THEN 
  DEALLOCATE(grid%b_wif_oct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_oct. ')
 endif
  NULLIFY(grid%b_wif_oct)
ENDIF
IF ( ASSOCIATED( grid%rain ) ) THEN 
  DEALLOCATE(grid%rain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rain. ')
 endif
  NULLIFY(grid%rain)
ENDIF
IF ( ASSOCIATED( grid%swp ) ) THEN 
  DEALLOCATE(grid%swp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swp. ')
 endif
  NULLIFY(grid%swp)
ENDIF
IF ( ASSOCIATED( grid%tau_qs ) ) THEN 
  DEALLOCATE(grid%tau_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_qs. ')
 endif
  NULLIFY(grid%tau_qs)
ENDIF
IF ( ASSOCIATED( grid%ts_lwp ) ) THEN 
  DEALLOCATE(grid%ts_lwp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_lwp. ')
 endif
  NULLIFY(grid%ts_lwp)
ENDIF
IF ( ASSOCIATED( grid%ts_tau_qc ) ) THEN 
  DEALLOCATE(grid%ts_tau_qc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tau_qc. ')
 endif
  NULLIFY(grid%ts_tau_qc)
ENDIF
IF ( ASSOCIATED( grid%ts_swdown ) ) THEN 
  DEALLOCATE(grid%ts_swdown,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swdown. ')
 endif
  NULLIFY(grid%ts_swdown)
ENDIF
IF ( ASSOCIATED( grid%s_pl ) ) THEN 
  DEALLOCATE(grid%s_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%s_pl. ')
 endif
  NULLIFY(grid%s_pl)
ENDIF
IF ( ASSOCIATED( grid%t_zl ) ) THEN 
  DEALLOCATE(grid%t_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_zl. ')
 endif
  NULLIFY(grid%t_zl)
ENDIF
IF ( ASSOCIATED( grid%mcm_le ) ) THEN 
  DEALLOCATE(grid%mcm_le,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_le. ')
 endif
  NULLIFY(grid%mcm_le)
ENDIF
IF ( ASSOCIATED( grid%mcm_tau13_t ) ) THEN 
  DEALLOCATE(grid%mcm_tau13_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_tau13_t. ')
 endif
  NULLIFY(grid%mcm_tau13_t)
ENDIF
IF ( ASSOCIATED( grid%sst_input ) ) THEN 
  DEALLOCATE(grid%sst_input,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sst_input. ')
 endif
  NULLIFY(grid%sst_input)
ENDIF
END SUBROUTINE deallocs_4
!ENDOFREGISTRYGENERATEDINCLUDE
