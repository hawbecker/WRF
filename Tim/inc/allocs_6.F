!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_6.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_6( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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

  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'tlp_strat'
   grid%tail_statevars%DataName = 'TLP_STRAT'
   grid%tail_statevars%Description = 'BASE STATE LAPSE RATE (DT/D(LN(P)) IN STRATOSPHERE'
   grid%tail_statevars%Units = 'K'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%tlp_strat
  grid%tail_statevars%streams(1) = 167772161 ! 0a000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%tlp_strat=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'p_strat'
   grid%tail_statevars%DataName = 'P_STRAT'
   grid%tail_statevars%Description = 'BASE STATE PRESSURE AT BOTTOM OF STRATOSPHERE'
   grid%tail_statevars%Units = 'Pa'
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%p_strat
  grid%tail_statevars%streams(1) = 167772161 ! 0a000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%p_strat=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'max_msftx'
   grid%tail_statevars%DataName = 'MAX_MSFTX'
   grid%tail_statevars%Description = 'Max map factor in domain'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%max_msftx
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%max_msftx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'max_msfty'
   grid%tail_statevars%DataName = 'MAX_MSFTY'
   grid%tail_statevars%Description = 'Max map factor in domain'
   grid%tail_statevars%Units = ''
   grid%tail_statevars%Type    = 'r'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%rfield_0d => grid%max_msfty
  grid%tail_statevars%streams(1) = 1 ! 00000001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%max_msfty=initial_data_value
IF(okay_to_alloc.AND.in_use_for_config(id,'phys_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'phys_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%phys_tot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phys_tot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%phys_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'phys_tot'
  grid%tail_statevars%DataName = 'PHYS_TOT'
  grid%tail_statevars%Description = 'TOTAL LATENT HEATING RATE'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%phys_tot
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%phys_tot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phys_tot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physc(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physc(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physc'
  grid%tail_statevars%DataName = 'PHYSC'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO CONDENSATION'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physc
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
  ALLOCATE(grid%physc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physe').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physe: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physe(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physe(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physe=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physe'
  grid%tail_statevars%DataName = 'PHYSE'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO EVAPORATION'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physe
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
  ALLOCATE(grid%physe(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physe(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physd').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physd: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physd(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physd(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physd=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physd'
  grid%tail_statevars%DataName = 'PHYSD'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO DEPOSITION'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physd
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
  ALLOCATE(grid%physd(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physd(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physs(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physs(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physs'
  grid%tail_statevars%DataName = 'PHYSS'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO SUBLIMATION'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physs
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
  ALLOCATE(grid%physs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physs(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physm').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physm(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physm(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physm'
  grid%tail_statevars%DataName = 'PHYSM'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO MELTING'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physm
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
  ALLOCATE(grid%physm(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physm(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'physf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'physf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%physf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%physf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'physf'
  grid%tail_statevars%DataName = 'PHYSF'
  grid%tail_statevars%Description = 'LATENT HEATING RATE DUE TO FREEZING'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%physf
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
  ALLOCATE(grid%physf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%physf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphys_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphys_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphys_tot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphys_tot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphys_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphys_tot'
  grid%tail_statevars%DataName = 'ACPHYS_TOT'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL LATENT HEATING'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphys_tot
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
  ALLOCATE(grid%acphys_tot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphys_tot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphysc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphysc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphysc(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysc(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphysc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphysc'
  grid%tail_statevars%DataName = 'ACPHYSC'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO CONDENSATION'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphysc
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
  ALLOCATE(grid%acphysc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphyse').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphyse: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphyse(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphyse(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphyse=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphyse'
  grid%tail_statevars%DataName = 'ACPHYSE'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO EVAPORATION'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphyse
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
  ALLOCATE(grid%acphyse(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphyse(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphysd').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphysd: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphysd(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysd(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphysd=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphysd'
  grid%tail_statevars%DataName = 'ACPHYSD'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO DEPOSITION'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphysd
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
  ALLOCATE(grid%acphysd(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysd(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphyss').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphyss: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphyss(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphyss(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphyss=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphyss'
  grid%tail_statevars%DataName = 'ACPHYSS'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO SUBLIMATION'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphyss
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
  ALLOCATE(grid%acphyss(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphyss(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphysm').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphysm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphysm(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysm(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphysm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphysm'
  grid%tail_statevars%DataName = 'ACPHYSM'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO MELTING'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphysm
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
  ALLOCATE(grid%acphysm(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysm(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'acphysf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'acphysf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%acphysf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%acphysf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'acphysf'
  grid%tail_statevars%DataName = 'ACPHYSF'
  grid%tail_statevars%Description = 'ACCUMULATED LATENT HEATING DUE TO FREEZING'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%acphysf
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
  ALLOCATE(grid%acphysf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%acphysf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'preci3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'preci3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%preci3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%preci3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%preci3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'preci3d'
  grid%tail_statevars%DataName = 'PRECI3D'
  grid%tail_statevars%Description = 'Sedimentation Fluxes for cloud ice'
  grid%tail_statevars%Units = 'KG/M^2/S'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%preci3d
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
  ALLOCATE(grid%preci3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%preci3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'precs3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'precs3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%precs3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precs3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%precs3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'precs3d'
  grid%tail_statevars%DataName = 'PRECS3D'
  grid%tail_statevars%Description = 'Sedimentation Fluxes for snow'
  grid%tail_statevars%Units = 'KG/M^2/S'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%precs3d
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
  ALLOCATE(grid%precs3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precs3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'precg3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'precg3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%precg3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precg3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%precg3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'precg3d'
  grid%tail_statevars%DataName = 'PRECG3D'
  grid%tail_statevars%Description = 'Sedimentation Fluxes for graupel'
  grid%tail_statevars%Units = 'KG/M^2/S'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%precg3d
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
  ALLOCATE(grid%precg3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precg3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'prech3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'prech3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%prech3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%prech3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%prech3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'prech3d'
  grid%tail_statevars%DataName = 'PRECH3D'
  grid%tail_statevars%Description = 'Sedimentation Fluxes for hail'
  grid%tail_statevars%Units = 'KG/M^2/S'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%prech3d
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
  ALLOCATE(grid%prech3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%prech3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'precr3d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'precr3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%precr3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precr3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%precr3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'precr3d'
  grid%tail_statevars%DataName = 'PRECR3D'
  grid%tail_statevars%Description = 'Sedimentation Fluxes for rain'
  grid%tail_statevars%Units = 'KG/M^2/S'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%precr3d
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
  ALLOCATE(grid%precr3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%precr3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tlwdn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tlwdn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tlwdn(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tlwdn(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tlwdn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tlwdn'
  grid%tail_statevars%DataName = 'TLWDN'
  grid%tail_statevars%Description = 'TOA LW downwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tlwdn
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
  ALLOCATE(grid%tlwdn(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tlwdn(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tlwup').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tlwup: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tlwup(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tlwup(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tlwup=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tlwup'
  grid%tail_statevars%DataName = 'TLWUP'
  grid%tail_statevars%Description = 'TOA LW upwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tlwup
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
  ALLOCATE(grid%tlwup(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tlwup(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'slwdn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'slwdn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%slwdn(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%slwdn(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%slwdn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'slwdn'
  grid%tail_statevars%DataName = 'SLWDN'
  grid%tail_statevars%Description = 'Surface LW downwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%slwdn
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
  ALLOCATE(grid%slwdn(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%slwdn(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'slwup').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'slwup: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%slwup(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%slwup(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%slwup=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'slwup'
  grid%tail_statevars%DataName = 'SLWUP'
  grid%tail_statevars%Description = 'Surface LW upwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%slwup
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
  ALLOCATE(grid%slwup(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%slwup(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tswdn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tswdn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tswdn(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tswdn(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tswdn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tswdn'
  grid%tail_statevars%DataName = 'TSWDN'
  grid%tail_statevars%Description = 'TOA SW downwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tswdn
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
  ALLOCATE(grid%tswdn(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tswdn(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tswup').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tswup: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tswup(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tswup(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tswup=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tswup'
  grid%tail_statevars%DataName = 'TSWUP'
  grid%tail_statevars%Description = 'TOA SW upwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tswup
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
  ALLOCATE(grid%tswup(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tswup(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sswdn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sswdn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sswdn(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sswdn(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sswdn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sswdn'
  grid%tail_statevars%DataName = 'SSWDN'
  grid%tail_statevars%Description = 'Surface SW downwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sswdn
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
  ALLOCATE(grid%sswdn(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sswdn(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sswup').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sswup: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sswup(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sswup(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sswup=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sswup'
  grid%tail_statevars%DataName = 'SSWUP'
  grid%tail_statevars%Description = 'Surface SW upwelling flux'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sswup
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
  ALLOCATE(grid%sswup(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sswup(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cod2d_out').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cod2d_out: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cod2d_out(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cod2d_out(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cod2d_out=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cod2d_out'
  grid%tail_statevars%DataName = 'COD2D_OUT'
  grid%tail_statevars%Description = 'Column Cloud Optical Depth'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%cod2d_out
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
  ALLOCATE(grid%cod2d_out(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cod2d_out(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ctop2d_out').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ctop2d_out: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ctop2d_out(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ctop2d_out(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ctop2d_out=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ctop2d_out'
  grid%tail_statevars%DataName = 'CTOP2D_OUT'
  grid%tail_statevars%Description = 'Cloud-Top Pressure'
  grid%tail_statevars%Units = 'mb'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%ctop2d_out
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
  ALLOCATE(grid%ctop2d_out(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ctop2d_out(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rushten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rushten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rushten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rushten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rushten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rushten'
  grid%tail_statevars%DataName = 'RUSHTEN'
  grid%tail_statevars%Description = 'X WIND TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rushten
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
  ALLOCATE(grid%rushten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rushten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rvshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rvshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rvshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rvshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rvshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rvshten'
  grid%tail_statevars%DataName = 'RVSHTEN'
  grid%tail_statevars%Description = 'Y WIND TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rvshten
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
  ALLOCATE(grid%rvshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rvshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rthshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rthshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rthshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rthshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rthshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rthshten'
  grid%tail_statevars%DataName = 'RTHSHTEN'
  grid%tail_statevars%Description = 'THETA TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rthshten
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
  ALLOCATE(grid%rthshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rthshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqvshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqvshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqvshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqvshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqvshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqvshten'
  grid%tail_statevars%DataName = 'RQVSHTEN'
  grid%tail_statevars%Description = 'Q_V TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqvshten
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
  ALLOCATE(grid%rqvshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqvshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqrshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqrshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqrshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqrshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqrshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqrshten'
  grid%tail_statevars%DataName = 'RQRSHTEN'
  grid%tail_statevars%Description = 'Q_R TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqrshten
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
  ALLOCATE(grid%rqrshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqrshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqcshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqcshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqcshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqcshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqcshten'
  grid%tail_statevars%DataName = 'RQCSHTEN'
  grid%tail_statevars%Description = 'Q_C TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqcshten
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
  ALLOCATE(grid%rqcshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqsshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqsshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqsshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqsshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqsshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqsshten'
  grid%tail_statevars%DataName = 'RQSSHTEN'
  grid%tail_statevars%Description = 'Q_S TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqsshten
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
  ALLOCATE(grid%rqsshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqsshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqishten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqishten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqishten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqishten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqishten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqishten'
  grid%tail_statevars%DataName = 'RQISHTEN'
  grid%tail_statevars%Description = 'Q_I TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqishten
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
  ALLOCATE(grid%rqishten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqishten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqgshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqgshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqgshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqgshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqgshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqgshten'
  grid%tail_statevars%DataName = 'RQGSHTEN'
  grid%tail_statevars%Description = 'Q_G TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqgshten
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
  ALLOCATE(grid%rqgshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqgshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqcnshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqcnshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqcnshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcnshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqcnshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqcnshten'
  grid%tail_statevars%DataName = 'RQCNSHTEN'
  grid%tail_statevars%Description = 'Q_CN TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = '  kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqcnshten
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
  ALLOCATE(grid%rqcnshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcnshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqinshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqinshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqinshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqinshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqinshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqinshten'
  grid%tail_statevars%DataName = 'RQINSHTEN'
  grid%tail_statevars%Description = 'Q_IN TENDENCY DUE TO SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = '  kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqinshten
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
  ALLOCATE(grid%rqinshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqinshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rdcashten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rdcashten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rdcashten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdcashten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rdcashten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rdcashten'
  grid%tail_statevars%DataName = 'RDCASHTEN'
  grid%tail_statevars%Description = 'CLOUD FRACTION AREA TENDENCY DUE TO DENG SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'Pa s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rdcashten
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
  ALLOCATE(grid%rdcashten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rdcashten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqcdcshten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqcdcshten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqcdcshten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcdcshten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqcdcshten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqcdcshten'
  grid%tail_statevars%DataName = 'RQCDCSHTEN'
  grid%tail_statevars%Description = 'CLOUD LIQUID TENDENCY DUE TO DENG SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqcdcshten
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
  ALLOCATE(grid%rqcdcshten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcdcshten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldareaa').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldareaa: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldareaa(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldareaa(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldareaa=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldareaa'
  grid%tail_statevars%DataName = 'CLDAREAA'
  grid%tail_statevars%Description = 'CLOUD FRACTION FROM DENG SCHEME'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldareaa
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
  ALLOCATE(grid%cldareaa(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldareaa(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldareab').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldareab: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldareab(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldareab(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldareab=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldareab'
  grid%tail_statevars%DataName = 'CLDAREAB'
  grid%tail_statevars%Description = 'CLOUD FRACTION FROM DENG SCHEME'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldareab
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
  ALLOCATE(grid%cldareab(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldareab(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ca_rad').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ca_rad: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ca_rad(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ca_rad(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ca_rad=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ca_rad'
  grid%tail_statevars%DataName = 'CA_RAD'
  grid%tail_statevars%Description = 'CLOUD WATER CONTENT FROM DENG SCHEME FOR RADIATION'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ca_rad
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
  ALLOCATE(grid%ca_rad(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ca_rad(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cw_rad').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cw_rad: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cw_rad(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cw_rad(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cw_rad=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cw_rad'
  grid%tail_statevars%DataName = 'CW_RAD'
  grid%tail_statevars%Description = 'CLOUD WATER CONTENT FROM DENG SCHEME FOR RADIATION'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cw_rad
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
  ALLOCATE(grid%cw_rad(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cw_rad(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldliqa').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldliqa: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldliqa(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldliqa(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldliqa=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldliqa'
  grid%tail_statevars%DataName = 'CLDLIQA'
  grid%tail_statevars%Description = 'CLOUD WATER CONTENT FROM DENG SCHEME'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldliqa
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
  ALLOCATE(grid%cldliqa(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldliqa(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldliqb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldliqb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldliqb(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldliqb(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldliqb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldliqb'
  grid%tail_statevars%DataName = 'CLDLIQB'
  grid%tail_statevars%Description = 'CLOUD WATER CONTENT FROM DENG SCHEME'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldliqb
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
  ALLOCATE(grid%cldliqb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldliqb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'clddpthb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'clddpthb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%clddpthb(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%clddpthb(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%clddpthb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'clddpthb'
  grid%tail_statevars%DataName = 'CLDDPTHB'
  grid%tail_statevars%Description = 'CLOUD DEPTH FROM TAU-1'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%clddpthb
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
  ALLOCATE(grid%clddpthb(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%clddpthb(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldtopb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldtopb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldtopb(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldtopb(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldtopb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldtopb'
  grid%tail_statevars%DataName = 'CLDTOPB'
  grid%tail_statevars%Description = 'CLOUD TOP FROM TAU-1'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%cldtopb
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
  ALLOCATE(grid%cldtopb(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldtopb(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pblmax').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pblmax: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pblmax(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pblmax(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pblmax=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pblmax'
  grid%tail_statevars%DataName = 'PBLMAX'
  grid%tail_statevars%Description = 'MAXIMUM VALUE OF PBL DEPTH SINCE THE START OF THE MODEL RUN'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%pblmax
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
  ALLOCATE(grid%pblmax(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pblmax(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wub').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wub: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wub(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wub(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wub=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wub'
  grid%tail_statevars%DataName = 'WUB'
  grid%tail_statevars%Description = 'UPDRAFT VERTICAL VELOCITY'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%wub
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
  ALLOCATE(grid%wub(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wub(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainshvb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainshvb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainshvb(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainshvb(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainshvb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainshvb'
  grid%tail_statevars%DataName = 'RAINSHVB'
  grid%tail_statevars%Description = 'TIME-STEP SHCU PRECIPITATION FROM TAU-1'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainshvb
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
  ALLOCATE(grid%rainshvb(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainshvb(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'capesave').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'capesave: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%capesave(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%capesave(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%capesave=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'capesave'
  grid%tail_statevars%DataName = 'CAPESAVE'
  grid%tail_statevars%Description = 'CAPE FROM TAU-1'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%capesave
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
  ALLOCATE(grid%capesave(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%capesave(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'radsave').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'radsave: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%radsave(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%radsave(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%radsave=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'radsave'
  grid%tail_statevars%DataName = 'RADSAVE'
  grid%tail_statevars%Description = 'CLOUD RADIUS FROM TAU-1'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%radsave
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
  ALLOCATE(grid%radsave(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%radsave(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ainckfsa').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((100)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((100)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ainckfsa: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ainckfsa(sm31:em31,1:100,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ainckfsa(sm31:em31,1:100,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ainckfsa=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ainckfsa'
  grid%tail_statevars%DataName = 'AINCKFSA'
  grid%tail_statevars%Description = 'NUMBER OF CLOUDS FROM TAU-1'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ainckfsa
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = 100
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = 100
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 100
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'nsh'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%ainckfsa(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ainckfsa(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ltopb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ltopb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ltopb(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ltopb(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ltopb=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ltopb'
  grid%tail_statevars%DataName = 'LTOPB'
  grid%tail_statevars%Description = 'LEVEL OF UPDRAFT TOP FROM TAU-1'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%ltopb
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
  ALLOCATE(grid%ltopb(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ltopb(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'kdcldtop').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'kdcldtop: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%kdcldtop(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kdcldtop(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%kdcldtop=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'kdcldtop'
  grid%tail_statevars%DataName = 'KDCLDTOP'
  grid%tail_statevars%Description = 'LEVEL OF NBC TOP'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%kdcldtop
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
  ALLOCATE(grid%kdcldtop(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kdcldtop(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'kdcldbas').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'kdcldbas: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%kdcldbas(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kdcldbas(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%kdcldbas=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'kdcldbas'
  grid%tail_statevars%DataName = 'KDCLDBAS'
  grid%tail_statevars%Description = 'LEVEL OF NBC BASE'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%kdcldbas
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
  ALLOCATE(grid%kdcldbas(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kdcldbas(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'xtime1').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'xtime1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%xtime1(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xtime1(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%xtime1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'xtime1'
  grid%tail_statevars%DataName = 'XTIME1'
  grid%tail_statevars%Description = 'TIME COUNTER AFTER RAIN'
  grid%tail_statevars%Units = 'min.'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%xtime1
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
  ALLOCATE(grid%xtime1(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xtime1(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pblhavg').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pblhavg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pblhavg(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pblhavg(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pblhavg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pblhavg'
  grid%tail_statevars%DataName = 'PBLHAVG'
  grid%tail_statevars%Description = 'TIME AVERAGE OF PBLH'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%pblhavg
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
  ALLOCATE(grid%pblhavg(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pblhavg(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tkeavg').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tkeavg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tkeavg(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tkeavg(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tkeavg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tkeavg'
  grid%tail_statevars%DataName = 'TKEAVG'
  grid%tail_statevars%Description = 'TIME AVERAGE OF TKE'
  grid%tail_statevars%Units = 'm2 s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%tkeavg
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
  ALLOCATE(grid%tkeavg(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tkeavg(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wsubsid').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wsubsid: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wsubsid(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wsubsid(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wsubsid=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wsubsid'
  grid%tail_statevars%DataName = 'WSUBSID'
  grid%tail_statevars%Description = 'LARGE-SCALE SUBSIDENCE IN DENG SHCU SCHEME'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%wsubsid
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
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
  ALLOCATE(grid%wsubsid(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wsubsid(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rucuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rucuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rucuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rucuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rucuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rucuten'
  grid%tail_statevars%DataName = 'RUCUTEN'
  grid%tail_statevars%Description = 'X WIND TENDENCY DUE TO CUMULUS PARAMETERIZATION'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rucuten
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
  ALLOCATE(grid%rucuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rucuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rvcuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rvcuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rvcuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rvcuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rvcuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rvcuten'
  grid%tail_statevars%DataName = 'RVCUTEN'
  grid%tail_statevars%Description = 'Y WIND TENDENCY DUE TO CUMULUS PARAMETERIZATION'
  grid%tail_statevars%Units = 'm s-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rvcuten
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
  ALLOCATE(grid%rvcuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rvcuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rthcuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rthcuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rthcuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rthcuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rthcuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rthcuten'
  grid%tail_statevars%DataName = 'RTHCUTEN'
  grid%tail_statevars%Description = 'THETA TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rthcuten
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
  ALLOCATE(grid%rthcuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rthcuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqvcuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqvcuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqvcuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqvcuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqvcuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqvcuten'
  grid%tail_statevars%DataName = 'RQVCUTEN'
  grid%tail_statevars%Description = 'Q_V TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqvcuten
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
  ALLOCATE(grid%rqvcuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqvcuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqrcuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqrcuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqrcuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqrcuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqrcuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqrcuten'
  grid%tail_statevars%DataName = 'RQRCUTEN'
  grid%tail_statevars%Description = 'Q_R TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqrcuten
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
  ALLOCATE(grid%rqrcuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqrcuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqccuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqccuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqccuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqccuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqccuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqccuten'
  grid%tail_statevars%DataName = 'RQCCUTEN'
  grid%tail_statevars%Description = 'Q_C TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqccuten
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
  ALLOCATE(grid%rqccuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqccuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqscuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqscuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqscuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqscuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqscuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqscuten'
  grid%tail_statevars%DataName = 'RQSCUTEN'
  grid%tail_statevars%Description = 'Q_S TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqscuten
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
  ALLOCATE(grid%rqscuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqscuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqicuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqicuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqicuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqicuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqicuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqicuten'
  grid%tail_statevars%DataName = 'RQICUTEN'
  grid%tail_statevars%Description = 'Q_I TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqicuten
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
  ALLOCATE(grid%rqicuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqicuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqcncuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqcncuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqcncuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcncuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqcncuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqcncuten'
  grid%tail_statevars%DataName = 'RQCNCUTEN'
  grid%tail_statevars%Description = 'Q_CN TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = '  kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqcncuten
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
  ALLOCATE(grid%rqcncuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqcncuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rqincuten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rqincuten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rqincuten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqincuten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rqincuten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rqincuten'
  grid%tail_statevars%DataName = 'RQINCUTEN'
  grid%tail_statevars%Description = 'Q_IN TENDENCY DUE TO CUMULUS SCHEME'
  grid%tail_statevars%Units = '  kg-1 s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rqincuten
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
  ALLOCATE(grid%rqincuten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rqincuten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w0avg').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w0avg: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w0avg(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w0avg(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w0avg=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w0avg'
  grid%tail_statevars%DataName = 'W0AVG'
  grid%tail_statevars%Description = 'AVERAGE VERTICAL VELOCITY FOR KF CUMULUS SCHEME'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w0avg
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
  ALLOCATE(grid%w0avg(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w0avg(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qcconv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qcconv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qcconv(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qcconv(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qcconv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qcconv'
  grid%tail_statevars%DataName = 'QCCONV'
  grid%tail_statevars%Description = 'CLOUD MIXING RATIO FOR BMJ CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qcconv
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
  ALLOCATE(grid%qcconv(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qcconv(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qiconv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qiconv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qiconv(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qiconv(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qiconv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qiconv'
  grid%tail_statevars%DataName = 'QICONV'
  grid%tail_statevars%Description = 'ICE MIXING RATIO FOR BMJ CUMULUS SCHEME'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qiconv
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
  ALLOCATE(grid%qiconv(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qiconv(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainc'
  grid%tail_statevars%DataName = 'RAINC'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainc
  grid%tail_statevars%streams(1) = 3 ! 00000003 
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
  ALLOCATE(grid%rainc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainsh'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainsh: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainsh(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainsh(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainsh=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainsh'
  grid%tail_statevars%DataName = 'RAINSH'
  grid%tail_statevars%Description = 'ACCUMULATED SHALLOW CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainsh
  grid%tail_statevars%streams(1) = 3 ! 00000003 
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
  ALLOCATE(grid%rainsh(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainsh(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainnc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainnc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainnc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainnc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainnc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainnc'
  grid%tail_statevars%DataName = 'RAINNC'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL GRID SCALE PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainnc
  grid%tail_statevars%streams(1) = 3 ! 00000003 
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
  ALLOCATE(grid%rainnc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainnc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_rainc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_rainc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_rainc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_rainc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_rainc=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_rainc'
  grid%tail_statevars%DataName = 'I_RAINC'
  grid%tail_statevars%Description = 'BUCKET FOR RAINC'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%i_rainc
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
  ALLOCATE(grid%i_rainc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_rainc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_rainnc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_rainnc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_rainnc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_rainnc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_rainnc=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_rainnc'
  grid%tail_statevars%DataName = 'I_RAINNC'
  grid%tail_statevars%Description = 'BUCKET FOR RAINNC'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%i_rainnc
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
  ALLOCATE(grid%i_rainnc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_rainnc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pratec').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pratec: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pratec(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pratec(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pratec=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pratec'
  grid%tail_statevars%DataName = 'PRATEC'
  grid%tail_statevars%Description = 'PRECIP RATE FROM CUMULUS SCHEME'
  grid%tail_statevars%Units = 'mm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%pratec
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
  ALLOCATE(grid%pratec(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pratec(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pratesh').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pratesh: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pratesh(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pratesh(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pratesh=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pratesh'
  grid%tail_statevars%DataName = 'PRATESH'
  grid%tail_statevars%Description = 'PRECIP RATE FROM SHALLOW CUMULUS SCHEME'
  grid%tail_statevars%Units = 'mm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%pratesh
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
  ALLOCATE(grid%pratesh(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pratesh(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'raincv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'raincv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%raincv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%raincv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'raincv'
  grid%tail_statevars%DataName = 'RAINCV'
  grid%tail_statevars%Description = 'TIME-STEP CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%raincv
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
  ALLOCATE(grid%raincv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainshv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainshv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainshv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainshv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainshv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainshv'
  grid%tail_statevars%DataName = 'RAINSHV'
  grid%tail_statevars%Description = 'TIME-STEP SHALLOW CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainshv
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
  ALLOCATE(grid%rainshv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainshv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainncv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainncv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainncv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainncv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainncv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainncv'
  grid%tail_statevars%DataName = 'RAINNCV'
  grid%tail_statevars%Description = 'TIME-STEP NONCONVECTIVE PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainncv
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
  ALLOCATE(grid%rainncv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainncv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rainbl').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rainbl: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rainbl(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainbl(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rainbl=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rainbl'
  grid%tail_statevars%DataName = 'RAINBL'
  grid%tail_statevars%Description = 'PBL TIME-STEP TOTAL PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rainbl
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
  ALLOCATE(grid%rainbl(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rainbl(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snownc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snownc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snownc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snownc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snownc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snownc'
  grid%tail_statevars%DataName = 'SNOWNC'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL GRID SCALE SNOW AND ICE'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%snownc
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
  ALLOCATE(grid%snownc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snownc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'graupelnc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'graupelnc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%graupelnc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%graupelnc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%graupelnc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'graupelnc'
  grid%tail_statevars%DataName = 'GRAUPELNC'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL GRID SCALE GRAUPEL'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%graupelnc
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
  ALLOCATE(grid%graupelnc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%graupelnc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'hailnc'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'hailnc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%hailnc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hailnc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%hailnc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'hailnc'
  grid%tail_statevars%DataName = 'HAILNC'
  grid%tail_statevars%Description = 'ACCUMULATED TOTAL GRID SCALE HAIL'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%hailnc
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
  ALLOCATE(grid%hailnc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hailnc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'snowncv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'snowncv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%snowncv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowncv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%snowncv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'snowncv'
  grid%tail_statevars%DataName = 'SNOWNCV'
  grid%tail_statevars%Description = 'TIME-STEP NONCONVECTIVE SNOW AND ICE'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%snowncv
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
  ALLOCATE(grid%snowncv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%snowncv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'graupelncv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'graupelncv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%graupelncv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%graupelncv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%graupelncv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'graupelncv'
  grid%tail_statevars%DataName = 'GRAUPELNCV'
  grid%tail_statevars%Description = 'TIME-STEP NONCONVECTIVE GRAUPEL'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%graupelncv
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
  ALLOCATE(grid%graupelncv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%graupelncv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'hailncv').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'hailncv: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%hailncv(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hailncv(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%hailncv=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'hailncv'
  grid%tail_statevars%DataName = 'HAILNCV'
  grid%tail_statevars%Description = 'TIME-STEP NONCONVECTIVE HAIL'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%hailncv
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
  ALLOCATE(grid%hailncv(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hailncv(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'refl_10cm'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'refl_10cm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%refl_10cm(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%refl_10cm(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%refl_10cm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'refl_10cm'
  grid%tail_statevars%DataName = 'REFL_10CM'
  grid%tail_statevars%Description = 'Radar reflectivity (lamda = 10 cm)'
  grid%tail_statevars%Units = 'dBZ'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%refl_10cm
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%refl_10cm(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%refl_10cm(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mskf_refl_10cm'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mskf_refl_10cm: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mskf_refl_10cm(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mskf_refl_10cm(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mskf_refl_10cm=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mskf_refl_10cm'
  grid%tail_statevars%DataName = 'MSKF_REFL_10CM'
  grid%tail_statevars%Description = 'Full Radar reflectivity (lamda = 10 cm)'
  grid%tail_statevars%Units = 'dBZ'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%mskf_refl_10cm
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%mskf_refl_10cm(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mskf_refl_10cm(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'th_old'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'th_old: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%th_old(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_old(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%th_old=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'th_old'
  grid%tail_statevars%DataName = 'TH_OLD'
  grid%tail_statevars%Description = 'Old Value of Th'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%th_old
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
  ALLOCATE(grid%th_old(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th_old(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qv_old'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qv_old: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qv_old(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_old(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qv_old=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qv_old'
  grid%tail_statevars%DataName = 'QV_OLD'
  grid%tail_statevars%Description = 'Old Value of qv'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qv_old
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
  ALLOCATE(grid%qv_old(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qv_old(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vmi3d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vmi3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vmi3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vmi3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vmi3d'
  grid%tail_statevars%DataName = 'V_ICE'
  grid%tail_statevars%Description = 'Mass-weighted ice fallspeed cat 1'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vmi3d
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%vmi3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'di3d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'di3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%di3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%di3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'di3d'
  grid%tail_statevars%DataName = 'D_ICE'
  grid%tail_statevars%Description = 'Mass-weighted mean ice size cat 1'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%di3d
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%di3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rhopo3d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rhopo3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rhopo3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rhopo3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rhopo3d'
  grid%tail_statevars%DataName = 'RHO_ICE'
  grid%tail_statevars%Description = 'Mass-weighted mean ice density cat 1'
  grid%tail_statevars%Units = 'kg m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rhopo3d
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%rhopo3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'phii3d'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'phii3d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%phii3d(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%phii3d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'phii3d'
  grid%tail_statevars%DataName = 'PHI_ICE'
  grid%tail_statevars%Description = 'Number-weighted mean ice aspect ratio cat 1'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%phii3d
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%phii3d(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vmi3d_2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vmi3d_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vmi3d_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vmi3d_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vmi3d_2'
  grid%tail_statevars%DataName = 'V_ICE2'
  grid%tail_statevars%Description = 'Mass-weighted ice fallspeed cat 2'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vmi3d_2
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%vmi3d_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'di3d_2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'di3d_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%di3d_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%di3d_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'di3d_2'
  grid%tail_statevars%DataName = 'D_ICE2'
  grid%tail_statevars%Description = 'Mass-weighted mean ice size cat 2'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%di3d_2
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%di3d_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rhopo3d_2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rhopo3d_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rhopo3d_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rhopo3d_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rhopo3d_2'
  grid%tail_statevars%DataName = 'RHO_ICE2'
  grid%tail_statevars%Description = 'Mass-weighted mean ice density cat 2'
  grid%tail_statevars%Units = 'kg m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rhopo3d_2
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%rhopo3d_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'phii3d_2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'phii3d_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%phii3d_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%phii3d_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'phii3d_2'
  grid%tail_statevars%DataName = 'PHI_ICE2'
  grid%tail_statevars%Description = 'Number-weighted mean ice aspect ratio cat 2'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%phii3d_2
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%phii3d_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vmi3d_3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vmi3d_3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vmi3d_3(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d_3(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vmi3d_3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vmi3d_3'
  grid%tail_statevars%DataName = 'V_ICE3'
  grid%tail_statevars%Description = 'Mass-weighted ice fallspeed cat 3'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vmi3d_3
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%vmi3d_3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmi3d_3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'di3d_3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'di3d_3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%di3d_3(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d_3(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%di3d_3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'di3d_3'
  grid%tail_statevars%DataName = 'D_ICE3'
  grid%tail_statevars%Description = 'Mass-weighted mean ice size cat 3'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%di3d_3
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%di3d_3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%di3d_3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rhopo3d_3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rhopo3d_3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rhopo3d_3(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d_3(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rhopo3d_3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rhopo3d_3'
  grid%tail_statevars%DataName = 'RHO_ICE3'
  grid%tail_statevars%Description = 'Mass-weighted mean ice density cat 3'
  grid%tail_statevars%Units = 'kg m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rhopo3d_3
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%rhopo3d_3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rhopo3d_3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'phii3d_3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'phii3d_3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%phii3d_3(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d_3(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%phii3d_3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'phii3d_3'
  grid%tail_statevars%DataName = 'PHI_ICE3'
  grid%tail_statevars%Description = 'Number-weighted mean ice aspect ratio cat 3'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%phii3d_3
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%phii3d_3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%phii3d_3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'itype'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'itype: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%itype(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%itype=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'itype'
  grid%tail_statevars%DataName = 'ICE_TYPE'
  grid%tail_statevars%Description = 'Diagnostic ice type cat 1 ISHMAEL microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%itype
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%itype(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'itype_2'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'itype_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%itype_2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype_2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%itype_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'itype_2'
  grid%tail_statevars%DataName = 'ICE_TYPE2'
  grid%tail_statevars%Description = 'Diagnostic ice type cat 2 ISHMAEL microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%itype_2
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%itype_2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype_2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'itype_3'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'itype_3: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%itype_3(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype_3(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%itype_3=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'itype_3'
  grid%tail_statevars%DataName = 'ICE_TYPE3'
  grid%tail_statevars%Description = 'Diagnostic ice type cat 3 ISHMAEL microphysics'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%itype_3
  grid%tail_statevars%streams(1) = 1 ! 00000001 
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
  ALLOCATE(grid%itype_3(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%itype_3(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'nca').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'nca: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%nca(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nca(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%nca=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'nca'
  grid%tail_statevars%DataName = 'NCA'
  grid%tail_statevars%Description = 'COUNTER OF THE CLOUD RELAXATION TIME IN KF CUMULUS SCHEME'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%nca
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
  ALLOCATE(grid%nca(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%nca(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lowlyr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lowlyr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lowlyr(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lowlyr(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lowlyr=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lowlyr'
  grid%tail_statevars%DataName = 'LOWLYR'
  grid%tail_statevars%Description = 'INDEX OF LOWEST MODEL LAYER ABOVE THE GROUND IN BMJ SCHEME'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%lowlyr
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
  ALLOCATE(grid%lowlyr(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lowlyr(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'mass_flux').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'mass_flux: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%mass_flux(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mass_flux(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%mass_flux=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'mass_flux'
  grid%tail_statevars%DataName = 'MASS_FLUX'
  grid%tail_statevars%Description = 'DOWNDRAFT MASS FLUX FOR IN GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'mb hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%mass_flux
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
  ALLOCATE(grid%mass_flux(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%mass_flux(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_dp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_dp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_dp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_dp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_dp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_dp'
  grid%tail_statevars%DataName = 'CLDFRA_DP'
  grid%tail_statevars%Description = 'DEEP CONVECTIVE CLOUD FRACTION FROM KF'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_dp
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
  ALLOCATE(grid%cldfra_dp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_dp(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfra_sh').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfra_sh: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfra_sh(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_sh(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfra_sh=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfra_sh'
  grid%tail_statevars%DataName = 'CLDFRA_SH'
  grid%tail_statevars%Description = 'SHALLOW CONVECTIVE CLOUD FRACTION FROM KF'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cldfra_sh
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
  ALLOCATE(grid%cldfra_sh(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfra_sh(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'udr_kf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'udr_kf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%udr_kf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%udr_kf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%udr_kf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'udr_kf'
  grid%tail_statevars%DataName = 'UDR_KF'
  grid%tail_statevars%Description = 'UPDRAFT DETRAINMENT RATE FROM KF'
  grid%tail_statevars%Units = 'kg s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%udr_kf
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
  ALLOCATE(grid%udr_kf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%udr_kf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ddr_kf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ddr_kf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ddr_kf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ddr_kf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ddr_kf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ddr_kf'
  grid%tail_statevars%DataName = 'DDR_KF'
  grid%tail_statevars%Description = 'DOWNDRAFT DETRAINMENT RATE FROM KF'
  grid%tail_statevars%Units = 'kg s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%ddr_kf
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
  ALLOCATE(grid%ddr_kf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ddr_kf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'uer_kf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'uer_kf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%uer_kf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%uer_kf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%uer_kf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'uer_kf'
  grid%tail_statevars%DataName = 'UER_KF'
  grid%tail_statevars%Description = 'UPDRAFT ENTRAINMENT RATE FROM KF'
  grid%tail_statevars%Units = 'kg s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%uer_kf
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
  ALLOCATE(grid%uer_kf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%uer_kf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'der_kf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'der_kf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%der_kf(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%der_kf(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%der_kf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'der_kf'
  grid%tail_statevars%DataName = 'DER_KF'
  grid%tail_statevars%Description = 'DOWNDRAFT ENTRAINMENT RATE FROM KF'
  grid%tail_statevars%Units = 'kg s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%der_kf
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
  ALLOCATE(grid%der_kf(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%der_kf(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'timec_kf').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'timec_kf: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%timec_kf(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%timec_kf(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%timec_kf=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'timec_kf'
  grid%tail_statevars%DataName = 'TIMEC_KF'
  grid%tail_statevars%Description = 'CONVECTIVE TIMESCALE FROM MSKF'
  grid%tail_statevars%Units = 's'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%timec_kf
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
  ALLOCATE(grid%timec_kf(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%timec_kf(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_gr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_gr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_gr(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_gr(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_gr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_gr'
  grid%tail_statevars%DataName = 'APR_GR'
  grid%tail_statevars%Description = 'PRECIP FROM CLOSURE OLD_GRELL'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_gr
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
  ALLOCATE(grid%apr_gr(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_gr(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_w').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_w: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_w(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_w(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_w=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_w'
  grid%tail_statevars%DataName = 'APR_W'
  grid%tail_statevars%Description = 'PRECIP FROM CLOSURE W'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_w
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
  ALLOCATE(grid%apr_w(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_w(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_mc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_mc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_mc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_mc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_mc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_mc'
  grid%tail_statevars%DataName = 'APR_MC'
  grid%tail_statevars%Description = 'PRECIP FROM CLOSURE KRISH MV'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_mc
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
  ALLOCATE(grid%apr_mc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_mc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_st').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_st: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_st(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_st(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_st=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_st'
  grid%tail_statevars%DataName = 'APR_ST'
  grid%tail_statevars%Description = 'PRECIP FROM CLOSURE STABILITY'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_st
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
  ALLOCATE(grid%apr_st(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_st(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_as').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_as: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_as(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_as(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_as=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_as'
  grid%tail_statevars%DataName = 'APR_AS'
  grid%tail_statevars%Description = 'PRECIP FROM CLOSURE AS-TYPE'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_as
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
  ALLOCATE(grid%apr_as(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_as(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_capma').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_capma: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_capma(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capma(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_capma=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_capma'
  grid%tail_statevars%DataName = 'APR_CAPMA'
  grid%tail_statevars%Description = 'PRECIP FROM MAX CAP'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_capma
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
  ALLOCATE(grid%apr_capma(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capma(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_capme').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_capme: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_capme(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capme(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_capme=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_capme'
  grid%tail_statevars%DataName = 'APR_CAPME'
  grid%tail_statevars%Description = 'PRECIP FROM MEAN CAP'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_capme
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
  ALLOCATE(grid%apr_capme(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capme(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'apr_capmi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'apr_capmi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%apr_capmi(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capmi(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%apr_capmi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'apr_capmi'
  grid%tail_statevars%DataName = 'APR_CAPMI'
  grid%tail_statevars%Description = 'PRECIP FROM MIN CAP'
  grid%tail_statevars%Units = 'mm hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%apr_capmi
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
  ALLOCATE(grid%apr_capmi(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%apr_capmi(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'edt_out').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'edt_out: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%edt_out(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%edt_out(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%edt_out=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'edt_out'
  grid%tail_statevars%DataName = 'EDT_OUT'
  grid%tail_statevars%Description = 'EDT FROM GD SCHEME'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%edt_out
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
  ALLOCATE(grid%edt_out(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%edt_out(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'xmb_shallow').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'xmb_shallow: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%xmb_shallow(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xmb_shallow(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%xmb_shallow=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'xmb_shallow'
  grid%tail_statevars%DataName = 'XMB_SHALLOW'
  grid%tail_statevars%Description = 'MASSFLUX FROM SHALLOW CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%xmb_shallow
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
  ALLOCATE(grid%xmb_shallow(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xmb_shallow(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'k22_shallow').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'k22_shallow: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%k22_shallow(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%k22_shallow(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%k22_shallow=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'k22_shallow'
  grid%tail_statevars%DataName = 'K22_SHALLOW'
  grid%tail_statevars%Description = 'K22 LEVEL FROM SHALLOW CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%k22_shallow
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
  ALLOCATE(grid%k22_shallow(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%k22_shallow(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'kbcon_shallow').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'kbcon_shallow: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%kbcon_shallow(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kbcon_shallow(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%kbcon_shallow=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'kbcon_shallow'
  grid%tail_statevars%DataName = 'KBCON_SHALLOW'
  grid%tail_statevars%Description = 'KBCON LEVEL FROM SHALLOW CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%kbcon_shallow
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
  ALLOCATE(grid%kbcon_shallow(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kbcon_shallow(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ktop_shallow').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ktop_shallow: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ktop_shallow(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ktop_shallow(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ktop_shallow=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ktop_shallow'
  grid%tail_statevars%DataName = 'KTOP_SHALLOW'
  grid%tail_statevars%Description = 'KTOP LEVEL FROM SHALLOW CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%ktop_shallow
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
  ALLOCATE(grid%ktop_shallow(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ktop_shallow(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'k22_deep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'k22_deep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%k22_deep(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%k22_deep(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%k22_deep=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'k22_deep'
  grid%tail_statevars%DataName = 'K22_DEEP'
  grid%tail_statevars%Description = 'K22 LEVEL FROM DEEPCONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%k22_deep
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
  ALLOCATE(grid%k22_deep(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%k22_deep(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'kbcon_deep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'kbcon_deep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%kbcon_deep(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kbcon_deep(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%kbcon_deep=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'kbcon_deep'
  grid%tail_statevars%DataName = 'KBCON_DEEP'
  grid%tail_statevars%Description = 'KBCON LEVEL FROM DEEP CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%kbcon_deep
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
  ALLOCATE(grid%kbcon_deep(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%kbcon_deep(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'ktop_deep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'ktop_deep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%ktop_deep(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ktop_deep(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%ktop_deep=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'ktop_deep'
  grid%tail_statevars%DataName = 'KTOP_DEEP'
  grid%tail_statevars%Description = 'KTOP LEVEL FROM DEEP CONVECTION (G3 and GF only)'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%ktop_deep
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
  ALLOCATE(grid%ktop_deep(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%ktop_deep(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'xf_ens').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))*(((model_config_rec%ensdim)-(1)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))*(((model_config_rec%ensdim)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'xf_ens: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%xf_ens(sm31:em31,sm33:em33,1:model_config_rec%ensdim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xf_ens(sm31:em31,sm33:em33,1:model_config_rec%ensdim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%xf_ens=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'xf_ens'
  grid%tail_statevars%DataName = 'XF_ENS'
  grid%tail_statevars%Description = 'MASS FLUX PDF IN GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'mb hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XYZ'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%xf_ens
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = config_flags%ensdim
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = config_flags%ensdim
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = config_flags%ensdim
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = 'ensemble_stag'
  ENDIF
ELSE
  ALLOCATE(grid%xf_ens(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%xf_ens(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pr_ens').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))*(((model_config_rec%ensdim)-(1)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))*(((model_config_rec%ensdim)-(1)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pr_ens: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pr_ens(sm31:em31,sm33:em33,1:model_config_rec%ensdim),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pr_ens(sm31:em31,sm33:em33,1:model_config_rec%ensdim). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pr_ens=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pr_ens'
  grid%tail_statevars%DataName = 'PR_ENS'
  grid%tail_statevars%Description = 'PRECIP RATE PDF IN GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'mb hour-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XYZ'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pr_ens
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = jds
  grid%tail_statevars%ed2 = (jde-1)
  grid%tail_statevars%sd3 = 1
  grid%tail_statevars%ed3 = config_flags%ensdim
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = jms
  grid%tail_statevars%em2 = jme
  grid%tail_statevars%sm3 = 1
  grid%tail_statevars%em3 = config_flags%ensdim
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = jps
  grid%tail_statevars%ep2 = MIN( (jde-1), jpe )
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = config_flags%ensdim
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'south_north'
  grid%tail_statevars%dimname3 = 'ensemble_stag'
  ENDIF
ELSE
  ALLOCATE(grid%pr_ens(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pr_ens(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cugd_tten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cugd_tten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cugd_tten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_tten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cugd_tten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cugd_tten'
  grid%tail_statevars%DataName = 'CUGD_TTEN'
  grid%tail_statevars%Description = 'INITIAL TTENDENCY OUT OFF GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cugd_tten
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
  ALLOCATE(grid%cugd_tten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_tten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cugd_qvten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cugd_qvten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cugd_qvten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qvten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cugd_qvten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cugd_qvten'
  grid%tail_statevars%DataName = 'CUGD_QVTEN'
  grid%tail_statevars%Description = 'INITIAL QTENDENCY OUT OFF GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cugd_qvten
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
  ALLOCATE(grid%cugd_qvten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qvten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cugd_ttens').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cugd_ttens: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cugd_ttens(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_ttens(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cugd_ttens=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cugd_ttens'
  grid%tail_statevars%DataName = 'CUGD_TTENS'
  grid%tail_statevars%Description = 'INITIAL SUBSIDENCE TTENDENCY OUT OFF GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cugd_ttens
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
  ALLOCATE(grid%cugd_ttens(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_ttens(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cugd_qvtens').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cugd_qvtens: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cugd_qvtens(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qvtens(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cugd_qvtens=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cugd_qvtens'
  grid%tail_statevars%DataName = 'CUGD_QVTENS'
  grid%tail_statevars%Description = 'INITIAL SUBSIDNCE QTENDENCY OUT OFF GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cugd_qvtens
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
  ALLOCATE(grid%cugd_qvtens(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qvtens(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cugd_qcten').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cugd_qcten: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cugd_qcten(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qcten(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cugd_qcten=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cugd_qcten'
  grid%tail_statevars%DataName = 'CUGD_QCTEN'
  grid%tail_statevars%Description = 'INITIAL TEMPERATURE TENDENCY OUT OFF GRELL CUMULUS SCHEME'
  grid%tail_statevars%Units = 'K s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%cugd_qcten
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
  ALLOCATE(grid%cugd_qcten(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cugd_qcten(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gd_cloud').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gd_cloud: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gd_cloud(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gd_cloud=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gd_cloud'
  grid%tail_statevars%DataName = 'GD_CLOUD'
  grid%tail_statevars%Description = 'CLOUD WATER/ICE MIXING RAIO IN GD CLOUD'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%gd_cloud
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
  ALLOCATE(grid%gd_cloud(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gd_cloud2').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gd_cloud2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gd_cloud2(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud2(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gd_cloud2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gd_cloud2'
  grid%tail_statevars%DataName = 'GD_CLOUD2'
  grid%tail_statevars%Description = 'TEST for GD CLOUD'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%gd_cloud2
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
  ALLOCATE(grid%gd_cloud2(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud2(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gd_cldfr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gd_cldfr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gd_cldfr(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cldfr(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gd_cldfr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gd_cldfr'
  grid%tail_statevars%DataName = 'GD_CLDFR'
  grid%tail_statevars%Description = 'GD CLOUD Fraction'
  grid%tail_statevars%Units = ' ? '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%gd_cldfr
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
  ALLOCATE(grid%gd_cldfr(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cldfr(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'raincv_a').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'raincv_a: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%raincv_a(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv_a(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%raincv_a=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'raincv_a'
  grid%tail_statevars%DataName = 'RAINCV_A'
  grid%tail_statevars%Description = 'taveragd TIME-STEP CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%raincv_a
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
  ALLOCATE(grid%raincv_a(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv_a(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'raincv_b').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'raincv_b: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%raincv_b(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv_b(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%raincv_b=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'raincv_b'
  grid%tail_statevars%DataName = 'RAINCV_B'
  grid%tail_statevars%Description = 'taveragd TIME-STEP CUMULUS PRECIPITATION'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%raincv_b
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
  ALLOCATE(grid%raincv_b(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%raincv_b(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gd_cloud_a').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gd_cloud_a: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gd_cloud_a(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud_a(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gd_cloud_a=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gd_cloud_a'
  grid%tail_statevars%DataName = 'GD_CLOUD_A'
  grid%tail_statevars%Description = 'taveragd CLOUD WATER MIXING RAIO IN GD CLOUD'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%gd_cloud_a
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
  ALLOCATE(grid%gd_cloud_a(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud_a(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'gd_cloud2_a').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'gd_cloud2_a: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%gd_cloud2_a(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud2_a(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%gd_cloud2_a=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'gd_cloud2_a'
  grid%tail_statevars%DataName = 'GD_CLOUD2_A'
  grid%tail_statevars%Description = 'taveragd cloud ice mix ratio in GD'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%gd_cloud2_a
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
  ALLOCATE(grid%gd_cloud2_a(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%gd_cloud2_a(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qc_cu').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qc_cu: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qc_cu(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qc_cu(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qc_cu=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qc_cu'
  grid%tail_statevars%DataName = 'QC_CU'
  grid%tail_statevars%Description = 'CLOUD WATER MIXING RATIO FROM A CU SCHEME'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qc_cu
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
  ALLOCATE(grid%qc_cu(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qc_cu(1,1,1).  ')
  endif
ENDIF
END SUBROUTINE allocs_6
