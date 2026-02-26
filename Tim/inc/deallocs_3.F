!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_3.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_3( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%lu_mask ) ) THEN 
  DEALLOCATE(grid%lu_mask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lu_mask. ')
 endif
  NULLIFY(grid%lu_mask)
ENDIF
IF ( ASSOCIATED( grid%t_gc ) ) THEN 
  DEALLOCATE(grid%t_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_gc. ')
 endif
  NULLIFY(grid%t_gc)
ENDIF
IF ( ASSOCIATED( grid%tmn_gc ) ) THEN 
  DEALLOCATE(grid%tmn_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tmn_gc. ')
 endif
  NULLIFY(grid%tmn_gc)
ENDIF
IF ( ASSOCIATED( grid%qv_gc ) ) THEN 
  DEALLOCATE(grid%qv_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_gc. ')
 endif
  NULLIFY(grid%qv_gc)
ENDIF
IF ( ASSOCIATED( grid%qni_gc ) ) THEN 
  DEALLOCATE(grid%qni_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qni_gc. ')
 endif
  NULLIFY(grid%qni_gc)
ENDIF
IF ( ASSOCIATED( grid%ght_min_p ) ) THEN 
  DEALLOCATE(grid%ght_min_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ght_min_p. ')
 endif
  NULLIFY(grid%ght_min_p)
ENDIF
IF ( ASSOCIATED( grid%vmaxw ) ) THEN 
  DEALLOCATE(grid%vmaxw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vmaxw. ')
 endif
  NULLIFY(grid%vmaxw)
ENDIF
IF ( ASSOCIATED( grid%u_save ) ) THEN 
  DEALLOCATE(grid%u_save,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_save. ')
 endif
  NULLIFY(grid%u_save)
ENDIF
IF ( ASSOCIATED( grid%v_save ) ) THEN 
  DEALLOCATE(grid%v_save,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_save. ')
 endif
  NULLIFY(grid%v_save)
ENDIF
IF ( ASSOCIATED( grid%php ) ) THEN 
  DEALLOCATE(grid%php,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%php. ')
 endif
  NULLIFY(grid%php)
ENDIF
IF ( ASSOCIATED( grid%t_save ) ) THEN 
  DEALLOCATE(grid%t_save,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_save. ')
 endif
  NULLIFY(grid%t_save)
ENDIF
IF ( ASSOCIATED( grid%ql_upstream_y_tend ) ) THEN 
  DEALLOCATE(grid%ql_upstream_y_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_upstream_y_tend. ')
 endif
  NULLIFY(grid%ql_upstream_y_tend)
ENDIF
IF ( ASSOCIATED( grid%th_largescale_tend ) ) THEN 
  DEALLOCATE(grid%th_largescale_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_largescale_tend. ')
 endif
  NULLIFY(grid%th_largescale_tend)
ENDIF
IF ( ASSOCIATED( grid%tau_x_tend ) ) THEN 
  DEALLOCATE(grid%tau_x_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_x_tend. ')
 endif
  NULLIFY(grid%tau_x_tend)
ENDIF
IF ( ASSOCIATED( grid%muus ) ) THEN 
  DEALLOCATE(grid%muus,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%muus. ')
 endif
  NULLIFY(grid%muus)
ENDIF
IF ( ASSOCIATED( grid%tke_1 ) ) THEN 
  DEALLOCATE(grid%tke_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tke_1. ')
 endif
  NULLIFY(grid%tke_1)
ENDIF
IF ( ASSOCIATED( grid%tke_2 ) ) THEN 
  DEALLOCATE(grid%tke_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tke_2. ')
 endif
  NULLIFY(grid%tke_2)
ENDIF
IF ( ASSOCIATED( grid%alb ) ) THEN 
  DEALLOCATE(grid%alb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alb. ')
 endif
  NULLIFY(grid%alb)
ENDIF
IF ( ASSOCIATED( grid%z ) ) THEN 
  DEALLOCATE(grid%z,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z. ')
 endif
  NULLIFY(grid%z)
ENDIF
IF ( ASSOCIATED( grid%vratx ) ) THEN 
  DEALLOCATE(grid%vratx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vratx. ')
 endif
  NULLIFY(grid%vratx)
ENDIF
IF ( ASSOCIATED( grid%moist_bxs ) ) THEN 
  DEALLOCATE(grid%moist_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_bxs. ')
 endif
  NULLIFY(grid%moist_bxs)
ENDIF
IF ( ASSOCIATED( grid%moist_bxe ) ) THEN 
  DEALLOCATE(grid%moist_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_bxe. ')
 endif
  NULLIFY(grid%moist_bxe)
ENDIF
IF ( ASSOCIATED( grid%moist_bys ) ) THEN 
  DEALLOCATE(grid%moist_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_bys. ')
 endif
  NULLIFY(grid%moist_bys)
ENDIF
IF ( ASSOCIATED( grid%moist_bye ) ) THEN 
  DEALLOCATE(grid%moist_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist_bye. ')
 endif
  NULLIFY(grid%moist_bye)
ENDIF
IF ( ASSOCIATED( grid%re_cloud ) ) THEN 
  DEALLOCATE(grid%re_cloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_cloud. ')
 endif
  NULLIFY(grid%re_cloud)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_cloud_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_cloud_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_cloud_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_cloud_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_scalar ) ) THEN 
  DEALLOCATE(grid%dfi_scalar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_scalar. ')
 endif
  NULLIFY(grid%dfi_scalar)
ENDIF
IF ( ASSOCIATED( grid%soilm ) ) THEN 
  DEALLOCATE(grid%soilm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm. ')
 endif
  NULLIFY(grid%soilm)
ENDIF
IF ( ASSOCIATED( grid%sm100200 ) ) THEN 
  DEALLOCATE(grid%sm100200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm100200. ')
 endif
  NULLIFY(grid%sm100200)
ENDIF
IF ( ASSOCIATED( grid%sw010200 ) ) THEN 
  DEALLOCATE(grid%sw010200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw010200. ')
 endif
  NULLIFY(grid%sw010200)
ENDIF
IF ( ASSOCIATED( grid%soilt000 ) ) THEN 
  DEALLOCATE(grid%soilt000,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt000. ')
 endif
  NULLIFY(grid%soilt000)
ENDIF
IF ( ASSOCIATED( grid%shdmin ) ) THEN 
  DEALLOCATE(grid%shdmin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shdmin. ')
 endif
  NULLIFY(grid%shdmin)
ENDIF
IF ( ASSOCIATED( grid%ts_hour ) ) THEN 
  DEALLOCATE(grid%ts_hour,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_hour. ')
 endif
  NULLIFY(grid%ts_hour)
ENDIF
IF ( ASSOCIATED( grid%ts_clw ) ) THEN 
  DEALLOCATE(grid%ts_clw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_clw. ')
 endif
  NULLIFY(grid%ts_clw)
ENDIF
IF ( ASSOCIATED( grid%dzg ) ) THEN 
  DEALLOCATE(grid%dzg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzg. ')
 endif
  NULLIFY(grid%dzg)
ENDIF
IF ( ASSOCIATED( grid%xice ) ) THEN 
  DEALLOCATE(grid%xice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xice. ')
 endif
  NULLIFY(grid%xice)
ENDIF
IF ( ASSOCIATED( grid%sfcrunoff ) ) THEN 
  DEALLOCATE(grid%sfcrunoff,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfcrunoff. ')
 endif
  NULLIFY(grid%sfcrunoff)
ENDIF
IF ( ASSOCIATED( grid%snow ) ) THEN 
  DEALLOCATE(grid%snow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snow. ')
 endif
  NULLIFY(grid%snow)
ENDIF
IF ( ASSOCIATED( grid%dtw ) ) THEN 
  DEALLOCATE(grid%dtw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtw. ')
 endif
  NULLIFY(grid%dtw)
ENDIF
IF ( ASSOCIATED( grid%dfi_v ) ) THEN 
  DEALLOCATE(grid%dfi_v,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_v. ')
 endif
  NULLIFY(grid%dfi_v)
ENDIF
IF ( ASSOCIATED( grid%dfi_snow ) ) THEN 
  DEALLOCATE(grid%dfi_snow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_snow. ')
 endif
  NULLIFY(grid%dfi_snow)
ENDIF
IF ( ASSOCIATED( grid%uc_urb2d ) ) THEN 
  DEALLOCATE(grid%uc_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uc_urb2d. ')
 endif
  NULLIFY(grid%uc_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tgrl_urb3d ) ) THEN 
  DEALLOCATE(grid%tgrl_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgrl_urb3d. ')
 endif
  NULLIFY(grid%tgrl_urb3d)
ENDIF
IF ( ASSOCIATED( grid%trb_urb4d ) ) THEN 
  DEALLOCATE(grid%trb_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trb_urb4d. ')
 endif
  NULLIFY(grid%trb_urb4d)
ENDIF
IF ( ASSOCIATED( grid%cm_ac_urb3d ) ) THEN 
  DEALLOCATE(grid%cm_ac_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cm_ac_urb3d. ')
 endif
  NULLIFY(grid%cm_ac_urb3d)
ENDIF
IF ( ASSOCIATED( grid%qr_urb4d ) ) THEN 
  DEALLOCATE(grid%qr_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qr_urb4d. ')
 endif
  NULLIFY(grid%qr_urb4d)
ENDIF
IF ( ASSOCIATED( grid%chr_sfcdif ) ) THEN 
  DEALLOCATE(grid%chr_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chr_sfcdif. ')
 endif
  NULLIFY(grid%chr_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%alswnirdir ) ) THEN 
  DEALLOCATE(grid%alswnirdir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alswnirdir. ')
 endif
  NULLIFY(grid%alswnirdir)
ENDIF
IF ( ASSOCIATED( grid%wfc_px ) ) THEN 
  DEALLOCATE(grid%wfc_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wfc_px. ')
 endif
  NULLIFY(grid%wfc_px)
ENDIF
IF ( ASSOCIATED( grid%zol ) ) THEN 
  DEALLOCATE(grid%zol,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zol. ')
 endif
  NULLIFY(grid%zol)
ENDIF
IF ( ASSOCIATED( grid%vz0 ) ) THEN 
  DEALLOCATE(grid%vz0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vz0. ')
 endif
  NULLIFY(grid%vz0)
ENDIF
IF ( ASSOCIATED( grid%q10 ) ) THEN 
  DEALLOCATE(grid%q10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q10. ')
 endif
  NULLIFY(grid%q10)
ENDIF
IF ( ASSOCIATED( grid%frac_up ) ) THEN 
  DEALLOCATE(grid%frac_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%frac_up. ')
 endif
  NULLIFY(grid%frac_up)
ENDIF
IF ( ASSOCIATED( grid%qtup_temf ) ) THEN 
  DEALLOCATE(grid%qtup_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtup_temf. ')
 endif
  NULLIFY(grid%qtup_temf)
ENDIF
IF ( ASSOCIATED( grid%qwt ) ) THEN 
  DEALLOCATE(grid%qwt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qwt. ')
 endif
  NULLIFY(grid%qwt)
ENDIF
IF ( ASSOCIATED( grid%edmf_ent ) ) THEN 
  DEALLOCATE(grid%edmf_ent,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_ent. ')
 endif
  NULLIFY(grid%edmf_ent)
ENDIF
IF ( ASSOCIATED( grid%exch_tke ) ) THEN 
  DEALLOCATE(grid%exch_tke,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exch_tke. ')
 endif
  NULLIFY(grid%exch_tke)
ENDIF
IF ( ASSOCIATED( grid%ol2 ) ) THEN 
  DEALLOCATE(grid%ol2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol2. ')
 endif
  NULLIFY(grid%ol2)
ENDIF
IF ( ASSOCIATED( grid%dvsfcg_ls ) ) THEN 
  DEALLOCATE(grid%dvsfcg_ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dvsfcg_ls. ')
 endif
  NULLIFY(grid%dvsfcg_ls)
ENDIF
IF ( ASSOCIATED( grid%oa4ls ) ) THEN 
  DEALLOCATE(grid%oa4ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa4ls. ')
 endif
  NULLIFY(grid%oa4ls)
ENDIF
IF ( ASSOCIATED( grid%ol2ss ) ) THEN 
  DEALLOCATE(grid%ol2ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol2ss. ')
 endif
  NULLIFY(grid%ol2ss)
ENDIF
IF ( ASSOCIATED( grid%b_t_bep ) ) THEN 
  DEALLOCATE(grid%b_t_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_t_bep. ')
 endif
  NULLIFY(grid%b_t_bep)
ENDIF
IF ( ASSOCIATED( grid%wu_tur ) ) THEN 
  DEALLOCATE(grid%wu_tur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wu_tur. ')
 endif
  NULLIFY(grid%wu_tur)
ENDIF
IF ( ASSOCIATED( grid%rlwtoa ) ) THEN 
  DEALLOCATE(grid%rlwtoa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rlwtoa. ')
 endif
  NULLIFY(grid%rlwtoa)
ENDIF
IF ( ASSOCIATED( grid%pina ) ) THEN 
  DEALLOCATE(grid%pina,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pina. ')
 endif
  NULLIFY(grid%pina)
ENDIF
IF ( ASSOCIATED( grid%f_ice_phy ) ) THEN 
  DEALLOCATE(grid%f_ice_phy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%f_ice_phy. ')
 endif
  NULLIFY(grid%f_ice_phy)
ENDIF
IF ( ASSOCIATED( grid%om_tini ) ) THEN 
  DEALLOCATE(grid%om_tini,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_tini. ')
 endif
  NULLIFY(grid%om_tini)
ENDIF
IF ( ASSOCIATED( grid%activefrac ) ) THEN 
  DEALLOCATE(grid%activefrac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%activefrac. ')
 endif
  NULLIFY(grid%activefrac)
ENDIF
IF ( ASSOCIATED( grid%mfdn_cup ) ) THEN 
  DEALLOCATE(grid%mfdn_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mfdn_cup. ')
 endif
  NULLIFY(grid%mfdn_cup)
ENDIF
IF ( ASSOCIATED( grid%msfu ) ) THEN 
  DEALLOCATE(grid%msfu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfu. ')
 endif
  NULLIFY(grid%msfu)
ENDIF
IF ( ASSOCIATED( grid%cosa ) ) THEN 
  DEALLOCATE(grid%cosa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cosa. ')
 endif
  NULLIFY(grid%cosa)
ENDIF
IF ( ASSOCIATED( grid%tsk ) ) THEN 
  DEALLOCATE(grid%tsk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk. ')
 endif
  NULLIFY(grid%tsk)
ENDIF
IF ( ASSOCIATED( grid%physm ) ) THEN 
  DEALLOCATE(grid%physm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physm. ')
 endif
  NULLIFY(grid%physm)
ENDIF
IF ( ASSOCIATED( grid%prech3d ) ) THEN 
  DEALLOCATE(grid%prech3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prech3d. ')
 endif
  NULLIFY(grid%prech3d)
ENDIF
IF ( ASSOCIATED( grid%rushten ) ) THEN 
  DEALLOCATE(grid%rushten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rushten. ')
 endif
  NULLIFY(grid%rushten)
ENDIF
IF ( ASSOCIATED( grid%rqcdcshten ) ) THEN 
  DEALLOCATE(grid%rqcdcshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqcdcshten. ')
 endif
  NULLIFY(grid%rqcdcshten)
ENDIF
IF ( ASSOCIATED( grid%capesave ) ) THEN 
  DEALLOCATE(grid%capesave,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%capesave. ')
 endif
  NULLIFY(grid%capesave)
ENDIF
IF ( ASSOCIATED( grid%rthcuten ) ) THEN 
  DEALLOCATE(grid%rthcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthcuten. ')
 endif
  NULLIFY(grid%rthcuten)
ENDIF
IF ( ASSOCIATED( grid%rainsh ) ) THEN 
  DEALLOCATE(grid%rainsh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainsh. ')
 endif
  NULLIFY(grid%rainsh)
ENDIF
IF ( ASSOCIATED( grid%hailnc ) ) THEN 
  DEALLOCATE(grid%hailnc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailnc. ')
 endif
  NULLIFY(grid%hailnc)
ENDIF
IF ( ASSOCIATED( grid%vmi3d_2 ) ) THEN 
  DEALLOCATE(grid%vmi3d_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vmi3d_2. ')
 endif
  NULLIFY(grid%vmi3d_2)
ENDIF
IF ( ASSOCIATED( grid%lowlyr ) ) THEN 
  DEALLOCATE(grid%lowlyr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lowlyr. ')
 endif
  NULLIFY(grid%lowlyr)
ENDIF
IF ( ASSOCIATED( grid%apr_st ) ) THEN 
  DEALLOCATE(grid%apr_st,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_st. ')
 endif
  NULLIFY(grid%apr_st)
ENDIF
IF ( ASSOCIATED( grid%ktop_deep ) ) THEN 
  DEALLOCATE(grid%ktop_deep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ktop_deep. ')
 endif
  NULLIFY(grid%ktop_deep)
ENDIF
IF ( ASSOCIATED( grid%raincv_b ) ) THEN 
  DEALLOCATE(grid%raincv_b,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%raincv_b. ')
 endif
  NULLIFY(grid%raincv_b)
ENDIF
IF ( ASSOCIATED( grid%cu_uaf ) ) THEN 
  DEALLOCATE(grid%cu_uaf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cu_uaf. ')
 endif
  NULLIFY(grid%cu_uaf)
ENDIF
IF ( ASSOCIATED( grid%ccn5_gs ) ) THEN 
  DEALLOCATE(grid%ccn5_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn5_gs. ')
 endif
  NULLIFY(grid%ccn5_gs)
ENDIF
IF ( ASSOCIATED( grid%rthratensw ) ) THEN 
  DEALLOCATE(grid%rthratensw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthratensw. ')
 endif
  NULLIFY(grid%rthratensw)
ENDIF
IF ( ASSOCIATED( grid%gsw ) ) THEN 
  DEALLOCATE(grid%gsw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gsw. ')
 endif
  NULLIFY(grid%gsw)
ENDIF
IF ( ASSOCIATED( grid%swddif2 ) ) THEN 
  DEALLOCATE(grid%swddif2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddif2. ')
 endif
  NULLIFY(grid%swddif2)
ENDIF
IF ( ASSOCIATED( grid%aod5503d ) ) THEN 
  DEALLOCATE(grid%aod5503d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aod5503d. ')
 endif
  NULLIFY(grid%aod5503d)
ENDIF
IF ( ASSOCIATED( grid%tq2max ) ) THEN 
  DEALLOCATE(grid%tq2max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tq2max. ')
 endif
  NULLIFY(grid%tq2max)
ENDIF
IF ( ASSOCIATED( grid%tspduv10max ) ) THEN 
  DEALLOCATE(grid%tspduv10max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tspduv10max. ')
 endif
  NULLIFY(grid%tspduv10max)
ENDIF
IF ( ASSOCIATED( grid%rainncvmean ) ) THEN 
  DEALLOCATE(grid%rainncvmean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainncvmean. ')
 endif
  NULLIFY(grid%rainncvmean)
ENDIF
IF ( ASSOCIATED( grid%aclwupt ) ) THEN 
  DEALLOCATE(grid%aclwupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwupt. ')
 endif
  NULLIFY(grid%aclwupt)
ENDIF
IF ( ASSOCIATED( grid%i_acswupb ) ) THEN 
  DEALLOCATE(grid%i_acswupb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswupb. ')
 endif
  NULLIFY(grid%i_acswupb)
ENDIF
IF ( ASSOCIATED( grid%swupt ) ) THEN 
  DEALLOCATE(grid%swupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupt. ')
 endif
  NULLIFY(grid%swupt)
ENDIF
IF ( ASSOCIATED( grid%lwupt ) ) THEN 
  DEALLOCATE(grid%lwupt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupt. ')
 endif
  NULLIFY(grid%lwupt)
ENDIF
IF ( ASSOCIATED( grid%swcf ) ) THEN 
  DEALLOCATE(grid%swcf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swcf. ')
 endif
  NULLIFY(grid%swcf)
ENDIF
IF ( ASSOCIATED( grid%snotime ) ) THEN 
  DEALLOCATE(grid%snotime,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snotime. ')
 endif
  NULLIFY(grid%snotime)
ENDIF
IF ( ASSOCIATED( grid%fvb ) ) THEN 
  DEALLOCATE(grid%fvb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fvb. ')
 endif
  NULLIFY(grid%fvb)
ENDIF
IF ( ASSOCIATED( grid%albedo_mosaic ) ) THEN 
  DEALLOCATE(grid%albedo_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albedo_mosaic. ')
 endif
  NULLIFY(grid%albedo_mosaic)
ENDIF
IF ( ASSOCIATED( grid%snotime_mosaic ) ) THEN 
  DEALLOCATE(grid%snotime_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snotime_mosaic. ')
 endif
  NULLIFY(grid%snotime_mosaic)
ENDIF
IF ( ASSOCIATED( grid%sh_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%sh_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh_urb2d_mosaic. ')
 endif
  NULLIFY(grid%sh_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tmn ) ) THEN 
  DEALLOCATE(grid%tmn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tmn. ')
 endif
  NULLIFY(grid%tmn)
ENDIF
IF ( ASSOCIATED( grid%cd ) ) THEN 
  DEALLOCATE(grid%cd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cd. ')
 endif
  NULLIFY(grid%cd)
ENDIF
IF ( ASSOCIATED( grid%lh ) ) THEN 
  DEALLOCATE(grid%lh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lh. ')
 endif
  NULLIFY(grid%lh)
ENDIF
IF ( ASSOCIATED( grid%dfi_soilt1 ) ) THEN 
  DEALLOCATE(grid%dfi_soilt1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_soilt1. ')
 endif
  NULLIFY(grid%dfi_soilt1)
ENDIF
IF ( ASSOCIATED( grid%xkhh ) ) THEN 
  DEALLOCATE(grid%xkhh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xkhh. ')
 endif
  NULLIFY(grid%xkhh)
ENDIF
IF ( ASSOCIATED( grid%rmundgdten ) ) THEN 
  DEALLOCATE(grid%rmundgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rmundgdten. ')
 endif
  NULLIFY(grid%rmundgdten)
ENDIF
IF ( ASSOCIATED( grid%q2_ndg_new ) ) THEN 
  DEALLOCATE(grid%q2_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2_ndg_new. ')
 endif
  NULLIFY(grid%q2_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%sn_ndg_old ) ) THEN 
  DEALLOCATE(grid%sn_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sn_ndg_old. ')
 endif
  NULLIFY(grid%sn_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%dmudt ) ) THEN 
  DEALLOCATE(grid%dmudt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dmudt. ')
 endif
  NULLIFY(grid%dmudt)
ENDIF
IF ( ASSOCIATED( grid%numcolpts ) ) THEN 
  DEALLOCATE(grid%numcolpts,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%numcolpts. ')
 endif
  NULLIFY(grid%numcolpts)
ENDIF
IF ( ASSOCIATED( grid%hml ) ) THEN 
  DEALLOCATE(grid%hml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hml. ')
 endif
  NULLIFY(grid%hml)
ENDIF
IF ( ASSOCIATED( grid%track_alt ) ) THEN 
  DEALLOCATE(grid%track_alt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_alt. ')
 endif
  NULLIFY(grid%track_alt)
ENDIF
IF ( ASSOCIATED( grid%cldbasez ) ) THEN 
  DEALLOCATE(grid%cldbasez,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldbasez. ')
 endif
  NULLIFY(grid%cldbasez)
ENDIF
IF ( ASSOCIATED( grid%aqvblten ) ) THEN 
  DEALLOCATE(grid%aqvblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aqvblten. ')
 endif
  NULLIFY(grid%aqvblten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_dhail2 ) ) THEN 
  DEALLOCATE(grid%hailcast_dhail2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_dhail2. ')
 endif
  NULLIFY(grid%hailcast_dhail2)
ENDIF
IF ( ASSOCIATED( grid%ic_flashcount ) ) THEN 
  DEALLOCATE(grid%ic_flashcount,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ic_flashcount. ')
 endif
  NULLIFY(grid%ic_flashcount)
ENDIF
IF ( ASSOCIATED( grid%ph_xxx ) ) THEN 
  DEALLOCATE(grid%ph_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph_xxx. ')
 endif
  NULLIFY(grid%ph_xxx)
ENDIF
IF ( ASSOCIATED( grid%dzdxf ) ) THEN 
  DEALLOCATE(grid%dzdxf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzdxf. ')
 endif
  NULLIFY(grid%dzdxf)
ENDIF
IF ( ASSOCIATED( grid%grnhfx_fu ) ) THEN 
  DEALLOCATE(grid%grnhfx_fu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grnhfx_fu. ')
 endif
  NULLIFY(grid%grnhfx_fu)
ENDIF
IF ( ASSOCIATED( grid%uf ) ) THEN 
  DEALLOCATE(grid%uf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uf. ')
 endif
  NULLIFY(grid%uf)
ENDIF
IF ( ASSOCIATED( grid%fmc_gc ) ) THEN 
  DEALLOCATE(grid%fmc_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmc_gc. ')
 endif
  NULLIFY(grid%fmc_gc)
ENDIF
IF ( ASSOCIATED( grid%phiwc ) ) THEN 
  DEALLOCATE(grid%phiwc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phiwc. ')
 endif
  NULLIFY(grid%phiwc)
ENDIF
IF ( ASSOCIATED( grid%fs_landing_mask ) ) THEN 
  DEALLOCATE(grid%fs_landing_mask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_landing_mask. ')
 endif
  NULLIFY(grid%fs_landing_mask)
ENDIF
IF ( ASSOCIATED( grid%fs_p_effd ) ) THEN 
  DEALLOCATE(grid%fs_p_effd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_effd. ')
 endif
  NULLIFY(grid%fs_p_effd)
ENDIF
IF ( ASSOCIATED( grid%avgflx_efd1 ) ) THEN 
  DEALLOCATE(grid%avgflx_efd1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_efd1. ')
 endif
  NULLIFY(grid%avgflx_efd1)
ENDIF
IF ( ASSOCIATED( grid%field_pbl ) ) THEN 
  DEALLOCATE(grid%field_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_pbl. ')
 endif
  NULLIFY(grid%field_pbl)
ENDIF
IF ( ASSOCIATED( grid%spstreamforcc ) ) THEN 
  DEALLOCATE(grid%spstreamforcc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spstreamforcc. ')
 endif
  NULLIFY(grid%spstreamforcc)
ENDIF
IF ( ASSOCIATED( grid%spforcc3 ) ) THEN 
  DEALLOCATE(grid%spforcc3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcc3. ')
 endif
  NULLIFY(grid%spforcc3)
ENDIF
IF ( ASSOCIATED( grid%vertampt ) ) THEN 
  DEALLOCATE(grid%vertampt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vertampt. ')
 endif
  NULLIFY(grid%vertampt)
ENDIF
IF ( ASSOCIATED( grid%mult3d_vertstruc ) ) THEN 
  DEALLOCATE(grid%mult3d_vertstruc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mult3d_vertstruc. ')
 endif
  NULLIFY(grid%mult3d_vertstruc)
ENDIF
IF ( ASSOCIATED( grid%tauresx2d ) ) THEN 
  DEALLOCATE(grid%tauresx2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tauresx2d. ')
 endif
  NULLIFY(grid%tauresx2d)
ENDIF
IF ( ASSOCIATED( grid%zmdq ) ) THEN 
  DEALLOCATE(grid%zmdq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmdq. ')
 endif
  NULLIFY(grid%zmdq)
ENDIF
IF ( ASSOCIATED( grid%cmfmcdzm ) ) THEN 
  DEALLOCATE(grid%cmfmcdzm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmfmcdzm. ')
 endif
  NULLIFY(grid%cmfmcdzm)
ENDIF
IF ( ASSOCIATED( grid%zmvpgd ) ) THEN 
  DEALLOCATE(grid%zmvpgd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmvpgd. ')
 endif
  NULLIFY(grid%zmvpgd)
ENDIF
IF ( ASSOCIATED( grid%md3d ) ) THEN 
  DEALLOCATE(grid%md3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%md3d. ')
 endif
  NULLIFY(grid%md3d)
ENDIF
IF ( ASSOCIATED( grid%cush ) ) THEN 
  DEALLOCATE(grid%cush,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cush. ')
 endif
  NULLIFY(grid%cush)
ENDIF
IF ( ASSOCIATED( grid%qtten_cu ) ) THEN 
  DEALLOCATE(grid%qtten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtten_cu. ')
 endif
  NULLIFY(grid%qtten_cu)
ENDIF
IF ( ASSOCIATED( grid%plcl_cu ) ) THEN 
  DEALLOCATE(grid%plcl_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%plcl_cu. ')
 endif
  NULLIFY(grid%plcl_cu)
ENDIF
IF ( ASSOCIATED( grid%tkeavg_cu ) ) THEN 
  DEALLOCATE(grid%tkeavg_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tkeavg_cu. ')
 endif
  NULLIFY(grid%tkeavg_cu)
ENDIF
IF ( ASSOCIATED( grid%vu_cu ) ) THEN 
  DEALLOCATE(grid%vu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vu_cu. ')
 endif
  NULLIFY(grid%vu_cu)
ENDIF
IF ( ASSOCIATED( grid%fdr_cu ) ) THEN 
  DEALLOCATE(grid%fdr_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fdr_cu. ')
 endif
  NULLIFY(grid%fdr_cu)
ENDIF
IF ( ASSOCIATED( grid%aquad_cu ) ) THEN 
  DEALLOCATE(grid%aquad_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aquad_cu. ')
 endif
  NULLIFY(grid%aquad_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_wu_cu ) ) THEN 
  DEALLOCATE(grid%exit_wu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_wu_cu. ')
 endif
  NULLIFY(grid%exit_wu_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_rei_cu ) ) THEN 
  DEALLOCATE(grid%limit_rei_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_rei_cu. ')
 endif
  NULLIFY(grid%limit_rei_cu)
ENDIF
IF ( ASSOCIATED( grid%wtp ) ) THEN 
  DEALLOCATE(grid%wtp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wtp. ')
 endif
  NULLIFY(grid%wtp)
ENDIF
IF ( ASSOCIATED( grid%fsi240 ) ) THEN 
  DEALLOCATE(grid%fsi240,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsi240. ')
 endif
  NULLIFY(grid%fsi240)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq_s4 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq_s4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq_s4. ')
 endif
  NULLIFY(grid%h2osoi_liq_s4)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice_s1 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice_s1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice_s1. ')
 endif
  NULLIFY(grid%h2osoi_ice_s1)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice8 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice8,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice8. ')
 endif
  NULLIFY(grid%h2osoi_ice8)
ENDIF
IF ( ASSOCIATED( grid%t_soisno5 ) ) THEN 
  DEALLOCATE(grid%t_soisno5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno5. ')
 endif
  NULLIFY(grid%t_soisno5)
ENDIF
IF ( ASSOCIATED( grid%snowrds2 ) ) THEN 
  DEALLOCATE(grid%snowrds2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowrds2. ')
 endif
  NULLIFY(grid%snowrds2)
ENDIF
IF ( ASSOCIATED( grid%t_lake9 ) ) THEN 
  DEALLOCATE(grid%t_lake9,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake9. ')
 endif
  NULLIFY(grid%t_lake9)
ENDIF
IF ( ASSOCIATED( grid%albedosubgrid ) ) THEN 
  DEALLOCATE(grid%albedosubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albedosubgrid. ')
 endif
  NULLIFY(grid%albedosubgrid)
ENDIF
IF ( ASSOCIATED( grid%snowdp2d ) ) THEN 
  DEALLOCATE(grid%snowdp2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowdp2d. ')
 endif
  NULLIFY(grid%snowdp2d)
ENDIF
IF ( ASSOCIATED( grid%z3d ) ) THEN 
  DEALLOCATE(grid%z3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z3d. ')
 endif
  NULLIFY(grid%z3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_egi ) ) THEN 
  DEALLOCATE(grid%ssib_egi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_egi. ')
 endif
  NULLIFY(grid%ssib_egi)
ENDIF
IF ( ASSOCIATED( grid%ssib_veg ) ) THEN 
  DEALLOCATE(grid%ssib_veg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_veg. ')
 endif
  NULLIFY(grid%ssib_veg)
ENDIF
IF ( ASSOCIATED( grid%cto1 ) ) THEN 
  DEALLOCATE(grid%cto1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cto1. ')
 endif
  NULLIFY(grid%cto1)
ENDIF
IF ( ASSOCIATED( grid%cto2 ) ) THEN 
  DEALLOCATE(grid%cto2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cto2. ')
 endif
  NULLIFY(grid%cto2)
ENDIF
IF ( ASSOCIATED( grid%cto3 ) ) THEN 
  DEALLOCATE(grid%cto3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cto3. ')
 endif
  NULLIFY(grid%cto3)
ENDIF
IF ( ASSOCIATED( grid%cto4 ) ) THEN 
  DEALLOCATE(grid%cto4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cto4. ')
 endif
  NULLIFY(grid%cto4)
ENDIF
IF ( ASSOCIATED( grid%tahxy ) ) THEN 
  DEALLOCATE(grid%tahxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tahxy. ')
 endif
  NULLIFY(grid%tahxy)
ENDIF
IF ( ASSOCIATED( grid%tsnoxy ) ) THEN 
  DEALLOCATE(grid%tsnoxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsnoxy. ')
 endif
  NULLIFY(grid%tsnoxy)
ENDIF
IF ( ASSOCIATED( grid%t2mvxy ) ) THEN 
  DEALLOCATE(grid%t2mvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2mvxy. ')
 endif
  NULLIFY(grid%t2mvxy)
ENDIF
IF ( ASSOCIATED( grid%ecanxy ) ) THEN 
  DEALLOCATE(grid%ecanxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ecanxy. ')
 endif
  NULLIFY(grid%ecanxy)
ENDIF
IF ( ASSOCIATED( grid%wgapxy ) ) THEN 
  DEALLOCATE(grid%wgapxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wgapxy. ')
 endif
  NULLIFY(grid%wgapxy)
ENDIF
IF ( ASSOCIATED( grid%irgxy ) ) THEN 
  DEALLOCATE(grid%irgxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irgxy. ')
 endif
  NULLIFY(grid%irgxy)
ENDIF
IF ( ASSOCIATED( grid%rechxy ) ) THEN 
  DEALLOCATE(grid%rechxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rechxy. ')
 endif
  NULLIFY(grid%rechxy)
ENDIF
IF ( ASSOCIATED( grid%pexpxy ) ) THEN 
  DEALLOCATE(grid%pexpxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pexpxy. ')
 endif
  NULLIFY(grid%pexpxy)
ENDIF
IF ( ASSOCIATED( grid%qsnsubxy ) ) THEN 
  DEALLOCATE(grid%qsnsubxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsnsubxy. ')
 endif
  NULLIFY(grid%qsnsubxy)
ENDIF
IF ( ASSOCIATED( grid%pahgxy ) ) THEN 
  DEALLOCATE(grid%pahgxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pahgxy. ')
 endif
  NULLIFY(grid%pahgxy)
ENDIF
IF ( ASSOCIATED( grid%acints ) ) THEN 
  DEALLOCATE(grid%acints,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acints. ')
 endif
  NULLIFY(grid%acints)
ENDIF
IF ( ASSOCIATED( grid%acrunsb ) ) THEN 
  DEALLOCATE(grid%acrunsb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acrunsb. ')
 endif
  NULLIFY(grid%acrunsb)
ENDIF
IF ( ASSOCIATED( grid%acmeltc ) ) THEN 
  DEALLOCATE(grid%acmeltc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acmeltc. ')
 endif
  NULLIFY(grid%acmeltc)
ENDIF
IF ( ASSOCIATED( grid%acevb ) ) THEN 
  DEALLOCATE(grid%acevb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acevb. ')
 endif
  NULLIFY(grid%acevb)
ENDIF
IF ( ASSOCIATED( grid%acevc ) ) THEN 
  DEALLOCATE(grid%acevc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acevc. ')
 endif
  NULLIFY(grid%acevc)
ENDIF
IF ( ASSOCIATED( grid%soilenergy ) ) THEN 
  DEALLOCATE(grid%soilenergy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilenergy. ')
 endif
  NULLIFY(grid%soilenergy)
ENDIF
IF ( ASSOCIATED( grid%acc_edirxy ) ) THEN 
  DEALLOCATE(grid%acc_edirxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_edirxy. ')
 endif
  NULLIFY(grid%acc_edirxy)
ENDIF
IF ( ASSOCIATED( grid%irfract ) ) THEN 
  DEALLOCATE(grid%irfract,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irfract. ')
 endif
  NULLIFY(grid%irfract)
ENDIF
IF ( ASSOCIATED( grid%irfivol ) ) THEN 
  DEALLOCATE(grid%irfivol,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irfivol. ')
 endif
  NULLIFY(grid%irfivol)
ENDIF
IF ( ASSOCIATED( grid%kext_ft_qip ) ) THEN 
  DEALLOCATE(grid%kext_ft_qip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ft_qip. ')
 endif
  NULLIFY(grid%kext_ft_qip)
ENDIF
IF ( ASSOCIATED( grid%refd_com ) ) THEN 
  DEALLOCATE(grid%refd_com,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%refd_com. ')
 endif
  NULLIFY(grid%refd_com)
ENDIF
IF ( ASSOCIATED( grid%icing_lg ) ) THEN 
  DEALLOCATE(grid%icing_lg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icing_lg. ')
 endif
  NULLIFY(grid%icing_lg)
ENDIF
IF ( ASSOCIATED( grid%afwa_llturbsvr ) ) THEN 
  DEALLOCATE(grid%afwa_llturbsvr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_llturbsvr. ')
 endif
  NULLIFY(grid%afwa_llturbsvr)
ENDIF
IF ( ASSOCIATED( grid%afwa_cloud_ceil ) ) THEN 
  DEALLOCATE(grid%afwa_cloud_ceil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cloud_ceil. ')
 endif
  NULLIFY(grid%afwa_cloud_ceil)
ENDIF
IF ( ASSOCIATED( grid%afwa_llws ) ) THEN 
  DEALLOCATE(grid%afwa_llws,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_llws. ')
 endif
  NULLIFY(grid%afwa_llws)
ENDIF
IF ( ASSOCIATED( grid%swdnb_mean ) ) THEN 
  DEALLOCATE(grid%swdnb_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnb_mean. ')
 endif
  NULLIFY(grid%swdnb_mean)
ENDIF
IF ( ASSOCIATED( grid%t2_diurn ) ) THEN 
  DEALLOCATE(grid%t2_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_diurn. ')
 endif
  NULLIFY(grid%t2_diurn)
ENDIF
IF ( ASSOCIATED( grid%swdnt_diurn ) ) THEN 
  DEALLOCATE(grid%swdnt_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnt_diurn. ')
 endif
  NULLIFY(grid%swdnt_diurn)
ENDIF
IF ( ASSOCIATED( grid%hfx_dtmp ) ) THEN 
  DEALLOCATE(grid%hfx_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx_dtmp. ')
 endif
  NULLIFY(grid%hfx_dtmp)
ENDIF
IF ( ASSOCIATED( grid%induc ) ) THEN 
  DEALLOCATE(grid%induc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%induc. ')
 endif
  NULLIFY(grid%induc)
ENDIF
IF ( ASSOCIATED( grid%flshn ) ) THEN 
  DEALLOCATE(grid%flshn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flshn. ')
 endif
  NULLIFY(grid%flshn)
ENDIF
IF ( ASSOCIATED( grid%field_v_tend_perturb ) ) THEN 
  DEALLOCATE(grid%field_v_tend_perturb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_v_tend_perturb. ')
 endif
  NULLIFY(grid%field_v_tend_perturb)
ENDIF
IF ( ASSOCIATED( grid%pcb ) ) THEN 
  DEALLOCATE(grid%pcb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pcb. ')
 endif
  NULLIFY(grid%pcb)
ENDIF
IF ( ASSOCIATED( grid%p_wif_now ) ) THEN 
  DEALLOCATE(grid%p_wif_now,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_now. ')
 endif
  NULLIFY(grid%p_wif_now)
ENDIF
IF ( ASSOCIATED( grid%p_wif_dec ) ) THEN 
  DEALLOCATE(grid%p_wif_dec,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_dec. ')
 endif
  NULLIFY(grid%p_wif_dec)
ENDIF
IF ( ASSOCIATED( grid%w_wif_nov ) ) THEN 
  DEALLOCATE(grid%w_wif_nov,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_nov. ')
 endif
  NULLIFY(grid%w_wif_nov)
ENDIF
IF ( ASSOCIATED( grid%i_wif_oct ) ) THEN 
  DEALLOCATE(grid%i_wif_oct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_oct. ')
 endif
  NULLIFY(grid%i_wif_oct)
ENDIF
IF ( ASSOCIATED( grid%b_wif_sep ) ) THEN 
  DEALLOCATE(grid%b_wif_sep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_sep. ')
 endif
  NULLIFY(grid%b_wif_sep)
ENDIF
IF ( ASSOCIATED( grid%dir ) ) THEN 
  DEALLOCATE(grid%dir,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dir. ')
 endif
  NULLIFY(grid%dir)
ENDIF
IF ( ASSOCIATED( grid%iwp ) ) THEN 
  DEALLOCATE(grid%iwp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iwp. ')
 endif
  NULLIFY(grid%iwp)
ENDIF
IF ( ASSOCIATED( grid%tau_qi ) ) THEN 
  DEALLOCATE(grid%tau_qi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_qi. ')
 endif
  NULLIFY(grid%tau_qi)
ENDIF
IF ( ASSOCIATED( grid%ts_wvp ) ) THEN 
  DEALLOCATE(grid%ts_wvp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_wvp. ')
 endif
  NULLIFY(grid%ts_wvp)
ENDIF
IF ( ASSOCIATED( grid%ts_re_qi_tot ) ) THEN 
  DEALLOCATE(grid%ts_re_qi_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_re_qi_tot. ')
 endif
  NULLIFY(grid%ts_re_qi_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_ghi_accum ) ) THEN 
  DEALLOCATE(grid%ts_ghi_accum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_ghi_accum. ')
 endif
  NULLIFY(grid%ts_ghi_accum)
ENDIF
IF ( ASSOCIATED( grid%ght_pl ) ) THEN 
  DEALLOCATE(grid%ght_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ght_pl. ')
 endif
  NULLIFY(grid%ght_pl)
ENDIF
IF ( ASSOCIATED( grid%v_zl ) ) THEN 
  DEALLOCATE(grid%v_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_zl. ')
 endif
  NULLIFY(grid%v_zl)
ENDIF
IF ( ASSOCIATED( grid%mcm_sh ) ) THEN 
  DEALLOCATE(grid%mcm_sh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_sh. ')
 endif
  NULLIFY(grid%mcm_sh)
ENDIF
IF ( ASSOCIATED( grid%mcm_lw_out ) ) THEN 
  DEALLOCATE(grid%mcm_lw_out,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_lw_out. ')
 endif
  NULLIFY(grid%mcm_lw_out)
ENDIF
IF ( ASSOCIATED( grid%sst ) ) THEN 
  DEALLOCATE(grid%sst,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sst. ')
 endif
  NULLIFY(grid%sst)
ENDIF
END SUBROUTINE deallocs_3
!ENDOFREGISTRYGENERATEDINCLUDE
