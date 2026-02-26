!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_2.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_2( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%lu_index ) ) THEN 
  DEALLOCATE(grid%lu_index,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lu_index. ')
 endif
  NULLIFY(grid%lu_index)
ENDIF
IF ( ASSOCIATED( grid%v_gc ) ) THEN 
  DEALLOCATE(grid%v_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_gc. ')
 endif
  NULLIFY(grid%v_gc)
ENDIF
IF ( ASSOCIATED( grid%tavgsfc ) ) THEN 
  DEALLOCATE(grid%tavgsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tavgsfc. ')
 endif
  NULLIFY(grid%tavgsfc)
ENDIF
IF ( ASSOCIATED( grid%pdhs ) ) THEN 
  DEALLOCATE(grid%pdhs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pdhs. ')
 endif
  NULLIFY(grid%pdhs)
ENDIF
IF ( ASSOCIATED( grid%qh_gc ) ) THEN 
  DEALLOCATE(grid%qh_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qh_gc. ')
 endif
  NULLIFY(grid%qh_gc)
ENDIF
IF ( ASSOCIATED( grid%t_min_p ) ) THEN 
  DEALLOCATE(grid%t_min_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_min_p. ')
 endif
  NULLIFY(grid%t_min_p)
ENDIF
IF ( ASSOCIATED( grid%utrop ) ) THEN 
  DEALLOCATE(grid%utrop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%utrop. ')
 endif
  NULLIFY(grid%utrop)
ENDIF
IF ( ASSOCIATED( grid%ww_m ) ) THEN 
  DEALLOCATE(grid%ww_m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ww_m. ')
 endif
  NULLIFY(grid%ww_m)
ENDIF
IF ( ASSOCIATED( grid%ph0 ) ) THEN 
  DEALLOCATE(grid%ph0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ph0. ')
 endif
  NULLIFY(grid%ph0)
ENDIF
IF ( ASSOCIATED( grid%ql_upstream_y ) ) THEN 
  DEALLOCATE(grid%ql_upstream_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_upstream_y. ')
 endif
  NULLIFY(grid%ql_upstream_y)
ENDIF
IF ( ASSOCIATED( grid%th_largescale ) ) THEN 
  DEALLOCATE(grid%th_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_largescale. ')
 endif
  NULLIFY(grid%th_largescale)
ENDIF
IF ( ASSOCIATED( grid%tau_x ) ) THEN 
  DEALLOCATE(grid%tau_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_x. ')
 endif
  NULLIFY(grid%tau_x)
ENDIF
IF ( ASSOCIATED( grid%muu ) ) THEN 
  DEALLOCATE(grid%muu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%muu. ')
 endif
  NULLIFY(grid%muu)
ENDIF
IF ( ASSOCIATED( grid%ht_coarse ) ) THEN 
  DEALLOCATE(grid%ht_coarse,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_coarse. ')
 endif
  NULLIFY(grid%ht_coarse)
ENDIF
IF ( ASSOCIATED( grid%alt ) ) THEN 
  DEALLOCATE(grid%alt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alt. ')
 endif
  NULLIFY(grid%alt)
ENDIF
IF ( ASSOCIATED( grid%rho ) ) THEN 
  DEALLOCATE(grid%rho,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rho. ')
 endif
  NULLIFY(grid%rho)
ENDIF
IF ( ASSOCIATED( grid%t_base ) ) THEN 
  DEALLOCATE(grid%t_base,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_base. ')
 endif
  NULLIFY(grid%t_base)
ENDIF
IF ( ASSOCIATED( grid%uratx ) ) THEN 
  DEALLOCATE(grid%uratx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uratx. ')
 endif
  NULLIFY(grid%uratx)
ENDIF
IF ( ASSOCIATED( grid%moist ) ) THEN 
  DEALLOCATE(grid%moist,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%moist. ')
 endif
  NULLIFY(grid%moist)
ENDIF
IF ( ASSOCIATED( grid%qnbcbb2d ) ) THEN 
  DEALLOCATE(grid%qnbcbb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnbcbb2d. ')
 endif
  NULLIFY(grid%qnbcbb2d)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_snow ) ) THEN 
  DEALLOCATE(grid%dfi_re_snow,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_snow. ')
 endif
  NULLIFY(grid%dfi_re_snow)
ENDIF
IF ( ASSOCIATED( grid%scalar_btxs ) ) THEN 
  DEALLOCATE(grid%scalar_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_btxs. ')
 endif
  NULLIFY(grid%scalar_btxs)
ENDIF
IF ( ASSOCIATED( grid%scalar_btxe ) ) THEN 
  DEALLOCATE(grid%scalar_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_btxe. ')
 endif
  NULLIFY(grid%scalar_btxe)
ENDIF
IF ( ASSOCIATED( grid%scalar_btys ) ) THEN 
  DEALLOCATE(grid%scalar_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_btys. ')
 endif
  NULLIFY(grid%scalar_btys)
ENDIF
IF ( ASSOCIATED( grid%scalar_btye ) ) THEN 
  DEALLOCATE(grid%scalar_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scalar_btye. ')
 endif
  NULLIFY(grid%scalar_btye)
ENDIF
IF ( ASSOCIATED( grid%soilt ) ) THEN 
  DEALLOCATE(grid%soilt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt. ')
 endif
  NULLIFY(grid%soilt)
ENDIF
IF ( ASSOCIATED( grid%sm040100 ) ) THEN 
  DEALLOCATE(grid%sm040100,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm040100. ')
 endif
  NULLIFY(grid%sm040100)
ENDIF
IF ( ASSOCIATED( grid%sw100200 ) ) THEN 
  DEALLOCATE(grid%sw100200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sw100200. ')
 endif
  NULLIFY(grid%sw100200)
ENDIF
IF ( ASSOCIATED( grid%st010200 ) ) THEN 
  DEALLOCATE(grid%st010200,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st010200. ')
 endif
  NULLIFY(grid%st010200)
ENDIF
IF ( ASSOCIATED( grid%shdmax ) ) THEN 
  DEALLOCATE(grid%shdmax,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shdmax. ')
 endif
  NULLIFY(grid%shdmax)
ENDIF
IF ( ASSOCIATED( grid%tslb ) ) THEN 
  DEALLOCATE(grid%tslb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tslb. ')
 endif
  NULLIFY(grid%tslb)
ENDIF
IF ( ASSOCIATED( grid%ts_tslb ) ) THEN 
  DEALLOCATE(grid%ts_tslb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tslb. ')
 endif
  NULLIFY(grid%ts_tslb)
ENDIF
IF ( ASSOCIATED( grid%dzb ) ) THEN 
  DEALLOCATE(grid%dzb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dzb. ')
 endif
  NULLIFY(grid%dzb)
ENDIF
IF ( ASSOCIATED( grid%smcrel ) ) THEN 
  DEALLOCATE(grid%smcrel,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smcrel. ')
 endif
  NULLIFY(grid%smcrel)
ENDIF
IF ( ASSOCIATED( grid%zwatble2d ) ) THEN 
  DEALLOCATE(grid%zwatble2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zwatble2d. ')
 endif
  NULLIFY(grid%zwatble2d)
ENDIF
IF ( ASSOCIATED( grid%acsnom ) ) THEN 
  DEALLOCATE(grid%acsnom,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnom. ')
 endif
  NULLIFY(grid%acsnom)
ENDIF
IF ( ASSOCIATED( grid%water_depth ) ) THEN 
  DEALLOCATE(grid%water_depth,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%water_depth. ')
 endif
  NULLIFY(grid%water_depth)
ENDIF
IF ( ASSOCIATED( grid%dfi_u ) ) THEN 
  DEALLOCATE(grid%dfi_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_u. ')
 endif
  NULLIFY(grid%dfi_u)
ENDIF
IF ( ASSOCIATED( grid%dfi_smois ) ) THEN 
  DEALLOCATE(grid%dfi_smois,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_smois. ')
 endif
  NULLIFY(grid%dfi_smois)
ENDIF
IF ( ASSOCIATED( grid%qc_urb2d ) ) THEN 
  DEALLOCATE(grid%qc_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_urb2d. ')
 endif
  NULLIFY(grid%qc_urb2d)
ENDIF
IF ( ASSOCIATED( grid%flxhumg_urb2d ) ) THEN 
  DEALLOCATE(grid%flxhumg_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flxhumg_urb2d. ')
 endif
  NULLIFY(grid%flxhumg_urb2d)
ENDIF
IF ( ASSOCIATED( grid%utype_urb2d ) ) THEN 
  DEALLOCATE(grid%utype_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%utype_urb2d. ')
 endif
  NULLIFY(grid%utype_urb2d)
ENDIF
IF ( ASSOCIATED( grid%lf_ac_urb3d ) ) THEN 
  DEALLOCATE(grid%lf_ac_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lf_ac_urb3d. ')
 endif
  NULLIFY(grid%lf_ac_urb3d)
ENDIF
IF ( ASSOCIATED( grid%trv_urb4d ) ) THEN 
  DEALLOCATE(grid%trv_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trv_urb4d. ')
 endif
  NULLIFY(grid%trv_urb4d)
ENDIF
IF ( ASSOCIATED( grid%cmr_sfcdif ) ) THEN 
  DEALLOCATE(grid%cmr_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmr_sfcdif. ')
 endif
  NULLIFY(grid%cmr_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%alswvisdif ) ) THEN 
  DEALLOCATE(grid%alswvisdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alswvisdif. ')
 endif
  NULLIFY(grid%alswvisdif)
ENDIF
IF ( ASSOCIATED( grid%wwlt_px ) ) THEN 
  DEALLOCATE(grid%wwlt_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wwlt_px. ')
 endif
  NULLIFY(grid%wwlt_px)
ENDIF
IF ( ASSOCIATED( grid%br ) ) THEN 
  DEALLOCATE(grid%br,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%br. ')
 endif
  NULLIFY(grid%br)
ENDIF
IF ( ASSOCIATED( grid%uz0 ) ) THEN 
  DEALLOCATE(grid%uz0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uz0. ')
 endif
  NULLIFY(grid%uz0)
ENDIF
IF ( ASSOCIATED( grid%th10 ) ) THEN 
  DEALLOCATE(grid%th10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th10. ')
 endif
  NULLIFY(grid%th10)
ENDIF
IF ( ASSOCIATED( grid%v_up ) ) THEN 
  DEALLOCATE(grid%v_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_up. ')
 endif
  NULLIFY(grid%v_up)
ENDIF
IF ( ASSOCIATED( grid%thup_temf ) ) THEN 
  DEALLOCATE(grid%thup_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thup_temf. ')
 endif
  NULLIFY(grid%thup_temf)
ENDIF
IF ( ASSOCIATED( grid%qdiss ) ) THEN 
  DEALLOCATE(grid%qdiss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qdiss. ')
 endif
  NULLIFY(grid%qdiss)
ENDIF
IF ( ASSOCIATED( grid%edmf_qt ) ) THEN 
  DEALLOCATE(grid%edmf_qt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edmf_qt. ')
 endif
  NULLIFY(grid%edmf_qt)
ENDIF
IF ( ASSOCIATED( grid%vdfg ) ) THEN 
  DEALLOCATE(grid%vdfg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vdfg. ')
 endif
  NULLIFY(grid%vdfg)
ENDIF
IF ( ASSOCIATED( grid%ol1 ) ) THEN 
  DEALLOCATE(grid%ol1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol1. ')
 endif
  NULLIFY(grid%ol1)
ENDIF
IF ( ASSOCIATED( grid%dusfcg_ls ) ) THEN 
  DEALLOCATE(grid%dusfcg_ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dusfcg_ls. ')
 endif
  NULLIFY(grid%dusfcg_ls)
ENDIF
IF ( ASSOCIATED( grid%oa3ls ) ) THEN 
  DEALLOCATE(grid%oa3ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%oa3ls. ')
 endif
  NULLIFY(grid%oa3ls)
ENDIF
IF ( ASSOCIATED( grid%ol1ss ) ) THEN 
  DEALLOCATE(grid%ol1ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol1ss. ')
 endif
  NULLIFY(grid%ol1ss)
ENDIF
IF ( ASSOCIATED( grid%b_v_bep ) ) THEN 
  DEALLOCATE(grid%b_v_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_v_bep. ')
 endif
  NULLIFY(grid%b_v_bep)
ENDIF
IF ( ASSOCIATED( grid%pr_pbl ) ) THEN 
  DEALLOCATE(grid%pr_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pr_pbl. ')
 endif
  NULLIFY(grid%pr_pbl)
ENDIF
IF ( ASSOCIATED( grid%rswtoa ) ) THEN 
  DEALLOCATE(grid%rswtoa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rswtoa. ')
 endif
  NULLIFY(grid%rswtoa)
ENDIF
IF ( ASSOCIATED( grid%aerodm ) ) THEN 
  DEALLOCATE(grid%aerodm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerodm. ')
 endif
  NULLIFY(grid%aerodm)
ENDIF
IF ( ASSOCIATED( grid%m_hybi ) ) THEN 
  DEALLOCATE(grid%m_hybi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%m_hybi. ')
 endif
  NULLIFY(grid%m_hybi)
ENDIF
IF ( ASSOCIATED( grid%om_ml ) ) THEN 
  DEALLOCATE(grid%om_ml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_ml. ')
 endif
  NULLIFY(grid%om_ml)
ENDIF
IF ( ASSOCIATED( grid%wcloudbase ) ) THEN 
  DEALLOCATE(grid%wcloudbase,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wcloudbase. ')
 endif
  NULLIFY(grid%wcloudbase)
ENDIF
IF ( ASSOCIATED( grid%mfup_ent_cup ) ) THEN 
  DEALLOCATE(grid%mfup_ent_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mfup_ent_cup. ')
 endif
  NULLIFY(grid%mfup_ent_cup)
ENDIF
IF ( ASSOCIATED( grid%msft ) ) THEN 
  DEALLOCATE(grid%msft,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msft. ')
 endif
  NULLIFY(grid%msft)
ENDIF
IF ( ASSOCIATED( grid%sina ) ) THEN 
  DEALLOCATE(grid%sina,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sina. ')
 endif
  NULLIFY(grid%sina)
ENDIF
IF ( ASSOCIATED( grid%physs ) ) THEN 
  DEALLOCATE(grid%physs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%physs. ')
 endif
  NULLIFY(grid%physs)
ENDIF
IF ( ASSOCIATED( grid%precg3d ) ) THEN 
  DEALLOCATE(grid%precg3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%precg3d. ')
 endif
  NULLIFY(grid%precg3d)
ENDIF
IF ( ASSOCIATED( grid%ctop2d_out ) ) THEN 
  DEALLOCATE(grid%ctop2d_out,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ctop2d_out. ')
 endif
  NULLIFY(grid%ctop2d_out)
ENDIF
IF ( ASSOCIATED( grid%rdcashten ) ) THEN 
  DEALLOCATE(grid%rdcashten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rdcashten. ')
 endif
  NULLIFY(grid%rdcashten)
ENDIF
IF ( ASSOCIATED( grid%rainshvb ) ) THEN 
  DEALLOCATE(grid%rainshvb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainshvb. ')
 endif
  NULLIFY(grid%rainshvb)
ENDIF
IF ( ASSOCIATED( grid%rvcuten ) ) THEN 
  DEALLOCATE(grid%rvcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rvcuten. ')
 endif
  NULLIFY(grid%rvcuten)
ENDIF
IF ( ASSOCIATED( grid%rainc ) ) THEN 
  DEALLOCATE(grid%rainc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainc. ')
 endif
  NULLIFY(grid%rainc)
ENDIF
IF ( ASSOCIATED( grid%graupelnc ) ) THEN 
  DEALLOCATE(grid%graupelnc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%graupelnc. ')
 endif
  NULLIFY(grid%graupelnc)
ENDIF
IF ( ASSOCIATED( grid%phii3d ) ) THEN 
  DEALLOCATE(grid%phii3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phii3d. ')
 endif
  NULLIFY(grid%phii3d)
ENDIF
IF ( ASSOCIATED( grid%nca ) ) THEN 
  DEALLOCATE(grid%nca,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%nca. ')
 endif
  NULLIFY(grid%nca)
ENDIF
IF ( ASSOCIATED( grid%apr_mc ) ) THEN 
  DEALLOCATE(grid%apr_mc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_mc. ')
 endif
  NULLIFY(grid%apr_mc)
ENDIF
IF ( ASSOCIATED( grid%kbcon_deep ) ) THEN 
  DEALLOCATE(grid%kbcon_deep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kbcon_deep. ')
 endif
  NULLIFY(grid%kbcon_deep)
ENDIF
IF ( ASSOCIATED( grid%raincv_a ) ) THEN 
  DEALLOCATE(grid%raincv_a,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%raincv_a. ')
 endif
  NULLIFY(grid%raincv_a)
ENDIF
IF ( ASSOCIATED( grid%ccn_cu ) ) THEN 
  DEALLOCATE(grid%ccn_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn_cu. ')
 endif
  NULLIFY(grid%ccn_cu)
ENDIF
IF ( ASSOCIATED( grid%ccn4_gs ) ) THEN 
  DEALLOCATE(grid%ccn4_gs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ccn4_gs. ')
 endif
  NULLIFY(grid%ccn4_gs)
ENDIF
IF ( ASSOCIATED( grid%rthratenlwc ) ) THEN 
  DEALLOCATE(grid%rthratenlwc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthratenlwc. ')
 endif
  NULLIFY(grid%rthratenlwc)
ENDIF
IF ( ASSOCIATED( grid%swdownc2 ) ) THEN 
  DEALLOCATE(grid%swdownc2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdownc2. ')
 endif
  NULLIFY(grid%swdownc2)
ENDIF
IF ( ASSOCIATED( grid%swddif ) ) THEN 
  DEALLOCATE(grid%swddif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddif. ')
 endif
  NULLIFY(grid%swddif)
ENDIF
IF ( ASSOCIATED( grid%aerasy2d ) ) THEN 
  DEALLOCATE(grid%aerasy2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerasy2d. ')
 endif
  NULLIFY(grid%aerasy2d)
ENDIF
IF ( ASSOCIATED( grid%tq2min ) ) THEN 
  DEALLOCATE(grid%tq2min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tq2min. ')
 endif
  NULLIFY(grid%tq2min)
ENDIF
IF ( ASSOCIATED( grid%spduv10max ) ) THEN 
  DEALLOCATE(grid%spduv10max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spduv10max. ')
 endif
  NULLIFY(grid%spduv10max)
ENDIF
IF ( ASSOCIATED( grid%raincvmean ) ) THEN 
  DEALLOCATE(grid%raincvmean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%raincvmean. ')
 endif
  NULLIFY(grid%raincvmean)
ENDIF
IF ( ASSOCIATED( grid%acswdnbc ) ) THEN 
  DEALLOCATE(grid%acswdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswdnbc. ')
 endif
  NULLIFY(grid%acswdnbc)
ENDIF
IF ( ASSOCIATED( grid%i_acswdntc ) ) THEN 
  DEALLOCATE(grid%i_acswdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswdntc. ')
 endif
  NULLIFY(grid%i_acswdntc)
ENDIF
IF ( ASSOCIATED( grid%i_aclwdnbc ) ) THEN 
  DEALLOCATE(grid%i_aclwdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwdnbc. ')
 endif
  NULLIFY(grid%i_aclwdnbc)
ENDIF
IF ( ASSOCIATED( grid%swdnbcln ) ) THEN 
  DEALLOCATE(grid%swdnbcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnbcln. ')
 endif
  NULLIFY(grid%swdnbcln)
ENDIF
IF ( ASSOCIATED( grid%lwdnbcln ) ) THEN 
  DEALLOCATE(grid%lwdnbcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnbcln. ')
 endif
  NULLIFY(grid%lwdnbcln)
ENDIF
IF ( ASSOCIATED( grid%emiss ) ) THEN 
  DEALLOCATE(grid%emiss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%emiss. ')
 endif
  NULLIFY(grid%emiss)
ENDIF
IF ( ASSOCIATED( grid%flx4 ) ) THEN 
  DEALLOCATE(grid%flx4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flx4. ')
 endif
  NULLIFY(grid%flx4)
ENDIF
IF ( ASSOCIATED( grid%snowc_mosaic ) ) THEN 
  DEALLOCATE(grid%snowc_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowc_mosaic. ')
 endif
  NULLIFY(grid%snowc_mosaic)
ENDIF
IF ( ASSOCIATED( grid%grdflx_mosaic ) ) THEN 
  DEALLOCATE(grid%grdflx_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grdflx_mosaic. ')
 endif
  NULLIFY(grid%grdflx_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tgl_urb3d_mosaic ) ) THEN 
  DEALLOCATE(grid%tgl_urb3d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgl_urb3d_mosaic. ')
 endif
  NULLIFY(grid%tgl_urb3d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%cka ) ) THEN 
  DEALLOCATE(grid%cka,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cka. ')
 endif
  NULLIFY(grid%cka)
ENDIF
IF ( ASSOCIATED( grid%qfx ) ) THEN 
  DEALLOCATE(grid%qfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qfx. ')
 endif
  NULLIFY(grid%qfx)
ENDIF
IF ( ASSOCIATED( grid%soilt1 ) ) THEN 
  DEALLOCATE(grid%soilt1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt1. ')
 endif
  NULLIFY(grid%soilt1)
ENDIF
IF ( ASSOCIATED( grid%soiltb ) ) THEN 
  DEALLOCATE(grid%soiltb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soiltb. ')
 endif
  NULLIFY(grid%soiltb)
ENDIF
IF ( ASSOCIATED( grid%xkhv ) ) THEN 
  DEALLOCATE(grid%xkhv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xkhv. ')
 endif
  NULLIFY(grid%xkhv)
ENDIF
IF ( ASSOCIATED( grid%rqvndgdten ) ) THEN 
  DEALLOCATE(grid%rqvndgdten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvndgdten. ')
 endif
  NULLIFY(grid%rqvndgdten)
ENDIF
IF ( ASSOCIATED( grid%q2_ndg_old ) ) THEN 
  DEALLOCATE(grid%q2_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2_ndg_old. ')
 endif
  NULLIFY(grid%q2_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%sn_ndg_new ) ) THEN 
  DEALLOCATE(grid%sn_ndg_new,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sn_ndg_new. ')
 endif
  NULLIFY(grid%sn_ndg_new)
ENDIF
IF ( ASSOCIATED( grid%dpsdt ) ) THEN 
  DEALLOCATE(grid%dpsdt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dpsdt. ')
 endif
  NULLIFY(grid%dpsdt)
ENDIF
IF ( ASSOCIATED( grid%w_colmean ) ) THEN 
  DEALLOCATE(grid%w_colmean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_colmean. ')
 endif
  NULLIFY(grid%w_colmean)
ENDIF
IF ( ASSOCIATED( grid%t0ml ) ) THEN 
  DEALLOCATE(grid%t0ml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t0ml. ')
 endif
  NULLIFY(grid%t0ml)
ENDIF
IF ( ASSOCIATED( grid%track_rh ) ) THEN 
  DEALLOCATE(grid%track_rh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_rh. ')
 endif
  NULLIFY(grid%track_rh)
ENDIF
IF ( ASSOCIATED( grid%cldtopz ) ) THEN 
  DEALLOCATE(grid%cldtopz,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldtopz. ')
 endif
  NULLIFY(grid%cldtopz)
ENDIF
IF ( ASSOCIATED( grid%athblten ) ) THEN 
  DEALLOCATE(grid%athblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athblten. ')
 endif
  NULLIFY(grid%athblten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_dhail1 ) ) THEN 
  DEALLOCATE(grid%hailcast_dhail1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_dhail1. ')
 endif
  NULLIFY(grid%hailcast_dhail1)
ENDIF
IF ( ASSOCIATED( grid%ww_xxx ) ) THEN 
  DEALLOCATE(grid%ww_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ww_xxx. ')
 endif
  NULLIFY(grid%ww_xxx)
ENDIF
IF ( ASSOCIATED( grid%zsf ) ) THEN 
  DEALLOCATE(grid%zsf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zsf. ')
 endif
  NULLIFY(grid%zsf)
ENDIF
IF ( ASSOCIATED( grid%vah ) ) THEN 
  DEALLOCATE(grid%vah,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vah. ')
 endif
  NULLIFY(grid%vah)
ENDIF
IF ( ASSOCIATED( grid%fire_area ) ) THEN 
  DEALLOCATE(grid%fire_area,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fire_area. ')
 endif
  NULLIFY(grid%fire_area)
ENDIF
IF ( ASSOCIATED( grid%betafl ) ) THEN 
  DEALLOCATE(grid%betafl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%betafl. ')
 endif
  NULLIFY(grid%betafl)
ENDIF
IF ( ASSOCIATED( grid%fs_count_landed_hist ) ) THEN 
  DEALLOCATE(grid%fs_count_landed_hist,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_count_landed_hist. ')
 endif
  NULLIFY(grid%fs_count_landed_hist)
ENDIF
IF ( ASSOCIATED( grid%fs_p_diam ) ) THEN 
  DEALLOCATE(grid%fs_p_diam,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_diam. ')
 endif
  NULLIFY(grid%fs_p_diam)
ENDIF
IF ( ASSOCIATED( grid%avgflx_dfd1 ) ) THEN 
  DEALLOCATE(grid%avgflx_dfd1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_dfd1. ')
 endif
  NULLIFY(grid%avgflx_dfd1)
ENDIF
IF ( ASSOCIATED( grid%field_sf ) ) THEN 
  DEALLOCATE(grid%field_sf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_sf. ')
 endif
  NULLIFY(grid%field_sf)
ENDIF
IF ( ASSOCIATED( grid%rand_imag ) ) THEN 
  DEALLOCATE(grid%rand_imag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_imag. ')
 endif
  NULLIFY(grid%rand_imag)
ENDIF
IF ( ASSOCIATED( grid%sp_amp2 ) ) THEN 
  DEALLOCATE(grid%sp_amp2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp2. ')
 endif
  NULLIFY(grid%sp_amp2)
ENDIF
IF ( ASSOCIATED( grid%sppt_amp ) ) THEN 
  DEALLOCATE(grid%sppt_amp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sppt_amp. ')
 endif
  NULLIFY(grid%sppt_amp)
ENDIF
IF ( ASSOCIATED( grid%rand_imag_yyy ) ) THEN 
  DEALLOCATE(grid%rand_imag_yyy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_imag_yyy. ')
 endif
  NULLIFY(grid%rand_imag_yyy)
ENDIF
IF ( ASSOCIATED( grid%timescale_mult3d ) ) THEN 
  DEALLOCATE(grid%timescale_mult3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%timescale_mult3d. ')
 endif
  NULLIFY(grid%timescale_mult3d)
ENDIF
IF ( ASSOCIATED( grid%zmdt ) ) THEN 
  DEALLOCATE(grid%zmdt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmdt. ')
 endif
  NULLIFY(grid%zmdt)
ENDIF
IF ( ASSOCIATED( grid%zmeiheat ) ) THEN 
  DEALLOCATE(grid%zmeiheat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmeiheat. ')
 endif
  NULLIFY(grid%zmeiheat)
ENDIF
IF ( ASSOCIATED( grid%zmvpgu ) ) THEN 
  DEALLOCATE(grid%zmvpgu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmvpgu. ')
 endif
  NULLIFY(grid%zmvpgu)
ENDIF
IF ( ASSOCIATED( grid%eu3d ) ) THEN 
  DEALLOCATE(grid%eu3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%eu3d. ')
 endif
  NULLIFY(grid%eu3d)
ENDIF
IF ( ASSOCIATED( grid%cldfrash ) ) THEN 
  DEALLOCATE(grid%cldfrash,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfrash. ')
 endif
  NULLIFY(grid%cldfrash)
ENDIF
IF ( ASSOCIATED( grid%vflx_cu ) ) THEN 
  DEALLOCATE(grid%vflx_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vflx_cu. ')
 endif
  NULLIFY(grid%vflx_cu)
ENDIF
IF ( ASSOCIATED( grid%wlcl_cu ) ) THEN 
  DEALLOCATE(grid%wlcl_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wlcl_cu. ')
 endif
  NULLIFY(grid%wlcl_cu)
ENDIF
IF ( ASSOCIATED( grid%cbmflimit_cu ) ) THEN 
  DEALLOCATE(grid%cbmflimit_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cbmflimit_cu. ')
 endif
  NULLIFY(grid%cbmflimit_cu)
ENDIF
IF ( ASSOCIATED( grid%uu_cu ) ) THEN 
  DEALLOCATE(grid%uu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uu_cu. ')
 endif
  NULLIFY(grid%uu_cu)
ENDIF
IF ( ASSOCIATED( grid%fer_cu ) ) THEN 
  DEALLOCATE(grid%fer_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fer_cu. ')
 endif
  NULLIFY(grid%fer_cu)
ENDIF
IF ( ASSOCIATED( grid%xc_cu ) ) THEN 
  DEALLOCATE(grid%xc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xc_cu. ')
 endif
  NULLIFY(grid%xc_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_drycore_cu ) ) THEN 
  DEALLOCATE(grid%exit_drycore_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_drycore_cu. ')
 endif
  NULLIFY(grid%exit_drycore_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_cbmf_cu ) ) THEN 
  DEALLOCATE(grid%limit_cbmf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_cbmf_cu. ')
 endif
  NULLIFY(grid%limit_cbmf_cu)
ENDIF
IF ( ASSOCIATED( grid%cldfral ) ) THEN 
  DEALLOCATE(grid%cldfral,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfral. ')
 endif
  NULLIFY(grid%cldfral)
ENDIF
IF ( ASSOCIATED( grid%wtc ) ) THEN 
  DEALLOCATE(grid%wtc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wtc. ')
 endif
  NULLIFY(grid%wtc)
ENDIF
IF ( ASSOCIATED( grid%fsi24 ) ) THEN 
  DEALLOCATE(grid%fsi24,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsi24. ')
 endif
  NULLIFY(grid%fsi24)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq_s3 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq_s3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq_s3. ')
 endif
  NULLIFY(grid%h2osoi_liq_s3)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq10 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq10. ')
 endif
  NULLIFY(grid%h2osoi_liq10)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice7 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice7,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice7. ')
 endif
  NULLIFY(grid%h2osoi_ice7)
ENDIF
IF ( ASSOCIATED( grid%t_soisno4 ) ) THEN 
  DEALLOCATE(grid%t_soisno4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno4. ')
 endif
  NULLIFY(grid%t_soisno4)
ENDIF
IF ( ASSOCIATED( grid%snowrds1 ) ) THEN 
  DEALLOCATE(grid%snowrds1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowrds1. ')
 endif
  NULLIFY(grid%snowrds1)
ENDIF
IF ( ASSOCIATED( grid%t_lake8 ) ) THEN 
  DEALLOCATE(grid%t_lake8,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake8. ')
 endif
  NULLIFY(grid%t_lake8)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol10 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol10. ')
 endif
  NULLIFY(grid%h2osoi_vol10)
ENDIF
IF ( ASSOCIATED( grid%savedtke12d ) ) THEN 
  DEALLOCATE(grid%savedtke12d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%savedtke12d. ')
 endif
  NULLIFY(grid%savedtke12d)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol3d ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol3d. ')
 endif
  NULLIFY(grid%h2osoi_vol3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_ect ) ) THEN 
  DEALLOCATE(grid%ssib_ect,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_ect. ')
 endif
  NULLIFY(grid%ssib_ect)
ENDIF
IF ( ASSOCIATED( grid%ssib_z00 ) ) THEN 
  DEALLOCATE(grid%ssib_z00,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_z00. ')
 endif
  NULLIFY(grid%ssib_z00)
ENDIF
IF ( ASSOCIATED( grid%bto1 ) ) THEN 
  DEALLOCATE(grid%bto1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bto1. ')
 endif
  NULLIFY(grid%bto1)
ENDIF
IF ( ASSOCIATED( grid%bto2 ) ) THEN 
  DEALLOCATE(grid%bto2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bto2. ')
 endif
  NULLIFY(grid%bto2)
ENDIF
IF ( ASSOCIATED( grid%bto3 ) ) THEN 
  DEALLOCATE(grid%bto3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bto3. ')
 endif
  NULLIFY(grid%bto3)
ENDIF
IF ( ASSOCIATED( grid%bto4 ) ) THEN 
  DEALLOCATE(grid%bto4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bto4. ')
 endif
  NULLIFY(grid%bto4)
ENDIF
IF ( ASSOCIATED( grid%eahxy ) ) THEN 
  DEALLOCATE(grid%eahxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%eahxy. ')
 endif
  NULLIFY(grid%eahxy)
ENDIF
IF ( ASSOCIATED( grid%wtxy ) ) THEN 
  DEALLOCATE(grid%wtxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wtxy. ')
 endif
  NULLIFY(grid%wtxy)
ENDIF
IF ( ASSOCIATED( grid%taussxy ) ) THEN 
  DEALLOCATE(grid%taussxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%taussxy. ')
 endif
  NULLIFY(grid%taussxy)
ENDIF
IF ( ASSOCIATED( grid%runsbxy ) ) THEN 
  DEALLOCATE(grid%runsbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%runsbxy. ')
 endif
  NULLIFY(grid%runsbxy)
ENDIF
IF ( ASSOCIATED( grid%bgapxy ) ) THEN 
  DEALLOCATE(grid%bgapxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bgapxy. ')
 endif
  NULLIFY(grid%bgapxy)
ENDIF
IF ( ASSOCIATED( grid%ghbxy ) ) THEN 
  DEALLOCATE(grid%ghbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ghbxy. ')
 endif
  NULLIFY(grid%ghbxy)
ENDIF
IF ( ASSOCIATED( grid%smcwtdxy ) ) THEN 
  DEALLOCATE(grid%smcwtdxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smcwtdxy. ')
 endif
  NULLIFY(grid%smcwtdxy)
ENDIF
IF ( ASSOCIATED( grid%qthrorxy ) ) THEN 
  DEALLOCATE(grid%qthrorxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qthrorxy. ')
 endif
  NULLIFY(grid%qthrorxy)
ENDIF
IF ( ASSOCIATED( grid%pahxy ) ) THEN 
  DEALLOCATE(grid%pahxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pahxy. ')
 endif
  NULLIFY(grid%pahxy)
ENDIF
IF ( ASSOCIATED( grid%soilcl4 ) ) THEN 
  DEALLOCATE(grid%soilcl4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcl4. ')
 endif
  NULLIFY(grid%soilcl4)
ENDIF
IF ( ASSOCIATED( grid%acrainlsm ) ) THEN 
  DEALLOCATE(grid%acrainlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acrainlsm. ')
 endif
  NULLIFY(grid%acrainlsm)
ENDIF
IF ( ASSOCIATED( grid%acfrzc ) ) THEN 
  DEALLOCATE(grid%acfrzc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acfrzc. ')
 endif
  NULLIFY(grid%acfrzc)
ENDIF
IF ( ASSOCIATED( grid%acshb ) ) THEN 
  DEALLOCATE(grid%acshb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acshb. ')
 endif
  NULLIFY(grid%acshb)
ENDIF
IF ( ASSOCIATED( grid%acshc ) ) THEN 
  DEALLOCATE(grid%acshc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acshc. ')
 endif
  NULLIFY(grid%acshc)
ENDIF
IF ( ASSOCIATED( grid%accanhs ) ) THEN 
  DEALLOCATE(grid%accanhs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%accanhs. ')
 endif
  NULLIFY(grid%accanhs)
ENDIF
IF ( ASSOCIATED( grid%acc_etranxy ) ) THEN 
  DEALLOCATE(grid%acc_etranxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_etranxy. ')
 endif
  NULLIFY(grid%acc_etranxy)
ENDIF
IF ( ASSOCIATED( grid%qtdrain ) ) THEN 
  DEALLOCATE(grid%qtdrain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtdrain. ')
 endif
  NULLIFY(grid%qtdrain)
ENDIF
IF ( ASSOCIATED( grid%irmivol ) ) THEN 
  DEALLOCATE(grid%irmivol,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irmivol. ')
 endif
  NULLIFY(grid%irmivol)
ENDIF
IF ( ASSOCIATED( grid%kext_ft_qic ) ) THEN 
  DEALLOCATE(grid%kext_ft_qic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ft_qic. ')
 endif
  NULLIFY(grid%kext_ft_qic)
ENDIF
IF ( ASSOCIATED( grid%grpl_flx_max ) ) THEN 
  DEALLOCATE(grid%grpl_flx_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%grpl_flx_max. ')
 endif
  NULLIFY(grid%grpl_flx_max)
ENDIF
IF ( ASSOCIATED( grid%qicing_sm_max ) ) THEN 
  DEALLOCATE(grid%qicing_sm_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qicing_sm_max. ')
 endif
  NULLIFY(grid%qicing_sm_max)
ENDIF
IF ( ASSOCIATED( grid%afwa_llturbmdt ) ) THEN 
  DEALLOCATE(grid%afwa_llturbmdt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_llturbmdt. ')
 endif
  NULLIFY(grid%afwa_llturbmdt)
ENDIF
IF ( ASSOCIATED( grid%afwa_cloud ) ) THEN 
  DEALLOCATE(grid%afwa_cloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cloud. ')
 endif
  NULLIFY(grid%afwa_cloud)
ENDIF
IF ( ASSOCIATED( grid%afwa_hail ) ) THEN 
  DEALLOCATE(grid%afwa_hail,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_hail. ')
 endif
  NULLIFY(grid%afwa_hail)
ENDIF
IF ( ASSOCIATED( grid%lh_mean ) ) THEN 
  DEALLOCATE(grid%lh_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lh_mean. ')
 endif
  NULLIFY(grid%lh_mean)
ENDIF
IF ( ASSOCIATED( grid%tsk_diurn ) ) THEN 
  DEALLOCATE(grid%tsk_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_diurn. ')
 endif
  NULLIFY(grid%tsk_diurn)
ENDIF
IF ( ASSOCIATED( grid%swupt_diurn ) ) THEN 
  DEALLOCATE(grid%swupt_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupt_diurn. ')
 endif
  NULLIFY(grid%swupt_diurn)
ENDIF
IF ( ASSOCIATED( grid%v10_dtmp ) ) THEN 
  DEALLOCATE(grid%v10_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10_dtmp. ')
 endif
  NULLIFY(grid%v10_dtmp)
ENDIF
IF ( ASSOCIATED( grid%rscghis_2d ) ) THEN 
  DEALLOCATE(grid%rscghis_2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rscghis_2d. ')
 endif
  NULLIFY(grid%rscghis_2d)
ENDIF
IF ( ASSOCIATED( grid%flshi ) ) THEN 
  DEALLOCATE(grid%flshi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flshi. ')
 endif
  NULLIFY(grid%flshi)
ENDIF
IF ( ASSOCIATED( grid%field_u_tend_perturb ) ) THEN 
  DEALLOCATE(grid%field_u_tend_perturb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%field_u_tend_perturb. ')
 endif
  NULLIFY(grid%field_u_tend_perturb)
ENDIF
IF ( ASSOCIATED( grid%c4f ) ) THEN 
  DEALLOCATE(grid%c4f,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c4f. ')
 endif
  NULLIFY(grid%c4f)
ENDIF
IF ( ASSOCIATED( grid%p_wif_gc ) ) THEN 
  DEALLOCATE(grid%p_wif_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_gc. ')
 endif
  NULLIFY(grid%p_wif_gc)
ENDIF
IF ( ASSOCIATED( grid%p_wif_nov ) ) THEN 
  DEALLOCATE(grid%p_wif_nov,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_nov. ')
 endif
  NULLIFY(grid%p_wif_nov)
ENDIF
IF ( ASSOCIATED( grid%w_wif_oct ) ) THEN 
  DEALLOCATE(grid%w_wif_oct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_oct. ')
 endif
  NULLIFY(grid%w_wif_oct)
ENDIF
IF ( ASSOCIATED( grid%i_wif_sep ) ) THEN 
  DEALLOCATE(grid%i_wif_sep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_sep. ')
 endif
  NULLIFY(grid%i_wif_sep)
ENDIF
IF ( ASSOCIATED( grid%b_wif_aug ) ) THEN 
  DEALLOCATE(grid%b_wif_aug,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_aug. ')
 endif
  NULLIFY(grid%b_wif_aug)
ENDIF
IF ( ASSOCIATED( grid%speed ) ) THEN 
  DEALLOCATE(grid%speed,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%speed. ')
 endif
  NULLIFY(grid%speed)
ENDIF
IF ( ASSOCIATED( grid%lwp ) ) THEN 
  DEALLOCATE(grid%lwp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwp. ')
 endif
  NULLIFY(grid%lwp)
ENDIF
IF ( ASSOCIATED( grid%tau_qc ) ) THEN 
  DEALLOCATE(grid%tau_qc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_qc. ')
 endif
  NULLIFY(grid%tau_qc)
ENDIF
IF ( ASSOCIATED( grid%ts_cldfrac2d ) ) THEN 
  DEALLOCATE(grid%ts_cldfrac2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_cldfrac2d. ')
 endif
  NULLIFY(grid%ts_cldfrac2d)
ENDIF
IF ( ASSOCIATED( grid%ts_re_qc_tot ) ) THEN 
  DEALLOCATE(grid%ts_re_qc_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_re_qc_tot. ')
 endif
  NULLIFY(grid%ts_re_qc_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_sza ) ) THEN 
  DEALLOCATE(grid%ts_sza,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_sza. ')
 endif
  NULLIFY(grid%ts_sza)
ENDIF
IF ( ASSOCIATED( grid%rh_pl ) ) THEN 
  DEALLOCATE(grid%rh_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh_pl. ')
 endif
  NULLIFY(grid%rh_pl)
ENDIF
IF ( ASSOCIATED( grid%u_zl ) ) THEN 
  DEALLOCATE(grid%u_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_zl. ')
 endif
  NULLIFY(grid%u_zl)
ENDIF
IF ( ASSOCIATED( grid%mcm_lw ) ) THEN 
  DEALLOCATE(grid%mcm_lw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_lw. ')
 endif
  NULLIFY(grid%mcm_lw)
ENDIF
IF ( ASSOCIATED( grid%mcm_lw_in ) ) THEN 
  DEALLOCATE(grid%mcm_lw_in,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_lw_in. ')
 endif
  NULLIFY(grid%mcm_lw_in)
ENDIF
IF ( ASSOCIATED( grid%prtk ) ) THEN 
  DEALLOCATE(grid%prtk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prtk. ')
 endif
  NULLIFY(grid%prtk)
ENDIF
IF ( ASSOCIATED( grid%lakemask ) ) THEN 
  DEALLOCATE(grid%lakemask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lakemask. ')
 endif
  NULLIFY(grid%lakemask)
ENDIF
END SUBROUTINE deallocs_2
!ENDOFREGISTRYGENERATEDINCLUDE
