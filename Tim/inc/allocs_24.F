!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_24.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_24( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
         sd31, ed31, sd32, ed32, sd33, ed33, &
         sm31 , em31 , sm32 , em32 , sm33 , em33 , &
         sp31 , ep31 , sp32 , ep32 , sp33 , ep33 , &
         sp31x, ep31x, sp32x, ep32x, sp33x, ep33x, &
         sp31y, ep31y, sp32y, ep32y, sp33y, ep33y, &
         sm31x, em31x, sm32x, em32x, sm33x, em33x, &
         sm31y, em31y, sm32y, em32y, sm33y, em33y )
  USE module_domain_type
  USE module_configure, ONLY : model_config_rec, grid_config_rec_type, in_use_for_config, model_to_grid_config_rec
  USE module_scalar_tables ! this includes module_state_description too
  IMPLICIT NONE
  !  Input data.

  TYPE(domain)               , POINTER          :: grid
  INTEGER , INTENT(IN)            :: id
  INTEGER , INTENT(IN)            :: setinitval_in   ! 3 = everything, 1 = arrays only, 0 = none
  INTEGER , INTENT(IN)            :: sd31, ed31, sd32, ed32, sd33, ed33
  INTEGER , INTENT(IN)            :: sm31, em31, sm32, em32, sm33, em33
  INTEGER , INTENT(IN)            :: sp31, ep31, sp32, ep32, sp33, ep33
  INTEGER , INTENT(IN)            :: sp31x, ep31x, sp32x, ep32x, sp33x, ep33x
  INTEGER , INTENT(IN)            :: sp31y, ep31y, sp32y, ep32y, sp33y, ep33y
  INTEGER , INTENT(IN)            :: sm31x, em31x, sm32x, em32x, sm33x, em33x
  INTEGER , INTENT(IN)            :: sm31y, em31y, sm32y, em32y, sm33y, em33y

  ! this argument is a bitmask. First bit is time level 1, second is time level 2, and so on.
  ! e.g. to set both 1st and second time level, use 3
  !      to set only 1st                        use 1
  !      to set only 2st                        use 2
  INTEGER , INTENT(IN)            :: tl_in

  ! true if the allocation is for an intermediate domain (for nesting); only certain fields allocated
  ! false otherwise (all allocated, modulo tl above)
  LOGICAL , INTENT(IN)            :: inter_domain_in, okay_to_alloc_in

  INTEGER(KIND=8) , INTENT(INOUT)         :: num_bytes_allocated
  !  Local data.
  INTEGER idum1, idum2, spec_bdy_width
  REAL    initial_data_value
  CHARACTER (LEN=256) message
  INTEGER tl
  LOGICAL inter_domain, okay_to_alloc
  INTEGER setinitval
  INTEGER sr_x, sr_y

  !declare ierr variable for error checking ALLOCATE calls
  INTEGER ierr

  INTEGER                              :: loop
  INTEGER(KIND=8)                      :: nba ! number of bytes allocated per variable
  CHARACTER(LEN=256)                   :: message_string

  ! Local data

  TYPE ( grid_config_rec_type ) :: config_flags

  INTEGER                         :: k_start , k_end, its, ite, jts, jte
  INTEGER                         :: ids , ide , jds , jde , kds , kde , &
                                    ims , ime , jms , jme , kms , kme , &
                                    ips , ipe , jps , jpe , kps , kpe

  INTEGER                         :: sids , side , sjds , sjde , skds , skde , &
                                    sims , sime , sjms , sjme , skms , skme , &
                                    sips , sipe , sjps , sjpe , skps , skpe

  INTEGER ::              imsx, imex, jmsx, jmex, kmsx, kmex,    &
                          ipsx, ipex, jpsx, jpex, kpsx, kpex,    &
                          imsy, imey, jmsy, jmey, kmsy, kmey,    &
                          ipsy, ipey, jpsy, jpey, kpsy, kpey

  data_ordering : SELECT CASE ( model_data_order )
    CASE  ( DATA_ORDER_XYZ )
        ids = sd31 ; ide = ed31 ; jds = sd32 ; jde = ed32 ; kds = sd33 ; kde = ed33 ;
        ims = sm31 ; ime = em31 ; jms = sm32 ; jme = em32 ; kms = sm33 ; kme = em33 ;
        ips = sp31 ; ipe = ep31 ; jps = sp32 ; jpe = ep32 ; kps = sp33 ; kpe = ep33 ;
        imsx = sm31x ; imex = em31x ; jmsx = sm32x ; jmex = em32x ; kmsx = sm33x ; kmex = em33x ;
        ipsx = sp31x ; ipex = ep31x ; jpsx = sp32x ; jpex = ep32x ; kpsx = sp33x ; kpex = ep33x ;
        imsy = sm31y ; imey = em31y ; jmsy = sm32y ; jmey = em32y ; kmsy = sm33y ; kmey = em33y ;
        ipsy = sp31y ; ipey = ep31y ; jpsy = sp32y ; jpey = ep32y ; kpsy = sp33y ; kpey = ep33y ;
    CASE  ( DATA_ORDER_YXZ )
        ids = sd32  ; ide = ed32  ; jds = sd31  ; jde = ed31  ; kds = sd33  ; kde = ed33  ;
        ims = sm32  ; ime = em32  ; jms = sm31  ; jme = em31  ; kms = sm33  ; kme = em33  ;
        ips = sp32  ; ipe = ep32  ; jps = sp31  ; jpe = ep31  ; kps = sp33  ; kpe = ep33  ;
        imsx = sm32x  ; imex = em32x  ; jmsx = sm31x  ; jmex = em31x  ; kmsx = sm33x  ; kmex = em33x  ;
        ipsx = sp32x  ; ipex = ep32x  ; jpsx = sp31x  ; jpex = ep31x  ; kpsx = sp33x  ; kpex = ep33x  ;
        imsy = sm32y  ; imey = em32y  ; jmsy = sm31y  ; jmey = em31y  ; kmsy = sm33y  ; kmey = em33y  ;
        ipsy = sp32y  ; ipey = ep32y  ; jpsy = sp31y  ; jpey = ep31y  ; kpsy = sp33y  ; kpey = ep33y  ;
    CASE  ( DATA_ORDER_ZXY )
        ids = sd32  ; ide = ed32  ; jds = sd33  ; jde = ed33  ; kds = sd31  ; kde = ed31  ;
        ims = sm32  ; ime = em32  ; jms = sm33  ; jme = em33  ; kms = sm31  ; kme = em31  ;
        ips = sp32  ; ipe = ep32  ; jps = sp33  ; jpe = ep33  ; kps = sp31  ; kpe = ep31  ;
        imsx = sm32x  ; imex = em32x  ; jmsx = sm33x  ; jmex = em33x  ; kmsx = sm31x  ; kmex = em31x  ;
        ipsx = sp32x  ; ipex = ep32x  ; jpsx = sp33x  ; jpex = ep33x  ; kpsx = sp31x  ; kpex = ep31x  ;
        imsy = sm32y  ; imey = em32y  ; jmsy = sm33y  ; jmey = em33y  ; kmsy = sm31y  ; kmey = em31y  ;
        ipsy = sp32y  ; ipey = ep32y  ; jpsy = sp33y  ; jpey = ep33y  ; kpsy = sp31y  ; kpey = ep31y  ;
    CASE  ( DATA_ORDER_ZYX )
        ids = sd33  ; ide = ed33  ; jds = sd32  ; jde = ed32  ; kds = sd31  ; kde = ed31  ;
        ims = sm33  ; ime = em33  ; jms = sm32  ; jme = em32  ; kms = sm31  ; kme = em31  ;
        ips = sp33  ; ipe = ep33  ; jps = sp32  ; jpe = ep32  ; kps = sp31  ; kpe = ep31  ;
        imsx = sm33x  ; imex = em33x  ; jmsx = sm32x  ; jmex = em32x  ; kmsx = sm31x  ; kmex = em31x  ;
        ipsx = sp33x  ; ipex = ep33x  ; jpsx = sp32x  ; jpex = ep32x  ; kpsx = sp31x  ; kpex = ep31x  ;
        imsy = sm33y  ; imey = em33y  ; jmsy = sm32y  ; jmey = em32y  ; kmsy = sm31y  ; kmey = em31y  ;
        ipsy = sp33y  ; ipey = ep33y  ; jpsy = sp32y  ; jpey = ep32y  ; kpsy = sp31y  ; kpey = ep31y  ;
    CASE  ( DATA_ORDER_XZY )
        ids = sd31  ; ide = ed31  ; jds = sd33  ; jde = ed33  ; kds = sd32  ; kde = ed32  ;
        ims = sm31  ; ime = em31  ; jms = sm33  ; jme = em33  ; kms = sm32  ; kme = em32  ;
        ips = sp31  ; ipe = ep31  ; jps = sp33  ; jpe = ep33  ; kps = sp32  ; kpe = ep32  ;
        imsx = sm31x  ; imex = em31x  ; jmsx = sm33x  ; jmex = em33x  ; kmsx = sm32x  ; kmex = em32x  ;
        ipsx = sp31x  ; ipex = ep31x  ; jpsx = sp33x  ; jpex = ep33x  ; kpsx = sp32x  ; kpex = ep32x  ;
        imsy = sm31y  ; imey = em31y  ; jmsy = sm33y  ; jmey = em33y  ; kmsy = sm32y  ; kmey = em32y  ;
        ipsy = sp31y  ; ipey = ep31y  ; jpsy = sp33y  ; jpey = ep33y  ; kpsy = sp32y  ; kpey = ep32y  ;
    CASE  ( DATA_ORDER_YZX )
        ids = sd33  ; ide = ed33  ; jds = sd31  ; jde = ed31  ; kds = sd32  ; kde = ed32  ;
        ims = sm33  ; ime = em33  ; jms = sm31  ; jme = em31  ; kms = sm32  ; kme = em32  ;
        ips = sp33  ; ipe = ep33  ; jps = sp31  ; jpe = ep31  ; kps = sp32  ; kpe = ep32  ;
        imsx = sm33x  ; imex = em33x  ; jmsx = sm31x  ; jmex = em31x  ; kmsx = sm32x  ; kmex = em32x  ;
        ipsx = sp33x  ; ipex = ep33x  ; jpsx = sp31x  ; jpex = ep31x  ; kpsx = sp32x  ; kpex = ep32x  ;
        imsy = sm33y  ; imey = em33y  ; jmsy = sm31y  ; jmey = em31y  ; kmsy = sm32y  ; kmey = em32y  ;
        ipsy = sp33y  ; ipey = ep33y  ; jpsy = sp31y  ; jpey = ep31y  ; kpsy = sp32y  ; kpey = ep32y  ;
  END SELECT data_ordering

  CALL model_to_grid_config_rec ( id , model_config_rec , config_flags )

  CALL nl_get_sr_x( id , sr_x )
  CALL nl_get_sr_y( id , sr_y )

  tl = tl_in
  inter_domain = inter_domain_in
  okay_to_alloc = okay_to_alloc_in

#if ( RWORDSIZE == 8 )
  initial_data_value = 0.
#else
  CALL get_initial_data_value ( initial_data_value )
#endif

#ifdef NO_INITIAL_DATA_VALUE
  setinitval = 0
#else
  setinitval = setinitval_in
#endif

  CALL nl_get_spec_bdy_width( 1, spec_bdy_width )

IF(okay_to_alloc.AND.in_use_for_config(id,'avgflx_dfu1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'avgflx_dfu1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%avgflx_dfu1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_dfu1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%avgflx_dfu1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'avgflx_dfu1'
  grid%tail_statevars%DataName = 'DFU1'
  grid%tail_statevars%Description = 'AVERAGE detrainment from updraft from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%avgflx_dfu1
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%avgflx_dfu1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_dfu1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'avgflx_efu1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'avgflx_efu1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%avgflx_efu1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_efu1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%avgflx_efu1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'avgflx_efu1'
  grid%tail_statevars%DataName = 'EFU1'
  grid%tail_statevars%Description = 'AVERAGE entrainment into updraft  from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%avgflx_efu1
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%avgflx_efu1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_efu1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'avgflx_dfd1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'avgflx_dfd1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%avgflx_dfd1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_dfd1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%avgflx_dfd1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'avgflx_dfd1'
  grid%tail_statevars%DataName = 'DFD1'
  grid%tail_statevars%Description = 'AVERAGE detrainment from downdraft from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%avgflx_dfd1
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%avgflx_dfd1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_dfd1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'avgflx_efd1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'avgflx_efd1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%avgflx_efd1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_efd1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%avgflx_efd1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'avgflx_efd1'
  grid%tail_statevars%DataName = 'EFD1'
  grid%tail_statevars%Description = 'AVERAGE entrainment into downdraft  from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%avgflx_efd1
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%avgflx_efd1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%avgflx_efd1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cfu1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cfu1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cfu1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cfu1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cfu1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cfu1'
  grid%tail_statevars%DataName = 'CFU1'
  grid%tail_statevars%Description = 'instantaneous updraft mass flux from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cfu1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = kde
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( kde, kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%cfu1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cfu1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cfd1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cfd1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cfd1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cfd1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cfd1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cfd1'
  grid%tail_statevars%DataName = 'CFD1'
  grid%tail_statevars%Description = 'instantaneous downdraft mass flux from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cfd1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = kde
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( kde, kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%cfd1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cfd1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dfu1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dfu1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dfu1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfu1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfu1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dfu1'
  grid%tail_statevars%DataName = 'DFU1'
  grid%tail_statevars%Description = 'instantaneous detrainment from updraft from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dfu1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dfu1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfu1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'efu1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'efu1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%efu1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%efu1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%efu1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'efu1'
  grid%tail_statevars%DataName = 'EFU1'
  grid%tail_statevars%Description = 'instantaneous entrainment into updraft  from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%efu1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%efu1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%efu1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dfd1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dfd1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dfd1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfd1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfd1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dfd1'
  grid%tail_statevars%DataName = 'DFD1'
  grid%tail_statevars%Description = 'instantaneous detrainment from downdraft from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dfd1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dfd1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfd1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'efd1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'efd1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%efd1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%efd1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%efd1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'efd1'
  grid%tail_statevars%DataName = 'EFD1'
  grid%tail_statevars%Description = 'instantaneous entrainment into downdraft  from GD-scheme'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%efd1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%efd1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%efd1(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%do_avgflx_em=0
IF ( setinitval .EQ. 3 ) grid%do_avgflx_cugd=0
IF(okay_to_alloc.AND.in_use_for_config(id,'vertstrucc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertstrucc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertstrucc(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucc(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertstrucc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertstrucc'
  grid%tail_statevars%DataName = 'VERTSTRUCC'
  grid%tail_statevars%Description = 'vertical structure for stoch. forcing '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vertstrucc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%vertstrucc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertstrucs'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertstrucs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertstrucs(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucs(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertstrucs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertstrucs'
  grid%tail_statevars%DataName = 'VERTSTRUCS'
  grid%tail_statevars%Description = 'vertical structure for stoch. forcing '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vertstrucs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%vertstrucs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucs(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'field_sf'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_sf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_sf(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_sf(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_sf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_sf'
  grid%tail_statevars%DataName = 'FIELD_SF      '
  grid%tail_statevars%Description = 'field for surface perturbations '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_sf
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%field_sf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_sf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'field_pbl'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_pbl: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_pbl(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_pbl(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_pbl=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_pbl'
  grid%tail_statevars%DataName = 'FIELD_PBL     '
  grid%tail_statevars%Description = 'field for surface perturbations '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_pbl
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%field_pbl(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_pbl(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'field_conv'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_conv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_conv(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_conv(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_conv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_conv'
  grid%tail_statevars%DataName = 'FIELD_CONV     '
  grid%tail_statevars%Description = 'field for surface perturbations '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_conv
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%field_conv(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_conv(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ru_tendf_stoch'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ru_tendf_stoch: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ru_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ru_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ru_tendf_stoch=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ru_tendf_stoch'
  grid%tail_statevars%DataName = 'RU_TENDF_STOCH'
  grid%tail_statevars%Description = 'stochastic forcing, U '
  grid%tail_statevars%Units = 'm/s^2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ru_tendf_stoch
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%ru_tendf_stoch(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ru_tendf_stoch(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rv_tendf_stoch'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rv_tendf_stoch: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rv_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rv_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rv_tendf_stoch=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rv_tendf_stoch'
  grid%tail_statevars%DataName = 'RV_TENDF_STOCH'
  grid%tail_statevars%Description = 'stochastic forcing, V '
  grid%tail_statevars%Units = 'm/s^2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Y'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rv_tendf_stoch
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rv_tendf_stoch(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rv_tendf_stoch(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rt_tendf_stoch'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rt_tendf_stoch: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rt_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rt_tendf_stoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rt_tendf_stoch=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rt_tendf_stoch'
  grid%tail_statevars%DataName = 'RT_TENDF_STOCH'
  grid%tail_statevars%Description = 'stochastic forcing, T '
  grid%tail_statevars%Units = 'K/s'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rt_tendf_stoch
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%rt_tendf_stoch(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rt_tendf_stoch(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_pert'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_pert: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_pert(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_pert(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_pert=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_pert'
  grid%tail_statevars%DataName = 'RAND_PERT'
  grid%tail_statevars%Description = 'randomn field '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_pert
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%rand_pert(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_pert(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pattern_spp_conv'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pattern_spp_conv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pattern_spp_conv(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_conv(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pattern_spp_conv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pattern_spp_conv'
  grid%tail_statevars%DataName = 'PATTERN_SPP_CONV'
  grid%tail_statevars%Description = 'pattern sppt conv'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pattern_spp_conv
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%pattern_spp_conv(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_conv(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pattern_spp_pbl'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pattern_spp_pbl: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pattern_spp_pbl(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_pbl(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pattern_spp_pbl=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pattern_spp_pbl'
  grid%tail_statevars%DataName = 'PATTERN_SPP_PBL'
  grid%tail_statevars%Description = 'pattern sppt pbl'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pattern_spp_pbl
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%pattern_spp_pbl(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_pbl(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pattern_spp_lsm'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pattern_spp_lsm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pattern_spp_lsm(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_lsm(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pattern_spp_lsm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pattern_spp_lsm'
  grid%tail_statevars%DataName = 'PATTERN_SPP_LSM'
  grid%tail_statevars%Description = 'pattern sppt lsm'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pattern_spp_lsm
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%pattern_spp_lsm(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pattern_spp_lsm(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rstoch'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rstoch: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rstoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rstoch(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rstoch=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rstoch'
  grid%tail_statevars%DataName = 'RSTOCH'
  grid%tail_statevars%Description = 'randomn field for SPPT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rstoch
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%rstoch(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rstoch(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_real').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_real: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_real(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_real=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_real'
  grid%tail_statevars%DataName = 'RAND_REAL'
  grid%tail_statevars%Description = 'array for FFTs'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_real
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_real(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_imag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_imag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_imag(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_imag=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_imag'
  grid%tail_statevars%DataName = 'RAND_IMAG'
  grid%tail_statevars%Description = 'array for FFTs'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_imag
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_imag(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spstreamforcc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spstreamforcc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spstreamforcc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstreamforcc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spstreamforcc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spstreamforcc'
  grid%tail_statevars%DataName = 'SPSTREAMFORCC'
  grid%tail_statevars%Description = 'real  spect. coeff. of stoch. streamfunction perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spstreamforcc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spstreamforcc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstreamforcc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spstreamforcs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spstreamforcs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spstreamforcs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstreamforcs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spstreamforcs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spstreamforcs'
  grid%tail_statevars%DataName = 'SPSTREAMFORCS'
  grid%tail_statevars%Description = 'imag. spect. coeff. of stoch. streamfunction perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spstreamforcs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spstreamforcs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstreamforcs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spstream_amp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spstream_amp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spstream_amp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstream_amp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spstream_amp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spstream_amp'
  grid%tail_statevars%DataName = 'SPSTREAM_AMP'
  grid%tail_statevars%Description = 'amplitude of stoch. streamfunction perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spstream_amp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spstream_amp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spstream_amp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sptforcc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sptforcc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sptforcc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sptforcc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sptforcc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sptforcc'
  grid%tail_statevars%DataName = 'SPTFORCC'
  grid%tail_statevars%Description = 'real  spect. coeff. of stoch. temperature perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sptforcc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sptforcc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sptforcc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sptforcs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sptforcs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sptforcs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sptforcs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sptforcs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sptforcs'
  grid%tail_statevars%DataName = 'SPTFORCS'
  grid%tail_statevars%Description = 'imag. spect. coeff. of stoch. temperature perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sptforcs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sptforcs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sptforcs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spt_amp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spt_amp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spt_amp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spt_amp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spt_amp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spt_amp'
  grid%tail_statevars%DataName = 'SPT_AMP'
  grid%tail_statevars%Description = 'amplitude of stoch. temperature perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spt_amp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spt_amp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spt_amp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc'
  grid%tail_statevars%DataName = 'SPFORCC'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs'
  grid%tail_statevars%DataName = 'SPFORCS'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp'
  grid%tail_statevars%DataName = 'SP_AMP'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sp_amp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc2').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc2'
  grid%tail_statevars%DataName = 'SPFORCC2'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcc2
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcc2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs2').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs2'
  grid%tail_statevars%DataName = 'SPFORCS2'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcs2
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcs2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp2').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp2'
  grid%tail_statevars%DataName = 'SP_AMP2'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sp_amp2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc3').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc3(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc3(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc3'
  grid%tail_statevars%DataName = 'SPFORCC3'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcc3
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcc3(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc3(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs3').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs3(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs3(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs3'
  grid%tail_statevars%DataName = 'SPFORCS3'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcs3
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcs3(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs3(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp3').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp3(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp3(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp3'
  grid%tail_statevars%DataName = 'SP_AMP3'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sp_amp3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp3(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp3(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc4').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc4(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc4(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc4'
  grid%tail_statevars%DataName = 'SPFORCC4'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcc4
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcc4(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc4(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs4').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs4(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs4(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs4'
  grid%tail_statevars%DataName = 'SPFORCS4'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcs4
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcs4(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs4(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp4').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp4(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp4(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp4'
  grid%tail_statevars%DataName = 'SP_AMP4'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sp_amp4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp4(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp4(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc5').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc5(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc5(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc5'
  grid%tail_statevars%DataName = 'SPFORCC5'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcc5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcc5(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc5(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs5').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs5(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs5(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs5'
  grid%tail_statevars%DataName = 'SPFORCS5'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spforcs5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spforcs5(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs5(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp5').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp5(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp5(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp5'
  grid%tail_statevars%DataName = 'SP_AMP5'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sp_amp5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp5(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp5(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spptforcc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spptforcc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spptforcc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spptforcc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spptforcc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spptforcc'
  grid%tail_statevars%DataName = 'SPPTFORCC'
  grid%tail_statevars%Description = 'real  spect. coeff. of randomn perturbation field in SPPT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spptforcc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spptforcc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spptforcc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spptforcs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spptforcs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spptforcs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spptforcs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spptforcs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spptforcs'
  grid%tail_statevars%DataName = 'SPPTFORCS'
  grid%tail_statevars%Description = 'imag. spect. coeff. of randomn perturbation field in SPPT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%spptforcs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = jde
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%spptforcs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spptforcs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sppt_amp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sppt_amp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sppt_amp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sppt_amp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sppt_amp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sppt_amp'
  grid%tail_statevars%DataName = 'SPPT_AMP'
  grid%tail_statevars%Description = 'amplitude of random perturbation field in SPPT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sppt_amp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%sppt_amp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sppt_amp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertampt').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertampt: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertampt(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampt(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertampt=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertampt'
  grid%tail_statevars%DataName = 'VERTAMPT'
  grid%tail_statevars%Description = 'vert. amplitude of stoch. temperature perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%vertampt
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = (kde-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = kms
  grid%tail_statevars%em1 = kme
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = kps
  grid%tail_statevars%ep1 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%vertampt(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampt(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertampuv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertampuv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertampuv(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampuv(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertampuv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertampuv'
  grid%tail_statevars%DataName = 'VERTAMPUV'
  grid%tail_statevars%Description = 'vert. amplitude of stoch. u,v perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%vertampuv
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = (kde-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = kms
  grid%tail_statevars%em1 = kme
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = kps
  grid%tail_statevars%ep1 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%vertampuv(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampuv(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_sppt').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_sppt: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_sppt(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_sppt(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_sppt=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_sppt'
  grid%tail_statevars%DataName = 'ISEEDARR_SPPT'
  grid%tail_statevars%Description = 'Array to hold seed for restart, SPPT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_sppt
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_sppt(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_sppt(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_skebs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_skebs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_skebs(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_skebs(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_skebs=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_skebs'
  grid%tail_statevars%DataName = 'ISEEDARR_SKEBS'
  grid%tail_statevars%Description = 'Array to hold seed for restart, SKEBS'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_skebs
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_skebs(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_skebs(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_rand_pert').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_rand_pert: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_rand_pert(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_rand_pert(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_rand_pert=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_rand_pert'
  grid%tail_statevars%DataName = 'ISEEDARR_RAND_PERTURB'
  grid%tail_statevars%Description = 'Array to hold seed for restart, RAND_PERT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_rand_pert
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_rand_pert(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_rand_pert(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_spp_conv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_spp_conv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_spp_conv(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_conv(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_spp_conv=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_spp_conv'
  grid%tail_statevars%DataName = 'ISEEDARRAY_SPP_CONV'
  grid%tail_statevars%Description = 'Array to hold seed for restart, RAND_PERT2'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_spp_conv
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_spp_conv(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_conv(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_spp_pbl').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_spp_pbl: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_spp_pbl(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_pbl(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_spp_pbl=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_spp_pbl'
  grid%tail_statevars%DataName = 'ISEEDARRAY_SPP_PBL'
  grid%tail_statevars%Description = 'Array to hold seed for restart, RAND_PERT3'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_spp_pbl
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_spp_pbl(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_pbl(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_spp_lsm').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%seed_dim)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_spp_lsm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_spp_lsm(1:model_config_rec%seed_dim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_lsm(1:model_config_rec%seed_dim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_spp_lsm=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_spp_lsm'
  grid%tail_statevars%DataName = 'ISEEDARRAY_SPP_LSM'
  grid%tail_statevars%Description = 'Array to hold seed for restart, RAND_PERT4'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseedarr_spp_lsm
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%seed_dim
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%seed_dim
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%seed_dim
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'seed_dim_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_spp_lsm(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_spp_lsm(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_real_xxx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31x)-(sm31x)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33x)-(sm33x)+1))) * RWORDSIZE
  nba = &
((((em31x)-(sm31x)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33x)-(sm33x)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_real_xxx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_real_xxx(sm31x:em31x,1:model_config_rec%num_stoch_levels,sm33x:em33x),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real_xxx(sm31x:em31x,1:model_config_rec%num_stoch_levels,sm33x:em33x). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_real_xxx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_real_xxx'
  grid%tail_statevars%DataName = 'RAND_REAL_XXX'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = 'X'
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_real_xxx
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = imsx
  grid%tail_statevars%em1 = imex
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jmsx
  grid%tail_statevars%em3 = jmex
  grid%tail_statevars%sp1 = ipsx
  grid%tail_statevars%ep1 = MIN( ide, ipex )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jpsx
  grid%tail_statevars%ep3 = MIN( jde, jpex )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_real_xxx(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real_xxx(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_real_yyy').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31y)-(sm31y)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33y)-(sm33y)+1))) * RWORDSIZE
  nba = &
((((em31y)-(sm31y)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33y)-(sm33y)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_real_yyy: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_real_yyy(sm31y:em31y,1:model_config_rec%num_stoch_levels,sm33y:em33y),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real_yyy(sm31y:em31y,1:model_config_rec%num_stoch_levels,sm33y:em33y). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_real_yyy=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_real_yyy'
  grid%tail_statevars%DataName = 'RAND_REAL_YYY'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = 'Y'
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_real_yyy
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = imsy
  grid%tail_statevars%em1 = imey
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jmsy
  grid%tail_statevars%em3 = jmey
  grid%tail_statevars%sp1 = ipsy
  grid%tail_statevars%ep1 = MIN( ide, ipey )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jpsy
  grid%tail_statevars%ep3 = MIN( jde, jpey )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_real_yyy(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_real_yyy(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_imag_xxx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31x)-(sm31x)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33x)-(sm33x)+1))) * RWORDSIZE
  nba = &
((((em31x)-(sm31x)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33x)-(sm33x)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_imag_xxx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_imag_xxx(sm31x:em31x,1:model_config_rec%num_stoch_levels,sm33x:em33x),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag_xxx(sm31x:em31x,1:model_config_rec%num_stoch_levels,sm33x:em33x). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_imag_xxx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_imag_xxx'
  grid%tail_statevars%DataName = 'RAND_IMAG_XXX'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = 'X'
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_imag_xxx
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = imsx
  grid%tail_statevars%em1 = imex
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jmsx
  grid%tail_statevars%em3 = jmex
  grid%tail_statevars%sp1 = ipsx
  grid%tail_statevars%ep1 = MIN( ide, ipex )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jpsx
  grid%tail_statevars%ep3 = MIN( jde, jpex )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_imag_xxx(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag_xxx(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rand_imag_yyy').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31y)-(sm31y)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33y)-(sm33y)+1))) * RWORDSIZE
  nba = &
((((em31y)-(sm31y)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33y)-(sm33y)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rand_imag_yyy: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rand_imag_yyy(sm31y:em31y,1:model_config_rec%num_stoch_levels,sm33y:em33y),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag_yyy(sm31y:em31y,1:model_config_rec%num_stoch_levels,sm33y:em33y). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rand_imag_yyy=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rand_imag_yyy'
  grid%tail_statevars%DataName = 'RAND_IMAG_YYY'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = 'Y'
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XYZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rand_imag_yyy
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = imsy
  grid%tail_statevars%em1 = imey
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jmsy
  grid%tail_statevars%em3 = jmey
  grid%tail_statevars%sp1 = ipsy
  grid%tail_statevars%ep1 = MIN( ide, ipey )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jpsy
  grid%tail_statevars%ep3 = MIN( jde, jpey )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_stoch_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%rand_imag_yyy(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rand_imag_yyy(1,1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_t'
   grid%tail_statevars%DataName = 'ALPH_TAU '
   grid%tail_statevars%Description = 'autoregressive coeff. for theta  perturb.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_t
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_t=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_psi'
   grid%tail_statevars%DataName = 'ALPH_PSI '
   grid%tail_statevars%Description = 'autoregressive coeff. for psi    perturb.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_psi
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_psi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_sppt'
   grid%tail_statevars%DataName = 'ALPH_SPPT'
   grid%tail_statevars%Description = 'autoregressive coeff. for tendf  perturb.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_sppt
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_sppt=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_rand'
   grid%tail_statevars%DataName = 'ALPH_RAND '
   grid%tail_statevars%Description = 'autoregressive coeff. for generic rand. pert.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_rand
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_rand=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_rand2'
   grid%tail_statevars%DataName = 'ALPH_RAND2'
   grid%tail_statevars%Description = 'autoregressive coeff. for generic rand. pert.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_rand2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_rand2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_rand3'
   grid%tail_statevars%DataName = 'ALPH_RAND3'
   grid%tail_statevars%Description = 'autoregressive coeff. for generic rand. pert.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_rand3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_rand3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'alph_rand4'
   grid%tail_statevars%DataName = 'ALPH_RAND4'
   grid%tail_statevars%Description = 'autoregressive coeff. for generic rand. pert.'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%alph_rand4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%alph_rand4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'did_stoch'
   grid%tail_statevars%DataName = 'DID_STOCH'
   grid%tail_statevars%Description = 'Logical to tell us that we already did the initialization for dom 1'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%did_stoch
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%did_stoch=.FALSE.
IF(okay_to_alloc.AND.in_use_for_config(id,'gridpt_stddev_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gridpt_stddev_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gridpt_stddev_mult3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gridpt_stddev_mult3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gridpt_stddev_mult3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gridpt_stddev_mult3d'
  grid%tail_statevars%DataName = 'PERT3D_STD'
  grid%tail_statevars%Description = 'gridpoint standard deviation of random perturbations in mult3d'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%gridpt_stddev_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%gridpt_stddev_mult3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gridpt_stddev_mult3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'stddev_cutoff_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'stddev_cutoff_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%stddev_cutoff_mult3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%stddev_cutoff_mult3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%stddev_cutoff_mult3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'stddev_cutoff_mult3d'
  grid%tail_statevars%DataName = 'PERT3D_CUT'
  grid%tail_statevars%Description = 'cutoff tails of pdf above this threshold standard deviation'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%stddev_cutoff_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%stddev_cutoff_mult3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%stddev_cutoff_mult3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lengthscale_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lengthscale_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lengthscale_mult3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lengthscale_mult3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lengthscale_mult3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lengthscale_mult3d'
  grid%tail_statevars%DataName = 'PERT3D_LEN'
  grid%tail_statevars%Description = 'Correlation length scale in meters for mult3d'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%lengthscale_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%lengthscale_mult3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lengthscale_mult3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'timescale_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'timescale_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%timescale_mult3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%timescale_mult3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%timescale_mult3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'timescale_mult3d'
  grid%tail_statevars%DataName = 'PERT3D_TIM'
  grid%tail_statevars%Description = 'Decorrelation time scale in s for mult3d'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%timescale_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%timescale_mult3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%timescale_mult3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mult3d_vertstruc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mult3d_vertstruc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mult3d_vertstruc(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mult3d_vertstruc(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mult3d_vertstruc=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mult3d_vertstruc'
  grid%tail_statevars%DataName = 'PERT3D_IVS'
  grid%tail_statevars%Description = 'vertical structure for mult3d: 0=constant, 1=random phase'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%mult3d_vertstruc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%mult3d_vertstruc(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mult3d_vertstruc(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseed_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseed_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseed_mult3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseed_mult3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseed_mult3d=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseed_mult3d'
  grid%tail_statevars%DataName = 'PERT3D_ISD'
  grid%tail_statevars%Description = 'RANDOM SEED FOR mult3d '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_1d => grid%iseed_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseed_mult3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseed_mult3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iseedarr_mult3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
  nba = &
((((em32)-(sm32)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iseedarr_mult3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iseedarr_mult3d(sm32:em32,1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_mult3d(sm32:em32,1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iseedarr_mult3d=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iseedarr_mult3d'
  grid%tail_statevars%DataName = 'ISEEDARR_MULT3D'
  grid%tail_statevars%Description = 'Array to hold seed for restart, MULT3D_PERT'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'ZZ'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%iseedarr_mult3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = (kde-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_pert_3d
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = kms
  grid%tail_statevars%em1 = kme
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_pert_3d
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = kps
  grid%tail_statevars%ep1 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_pert_3d
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top'
  grid%tail_statevars%dimname2 = 'num_pert_3d'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%iseedarr_mult3d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iseedarr_mult3d(1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'stepsp'
   grid%tail_statevars%DataName = 'STEPSP'
   grid%tail_statevars%Description = 'Update perturbation every STEPSP time steps'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%stepsp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%stepsp=0
IF ( setinitval .EQ. 3 ) grid%multi_perturb=0
IF ( setinitval .EQ. 3 ) grid%pert_farms=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_farms_albedo=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_aod=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_angexp=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_aerasy=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_qc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_farms_qs=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_deng=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_deng_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_deng_qc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_deng_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_deng_w=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_mynn=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_mynn_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_mynn_qc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_mynn_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_mynn_qke=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_noah=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_noah_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_noah_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_noah_smois=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_noah_tslb=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_thom=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_thom_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_thom_qc=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_thom_qi=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_thom_qs=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_thom_ni=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_cld3=.FALSE.
IF ( setinitval .EQ. 3 ) grid%pert_cld3_qv=initial_data_value
IF ( setinitval .EQ. 3 ) grid%pert_cld3_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%spdt=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcc3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcc3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcc3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcc3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcc3d'
  grid%tail_statevars%DataName = 'SPFORCC3D'
  grid%tail_statevars%Description = 'real  spect. coeff. of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%spforcc3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_pert_3d
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_pert_3d
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_pert_3d
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_pert_3d'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%spforcc3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcc3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'spforcs3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'spforcs3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%spforcs3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%spforcs3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'spforcs3d'
  grid%tail_statevars%DataName = 'SPFORCS3D'
  grid%tail_statevars%Description = 'imag. spect. coeff. of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%spforcs3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_pert_3d
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_pert_3d
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_pert_3d
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'num_pert_3d'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%spforcs3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%spforcs3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sp_amp3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_pert_3d)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sp_amp3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sp_amp3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp3d(sm31:em31,1:model_config_rec%num_pert_3d,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sp_amp3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sp_amp3d'
  grid%tail_statevars%DataName = 'SP_AMP3D'
  grid%tail_statevars%Description = 'amplitude of random perturbation field'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%sp_amp3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_pert_3d
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_pert_3d
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_pert_3d
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_pert_3d'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%sp_amp3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sp_amp3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'alph_rand3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'alph_rand3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%alph_rand3d(1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alph_rand3d(1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%alph_rand3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'alph_rand3d'
  grid%tail_statevars%DataName = 'ALPH_RAND3D'
  grid%tail_statevars%Description = 'autoregressive coeff. for generic rand. pert.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%alph_rand3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_pert_3d
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_pert_3d
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_pert_3d
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'num_pert_3d'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%alph_rand3d(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alph_rand3d(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertstrucc3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertstrucc3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertstrucc3d(sm31:em31,sm32:em32,sm33:em33,1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucc3d(sm31:em31,sm32:em32,sm33:em33,1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertstrucc3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertstrucc3d'
  grid%tail_statevars%DataName = 'VERTSTRUCC3D'
  grid%tail_statevars%Description = 'vertical structure for stoch. pert. forcing '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_4d => grid%vertstrucc3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%vertstrucc3d(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucc3d(1,1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertstrucs3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertstrucs3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertstrucs3d(sm31:em31,sm32:em32,sm33:em33,1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucs3d(sm31:em31,sm32:em32,sm33:em33,1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertstrucs3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertstrucs3d'
  grid%tail_statevars%DataName = 'VERTSTRUCS3D'
  grid%tail_statevars%Description = 'vertical structure for stoch. pert. forcing '
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_4d => grid%vertstrucs3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = (kde-1)
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = kms
  grid%tail_statevars%em2 = kme
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%vertstrucs3d(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertstrucs3d(1,1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vertampt3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))*(((model_config_rec%num_pert_3d)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vertampt3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vertampt3d(sm32:em32,1:model_config_rec%num_pert_3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampt3d(sm32:em32,1:model_config_rec%num_pert_3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vertampt3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vertampt3d'
  grid%tail_statevars%DataName = 'VERTAMPT3D'
  grid%tail_statevars%Description = 'vert. amplitude of stoch. temperature perturb.'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'ZZ'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%vertampt3d
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = (kde-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_pert_3d
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = kms
  grid%tail_statevars%em1 = kme
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_pert_3d
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = kps
  grid%tail_statevars%ep1 = MIN( (kde-1), kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_pert_3d
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top'
  grid%tail_statevars%dimname2 = 'num_pert_3d'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%vertampt3d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vertampt3d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pert3d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1)*num_pert3d)) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1)*num_pert3d)) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pert3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pert3d(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33,num_pert3d),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pert3d(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33,num_pert3d). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pert3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pert3d'
  grid%tail_statevars%DataName = 'PERT3D'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .TRUE.
  grid%tail_statevars%rfield_4d => grid%pert3d
  grid%tail_statevars%num_table => pert3d_num_table
  grid%tail_statevars%index_table => pert3d_index_table
  grid%tail_statevars%boundary_table => pert3d_boundary_table
  grid%tail_statevars%dname_table => pert3d_dname_table
  grid%tail_statevars%desc_table => pert3d_desc_table
  grid%tail_statevars%units_table => pert3d_units_table
  grid%tail_statevars%streams_table => pert3d_streams_table
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_stoch_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_stoch_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_stoch_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_stoch_levels'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%pert3d(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pert3d(1,1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%num_pert_3d=0
IF ( setinitval .EQ. 3 ) grid%nens=0
IF ( setinitval .EQ. 3 ) grid%skebs=0
IF ( setinitval .EQ. 3 ) grid%stoch_force_opt=0
IF ( setinitval .EQ. 3 ) grid%skebs_vertstruc=0
IF ( setinitval .EQ. 3 ) grid%stoch_vertstruc_opt=0
IF ( setinitval .EQ. 3 ) grid%tot_backscat_psi=initial_data_value
IF ( setinitval .EQ. 3 ) grid%tot_backscat_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%ztau_psi=initial_data_value
IF ( setinitval .EQ. 3 ) grid%ztau_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%rexponent_psi=initial_data_value
IF ( setinitval .EQ. 3 ) grid%rexponent_t=initial_data_value
IF ( setinitval .EQ. 3 ) grid%zsigma2_eps=initial_data_value
IF ( setinitval .EQ. 3 ) grid%zsigma2_eta=initial_data_value
IF ( setinitval .EQ. 3 ) grid%kminforc=0
IF ( setinitval .EQ. 3 ) grid%lminforc=0
IF ( setinitval .EQ. 3 ) grid%kminforct=0
IF ( setinitval .EQ. 3 ) grid%lminforct=0
IF ( setinitval .EQ. 3 ) grid%kmaxforc=0
IF ( setinitval .EQ. 3 ) grid%lmaxforc=0
IF ( setinitval .EQ. 3 ) grid%kmaxforct=0
IF ( setinitval .EQ. 3 ) grid%lmaxforct=0
IF ( setinitval .EQ. 3 ) grid%iseed_skebs=0
IF ( setinitval .EQ. 3 ) grid%kmaxforch=0
IF ( setinitval .EQ. 3 ) grid%lmaxforch=0
IF ( setinitval .EQ. 3 ) grid%kmaxforcth=0
IF ( setinitval .EQ. 3 ) grid%lmaxforcth=0
IF ( setinitval .EQ. 3 ) grid%sppt=0
IF ( setinitval .EQ. 3 ) grid%gridpt_stddev_sppt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%stddev_cutoff_sppt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%lengthscale_sppt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%timescale_sppt=initial_data_value
IF ( setinitval .EQ. 3 ) grid%sppt_vertstruc=0
IF ( setinitval .EQ. 3 ) grid%iseed_sppt=0
IF ( setinitval .EQ. 3 ) grid%rand_perturb=0
IF ( setinitval .EQ. 3 ) grid%gridpt_stddev_rand_pert=initial_data_value
END SUBROUTINE allocs_24
