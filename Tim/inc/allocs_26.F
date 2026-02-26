!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_26.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_26( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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

IF(okay_to_alloc.AND.in_use_for_config(id,'fer_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fer_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fer_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fer_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fer_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fer_cu'
  grid%tail_statevars%DataName = 'FER_CU'
  grid%tail_statevars%Description = 'cumulus lateral fractional entrainment rate'
  grid%tail_statevars%Units = 'm-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fer_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%fer_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fer_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fdr_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fdr_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fdr_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fdr_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fdr_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fdr_cu'
  grid%tail_statevars%DataName = 'FDR_CU'
  grid%tail_statevars%Description = 'cumulus lateral fractional detrainment rate'
  grid%tail_statevars%Units = 'm-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fdr_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%fdr_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fdr_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dwten_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dwten_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dwten_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dwten_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dwten_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dwten_cu'
  grid%tail_statevars%DataName = 'DWTEN_CU'
  grid%tail_statevars%Description = 'expellsion rate of cumulus cloud water to env.'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dwten_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%dwten_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dwten_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'diten_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'diten_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%diten_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%diten_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%diten_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'diten_cu'
  grid%tail_statevars%DataName = 'DITEN_CU'
  grid%tail_statevars%Description = 'expellsion rate of cumulus ice water to env.'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%diten_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%diten_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%diten_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qrten_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qrten_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qrten_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qrten_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qrten_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qrten_cu'
  grid%tail_statevars%DataName = 'QRTEN_CU'
  grid%tail_statevars%Description = 'production rate of rain by cumulus'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qrten_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%qrten_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qrten_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qsten_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qsten_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qsten_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qsten_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qsten_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qsten_cu'
  grid%tail_statevars%DataName = 'QSTEN_CU'
  grid%tail_statevars%Description = 'production rate of snow by cumulus'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qsten_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%qsten_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qsten_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'flxrain_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'flxrain_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%flxrain_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flxrain_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%flxrain_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'flxrain_cu'
  grid%tail_statevars%DataName = 'FLXRAIN_CU'
  grid%tail_statevars%Description = 'rain flux induced by cumulus'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%flxrain_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%flxrain_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flxrain_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'flxsnow_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'flxsnow_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%flxsnow_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flxsnow_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%flxsnow_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'flxsnow_cu'
  grid%tail_statevars%DataName = 'FLXSNOW_CU'
  grid%tail_statevars%Description = 'snow flux induced by cumulus'
  grid%tail_statevars%Units = 'kg m-2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%flxsnow_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%flxsnow_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flxsnow_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ntraprd_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ntraprd_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ntraprd_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ntraprd_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ntraprd_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ntraprd_cu'
  grid%tail_statevars%DataName = 'NTRAPRD_CU'
  grid%tail_statevars%Description = 'net production rate of rain by cumulus'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ntraprd_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%ntraprd_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ntraprd_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ntsnprd_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ntsnprd_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ntsnprd_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ntsnprd_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ntsnprd_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ntsnprd_cu'
  grid%tail_statevars%DataName = 'NTSNPRD_CU'
  grid%tail_statevars%Description = 'net production rate of snow by cumulus'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ntsnprd_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%ntsnprd_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ntsnprd_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'excessu_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'excessu_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%excessu_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%excessu_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%excessu_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'excessu_cu'
  grid%tail_statevars%DataName = 'EXCESSU_CU'
  grid%tail_statevars%Description = 'updraft saturation excess'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%excessu_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%excessu_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%excessu_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'excessu0_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'excessu0_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%excessu0_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%excessu0_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%excessu0_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'excessu0_cu'
  grid%tail_statevars%DataName = 'EXCESSU0_CU'
  grid%tail_statevars%Description = 'environmental saturation excess'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%excessu0_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%excessu0_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%excessu0_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'xc_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'xc_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%xc_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xc_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%xc_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'xc_cu'
  grid%tail_statevars%DataName = 'XC_CU'
  grid%tail_statevars%Description = 'critical mixing ratio'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%xc_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%xc_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xc_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'aquad_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'aquad_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%aquad_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%aquad_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%aquad_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'aquad_cu'
  grid%tail_statevars%DataName = 'AQUAD_CU'
  grid%tail_statevars%Description = 'aquad'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%aquad_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%aquad_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%aquad_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'bquad_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'bquad_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%bquad_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bquad_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%bquad_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'bquad_cu'
  grid%tail_statevars%DataName = 'BQUAD_CU'
  grid%tail_statevars%Description = 'bquad'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%bquad_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%bquad_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bquad_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cquad_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cquad_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cquad_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cquad_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cquad_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cquad_cu'
  grid%tail_statevars%DataName = 'CQUAD_CU'
  grid%tail_statevars%Description = 'cquad'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cquad_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%cquad_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cquad_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'bogbot_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'bogbot_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%bogbot_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bogbot_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%bogbot_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'bogbot_cu'
  grid%tail_statevars%DataName = 'BOGBOT_CU'
  grid%tail_statevars%Description = 'cloud buoyancy at the bottom interface'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%bogbot_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%bogbot_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bogbot_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'bogtop_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'bogtop_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%bogtop_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bogtop_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%bogtop_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'bogtop_cu'
  grid%tail_statevars%DataName = 'BOGTOP_CU'
  grid%tail_statevars%Description = 'cloud buoyancy at the top interface'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%bogtop_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
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
  ALLOCATE(grid%bogtop_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%bogtop_cu(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_uwcu_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_uwcu_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_uwcu_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_uwcu_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_uwcu_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_uwcu_cu'
  grid%tail_statevars%DataName = 'EXIT_UWCU_CU'
  grid%tail_statevars%Description = 'exit_UWCu_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_uwcu_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_uwcu_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_uwcu_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_conden_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_conden_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_conden_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_conden_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_conden_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_conden_cu'
  grid%tail_statevars%DataName = 'EXIT_CONDEN_CU'
  grid%tail_statevars%Description = 'exit_conden_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_conden_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_conden_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_conden_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_klclmkx_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_klclmkx_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_klclmkx_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_klclmkx_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_klclmkx_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_klclmkx_cu'
  grid%tail_statevars%DataName = 'EXIT_KLCLMKX_CU'
  grid%tail_statevars%Description = 'exit_klclmkx_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_klclmkx_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_klclmkx_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_klclmkx_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_klfcmkx_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_klfcmkx_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_klfcmkx_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_klfcmkx_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_klfcmkx_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_klfcmkx_cu'
  grid%tail_statevars%DataName = 'EXIT_KLFCMKX_CU'
  grid%tail_statevars%Description = 'exit_klfcmkx_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_klfcmkx_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_klfcmkx_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_klfcmkx_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_ufrc_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_ufrc_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_ufrc_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_ufrc_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_ufrc_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_ufrc_cu'
  grid%tail_statevars%DataName = 'EXIT_UFRC_CU'
  grid%tail_statevars%Description = 'exit_ufrc_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_ufrc_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_ufrc_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_ufrc_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_wtw_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_wtw_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_wtw_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_wtw_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_wtw_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_wtw_cu'
  grid%tail_statevars%DataName = 'EXIT_WTW_CU'
  grid%tail_statevars%Description = 'exit_wtw_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_wtw_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_wtw_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_wtw_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_drycore_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_drycore_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_drycore_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_drycore_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_drycore_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_drycore_cu'
  grid%tail_statevars%DataName = 'EXIT_DRYCORE_CU'
  grid%tail_statevars%Description = 'exit_drycore_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_drycore_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_drycore_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_drycore_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_wu_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_wu_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_wu_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_wu_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_wu_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_wu_cu'
  grid%tail_statevars%DataName = 'EXIT_WU_CU'
  grid%tail_statevars%Description = 'exit_wu_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_wu_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_wu_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_wu_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_cufliter_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_cufliter_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_cufliter_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_cufliter_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_cufliter_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_cufliter_cu'
  grid%tail_statevars%DataName = 'EXIT_CUFILTER_CU'
  grid%tail_statevars%Description = 'exit_cufilter_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_cufliter_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_cufliter_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_cufliter_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_kinv1_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_kinv1_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_kinv1_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_kinv1_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_kinv1_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_kinv1_cu'
  grid%tail_statevars%DataName = 'EXIT_KINV1_CU'
  grid%tail_statevars%Description = 'exit_kinv1_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_kinv1_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_kinv1_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_kinv1_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'exit_rei_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'exit_rei_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%exit_rei_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_rei_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%exit_rei_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'exit_rei_cu'
  grid%tail_statevars%DataName = 'EXIT_REI_CU'
  grid%tail_statevars%Description = 'exit_rei_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%exit_rei_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%exit_rei_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%exit_rei_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_shcu_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_shcu_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_shcu_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_shcu_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_shcu_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_shcu_cu'
  grid%tail_statevars%DataName = 'LIMIT_SHCU_CU'
  grid%tail_statevars%Description = 'limit_shcu_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_shcu_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_shcu_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_shcu_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_negcon_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_negcon_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_negcon_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_negcon_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_negcon_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_negcon_cu'
  grid%tail_statevars%DataName = 'LIMIT_NEGCON_CU'
  grid%tail_statevars%Description = 'limit_negcon_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_negcon_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_negcon_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_negcon_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_ufrc_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_ufrc_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_ufrc_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_ufrc_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_ufrc_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_ufrc_cu'
  grid%tail_statevars%DataName = 'LIMIT_UFRC_CU'
  grid%tail_statevars%Description = 'limit_ufrc_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_ufrc_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_ufrc_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_ufrc_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_ppen_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_ppen_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_ppen_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_ppen_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_ppen_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_ppen_cu'
  grid%tail_statevars%DataName = 'LIMIT_PPEN_CU'
  grid%tail_statevars%Description = 'limit_ppen_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_ppen_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_ppen_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_ppen_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_emf_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_emf_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_emf_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_emf_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_emf_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_emf_cu'
  grid%tail_statevars%DataName = 'LIMIT_EMF_CU'
  grid%tail_statevars%Description = 'limit_emf_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_emf_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_emf_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_emf_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_cinlcl_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_cinlcl_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_cinlcl_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cinlcl_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_cinlcl_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_cinlcl_cu'
  grid%tail_statevars%DataName = 'LIMIT_CINLCL_CU'
  grid%tail_statevars%Description = 'limit_cinlcl_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_cinlcl_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_cinlcl_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cinlcl_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_cin_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_cin_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_cin_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cin_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_cin_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_cin_cu'
  grid%tail_statevars%DataName = 'LIMIT_CIN_CU'
  grid%tail_statevars%Description = 'limit_cin_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_cin_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_cin_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cin_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_cbmf_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_cbmf_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_cbmf_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cbmf_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_cbmf_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_cbmf_cu'
  grid%tail_statevars%DataName = 'LIMIT_CBMF_CU'
  grid%tail_statevars%Description = 'limit_cbmf_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_cbmf_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_cbmf_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_cbmf_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'limit_rei_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'limit_rei_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%limit_rei_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_rei_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%limit_rei_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'limit_rei_cu'
  grid%tail_statevars%DataName = 'LIMIT_REI_CU'
  grid%tail_statevars%Description = 'limit_rei_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%limit_rei_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%limit_rei_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%limit_rei_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ind_delcin_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ind_delcin_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ind_delcin_cu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ind_delcin_cu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ind_delcin_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ind_delcin_cu'
  grid%tail_statevars%DataName = 'IND_DELCIN_CU'
  grid%tail_statevars%Description = 'ind_delcin_cu'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%ind_delcin_cu
  grid%tail_statevars%streams(1) = 64 ! 00000040 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%ind_delcin_cu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ind_delcin_cu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rh_old_mp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rh_old_mp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rh_old_mp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rh_old_mp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rh_old_mp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rh_old_mp'
  grid%tail_statevars%DataName = 'RH_OLD_MP'
  grid%tail_statevars%Description = 'previous time level RH for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rh_old_mp
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
  ALLOCATE(grid%rh_old_mp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rh_old_mp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lcd_old_mp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lcd_old_mp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lcd_old_mp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lcd_old_mp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lcd_old_mp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lcd_old_mp'
  grid%tail_statevars%DataName = 'LCD_OLD_MP'
  grid%tail_statevars%Description = 'previous time level liquid cldfra for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%lcd_old_mp
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
  ALLOCATE(grid%lcd_old_mp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lcd_old_mp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_old_mp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_old_mp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_old_mp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_old_mp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_old_mp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_old_mp'
  grid%tail_statevars%DataName = 'CLDFRA_OLD_MP'
  grid%tail_statevars%Description = 'previous time level cldfra for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_old_mp
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
  ALLOCATE(grid%cldfra_old_mp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_old_mp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_mp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_mp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_mp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_mp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_mp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_mp'
  grid%tail_statevars%DataName = 'CLDFRA_MP'
  grid%tail_statevars%Description = 'current time level cldfra for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_mp
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
  ALLOCATE(grid%cldfra_mp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_mp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_mp_all').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_mp_all: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_mp_all(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_mp_all(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_mp_all=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_mp_all'
  grid%tail_statevars%DataName = 'CLDFRA_MP_ALL'
  grid%tail_statevars%Description = 'current time level cldfra for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_mp_all
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
  ALLOCATE(grid%cldfra_mp_all(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_mp_all(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iradius').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iradius: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iradius(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iradius(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iradius=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iradius'
  grid%tail_statevars%DataName = 'IRADIUS'
  grid%tail_statevars%Description = 'effective radius of ice condensate'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%iradius
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
  ALLOCATE(grid%iradius(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iradius(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lradius').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lradius: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lradius(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lradius(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lradius=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lradius'
  grid%tail_statevars%DataName = 'LRADIUS'
  grid%tail_statevars%Description = 'effective radius of liquid condensate'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%lradius
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
  ALLOCATE(grid%lradius(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lradius(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_conv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_conv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_conv(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_conv(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_conv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_conv'
  grid%tail_statevars%DataName = 'CLDFRA_CONV'
  grid%tail_statevars%Description = 'current time level cldfra for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_conv
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
  ALLOCATE(grid%cldfra_conv(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_conv(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfrai').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfrai: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfrai(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfrai(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfrai=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfrai'
  grid%tail_statevars%DataName = 'CLDFRAI'
  grid%tail_statevars%Description = 'current time level cldfrai for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfrai
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
  ALLOCATE(grid%cldfrai(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfrai(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfral').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfral: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfral(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfral(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfral=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfral'
  grid%tail_statevars%DataName = 'CLDFRAL'
  grid%tail_statevars%Description = 'current time level cldfral for CAMMGMP microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfral
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
  ALLOCATE(grid%cldfral(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfral(1,1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'is_cammgmp_used'
   grid%tail_statevars%DataName = 'IS_CAMMGMP_USED'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%is_cammgmp_used
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%is_cammgmp_used=.FALSE.
IF(okay_to_alloc.AND.in_use_for_config(id,'numc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'numc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%numc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%numc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%numc=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'numc'
  grid%tail_statevars%DataName = 'NUMC'
  grid%tail_statevars%Description = 'NUMBER OF COLUMN SUBGRIDS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%numc
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
  ALLOCATE(grid%numc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%numc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'nump'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'nump: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%nump(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nump(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%nump=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'nump'
  grid%tail_statevars%DataName = 'NUMP'
  grid%tail_statevars%Description = 'NUMBER OF PFT SUBGRIDS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%nump
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
  ALLOCATE(grid%nump(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nump(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sabv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sabv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sabv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sabv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sabv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sabv'
  grid%tail_statevars%DataName = 'SABV'
  grid%tail_statevars%Description = 'NET VEGETATION SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sabv
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%sabv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sabv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sabg').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sabg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sabg(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sabg(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sabg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sabg'
  grid%tail_statevars%DataName = 'SABG'
  grid%tail_statevars%Description = 'NET SOIL SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sabg
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%sabg(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sabg(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwup').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwup: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwup(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwup(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwup=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwup'
  grid%tail_statevars%DataName = 'LWUP'
  grid%tail_statevars%Description = 'OUTGOING LONGWAVE RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwup
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%lwup(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwup(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lhsoi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lhsoi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lhsoi(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhsoi(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lhsoi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lhsoi'
  grid%tail_statevars%DataName = 'LHSOI'
  grid%tail_statevars%Description = 'LH from soil'
  grid%tail_statevars%Units = 'W/m^2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%lhsoi
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%lhsoi(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhsoi(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lhveg').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lhveg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lhveg(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhveg(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lhveg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lhveg'
  grid%tail_statevars%DataName = 'LHVEG'
  grid%tail_statevars%Description = 'LH from vegetation'
  grid%tail_statevars%Units = 'W/m^2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%lhveg
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%lhveg(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhveg(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lhtran').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lhtran: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lhtran(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhtran(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lhtran=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lhtran'
  grid%tail_statevars%DataName = 'LHTRAN'
  grid%tail_statevars%Description = 'LH from transpiration'
  grid%tail_statevars%Units = 'W/m^2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%lhtran
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%lhtran(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lhtran(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snl'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snl: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snl(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snl(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snl=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snl'
  grid%tail_statevars%DataName = 'SNL'
  grid%tail_statevars%Description = 'NUMBER OF SNOW LAYERS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_3d => grid%snl
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snl(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snl(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowdp'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowdp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowdp(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowdp(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowdp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowdp'
  grid%tail_statevars%DataName = 'SNOWDP'
  grid%tail_statevars%Description = 'SUBGRID SNOW DEPTH'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowdp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowdp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowdp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wtc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wtc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wtc(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wtc(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wtc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wtc'
  grid%tail_statevars%DataName = 'WTC'
  grid%tail_statevars%Description = 'COLUMN WEIGHT'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%wtc
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%wtc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wtc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wtp'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wtp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wtp(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wtp(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wtp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wtp'
  grid%tail_statevars%DataName = 'WTP'
  grid%tail_statevars%Description = 'PFT WEIGHT'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%wtp
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%wtp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wtp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osno'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osno: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osno(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osno(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osno=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osno'
  grid%tail_statevars%DataName = 'H2OSNO'
  grid%tail_statevars%Description = 'SUBGRID SNOW WATER EQUIVALENT'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osno
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osno(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osno(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_grnd'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_grnd: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_grnd(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_grnd(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_grnd=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_grnd'
  grid%tail_statevars%DataName = 'T_GRND'
  grid%tail_statevars%Description = 'SUBGRID GROUND TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_grnd
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_grnd(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_grnd(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_veg'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_veg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_veg(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_veg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_veg'
  grid%tail_statevars%DataName = 'T_VEG'
  grid%tail_statevars%Description = 'SUBGRID VEGETATION TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_veg
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_veg(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_veg24'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_veg24: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_veg24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_veg24=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_veg24'
  grid%tail_statevars%DataName = 'T_VEG24'
  grid%tail_statevars%Description = '24H SUBGRID VEGETATION TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_veg24
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_veg24(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg24(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_veg240'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_veg240: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_veg240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_veg240=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_veg240'
  grid%tail_statevars%DataName = 'T_VEG240'
  grid%tail_statevars%Description = '10D SUBGRID VEGETATION TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_veg240
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_veg240(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_veg240(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsun'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsun: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsun(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsun=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsun'
  grid%tail_statevars%DataName = 'FSUN'
  grid%tail_statevars%Description = 'SUBGRID VEGETATION RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsun
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsun(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsun24'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsun24: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsun24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsun24=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsun24'
  grid%tail_statevars%DataName = 'FSUN24'
  grid%tail_statevars%Description = '24H SUBGRID VEGETATION RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsun24
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsun24(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun24(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsun240'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsun240: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsun240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsun240=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsun240'
  grid%tail_statevars%DataName = 'FSUN240'
  grid%tail_statevars%Description = '10D SUBGRID VEGETATION RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsun240
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsun240(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsun240(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsd24'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsd24: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsd24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsd24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsd24=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsd24'
  grid%tail_statevars%DataName = 'FSD24'
  grid%tail_statevars%Description = '24H DIRECT SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsd24
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsd24(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsd24(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsd240'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsd240: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsd240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsd240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsd240=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsd240'
  grid%tail_statevars%DataName = 'FSD240'
  grid%tail_statevars%Description = '10D DIRECT SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsd240
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsd240(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsd240(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsi24'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsi24: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsi24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsi24(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsi24=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsi24'
  grid%tail_statevars%DataName = 'FSI24'
  grid%tail_statevars%Description = '24H INDIRECT SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsi24
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsi24(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsi24(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fsi240'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fsi240: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fsi240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsi240(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fsi240=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fsi240'
  grid%tail_statevars%DataName = 'FSI240'
  grid%tail_statevars%Description = '10D INDIRECT SOLAR RADIATION'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%fsi240
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%fsi240(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fsi240(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'laip'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'laip: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%laip(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%laip(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%laip=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'laip'
  grid%tail_statevars%DataName = 'LAIP'
  grid%tail_statevars%Description = 'PRIOR TIMESTEP LEAF AREA INDEX'
  grid%tail_statevars%Units = 'area/area'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%laip
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%laip(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%laip(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2ocan'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2ocan: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2ocan(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2ocan(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2ocan=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2ocan'
  grid%tail_statevars%DataName = 'H2OCAN'
  grid%tail_statevars%Description = 'SUBGRID VEGETATION INTERCEP WATER'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2ocan
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2ocan(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2ocan(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2ocan_col'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2ocan_col: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2ocan_col(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2ocan_col(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2ocan_col=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2ocan_col'
  grid%tail_statevars%DataName = 'H2OCAN_COL'
  grid%tail_statevars%Description = 'COLUMN VEGETATION INTERCEP WATER'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2ocan_col
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2ocan_col(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2ocan_col(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t2m_max'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't2m_max: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t2m_max(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2m_max(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t2m_max=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't2m_max'
  grid%tail_statevars%DataName = 'T2M_MAX'
  grid%tail_statevars%Description = 'MAX TEMPERATURE AT 2 M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%t2m_max
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%t2m_max(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2m_max(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t2m_min'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't2m_min: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t2m_min(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2m_min(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t2m_min=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't2m_min'
  grid%tail_statevars%DataName = 'T2M_MIN'
  grid%tail_statevars%Description = 'MIN TEMPERATURE AT 2 M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%t2m_min
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%t2m_min(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2m_min(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t2clm'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't2clm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t2clm(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2clm(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t2clm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't2clm'
  grid%tail_statevars%DataName = 'T2CLM'
  grid%tail_statevars%Description = '2M TEMPERATURE IN CLM'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%t2clm
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%t2clm(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2clm(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_ref2m'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_ref2m: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_ref2m(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_ref2m(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_ref2m=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_ref2m'
  grid%tail_statevars%DataName = 'T_REF2M'
  grid%tail_statevars%Description = 'TEMPERATURE AT 2 M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_ref2m
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_ref2m(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_ref2m(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'q_ref2m'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'q_ref2m: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%q_ref2m(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_ref2m(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%q_ref2m=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'q_ref2m'
  grid%tail_statevars%DataName = 'Q_REF2M'
  grid%tail_statevars%Description = 'SPECIFIC HUMIDITY AT 2 M'
  grid%tail_statevars%Units = 'kg/kg'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%q_ref2m
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%q_ref2m(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_ref2m(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq_s1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq_s1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq_s1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq_s1'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ_S1'
  grid%tail_statevars%Description = '1ST   SNOWLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq_s1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq_s1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq_s2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq_s2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq_s2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq_s2'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ_S2'
  grid%tail_statevars%Description = '2ND   SNOWLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq_s2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq_s2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq_s3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq_s3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq_s3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq_s3'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ_S3'
  grid%tail_statevars%Description = '3RD   SNOWLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq_s3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq_s3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq_s4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq_s4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq_s4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq_s4'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ_S4'
  grid%tail_statevars%Description = '4TH   SNOWLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq_s4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq_s4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq_s5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq_s5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq_s5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq_s5'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ_S5'
  grid%tail_statevars%Description = '5TH   SNOWLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq_s5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq_s5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq_s5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq1'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ1'
  grid%tail_statevars%Description = '1ST   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq2'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ2'
  grid%tail_statevars%Description = '2ND   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq3'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ3'
  grid%tail_statevars%Description = '3RD   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq4'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ4'
  grid%tail_statevars%Description = '4TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq5'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ5'
  grid%tail_statevars%Description = '5TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq6'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq6: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq6=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq6'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ6'
  grid%tail_statevars%Description = '6TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq6
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq6(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq6(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq7'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq7: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq7=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq7'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ7'
  grid%tail_statevars%Description = '7TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq7
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq7(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq7(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq8'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq8: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq8=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq8'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ8'
  grid%tail_statevars%Description = '8TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq8
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq8(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq8(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq9'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq9: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq9=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq9'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ9'
  grid%tail_statevars%Description = '9TH   SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq9
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq9(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq9(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_liq10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_liq10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_liq10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_liq10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_liq10'
  grid%tail_statevars%DataName = 'H2OSOI_LIQ10'
  grid%tail_statevars%Description = '10TH  SOILLAYER LIQ WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_liq10
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_liq10(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_liq10(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice_s1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice_s1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice_s1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice_s1'
  grid%tail_statevars%DataName = 'H2OSOI_ICE_S1'
  grid%tail_statevars%Description = '1ST   SNOWLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice_s1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice_s1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice_s2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice_s2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice_s2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice_s2'
  grid%tail_statevars%DataName = 'H2OSOI_ICE_S2'
  grid%tail_statevars%Description = '2ND   SNOWLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice_s2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice_s2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice_s3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice_s3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice_s3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice_s3'
  grid%tail_statevars%DataName = 'H2OSOI_ICE_S3'
  grid%tail_statevars%Description = '3RD   SNOWLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice_s3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice_s3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice_s4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice_s4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice_s4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice_s4'
  grid%tail_statevars%DataName = 'H2OSOI_ICE_S4'
  grid%tail_statevars%Description = '4TH   SNOWLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice_s4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice_s4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice_s5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice_s5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice_s5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice_s5'
  grid%tail_statevars%DataName = 'H2OSOI_ICE_S5'
  grid%tail_statevars%Description = '5TH   SNOWLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice_s5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice_s5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice_s5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice1'
  grid%tail_statevars%DataName = 'H2OSOI_ICE1'
  grid%tail_statevars%Description = '1ST   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice2'
  grid%tail_statevars%DataName = 'H2OSOI_ICE2'
  grid%tail_statevars%Description = '2ND   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice3'
  grid%tail_statevars%DataName = 'H2OSOI_ICE3'
  grid%tail_statevars%Description = '3RD   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice4'
  grid%tail_statevars%DataName = 'H2OSOI_ICE4'
  grid%tail_statevars%Description = '4TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice5'
  grid%tail_statevars%DataName = 'H2OSOI_ICE5'
  grid%tail_statevars%Description = '5TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice6'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice6: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice6=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice6'
  grid%tail_statevars%DataName = 'H2OSOI_ICE6'
  grid%tail_statevars%Description = '6TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice6
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice6(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice6(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice7'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice7: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice7=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice7'
  grid%tail_statevars%DataName = 'H2OSOI_ICE7'
  grid%tail_statevars%Description = '7TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice7
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice7(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice7(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice8'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice8: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice8=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice8'
  grid%tail_statevars%DataName = 'H2OSOI_ICE8'
  grid%tail_statevars%Description = '8TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice8
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice8(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice8(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice9'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice9: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice9=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice9'
  grid%tail_statevars%DataName = 'H2OSOI_ICE9'
  grid%tail_statevars%Description = '9TH   SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice9
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice9(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice9(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_ice10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_ice10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_ice10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_ice10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_ice10'
  grid%tail_statevars%DataName = 'H2OSOI_ICE10'
  grid%tail_statevars%Description = '10TH  SOILLAYER ICE WATER'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_ice10
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_ice10(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_ice10(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno_s1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno_s1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno_s1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno_s1'
  grid%tail_statevars%DataName = 'T_SOISNO_S1'
  grid%tail_statevars%Description = '1ST  SNOWLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno_s1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno_s1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno_s2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno_s2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno_s2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno_s2'
  grid%tail_statevars%DataName = 'T_SOISNO_S2'
  grid%tail_statevars%Description = '2ND  SNOWLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno_s2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno_s2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno_s3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno_s3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno_s3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno_s3'
  grid%tail_statevars%DataName = 'T_SOISNO_S3'
  grid%tail_statevars%Description = '3RD  SNOWLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno_s3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno_s3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno_s4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno_s4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno_s4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno_s4'
  grid%tail_statevars%DataName = 'T_SOISNO_S4'
  grid%tail_statevars%Description = '4TH  SNOWLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno_s4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno_s4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno_s5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno_s5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno_s5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno_s5'
  grid%tail_statevars%DataName = 'T_SOISNO_S5'
  grid%tail_statevars%Description = '5TH  SNOWLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno_s5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno_s5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno_s5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno1'
  grid%tail_statevars%DataName = 'T_SOISNO1'
  grid%tail_statevars%Description = '1ST  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno2'
  grid%tail_statevars%DataName = 'T_SOISNO2'
  grid%tail_statevars%Description = '2ND  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno3'
  grid%tail_statevars%DataName = 'T_SOISNO3'
  grid%tail_statevars%Description = '3RD  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno4'
  grid%tail_statevars%DataName = 'T_SOISNO4'
  grid%tail_statevars%Description = '4TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno5'
  grid%tail_statevars%DataName = 'T_SOISNO5'
  grid%tail_statevars%Description = '5TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno6'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno6: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno6=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno6'
  grid%tail_statevars%DataName = 'T_SOISNO6'
  grid%tail_statevars%Description = '6TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno6
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno6(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno6(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno7'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno7: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno7=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno7'
  grid%tail_statevars%DataName = 'T_SOISNO7'
  grid%tail_statevars%Description = '7TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno7
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno7(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno7(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno8'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno8: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno8=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno8'
  grid%tail_statevars%DataName = 'T_SOISNO8'
  grid%tail_statevars%Description = '8TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno8
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno8(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno8(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno9'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno9: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno9=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno9'
  grid%tail_statevars%DataName = 'T_SOISNO9'
  grid%tail_statevars%Description = '9TH  SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno9
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno9(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno9(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soisno10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soisno10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soisno10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soisno10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soisno10'
  grid%tail_statevars%DataName = 'T_SOISNO10'
  grid%tail_statevars%Description = '10TH SOILLAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_soisno10
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_soisno10(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soisno10(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dzsnow1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dzsnow1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dzsnow1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dzsnow1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dzsnow1'
  grid%tail_statevars%DataName = 'DZSNOW1'
  grid%tail_statevars%Description = 'FIRST   SNOW LAYER THKNESS(FROM BOTM)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dzsnow1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dzsnow1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dzsnow2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dzsnow2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dzsnow2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dzsnow2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dzsnow2'
  grid%tail_statevars%DataName = 'DZSNOW2'
  grid%tail_statevars%Description = 'SECOND  SNOW LAYER THKNESS(FROM BOTM)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dzsnow2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dzsnow2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dzsnow3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dzsnow3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dzsnow3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dzsnow3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dzsnow3'
  grid%tail_statevars%DataName = 'DZSNOW3'
  grid%tail_statevars%Description = 'THIRD   SNOW LAYER THKNESS(FROM BOTM)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dzsnow3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dzsnow3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dzsnow4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dzsnow4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dzsnow4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dzsnow4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dzsnow4'
  grid%tail_statevars%DataName = 'DZSNOW4'
  grid%tail_statevars%Description = 'FOURTH  SNOW LAYER THKNESS(FROM BOTM)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dzsnow4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dzsnow4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dzsnow5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dzsnow5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dzsnow5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dzsnow5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dzsnow5'
  grid%tail_statevars%DataName = 'DZSNOW5'
  grid%tail_statevars%Description = 'FIFTH   SNOW LAYER THKNESS(FROM BOTM)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dzsnow5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%dzsnow5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dzsnow5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowrds1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowrds1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowrds1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowrds1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowrds1'
  grid%tail_statevars%DataName = 'SNOWRDS1'
  grid%tail_statevars%Description = 'FIRST   SNOW LAYER EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'micron'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowrds1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowrds1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowrds2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowrds2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowrds2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowrds2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowrds2'
  grid%tail_statevars%DataName = 'SNOWRDS2'
  grid%tail_statevars%Description = 'SECOND  SNOW LAYER EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'micron'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowrds2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowrds2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowrds3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowrds3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowrds3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowrds3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowrds3'
  grid%tail_statevars%DataName = 'SNOWRDS3'
  grid%tail_statevars%Description = 'THIRD   SNOW LAYER EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'micron'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowrds3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowrds3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowrds4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowrds4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowrds4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowrds4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowrds4'
  grid%tail_statevars%DataName = 'SNOWRDS4'
  grid%tail_statevars%Description = 'FOURTH  SNOW LAYER EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'micron'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowrds4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowrds4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowrds5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowrds5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowrds5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowrds5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowrds5'
  grid%tail_statevars%DataName = 'SNOWRDS5'
  grid%tail_statevars%Description = 'FIFTH   SNOW LAYER EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'micron'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%snowrds5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%snowrds5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowrds5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake1'
  grid%tail_statevars%DataName = 'T_LAKE1'
  grid%tail_statevars%Description = '1ST  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake2'
  grid%tail_statevars%DataName = 'T_LAKE2'
  grid%tail_statevars%Description = '2ND  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake3'
  grid%tail_statevars%DataName = 'T_LAKE3'
  grid%tail_statevars%Description = '3RD  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake4'
  grid%tail_statevars%DataName = 'T_LAKE4'
  grid%tail_statevars%Description = '4TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake5'
  grid%tail_statevars%DataName = 'T_LAKE5'
  grid%tail_statevars%Description = '5TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake6'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake6: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake6=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake6'
  grid%tail_statevars%DataName = 'T_LAKE6'
  grid%tail_statevars%Description = '6TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake6
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake6(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake6(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake7'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake7: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake7=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake7'
  grid%tail_statevars%DataName = 'T_LAKE7'
  grid%tail_statevars%Description = '7TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake7
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake7(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake7(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake8'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake8: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake8=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake8'
  grid%tail_statevars%DataName = 'T_LAKE8'
  grid%tail_statevars%Description = '8TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake8
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake8(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake8(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake9'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake9: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake9=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake9'
  grid%tail_statevars%DataName = 'T_LAKE9'
  grid%tail_statevars%Description = '9TH  LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake9
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake9(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake9(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_lake10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_lake10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_lake10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_lake10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_lake10'
  grid%tail_statevars%DataName = 'T_LAKE10'
  grid%tail_statevars%Description = '10TH LAKELAYER TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%t_lake10
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%t_lake10(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_lake10(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol1'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol1(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol1'
  grid%tail_statevars%DataName = 'H2OSOI_VOL1'
  grid%tail_statevars%Description = '1ST  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol1
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol2(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol2'
  grid%tail_statevars%DataName = 'H2OSOI_VOL2'
  grid%tail_statevars%Description = '2ND  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol2
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol3(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol3'
  grid%tail_statevars%DataName = 'H2OSOI_VOL3'
  grid%tail_statevars%Description = '3RD  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol3
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol4'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol4: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol4(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol4=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol4'
  grid%tail_statevars%DataName = 'H2OSOI_VOL4'
  grid%tail_statevars%Description = '4TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol4
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol4(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol4(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol5'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol5: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol5(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol5=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol5'
  grid%tail_statevars%DataName = 'H2OSOI_VOL5'
  grid%tail_statevars%Description = '5TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol5
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol5(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol5(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol6'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol6: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol6(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol6=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol6'
  grid%tail_statevars%DataName = 'H2OSOI_VOL6'
  grid%tail_statevars%Description = '6TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol6
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol6(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol6(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol7'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol7: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol7(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol7=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol7'
  grid%tail_statevars%DataName = 'H2OSOI_VOL7'
  grid%tail_statevars%Description = '7TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol7
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol7(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol7(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol8'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol8: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol8(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol8=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol8'
  grid%tail_statevars%DataName = 'H2OSOI_VOL8'
  grid%tail_statevars%Description = '8TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol8
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol8(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol8(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol9'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol9: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol9(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol9=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol9'
  grid%tail_statevars%DataName = 'H2OSOI_VOL9'
  grid%tail_statevars%Description = '9TH  SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol9
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol9(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol9(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'h2osoi_vol10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%maxpatch)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'h2osoi_vol10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%h2osoi_vol10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol10(sm31:em31,1:model_config_rec%maxpatch,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%h2osoi_vol10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'h2osoi_vol10'
  grid%tail_statevars%DataName = 'H2OSOI_VOL10'
  grid%tail_statevars%Description = '10TH SOILLAYER VOL MOIST'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%h2osoi_vol10
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%maxpatch
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%maxpatch
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%maxpatch
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'subgrid_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%h2osoi_vol10(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%h2osoi_vol10(1,1,1).  ')
  endif
ENDIF
END SUBROUTINE allocs_26
