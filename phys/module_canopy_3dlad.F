module module_canopy_3dlad

   use module_dm
   implicit none

   logical :: canopy_3dlad_initialized = .false.

   integer :: nk_3dlad

   real, allocatable :: lad_3d(:,:,:)
   real, allocatable :: canopyz_2d(:,:)
   real, allocatable :: lad_z_3d(:)

contains


subroutine init_canopy_3dlad( id, ims, ime, jms, jme )

   use module_dm
   use module_wrf_error
   use module_domain_type
   implicit none
   LOGICAL, EXTERNAL  :: wrf_dm_on_monitor

   character(len=256) :: filename
   character(len=2)   :: dom_id_str

   integer, intent(in) :: id, ims, ime, jms, jme
   integer :: ni, nj
   logical :: is_monitor

   if ( canopy_3dlad_initialized ) return

   ! The external NetCDF reader has been disabled: 3D LAD data
   ! must be provided via wrfinput/restart (grid%lad_3d, canopyz_2d,
   ! lad_z_3d). Simply mark initialized and return.
   canopy_3dlad_initialized = .true.

end subroutine init_canopy_3dlad


subroutine read_canopy_3dlad_monitor( lad_3d,              &
                                      canopyz_2d,          &
                                      lad_z_3d,             &
                                      nk,                  &
                                      ims, ime, jms, jme )

   use netcdf
   use module_wrf_error
   implicit none

   integer, intent(out) :: nk
   integer, intent(in) :: ims, ime, jms, jme

   real, allocatable, intent(out) :: lad_3d(:,:,:)
   real, allocatable, intent(out) :: canopyz_2d(:,:)
   real, allocatable, intent(out) :: lad_z_3d(:)

   integer :: ncid, ierr
   integer :: varid_lad, varid_canopyz, varid_z
   integer :: dimid_k

   integer :: ni, nj, i, j, k

   real, allocatable :: lad_tmp(:,:,:)   ! (k,j,i)
   real, allocatable :: canopyz_tmp(:,:)   ! (j,i)

   ni = ime - ims + 1
   nj = jme - jms + 1

   !---------------------------------------------------------------
   ! Open file
   !---------------------------------------------------------------
   ierr = nf90_open(trim('./mcanopy_inputs.nc'), NF90_NOWRITE, ncid)
   if ( ierr /= NF90_NOERR ) then
      call wrf_error_fatal('3D LAD: cannot open ./mcanopy_inputs.nc')
   endif

   !---------------------------------------------------------------
   ! Vertical dimension
   !---------------------------------------------------------------
   ierr = nf90_inq_dimid(ncid, 'z-dimension0020', dimid_k)
   if ( ierr /= NF90_NOERR ) then
      call wrf_error_fatal('3D LAD: missing z-dimension0020')
   endif

!   call nf90_inquire_dimension(ncid, dimid_k, len=nk)
   ierr = nf90_inquire_dimension(ncid, dimid_k, len=nk)
   if (ierr /= nf90_noerr) then
      call wrf_error_fatal('Failed to inquire dimension z')
   endif


   !---------------------------------------------------------------
   ! Allocate outputs
   !---------------------------------------------------------------
   allocate( lad_3d(ims:ime, nk, jms:jme) )
   allocate( canopyz_2d(ims:ime, jms:jme) )
   allocate( lad_z_3d(nk) )

   allocate( lad_tmp(nk, nj, ni) )
   allocate( canopyz_tmp(nj, ni) )

   !---------------------------------------------------------------
   ! Variable IDs
   !---------------------------------------------------------------
   ierr = nf90_inq_varid(ncid, 'LAD',      varid_lad)
   if (ierr /= nf90_noerr) then
      call wrf_error_fatal('Failed to inquire varID LAD')
   endif
   ierr = nf90_inq_varid(ncid, 'CANOPYZ',  varid_canopyz)
   if (ierr /= nf90_noerr) then
      call wrf_error_fatal('Failed to inquire varID CANOPYZ')
   endif
   ierr = nf90_inq_varid(ncid, 'z0020',    varid_z)
   if (ierr /= nf90_noerr) then
      call wrf_error_fatal('Failed to inquire varID z0020')
   endif

   !---------------------------------------------------------------
   ! Read LAD (Time,k,j,i)
   !---------------------------------------------------------------
   ierr = nf90_get_var( ncid, varid_lad, lad_tmp, &
                        start=(/1,1,1/),        &
                        count=(/nk,nj,ni/) )

   !---------------------------------------------------------------
   ! Reorder to WRF (i,k,j)
   !---------------------------------------------------------------
!   lad_3d = transpose(lad_tmp3d, (/3,1,2/))

   !---------------------------------------------------------------
   ! CANOPYZ (j,i → i,j)
   !---------------------------------------------------------------
   ierr = nf90_get_var( ncid, varid_canopyz, canopyz_tmp )
!   canopyz_2d = transpose(canopyz_2d)

   !---------------------------------------------------------------
   ! z coordinate
   !---------------------------------------------------------------
   ierr = nf90_get_var( ncid, varid_z, lad_z_3d )

   !---------------------------------------------------------------
   ! Reshape arrays:
   !---------------------------------------------------------------

   do j = jms, jme
      do i = ims, ime
         do k = 1, nk
            lad_3d(i,k,j) = lad_tmp(k,j,i)
         end do
         canopyz_2d(i,j) = canopyz_tmp(j,i)
      end do
   end do


   ierr = nf90_close(ncid)

   deallocate(lad_tmp)

end subroutine read_canopy_3dlad_monitor

end module module_canopy_3dlad

