!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_6.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_6( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%zs ) ) THEN 
  DEALLOCATE(grid%zs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zs. ')
 endif
  NULLIFY(grid%zs)
ENDIF
IF ( ASSOCIATED( grid%p_gc ) ) THEN 
  DEALLOCATE(grid%p_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_gc. ')
 endif
  NULLIFY(grid%p_gc)
ENDIF
IF ( ASSOCIATED( grid%scb_dom_gc ) ) THEN 
  DEALLOCATE(grid%scb_dom_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%scb_dom_gc. ')
 endif
  NULLIFY(grid%scb_dom_gc)
ENDIF
IF ( ASSOCIATED( grid%cf_gc ) ) THEN 
  DEALLOCATE(grid%cf_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cf_gc. ')
 endif
  NULLIFY(grid%cf_gc)
ENDIF
IF ( ASSOCIATED( grid%qns_gc ) ) THEN 
  DEALLOCATE(grid%qns_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qns_gc. ')
 endif
  NULLIFY(grid%qns_gc)
ENDIF
IF ( ASSOCIATED( grid%hgttrop ) ) THEN 
  DEALLOCATE(grid%hgttrop,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hgttrop. ')
 endif
  NULLIFY(grid%hgttrop)
ENDIF
IF ( ASSOCIATED( grid%bathymetry ) ) THEN 
  DEALLOCATE(grid%bathymetry,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bathymetry. ')
 endif
  NULLIFY(grid%bathymetry)
ENDIF
IF ( ASSOCIATED( grid%u_g ) ) THEN 
  DEALLOCATE(grid%u_g,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_g. ')
 endif
  NULLIFY(grid%u_g)
ENDIF
IF ( ASSOCIATED( grid%w_1 ) ) THEN 
  DEALLOCATE(grid%w_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_1. ')
 endif
  NULLIFY(grid%w_1)
ENDIF
IF ( ASSOCIATED( grid%w_2 ) ) THEN 
  DEALLOCATE(grid%w_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_2. ')
 endif
  NULLIFY(grid%w_2)
ENDIF
IF ( ASSOCIATED( grid%th_upstream_y ) ) THEN 
  DEALLOCATE(grid%th_upstream_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%th_upstream_y. ')
 endif
  NULLIFY(grid%th_upstream_y)
ENDIF
IF ( ASSOCIATED( grid%u_upstream_y ) ) THEN 
  DEALLOCATE(grid%u_upstream_y,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_upstream_y. ')
 endif
  NULLIFY(grid%u_upstream_y)
ENDIF
IF ( ASSOCIATED( grid%ql_largescale ) ) THEN 
  DEALLOCATE(grid%ql_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ql_largescale. ')
 endif
  NULLIFY(grid%ql_largescale)
ENDIF
IF ( ASSOCIATED( grid%t_soil_forcing_val ) ) THEN 
  DEALLOCATE(grid%t_soil_forcing_val,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soil_forcing_val. ')
 endif
  NULLIFY(grid%t_soil_forcing_val)
ENDIF
IF ( ASSOCIATED( grid%mu_1 ) ) THEN 
  DEALLOCATE(grid%mu_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_1. ')
 endif
  NULLIFY(grid%mu_1)
ENDIF
IF ( ASSOCIATED( grid%mu_2 ) ) THEN 
  DEALLOCATE(grid%mu_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_2. ')
 endif
  NULLIFY(grid%mu_2)
ENDIF
IF ( ASSOCIATED( grid%mut ) ) THEN 
  DEALLOCATE(grid%mut,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mut. ')
 endif
  NULLIFY(grid%mut)
ENDIF
IF ( ASSOCIATED( grid%gamu ) ) THEN 
  DEALLOCATE(grid%gamu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gamu. ')
 endif
  NULLIFY(grid%gamu)
ENDIF
IF ( ASSOCIATED( grid%rdz ) ) THEN 
  DEALLOCATE(grid%rdz,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rdz. ')
 endif
  NULLIFY(grid%rdz)
ENDIF
IF ( ASSOCIATED( grid%p_hyd_w ) ) THEN 
  DEALLOCATE(grid%p_hyd_w,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_hyd_w. ')
 endif
  NULLIFY(grid%p_hyd_w)
ENDIF
IF ( ASSOCIATED( grid%imask_nostag ) ) THEN 
  DEALLOCATE(grid%imask_nostag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%imask_nostag. ')
 endif
  NULLIFY(grid%imask_nostag)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_bxs ) ) THEN 
  DEALLOCATE(grid%dfi_moist_bxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_bxs. ')
 endif
  NULLIFY(grid%dfi_moist_bxs)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_bxe ) ) THEN 
  DEALLOCATE(grid%dfi_moist_bxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_bxe. ')
 endif
  NULLIFY(grid%dfi_moist_bxe)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_bys ) ) THEN 
  DEALLOCATE(grid%dfi_moist_bys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_bys. ')
 endif
  NULLIFY(grid%dfi_moist_bys)
ENDIF
IF ( ASSOCIATED( grid%dfi_moist_bye ) ) THEN 
  DEALLOCATE(grid%dfi_moist_bye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_moist_bye. ')
 endif
  NULLIFY(grid%dfi_moist_bye)
ENDIF
IF ( ASSOCIATED( grid%re_cloud_gsfc ) ) THEN 
  DEALLOCATE(grid%re_cloud_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_cloud_gsfc. ')
 endif
  NULLIFY(grid%re_cloud_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_snow_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_snow_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_snow_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_snow_gsfc)
ENDIF
IF ( ASSOCIATED( grid%fcx ) ) THEN 
  DEALLOCATE(grid%fcx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcx. ')
 endif
  NULLIFY(grid%fcx)
ENDIF
IF ( ASSOCIATED( grid%sm028100 ) ) THEN 
  DEALLOCATE(grid%sm028100,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sm028100. ')
 endif
  NULLIFY(grid%sm028100)
ENDIF
IF ( ASSOCIATED( grid%soilm005 ) ) THEN 
  DEALLOCATE(grid%soilm005,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm005. ')
 endif
  NULLIFY(grid%soilm005)
ENDIF
IF ( ASSOCIATED( grid%soilw020 ) ) THEN 
  DEALLOCATE(grid%soilw020,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilw020. ')
 endif
  NULLIFY(grid%soilw020)
ENDIF
IF ( ASSOCIATED( grid%soilt040 ) ) THEN 
  DEALLOCATE(grid%soilt040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt040. ')
 endif
  NULLIFY(grid%soilt040)
ENDIF
IF ( ASSOCIATED( grid%landusef ) ) THEN 
  DEALLOCATE(grid%landusef,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%landusef. ')
 endif
  NULLIFY(grid%landusef)
ENDIF
IF ( ASSOCIATED( grid%ts_q ) ) THEN 
  DEALLOCATE(grid%ts_q,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_q. ')
 endif
  NULLIFY(grid%ts_q)
ENDIF
IF ( ASSOCIATED( grid%ts_u_profile ) ) THEN 
  DEALLOCATE(grid%ts_u_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_u_profile. ')
 endif
  NULLIFY(grid%ts_u_profile)
ENDIF
IF ( ASSOCIATED( grid%hi_urb2d ) ) THEN 
  DEALLOCATE(grid%hi_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hi_urb2d. ')
 endif
  NULLIFY(grid%hi_urb2d)
ENDIF
IF ( ASSOCIATED( grid%albsi ) ) THEN 
  DEALLOCATE(grid%albsi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albsi. ')
 endif
  NULLIFY(grid%albsi)
ENDIF
IF ( ASSOCIATED( grid%isltyp ) ) THEN 
  DEALLOCATE(grid%isltyp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%isltyp. ')
 endif
  NULLIFY(grid%isltyp)
ENDIF
IF ( ASSOCIATED( grid%hcoeff ) ) THEN 
  DEALLOCATE(grid%hcoeff,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hcoeff. ')
 endif
  NULLIFY(grid%hcoeff)
ENDIF
IF ( ASSOCIATED( grid%dfi_t ) ) THEN 
  DEALLOCATE(grid%dfi_t,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_t. ')
 endif
  NULLIFY(grid%dfi_t)
ENDIF
IF ( ASSOCIATED( grid%dfi_smfr3d ) ) THEN 
  DEALLOCATE(grid%dfi_smfr3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_smfr3d. ')
 endif
  NULLIFY(grid%dfi_smfr3d)
ENDIF
IF ( ASSOCIATED( grid%xxxg_urb2d ) ) THEN 
  DEALLOCATE(grid%xxxg_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xxxg_urb2d. ')
 endif
  NULLIFY(grid%xxxg_urb2d)
ENDIF
IF ( ASSOCIATED( grid%tbl_urb3d ) ) THEN 
  DEALLOCATE(grid%tbl_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tbl_urb3d. ')
 endif
  NULLIFY(grid%tbl_urb3d)
ENDIF
IF ( ASSOCIATED( grid%tgb_urb4d ) ) THEN 
  DEALLOCATE(grid%tgb_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tgb_urb4d. ')
 endif
  NULLIFY(grid%tgb_urb4d)
ENDIF
IF ( ASSOCIATED( grid%sfwin1_urb3d ) ) THEN 
  DEALLOCATE(grid%sfwin1_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfwin1_urb3d. ')
 endif
  NULLIFY(grid%sfwin1_urb3d)
ENDIF
IF ( ASSOCIATED( grid%drain_urb4d ) ) THEN 
  DEALLOCATE(grid%drain_urb4d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%drain_urb4d. ')
 endif
  NULLIFY(grid%drain_urb4d)
ENDIF
IF ( ASSOCIATED( grid%cmgr_sfcdif ) ) THEN 
  DEALLOCATE(grid%cmgr_sfcdif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmgr_sfcdif. ')
 endif
  NULLIFY(grid%cmgr_sfcdif)
ENDIF
IF ( ASSOCIATED( grid%precipfr ) ) THEN 
  DEALLOCATE(grid%precipfr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%precipfr. ')
 endif
  NULLIFY(grid%precipfr)
ENDIF
IF ( ASSOCIATED( grid%rs ) ) THEN 
  DEALLOCATE(grid%rs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rs. ')
 endif
  NULLIFY(grid%rs)
ENDIF
IF ( ASSOCIATED( grid%csand_px ) ) THEN 
  DEALLOCATE(grid%csand_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%csand_px. ')
 endif
  NULLIFY(grid%csand_px)
ENDIF
IF ( ASSOCIATED( grid%pek_pbl ) ) THEN 
  DEALLOCATE(grid%pek_pbl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pek_pbl. ')
 endif
  NULLIFY(grid%pek_pbl)
ENDIF
IF ( ASSOCIATED( grid%akms ) ) THEN 
  DEALLOCATE(grid%akms,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%akms. ')
 endif
  NULLIFY(grid%akms)
ENDIF
IF ( ASSOCIATED( grid%entr_edkf ) ) THEN 
  DEALLOCATE(grid%entr_edkf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%entr_edkf. ')
 endif
  NULLIFY(grid%entr_edkf)
ENDIF
IF ( ASSOCIATED( grid%kh_temf ) ) THEN 
  DEALLOCATE(grid%kh_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kh_temf. ')
 endif
  NULLIFY(grid%kh_temf)
ENDIF
IF ( ASSOCIATED( grid%hd_temf ) ) THEN 
  DEALLOCATE(grid%hd_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hd_temf. ')
 endif
  NULLIFY(grid%hd_temf)
ENDIF
IF ( ASSOCIATED( grid%qsq ) ) THEN 
  DEALLOCATE(grid%qsq,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qsq. ')
 endif
  NULLIFY(grid%qsq)
ENDIF
IF ( ASSOCIATED( grid%sub_sqv3d ) ) THEN 
  DEALLOCATE(grid%sub_sqv3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sub_sqv3d. ')
 endif
  NULLIFY(grid%sub_sqv3d)
ENDIF
IF ( ASSOCIATED( grid%dusfcg ) ) THEN 
  DEALLOCATE(grid%dusfcg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dusfcg. ')
 endif
  NULLIFY(grid%dusfcg)
ENDIF
IF ( ASSOCIATED( grid%dtaux3d_ls ) ) THEN 
  DEALLOCATE(grid%dtaux3d_ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtaux3d_ls. ')
 endif
  NULLIFY(grid%dtaux3d_ls)
ENDIF
IF ( ASSOCIATED( grid%dusfcg_ss ) ) THEN 
  DEALLOCATE(grid%dusfcg_ss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dusfcg_ss. ')
 endif
  NULLIFY(grid%dusfcg_ss)
ENDIF
IF ( ASSOCIATED( grid%ol3ls ) ) THEN 
  DEALLOCATE(grid%ol3ls,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ol3ls. ')
 endif
  NULLIFY(grid%ol3ls)
ENDIF
IF ( ASSOCIATED( grid%ctopo ) ) THEN 
  DEALLOCATE(grid%ctopo,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ctopo. ')
 endif
  NULLIFY(grid%ctopo)
ENDIF
IF ( ASSOCIATED( grid%dlg_bep ) ) THEN 
  DEALLOCATE(grid%dlg_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dlg_bep. ')
 endif
  NULLIFY(grid%dlg_bep)
ENDIF
IF ( ASSOCIATED( grid%wq_tur ) ) THEN 
  DEALLOCATE(grid%wq_tur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wq_tur. ')
 endif
  NULLIFY(grid%wq_tur)
ENDIF
IF ( ASSOCIATED( grid%cfracm ) ) THEN 
  DEALLOCATE(grid%cfracm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cfracm. ')
 endif
  NULLIFY(grid%cfracm)
ENDIF
IF ( ASSOCIATED( grid%aeromcu ) ) THEN 
  DEALLOCATE(grid%aeromcu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aeromcu. ')
 endif
  NULLIFY(grid%aeromcu)
ENDIF
IF ( ASSOCIATED( grid%qndropsource ) ) THEN 
  DEALLOCATE(grid%qndropsource,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qndropsource. ')
 endif
  NULLIFY(grid%qndropsource)
ENDIF
IF ( ASSOCIATED( grid%slopesfc ) ) THEN 
  DEALLOCATE(grid%slopesfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slopesfc. ')
 endif
  NULLIFY(grid%slopesfc)
ENDIF
IF ( ASSOCIATED( grid%updfra_cup ) ) THEN 
  DEALLOCATE(grid%updfra_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%updfra_cup. ')
 endif
  NULLIFY(grid%updfra_cup)
ENDIF
IF ( ASSOCIATED( grid%fcvt_qc_to_qi_cup ) ) THEN 
  DEALLOCATE(grid%fcvt_qc_to_qi_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcvt_qc_to_qi_cup. ')
 endif
  NULLIFY(grid%fcvt_qc_to_qi_cup)
ENDIF
IF ( ASSOCIATED( grid%msfty ) ) THEN 
  DEALLOCATE(grid%msfty,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfty. ')
 endif
  NULLIFY(grid%msfty)
ENDIF
IF ( ASSOCIATED( grid%ht_int ) ) THEN 
  DEALLOCATE(grid%ht_int,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_int. ')
 endif
  NULLIFY(grid%ht_int)
ENDIF
IF ( ASSOCIATED( grid%u_base ) ) THEN 
  DEALLOCATE(grid%u_base,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_base. ')
 endif
  NULLIFY(grid%u_base)
ENDIF
IF ( ASSOCIATED( grid%acphysc ) ) THEN 
  DEALLOCATE(grid%acphysc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphysc. ')
 endif
  NULLIFY(grid%acphysc)
ENDIF
IF ( ASSOCIATED( grid%tlwup ) ) THEN 
  DEALLOCATE(grid%tlwup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tlwup. ')
 endif
  NULLIFY(grid%tlwup)
ENDIF
IF ( ASSOCIATED( grid%rqvshten ) ) THEN 
  DEALLOCATE(grid%rqvshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqvshten. ')
 endif
  NULLIFY(grid%rqvshten)
ENDIF
IF ( ASSOCIATED( grid%ca_rad ) ) THEN 
  DEALLOCATE(grid%ca_rad,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ca_rad. ')
 endif
  NULLIFY(grid%ca_rad)
ENDIF
IF ( ASSOCIATED( grid%ltopb ) ) THEN 
  DEALLOCATE(grid%ltopb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ltopb. ')
 endif
  NULLIFY(grid%ltopb)
ENDIF
IF ( ASSOCIATED( grid%rqccuten ) ) THEN 
  DEALLOCATE(grid%rqccuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqccuten. ')
 endif
  NULLIFY(grid%rqccuten)
ENDIF
IF ( ASSOCIATED( grid%i_rainnc ) ) THEN 
  DEALLOCATE(grid%i_rainnc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_rainnc. ')
 endif
  NULLIFY(grid%i_rainnc)
ENDIF
IF ( ASSOCIATED( grid%hailncv ) ) THEN 
  DEALLOCATE(grid%hailncv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailncv. ')
 endif
  NULLIFY(grid%hailncv)
ENDIF
IF ( ASSOCIATED( grid%phii3d_2 ) ) THEN 
  DEALLOCATE(grid%phii3d_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%phii3d_2. ')
 endif
  NULLIFY(grid%phii3d_2)
ENDIF
IF ( ASSOCIATED( grid%cldfra_sh ) ) THEN 
  DEALLOCATE(grid%cldfra_sh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_sh. ')
 endif
  NULLIFY(grid%cldfra_sh)
ENDIF
IF ( ASSOCIATED( grid%apr_capme ) ) THEN 
  DEALLOCATE(grid%apr_capme,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%apr_capme. ')
 endif
  NULLIFY(grid%apr_capme)
ENDIF
IF ( ASSOCIATED( grid%cugd_tten ) ) THEN 
  DEALLOCATE(grid%cugd_tten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cugd_tten. ')
 endif
  NULLIFY(grid%cugd_tten)
ENDIF
IF ( ASSOCIATED( grid%qc_cu ) ) THEN 
  DEALLOCATE(grid%qc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_cu. ')
 endif
  NULLIFY(grid%qc_cu)
ENDIF
IF ( ASSOCIATED( grid%efcg ) ) THEN 
  DEALLOCATE(grid%efcg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efcg. ')
 endif
  NULLIFY(grid%efcg)
ENDIF
IF ( ASSOCIATED( grid%qc_bl ) ) THEN 
  DEALLOCATE(grid%qc_bl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_bl. ')
 endif
  NULLIFY(grid%qc_bl)
ENDIF
IF ( ASSOCIATED( grid%convcld ) ) THEN 
  DEALLOCATE(grid%convcld,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%convcld. ')
 endif
  NULLIFY(grid%convcld)
ENDIF
IF ( ASSOCIATED( grid%diffuse_frac ) ) THEN 
  DEALLOCATE(grid%diffuse_frac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%diffuse_frac. ')
 endif
  NULLIFY(grid%diffuse_frac)
ENDIF
IF ( ASSOCIATED( grid%gg ) ) THEN 
  DEALLOCATE(grid%gg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%gg. ')
 endif
  NULLIFY(grid%gg)
ENDIF
IF ( ASSOCIATED( grid%t2min ) ) THEN 
  DEALLOCATE(grid%t2min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2min. ')
 endif
  NULLIFY(grid%t2min)
ENDIF
IF ( ASSOCIATED( grid%skintempmin ) ) THEN 
  DEALLOCATE(grid%skintempmin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%skintempmin. ')
 endif
  NULLIFY(grid%skintempmin)
ENDIF
IF ( ASSOCIATED( grid%spduv10mean ) ) THEN 
  DEALLOCATE(grid%spduv10mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spduv10mean. ')
 endif
  NULLIFY(grid%spduv10mean)
ENDIF
IF ( ASSOCIATED( grid%aclwdntc ) ) THEN 
  DEALLOCATE(grid%aclwdntc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwdntc. ')
 endif
  NULLIFY(grid%aclwdntc)
ENDIF
IF ( ASSOCIATED( grid%i_acswdnbc ) ) THEN 
  DEALLOCATE(grid%i_acswdnbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_acswdnbc. ')
 endif
  NULLIFY(grid%i_acswdnbc)
ENDIF
IF ( ASSOCIATED( grid%swdnt ) ) THEN 
  DEALLOCATE(grid%swdnt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnt. ')
 endif
  NULLIFY(grid%swdnt)
ENDIF
IF ( ASSOCIATED( grid%lwdnt ) ) THEN 
  DEALLOCATE(grid%lwdnt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdnt. ')
 endif
  NULLIFY(grid%lwdnt)
ENDIF
IF ( ASSOCIATED( grid%xlat_u ) ) THEN 
  DEALLOCATE(grid%xlat_u,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlat_u. ')
 endif
  NULLIFY(grid%xlat_u)
ENDIF
IF ( ASSOCIATED( grid%tsk_mosaic ) ) THEN 
  DEALLOCATE(grid%tsk_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_mosaic. ')
 endif
  NULLIFY(grid%tsk_mosaic)
ENDIF
IF ( ASSOCIATED( grid%embck_mosaic ) ) THEN 
  DEALLOCATE(grid%embck_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%embck_mosaic. ')
 endif
  NULLIFY(grid%embck_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tg_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%tg_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tg_urb2d_mosaic. ')
 endif
  NULLIFY(grid%tg_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%rn_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%rn_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rn_urb2d_mosaic. ')
 endif
  NULLIFY(grid%rn_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%tdly ) ) THEN 
  DEALLOCATE(grid%tdly,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tdly. ')
 endif
  NULLIFY(grid%tdly)
ENDIF
IF ( ASSOCIATED( grid%ustm ) ) THEN 
  DEALLOCATE(grid%ustm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ustm. ')
 endif
  NULLIFY(grid%ustm)
ENDIF
IF ( ASSOCIATED( grid%aclhf ) ) THEN 
  DEALLOCATE(grid%aclhf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclhf. ')
 endif
  NULLIFY(grid%aclhf)
ENDIF
IF ( ASSOCIATED( grid%regime ) ) THEN 
  DEALLOCATE(grid%regime,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%regime. ')
 endif
  NULLIFY(grid%regime)
ENDIF
IF ( ASSOCIATED( grid%defor11 ) ) THEN 
  DEALLOCATE(grid%defor11,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%defor11. ')
 endif
  NULLIFY(grid%defor11)
ENDIF
IF ( ASSOCIATED( grid%u10_ndg_old ) ) THEN 
  DEALLOCATE(grid%u10_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10_ndg_old. ')
 endif
  NULLIFY(grid%u10_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%psl_ndg_old ) ) THEN 
  DEALLOCATE(grid%psl_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psl_ndg_old. ')
 endif
  NULLIFY(grid%psl_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%qnorm ) ) THEN 
  DEALLOCATE(grid%qnorm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnorm. ')
 endif
  NULLIFY(grid%qnorm)
ENDIF
IF ( ASSOCIATED( grid%wspd10max ) ) THEN 
  DEALLOCATE(grid%wspd10max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wspd10max. ')
 endif
  NULLIFY(grid%wspd10max)
ENDIF
IF ( ASSOCIATED( grid%hail_max2d ) ) THEN 
  DEALLOCATE(grid%hail_max2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hail_max2d. ')
 endif
  NULLIFY(grid%hail_max2d)
ENDIF
IF ( ASSOCIATED( grid%hvml ) ) THEN 
  DEALLOCATE(grid%hvml,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hvml. ')
 endif
  NULLIFY(grid%hvml)
ENDIF
IF ( ASSOCIATED( grid%track_qcloud ) ) THEN 
  DEALLOCATE(grid%track_qcloud,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_qcloud. ')
 endif
  NULLIFY(grid%track_qcloud)
ENDIF
IF ( ASSOCIATED( grid%athcuten ) ) THEN 
  DEALLOCATE(grid%athcuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athcuten. ')
 endif
  NULLIFY(grid%athcuten)
ENDIF
IF ( ASSOCIATED( grid%athratenlw ) ) THEN 
  DEALLOCATE(grid%athratenlw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%athratenlw. ')
 endif
  NULLIFY(grid%athratenlw)
ENDIF
IF ( ASSOCIATED( grid%hailcast_dhail5 ) ) THEN 
  DEALLOCATE(grid%hailcast_dhail5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_dhail5. ')
 endif
  NULLIFY(grid%hailcast_dhail5)
ENDIF
IF ( ASSOCIATED( grid%cg_flashrate ) ) THEN 
  DEALLOCATE(grid%cg_flashrate,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cg_flashrate. ')
 endif
  NULLIFY(grid%cg_flashrate)
ENDIF
IF ( ASSOCIATED( grid%iccg_in_den ) ) THEN 
  DEALLOCATE(grid%iccg_in_den,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iccg_in_den. ')
 endif
  NULLIFY(grid%iccg_in_den)
ENDIF
IF ( ASSOCIATED( grid%clat_xxx ) ) THEN 
  DEALLOCATE(grid%clat_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%clat_xxx. ')
 endif
  NULLIFY(grid%clat_xxx)
ENDIF
IF ( ASSOCIATED( grid%rthfrten ) ) THEN 
  DEALLOCATE(grid%rthfrten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rthfrten. ')
 endif
  NULLIFY(grid%rthfrten)
ENDIF
IF ( ASSOCIATED( grid%lfn_0 ) ) THEN 
  DEALLOCATE(grid%lfn_0,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_0. ')
 endif
  NULLIFY(grid%lfn_0)
ENDIF
IF ( ASSOCIATED( grid%fgrnqfx ) ) THEN 
  DEALLOCATE(grid%fgrnqfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fgrnqfx. ')
 endif
  NULLIFY(grid%fgrnqfx)
ENDIF
IF ( ASSOCIATED( grid%fmc_lag ) ) THEN 
  DEALLOCATE(grid%fmc_lag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fmc_lag. ')
 endif
  NULLIFY(grid%fmc_lag)
ENDIF
IF ( ASSOCIATED( grid%ischap ) ) THEN 
  DEALLOCATE(grid%ischap,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ischap. ')
 endif
  NULLIFY(grid%ischap)
ENDIF
IF ( ASSOCIATED( grid%fs_spotting_lkhd ) ) THEN 
  DEALLOCATE(grid%fs_spotting_lkhd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_spotting_lkhd. ')
 endif
  NULLIFY(grid%fs_spotting_lkhd)
ENDIF
IF ( ASSOCIATED( grid%avgflx_rum ) ) THEN 
  DEALLOCATE(grid%avgflx_rum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_rum. ')
 endif
  NULLIFY(grid%avgflx_rum)
ENDIF
IF ( ASSOCIATED( grid%dfu1 ) ) THEN 
  DEALLOCATE(grid%dfu1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfu1. ')
 endif
  NULLIFY(grid%dfu1)
ENDIF
IF ( ASSOCIATED( grid%rv_tendf_stoch ) ) THEN 
  DEALLOCATE(grid%rv_tendf_stoch,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rv_tendf_stoch. ')
 endif
  NULLIFY(grid%rv_tendf_stoch)
ENDIF
IF ( ASSOCIATED( grid%sptforcc ) ) THEN 
  DEALLOCATE(grid%sptforcc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sptforcc. ')
 endif
  NULLIFY(grid%sptforcc)
ENDIF
IF ( ASSOCIATED( grid%spforcc4 ) ) THEN 
  DEALLOCATE(grid%spforcc4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcc4. ')
 endif
  NULLIFY(grid%spforcc4)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_skebs ) ) THEN 
  DEALLOCATE(grid%iseedarr_skebs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_skebs. ')
 endif
  NULLIFY(grid%iseedarr_skebs)
ENDIF
IF ( ASSOCIATED( grid%spforcs3d ) ) THEN 
  DEALLOCATE(grid%spforcs3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spforcs3d. ')
 endif
  NULLIFY(grid%spforcs3d)
ENDIF
IF ( ASSOCIATED( grid%qpert2d ) ) THEN 
  DEALLOCATE(grid%qpert2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qpert2d. ')
 endif
  NULLIFY(grid%qpert2d)
ENDIF
IF ( ASSOCIATED( grid%evaptzm ) ) THEN 
  DEALLOCATE(grid%evaptzm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evaptzm. ')
 endif
  NULLIFY(grid%evaptzm)
ENDIF
IF ( ASSOCIATED( grid%pconvt ) ) THEN 
  DEALLOCATE(grid%pconvt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pconvt. ')
 endif
  NULLIFY(grid%pconvt)
ENDIF
IF ( ASSOCIATED( grid%zmicvu ) ) THEN 
  DEALLOCATE(grid%zmicvu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmicvu. ')
 endif
  NULLIFY(grid%zmicvu)
ENDIF
IF ( ASSOCIATED( grid%ideep2d ) ) THEN 
  DEALLOCATE(grid%ideep2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ideep2d. ')
 endif
  NULLIFY(grid%ideep2d)
ENDIF
IF ( ASSOCIATED( grid%snowsh ) ) THEN 
  DEALLOCATE(grid%snowsh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowsh. ')
 endif
  NULLIFY(grid%snowsh)
ENDIF
IF ( ASSOCIATED( grid%vten_cu ) ) THEN 
  DEALLOCATE(grid%vten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vten_cu. ')
 endif
  NULLIFY(grid%vten_cu)
ENDIF
IF ( ASSOCIATED( grid%pbup_cu ) ) THEN 
  DEALLOCATE(grid%pbup_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pbup_cu. ')
 endif
  NULLIFY(grid%pbup_cu)
ENDIF
IF ( ASSOCIATED( grid%rlwp_cu ) ) THEN 
  DEALLOCATE(grid%rlwp_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rlwp_cu. ')
 endif
  NULLIFY(grid%rlwp_cu)
ENDIF
IF ( ASSOCIATED( grid%uu_emf_cu ) ) THEN 
  DEALLOCATE(grid%uu_emf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%uu_emf_cu. ')
 endif
  NULLIFY(grid%uu_emf_cu)
ENDIF
IF ( ASSOCIATED( grid%qrten_cu ) ) THEN 
  DEALLOCATE(grid%qrten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qrten_cu. ')
 endif
  NULLIFY(grid%qrten_cu)
ENDIF
IF ( ASSOCIATED( grid%bogbot_cu ) ) THEN 
  DEALLOCATE(grid%bogbot_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bogbot_cu. ')
 endif
  NULLIFY(grid%bogbot_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_rei_cu ) ) THEN 
  DEALLOCATE(grid%exit_rei_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_rei_cu. ')
 endif
  NULLIFY(grid%exit_rei_cu)
ENDIF
IF ( ASSOCIATED( grid%lcd_old_mp ) ) THEN 
  DEALLOCATE(grid%lcd_old_mp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lcd_old_mp. ')
 endif
  NULLIFY(grid%lcd_old_mp)
ENDIF
IF ( ASSOCIATED( grid%sabv ) ) THEN 
  DEALLOCATE(grid%sabv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sabv. ')
 endif
  NULLIFY(grid%sabv)
ENDIF
IF ( ASSOCIATED( grid%t_veg ) ) THEN 
  DEALLOCATE(grid%t_veg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_veg. ')
 endif
  NULLIFY(grid%t_veg)
ENDIF
IF ( ASSOCIATED( grid%h2ocan_col ) ) THEN 
  DEALLOCATE(grid%h2ocan_col,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2ocan_col. ')
 endif
  NULLIFY(grid%h2ocan_col)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq2 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq2. ')
 endif
  NULLIFY(grid%h2osoi_liq2)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice_s4 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice_s4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice_s4. ')
 endif
  NULLIFY(grid%h2osoi_ice_s4)
ENDIF
IF ( ASSOCIATED( grid%t_soisno_s1 ) ) THEN 
  DEALLOCATE(grid%t_soisno_s1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno_s1. ')
 endif
  NULLIFY(grid%t_soisno_s1)
ENDIF
IF ( ASSOCIATED( grid%t_soisno8 ) ) THEN 
  DEALLOCATE(grid%t_soisno8,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno8. ')
 endif
  NULLIFY(grid%t_soisno8)
ENDIF
IF ( ASSOCIATED( grid%snowrds5 ) ) THEN 
  DEALLOCATE(grid%snowrds5,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowrds5. ')
 endif
  NULLIFY(grid%snowrds5)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol2 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol2. ')
 endif
  NULLIFY(grid%h2osoi_vol2)
ENDIF
IF ( ASSOCIATED( grid%lwupsubgrid ) ) THEN 
  DEALLOCATE(grid%lwupsubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwupsubgrid. ')
 endif
  NULLIFY(grid%lwupsubgrid)
ENDIF
IF ( ASSOCIATED( grid%t_grnd2d ) ) THEN 
  DEALLOCATE(grid%t_grnd2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_grnd2d. ')
 endif
  NULLIFY(grid%t_grnd2d)
ENDIF
IF ( ASSOCIATED( grid%watsat3d ) ) THEN 
  DEALLOCATE(grid%watsat3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%watsat3d. ')
 endif
  NULLIFY(grid%watsat3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_cm ) ) THEN 
  DEALLOCATE(grid%ssib_cm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_cm. ')
 endif
  NULLIFY(grid%ssib_cm)
ENDIF
IF ( ASSOCIATED( grid%ssib_sup ) ) THEN 
  DEALLOCATE(grid%ssib_sup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_sup. ')
 endif
  NULLIFY(grid%ssib_sup)
ENDIF
IF ( ASSOCIATED( grid%snowden ) ) THEN 
  DEALLOCATE(grid%snowden,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snowden. ')
 endif
  NULLIFY(grid%snowden)
ENDIF
IF ( ASSOCIATED( grid%bio1 ) ) THEN 
  DEALLOCATE(grid%bio1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bio1. ')
 endif
  NULLIFY(grid%bio1)
ENDIF
IF ( ASSOCIATED( grid%bio2 ) ) THEN 
  DEALLOCATE(grid%bio2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bio2. ')
 endif
  NULLIFY(grid%bio2)
ENDIF
IF ( ASSOCIATED( grid%bio3 ) ) THEN 
  DEALLOCATE(grid%bio3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bio3. ')
 endif
  NULLIFY(grid%bio3)
ENDIF
IF ( ASSOCIATED( grid%bio4 ) ) THEN 
  DEALLOCATE(grid%bio4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%bio4. ')
 endif
  NULLIFY(grid%bio4)
ENDIF
IF ( ASSOCIATED( grid%fwetxy ) ) THEN 
  DEALLOCATE(grid%fwetxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fwetxy. ')
 endif
  NULLIFY(grid%fwetxy)
ENDIF
IF ( ASSOCIATED( grid%snliqxy ) ) THEN 
  DEALLOCATE(grid%snliqxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%snliqxy. ')
 endif
  NULLIFY(grid%snliqxy)
ENDIF
IF ( ASSOCIATED( grid%q2mbxy ) ) THEN 
  DEALLOCATE(grid%q2mbxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q2mbxy. ')
 endif
  NULLIFY(grid%q2mbxy)
ENDIF
IF ( ASSOCIATED( grid%fsaxy ) ) THEN 
  DEALLOCATE(grid%fsaxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fsaxy. ')
 endif
  NULLIFY(grid%fsaxy)
ENDIF
IF ( ASSOCIATED( grid%chvxy ) ) THEN 
  DEALLOCATE(grid%chvxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chvxy. ')
 endif
  NULLIFY(grid%chvxy)
ENDIF
IF ( ASSOCIATED( grid%trxy ) ) THEN 
  DEALLOCATE(grid%trxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%trxy. ')
 endif
  NULLIFY(grid%trxy)
ENDIF
IF ( ASSOCIATED( grid%areaxy ) ) THEN 
  DEALLOCATE(grid%areaxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%areaxy. ')
 endif
  NULLIFY(grid%areaxy)
ENDIF
IF ( ASSOCIATED( grid%eqzwt ) ) THEN 
  DEALLOCATE(grid%eqzwt,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%eqzwt. ')
 endif
  NULLIFY(grid%eqzwt)
ENDIF
IF ( ASSOCIATED( grid%qfrocxy ) ) THEN 
  DEALLOCATE(grid%qfrocxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qfrocxy. ')
 endif
  NULLIFY(grid%qfrocxy)
ENDIF
IF ( ASSOCIATED( grid%canhsxy ) ) THEN 
  DEALLOCATE(grid%canhsxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%canhsxy. ')
 endif
  NULLIFY(grid%canhsxy)
ENDIF
IF ( ASSOCIATED( grid%acthror ) ) THEN 
  DEALLOCATE(grid%acthror,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acthror. ')
 endif
  NULLIFY(grid%acthror)
ENDIF
IF ( ASSOCIATED( grid%acetran ) ) THEN 
  DEALLOCATE(grid%acetran,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acetran. ')
 endif
  NULLIFY(grid%acetran)
ENDIF
IF ( ASSOCIATED( grid%acponding ) ) THEN 
  DEALLOCATE(grid%acponding,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acponding. ')
 endif
  NULLIFY(grid%acponding)
ENDIF
IF ( ASSOCIATED( grid%acsagv ) ) THEN 
  DEALLOCATE(grid%acsagv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsagv. ')
 endif
  NULLIFY(grid%acsagv)
ENDIF
IF ( ASSOCIATED( grid%acswdnlsm ) ) THEN 
  DEALLOCATE(grid%acswdnlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswdnlsm. ')
 endif
  NULLIFY(grid%acswdnlsm)
ENDIF
IF ( ASSOCIATED( grid%acc_qinsur ) ) THEN 
  DEALLOCATE(grid%acc_qinsur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_qinsur. ')
 endif
  NULLIFY(grid%acc_qinsur)
ENDIF
IF ( ASSOCIATED( grid%croptype ) ) THEN 
  DEALLOCATE(grid%croptype,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%croptype. ')
 endif
  NULLIFY(grid%croptype)
ENDIF
IF ( ASSOCIATED( grid%fifract ) ) THEN 
  DEALLOCATE(grid%fifract,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fifract. ')
 endif
  NULLIFY(grid%fifract)
ENDIF
IF ( ASSOCIATED( grid%kext_ql ) ) THEN 
  DEALLOCATE(grid%kext_ql,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ql. ')
 endif
  NULLIFY(grid%kext_ql)
ENDIF
IF ( ASSOCIATED( grid%kext_ft_qg ) ) THEN 
  DEALLOCATE(grid%kext_ft_qg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_ft_qg. ')
 endif
  NULLIFY(grid%kext_ft_qg)
ENDIF
IF ( ASSOCIATED( grid%radarvil ) ) THEN 
  DEALLOCATE(grid%radarvil,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%radarvil. ')
 endif
  NULLIFY(grid%radarvil)
ENDIF
IF ( ASSOCIATED( grid%afwa_heatidx ) ) THEN 
  DEALLOCATE(grid%afwa_heatidx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_heatidx. ')
 endif
  NULLIFY(grid%afwa_heatidx)
ENDIF
IF ( ASSOCIATED( grid%afwa_rain ) ) THEN 
  DEALLOCATE(grid%afwa_rain,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_rain. ')
 endif
  NULLIFY(grid%afwa_rain)
ENDIF
IF ( ASSOCIATED( grid%afwa_cape_mu ) ) THEN 
  DEALLOCATE(grid%afwa_cape_mu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_cape_mu. ')
 endif
  NULLIFY(grid%afwa_cape_mu)
ENDIF
IF ( ASSOCIATED( grid%tornado_dur ) ) THEN 
  DEALLOCATE(grid%tornado_dur,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tornado_dur. ')
 endif
  NULLIFY(grid%tornado_dur)
ENDIF
IF ( ASSOCIATED( grid%tsk_mean ) ) THEN 
  DEALLOCATE(grid%tsk_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_mean. ')
 endif
  NULLIFY(grid%tsk_mean)
ENDIF
IF ( ASSOCIATED( grid%swupb_mean ) ) THEN 
  DEALLOCATE(grid%swupb_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupb_mean. ')
 endif
  NULLIFY(grid%swupb_mean)
ENDIF
IF ( ASSOCIATED( grid%u10_diurn ) ) THEN 
  DEALLOCATE(grid%u10_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10_diurn. ')
 endif
  NULLIFY(grid%u10_diurn)
ENDIF
IF ( ASSOCIATED( grid%glw_dtmp ) ) THEN 
  DEALLOCATE(grid%glw_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%glw_dtmp. ')
 endif
  NULLIFY(grid%glw_dtmp)
ENDIF
IF ( ASSOCIATED( grid%elecmag ) ) THEN 
  DEALLOCATE(grid%elecmag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%elecmag. ')
 endif
  NULLIFY(grid%elecmag)
ENDIF
IF ( ASSOCIATED( grid%pc_btxs ) ) THEN 
  DEALLOCATE(grid%pc_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_btxs. ')
 endif
  NULLIFY(grid%pc_btxs)
ENDIF
IF ( ASSOCIATED( grid%pc_btxe ) ) THEN 
  DEALLOCATE(grid%pc_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_btxe. ')
 endif
  NULLIFY(grid%pc_btxe)
ENDIF
IF ( ASSOCIATED( grid%pc_btys ) ) THEN 
  DEALLOCATE(grid%pc_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_btys. ')
 endif
  NULLIFY(grid%pc_btys)
ENDIF
IF ( ASSOCIATED( grid%pc_btye ) ) THEN 
  DEALLOCATE(grid%pc_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pc_btye. ')
 endif
  NULLIFY(grid%pc_btye)
ENDIF
IF ( ASSOCIATED( grid%p_wif_mar ) ) THEN 
  DEALLOCATE(grid%p_wif_mar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_mar. ')
 endif
  NULLIFY(grid%p_wif_mar)
ENDIF
IF ( ASSOCIATED( grid%w_wif_feb ) ) THEN 
  DEALLOCATE(grid%w_wif_feb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_feb. ')
 endif
  NULLIFY(grid%w_wif_feb)
ENDIF
IF ( ASSOCIATED( grid%i_wif_jan ) ) THEN 
  DEALLOCATE(grid%i_wif_jan,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_jan. ')
 endif
  NULLIFY(grid%i_wif_jan)
ENDIF
IF ( ASSOCIATED( grid%b_wif_now ) ) THEN 
  DEALLOCATE(grid%b_wif_now,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_now. ')
 endif
  NULLIFY(grid%b_wif_now)
ENDIF
IF ( ASSOCIATED( grid%b_wif_dec ) ) THEN 
  DEALLOCATE(grid%b_wif_dec,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_dec. ')
 endif
  NULLIFY(grid%b_wif_dec)
ENDIF
IF ( ASSOCIATED( grid%tpw ) ) THEN 
  DEALLOCATE(grid%tpw,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tpw. ')
 endif
  NULLIFY(grid%tpw)
ENDIF
IF ( ASSOCIATED( grid%lwp_tot ) ) THEN 
  DEALLOCATE(grid%lwp_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwp_tot. ')
 endif
  NULLIFY(grid%lwp_tot)
ENDIF
IF ( ASSOCIATED( grid%tau_qi_tot ) ) THEN 
  DEALLOCATE(grid%tau_qi_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tau_qi_tot. ')
 endif
  NULLIFY(grid%tau_qi_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_swp ) ) THEN 
  DEALLOCATE(grid%ts_swp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swp. ')
 endif
  NULLIFY(grid%ts_swp)
ENDIF
IF ( ASSOCIATED( grid%ts_tau_qs ) ) THEN 
  DEALLOCATE(grid%ts_tau_qs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tau_qs. ')
 endif
  NULLIFY(grid%ts_tau_qs)
ENDIF
IF ( ASSOCIATED( grid%ts_swddif ) ) THEN 
  DEALLOCATE(grid%ts_swddif,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddif. ')
 endif
  NULLIFY(grid%ts_swddif)
ENDIF
IF ( ASSOCIATED( grid%q_pl ) ) THEN 
  DEALLOCATE(grid%q_pl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q_pl. ')
 endif
  NULLIFY(grid%q_pl)
ENDIF
IF ( ASSOCIATED( grid%ght_zl ) ) THEN 
  DEALLOCATE(grid%ght_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ght_zl. ')
 endif
  NULLIFY(grid%ght_zl)
ENDIF
IF ( ASSOCIATED( grid%coszr ) ) THEN 
  DEALLOCATE(grid%coszr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%coszr. ')
 endif
  NULLIFY(grid%coszr)
ENDIF
IF ( ASSOCIATED( grid%mcm_qv_tend ) ) THEN 
  DEALLOCATE(grid%mcm_qv_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_qv_tend. ')
 endif
  NULLIFY(grid%mcm_qv_tend)
ENDIF
IF ( ASSOCIATED( grid%mcm_tau13_c ) ) THEN 
  DEALLOCATE(grid%mcm_tau13_c,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_tau13_c. ')
 endif
  NULLIFY(grid%mcm_tau13_c)
ENDIF
IF ( ASSOCIATED( grid%m_pblh ) ) THEN 
  DEALLOCATE(grid%m_pblh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%m_pblh. ')
 endif
  NULLIFY(grid%m_pblh)
ENDIF
IF ( ASSOCIATED( grid%chem ) ) THEN 
  DEALLOCATE(grid%chem,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chem. ')
 endif
  NULLIFY(grid%chem)
ENDIF
END SUBROUTINE deallocs_6
!ENDOFREGISTRYGENERATEDINCLUDE
