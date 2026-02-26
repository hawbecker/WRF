!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_1.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_1( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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

IF(okay_to_alloc.AND.in_use_for_config(id,'qv_t_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qv_t_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qv_t_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_t_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qv_t_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qv_t_tend'
  grid%tail_statevars%DataName = 'QV_T_TEND'
  grid%tail_statevars%Description = 'tendency qv time'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%qv_t_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%qv_t_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_t_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'th_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'th_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%th_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%th_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'th_largescale'
  grid%tail_statevars%DataName = 'TH_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale theta'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%th_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%th_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'th_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'th_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%th_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%th_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'th_largescale_tend'
  grid%tail_statevars%DataName = 'TH_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale theta'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%th_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%th_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qv_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qv_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qv_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qv_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qv_largescale'
  grid%tail_statevars%DataName = 'QV_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale qv'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%qv_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%qv_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qv_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qv_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qv_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qv_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qv_largescale_tend'
  grid%tail_statevars%DataName = 'QV_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale qv'
  grid%tail_statevars%Units = 'kg kg-1 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%qv_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%qv_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ql_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ql_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ql_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ql_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ql_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ql_largescale'
  grid%tail_statevars%DataName = 'QL_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale ql'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%ql_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%ql_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ql_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ql_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ql_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ql_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ql_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ql_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ql_largescale_tend'
  grid%tail_statevars%DataName = 'QL_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale ql'
  grid%tail_statevars%Units = 'kg kg-1 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%ql_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%ql_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ql_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'u_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'u_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%u_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%u_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'u_largescale'
  grid%tail_statevars%DataName = 'U_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale u'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%u_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%u_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'u_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'u_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%u_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%u_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'u_largescale_tend'
  grid%tail_statevars%DataName = 'U_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale u'
  grid%tail_statevars%Units = 'm s-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%u_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%u_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'v_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'v_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%v_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%v_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'v_largescale'
  grid%tail_statevars%DataName = 'V_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale v'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%v_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%v_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'v_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'v_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%v_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%v_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'v_largescale_tend'
  grid%tail_statevars%DataName = 'V_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale v'
  grid%tail_statevars%Units = 'm s-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%v_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%v_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_largescale').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_largescale: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_largescale(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_largescale(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_largescale=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_largescale'
  grid%tail_statevars%DataName = 'TAU_LARGESCALE'
  grid%tail_statevars%Description = 'SCM largescale timescale'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_largescale
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_largescale(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_largescale(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_largescale_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_largescale_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_largescale_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_largescale_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_largescale_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_largescale_tend'
  grid%tail_statevars%DataName = 'TAU_LARGESCALE_TEND'
  grid%tail_statevars%Description = 'SCM tendency largescale timescale'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_largescale_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_largescale_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_largescale_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_x').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_x: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_x(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_x(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_x=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_x'
  grid%tail_statevars%DataName = 'TAU_X'
  grid%tail_statevars%Description = 'X-direction advective timescale'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_x
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_x(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_x(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_x_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_x_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_x_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_x_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_x_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_x_tend'
  grid%tail_statevars%DataName = 'TAU_X_TEND'
  grid%tail_statevars%Description = 'tendency X-direction advective timescale'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_x_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_x_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_x_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_y').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_y: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_y(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_y(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_y=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_y'
  grid%tail_statevars%DataName = 'TAU_Y'
  grid%tail_statevars%Description = 'Y-direction advective timescale'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_y
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_y(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_y(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_y_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_y_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_y_tend(1:model_config_rec%num_force_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_y_tend(1:model_config_rec%num_force_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_y_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_y_tend'
  grid%tail_statevars%DataName = 'TAU_Y_TEND'
  grid%tail_statevars%Description = 'tendency Y-direction advective timescale'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_y_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_y_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_y_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soil_forcing_val').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soil_forcing_val: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soil_forcing_val(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soil_forcing_val(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soil_forcing_val=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soil_forcing_val'
  grid%tail_statevars%DataName = 'T_SOIL_FORCING_VAL'
  grid%tail_statevars%Description = 'Soil temp value for SCM forcing'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%t_soil_forcing_val
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%t_soil_forcing_val(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soil_forcing_val(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_soil_forcing_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_soil_forcing_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_soil_forcing_tend(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soil_forcing_tend(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_soil_forcing_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_soil_forcing_tend'
  grid%tail_statevars%DataName = 'T_SOIL_FORCING_TEND'
  grid%tail_statevars%Description = 'tendency soil temp for SCM forcing'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%t_soil_forcing_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%t_soil_forcing_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_soil_forcing_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'q_soil_forcing_val').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'q_soil_forcing_val: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%q_soil_forcing_val(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_soil_forcing_val(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%q_soil_forcing_val=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'q_soil_forcing_val'
  grid%tail_statevars%DataName = 'Q_SOIL_FORCING_VAL'
  grid%tail_statevars%Description = 'Soil moisture value for SCM forcing'
  grid%tail_statevars%Units = '1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%q_soil_forcing_val
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%q_soil_forcing_val(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_soil_forcing_val(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'q_soil_forcing_tend').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'q_soil_forcing_tend: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%q_soil_forcing_tend(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_soil_forcing_tend(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%q_soil_forcing_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'q_soil_forcing_tend'
  grid%tail_statevars%DataName = 'Q_SOIL_FORCING_TEND'
  grid%tail_statevars%Description = 'tendency soil moisture for SCM forcing'
  grid%tail_statevars%Units = 's-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%q_soil_forcing_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%q_soil_forcing_tend(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q_soil_forcing_tend(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_soil').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_soil: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_soil(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_soil(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_soil=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_soil'
  grid%tail_statevars%DataName = 'TAU_SOIL'
  grid%tail_statevars%Description = 'SCM soil forcing timescale'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%tau_soil
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%tau_soil(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_soil(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'soil_depth_force').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%num_force_soil_layers)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'soil_depth_force: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%soil_depth_force(1:model_config_rec%num_force_soil_layers),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%soil_depth_force(1:model_config_rec%num_force_soil_layers). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%soil_depth_force=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'soil_depth_force'
  grid%tail_statevars%DataName = 'SOIL_DEPTH_FORCE'
  grid%tail_statevars%Description = 'SCM depth at center of soil layers in forcing file'
  grid%tail_statevars%Units = '1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%soil_depth_force
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 1
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = 1
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 1
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = 1
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%num_force_soil_layers
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'force_soil_layers'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%soil_depth_force(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%soil_depth_force(1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'hfx_force'
   grid%tail_statevars%DataName = 'HFX_FORCE'
   grid%tail_statevars%Description = 'SCM ideal surface sensible heat flux'
   grid%tail_statevars%Units = 'W m-2'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%hfx_force
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%hfx_force=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'lh_force'
   grid%tail_statevars%DataName = 'LH_FORCE'
   grid%tail_statevars%Description = 'SCM ideal surface latent heat flux'
   grid%tail_statevars%Units = 'W m-2'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%lh_force
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%lh_force=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'tsk_force'
   grid%tail_statevars%DataName = 'TSK_FORCE'
   grid%tail_statevars%Description = 'SCM ideal surface skin temperature'
   grid%tail_statevars%Units = 'W m-2'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%tsk_force
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%tsk_force=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'hfx_force_tend'
   grid%tail_statevars%DataName = 'HFX_FORCE_TEND'
   grid%tail_statevars%Description = 'SCM ideal surface sensible heat flux tendency'
   grid%tail_statevars%Units = 'W m-2 s-1'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%hfx_force_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%hfx_force_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'lh_force_tend'
   grid%tail_statevars%DataName = 'LH_FORCE_TEND'
   grid%tail_statevars%Description = 'SCM ideal surface latent heat flux tendency'
   grid%tail_statevars%Units = 'W m-2 s-1'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%lh_force_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%lh_force_tend=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'tsk_force_tend'
   grid%tail_statevars%DataName = 'TSK_FORCE_TEND'
   grid%tail_statevars%Description = 'SCM ideal surface skin temperature tendency'
   grid%tail_statevars%Units = 'W m-2 s-1'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%tsk_force_tend
  grid%tail_statevars%streams(1) = 268435457 ! 10000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%tsk_force_tend=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'mu_1').AND.(IAND(1,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mu_1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mu_1(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_1(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mu_1'
  grid%tail_statevars%DataName = 'MU_1'
  grid%tail_statevars%Description = 'perturbation dry air mass in column'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 201
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mu_1
  grid%tail_statevars%streams(1) = 33554435 ! 02000003 
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
  ALLOCATE(grid%mu_1(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_1(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mu_2').AND.(IAND(2,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mu_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mu_2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mu_2'
  grid%tail_statevars%DataName = 'MU_2'
  grid%tail_statevars%Description = 'perturbation dry air mass in column'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 202
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mu_2
  grid%tail_statevars%streams(1) = 33554435 ! 02000003 
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
  ALLOCATE(grid%mu_2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_2(1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_bxs(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bxs(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_bxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_bxe(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bxe(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_bxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_bys(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bys(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_bys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_bye(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bye(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_bye=initial_data_value
ELSE
  ALLOCATE(grid%mu_bxs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bxs(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_bxe(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bxe(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_bys(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bys(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_bye(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_bye(1,1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_btxs(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btxs(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_btxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_btxe(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btxe(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_btxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_btys(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btys(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_btys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%mu_btye(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btye(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu_btye=initial_data_value
ELSE
  ALLOCATE(grid%mu_btxs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btxs(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_btxe(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btxe(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_btys(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btys(1,1,1).  ')
  endif
  ALLOCATE(grid%mu_btye(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu_btye(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mub'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mub: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mub(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mub=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mub'
  grid%tail_statevars%DataName = 'MUB'
  grid%tail_statevars%Description = 'base state dry air mass in column'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mub
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%mub(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mub_fine').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mub_fine: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mub_fine(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub_fine(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mub_fine=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mub_fine'
  grid%tail_statevars%DataName = 'MUB_FINE'
  grid%tail_statevars%Description = 'nest temp, holds interpolated coarse grid mub'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mub_fine
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%mub_fine(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub_fine(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mub_save').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mub_save: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mub_save(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub_save(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mub_save=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mub_save'
  grid%tail_statevars%DataName = 'MUB_SAVE'
  grid%tail_statevars%Description = 'nest temp, holds orig fine grid mub'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mub_save
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%mub_save(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mub_save(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mu0').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mu0: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mu0(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu0(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mu0=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mu0'
  grid%tail_statevars%DataName = 'MU0'
  grid%tail_statevars%Description = 'initial dry mass in column'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mu0
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
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
  ALLOCATE(grid%mu0(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mu0(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mudf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mudf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mudf(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mudf(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mudf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mudf'
  grid%tail_statevars%DataName = 'MUDF'
  grid%tail_statevars%Description = ''
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mudf
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%mudf(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mudf(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'muu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'muu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%muu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%muu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'muu'
  grid%tail_statevars%DataName = 'MUU'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%muu
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
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
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%muu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'muus').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'muus: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%muus(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muus(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%muus=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'muus'
  grid%tail_statevars%DataName = 'MUUS'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%muus
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
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
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%muus(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muus(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'muv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'muv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%muv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%muv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'muv'
  grid%tail_statevars%DataName = 'MUV'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Y'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%muv
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
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
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%muv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'muvs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'muvs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%muvs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muvs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%muvs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'muvs'
  grid%tail_statevars%DataName = 'MUVS'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Y'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%muvs
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
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
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%muvs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muvs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mut').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mut: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mut(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mut(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mut=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mut'
  grid%tail_statevars%DataName = 'MUT'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mut
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%mut(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mut(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'muts').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'muts: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%muts(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muts(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%muts=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'muts'
  grid%tail_statevars%DataName = 'MUTS'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%muts
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%muts(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%muts(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'nest_pos'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'nest_pos: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%nest_pos(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nest_pos(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%nest_pos=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'nest_pos'
  grid%tail_statevars%DataName = 'NEST_POS'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%nest_pos
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
  ALLOCATE(grid%nest_pos(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nest_pos(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'nest_mask'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'nest_mask: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%nest_mask(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nest_mask(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%nest_mask=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'nest_mask'
  grid%tail_statevars%DataName = 'NEST_MASK'
  grid%tail_statevars%Description = 'LOCATION OF NEST IF ANY'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%nest_mask
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
  ALLOCATE(grid%nest_mask(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nest_mask(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ht_coarse').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ht_coarse: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ht_coarse(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ht_coarse(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ht_coarse=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ht_coarse'
  grid%tail_statevars%DataName = 'HT_COARSE'
  grid%tail_statevars%Description = 'STORAGE FOR LOW-RES TERRAIN'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%ht_coarse
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
  ALLOCATE(grid%ht_coarse(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ht_coarse(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tke_1').AND.(.NOT.grid%is_intermediate).AND.(IAND(1,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tke_1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tke_1(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tke_1(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tke_1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tke_1'
  grid%tail_statevars%DataName = 'TKE_1'
  grid%tail_statevars%Description = 'TURBULENCE KINETIC ENERGY'
  grid%tail_statevars%Units = 'm2 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 201
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%tke_1
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
  ALLOCATE(grid%tke_1(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tke_1(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tke_2').AND.(.NOT.grid%is_intermediate).AND.(IAND(2,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tke_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tke_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tke_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tke_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tke_2'
  grid%tail_statevars%DataName = 'TKE_2'
  grid%tail_statevars%Description = 'TURBULENCE KINETIC ENERGY'
  grid%tail_statevars%Units = 'm2 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 202
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%tke_2
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
  ALLOCATE(grid%tke_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tke_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'nlflux').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'nlflux: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%nlflux(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nlflux(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%nlflux=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'nlflux'
  grid%tail_statevars%DataName = 'NLFLUX'
  grid%tail_statevars%Description = 'PRESCRIBED NONLOCAL HEAT FLUX IN 3DTKE SCHEME'
  grid%tail_statevars%Units = 'K m s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%nlflux
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
  ALLOCATE(grid%nlflux(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nlflux(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gamu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gamu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gamu(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gamu(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gamu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gamu'
  grid%tail_statevars%DataName = 'GAMU'
  grid%tail_statevars%Description = 'NONLOCAL U GAMMA TERM IN 3DTKE SCHEME'
  grid%tail_statevars%Units = 's-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%gamu
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
  ALLOCATE(grid%gamu(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gamu(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gamv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gamv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gamv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gamv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gamv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gamv'
  grid%tail_statevars%DataName = 'GAMV'
  grid%tail_statevars%Description = 'NONLOCAL V GAMMA TERM IN 3DTKE SCHEME'
  grid%tail_statevars%Units = 's-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%gamv
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
  ALLOCATE(grid%gamv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gamv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dlk').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dlk: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dlk(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dlk(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dlk=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dlk'
  grid%tail_statevars%DataName = 'DLK'
  grid%tail_statevars%Description = 'TURBULENT LENGTH SCALE'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dlk
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
  ALLOCATE(grid%dlk(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dlk(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'l_diss').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'l_diss: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%l_diss(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%l_diss(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%l_diss=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'l_diss'
  grid%tail_statevars%DataName = 'L_DISS'
  grid%tail_statevars%Description = 'DISSIPATION LENGTH SCALE'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%l_diss
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
  ALLOCATE(grid%l_diss(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%l_diss(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'elmin').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'elmin: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%elmin(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elmin(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%elmin=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'elmin'
  grid%tail_statevars%DataName = 'ELMIN'
  grid%tail_statevars%Description = 'FREE ATMOS LENGTH SCALE (FROM BOULAC SCHEME)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%elmin
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
  ALLOCATE(grid%elmin(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elmin(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'xkmv_meso').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'xkmv_meso: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%xkmv_meso(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xkmv_meso(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%xkmv_meso=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'xkmv_meso'
  grid%tail_statevars%DataName = 'XKMV_MESO'
  grid%tail_statevars%Description = 'XKMV AT MESOSCALE LIMIT'
  grid%tail_statevars%Units = 'm2 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%xkmv_meso
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
  ALLOCATE(grid%xkmv_meso(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xkmv_meso(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p'
  grid%tail_statevars%DataName = 'P'
  grid%tail_statevars%Description = 'perturbation pressure'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%p(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'al').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'al: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%al(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%al(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%al=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'al'
  grid%tail_statevars%DataName = 'AL'
  grid%tail_statevars%Description = 'inverse perturbation density'
  grid%tail_statevars%Units = 'm3 kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%al
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
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
  ALLOCATE(grid%al(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%al(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'alt').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'alt: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%alt(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alt(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%alt=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'alt'
  grid%tail_statevars%DataName = 'ALT'
  grid%tail_statevars%Description = 'inverse density'
  grid%tail_statevars%Units = 'm3 kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%alt
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
  ALLOCATE(grid%alt(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alt(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'alb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'alb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%alb(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alb(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%alb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'alb'
  grid%tail_statevars%DataName = 'ALB'
  grid%tail_statevars%Description = 'inverse base density'
  grid%tail_statevars%Units = 'm3 kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%alb
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
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
  ALLOCATE(grid%alb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%alb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'zx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'zx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%zx(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%zx(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%zx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'zx'
  grid%tail_statevars%DataName = 'ZX'
  grid%tail_statevars%Description = ' '
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'XZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%zx
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
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
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = kps
  grid%tail_statevars%ep2 = MIN( kde, kpe )
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'bottom_top_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%zx(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%zx(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'zy').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'zy: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%zy(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%zy(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%zy=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'zy'
  grid%tail_statevars%DataName = 'ZY'
  grid%tail_statevars%Description = ' '
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'YZ'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%zy
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = kds
  grid%tail_statevars%ed2 = kde
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = jde
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
  grid%tail_statevars%ep3 = MIN( jde, jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'bottom_top_stag'
  grid%tail_statevars%dimname3 = 'south_north_stag'
  ENDIF
ELSE
  ALLOCATE(grid%zy(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%zy(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rdz').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rdz: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rdz(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdz(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rdz=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rdz'
  grid%tail_statevars%DataName = 'RDZ'
  grid%tail_statevars%Description = ' '
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rdz
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
  ALLOCATE(grid%rdz(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdz(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rdzw').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rdzw: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rdzw(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdzw(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rdzw=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rdzw'
  grid%tail_statevars%DataName = 'RDZW'
  grid%tail_statevars%Description = ' '
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rdzw
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
  ALLOCATE(grid%rdzw(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdzw(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pb(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pb(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pb'
  grid%tail_statevars%DataName = 'PB'
  grid%tail_statevars%Description = 'BASE STATE PRESSURE '
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pb
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%pb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rho').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rho: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rho(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rho(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rho=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rho'
  grid%tail_statevars%DataName = 'RHO'
  grid%tail_statevars%Description = 'DENSITY'
  grid%tail_statevars%Units = 'Kg m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rho
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
  ALLOCATE(grid%rho(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rho(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fnm').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fnm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fnm(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fnm(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fnm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fnm'
  grid%tail_statevars%DataName = 'FNM'
  grid%tail_statevars%Description = 'upper weight for vertical stretching'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%fnm
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%fnm(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fnm(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'fnp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'fnp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%fnp(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fnp(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%fnp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'fnp'
  grid%tail_statevars%DataName = 'FNP'
  grid%tail_statevars%Description = 'lower weight for vertical stretching'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%fnp
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%fnp(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%fnp(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rdnw').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rdnw: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rdnw(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdnw(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rdnw=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rdnw'
  grid%tail_statevars%DataName = 'RDNW'
  grid%tail_statevars%Description = 'inverse d(eta) values between full (w) levels'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%rdnw
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%rdnw(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdnw(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rdn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rdn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rdn(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdn(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rdn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rdn'
  grid%tail_statevars%DataName = 'RDN'
  grid%tail_statevars%Description = 'inverse d(eta) values between half (mass) levels'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%rdn
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%rdn(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdn(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dnw').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dnw: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dnw(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dnw(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dnw=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dnw'
  grid%tail_statevars%DataName = 'DNW'
  grid%tail_statevars%Description = 'd(eta) values between full (w) levels'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%dnw
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%dnw(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dnw(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dn(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dn(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dn'
  grid%tail_statevars%DataName = 'DN '
  grid%tail_statevars%Description = 'd(eta) values between half (mass) levels'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%dn
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%dn(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dn(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t_base').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't_base: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t_base(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_base(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t_base=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't_base'
  grid%tail_statevars%DataName = 'T_BASE'
  grid%tail_statevars%Description = 'BASE STATE T IN IDEALIZED CASES'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%t_base
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
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
  ALLOCATE(grid%t_base(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t_base(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'z').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'z: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%z(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%z(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%z=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'z'
  grid%tail_statevars%DataName = 'Z'
  grid%tail_statevars%Description = ' '
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%z
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
  ALLOCATE(grid%z(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%z(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'z_at_w').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'z_at_w: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%z_at_w(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%z_at_w(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%z_at_w=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'z_at_w'
  grid%tail_statevars%DataName = 'Z_AT_W'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%z_at_w
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
  ALLOCATE(grid%z_at_w(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%z_at_w(1,1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cfn'
   grid%tail_statevars%DataName = 'CFN'
   grid%tail_statevars%Description = 'extrapolation constant'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cfn
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cfn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cfn1'
   grid%tail_statevars%DataName = 'CFN1'
   grid%tail_statevars%Description = 'extrapolation constant'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cfn1
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cfn1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'step_number'
   grid%tail_statevars%DataName = 'STEP_NUMBER'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%step_number
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%step_number=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'this_is_an_ideal_run'
   grid%tail_statevars%DataName = 'THIS_IS_AN_IDEAL_RUN'
   grid%tail_statevars%Description = 'T/F flag: this is an ARW ideal simulation'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%this_is_an_ideal_run
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%this_is_an_ideal_run=.FALSE.
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'stepping_to_time'
   grid%tail_statevars%DataName = 'STEPPING_TO_TIME'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%stepping_to_time
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%stepping_to_time=.FALSE.
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_step_updated'
   grid%tail_statevars%DataName = 'LAST_STEP_UPDATED'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_step_updated
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_step_updated=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'adapt_step_using_child'
   grid%tail_statevars%DataName = 'ADAPT_STEP_USING_CHILD'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%adapt_step_using_child
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%adapt_step_using_child=.FALSE.
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_dt_sec'
   grid%tail_statevars%DataName = 'LAST_DT_SEC'
   grid%tail_statevars%Description = 'Whole seconds for last timestep'
   grid%tail_statevars%Units = 'sec'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_dt_sec
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_dt_sec=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_dt_sec_num'
   grid%tail_statevars%DataName = 'LAST_DT_SEC_NUM'
   grid%tail_statevars%Description = 'Fractional secs, numerator'
   grid%tail_statevars%Units = 'sec'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_dt_sec_num
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_dt_sec_num=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_dt_sec_den'
   grid%tail_statevars%DataName = 'LAST_DT_SEC_DEN'
   grid%tail_statevars%Description = 'Fractional secs, denominator'
   grid%tail_statevars%Units = 'sec'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_dt_sec_den
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_dt_sec_den=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_dt_yr'
   grid%tail_statevars%DataName = 'LAST_DT_YR'
   grid%tail_statevars%Description = 'Relative year'
   grid%tail_statevars%Units = 'years'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_dt_yr
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_dt_yr=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'last_dt_mm'
   grid%tail_statevars%DataName = 'LAST_DT_MM'
   grid%tail_statevars%Description = 'Relative month'
   grid%tail_statevars%Units = 'months'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%last_dt_mm
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%last_dt_mm=0
IF(okay_to_alloc.AND.in_use_for_config(id,'p_hyd').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_hyd: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_hyd(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_hyd(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_hyd=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_hyd'
  grid%tail_statevars%DataName = 'P_HYD'
  grid%tail_statevars%Description = 'hydrostatic pressure'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_hyd
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%p_hyd(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_hyd(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_hyd_w').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_hyd_w: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_hyd_w(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_hyd_w(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_hyd_w=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_hyd_w'
  grid%tail_statevars%DataName = 'P_HYD_W'
  grid%tail_statevars%Description = 'hydrostatic pressure at full levels'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_hyd_w
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
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
  ALLOCATE(grid%p_hyd_w(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_hyd_w(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'q2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'q2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%q2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%q2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'q2'
  grid%tail_statevars%DataName = 'Q2'
  grid%tail_statevars%Description = 'QV at 2 M'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%q2
  grid%tail_statevars%streams(1) = 46137347 ! 02c00003 
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
  ALLOCATE(grid%q2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't2'
  grid%tail_statevars%DataName = 'T2'
  grid%tail_statevars%Description = 'TEMP at 2 M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%t2
  grid%tail_statevars%streams(1) = 113246211 ! 06c00003 
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
  ALLOCATE(grid%t2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'th2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'th2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%th2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%th2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'th2'
  grid%tail_statevars%DataName = 'TH2'
  grid%tail_statevars%Description = 'POT TEMP at 2 M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%th2
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%th2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th2(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'psfc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'psfc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%psfc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%psfc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%psfc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'psfc'
  grid%tail_statevars%DataName = 'PSFC'
  grid%tail_statevars%Description = 'SFC PRESSURE'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%psfc
  grid%tail_statevars%streams(1) = 100663299 ! 06000003 
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
  ALLOCATE(grid%psfc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%psfc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'u10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'u10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%u10(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u10(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%u10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'u10'
  grid%tail_statevars%DataName = 'U10'
  grid%tail_statevars%Description = 'U at 10 M'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%u10
  grid%tail_statevars%streams(1) = 46137347 ! 02c00003 
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
  ALLOCATE(grid%u10(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u10(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'v10'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'v10: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%v10(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v10(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%v10=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'v10'
  grid%tail_statevars%DataName = 'V10'
  grid%tail_statevars%Description = 'V at 10 M'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%v10
  grid%tail_statevars%streams(1) = 46137347 ! 02c00003 
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
  ALLOCATE(grid%v10(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v10(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lpi'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lpi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lpi(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lpi(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lpi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lpi'
  grid%tail_statevars%DataName = 'LPI'
  grid%tail_statevars%Description = 'Lightning Potential Index'
  grid%tail_statevars%Units = 'm^2 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lpi
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
  ALLOCATE(grid%lpi(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lpi(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'uratx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'uratx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%uratx(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%uratx(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%uratx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'uratx'
  grid%tail_statevars%DataName = 'URATX'
  grid%tail_statevars%Description = 'Ratio of U over U10 on mass points '
  grid%tail_statevars%Units = 'dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%uratx
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
  ALLOCATE(grid%uratx(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%uratx(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vratx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vratx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vratx(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vratx(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vratx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vratx'
  grid%tail_statevars%DataName = 'VRATX'
  grid%tail_statevars%Description = 'Ratio of V over V10 on mass points '
  grid%tail_statevars%Units = 'dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%vratx
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
  ALLOCATE(grid%vratx(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vratx(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tratx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tratx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tratx(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tratx(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tratx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tratx'
  grid%tail_statevars%DataName = 'TRATX'
  grid%tail_statevars%Description = 'Ratio of T over TH2 on mass points '
  grid%tail_statevars%Units = 'dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tratx
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
  ALLOCATE(grid%tratx(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tratx(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'obs_savwt').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((model_config_rec%nobs_err_flds)-(1)+1))*(((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((model_config_rec%nobs_err_flds)-(1)+1))*(((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'obs_savwt: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%obs_savwt(1:model_config_rec%nobs_err_flds,sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%obs_savwt(1:model_config_rec%nobs_err_flds,sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%obs_savwt=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'obs_savwt'
  grid%tail_statevars%DataName = 'OBS_SAVWT'
  grid%tail_statevars%Description = 'Internal space holding weights of each ob, for each i,j,k'
  grid%tail_statevars%Units = 'dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'CXZ'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_4d => grid%obs_savwt
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = 1
  grid%tail_statevars%ed1 = config_flags%nobs_err_flds
  grid%tail_statevars%sd2 = ids
  grid%tail_statevars%ed2 = ide
  grid%tail_statevars%sd3 = kds
  grid%tail_statevars%ed3 = (kde-1)
  grid%tail_statevars%sm1 = 1
  grid%tail_statevars%em1 = config_flags%nobs_err_flds
  grid%tail_statevars%sm2 = ims
  grid%tail_statevars%em2 = ime
  grid%tail_statevars%sm3 = kms
  grid%tail_statevars%em3 = kme
  grid%tail_statevars%sp1 = 1
  grid%tail_statevars%ep1 = config_flags%nobs_err_flds
  grid%tail_statevars%sp2 = ips
  grid%tail_statevars%ep2 = MIN( ide, ipe )
  grid%tail_statevars%sp3 = kps
  grid%tail_statevars%ep3 = MIN( (kde-1), kpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%dimname1 = ''
  grid%tail_statevars%dimname2 = 'west_east_stag'
  grid%tail_statevars%dimname3 = 'bottom_top'
  ENDIF
ELSE
  ALLOCATE(grid%obs_savwt(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%obs_savwt(1,1,1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'rdx'
   grid%tail_statevars%DataName = 'RDX'
   grid%tail_statevars%Description = 'INVERSE X GRID LENGTH'
   grid%tail_statevars%Units = 'm-1'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%rdx
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%rdx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'rdy'
   grid%tail_statevars%DataName = 'RDY'
   grid%tail_statevars%Description = 'INVERSE Y GRID LENGTH'
   grid%tail_statevars%Units = 'm-1'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%rdy
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%rdy=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'area2d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'area2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%area2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%area2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%area2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'area2d'
  grid%tail_statevars%DataName = 'AREA2D'
  grid%tail_statevars%Description = 'Horizontal grid cell area, using dx, dy, and map factors'
  grid%tail_statevars%Units = 'm2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%area2d
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
  ALLOCATE(grid%area2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%area2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dx2d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dx2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dx2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dx2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dx2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dx2d'
  grid%tail_statevars%DataName = 'DX2D'
  grid%tail_statevars%Description = 'Horizontal grid distance: sqrt(area2d)'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%dx2d
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
  ALLOCATE(grid%dx2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dx2d(1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'dts'
   grid%tail_statevars%DataName = 'DTS'
   grid%tail_statevars%Description = 'SMALL TIMESTEP'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%dts
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%dts=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'dtseps'
   grid%tail_statevars%DataName = 'DTSEPS'
   grid%tail_statevars%Description = 'TIME WEIGHT CONSTANT FOR SMALL STEPS'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%dtseps
  grid%tail_statevars%streams(1) = 33554432 ! 02000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%dtseps=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'resm'
   grid%tail_statevars%DataName = 'RESM'
   grid%tail_statevars%Description = 'TIME WEIGHT CONSTANT FOR SMALL STEPS'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%resm
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%resm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'zetatop'
   grid%tail_statevars%DataName = 'ZETATOP'
   grid%tail_statevars%Description = 'ZETA AT MODEL TOP'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%zetatop
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%zetatop=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cf1'
   grid%tail_statevars%DataName = 'CF1'
   grid%tail_statevars%Description = '2nd order extrapolation constant'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cf1
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cf1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cf2'
   grid%tail_statevars%DataName = 'CF2'
   grid%tail_statevars%Description = '2nd order extrapolation constant'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cf2
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cf2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cf3'
   grid%tail_statevars%DataName = 'CF3'
   grid%tail_statevars%Description = '2nd order extrapolation constant'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cf3
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cf3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'number_at_same_level'
   grid%tail_statevars%DataName = 'NUMBER_AT_SAME_LEVEL'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%number_at_same_level
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%number_at_same_level=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'radtacttime'
   grid%tail_statevars%DataName = 'RADTACTTIME'
   grid%tail_statevars%Description = 'RADTACTTIME'
   grid%tail_statevars%Units = 'LW SW ACTIVATION TIME in s'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%radtacttime
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%radtacttime=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'bldtacttime'
   grid%tail_statevars%DataName = 'BLDTACTTIME'
   grid%tail_statevars%Description = 'BLDTACTTIME'
   grid%tail_statevars%Units = 'PBL   ACTIVATION TIME in s'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%bldtacttime
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%bldtacttime=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'cudtacttime'
   grid%tail_statevars%DataName = 'CUDTACTTIME'
   grid%tail_statevars%Description = 'CUDTACTTIME'
   grid%tail_statevars%Units = 'CPS   ACTIVATION TIME in s'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%cudtacttime
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%cudtacttime=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'ltngacttime'
   grid%tail_statevars%DataName = 'LTNGACTTIME'
   grid%tail_statevars%Description = 'LTNGACTTIME'
   grid%tail_statevars%Units = 'LTNG  ACTIVATION TIME in s'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%ltngacttime
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%ltngacttime=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'power').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'power: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%power(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%power(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%power=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'power'
  grid%tail_statevars%DataName = 'POWER'
  grid%tail_statevars%Description = 'Power production'
  grid%tail_statevars%Units = 'W'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%power
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%power(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%power(1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'itimestep'
   grid%tail_statevars%DataName = 'ITIMESTEP'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%itimestep
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%itimestep=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'xtime'
   grid%tail_statevars%DataName = 'XTIME'
   grid%tail_statevars%Description = 'minutes since YYYY-MM-DD hh:mm:ss'
   grid%tail_statevars%Units = 'minutes since simulation start'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%xtime
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%xtime=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'julian'
   grid%tail_statevars%DataName = 'JULIAN'
   grid%tail_statevars%Description = 'day of year, 0.0 at 0Z on 1 Jan.'
   grid%tail_statevars%Units = 'days'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%julian
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%julian=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'lbc_fid'
   grid%tail_statevars%DataName = 'LBC_FID'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%lbc_fid
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%lbc_fid=0
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'tiled'
   grid%tail_statevars%DataName = 'TILED'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%tiled
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%tiled=.FALSE.
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'patched'
   grid%tail_statevars%DataName = 'PATCHED'
   grid%tail_statevars%Description = ''
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%patched
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%patched=.FALSE.
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'press_adj'
   grid%tail_statevars%DataName = 'PRESS_ADJ'
   grid%tail_statevars%Description = 'T/F flag adjust mu'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'l'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .FALSE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%lfield_0d => grid%press_adj
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%press_adj=.FALSE.
IF(okay_to_alloc.AND.in_use_for_config(id,'imask_nostag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'imask_nostag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%imask_nostag(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_nostag(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%imask_nostag=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'imask_nostag'
  grid%tail_statevars%DataName = 'IMASK_NOSTAG'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%imask_nostag
  grid%tail_statevars%streams(1) = 0 ! 00000000 
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
  ALLOCATE(grid%imask_nostag(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_nostag(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'imask_xstag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'imask_xstag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%imask_xstag(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_xstag(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%imask_xstag=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'imask_xstag'
  grid%tail_statevars%DataName = 'IMASK_XSTAG'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%imask_xstag
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = ide
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
  grid%tail_statevars%ep1 = MIN( ide, ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east_stag'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%imask_xstag(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_xstag(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'imask_ystag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'imask_ystag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%imask_ystag(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_ystag(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%imask_ystag=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'imask_ystag'
  grid%tail_statevars%DataName = 'IMASK_YSTAG'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'Y'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%imask_ystag
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
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
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( jde, jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north_stag'
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%imask_ystag(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_ystag(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'imask_xystag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'imask_xystag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%imask_xystag(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_xystag(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%imask_xystag=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'imask_xystag'
  grid%tail_statevars%DataName = 'IMASK_XYSTAG'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = 'XY'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%imask_xystag
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%imask_xystag(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%imask_xystag(1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'xi'
   grid%tail_statevars%DataName = 'XI'
   grid%tail_statevars%Description = '-'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%xi
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%xi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'xj'
   grid%tail_statevars%DataName = 'XJ'
   grid%tail_statevars%Description = '-'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%xj
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%xj=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'vc_i'
   grid%tail_statevars%DataName = 'VC_I'
   grid%tail_statevars%Description = '-'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%vc_i
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%vc_i=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'vc_j'
   grid%tail_statevars%DataName = 'VC_J'
   grid%tail_statevars%Description = '-'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%vc_j
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%vc_j=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'moist'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1)*num_moist)) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1)*num_moist)) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'moist: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%moist(sm31:em31,sm32:em32,sm33:em33,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist(sm31:em31,sm32:em32,sm33:em33,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'moist'
  grid%tail_statevars%DataName = 'MOIST'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .TRUE.
  grid%tail_statevars%rfield_4d => grid%moist
  grid%tail_statevars%num_table => moist_num_table
  grid%tail_statevars%index_table => moist_index_table
  grid%tail_statevars%boundary_table => moist_boundary_table
  grid%tail_statevars%dname_table => moist_dname_table
  grid%tail_statevars%desc_table => moist_desc_table
  grid%tail_statevars%units_table => moist_units_table
  grid%tail_statevars%streams_table => moist_streams_table
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%moist(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist(1,1,1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_bxs(sm33:em33,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bxs(sm33:em33,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_bxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_bxe(sm33:em33,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bxe(sm33:em33,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_bxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_bys(sm31:em31,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bys(sm31:em31,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_bys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_bye(sm31:em31,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bye(sm31:em31,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_bye=initial_data_value
ELSE
  ALLOCATE(grid%moist_bxs(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bxs(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_bxe(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bxe(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_bys(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bys(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_bye(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_bye(1,1,1,num_moist).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_btxs(sm33:em33,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btxs(sm33:em33,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_btxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_btxe(sm33:em33,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btxe(sm33:em33,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_btxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_btys(sm31:em31,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btys(sm31:em31,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_btys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_moist)) * RWORDSIZE
  ALLOCATE(grid%moist_btye(sm31:em31,sm32:em32,spec_bdy_width,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btye(sm31:em31,sm32:em32,spec_bdy_width,num_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%moist_btye=initial_data_value
ELSE
  ALLOCATE(grid%moist_btxs(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btxs(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_btxe(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btxe(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_btys(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btys(1,1,1,num_moist).  ')
  endif
  ALLOCATE(grid%moist_btye(1,1,1,num_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%moist_btye(1,1,1,num_moist).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dfi_moist'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1)*num_dfi_moist)) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1)*num_dfi_moist)) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dfi_moist: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dfi_moist(sm31:em31,sm32:em32,sm33:em33,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist(sm31:em31,sm32:em32,sm33:em33,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dfi_moist'
  grid%tail_statevars%DataName = 'DFI_MOIST'
  grid%tail_statevars%Description = '-'
  grid%tail_statevars%Units = '-'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 4
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .TRUE.
  grid%tail_statevars%rfield_4d => grid%dfi_moist
  grid%tail_statevars%num_table => dfi_moist_num_table
  grid%tail_statevars%index_table => dfi_moist_index_table
  grid%tail_statevars%boundary_table => dfi_moist_boundary_table
  grid%tail_statevars%dname_table => dfi_moist_dname_table
  grid%tail_statevars%desc_table => dfi_moist_desc_table
  grid%tail_statevars%units_table => dfi_moist_units_table
  grid%tail_statevars%streams_table => dfi_moist_streams_table
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
  ALLOCATE(grid%dfi_moist(1,1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist(1,1,1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_bxs(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bxs(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_bxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_bxe(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bxe(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_bxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_bys(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bys(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_bys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_bye(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bye(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_bye=initial_data_value
ELSE
  ALLOCATE(grid%dfi_moist_bxs(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bxs(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_bxe(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bxe(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_bys(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bys(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_bye(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_bye(1,1,1,num_dfi_moist).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_btxs(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btxs(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_btxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_btxe(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btxe(sm33:em33,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_btxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_btys(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btys(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_btys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(em32-sm32+1)*(spec_bdy_width)*num_dfi_moist)) * RWORDSIZE
  ALLOCATE(grid%dfi_moist_btye(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btye(sm31:em31,sm32:em32,spec_bdy_width,num_dfi_moist). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dfi_moist_btye=initial_data_value
ELSE
  ALLOCATE(grid%dfi_moist_btxs(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btxs(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_btxe(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btxe(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_btys(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btys(1,1,1,num_dfi_moist).  ')
  endif
  ALLOCATE(grid%dfi_moist_btye(1,1,1,num_dfi_moist),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dfi_moist_btye(1,1,1,num_dfi_moist).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qvold'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qvold: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qvold(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qvold(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qvold=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qvold'
  grid%tail_statevars%DataName = 'QVOLD'
  grid%tail_statevars%Description = 'Water vapor mixing ratio, old time step'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qvold
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
  ALLOCATE(grid%qvold(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qvold(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rimi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rimi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rimi(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rimi(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rimi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rimi'
  grid%tail_statevars%DataName = 'RIMI'
  grid%tail_statevars%Description = 'riming intensity'
  grid%tail_statevars%Units = 'fraction'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rimi
  grid%tail_statevars%streams(1) = 33554433 ! 02000001 
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
  ALLOCATE(grid%rimi(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rimi(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnwfa2d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnwfa2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnwfa2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnwfa2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnwfa2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnwfa2d'
  grid%tail_statevars%DataName = 'QNWFA2D'
  grid%tail_statevars%Description = 'Surface aerosol number conc emission'
  grid%tail_statevars%Units = 'kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%qnwfa2d
  grid%tail_statevars%streams(1) = 100663297 ! 06000001 
  grid%tail_statevars%streams(2) = 2099200 ! 00200800 
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
  ALLOCATE(grid%qnwfa2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnwfa2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnifa2d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnifa2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnifa2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnifa2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnifa2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnifa2d'
  grid%tail_statevars%DataName = 'QNIFA2D'
  grid%tail_statevars%Description = 'Surface dust number conc emission'
  grid%tail_statevars%Units = 'kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%qnifa2d
  grid%tail_statevars%streams(1) = 100663297 ! 06000001 
  grid%tail_statevars%streams(2) = 2099200 ! 00200800 
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
  ALLOCATE(grid%qnifa2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnifa2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnbca2d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnbca2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnbca2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnbca2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnbca2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnbca2d'
  grid%tail_statevars%DataName = 'QNBCA2D'
  grid%tail_statevars%Description = 'Surface black carbon number conc emission'
  grid%tail_statevars%Units = 'kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%qnbca2d
  grid%tail_statevars%streams(1) = 100663297 ! 06000001 
  grid%tail_statevars%streams(2) = 2099200 ! 00200800 
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
  ALLOCATE(grid%qnbca2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnbca2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnocbb2d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnocbb2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnocbb2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnocbb2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnocbb2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnocbb2d'
  grid%tail_statevars%DataName = 'QNOCBB2D'
  grid%tail_statevars%Description = 'Surface organic carbon biomass burning number conc emission'
  grid%tail_statevars%Units = 'kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%qnocbb2d
  grid%tail_statevars%streams(1) = 100663297 ! 06000001 
  grid%tail_statevars%streams(2) = 2099200 ! 00200800 
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
  ALLOCATE(grid%qnocbb2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnocbb2d(1,1).  ')
  endif
ENDIF
END SUBROUTINE allocs_1
