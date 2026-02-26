!STARTOFREGISTRYGENERATEDINCLUDE 'inc/deallocs_8.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE deallocs_8( grid )
  USE module_wrf_error
  USE module_domain_type
  IMPLICIT NONE
  TYPE( domain ), POINTER :: grid
  INTEGER :: ierr
IF ( ASSOCIATED( grid%traj_i ) ) THEN 
  DEALLOCATE(grid%traj_i,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%traj_i. ')
 endif
  NULLIFY(grid%traj_i)
ENDIF
IF ( ASSOCIATED( grid%xlat_gc ) ) THEN 
  DEALLOCATE(grid%xlat_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlat_gc. ')
 endif
  NULLIFY(grid%xlat_gc)
ENDIF
IF ( ASSOCIATED( grid%albedo12m ) ) THEN 
  DEALLOCATE(grid%albedo12m,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%albedo12m. ')
 endif
  NULLIFY(grid%albedo12m)
ENDIF
IF ( ASSOCIATED( grid%icepct ) ) THEN 
  DEALLOCATE(grid%icepct,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%icepct. ')
 endif
  NULLIFY(grid%icepct)
ENDIF
IF ( ASSOCIATED( grid%qnh_gc ) ) THEN 
  DEALLOCATE(grid%qnh_gc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qnh_gc. ')
 endif
  NULLIFY(grid%qnh_gc)
ENDIF
IF ( ASSOCIATED( grid%pmaxwnn ) ) THEN 
  DEALLOCATE(grid%pmaxwnn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pmaxwnn. ')
 endif
  NULLIFY(grid%pmaxwnn)
ENDIF
IF ( ASSOCIATED( grid%u_1 ) ) THEN 
  DEALLOCATE(grid%u_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_1. ')
 endif
  NULLIFY(grid%u_1)
ENDIF
IF ( ASSOCIATED( grid%u_2 ) ) THEN 
  DEALLOCATE(grid%u_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_2. ')
 endif
  NULLIFY(grid%u_2)
ENDIF
IF ( ASSOCIATED( grid%v_1 ) ) THEN 
  DEALLOCATE(grid%v_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_1. ')
 endif
  NULLIFY(grid%v_1)
ENDIF
IF ( ASSOCIATED( grid%v_2 ) ) THEN 
  DEALLOCATE(grid%v_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_2. ')
 endif
  NULLIFY(grid%v_2)
ENDIF
IF ( ASSOCIATED( grid%w_btxs ) ) THEN 
  DEALLOCATE(grid%w_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_btxs. ')
 endif
  NULLIFY(grid%w_btxs)
ENDIF
IF ( ASSOCIATED( grid%w_btxe ) ) THEN 
  DEALLOCATE(grid%w_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_btxe. ')
 endif
  NULLIFY(grid%w_btxe)
ENDIF
IF ( ASSOCIATED( grid%w_btys ) ) THEN 
  DEALLOCATE(grid%w_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_btys. ')
 endif
  NULLIFY(grid%w_btys)
ENDIF
IF ( ASSOCIATED( grid%w_btye ) ) THEN 
  DEALLOCATE(grid%w_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_btye. ')
 endif
  NULLIFY(grid%w_btye)
ENDIF
IF ( ASSOCIATED( grid%w_subs_tend ) ) THEN 
  DEALLOCATE(grid%w_subs_tend,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_subs_tend. ')
 endif
  NULLIFY(grid%w_subs_tend)
ENDIF
IF ( ASSOCIATED( grid%t_1 ) ) THEN 
  DEALLOCATE(grid%t_1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_1. ')
 endif
  NULLIFY(grid%t_1)
ENDIF
IF ( ASSOCIATED( grid%t_2 ) ) THEN 
  DEALLOCATE(grid%t_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_2. ')
 endif
  NULLIFY(grid%t_2)
ENDIF
IF ( ASSOCIATED( grid%qv_upstream_x ) ) THEN 
  DEALLOCATE(grid%qv_upstream_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_upstream_x. ')
 endif
  NULLIFY(grid%qv_upstream_x)
ENDIF
IF ( ASSOCIATED( grid%v_upstream_x ) ) THEN 
  DEALLOCATE(grid%v_upstream_x,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v_upstream_x. ')
 endif
  NULLIFY(grid%v_upstream_x)
ENDIF
IF ( ASSOCIATED( grid%u_largescale ) ) THEN 
  DEALLOCATE(grid%u_largescale,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u_largescale. ')
 endif
  NULLIFY(grid%u_largescale)
ENDIF
IF ( ASSOCIATED( grid%q_soil_forcing_val ) ) THEN 
  DEALLOCATE(grid%q_soil_forcing_val,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%q_soil_forcing_val. ')
 endif
  NULLIFY(grid%q_soil_forcing_val)
ENDIF
IF ( ASSOCIATED( grid%mu_btxs ) ) THEN 
  DEALLOCATE(grid%mu_btxs,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_btxs. ')
 endif
  NULLIFY(grid%mu_btxs)
ENDIF
IF ( ASSOCIATED( grid%mu_btxe ) ) THEN 
  DEALLOCATE(grid%mu_btxe,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_btxe. ')
 endif
  NULLIFY(grid%mu_btxe)
ENDIF
IF ( ASSOCIATED( grid%mu_btys ) ) THEN 
  DEALLOCATE(grid%mu_btys,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_btys. ')
 endif
  NULLIFY(grid%mu_btys)
ENDIF
IF ( ASSOCIATED( grid%mu_btye ) ) THEN 
  DEALLOCATE(grid%mu_btye,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mu_btye. ')
 endif
  NULLIFY(grid%mu_btye)
ENDIF
IF ( ASSOCIATED( grid%dlk ) ) THEN 
  DEALLOCATE(grid%dlk,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dlk. ')
 endif
  NULLIFY(grid%dlk)
ENDIF
IF ( ASSOCIATED( grid%pb ) ) THEN 
  DEALLOCATE(grid%pb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pb. ')
 endif
  NULLIFY(grid%pb)
ENDIF
IF ( ASSOCIATED( grid%fnm ) ) THEN 
  DEALLOCATE(grid%fnm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fnm. ')
 endif
  NULLIFY(grid%fnm)
ENDIF
IF ( ASSOCIATED( grid%t2 ) ) THEN 
  DEALLOCATE(grid%t2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2. ')
 endif
  NULLIFY(grid%t2)
ENDIF
IF ( ASSOCIATED( grid%area2d ) ) THEN 
  DEALLOCATE(grid%area2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%area2d. ')
 endif
  NULLIFY(grid%area2d)
ENDIF
IF ( ASSOCIATED( grid%imask_ystag ) ) THEN 
  DEALLOCATE(grid%imask_ystag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%imask_ystag. ')
 endif
  NULLIFY(grid%imask_ystag)
ENDIF
IF ( ASSOCIATED( grid%qvold ) ) THEN 
  DEALLOCATE(grid%qvold,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qvold. ')
 endif
  NULLIFY(grid%qvold)
ENDIF
IF ( ASSOCIATED( grid%re_ice_gsfc ) ) THEN 
  DEALLOCATE(grid%re_ice_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%re_ice_gsfc. ')
 endif
  NULLIFY(grid%re_ice_gsfc)
ENDIF
IF ( ASSOCIATED( grid%dfi_re_hail_gsfc ) ) THEN 
  DEALLOCATE(grid%dfi_re_hail_gsfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_re_hail_gsfc. ')
 endif
  NULLIFY(grid%dfi_re_hail_gsfc)
ENDIF
IF ( ASSOCIATED( grid%st000007 ) ) THEN 
  DEALLOCATE(grid%st000007,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%st000007. ')
 endif
  NULLIFY(grid%st000007)
ENDIF
IF ( ASSOCIATED( grid%soilm040 ) ) THEN 
  DEALLOCATE(grid%soilm040,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilm040. ')
 endif
  NULLIFY(grid%soilm040)
ENDIF
IF ( ASSOCIATED( grid%soilw160 ) ) THEN 
  DEALLOCATE(grid%soilw160,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilw160. ')
 endif
  NULLIFY(grid%soilw160)
ENDIF
IF ( ASSOCIATED( grid%soilt300 ) ) THEN 
  DEALLOCATE(grid%soilt300,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilt300. ')
 endif
  NULLIFY(grid%soilt300)
ENDIF
IF ( ASSOCIATED( grid%soilcbot ) ) THEN 
  DEALLOCATE(grid%soilcbot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%soilcbot. ')
 endif
  NULLIFY(grid%soilcbot)
ENDIF
IF ( ASSOCIATED( grid%ts_psfc ) ) THEN 
  DEALLOCATE(grid%ts_psfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_psfc. ')
 endif
  NULLIFY(grid%ts_psfc)
ENDIF
IF ( ASSOCIATED( grid%ts_w_profile ) ) THEN 
  DEALLOCATE(grid%ts_w_profile,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_w_profile. ')
 endif
  NULLIFY(grid%ts_w_profile)
ENDIF
IF ( ASSOCIATED( grid%hgt_urb2d ) ) THEN 
  DEALLOCATE(grid%hgt_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hgt_urb2d. ')
 endif
  NULLIFY(grid%hgt_urb2d)
ENDIF
IF ( ASSOCIATED( grid%smstav ) ) THEN 
  DEALLOCATE(grid%smstav,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%smstav. ')
 endif
  NULLIFY(grid%smstav)
ENDIF
IF ( ASSOCIATED( grid%sfcevp ) ) THEN 
  DEALLOCATE(grid%sfcevp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfcevp. ')
 endif
  NULLIFY(grid%sfcevp)
ENDIF
IF ( ASSOCIATED( grid%dfi_p ) ) THEN 
  DEALLOCATE(grid%dfi_p,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_p. ')
 endif
  NULLIFY(grid%dfi_p)
ENDIF
IF ( ASSOCIATED( grid%dfi_ph ) ) THEN 
  DEALLOCATE(grid%dfi_ph,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_ph. ')
 endif
  NULLIFY(grid%dfi_ph)
ENDIF
IF ( ASSOCIATED( grid%tsk_rural ) ) THEN 
  DEALLOCATE(grid%tsk_rural,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tsk_rural. ')
 endif
  NULLIFY(grid%tsk_rural)
ENDIF
IF ( ASSOCIATED( grid%cmcr_urb2d ) ) THEN 
  DEALLOCATE(grid%cmcr_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cmcr_urb2d. ')
 endif
  NULLIFY(grid%cmcr_urb2d)
ENDIF
IF ( ASSOCIATED( grid%sh_urb2d ) ) THEN 
  DEALLOCATE(grid%sh_urb2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh_urb2d. ')
 endif
  NULLIFY(grid%sh_urb2d)
ENDIF
IF ( ASSOCIATED( grid%qlev_urb3d ) ) THEN 
  DEALLOCATE(grid%qlev_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qlev_urb3d. ')
 endif
  NULLIFY(grid%qlev_urb3d)
ENDIF
IF ( ASSOCIATED( grid%sfw1_urb3d ) ) THEN 
  DEALLOCATE(grid%sfw1_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfw1_urb3d. ')
 endif
  NULLIFY(grid%sfw1_urb3d)
ENDIF
IF ( ASSOCIATED( grid%sfrv_urb3d ) ) THEN 
  DEALLOCATE(grid%sfrv_urb3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sfrv_urb3d. ')
 endif
  NULLIFY(grid%sfrv_urb3d)
ENDIF
IF ( ASSOCIATED( grid%ecmask ) ) THEN 
  DEALLOCATE(grid%ecmask,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ecmask. ')
 endif
  NULLIFY(grid%ecmask)
ENDIF
IF ( ASSOCIATED( grid%keepfr3dflag ) ) THEN 
  DEALLOCATE(grid%keepfr3dflag,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%keepfr3dflag. ')
 endif
  NULLIFY(grid%keepfr3dflag)
ENDIF
IF ( ASSOCIATED( grid%vegf_px ) ) THEN 
  DEALLOCATE(grid%vegf_px,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%vegf_px. ')
 endif
  NULLIFY(grid%vegf_px)
ENDIF
IF ( ASSOCIATED( grid%exch_h ) ) THEN 
  DEALLOCATE(grid%exch_h,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exch_h. ')
 endif
  NULLIFY(grid%exch_h)
ENDIF
IF ( ASSOCIATED( grid%u10e ) ) THEN 
  DEALLOCATE(grid%u10e,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%u10e. ')
 endif
  NULLIFY(grid%u10e)
ENDIF
IF ( ASSOCIATED( grid%thl_up ) ) THEN 
  DEALLOCATE(grid%thl_up,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%thl_up. ')
 endif
  NULLIFY(grid%thl_up)
ENDIF
IF ( ASSOCIATED( grid%shf_temf ) ) THEN 
  DEALLOCATE(grid%shf_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shf_temf. ')
 endif
  NULLIFY(grid%shf_temf)
ENDIF
IF ( ASSOCIATED( grid%hct_temf ) ) THEN 
  DEALLOCATE(grid%hct_temf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hct_temf. ')
 endif
  NULLIFY(grid%hct_temf)
ENDIF
IF ( ASSOCIATED( grid%sh3d ) ) THEN 
  DEALLOCATE(grid%sh3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sh3d. ')
 endif
  NULLIFY(grid%sh3d)
ENDIF
IF ( ASSOCIATED( grid%det_sqv3d ) ) THEN 
  DEALLOCATE(grid%det_sqv3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%det_sqv3d. ')
 endif
  NULLIFY(grid%det_sqv3d)
ENDIF
IF ( ASSOCIATED( grid%var2d ) ) THEN 
  DEALLOCATE(grid%var2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%var2d. ')
 endif
  NULLIFY(grid%var2d)
ENDIF
IF ( ASSOCIATED( grid%dtaux3d_bl ) ) THEN 
  DEALLOCATE(grid%dtaux3d_bl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dtaux3d_bl. ')
 endif
  NULLIFY(grid%dtaux3d_bl)
ENDIF
IF ( ASSOCIATED( grid%dusfcg_fd ) ) THEN 
  DEALLOCATE(grid%dusfcg_fd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dusfcg_fd. ')
 endif
  NULLIFY(grid%dusfcg_fd)
ENDIF
IF ( ASSOCIATED( grid%var2dss ) ) THEN 
  DEALLOCATE(grid%var2dss,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%var2dss. ')
 endif
  NULLIFY(grid%var2dss)
ENDIF
IF ( ASSOCIATED( grid%a_u_bep ) ) THEN 
  DEALLOCATE(grid%a_u_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%a_u_bep. ')
 endif
  NULLIFY(grid%a_u_bep)
ENDIF
IF ( ASSOCIATED( grid%sf_bep ) ) THEN 
  DEALLOCATE(grid%sf_bep,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sf_bep. ')
 endif
  NULLIFY(grid%sf_bep)
ENDIF
IF ( ASSOCIATED( grid%hbot ) ) THEN 
  DEALLOCATE(grid%hbot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hbot. ')
 endif
  NULLIFY(grid%hbot)
ENDIF
IF ( ASSOCIATED( grid%acfrst ) ) THEN 
  DEALLOCATE(grid%acfrst,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acfrst. ')
 endif
  NULLIFY(grid%acfrst)
ENDIF
IF ( ASSOCIATED( grid%aerocu ) ) THEN 
  DEALLOCATE(grid%aerocu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aerocu. ')
 endif
  NULLIFY(grid%aerocu)
ENDIF
IF ( ASSOCIATED( grid%om_s ) ) THEN 
  DEALLOCATE(grid%om_s,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%om_s. ')
 endif
  NULLIFY(grid%om_s)
ENDIF
IF ( ASSOCIATED( grid%sigmasfc ) ) THEN 
  DEALLOCATE(grid%sigmasfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sigmasfc. ')
 endif
  NULLIFY(grid%sigmasfc)
ENDIF
IF ( ASSOCIATED( grid%qc_ic_cup ) ) THEN 
  DEALLOCATE(grid%qc_ic_cup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qc_ic_cup. ')
 endif
  NULLIFY(grid%qc_ic_cup)
ENDIF
IF ( ASSOCIATED( grid%tstar ) ) THEN 
  DEALLOCATE(grid%tstar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tstar. ')
 endif
  NULLIFY(grid%tstar)
ENDIF
IF ( ASSOCIATED( grid%msfuy ) ) THEN 
  DEALLOCATE(grid%msfuy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%msfuy. ')
 endif
  NULLIFY(grid%msfuy)
ENDIF
IF ( ASSOCIATED( grid%ht_smooth ) ) THEN 
  DEALLOCATE(grid%ht_smooth,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ht_smooth. ')
 endif
  NULLIFY(grid%ht_smooth)
ENDIF
IF ( ASSOCIATED( grid%qv_base ) ) THEN 
  DEALLOCATE(grid%qv_base,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qv_base. ')
 endif
  NULLIFY(grid%qv_base)
ENDIF
IF ( ASSOCIATED( grid%acphysd ) ) THEN 
  DEALLOCATE(grid%acphysd,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acphysd. ')
 endif
  NULLIFY(grid%acphysd)
ENDIF
IF ( ASSOCIATED( grid%slwup ) ) THEN 
  DEALLOCATE(grid%slwup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%slwup. ')
 endif
  NULLIFY(grid%slwup)
ENDIF
IF ( ASSOCIATED( grid%rqcshten ) ) THEN 
  DEALLOCATE(grid%rqcshten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqcshten. ')
 endif
  NULLIFY(grid%rqcshten)
ENDIF
IF ( ASSOCIATED( grid%cldliqa ) ) THEN 
  DEALLOCATE(grid%cldliqa,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldliqa. ')
 endif
  NULLIFY(grid%cldliqa)
ENDIF
IF ( ASSOCIATED( grid%kdcldbas ) ) THEN 
  DEALLOCATE(grid%kdcldbas,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kdcldbas. ')
 endif
  NULLIFY(grid%kdcldbas)
ENDIF
IF ( ASSOCIATED( grid%rqicuten ) ) THEN 
  DEALLOCATE(grid%rqicuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rqicuten. ')
 endif
  NULLIFY(grid%rqicuten)
ENDIF
IF ( ASSOCIATED( grid%pratesh ) ) THEN 
  DEALLOCATE(grid%pratesh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%pratesh. ')
 endif
  NULLIFY(grid%pratesh)
ENDIF
IF ( ASSOCIATED( grid%mskf_refl_10cm ) ) THEN 
  DEALLOCATE(grid%mskf_refl_10cm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mskf_refl_10cm. ')
 endif
  NULLIFY(grid%mskf_refl_10cm)
ENDIF
IF ( ASSOCIATED( grid%di3d_3 ) ) THEN 
  DEALLOCATE(grid%di3d_3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%di3d_3. ')
 endif
  NULLIFY(grid%di3d_3)
ENDIF
IF ( ASSOCIATED( grid%ddr_kf ) ) THEN 
  DEALLOCATE(grid%ddr_kf,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ddr_kf. ')
 endif
  NULLIFY(grid%ddr_kf)
ENDIF
IF ( ASSOCIATED( grid%edt_out ) ) THEN 
  DEALLOCATE(grid%edt_out,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%edt_out. ')
 endif
  NULLIFY(grid%edt_out)
ENDIF
IF ( ASSOCIATED( grid%cugd_ttens ) ) THEN 
  DEALLOCATE(grid%cugd_ttens,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cugd_ttens. ')
 endif
  NULLIFY(grid%cugd_ttens)
ENDIF
IF ( ASSOCIATED( grid%qr_cu ) ) THEN 
  DEALLOCATE(grid%qr_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qr_cu. ')
 endif
  NULLIFY(grid%qr_cu)
ENDIF
IF ( ASSOCIATED( grid%efsg ) ) THEN 
  DEALLOCATE(grid%efsg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%efsg. ')
 endif
  NULLIFY(grid%efsg)
ENDIF
IF ( ASSOCIATED( grid%cldfra_old ) ) THEN 
  DEALLOCATE(grid%cldfra_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_old. ')
 endif
  NULLIFY(grid%cldfra_old)
ENDIF
IF ( ASSOCIATED( grid%swddir2 ) ) THEN 
  DEALLOCATE(grid%swddir2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swddir2. ')
 endif
  NULLIFY(grid%swddir2)
ENDIF
IF ( ASSOCIATED( grid%coszen_ref ) ) THEN 
  DEALLOCATE(grid%coszen_ref,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%coszen_ref. ')
 endif
  NULLIFY(grid%coszen_ref)
ENDIF
IF ( ASSOCIATED( grid%tt2min ) ) THEN 
  DEALLOCATE(grid%tt2min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tt2min. ')
 endif
  NULLIFY(grid%tt2min)
ENDIF
IF ( ASSOCIATED( grid%tskintempmin ) ) THEN 
  DEALLOCATE(grid%tskintempmin,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tskintempmin. ')
 endif
  NULLIFY(grid%tskintempmin)
ENDIF
IF ( ASSOCIATED( grid%v10std ) ) THEN 
  DEALLOCATE(grid%v10std,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10std. ')
 endif
  NULLIFY(grid%v10std)
ENDIF
IF ( ASSOCIATED( grid%acswuptc ) ) THEN 
  DEALLOCATE(grid%acswuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acswuptc. ')
 endif
  NULLIFY(grid%acswuptc)
ENDIF
IF ( ASSOCIATED( grid%aclwupbc ) ) THEN 
  DEALLOCATE(grid%aclwupbc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwupbc. ')
 endif
  NULLIFY(grid%aclwupbc)
ENDIF
IF ( ASSOCIATED( grid%i_aclwuptc ) ) THEN 
  DEALLOCATE(grid%i_aclwuptc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_aclwuptc. ')
 endif
  NULLIFY(grid%i_aclwuptc)
ENDIF
IF ( ASSOCIATED( grid%swdntcln ) ) THEN 
  DEALLOCATE(grid%swdntcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdntcln. ')
 endif
  NULLIFY(grid%swdntcln)
ENDIF
IF ( ASSOCIATED( grid%lwdntcln ) ) THEN 
  DEALLOCATE(grid%lwdntcln,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwdntcln. ')
 endif
  NULLIFY(grid%lwdntcln)
ENDIF
IF ( ASSOCIATED( grid%xlat_v ) ) THEN 
  DEALLOCATE(grid%xlat_v,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%xlat_v. ')
 endif
  NULLIFY(grid%xlat_v)
ENDIF
IF ( ASSOCIATED( grid%rvblten ) ) THEN 
  DEALLOCATE(grid%rvblten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rvblten. ')
 endif
  NULLIFY(grid%rvblten)
ENDIF
IF ( ASSOCIATED( grid%tslb_mosaic ) ) THEN 
  DEALLOCATE(grid%tslb_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tslb_mosaic. ')
 endif
  NULLIFY(grid%tslb_mosaic)
ENDIF
IF ( ASSOCIATED( grid%z0_mosaic ) ) THEN 
  DEALLOCATE(grid%z0_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%z0_mosaic. ')
 endif
  NULLIFY(grid%z0_mosaic)
ENDIF
IF ( ASSOCIATED( grid%ts_urb2d_mosaic ) ) THEN 
  DEALLOCATE(grid%ts_urb2d_mosaic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_urb2d_mosaic. ')
 endif
  NULLIFY(grid%ts_urb2d_mosaic)
ENDIF
IF ( ASSOCIATED( grid%landusef2 ) ) THEN 
  DEALLOCATE(grid%landusef2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%landusef2. ')
 endif
  NULLIFY(grid%landusef2)
ENDIF
IF ( ASSOCIATED( grid%t_phy ) ) THEN 
  DEALLOCATE(grid%t_phy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_phy. ')
 endif
  NULLIFY(grid%t_phy)
ENDIF
IF ( ASSOCIATED( grid%rmol ) ) THEN 
  DEALLOCATE(grid%rmol,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rmol. ')
 endif
  NULLIFY(grid%rmol)
ENDIF
IF ( ASSOCIATED( grid%flqc ) ) THEN 
  DEALLOCATE(grid%flqc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flqc. ')
 endif
  NULLIFY(grid%flqc)
ENDIF
IF ( ASSOCIATED( grid%dfi_snowc ) ) THEN 
  DEALLOCATE(grid%dfi_snowc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfi_snowc. ')
 endif
  NULLIFY(grid%dfi_snowc)
ENDIF
IF ( ASSOCIATED( grid%defor12 ) ) THEN 
  DEALLOCATE(grid%defor12,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%defor12. ')
 endif
  NULLIFY(grid%defor12)
ENDIF
IF ( ASSOCIATED( grid%v10_ndg_old ) ) THEN 
  DEALLOCATE(grid%v10_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%v10_ndg_old. ')
 endif
  NULLIFY(grid%v10_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%ps_ndg_old ) ) THEN 
  DEALLOCATE(grid%ps_ndg_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ps_ndg_old. ')
 endif
  NULLIFY(grid%ps_ndg_old)
ENDIF
IF ( ASSOCIATED( grid%qfx_both ) ) THEN 
  DEALLOCATE(grid%qfx_both,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qfx_both. ')
 endif
  NULLIFY(grid%qfx_both)
ENDIF
IF ( ASSOCIATED( grid%w_dn_max ) ) THEN 
  DEALLOCATE(grid%w_dn_max,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_dn_max. ')
 endif
  NULLIFY(grid%w_dn_max)
ENDIF
IF ( ASSOCIATED( grid%prec_acc_c ) ) THEN 
  DEALLOCATE(grid%prec_acc_c,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%prec_acc_c. ')
 endif
  NULLIFY(grid%prec_acc_c)
ENDIF
IF ( ASSOCIATED( grid%track_z ) ) THEN 
  DEALLOCATE(grid%track_z,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_z. ')
 endif
  NULLIFY(grid%track_z)
ENDIF
IF ( ASSOCIATED( grid%track_qice ) ) THEN 
  DEALLOCATE(grid%track_qice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%track_qice. ')
 endif
  NULLIFY(grid%track_qice)
ENDIF
IF ( ASSOCIATED( grid%aucuten ) ) THEN 
  DEALLOCATE(grid%aucuten,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aucuten. ')
 endif
  NULLIFY(grid%aucuten)
ENDIF
IF ( ASSOCIATED( grid%hailcast_diam_mean ) ) THEN 
  DEALLOCATE(grid%hailcast_diam_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hailcast_diam_mean. ')
 endif
  NULLIFY(grid%hailcast_diam_mean)
ENDIF
IF ( ASSOCIATED( grid%t_xxx ) ) THEN 
  DEALLOCATE(grid%t_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_xxx. ')
 endif
  NULLIFY(grid%t_xxx)
ENDIF
IF ( ASSOCIATED( grid%mf_xxx ) ) THEN 
  DEALLOCATE(grid%mf_xxx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mf_xxx. ')
 endif
  NULLIFY(grid%mf_xxx)
ENDIF
IF ( ASSOCIATED( grid%avg_fuel_frac ) ) THEN 
  DEALLOCATE(grid%avg_fuel_frac,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avg_fuel_frac. ')
 endif
  NULLIFY(grid%avg_fuel_frac)
ENDIF
IF ( ASSOCIATED( grid%lfn_2 ) ) THEN 
  DEALLOCATE(grid%lfn_2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lfn_2. ')
 endif
  NULLIFY(grid%lfn_2)
ENDIF
IF ( ASSOCIATED( grid%fcanqfx ) ) THEN 
  DEALLOCATE(grid%fcanqfx,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fcanqfx. ')
 endif
  NULLIFY(grid%fcanqfx)
ENDIF
IF ( ASSOCIATED( grid%t2_old ) ) THEN 
  DEALLOCATE(grid%t2_old,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_old. ')
 endif
  NULLIFY(grid%t2_old)
ENDIF
IF ( ASSOCIATED( grid%iboros ) ) THEN 
  DEALLOCATE(grid%iboros,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iboros. ')
 endif
  NULLIFY(grid%iboros)
ENDIF
IF ( ASSOCIATED( grid%fs_p_src ) ) THEN 
  DEALLOCATE(grid%fs_p_src,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fs_p_src. ')
 endif
  NULLIFY(grid%fs_p_src)
ENDIF
IF ( ASSOCIATED( grid%avgflx_wwm ) ) THEN 
  DEALLOCATE(grid%avgflx_wwm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%avgflx_wwm. ')
 endif
  NULLIFY(grid%avgflx_wwm)
ENDIF
IF ( ASSOCIATED( grid%dfd1 ) ) THEN 
  DEALLOCATE(grid%dfd1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%dfd1. ')
 endif
  NULLIFY(grid%dfd1)
ENDIF
IF ( ASSOCIATED( grid%rand_pert ) ) THEN 
  DEALLOCATE(grid%rand_pert,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rand_pert. ')
 endif
  NULLIFY(grid%rand_pert)
ENDIF
IF ( ASSOCIATED( grid%spt_amp ) ) THEN 
  DEALLOCATE(grid%spt_amp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%spt_amp. ')
 endif
  NULLIFY(grid%spt_amp)
ENDIF
IF ( ASSOCIATED( grid%sp_amp4 ) ) THEN 
  DEALLOCATE(grid%sp_amp4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sp_amp4. ')
 endif
  NULLIFY(grid%sp_amp4)
ENDIF
IF ( ASSOCIATED( grid%iseedarr_spp_conv ) ) THEN 
  DEALLOCATE(grid%iseedarr_spp_conv,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%iseedarr_spp_conv. ')
 endif
  NULLIFY(grid%iseedarr_spp_conv)
ENDIF
IF ( ASSOCIATED( grid%alph_rand3d ) ) THEN 
  DEALLOCATE(grid%alph_rand3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alph_rand3d. ')
 endif
  NULLIFY(grid%alph_rand3d)
ENDIF
IF ( ASSOCIATED( grid%turbtype3d ) ) THEN 
  DEALLOCATE(grid%turbtype3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%turbtype3d. ')
 endif
  NULLIFY(grid%turbtype3d)
ENDIF
IF ( ASSOCIATED( grid%evsntzm ) ) THEN 
  DEALLOCATE(grid%evsntzm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evsntzm. ')
 endif
  NULLIFY(grid%evsntzm)
ENDIF
IF ( ASSOCIATED( grid%zmmtu ) ) THEN 
  DEALLOCATE(grid%zmmtu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%zmmtu. ')
 endif
  NULLIFY(grid%zmmtu)
ENDIF
IF ( ASSOCIATED( grid%evapcdp3d ) ) THEN 
  DEALLOCATE(grid%evapcdp3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%evapcdp3d. ')
 endif
  NULLIFY(grid%evapcdp3d)
ENDIF
IF ( ASSOCIATED( grid%maxg2d ) ) THEN 
  DEALLOCATE(grid%maxg2d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%maxg2d. ')
 endif
  NULLIFY(grid%maxg2d)
ENDIF
IF ( ASSOCIATED( grid%rliq2 ) ) THEN 
  DEALLOCATE(grid%rliq2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rliq2. ')
 endif
  NULLIFY(grid%rliq2)
ENDIF
IF ( ASSOCIATED( grid%qlten_cu ) ) THEN 
  DEALLOCATE(grid%qlten_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qlten_cu. ')
 endif
  NULLIFY(grid%qlten_cu)
ENDIF
IF ( ASSOCIATED( grid%qtsrc_cu ) ) THEN 
  DEALLOCATE(grid%qtsrc_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qtsrc_cu. ')
 endif
  NULLIFY(grid%qtsrc_cu)
ENDIF
IF ( ASSOCIATED( grid%tophgt_cu ) ) THEN 
  DEALLOCATE(grid%tophgt_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tophgt_cu. ')
 endif
  NULLIFY(grid%tophgt_cu)
ENDIF
IF ( ASSOCIATED( grid%umf_cu ) ) THEN 
  DEALLOCATE(grid%umf_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%umf_cu. ')
 endif
  NULLIFY(grid%umf_cu)
ENDIF
IF ( ASSOCIATED( grid%flxrain_cu ) ) THEN 
  DEALLOCATE(grid%flxrain_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%flxrain_cu. ')
 endif
  NULLIFY(grid%flxrain_cu)
ENDIF
IF ( ASSOCIATED( grid%exit_uwcu_cu ) ) THEN 
  DEALLOCATE(grid%exit_uwcu_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%exit_uwcu_cu. ')
 endif
  NULLIFY(grid%exit_uwcu_cu)
ENDIF
IF ( ASSOCIATED( grid%limit_negcon_cu ) ) THEN 
  DEALLOCATE(grid%limit_negcon_cu,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%limit_negcon_cu. ')
 endif
  NULLIFY(grid%limit_negcon_cu)
ENDIF
IF ( ASSOCIATED( grid%cldfra_mp ) ) THEN 
  DEALLOCATE(grid%cldfra_mp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%cldfra_mp. ')
 endif
  NULLIFY(grid%cldfra_mp)
ENDIF
IF ( ASSOCIATED( grid%lwup ) ) THEN 
  DEALLOCATE(grid%lwup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lwup. ')
 endif
  NULLIFY(grid%lwup)
ENDIF
IF ( ASSOCIATED( grid%t_veg240 ) ) THEN 
  DEALLOCATE(grid%t_veg240,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_veg240. ')
 endif
  NULLIFY(grid%t_veg240)
ENDIF
IF ( ASSOCIATED( grid%t2m_min ) ) THEN 
  DEALLOCATE(grid%t2m_min,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2m_min. ')
 endif
  NULLIFY(grid%t2m_min)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_liq4 ) ) THEN 
  DEALLOCATE(grid%h2osoi_liq4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_liq4. ')
 endif
  NULLIFY(grid%h2osoi_liq4)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_ice1 ) ) THEN 
  DEALLOCATE(grid%h2osoi_ice1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_ice1. ')
 endif
  NULLIFY(grid%h2osoi_ice1)
ENDIF
IF ( ASSOCIATED( grid%t_soisno_s3 ) ) THEN 
  DEALLOCATE(grid%t_soisno_s3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno_s3. ')
 endif
  NULLIFY(grid%t_soisno_s3)
ENDIF
IF ( ASSOCIATED( grid%t_soisno10 ) ) THEN 
  DEALLOCATE(grid%t_soisno10,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_soisno10. ')
 endif
  NULLIFY(grid%t_soisno10)
ENDIF
IF ( ASSOCIATED( grid%t_lake2 ) ) THEN 
  DEALLOCATE(grid%t_lake2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t_lake2. ')
 endif
  NULLIFY(grid%t_lake2)
ENDIF
IF ( ASSOCIATED( grid%h2osoi_vol4 ) ) THEN 
  DEALLOCATE(grid%h2osoi_vol4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%h2osoi_vol4. ')
 endif
  NULLIFY(grid%h2osoi_vol4)
ENDIF
IF ( ASSOCIATED( grid%sabvsubgrid ) ) THEN 
  DEALLOCATE(grid%sabvsubgrid,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sabvsubgrid. ')
 endif
  NULLIFY(grid%sabvsubgrid)
ENDIF
IF ( ASSOCIATED( grid%lake_icefrac3d ) ) THEN 
  DEALLOCATE(grid%lake_icefrac3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%lake_icefrac3d. ')
 endif
  NULLIFY(grid%lake_icefrac3d)
ENDIF
IF ( ASSOCIATED( grid%tkmg3d ) ) THEN 
  DEALLOCATE(grid%tkmg3d,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tkmg3d. ')
 endif
  NULLIFY(grid%tkmg3d)
ENDIF
IF ( ASSOCIATED( grid%ssib_br ) ) THEN 
  DEALLOCATE(grid%ssib_br,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_br. ')
 endif
  NULLIFY(grid%ssib_br)
ENDIF
IF ( ASSOCIATED( grid%ssib_lup ) ) THEN 
  DEALLOCATE(grid%ssib_lup,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ssib_lup. ')
 endif
  NULLIFY(grid%ssib_lup)
ENDIF
IF ( ASSOCIATED( grid%tkair ) ) THEN 
  DEALLOCATE(grid%tkair,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tkair. ')
 endif
  NULLIFY(grid%tkair)
ENDIF
IF ( ASSOCIATED( grid%ho1 ) ) THEN 
  DEALLOCATE(grid%ho1,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ho1. ')
 endif
  NULLIFY(grid%ho1)
ENDIF
IF ( ASSOCIATED( grid%ho2 ) ) THEN 
  DEALLOCATE(grid%ho2,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ho2. ')
 endif
  NULLIFY(grid%ho2)
ENDIF
IF ( ASSOCIATED( grid%ho3 ) ) THEN 
  DEALLOCATE(grid%ho3,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ho3. ')
 endif
  NULLIFY(grid%ho3)
ENDIF
IF ( ASSOCIATED( grid%ho4 ) ) THEN 
  DEALLOCATE(grid%ho4,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ho4. ')
 endif
  NULLIFY(grid%ho4)
ENDIF
IF ( ASSOCIATED( grid%alboldxy ) ) THEN 
  DEALLOCATE(grid%alboldxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%alboldxy. ')
 endif
  NULLIFY(grid%alboldxy)
ENDIF
IF ( ASSOCIATED( grid%rtmassxy ) ) THEN 
  DEALLOCATE(grid%rtmassxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rtmassxy. ')
 endif
  NULLIFY(grid%rtmassxy)
ENDIF
IF ( ASSOCIATED( grid%neexy ) ) THEN 
  DEALLOCATE(grid%neexy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%neexy. ')
 endif
  NULLIFY(grid%neexy)
ENDIF
IF ( ASSOCIATED( grid%aparxy ) ) THEN 
  DEALLOCATE(grid%aparxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aparxy. ')
 endif
  NULLIFY(grid%aparxy)
ENDIF
IF ( ASSOCIATED( grid%shgxy ) ) THEN 
  DEALLOCATE(grid%shgxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%shgxy. ')
 endif
  NULLIFY(grid%shgxy)
ENDIF
IF ( ASSOCIATED( grid%chleafxy ) ) THEN 
  DEALLOCATE(grid%chleafxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%chleafxy. ')
 endif
  NULLIFY(grid%chleafxy)
ENDIF
IF ( ASSOCIATED( grid%qrfsxy ) ) THEN 
  DEALLOCATE(grid%qrfsxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qrfsxy. ')
 endif
  NULLIFY(grid%qrfsxy)
ENDIF
IF ( ASSOCIATED( grid%riverbedxy ) ) THEN 
  DEALLOCATE(grid%riverbedxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%riverbedxy. ')
 endif
  NULLIFY(grid%riverbedxy)
ENDIF
IF ( ASSOCIATED( grid%qdewcxy ) ) THEN 
  DEALLOCATE(grid%qdewcxy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%qdewcxy. ')
 endif
  NULLIFY(grid%qdewcxy)
ENDIF
IF ( ASSOCIATED( grid%rainlsm ) ) THEN 
  DEALLOCATE(grid%rainlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rainlsm. ')
 endif
  NULLIFY(grid%rainlsm)
ENDIF
IF ( ASSOCIATED( grid%acdewc ) ) THEN 
  DEALLOCATE(grid%acdewc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acdewc. ')
 endif
  NULLIFY(grid%acdewc)
ENDIF
IF ( ASSOCIATED( grid%acqlat ) ) THEN 
  DEALLOCATE(grid%acqlat,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acqlat. ')
 endif
  NULLIFY(grid%acqlat)
ENDIF
IF ( ASSOCIATED( grid%acsnfro ) ) THEN 
  DEALLOCATE(grid%acsnfro,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acsnfro. ')
 endif
  NULLIFY(grid%acsnfro)
ENDIF
IF ( ASSOCIATED( grid%acshg ) ) THEN 
  DEALLOCATE(grid%acshg,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acshg. ')
 endif
  NULLIFY(grid%acshg)
ENDIF
IF ( ASSOCIATED( grid%aclwdnlsm ) ) THEN 
  DEALLOCATE(grid%aclwdnlsm,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%aclwdnlsm. ')
 endif
  NULLIFY(grid%aclwdnlsm)
ENDIF
IF ( ASSOCIATED( grid%acc_etrani ) ) THEN 
  DEALLOCATE(grid%acc_etrani,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%acc_etrani. ')
 endif
  NULLIFY(grid%acc_etrani)
ENDIF
IF ( ASSOCIATED( grid%harvest ) ) THEN 
  DEALLOCATE(grid%harvest,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%harvest. ')
 endif
  NULLIFY(grid%harvest)
ENDIF
IF ( ASSOCIATED( grid%irnummi ) ) THEN 
  DEALLOCATE(grid%irnummi,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%irnummi. ')
 endif
  NULLIFY(grid%irnummi)
ENDIF
IF ( ASSOCIATED( grid%kext_qip ) ) THEN 
  DEALLOCATE(grid%kext_qip,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%kext_qip. ')
 endif
  NULLIFY(grid%kext_qip)
ENDIF
IF ( ASSOCIATED( grid%tempc ) ) THEN 
  DEALLOCATE(grid%tempc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%tempc. ')
 endif
  NULLIFY(grid%tempc)
ENDIF
IF ( ASSOCIATED( grid%fzlev ) ) THEN 
  DEALLOCATE(grid%fzlev,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%fzlev. ')
 endif
  NULLIFY(grid%fzlev)
ENDIF
IF ( ASSOCIATED( grid%afwa_fits ) ) THEN 
  DEALLOCATE(grid%afwa_fits,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_fits. ')
 endif
  NULLIFY(grid%afwa_fits)
ENDIF
IF ( ASSOCIATED( grid%afwa_ice ) ) THEN 
  DEALLOCATE(grid%afwa_ice,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_ice. ')
 endif
  NULLIFY(grid%afwa_ice)
ENDIF
IF ( ASSOCIATED( grid%afwa_zlfc ) ) THEN 
  DEALLOCATE(grid%afwa_zlfc,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%afwa_zlfc. ')
 endif
  NULLIFY(grid%afwa_zlfc)
ENDIF
IF ( ASSOCIATED( grid%t2_mean ) ) THEN 
  DEALLOCATE(grid%t2_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%t2_mean. ')
 endif
  NULLIFY(grid%t2_mean)
ENDIF
IF ( ASSOCIATED( grid%swdnt_mean ) ) THEN 
  DEALLOCATE(grid%swdnt_mean,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swdnt_mean. ')
 endif
  NULLIFY(grid%swdnt_mean)
ENDIF
IF ( ASSOCIATED( grid%hfx_diurn ) ) THEN 
  DEALLOCATE(grid%hfx_diurn,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%hfx_diurn. ')
 endif
  NULLIFY(grid%hfx_diurn)
ENDIF
IF ( ASSOCIATED( grid%psfc_dtmp ) ) THEN 
  DEALLOCATE(grid%psfc_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%psfc_dtmp. ')
 endif
  NULLIFY(grid%psfc_dtmp)
ENDIF
IF ( ASSOCIATED( grid%swupb_dtmp ) ) THEN 
  DEALLOCATE(grid%swupb_dtmp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%swupb_dtmp. ')
 endif
  NULLIFY(grid%swupb_dtmp)
ENDIF
IF ( ASSOCIATED( grid%elecy ) ) THEN 
  DEALLOCATE(grid%elecy,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%elecy. ')
 endif
  NULLIFY(grid%elecy)
ENDIF
IF ( ASSOCIATED( grid%c2h ) ) THEN 
  DEALLOCATE(grid%c2h,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%c2h. ')
 endif
  NULLIFY(grid%c2h)
ENDIF
IF ( ASSOCIATED( grid%p_wif_may ) ) THEN 
  DEALLOCATE(grid%p_wif_may,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%p_wif_may. ')
 endif
  NULLIFY(grid%p_wif_may)
ENDIF
IF ( ASSOCIATED( grid%w_wif_apr ) ) THEN 
  DEALLOCATE(grid%w_wif_apr,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%w_wif_apr. ')
 endif
  NULLIFY(grid%w_wif_apr)
ENDIF
IF ( ASSOCIATED( grid%i_wif_mar ) ) THEN 
  DEALLOCATE(grid%i_wif_mar,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%i_wif_mar. ')
 endif
  NULLIFY(grid%i_wif_mar)
ENDIF
IF ( ASSOCIATED( grid%b_wif_feb ) ) THEN 
  DEALLOCATE(grid%b_wif_feb,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%b_wif_feb. ')
 endif
  NULLIFY(grid%b_wif_feb)
ENDIF
IF ( ASSOCIATED( grid%sealevelp ) ) THEN 
  DEALLOCATE(grid%sealevelp,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%sealevelp. ')
 endif
  NULLIFY(grid%sealevelp)
ENDIF
IF ( ASSOCIATED( grid%rh ) ) THEN 
  DEALLOCATE(grid%rh,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rh. ')
 endif
  NULLIFY(grid%rh)
ENDIF
IF ( ASSOCIATED( grid%wp_tot_sum ) ) THEN 
  DEALLOCATE(grid%wp_tot_sum,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%wp_tot_sum. ')
 endif
  NULLIFY(grid%wp_tot_sum)
ENDIF
IF ( ASSOCIATED( grid%ctopht ) ) THEN 
  DEALLOCATE(grid%ctopht,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ctopht. ')
 endif
  NULLIFY(grid%ctopht)
ENDIF
IF ( ASSOCIATED( grid%ts_lwp_tot ) ) THEN 
  DEALLOCATE(grid%ts_lwp_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_lwp_tot. ')
 endif
  NULLIFY(grid%ts_lwp_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_tau_qi_tot ) ) THEN 
  DEALLOCATE(grid%ts_tau_qi_tot,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_tau_qi_tot. ')
 endif
  NULLIFY(grid%ts_tau_qi_tot)
ENDIF
IF ( ASSOCIATED( grid%ts_swddnic ) ) THEN 
  DEALLOCATE(grid%ts_swddnic,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%ts_swddnic. ')
 endif
  NULLIFY(grid%ts_swddnic)
ENDIF
IF ( ASSOCIATED( grid%td_zl ) ) THEN 
  DEALLOCATE(grid%td_zl,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%td_zl. ')
 endif
  NULLIFY(grid%td_zl)
ENDIF
IF ( ASSOCIATED( grid%rswdir_htop_red ) ) THEN 
  DEALLOCATE(grid%rswdir_htop_red,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%rswdir_htop_red. ')
 endif
  NULLIFY(grid%rswdir_htop_red)
ENDIF
IF ( ASSOCIATED( grid%mcm_q_source ) ) THEN 
  DEALLOCATE(grid%mcm_q_source,STAT=ierr)
 if (ierr.ne.0) then
 CALL wrf_error_fatal ( &
'frame/module_domain.f: Failed to deallocate grid%mcm_q_source. ')
 endif
  NULLIFY(grid%mcm_q_source)
ENDIF
END SUBROUTINE deallocs_8
!ENDOFREGISTRYGENERATEDINCLUDE
