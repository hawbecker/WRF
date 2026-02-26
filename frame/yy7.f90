!STARTOFREGISTRYGENERATEDINCLUDE 'inc/nl_config.inc'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit. Your changes to this file will be lost.
!
SUBROUTINE nl_get_fire_ignition_end_y3 ( id_id , fire_ignition_end_y3 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_end_y3
  INTEGER id_id
  fire_ignition_end_y3 = model_config_rec%fire_ignition_end_y3(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_end_y3
SUBROUTINE nl_get_fire_ignition_start_x4 ( id_id , fire_ignition_start_x4 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_start_x4
  INTEGER id_id
  fire_ignition_start_x4 = model_config_rec%fire_ignition_start_x4(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_start_x4
SUBROUTINE nl_get_fire_ignition_start_y4 ( id_id , fire_ignition_start_y4 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_start_y4
  INTEGER id_id
  fire_ignition_start_y4 = model_config_rec%fire_ignition_start_y4(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_start_y4
SUBROUTINE nl_get_fire_ignition_end_x4 ( id_id , fire_ignition_end_x4 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_end_x4
  INTEGER id_id
  fire_ignition_end_x4 = model_config_rec%fire_ignition_end_x4(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_end_x4
SUBROUTINE nl_get_fire_ignition_end_y4 ( id_id , fire_ignition_end_y4 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_end_y4
  INTEGER id_id
  fire_ignition_end_y4 = model_config_rec%fire_ignition_end_y4(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_end_y4
SUBROUTINE nl_get_fire_ignition_start_x5 ( id_id , fire_ignition_start_x5 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_start_x5
  INTEGER id_id
  fire_ignition_start_x5 = model_config_rec%fire_ignition_start_x5(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_start_x5
SUBROUTINE nl_get_fire_ignition_start_y5 ( id_id , fire_ignition_start_y5 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_start_y5
  INTEGER id_id
  fire_ignition_start_y5 = model_config_rec%fire_ignition_start_y5(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_start_y5
SUBROUTINE nl_get_fire_ignition_end_x5 ( id_id , fire_ignition_end_x5 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_end_x5
  INTEGER id_id
  fire_ignition_end_x5 = model_config_rec%fire_ignition_end_x5(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_end_x5
SUBROUTINE nl_get_fire_ignition_end_y5 ( id_id , fire_ignition_end_y5 )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ignition_end_y5
  INTEGER id_id
  fire_ignition_end_y5 = model_config_rec%fire_ignition_end_y5(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ignition_end_y5
SUBROUTINE nl_get_fire_lat_init ( id_id , fire_lat_init )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_lat_init
  INTEGER id_id
  fire_lat_init = model_config_rec%fire_lat_init(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lat_init
SUBROUTINE nl_get_fire_lon_init ( id_id , fire_lon_init )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_lon_init
  INTEGER id_id
  fire_lon_init = model_config_rec%fire_lon_init(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lon_init
SUBROUTINE nl_get_fire_ign_time ( id_id , fire_ign_time )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ign_time
  INTEGER id_id
  fire_ign_time = model_config_rec%fire_ign_time(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ign_time
SUBROUTINE nl_get_fire_shape ( id_id , fire_shape )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_shape
  INTEGER id_id
  fire_shape = model_config_rec%fire_shape(id_id)
  RETURN
END SUBROUTINE nl_get_fire_shape
SUBROUTINE nl_get_fire_sprd_mdl ( id_id , fire_sprd_mdl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_sprd_mdl
  INTEGER id_id
  fire_sprd_mdl = model_config_rec%fire_sprd_mdl(id_id)
  RETURN
END SUBROUTINE nl_get_fire_sprd_mdl
SUBROUTINE nl_get_fire_crwn_hgt ( id_id , fire_crwn_hgt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_crwn_hgt
  INTEGER id_id
  fire_crwn_hgt = model_config_rec%fire_crwn_hgt(id_id)
  RETURN
END SUBROUTINE nl_get_fire_crwn_hgt
SUBROUTINE nl_get_fire_ext_grnd ( id_id , fire_ext_grnd )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ext_grnd
  INTEGER id_id
  fire_ext_grnd = model_config_rec%fire_ext_grnd(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ext_grnd
SUBROUTINE nl_get_fire_ext_crwn ( id_id , fire_ext_crwn )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_ext_crwn
  INTEGER id_id
  fire_ext_crwn = model_config_rec%fire_ext_crwn(id_id)
  RETURN
END SUBROUTINE nl_get_fire_ext_crwn
SUBROUTINE nl_get_fire_wind_height ( id_id , fire_wind_height )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_wind_height
  INTEGER id_id
  fire_wind_height = model_config_rec%fire_wind_height(id_id)
  RETURN
END SUBROUTINE nl_get_fire_wind_height
SUBROUTINE nl_get_fire_fuel_read ( id_id , fire_fuel_read )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fuel_read
  INTEGER id_id
  fire_fuel_read = model_config_rec%fire_fuel_read(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fuel_read
SUBROUTINE nl_get_fire_fuel_cat ( id_id , fire_fuel_cat )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fuel_cat
  INTEGER id_id
  fire_fuel_cat = model_config_rec%fire_fuel_cat(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fuel_cat
SUBROUTINE nl_get_fire_fmc_read ( id_id , fire_fmc_read )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fmc_read
  INTEGER id_id
  fire_fmc_read = model_config_rec%fire_fmc_read(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fmc_read
SUBROUTINE nl_get_fire_print_msg ( id_id , fire_print_msg )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_print_msg
  INTEGER id_id
  fire_print_msg = model_config_rec%fire_print_msg(id_id)
  RETURN
END SUBROUTINE nl_get_fire_print_msg
SUBROUTINE nl_get_fire_print_file ( id_id , fire_print_file )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_print_file
  INTEGER id_id
  fire_print_file = model_config_rec%fire_print_file(id_id)
  RETURN
END SUBROUTINE nl_get_fire_print_file
SUBROUTINE nl_get_fire_fuel_left_method ( id_id , fire_fuel_left_method )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fuel_left_method
  INTEGER id_id
  fire_fuel_left_method = model_config_rec%fire_fuel_left_method(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fuel_left_method
SUBROUTINE nl_get_fire_fuel_left_irl ( id_id , fire_fuel_left_irl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fuel_left_irl
  INTEGER id_id
  fire_fuel_left_irl = model_config_rec%fire_fuel_left_irl(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fuel_left_irl
SUBROUTINE nl_get_fire_fuel_left_jrl ( id_id , fire_fuel_left_jrl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_fuel_left_jrl
  INTEGER id_id
  fire_fuel_left_jrl = model_config_rec%fire_fuel_left_jrl(id_id)
  RETURN
END SUBROUTINE nl_get_fire_fuel_left_jrl
SUBROUTINE nl_get_fire_grows_only ( id_id , fire_grows_only )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_grows_only
  INTEGER id_id
  fire_grows_only = model_config_rec%fire_grows_only(id_id)
  RETURN
END SUBROUTINE nl_get_fire_grows_only
SUBROUTINE nl_get_fire_upwinding ( id_id , fire_upwinding )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_upwinding
  INTEGER id_id
  fire_upwinding = model_config_rec%fire_upwinding(id_id)
  RETURN
END SUBROUTINE nl_get_fire_upwinding
SUBROUTINE nl_get_fire_upwind_split ( id_id , fire_upwind_split )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_upwind_split
  INTEGER id_id
  fire_upwind_split = model_config_rec%fire_upwind_split(id_id)
  RETURN
END SUBROUTINE nl_get_fire_upwind_split
SUBROUTINE nl_get_fire_viscosity ( id_id , fire_viscosity )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_viscosity
  INTEGER id_id
  fire_viscosity = model_config_rec%fire_viscosity(id_id)
  RETURN
END SUBROUTINE nl_get_fire_viscosity
SUBROUTINE nl_get_fire_lfn_ext_up ( id_id , fire_lfn_ext_up )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_lfn_ext_up
  INTEGER id_id
  fire_lfn_ext_up = model_config_rec%fire_lfn_ext_up(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lfn_ext_up
SUBROUTINE nl_get_fire_topo_from_atm ( id_id , fire_topo_from_atm )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_topo_from_atm
  INTEGER id_id
  fire_topo_from_atm = model_config_rec%fire_topo_from_atm(id_id)
  RETURN
END SUBROUTINE nl_get_fire_topo_from_atm
SUBROUTINE nl_get_fire_advection ( id_id , fire_advection )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_advection
  INTEGER id_id
  fire_advection = model_config_rec%fire_advection(id_id)
  RETURN
END SUBROUTINE nl_get_fire_advection
SUBROUTINE nl_get_fire_test_steps ( id_id , fire_test_steps )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_test_steps
  INTEGER id_id
  fire_test_steps = model_config_rec%fire_test_steps(id_id)
  RETURN
END SUBROUTINE nl_get_fire_test_steps
SUBROUTINE nl_get_fire_const_time ( id_id , fire_const_time )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_const_time
  INTEGER id_id
  fire_const_time = model_config_rec%fire_const_time(id_id)
  RETURN
END SUBROUTINE nl_get_fire_const_time
SUBROUTINE nl_get_fire_const_grnhfx ( id_id , fire_const_grnhfx )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_const_grnhfx
  INTEGER id_id
  fire_const_grnhfx = model_config_rec%fire_const_grnhfx(id_id)
  RETURN
END SUBROUTINE nl_get_fire_const_grnhfx
SUBROUTINE nl_get_fire_const_grnqfx ( id_id , fire_const_grnqfx )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_const_grnqfx
  INTEGER id_id
  fire_const_grnqfx = model_config_rec%fire_const_grnqfx(id_id)
  RETURN
END SUBROUTINE nl_get_fire_const_grnqfx
SUBROUTINE nl_get_fire_atm_feedback ( id_id , fire_atm_feedback )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_atm_feedback
  INTEGER id_id
  fire_atm_feedback = model_config_rec%fire_atm_feedback(id_id)
  RETURN
END SUBROUTINE nl_get_fire_atm_feedback
SUBROUTINE nl_get_fire_mountain_type ( id_id , fire_mountain_type )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_mountain_type
  INTEGER id_id
  fire_mountain_type = model_config_rec%fire_mountain_type(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_type
SUBROUTINE nl_get_fire_mountain_height ( id_id , fire_mountain_height )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_mountain_height
  INTEGER id_id
  fire_mountain_height = model_config_rec%fire_mountain_height(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_height
SUBROUTINE nl_get_fire_mountain_start_x ( id_id , fire_mountain_start_x )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_mountain_start_x
  INTEGER id_id
  fire_mountain_start_x = model_config_rec%fire_mountain_start_x(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_start_x
SUBROUTINE nl_get_fire_mountain_start_y ( id_id , fire_mountain_start_y )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_mountain_start_y
  INTEGER id_id
  fire_mountain_start_y = model_config_rec%fire_mountain_start_y(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_start_y
SUBROUTINE nl_get_fire_mountain_end_x ( id_id , fire_mountain_end_x )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_mountain_end_x
  INTEGER id_id
  fire_mountain_end_x = model_config_rec%fire_mountain_end_x(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_end_x
SUBROUTINE nl_get_fire_mountain_end_y ( id_id , fire_mountain_end_y )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_mountain_end_y
  INTEGER id_id
  fire_mountain_end_y = model_config_rec%fire_mountain_end_y(id_id)
  RETURN
END SUBROUTINE nl_get_fire_mountain_end_y
SUBROUTINE nl_get_delt_perturbation ( id_id , delt_perturbation )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: delt_perturbation
  INTEGER id_id
  delt_perturbation = model_config_rec%delt_perturbation(id_id)
  RETURN
END SUBROUTINE nl_get_delt_perturbation
SUBROUTINE nl_get_xrad_perturbation ( id_id , xrad_perturbation )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: xrad_perturbation
  INTEGER id_id
  xrad_perturbation = model_config_rec%xrad_perturbation(id_id)
  RETURN
END SUBROUTINE nl_get_xrad_perturbation
SUBROUTINE nl_get_yrad_perturbation ( id_id , yrad_perturbation )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: yrad_perturbation
  INTEGER id_id
  yrad_perturbation = model_config_rec%yrad_perturbation(id_id)
  RETURN
END SUBROUTINE nl_get_yrad_perturbation
SUBROUTINE nl_get_zrad_perturbation ( id_id , zrad_perturbation )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: zrad_perturbation
  INTEGER id_id
  zrad_perturbation = model_config_rec%zrad_perturbation(id_id)
  RETURN
END SUBROUTINE nl_get_zrad_perturbation
SUBROUTINE nl_get_hght_perturbation ( id_id , hght_perturbation )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: hght_perturbation
  INTEGER id_id
  hght_perturbation = model_config_rec%hght_perturbation(id_id)
  RETURN
END SUBROUTINE nl_get_hght_perturbation
SUBROUTINE nl_get_stretch_grd ( id_id , stretch_grd )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: stretch_grd
  INTEGER id_id
  stretch_grd = model_config_rec%stretch_grd(id_id)
  RETURN
END SUBROUTINE nl_get_stretch_grd
SUBROUTINE nl_get_stretch_hyp ( id_id , stretch_hyp )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: stretch_hyp
  INTEGER id_id
  stretch_hyp = model_config_rec%stretch_hyp(id_id)
  RETURN
END SUBROUTINE nl_get_stretch_hyp
SUBROUTINE nl_get_z_grd_scale ( id_id , z_grd_scale )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: z_grd_scale
  INTEGER id_id
  z_grd_scale = model_config_rec%z_grd_scale(id_id)
  RETURN
END SUBROUTINE nl_get_z_grd_scale
SUBROUTINE nl_get_sfc_full_init ( id_id , sfc_full_init )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: sfc_full_init
  INTEGER id_id
  sfc_full_init = model_config_rec%sfc_full_init(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_full_init
SUBROUTINE nl_get_sfc_lu_index ( id_id , sfc_lu_index )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sfc_lu_index
  INTEGER id_id
  sfc_lu_index = model_config_rec%sfc_lu_index(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_lu_index
SUBROUTINE nl_get_sfc_tsk ( id_id , sfc_tsk )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: sfc_tsk
  INTEGER id_id
  sfc_tsk = model_config_rec%sfc_tsk(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_tsk
SUBROUTINE nl_get_sfc_tmn ( id_id , sfc_tmn )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: sfc_tmn
  INTEGER id_id
  sfc_tmn = model_config_rec%sfc_tmn(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_tmn
SUBROUTINE nl_get_fire_read_lu ( id_id , fire_read_lu )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_lu
  INTEGER id_id
  fire_read_lu = model_config_rec%fire_read_lu(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_lu
SUBROUTINE nl_get_fire_read_tsk ( id_id , fire_read_tsk )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_tsk
  INTEGER id_id
  fire_read_tsk = model_config_rec%fire_read_tsk(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_tsk
SUBROUTINE nl_get_fire_read_tmn ( id_id , fire_read_tmn )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_tmn
  INTEGER id_id
  fire_read_tmn = model_config_rec%fire_read_tmn(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_tmn
SUBROUTINE nl_get_fire_read_atm_ht ( id_id , fire_read_atm_ht )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_atm_ht
  INTEGER id_id
  fire_read_atm_ht = model_config_rec%fire_read_atm_ht(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_atm_ht
SUBROUTINE nl_get_fire_read_fire_ht ( id_id , fire_read_fire_ht )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_fire_ht
  INTEGER id_id
  fire_read_fire_ht = model_config_rec%fire_read_fire_ht(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_fire_ht
SUBROUTINE nl_get_fire_read_atm_grad ( id_id , fire_read_atm_grad )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_atm_grad
  INTEGER id_id
  fire_read_atm_grad = model_config_rec%fire_read_atm_grad(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_atm_grad
SUBROUTINE nl_get_fire_read_fire_grad ( id_id , fire_read_fire_grad )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_read_fire_grad
  INTEGER id_id
  fire_read_fire_grad = model_config_rec%fire_read_fire_grad(id_id)
  RETURN
END SUBROUTINE nl_get_fire_read_fire_grad
SUBROUTINE nl_get_sfc_vegfra ( id_id , sfc_vegfra )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: sfc_vegfra
  INTEGER id_id
  sfc_vegfra = model_config_rec%sfc_vegfra(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_vegfra
SUBROUTINE nl_get_sfc_canwat ( id_id , sfc_canwat )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: sfc_canwat
  INTEGER id_id
  sfc_canwat = model_config_rec%sfc_canwat(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_canwat
SUBROUTINE nl_get_sfc_ivgtyp ( id_id , sfc_ivgtyp )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sfc_ivgtyp
  INTEGER id_id
  sfc_ivgtyp = model_config_rec%sfc_ivgtyp(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_ivgtyp
SUBROUTINE nl_get_sfc_isltyp ( id_id , sfc_isltyp )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sfc_isltyp
  INTEGER id_id
  sfc_isltyp = model_config_rec%sfc_isltyp(id_id)
  RETURN
END SUBROUTINE nl_get_sfc_isltyp
SUBROUTINE nl_get_fire_lsm_reinit ( id_id , fire_lsm_reinit )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_lsm_reinit
  INTEGER id_id
  fire_lsm_reinit = model_config_rec%fire_lsm_reinit(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lsm_reinit
SUBROUTINE nl_get_fire_lsm_reinit_iter ( id_id , fire_lsm_reinit_iter )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_lsm_reinit_iter
  INTEGER id_id
  fire_lsm_reinit_iter = model_config_rec%fire_lsm_reinit_iter(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lsm_reinit_iter
SUBROUTINE nl_get_fire_upwinding_reinit ( id_id , fire_upwinding_reinit )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_upwinding_reinit
  INTEGER id_id
  fire_upwinding_reinit = model_config_rec%fire_upwinding_reinit(id_id)
  RETURN
END SUBROUTINE nl_get_fire_upwinding_reinit
SUBROUTINE nl_get_fire_is_real_perim ( id_id , fire_is_real_perim )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_is_real_perim
  INTEGER id_id
  fire_is_real_perim = model_config_rec%fire_is_real_perim(id_id)
  RETURN
END SUBROUTINE nl_get_fire_is_real_perim
SUBROUTINE nl_get_fire_lsm_band_ngp ( id_id , fire_lsm_band_ngp )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_lsm_band_ngp
  INTEGER id_id
  fire_lsm_band_ngp = model_config_rec%fire_lsm_band_ngp(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lsm_band_ngp
SUBROUTINE nl_get_fire_lsm_zcoupling ( id_id , fire_lsm_zcoupling )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fire_lsm_zcoupling
  INTEGER id_id
  fire_lsm_zcoupling = model_config_rec%fire_lsm_zcoupling(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lsm_zcoupling
SUBROUTINE nl_get_fire_lsm_zcoupling_ref ( id_id , fire_lsm_zcoupling_ref )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_lsm_zcoupling_ref
  INTEGER id_id
  fire_lsm_zcoupling_ref = model_config_rec%fire_lsm_zcoupling_ref(id_id)
  RETURN
END SUBROUTINE nl_get_fire_lsm_zcoupling_ref
SUBROUTINE nl_get_fire_tracer_smoke ( id_id , fire_tracer_smoke )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_tracer_smoke
  INTEGER id_id
  fire_tracer_smoke = model_config_rec%fire_tracer_smoke(id_id)
  RETURN
END SUBROUTINE nl_get_fire_tracer_smoke
SUBROUTINE nl_get_fire_viscosity_bg ( id_id , fire_viscosity_bg )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_viscosity_bg
  INTEGER id_id
  fire_viscosity_bg = model_config_rec%fire_viscosity_bg(id_id)
  RETURN
END SUBROUTINE nl_get_fire_viscosity_bg
SUBROUTINE nl_get_fire_viscosity_band ( id_id , fire_viscosity_band )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_viscosity_band
  INTEGER id_id
  fire_viscosity_band = model_config_rec%fire_viscosity_band(id_id)
  RETURN
END SUBROUTINE nl_get_fire_viscosity_band
SUBROUTINE nl_get_fire_viscosity_ngp ( id_id , fire_viscosity_ngp )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fire_viscosity_ngp
  INTEGER id_id
  fire_viscosity_ngp = model_config_rec%fire_viscosity_ngp(id_id)
  RETURN
END SUBROUTINE nl_get_fire_viscosity_ngp
SUBROUTINE nl_get_fire_slope_factor ( id_id , fire_slope_factor )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fire_slope_factor
  INTEGER id_id
  fire_slope_factor = model_config_rec%fire_slope_factor(id_id)
  RETURN
END SUBROUTINE nl_get_fire_slope_factor
SUBROUTINE nl_get_fs_array_maxsize ( id_id , fs_array_maxsize )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_array_maxsize
  INTEGER id_id
  fs_array_maxsize = model_config_rec%fs_array_maxsize
  RETURN
END SUBROUTINE nl_get_fs_array_maxsize
SUBROUTINE nl_get_fs_firebrand_gen_lim ( id_id , fs_firebrand_gen_lim )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_lim
  INTEGER id_id
  fs_firebrand_gen_lim = model_config_rec%fs_firebrand_gen_lim
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_lim
SUBROUTINE nl_get_fs_firebrand_gen_dt ( id_id , fs_firebrand_gen_dt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_dt
  INTEGER id_id
  fs_firebrand_gen_dt = model_config_rec%fs_firebrand_gen_dt
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_dt
SUBROUTINE nl_get_fs_firebrand_gen_levels ( id_id , fs_firebrand_gen_levels )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_levels
  INTEGER id_id
  fs_firebrand_gen_levels = model_config_rec%fs_firebrand_gen_levels
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_levels
SUBROUTINE nl_get_fs_firebrand_gen_maxhgt ( id_id , fs_firebrand_gen_maxhgt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_maxhgt
  INTEGER id_id
  fs_firebrand_gen_maxhgt = model_config_rec%fs_firebrand_gen_maxhgt
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_maxhgt
SUBROUTINE nl_get_fs_firebrand_gen_levrand ( id_id , fs_firebrand_gen_levrand )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fs_firebrand_gen_levrand
  INTEGER id_id
  fs_firebrand_gen_levrand = model_config_rec%fs_firebrand_gen_levrand
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_levrand
SUBROUTINE nl_get_fs_firebrand_gen_levrand_seed ( id_id , fs_firebrand_gen_levrand_seed )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_levrand_seed
  INTEGER id_id
  fs_firebrand_gen_levrand_seed = model_config_rec%fs_firebrand_gen_levrand_seed
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_levrand_seed
SUBROUTINE nl_get_fs_firebrand_gen_mom3d_dt ( id_id , fs_firebrand_gen_mom3d_dt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_gen_mom3d_dt
  INTEGER id_id
  fs_firebrand_gen_mom3d_dt = model_config_rec%fs_firebrand_gen_mom3d_dt
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_mom3d_dt
SUBROUTINE nl_get_fs_firebrand_gen_prop_diam ( id_id , fs_firebrand_gen_prop_diam )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_gen_prop_diam
  INTEGER id_id
  fs_firebrand_gen_prop_diam = model_config_rec%fs_firebrand_gen_prop_diam
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_prop_diam
SUBROUTINE nl_get_fs_firebrand_gen_prop_effd ( id_id , fs_firebrand_gen_prop_effd )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_gen_prop_effd
  INTEGER id_id
  fs_firebrand_gen_prop_effd = model_config_rec%fs_firebrand_gen_prop_effd
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_prop_effd
SUBROUTINE nl_get_fs_firebrand_gen_prop_temp ( id_id , fs_firebrand_gen_prop_temp )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_gen_prop_temp
  INTEGER id_id
  fs_firebrand_gen_prop_temp = model_config_rec%fs_firebrand_gen_prop_temp
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_prop_temp
SUBROUTINE nl_get_fs_firebrand_gen_prop_tvel ( id_id , fs_firebrand_gen_prop_tvel )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_gen_prop_tvel
  INTEGER id_id
  fs_firebrand_gen_prop_tvel = model_config_rec%fs_firebrand_gen_prop_tvel
  RETURN
END SUBROUTINE nl_get_fs_firebrand_gen_prop_tvel
SUBROUTINE nl_get_fs_firebrand_dens ( id_id , fs_firebrand_dens )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_dens
  INTEGER id_id
  fs_firebrand_dens = model_config_rec%fs_firebrand_dens
  RETURN
END SUBROUTINE nl_get_fs_firebrand_dens
SUBROUTINE nl_get_fs_firebrand_dens_char ( id_id , fs_firebrand_dens_char )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_dens_char
  INTEGER id_id
  fs_firebrand_dens_char = model_config_rec%fs_firebrand_dens_char
  RETURN
END SUBROUTINE nl_get_fs_firebrand_dens_char
SUBROUTINE nl_get_fs_firebrand_max_life_dt ( id_id , fs_firebrand_max_life_dt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: fs_firebrand_max_life_dt
  INTEGER id_id
  fs_firebrand_max_life_dt = model_config_rec%fs_firebrand_max_life_dt
  RETURN
END SUBROUTINE nl_get_fs_firebrand_max_life_dt
SUBROUTINE nl_get_fs_firebrand_land_hgt ( id_id , fs_firebrand_land_hgt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: fs_firebrand_land_hgt
  INTEGER id_id
  fs_firebrand_land_hgt = model_config_rec%fs_firebrand_land_hgt
  RETURN
END SUBROUTINE nl_get_fs_firebrand_land_hgt
SUBROUTINE nl_get_fuel_crosswalk ( id_id , fuel_crosswalk )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: fuel_crosswalk
  INTEGER id_id
  fuel_crosswalk = model_config_rec%fuel_crosswalk(id_id)
  RETURN
END SUBROUTINE nl_get_fuel_crosswalk
SUBROUTINE nl_get_trackember ( id_id , trackember )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: trackember
  INTEGER id_id
  trackember = model_config_rec%trackember
  RETURN
END SUBROUTINE nl_get_trackember
SUBROUTINE nl_get_do_avgflx_em ( id_id , do_avgflx_em )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: do_avgflx_em
  INTEGER id_id
  do_avgflx_em = model_config_rec%do_avgflx_em(id_id)
  RETURN
END SUBROUTINE nl_get_do_avgflx_em
SUBROUTINE nl_get_do_avgflx_cugd ( id_id , do_avgflx_cugd )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: do_avgflx_cugd
  INTEGER id_id
  do_avgflx_cugd = model_config_rec%do_avgflx_cugd(id_id)
  RETURN
END SUBROUTINE nl_get_do_avgflx_cugd
SUBROUTINE nl_get_multi_perturb ( id_id , multi_perturb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: multi_perturb
  INTEGER id_id
  multi_perturb = model_config_rec%multi_perturb(id_id)
  RETURN
END SUBROUTINE nl_get_multi_perturb
SUBROUTINE nl_get_pert_farms ( id_id , pert_farms )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_farms
  INTEGER id_id
  pert_farms = model_config_rec%pert_farms(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms
SUBROUTINE nl_get_pert_farms_albedo ( id_id , pert_farms_albedo )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_albedo
  INTEGER id_id
  pert_farms_albedo = model_config_rec%pert_farms_albedo(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_albedo
SUBROUTINE nl_get_pert_farms_aod ( id_id , pert_farms_aod )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_aod
  INTEGER id_id
  pert_farms_aod = model_config_rec%pert_farms_aod(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_aod
SUBROUTINE nl_get_pert_farms_angexp ( id_id , pert_farms_angexp )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_angexp
  INTEGER id_id
  pert_farms_angexp = model_config_rec%pert_farms_angexp(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_angexp
SUBROUTINE nl_get_pert_farms_aerasy ( id_id , pert_farms_aerasy )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_aerasy
  INTEGER id_id
  pert_farms_aerasy = model_config_rec%pert_farms_aerasy(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_aerasy
SUBROUTINE nl_get_pert_farms_qv ( id_id , pert_farms_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_qv
  INTEGER id_id
  pert_farms_qv = model_config_rec%pert_farms_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_qv
SUBROUTINE nl_get_pert_farms_qc ( id_id , pert_farms_qc )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_qc
  INTEGER id_id
  pert_farms_qc = model_config_rec%pert_farms_qc(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_qc
SUBROUTINE nl_get_pert_farms_qs ( id_id , pert_farms_qs )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_farms_qs
  INTEGER id_id
  pert_farms_qs = model_config_rec%pert_farms_qs(id_id)
  RETURN
END SUBROUTINE nl_get_pert_farms_qs
SUBROUTINE nl_get_pert_deng ( id_id , pert_deng )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_deng
  INTEGER id_id
  pert_deng = model_config_rec%pert_deng(id_id)
  RETURN
END SUBROUTINE nl_get_pert_deng
SUBROUTINE nl_get_pert_deng_qv ( id_id , pert_deng_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_deng_qv
  INTEGER id_id
  pert_deng_qv = model_config_rec%pert_deng_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_deng_qv
SUBROUTINE nl_get_pert_deng_qc ( id_id , pert_deng_qc )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_deng_qc
  INTEGER id_id
  pert_deng_qc = model_config_rec%pert_deng_qc(id_id)
  RETURN
END SUBROUTINE nl_get_pert_deng_qc
SUBROUTINE nl_get_pert_deng_t ( id_id , pert_deng_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_deng_t
  INTEGER id_id
  pert_deng_t = model_config_rec%pert_deng_t(id_id)
  RETURN
END SUBROUTINE nl_get_pert_deng_t
SUBROUTINE nl_get_pert_deng_w ( id_id , pert_deng_w )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_deng_w
  INTEGER id_id
  pert_deng_w = model_config_rec%pert_deng_w(id_id)
  RETURN
END SUBROUTINE nl_get_pert_deng_w
SUBROUTINE nl_get_pert_mynn ( id_id , pert_mynn )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_mynn
  INTEGER id_id
  pert_mynn = model_config_rec%pert_mynn(id_id)
  RETURN
END SUBROUTINE nl_get_pert_mynn
SUBROUTINE nl_get_pert_mynn_qv ( id_id , pert_mynn_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_mynn_qv
  INTEGER id_id
  pert_mynn_qv = model_config_rec%pert_mynn_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_mynn_qv
SUBROUTINE nl_get_pert_mynn_qc ( id_id , pert_mynn_qc )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_mynn_qc
  INTEGER id_id
  pert_mynn_qc = model_config_rec%pert_mynn_qc(id_id)
  RETURN
END SUBROUTINE nl_get_pert_mynn_qc
SUBROUTINE nl_get_pert_mynn_t ( id_id , pert_mynn_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_mynn_t
  INTEGER id_id
  pert_mynn_t = model_config_rec%pert_mynn_t(id_id)
  RETURN
END SUBROUTINE nl_get_pert_mynn_t
SUBROUTINE nl_get_pert_mynn_qke ( id_id , pert_mynn_qke )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_mynn_qke
  INTEGER id_id
  pert_mynn_qke = model_config_rec%pert_mynn_qke(id_id)
  RETURN
END SUBROUTINE nl_get_pert_mynn_qke
SUBROUTINE nl_get_pert_noah ( id_id , pert_noah )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_noah
  INTEGER id_id
  pert_noah = model_config_rec%pert_noah(id_id)
  RETURN
END SUBROUTINE nl_get_pert_noah
SUBROUTINE nl_get_pert_noah_qv ( id_id , pert_noah_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_noah_qv
  INTEGER id_id
  pert_noah_qv = model_config_rec%pert_noah_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_noah_qv
SUBROUTINE nl_get_pert_noah_t ( id_id , pert_noah_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_noah_t
  INTEGER id_id
  pert_noah_t = model_config_rec%pert_noah_t(id_id)
  RETURN
END SUBROUTINE nl_get_pert_noah_t
SUBROUTINE nl_get_pert_noah_smois ( id_id , pert_noah_smois )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_noah_smois
  INTEGER id_id
  pert_noah_smois = model_config_rec%pert_noah_smois(id_id)
  RETURN
END SUBROUTINE nl_get_pert_noah_smois
SUBROUTINE nl_get_pert_noah_tslb ( id_id , pert_noah_tslb )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_noah_tslb
  INTEGER id_id
  pert_noah_tslb = model_config_rec%pert_noah_tslb(id_id)
  RETURN
END SUBROUTINE nl_get_pert_noah_tslb
SUBROUTINE nl_get_pert_thom ( id_id , pert_thom )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_thom
  INTEGER id_id
  pert_thom = model_config_rec%pert_thom(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom
SUBROUTINE nl_get_pert_thom_qv ( id_id , pert_thom_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_thom_qv
  INTEGER id_id
  pert_thom_qv = model_config_rec%pert_thom_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom_qv
SUBROUTINE nl_get_pert_thom_qc ( id_id , pert_thom_qc )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_thom_qc
  INTEGER id_id
  pert_thom_qc = model_config_rec%pert_thom_qc(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom_qc
SUBROUTINE nl_get_pert_thom_qi ( id_id , pert_thom_qi )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_thom_qi
  INTEGER id_id
  pert_thom_qi = model_config_rec%pert_thom_qi(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom_qi
SUBROUTINE nl_get_pert_thom_qs ( id_id , pert_thom_qs )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_thom_qs
  INTEGER id_id
  pert_thom_qs = model_config_rec%pert_thom_qs(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom_qs
SUBROUTINE nl_get_pert_thom_ni ( id_id , pert_thom_ni )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_thom_ni
  INTEGER id_id
  pert_thom_ni = model_config_rec%pert_thom_ni(id_id)
  RETURN
END SUBROUTINE nl_get_pert_thom_ni
SUBROUTINE nl_get_pert_cld3 ( id_id , pert_cld3 )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: pert_cld3
  INTEGER id_id
  pert_cld3 = model_config_rec%pert_cld3(id_id)
  RETURN
END SUBROUTINE nl_get_pert_cld3
SUBROUTINE nl_get_pert_cld3_qv ( id_id , pert_cld3_qv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_cld3_qv
  INTEGER id_id
  pert_cld3_qv = model_config_rec%pert_cld3_qv(id_id)
  RETURN
END SUBROUTINE nl_get_pert_cld3_qv
SUBROUTINE nl_get_pert_cld3_t ( id_id , pert_cld3_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: pert_cld3_t
  INTEGER id_id
  pert_cld3_t = model_config_rec%pert_cld3_t(id_id)
  RETURN
END SUBROUTINE nl_get_pert_cld3_t
SUBROUTINE nl_get_spdt ( id_id , spdt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: spdt
  INTEGER id_id
  spdt = model_config_rec%spdt(id_id)
  RETURN
END SUBROUTINE nl_get_spdt
SUBROUTINE nl_get_num_pert_3d ( id_id , num_pert_3d )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: num_pert_3d
  INTEGER id_id
  num_pert_3d = model_config_rec%num_pert_3d
  RETURN
END SUBROUTINE nl_get_num_pert_3d
SUBROUTINE nl_get_nens ( id_id , nens )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nens
  INTEGER id_id
  nens = model_config_rec%nens
  RETURN
END SUBROUTINE nl_get_nens
SUBROUTINE nl_get_skebs ( id_id , skebs )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: skebs
  INTEGER id_id
  skebs = model_config_rec%skebs(id_id)
  RETURN
END SUBROUTINE nl_get_skebs
SUBROUTINE nl_get_stoch_force_opt ( id_id , stoch_force_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: stoch_force_opt
  INTEGER id_id
  stoch_force_opt = model_config_rec%stoch_force_opt(id_id)
  RETURN
END SUBROUTINE nl_get_stoch_force_opt
SUBROUTINE nl_get_skebs_vertstruc ( id_id , skebs_vertstruc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: skebs_vertstruc
  INTEGER id_id
  skebs_vertstruc = model_config_rec%skebs_vertstruc
  RETURN
END SUBROUTINE nl_get_skebs_vertstruc
SUBROUTINE nl_get_stoch_vertstruc_opt ( id_id , stoch_vertstruc_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: stoch_vertstruc_opt
  INTEGER id_id
  stoch_vertstruc_opt = model_config_rec%stoch_vertstruc_opt(id_id)
  RETURN
END SUBROUTINE nl_get_stoch_vertstruc_opt
SUBROUTINE nl_get_tot_backscat_psi ( id_id , tot_backscat_psi )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: tot_backscat_psi
  INTEGER id_id
  tot_backscat_psi = model_config_rec%tot_backscat_psi(id_id)
  RETURN
END SUBROUTINE nl_get_tot_backscat_psi
SUBROUTINE nl_get_tot_backscat_t ( id_id , tot_backscat_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: tot_backscat_t
  INTEGER id_id
  tot_backscat_t = model_config_rec%tot_backscat_t(id_id)
  RETURN
END SUBROUTINE nl_get_tot_backscat_t
SUBROUTINE nl_get_ztau_psi ( id_id , ztau_psi )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: ztau_psi
  INTEGER id_id
  ztau_psi = model_config_rec%ztau_psi
  RETURN
END SUBROUTINE nl_get_ztau_psi
SUBROUTINE nl_get_ztau_t ( id_id , ztau_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: ztau_t
  INTEGER id_id
  ztau_t = model_config_rec%ztau_t
  RETURN
END SUBROUTINE nl_get_ztau_t
SUBROUTINE nl_get_rexponent_psi ( id_id , rexponent_psi )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: rexponent_psi
  INTEGER id_id
  rexponent_psi = model_config_rec%rexponent_psi
  RETURN
END SUBROUTINE nl_get_rexponent_psi
SUBROUTINE nl_get_rexponent_t ( id_id , rexponent_t )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: rexponent_t
  INTEGER id_id
  rexponent_t = model_config_rec%rexponent_t
  RETURN
END SUBROUTINE nl_get_rexponent_t
SUBROUTINE nl_get_zsigma2_eps ( id_id , zsigma2_eps )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: zsigma2_eps
  INTEGER id_id
  zsigma2_eps = model_config_rec%zsigma2_eps
  RETURN
END SUBROUTINE nl_get_zsigma2_eps
SUBROUTINE nl_get_zsigma2_eta ( id_id , zsigma2_eta )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: zsigma2_eta
  INTEGER id_id
  zsigma2_eta = model_config_rec%zsigma2_eta
  RETURN
END SUBROUTINE nl_get_zsigma2_eta
SUBROUTINE nl_get_kminforc ( id_id , kminforc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kminforc
  INTEGER id_id
  kminforc = model_config_rec%kminforc
  RETURN
END SUBROUTINE nl_get_kminforc
SUBROUTINE nl_get_lminforc ( id_id , lminforc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lminforc
  INTEGER id_id
  lminforc = model_config_rec%lminforc
  RETURN
END SUBROUTINE nl_get_lminforc
SUBROUTINE nl_get_kminforct ( id_id , kminforct )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kminforct
  INTEGER id_id
  kminforct = model_config_rec%kminforct
  RETURN
END SUBROUTINE nl_get_kminforct
SUBROUTINE nl_get_lminforct ( id_id , lminforct )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lminforct
  INTEGER id_id
  lminforct = model_config_rec%lminforct
  RETURN
END SUBROUTINE nl_get_lminforct
SUBROUTINE nl_get_kmaxforc ( id_id , kmaxforc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kmaxforc
  INTEGER id_id
  kmaxforc = model_config_rec%kmaxforc
  RETURN
END SUBROUTINE nl_get_kmaxforc
SUBROUTINE nl_get_lmaxforc ( id_id , lmaxforc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lmaxforc
  INTEGER id_id
  lmaxforc = model_config_rec%lmaxforc
  RETURN
END SUBROUTINE nl_get_lmaxforc
SUBROUTINE nl_get_kmaxforct ( id_id , kmaxforct )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kmaxforct
  INTEGER id_id
  kmaxforct = model_config_rec%kmaxforct
  RETURN
END SUBROUTINE nl_get_kmaxforct
SUBROUTINE nl_get_lmaxforct ( id_id , lmaxforct )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lmaxforct
  INTEGER id_id
  lmaxforct = model_config_rec%lmaxforct
  RETURN
END SUBROUTINE nl_get_lmaxforct
SUBROUTINE nl_get_iseed_skebs ( id_id , iseed_skebs )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_skebs
  INTEGER id_id
  iseed_skebs = model_config_rec%iseed_skebs
  RETURN
END SUBROUTINE nl_get_iseed_skebs
SUBROUTINE nl_get_kmaxforch ( id_id , kmaxforch )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kmaxforch
  INTEGER id_id
  kmaxforch = model_config_rec%kmaxforch
  RETURN
END SUBROUTINE nl_get_kmaxforch
SUBROUTINE nl_get_lmaxforch ( id_id , lmaxforch )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lmaxforch
  INTEGER id_id
  lmaxforch = model_config_rec%lmaxforch
  RETURN
END SUBROUTINE nl_get_lmaxforch
SUBROUTINE nl_get_kmaxforcth ( id_id , kmaxforcth )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: kmaxforcth
  INTEGER id_id
  kmaxforcth = model_config_rec%kmaxforcth
  RETURN
END SUBROUTINE nl_get_kmaxforcth
SUBROUTINE nl_get_lmaxforcth ( id_id , lmaxforcth )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: lmaxforcth
  INTEGER id_id
  lmaxforcth = model_config_rec%lmaxforcth
  RETURN
END SUBROUTINE nl_get_lmaxforcth
SUBROUTINE nl_get_sppt ( id_id , sppt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sppt
  INTEGER id_id
  sppt = model_config_rec%sppt(id_id)
  RETURN
END SUBROUTINE nl_get_sppt
SUBROUTINE nl_get_gridpt_stddev_sppt ( id_id , gridpt_stddev_sppt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: gridpt_stddev_sppt
  INTEGER id_id
  gridpt_stddev_sppt = model_config_rec%gridpt_stddev_sppt(id_id)
  RETURN
END SUBROUTINE nl_get_gridpt_stddev_sppt
SUBROUTINE nl_get_stddev_cutoff_sppt ( id_id , stddev_cutoff_sppt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: stddev_cutoff_sppt
  INTEGER id_id
  stddev_cutoff_sppt = model_config_rec%stddev_cutoff_sppt(id_id)
  RETURN
END SUBROUTINE nl_get_stddev_cutoff_sppt
SUBROUTINE nl_get_lengthscale_sppt ( id_id , lengthscale_sppt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lengthscale_sppt
  INTEGER id_id
  lengthscale_sppt = model_config_rec%lengthscale_sppt(id_id)
  RETURN
END SUBROUTINE nl_get_lengthscale_sppt
SUBROUTINE nl_get_timescale_sppt ( id_id , timescale_sppt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: timescale_sppt
  INTEGER id_id
  timescale_sppt = model_config_rec%timescale_sppt(id_id)
  RETURN
END SUBROUTINE nl_get_timescale_sppt
SUBROUTINE nl_get_sppt_vertstruc ( id_id , sppt_vertstruc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sppt_vertstruc
  INTEGER id_id
  sppt_vertstruc = model_config_rec%sppt_vertstruc
  RETURN
END SUBROUTINE nl_get_sppt_vertstruc
SUBROUTINE nl_get_iseed_sppt ( id_id , iseed_sppt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_sppt
  INTEGER id_id
  iseed_sppt = model_config_rec%iseed_sppt
  RETURN
END SUBROUTINE nl_get_iseed_sppt
SUBROUTINE nl_get_rand_perturb ( id_id , rand_perturb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: rand_perturb
  INTEGER id_id
  rand_perturb = model_config_rec%rand_perturb(id_id)
  RETURN
END SUBROUTINE nl_get_rand_perturb
SUBROUTINE nl_get_gridpt_stddev_rand_pert ( id_id , gridpt_stddev_rand_pert )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: gridpt_stddev_rand_pert
  INTEGER id_id
  gridpt_stddev_rand_pert = model_config_rec%gridpt_stddev_rand_pert(id_id)
  RETURN
END SUBROUTINE nl_get_gridpt_stddev_rand_pert
SUBROUTINE nl_get_stddev_cutoff_rand_pert ( id_id , stddev_cutoff_rand_pert )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: stddev_cutoff_rand_pert
  INTEGER id_id
  stddev_cutoff_rand_pert = model_config_rec%stddev_cutoff_rand_pert(id_id)
  RETURN
END SUBROUTINE nl_get_stddev_cutoff_rand_pert
SUBROUTINE nl_get_lengthscale_rand_pert ( id_id , lengthscale_rand_pert )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lengthscale_rand_pert
  INTEGER id_id
  lengthscale_rand_pert = model_config_rec%lengthscale_rand_pert(id_id)
  RETURN
END SUBROUTINE nl_get_lengthscale_rand_pert
SUBROUTINE nl_get_timescale_rand_pert ( id_id , timescale_rand_pert )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: timescale_rand_pert
  INTEGER id_id
  timescale_rand_pert = model_config_rec%timescale_rand_pert(id_id)
  RETURN
END SUBROUTINE nl_get_timescale_rand_pert
SUBROUTINE nl_get_rand_pert_vertstruc ( id_id , rand_pert_vertstruc )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: rand_pert_vertstruc
  INTEGER id_id
  rand_pert_vertstruc = model_config_rec%rand_pert_vertstruc
  RETURN
END SUBROUTINE nl_get_rand_pert_vertstruc
SUBROUTINE nl_get_iseed_rand_pert ( id_id , iseed_rand_pert )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_rand_pert
  INTEGER id_id
  iseed_rand_pert = model_config_rec%iseed_rand_pert
  RETURN
END SUBROUTINE nl_get_iseed_rand_pert
SUBROUTINE nl_get_spp ( id_id , spp )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: spp
  INTEGER id_id
  spp = model_config_rec%spp(id_id)
  RETURN
END SUBROUTINE nl_get_spp
SUBROUTINE nl_get_hrrr_cycling ( id_id , hrrr_cycling )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: hrrr_cycling
  INTEGER id_id
  hrrr_cycling = model_config_rec%hrrr_cycling
  RETURN
END SUBROUTINE nl_get_hrrr_cycling
SUBROUTINE nl_get_spp_conv ( id_id , spp_conv )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: spp_conv
  INTEGER id_id
  spp_conv = model_config_rec%spp_conv(id_id)
  RETURN
END SUBROUTINE nl_get_spp_conv
SUBROUTINE nl_get_gridpt_stddev_spp_conv ( id_id , gridpt_stddev_spp_conv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: gridpt_stddev_spp_conv
  INTEGER id_id
  gridpt_stddev_spp_conv = model_config_rec%gridpt_stddev_spp_conv(id_id)
  RETURN
END SUBROUTINE nl_get_gridpt_stddev_spp_conv
SUBROUTINE nl_get_stddev_cutoff_spp_conv ( id_id , stddev_cutoff_spp_conv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: stddev_cutoff_spp_conv
  INTEGER id_id
  stddev_cutoff_spp_conv = model_config_rec%stddev_cutoff_spp_conv(id_id)
  RETURN
END SUBROUTINE nl_get_stddev_cutoff_spp_conv
SUBROUTINE nl_get_lengthscale_spp_conv ( id_id , lengthscale_spp_conv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lengthscale_spp_conv
  INTEGER id_id
  lengthscale_spp_conv = model_config_rec%lengthscale_spp_conv(id_id)
  RETURN
END SUBROUTINE nl_get_lengthscale_spp_conv
SUBROUTINE nl_get_timescale_spp_conv ( id_id , timescale_spp_conv )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: timescale_spp_conv
  INTEGER id_id
  timescale_spp_conv = model_config_rec%timescale_spp_conv(id_id)
  RETURN
END SUBROUTINE nl_get_timescale_spp_conv
SUBROUTINE nl_get_vertstruc_spp_conv ( id_id , vertstruc_spp_conv )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: vertstruc_spp_conv
  INTEGER id_id
  vertstruc_spp_conv = model_config_rec%vertstruc_spp_conv
  RETURN
END SUBROUTINE nl_get_vertstruc_spp_conv
SUBROUTINE nl_get_iseed_spp_conv ( id_id , iseed_spp_conv )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_spp_conv
  INTEGER id_id
  iseed_spp_conv = model_config_rec%iseed_spp_conv
  RETURN
END SUBROUTINE nl_get_iseed_spp_conv
SUBROUTINE nl_get_spp_pbl ( id_id , spp_pbl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: spp_pbl
  INTEGER id_id
  spp_pbl = model_config_rec%spp_pbl(id_id)
  RETURN
END SUBROUTINE nl_get_spp_pbl
SUBROUTINE nl_get_gridpt_stddev_spp_pbl ( id_id , gridpt_stddev_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: gridpt_stddev_spp_pbl
  INTEGER id_id
  gridpt_stddev_spp_pbl = model_config_rec%gridpt_stddev_spp_pbl(id_id)
  RETURN
END SUBROUTINE nl_get_gridpt_stddev_spp_pbl
SUBROUTINE nl_get_stddev_cutoff_spp_pbl ( id_id , stddev_cutoff_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: stddev_cutoff_spp_pbl
  INTEGER id_id
  stddev_cutoff_spp_pbl = model_config_rec%stddev_cutoff_spp_pbl(id_id)
  RETURN
END SUBROUTINE nl_get_stddev_cutoff_spp_pbl
SUBROUTINE nl_get_lengthscale_spp_pbl ( id_id , lengthscale_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lengthscale_spp_pbl
  INTEGER id_id
  lengthscale_spp_pbl = model_config_rec%lengthscale_spp_pbl(id_id)
  RETURN
END SUBROUTINE nl_get_lengthscale_spp_pbl
SUBROUTINE nl_get_timescale_spp_pbl ( id_id , timescale_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: timescale_spp_pbl
  INTEGER id_id
  timescale_spp_pbl = model_config_rec%timescale_spp_pbl(id_id)
  RETURN
END SUBROUTINE nl_get_timescale_spp_pbl
SUBROUTINE nl_get_vertstruc_spp_pbl ( id_id , vertstruc_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: vertstruc_spp_pbl
  INTEGER id_id
  vertstruc_spp_pbl = model_config_rec%vertstruc_spp_pbl
  RETURN
END SUBROUTINE nl_get_vertstruc_spp_pbl
SUBROUTINE nl_get_iseed_spp_pbl ( id_id , iseed_spp_pbl )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_spp_pbl
  INTEGER id_id
  iseed_spp_pbl = model_config_rec%iseed_spp_pbl
  RETURN
END SUBROUTINE nl_get_iseed_spp_pbl
SUBROUTINE nl_get_spp_lsm ( id_id , spp_lsm )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: spp_lsm
  INTEGER id_id
  spp_lsm = model_config_rec%spp_lsm(id_id)
  RETURN
END SUBROUTINE nl_get_spp_lsm
SUBROUTINE nl_get_gridpt_stddev_spp_lsm ( id_id , gridpt_stddev_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: gridpt_stddev_spp_lsm
  INTEGER id_id
  gridpt_stddev_spp_lsm = model_config_rec%gridpt_stddev_spp_lsm(id_id)
  RETURN
END SUBROUTINE nl_get_gridpt_stddev_spp_lsm
SUBROUTINE nl_get_stddev_cutoff_spp_lsm ( id_id , stddev_cutoff_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: stddev_cutoff_spp_lsm
  INTEGER id_id
  stddev_cutoff_spp_lsm = model_config_rec%stddev_cutoff_spp_lsm(id_id)
  RETURN
END SUBROUTINE nl_get_stddev_cutoff_spp_lsm
SUBROUTINE nl_get_lengthscale_spp_lsm ( id_id , lengthscale_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lengthscale_spp_lsm
  INTEGER id_id
  lengthscale_spp_lsm = model_config_rec%lengthscale_spp_lsm(id_id)
  RETURN
END SUBROUTINE nl_get_lengthscale_spp_lsm
SUBROUTINE nl_get_timescale_spp_lsm ( id_id , timescale_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: timescale_spp_lsm
  INTEGER id_id
  timescale_spp_lsm = model_config_rec%timescale_spp_lsm(id_id)
  RETURN
END SUBROUTINE nl_get_timescale_spp_lsm
SUBROUTINE nl_get_vertstruc_spp_lsm ( id_id , vertstruc_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: vertstruc_spp_lsm
  INTEGER id_id
  vertstruc_spp_lsm = model_config_rec%vertstruc_spp_lsm
  RETURN
END SUBROUTINE nl_get_vertstruc_spp_lsm
SUBROUTINE nl_get_iseed_spp_lsm ( id_id , iseed_spp_lsm )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: iseed_spp_lsm
  INTEGER id_id
  iseed_spp_lsm = model_config_rec%iseed_spp_lsm
  RETURN
END SUBROUTINE nl_get_iseed_spp_lsm
SUBROUTINE nl_get_skebs_on ( id_id , skebs_on )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: skebs_on
  INTEGER id_id
  skebs_on = model_config_rec%skebs_on
  RETURN
END SUBROUTINE nl_get_skebs_on
SUBROUTINE nl_get_sppt_on ( id_id , sppt_on )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sppt_on
  INTEGER id_id
  sppt_on = model_config_rec%sppt_on
  RETURN
END SUBROUTINE nl_get_sppt_on
SUBROUTINE nl_get_spp_on ( id_id , spp_on )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: spp_on
  INTEGER id_id
  spp_on = model_config_rec%spp_on
  RETURN
END SUBROUTINE nl_get_spp_on
SUBROUTINE nl_get_rand_perturb_on ( id_id , rand_perturb_on )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: rand_perturb_on
  INTEGER id_id
  rand_perturb_on = model_config_rec%rand_perturb_on
  RETURN
END SUBROUTINE nl_get_rand_perturb_on
SUBROUTINE nl_get_num_stoch_levels ( id_id , num_stoch_levels )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: num_stoch_levels
  INTEGER id_id
  num_stoch_levels = model_config_rec%num_stoch_levels
  RETURN
END SUBROUTINE nl_get_num_stoch_levels
SUBROUTINE nl_get_seed_dim ( id_id , seed_dim )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: seed_dim
  INTEGER id_id
  seed_dim = model_config_rec%seed_dim
  RETURN
END SUBROUTINE nl_get_seed_dim
SUBROUTINE nl_get_sfs_opt ( id_id , sfs_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sfs_opt
  INTEGER id_id
  sfs_opt = model_config_rec%sfs_opt(id_id)
  RETURN
END SUBROUTINE nl_get_sfs_opt
SUBROUTINE nl_get_m_opt ( id_id , m_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: m_opt
  INTEGER id_id
  m_opt = model_config_rec%m_opt(id_id)
  RETURN
END SUBROUTINE nl_get_m_opt
SUBROUTINE nl_get_lakedepth_default ( id_id , lakedepth_default )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lakedepth_default
  INTEGER id_id
  lakedepth_default = model_config_rec%lakedepth_default(id_id)
  RETURN
END SUBROUTINE nl_get_lakedepth_default
SUBROUTINE nl_get_lake_min_elev ( id_id , lake_min_elev )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: lake_min_elev
  INTEGER id_id
  lake_min_elev = model_config_rec%lake_min_elev(id_id)
  RETURN
END SUBROUTINE nl_get_lake_min_elev
SUBROUTINE nl_get_use_lakedepth ( id_id , use_lakedepth )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: use_lakedepth
  INTEGER id_id
  use_lakedepth = model_config_rec%use_lakedepth(id_id)
  RETURN
END SUBROUTINE nl_get_use_lakedepth
SUBROUTINE nl_get_sbm_diagnostics ( id_id , sbm_diagnostics )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: sbm_diagnostics
  INTEGER id_id
  sbm_diagnostics = model_config_rec%sbm_diagnostics(id_id)
  RETURN
END SUBROUTINE nl_get_sbm_diagnostics
SUBROUTINE nl_get_afwa_diag_opt ( id_id , afwa_diag_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_diag_opt
  INTEGER id_id
  afwa_diag_opt = model_config_rec%afwa_diag_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_diag_opt
SUBROUTINE nl_get_afwa_ptype_opt ( id_id , afwa_ptype_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_ptype_opt
  INTEGER id_id
  afwa_ptype_opt = model_config_rec%afwa_ptype_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_ptype_opt
SUBROUTINE nl_get_afwa_vil_opt ( id_id , afwa_vil_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_vil_opt
  INTEGER id_id
  afwa_vil_opt = model_config_rec%afwa_vil_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_vil_opt
SUBROUTINE nl_get_afwa_radar_opt ( id_id , afwa_radar_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_radar_opt
  INTEGER id_id
  afwa_radar_opt = model_config_rec%afwa_radar_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_radar_opt
SUBROUTINE nl_get_afwa_severe_opt ( id_id , afwa_severe_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_severe_opt
  INTEGER id_id
  afwa_severe_opt = model_config_rec%afwa_severe_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_severe_opt
SUBROUTINE nl_get_afwa_icing_opt ( id_id , afwa_icing_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_icing_opt
  INTEGER id_id
  afwa_icing_opt = model_config_rec%afwa_icing_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_icing_opt
SUBROUTINE nl_get_afwa_vis_opt ( id_id , afwa_vis_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_vis_opt
  INTEGER id_id
  afwa_vis_opt = model_config_rec%afwa_vis_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_vis_opt
SUBROUTINE nl_get_afwa_cloud_opt ( id_id , afwa_cloud_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_cloud_opt
  INTEGER id_id
  afwa_cloud_opt = model_config_rec%afwa_cloud_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_cloud_opt
SUBROUTINE nl_get_afwa_therm_opt ( id_id , afwa_therm_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_therm_opt
  INTEGER id_id
  afwa_therm_opt = model_config_rec%afwa_therm_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_therm_opt
SUBROUTINE nl_get_afwa_turb_opt ( id_id , afwa_turb_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_turb_opt
  INTEGER id_id
  afwa_turb_opt = model_config_rec%afwa_turb_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_turb_opt
SUBROUTINE nl_get_afwa_buoy_opt ( id_id , afwa_buoy_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_buoy_opt
  INTEGER id_id
  afwa_buoy_opt = model_config_rec%afwa_buoy_opt(id_id)
  RETURN
END SUBROUTINE nl_get_afwa_buoy_opt
SUBROUTINE nl_get_afwa_ptype_ccn_tmp ( id_id , afwa_ptype_ccn_tmp )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: afwa_ptype_ccn_tmp
  INTEGER id_id
  afwa_ptype_ccn_tmp = model_config_rec%afwa_ptype_ccn_tmp
  RETURN
END SUBROUTINE nl_get_afwa_ptype_ccn_tmp
SUBROUTINE nl_get_afwa_ptype_tot_melt ( id_id , afwa_ptype_tot_melt )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: afwa_ptype_tot_melt
  INTEGER id_id
  afwa_ptype_tot_melt = model_config_rec%afwa_ptype_tot_melt
  RETURN
END SUBROUTINE nl_get_afwa_ptype_tot_melt
SUBROUTINE nl_get_afwa_bad_data_check ( id_id , afwa_bad_data_check )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: afwa_bad_data_check
  INTEGER id_id
  afwa_bad_data_check = model_config_rec%afwa_bad_data_check
  RETURN
END SUBROUTINE nl_get_afwa_bad_data_check
SUBROUTINE nl_get_mean_diag ( id_id , mean_diag )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag
  INTEGER id_id
  mean_diag = model_config_rec%mean_diag
  RETURN
END SUBROUTINE nl_get_mean_diag
SUBROUTINE nl_get_mean_freq ( id_id , mean_freq )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_freq
  INTEGER id_id
  mean_freq = model_config_rec%mean_freq
  RETURN
END SUBROUTINE nl_get_mean_freq
SUBROUTINE nl_get_mean_interval ( id_id , mean_interval )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_interval
  INTEGER id_id
  mean_interval = model_config_rec%mean_interval(id_id)
  RETURN
END SUBROUTINE nl_get_mean_interval
SUBROUTINE nl_get_mean_diag_interval ( id_id , mean_diag_interval )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval
  INTEGER id_id
  mean_diag_interval = model_config_rec%mean_diag_interval(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval
SUBROUTINE nl_get_mean_diag_interval_s ( id_id , mean_diag_interval_s )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval_s
  INTEGER id_id
  mean_diag_interval_s = model_config_rec%mean_diag_interval_s(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval_s
SUBROUTINE nl_get_mean_diag_interval_m ( id_id , mean_diag_interval_m )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval_m
  INTEGER id_id
  mean_diag_interval_m = model_config_rec%mean_diag_interval_m(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval_m
SUBROUTINE nl_get_mean_diag_interval_h ( id_id , mean_diag_interval_h )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval_h
  INTEGER id_id
  mean_diag_interval_h = model_config_rec%mean_diag_interval_h(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval_h
SUBROUTINE nl_get_mean_diag_interval_d ( id_id , mean_diag_interval_d )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval_d
  INTEGER id_id
  mean_diag_interval_d = model_config_rec%mean_diag_interval_d(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval_d
SUBROUTINE nl_get_mean_diag_interval_mo ( id_id , mean_diag_interval_mo )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mean_diag_interval_mo
  INTEGER id_id
  mean_diag_interval_mo = model_config_rec%mean_diag_interval_mo(id_id)
  RETURN
END SUBROUTINE nl_get_mean_diag_interval_mo
SUBROUTINE nl_get_diurnal_diag ( id_id , diurnal_diag )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: diurnal_diag
  INTEGER id_id
  diurnal_diag = model_config_rec%diurnal_diag
  RETURN
END SUBROUTINE nl_get_diurnal_diag
SUBROUTINE nl_get_nssl_ipelec ( id_id , nssl_ipelec )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nssl_ipelec
  INTEGER id_id
  nssl_ipelec = model_config_rec%nssl_ipelec(id_id)
  RETURN
END SUBROUTINE nl_get_nssl_ipelec
SUBROUTINE nl_get_nssl_isaund ( id_id , nssl_isaund )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nssl_isaund
  INTEGER id_id
  nssl_isaund = model_config_rec%nssl_isaund
  RETURN
END SUBROUTINE nl_get_nssl_isaund
SUBROUTINE nl_get_nssl_iscreen ( id_id , nssl_iscreen )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nssl_iscreen
  INTEGER id_id
  nssl_iscreen = model_config_rec%nssl_iscreen
  RETURN
END SUBROUTINE nl_get_nssl_iscreen
SUBROUTINE nl_get_nssl_lightrad ( id_id , nssl_lightrad )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: nssl_lightrad
  INTEGER id_id
  nssl_lightrad = model_config_rec%nssl_lightrad
  RETURN
END SUBROUTINE nl_get_nssl_lightrad
SUBROUTINE nl_get_nssl_idischarge ( id_id , nssl_idischarge )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nssl_idischarge
  INTEGER id_id
  nssl_idischarge = model_config_rec%nssl_idischarge
  RETURN
END SUBROUTINE nl_get_nssl_idischarge
SUBROUTINE nl_get_nssl_ibrkd ( id_id , nssl_ibrkd )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: nssl_ibrkd
  INTEGER id_id
  nssl_ibrkd = model_config_rec%nssl_ibrkd
  RETURN
END SUBROUTINE nl_get_nssl_ibrkd
SUBROUTINE nl_get_nssl_ecrit ( id_id , nssl_ecrit )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: nssl_ecrit
  INTEGER id_id
  nssl_ecrit = model_config_rec%nssl_ecrit
  RETURN
END SUBROUTINE nl_get_nssl_ecrit
SUBROUTINE nl_get_nssl_disfrac ( id_id , nssl_disfrac )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: nssl_disfrac
  INTEGER id_id
  nssl_disfrac = model_config_rec%nssl_disfrac
  RETURN
END SUBROUTINE nl_get_nssl_disfrac
SUBROUTINE nl_get_elec_physics ( id_id , elec_physics )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: elec_physics
  INTEGER id_id
  elec_physics = model_config_rec%elec_physics
  RETURN
END SUBROUTINE nl_get_elec_physics
SUBROUTINE nl_get_perturb_bdy ( id_id , perturb_bdy )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: perturb_bdy
  INTEGER id_id
  perturb_bdy = model_config_rec%perturb_bdy
  RETURN
END SUBROUTINE nl_get_perturb_bdy
SUBROUTINE nl_get_perturb_chem_bdy ( id_id , perturb_chem_bdy )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: perturb_chem_bdy
  INTEGER id_id
  perturb_chem_bdy = model_config_rec%perturb_chem_bdy
  RETURN
END SUBROUTINE nl_get_perturb_chem_bdy
SUBROUTINE nl_get_hybrid_opt ( id_id , hybrid_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: hybrid_opt
  INTEGER id_id
  hybrid_opt = model_config_rec%hybrid_opt
  RETURN
END SUBROUTINE nl_get_hybrid_opt
SUBROUTINE nl_get_etac ( id_id , etac )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: etac
  INTEGER id_id
  etac = model_config_rec%etac
  RETURN
END SUBROUTINE nl_get_etac
SUBROUTINE nl_get_num_wif_levels ( id_id , num_wif_levels )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: num_wif_levels
  INTEGER id_id
  num_wif_levels = model_config_rec%num_wif_levels
  RETURN
END SUBROUTINE nl_get_num_wif_levels
SUBROUTINE nl_get_wif_input_opt ( id_id , wif_input_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: wif_input_opt
  INTEGER id_id
  wif_input_opt = model_config_rec%wif_input_opt
  RETURN
END SUBROUTINE nl_get_wif_input_opt
SUBROUTINE nl_get_diag_nwp2 ( id_id , diag_nwp2 )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: diag_nwp2
  INTEGER id_id
  diag_nwp2 = model_config_rec%diag_nwp2
  RETURN
END SUBROUTINE nl_get_diag_nwp2
SUBROUTINE nl_get_solar_diagnostics ( id_id , solar_diagnostics )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: solar_diagnostics
  INTEGER id_id
  solar_diagnostics = model_config_rec%solar_diagnostics
  RETURN
END SUBROUTINE nl_get_solar_diagnostics
SUBROUTINE nl_get_p_lev_diags ( id_id , p_lev_diags )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: p_lev_diags
  INTEGER id_id
  p_lev_diags = model_config_rec%p_lev_diags
  RETURN
END SUBROUTINE nl_get_p_lev_diags
SUBROUTINE nl_get_p_lev_diags_dfi ( id_id , p_lev_diags_dfi )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: p_lev_diags_dfi
  INTEGER id_id
  p_lev_diags_dfi = model_config_rec%p_lev_diags_dfi
  RETURN
END SUBROUTINE nl_get_p_lev_diags_dfi
SUBROUTINE nl_get_num_press_levels ( id_id , num_press_levels )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: num_press_levels
  INTEGER id_id
  num_press_levels = model_config_rec%num_press_levels
  RETURN
END SUBROUTINE nl_get_num_press_levels
SUBROUTINE nl_get_press_levels ( id_id , press_levels )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: press_levels
  INTEGER id_id
  press_levels = model_config_rec%press_levels(id_id)
  RETURN
END SUBROUTINE nl_get_press_levels
SUBROUTINE nl_get_use_tot_or_hyd_p ( id_id , use_tot_or_hyd_p )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: use_tot_or_hyd_p
  INTEGER id_id
  use_tot_or_hyd_p = model_config_rec%use_tot_or_hyd_p
  RETURN
END SUBROUTINE nl_get_use_tot_or_hyd_p
SUBROUTINE nl_get_extrap_below_grnd ( id_id , extrap_below_grnd )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: extrap_below_grnd
  INTEGER id_id
  extrap_below_grnd = model_config_rec%extrap_below_grnd
  RETURN
END SUBROUTINE nl_get_extrap_below_grnd
SUBROUTINE nl_get_p_lev_missing ( id_id , p_lev_missing )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: p_lev_missing
  INTEGER id_id
  p_lev_missing = model_config_rec%p_lev_missing
  RETURN
END SUBROUTINE nl_get_p_lev_missing
SUBROUTINE nl_get_p_lev_interval ( id_id , p_lev_interval )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: p_lev_interval
  INTEGER id_id
  p_lev_interval = model_config_rec%p_lev_interval(id_id)
  RETURN
END SUBROUTINE nl_get_p_lev_interval
SUBROUTINE nl_get_z_lev_diags ( id_id , z_lev_diags )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: z_lev_diags
  INTEGER id_id
  z_lev_diags = model_config_rec%z_lev_diags
  RETURN
END SUBROUTINE nl_get_z_lev_diags
SUBROUTINE nl_get_z_lev_diags_dfi ( id_id , z_lev_diags_dfi )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: z_lev_diags_dfi
  INTEGER id_id
  z_lev_diags_dfi = model_config_rec%z_lev_diags_dfi
  RETURN
END SUBROUTINE nl_get_z_lev_diags_dfi
SUBROUTINE nl_get_num_z_levels ( id_id , num_z_levels )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: num_z_levels
  INTEGER id_id
  num_z_levels = model_config_rec%num_z_levels
  RETURN
END SUBROUTINE nl_get_num_z_levels
SUBROUTINE nl_get_z_levels ( id_id , z_levels )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: z_levels
  INTEGER id_id
  z_levels = model_config_rec%z_levels(id_id)
  RETURN
END SUBROUTINE nl_get_z_levels
SUBROUTINE nl_get_z_lev_missing ( id_id , z_lev_missing )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: z_lev_missing
  INTEGER id_id
  z_lev_missing = model_config_rec%z_lev_missing
  RETURN
END SUBROUTINE nl_get_z_lev_missing
SUBROUTINE nl_get_z_lev_interval ( id_id , z_lev_interval )
  USE module_configure, ONLY : model_config_rec
  real , INTENT(OUT) :: z_lev_interval
  INTEGER id_id
  z_lev_interval = model_config_rec%z_lev_interval(id_id)
  RETURN
END SUBROUTINE nl_get_z_lev_interval
SUBROUTINE nl_get_wrf_cmaq_option ( id_id , wrf_cmaq_option )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: wrf_cmaq_option
  INTEGER id_id
  wrf_cmaq_option = model_config_rec%wrf_cmaq_option
  RETURN
END SUBROUTINE nl_get_wrf_cmaq_option
SUBROUTINE nl_get_wrf_cmaq_freq ( id_id , wrf_cmaq_freq )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: wrf_cmaq_freq
  INTEGER id_id
  wrf_cmaq_freq = model_config_rec%wrf_cmaq_freq
  RETURN
END SUBROUTINE nl_get_wrf_cmaq_freq
SUBROUTINE nl_get_met_file_tstep ( id_id , met_file_tstep )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: met_file_tstep
  INTEGER id_id
  met_file_tstep = model_config_rec%met_file_tstep
  RETURN
END SUBROUTINE nl_get_met_file_tstep
SUBROUTINE nl_get_direct_sw_feedback ( id_id , direct_sw_feedback )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: direct_sw_feedback
  INTEGER id_id
  direct_sw_feedback = model_config_rec%direct_sw_feedback
  RETURN
END SUBROUTINE nl_get_direct_sw_feedback
SUBROUTINE nl_get_feedback_restart ( id_id , feedback_restart )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: feedback_restart
  INTEGER id_id
  feedback_restart = model_config_rec%feedback_restart
  RETURN
END SUBROUTINE nl_get_feedback_restart
SUBROUTINE nl_get_mcm_opt ( id_id , mcm_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mcm_opt
  INTEGER id_id
  mcm_opt = model_config_rec%mcm_opt(id_id)
  RETURN
END SUBROUTINE nl_get_mcm_opt
SUBROUTINE nl_get_mcm_link_rad ( id_id , mcm_link_rad )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: mcm_link_rad
  INTEGER id_id
  mcm_link_rad = model_config_rec%mcm_link_rad(id_id)
  RETURN
END SUBROUTINE nl_get_mcm_link_rad
SUBROUTINE nl_get_mcm_use_3d_lad ( id_id , mcm_use_3d_lad )
  USE module_configure, ONLY : model_config_rec
  logical , INTENT(OUT) :: mcm_use_3d_lad
  INTEGER id_id
  mcm_use_3d_lad = model_config_rec%mcm_use_3d_lad(id_id)
  RETURN
END SUBROUTINE nl_get_mcm_use_3d_lad
SUBROUTINE nl_get_mcm_model ( id_id , mcm_model )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: mcm_model
  INTEGER id_id
  mcm_model = model_config_rec%mcm_model(id_id)
  RETURN
END SUBROUTINE nl_get_mcm_model
SUBROUTINE nl_get_scpm_jdm_opt ( id_id , scpm_jdm_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: scpm_jdm_opt
  INTEGER id_id
  scpm_jdm_opt = model_config_rec%scpm_jdm_opt(id_id)
  RETURN
END SUBROUTINE nl_get_scpm_jdm_opt
SUBROUTINE nl_get_scpm_nb ( id_id , scpm_nb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: scpm_nb
  INTEGER id_id
  scpm_nb = model_config_rec%scpm_nb(id_id)
  RETURN
END SUBROUTINE nl_get_scpm_nb
SUBROUTINE nl_get_scpm_sb ( id_id , scpm_sb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: scpm_sb
  INTEGER id_id
  scpm_sb = model_config_rec%scpm_sb(id_id)
  RETURN
END SUBROUTINE nl_get_scpm_sb
SUBROUTINE nl_get_scpm_eb ( id_id , scpm_eb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: scpm_eb
  INTEGER id_id
  scpm_eb = model_config_rec%scpm_eb(id_id)
  RETURN
END SUBROUTINE nl_get_scpm_eb
SUBROUTINE nl_get_scpm_wb ( id_id , scpm_wb )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: scpm_wb
  INTEGER id_id
  scpm_wb = model_config_rec%scpm_wb(id_id)
  RETURN
END SUBROUTINE nl_get_scpm_wb
SUBROUTINE nl_get_m_pblh_opt ( id_id , m_pblh_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: m_pblh_opt
  INTEGER id_id
  m_pblh_opt = model_config_rec%m_pblh_opt(id_id)
  RETURN
END SUBROUTINE nl_get_m_pblh_opt
SUBROUTINE nl_get_chem_opt ( id_id , chem_opt )
  USE module_configure, ONLY : model_config_rec
  integer , INTENT(OUT) :: chem_opt
  INTEGER id_id
  chem_opt = model_config_rec%chem_opt(id_id)
  RETURN
END SUBROUTINE nl_get_chem_opt
!ENDOFREGISTRYGENERATEDINCLUDE
