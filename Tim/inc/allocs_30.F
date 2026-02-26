!STARTOFREGISTRYGENERATEDINCLUDE 'inc/allocs_30.F'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
SUBROUTINE allocs_30( grid,   id, setinitval_in ,  tl_in , inter_domain_in , okay_to_alloc_in, num_bytes_allocated ,  &
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
   grid%tail_statevars%VarName = 'nsteps_diurn'
   grid%tail_statevars%DataName = 'NSTEP_D'
   grid%tail_statevars%Description = 'NUMBER OF DIURNAL STEPS ACCUMULATED'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%nsteps_diurn
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%nsteps_diurn=0
IF(okay_to_alloc.AND.in_use_for_config(id,'psfc_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'psfc_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%psfc_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%psfc_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%psfc_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'psfc_dtmp'
  grid%tail_statevars%DataName = 'PSFC_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE SURFACE PRESSURE'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%psfc_dtmp
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
  ALLOCATE(grid%psfc_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%psfc_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tsk_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tsk_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tsk_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tsk_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tsk_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tsk_dtmp'
  grid%tail_statevars%DataName = 'TSK_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE SURFACE SKIN TEMPERATURE'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tsk_dtmp
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
  ALLOCATE(grid%tsk_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tsk_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'t2_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 't2_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%t2_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%t2_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 't2_dtmp'
  grid%tail_statevars%DataName = 'T2_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE TEMPERATURE AT 2M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%t2_dtmp
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
  ALLOCATE(grid%t2_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%t2_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'th2_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'th2_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%th2_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th2_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%th2_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'th2_dtmp'
  grid%tail_statevars%DataName = 'TH2_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE POTENTIAL TEMPERATURE AT 2M'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%th2_dtmp
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
  ALLOCATE(grid%th2_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%th2_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'q2_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'q2_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%q2_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q2_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%q2_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'q2_dtmp'
  grid%tail_statevars%DataName = 'Q2_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP WATER VAPOR MIXING RATIO AT 2M'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%q2_dtmp
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
  ALLOCATE(grid%q2_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%q2_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'u10_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'u10_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%u10_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u10_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%u10_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'u10_dtmp'
  grid%tail_statevars%DataName = 'U10_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP U-COMPONENT OF WIND AT 10M'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%u10_dtmp
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
  ALLOCATE(grid%u10_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%u10_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'v10_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'v10_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%v10_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v10_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%v10_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'v10_dtmp'
  grid%tail_statevars%DataName = 'V10_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP V-COMPONENT OF WIND AT 10M'
  grid%tail_statevars%Units = 'm s-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%v10_dtmp
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
  ALLOCATE(grid%v10_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%v10_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'hfx_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'hfx_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%hfx_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hfx_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%hfx_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'hfx_dtmp'
  grid%tail_statevars%DataName = 'HFX_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE SENSIBLE HEAT FLUX AT THE SURFACE'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%hfx_dtmp
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
  ALLOCATE(grid%hfx_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%hfx_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lh_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lh_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lh_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lh_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lh_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lh_dtmp'
  grid%tail_statevars%DataName = 'LH_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE LATENT HEAT FLUX AT THE SURFACE'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lh_dtmp
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
  ALLOCATE(grid%lh_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lh_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'swdnb_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'swdnb_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%swdnb_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swdnb_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%swdnb_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'swdnb_dtmp'
  grid%tail_statevars%DataName = 'SWDNB_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE DOWNWARD SHORT WAVE FLUX AT GROUND SURFACE'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%swdnb_dtmp
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
  ALLOCATE(grid%swdnb_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swdnb_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'glw_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'glw_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%glw_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%glw_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%glw_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'glw_dtmp'
  grid%tail_statevars%DataName = 'GLW_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE DOWNWARD LONG WAVE FLUX AT GROUND SURFACE'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%glw_dtmp
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
  ALLOCATE(grid%glw_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%glw_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwupb_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwupb_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwupb_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwupb_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwupb_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwupb_dtmp'
  grid%tail_statevars%DataName = 'LWUPB_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE UPWELLING LONGWAVE FLUX AT BOTTOM'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwupb_dtmp
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
  ALLOCATE(grid%lwupb_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwupb_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'swupb_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'swupb_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%swupb_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swupb_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%swupb_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'swupb_dtmp'
  grid%tail_statevars%DataName = 'SWUPB_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE UPWELLING SHORTWAVE FLUX AT BOTTOM'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%swupb_dtmp
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
  ALLOCATE(grid%swupb_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swupb_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'swupt_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'swupt_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%swupt_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swupt_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%swupt_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'swupt_dtmp'
  grid%tail_statevars%DataName = 'SWUPT_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE UPWELLING SHORTWAVE FLUX AT TOP'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%swupt_dtmp
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
  ALLOCATE(grid%swupt_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swupt_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'swdnt_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'swdnt_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%swdnt_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swdnt_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%swdnt_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'swdnt_dtmp'
  grid%tail_statevars%DataName = 'SWDNT_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE DOWNWELLING SHORTWAVE FLUX AT TOP'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%swdnt_dtmp
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
  ALLOCATE(grid%swdnt_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swdnt_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwupt_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwupt_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwupt_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwupt_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwupt_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwupt_dtmp'
  grid%tail_statevars%DataName = 'LWUPT_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE UPWELLING LONGWAVE FLUX AT TOP'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwupt_dtmp
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
  ALLOCATE(grid%lwupt_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwupt_dtmp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwdnt_dtmp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwdnt_dtmp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwdnt_dtmp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwdnt_dtmp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwdnt_dtmp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwdnt_dtmp'
  grid%tail_statevars%DataName = 'LWDNT_DTM'
  grid%tail_statevars%Description = 'DIURNAL TEMP AVERAGE DOWNWELLING LONGWAVE FLUX AT TOP'
  grid%tail_statevars%Units = 'W m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwdnt_dtmp
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
  ALLOCATE(grid%lwdnt_dtmp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwdnt_dtmp(1,1).  ')
  endif
ENDIF
  IF (.NOT.grid%is_intermediate) THEN
   ALLOCATE( grid%tail_statevars%next )
   grid%tail_statevars => grid%tail_statevars%next
   NULLIFY( grid%tail_statevars%next )
   grid%tail_statevars%ProcOrient    = '  '
   grid%tail_statevars%VarName = 'nstepsmean_diurn'
   grid%tail_statevars%DataName = 'NSTEP_DTM'
   grid%tail_statevars%Description = 'NUMBER OF MEAN STEPS ACCUMULATED IN DIURNAL Calculation'
   grid%tail_statevars%Units = '-'
   grid%tail_statevars%Type    = 'i'
   grid%tail_statevars%Ntl = 0
   grid%tail_statevars%Restart  = .TRUE.
   grid%tail_statevars%Ndim    = 0
   grid%tail_statevars%scalar_array  = .FALSE. 
   grid%tail_statevars%ifield_0d => grid%nstepsmean_diurn
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  ENDIF
IF ( setinitval .EQ. 3 ) grid%nstepsmean_diurn=0
IF(okay_to_alloc.AND.in_use_for_config(id,'rscghis_2d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rscghis_2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rscghis_2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rscghis_2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rscghis_2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rscghis_2d'
  grid%tail_statevars%DataName = 'RSCGHIS_2D'
  grid%tail_statevars%Description = 'MAX NONINDUCTIVE CHARGING 2D'
  grid%tail_statevars%Units = 'C m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rscghis_2d
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
  ALLOCATE(grid%rscghis_2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rscghis_2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'induc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'induc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%induc(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%induc(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%induc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'induc'
  grid%tail_statevars%DataName = 'INDUC'
  grid%tail_statevars%Description = 'TOTAL INDUCTIVE CHARGING '
  grid%tail_statevars%Units = 'C m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%induc
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
  ALLOCATE(grid%induc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%induc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'noninduc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'noninduc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%noninduc(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%noninduc(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%noninduc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'noninduc'
  grid%tail_statevars%DataName = 'NONINDUC'
  grid%tail_statevars%Description = 'TOTAL NONINDUCTIVE CHARGING'
  grid%tail_statevars%Units = 'C m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%noninduc
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
  ALLOCATE(grid%noninduc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%noninduc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'sctot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sctot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sctot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sctot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sctot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sctot'
  grid%tail_statevars%DataName = 'SCTOT'
  grid%tail_statevars%Description = 'Total Space Charge Density'
  grid%tail_statevars%Units = 'C m-3'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%sctot
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
  ALLOCATE(grid%sctot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sctot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'elecmag').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'elecmag: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%elecmag(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecmag(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%elecmag=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'elecmag'
  grid%tail_statevars%DataName = 'ELECMAG'
  grid%tail_statevars%Description = 'EFIELD MAGNITUDE'
  grid%tail_statevars%Units = 'V m-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%elecmag
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
  ALLOCATE(grid%elecmag(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecmag(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'elecx').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'elecx: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%elecx(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecx(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%elecx=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'elecx'
  grid%tail_statevars%DataName = 'ELECX'
  grid%tail_statevars%Description = 'EFIELD X-Component'
  grid%tail_statevars%Units = 'V m-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%elecx
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
  ALLOCATE(grid%elecx(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecx(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'elecy').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'elecy: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%elecy(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecy(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%elecy=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'elecy'
  grid%tail_statevars%DataName = 'ELECY'
  grid%tail_statevars%Description = 'EFIELD Y-Component'
  grid%tail_statevars%Units = 'V m-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%elecy
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
  ALLOCATE(grid%elecy(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecy(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'elecz').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'elecz: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%elecz(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecz(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%elecz=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'elecz'
  grid%tail_statevars%DataName = 'ELECZ'
  grid%tail_statevars%Description = 'EFIELD Z-Component'
  grid%tail_statevars%Units = 'V m-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%elecz
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
  ALLOCATE(grid%elecz(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%elecz(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pot'
  grid%tail_statevars%DataName = 'POT'
  grid%tail_statevars%Description = 'POTENTIAL'
  grid%tail_statevars%Units = 'V'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pot
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
  ALLOCATE(grid%pot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'light').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'light: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%light(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%light(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%light=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'light'
  grid%tail_statevars%DataName = 'LIGHT'
  grid%tail_statevars%Description = 'lightning flash'
  grid%tail_statevars%Units = 'flash origin density'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%light
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
  ALLOCATE(grid%light(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%light(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lightdens').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lightdens: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lightdens(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lightdens(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lightdens=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lightdens'
  grid%tail_statevars%DataName = 'LIGHTDENS'
  grid%tail_statevars%Description = 'lightning flash density'
  grid%tail_statevars%Units = 'flash column-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lightdens
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
  ALLOCATE(grid%lightdens(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lightdens(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lightdis').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * IWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lightdis: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lightdis(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lightdis(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lightdis=0
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lightdis'
  grid%tail_statevars%DataName = 'LIGHTDIS'
  grid%tail_statevars%Description = 'lightning source density'
  grid%tail_statevars%Units = 'Source column-1'
  grid%tail_statevars%Type    = 'i'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%ifield_2d => grid%lightdis
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
  ALLOCATE(grid%lightdis(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lightdis(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'flshi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'flshi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%flshi(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshi(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%flshi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'flshi'
  grid%tail_statevars%DataName = 'FLSHI'
  grid%tail_statevars%Description = 'Lightning init points'
  grid%tail_statevars%Units = 'count'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%flshi
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
  ALLOCATE(grid%flshi(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshi(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'flshn').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'flshn: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%flshn(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshn(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%flshn=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'flshn'
  grid%tail_statevars%DataName = 'FLSHN'
  grid%tail_statevars%Description = 'Negative channels'
  grid%tail_statevars%Units = 'count'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%flshn
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
  ALLOCATE(grid%flshn(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshn(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'flshp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'flshp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%flshp(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshp(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%flshp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'flshp'
  grid%tail_statevars%DataName = 'FLSHP'
  grid%tail_statevars%Description = 'Positive channels'
  grid%tail_statevars%Units = 'count'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%flshp
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
  ALLOCATE(grid%flshp(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%flshp(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%nssl_ipelec=0
IF ( setinitval .EQ. 3 ) grid%nssl_isaund=0
IF ( setinitval .EQ. 3 ) grid%nssl_iscreen=0
IF ( setinitval .EQ. 3 ) grid%nssl_lightrad=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_idischarge=0
IF ( setinitval .EQ. 3 ) grid%nssl_ibrkd=0
IF ( setinitval .EQ. 3 ) grid%nssl_ecrit=initial_data_value
IF ( setinitval .EQ. 3 ) grid%nssl_disfrac=initial_data_value
IF ( setinitval .EQ. 3 ) grid%elec_physics=0
IF(okay_to_alloc.AND.in_use_for_config(id,'field_u_tend_perturb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_u_tend_perturb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_u_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_u_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_u_tend_perturb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_u_tend_perturb'
  grid%tail_statevars%DataName = 'FIELD_U_TEND_PERTURB'
  grid%tail_statevars%Description = 'field used to perturb u in the boundaries'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'X'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_u_tend_perturb
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
  ALLOCATE(grid%field_u_tend_perturb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_u_tend_perturb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'field_v_tend_perturb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_v_tend_perturb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_v_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_v_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_v_tend_perturb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_v_tend_perturb'
  grid%tail_statevars%DataName = 'FIELD_V_TEND_PERTURB'
  grid%tail_statevars%Description = 'field used to perturb v in the boundaries'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Y'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_v_tend_perturb
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
  ALLOCATE(grid%field_v_tend_perturb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_v_tend_perturb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'field_t_tend_perturb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_stoch_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'field_t_tend_perturb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%field_t_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_t_tend_perturb(sm31:em31,1:model_config_rec%num_stoch_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%field_t_tend_perturb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'field_t_tend_perturb'
  grid%tail_statevars%DataName = 'FIELD_T_TEND_PERTURB'
  grid%tail_statevars%Description = 'field used to perturb t in the boundaries'
  grid%tail_statevars%Units = ''
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%field_t_tend_perturb
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
  ALLOCATE(grid%field_t_tend_perturb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%field_t_tend_perturb(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%perturb_bdy=0
IF ( setinitval .EQ. 3 ) grid%perturb_chem_bdy=0
IF(okay_to_alloc.AND.in_use_for_config(id,'c1h').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c1h: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c1h(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c1h(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c1h=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c1h'
  grid%tail_statevars%DataName = 'C1H'
  grid%tail_statevars%Description = 'half levels, c1h = d bf / d eta, using znw'
  grid%tail_statevars%Units = 'Dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c1h
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
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
  ALLOCATE(grid%c1h(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c1h(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c2h').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c2h: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c2h(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c2h(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c2h=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c2h'
  grid%tail_statevars%DataName = 'C2H'
  grid%tail_statevars%Description = 'half levels, c2h = (1-c1h)*(p0-pt)'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c2h
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
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
  ALLOCATE(grid%c2h(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c2h(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c1f').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c1f: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c1f(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c1f(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c1f=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c1f'
  grid%tail_statevars%DataName = 'C1F'
  grid%tail_statevars%Description = 'full levels, c1f = d bf / d eta, using znu'
  grid%tail_statevars%Units = 'Dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c1f
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = kde
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
  grid%tail_statevars%ep1 = MIN( kde, kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%c1f(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c1f(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c2f').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c2f: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c2f(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c2f(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c2f=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c2f'
  grid%tail_statevars%DataName = 'C2F'
  grid%tail_statevars%Description = 'full levels, c2f = (1-c1f)*(p0-pt)'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c2f
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = kde
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
  grid%tail_statevars%ep1 = MIN( kde, kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%c2f(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c2f(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c3h').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c3h: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c3h(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c3h(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c3h=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c3h'
  grid%tail_statevars%DataName = 'C3H'
  grid%tail_statevars%Description = 'half levels, c3h = bh'
  grid%tail_statevars%Units = 'Dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c3h
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
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
  ALLOCATE(grid%c3h(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c3h(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c4h').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c4h: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c4h(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c4h(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c4h=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c4h'
  grid%tail_statevars%DataName = 'C4H'
  grid%tail_statevars%Description = 'half levels, c4h = (eta-bh)*(p0-pt), using znu'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c4h
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
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
  ALLOCATE(grid%c4h(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c4h(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c3f').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c3f: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c3f(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c3f(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c3f=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c3f'
  grid%tail_statevars%DataName = 'C3F'
  grid%tail_statevars%Description = 'full levels, c3f = bf'
  grid%tail_statevars%Units = 'Dimensionless'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c3f
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = kde
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
  grid%tail_statevars%ep1 = MIN( kde, kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%c3f(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c3f(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'c4f').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em32)-(sm32)+1))) * RWORDSIZE
  nba = &
((((em32)-(sm32)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'c4f: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%c4f(sm32:em32),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c4f(sm32:em32). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%c4f=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'c4f'
  grid%tail_statevars%DataName = 'C4F'
  grid%tail_statevars%Description = 'full levels, c4f = (eta-bf)*(p0-pt), using znw'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'Z'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 1
  grid%tail_statevars%Restart  = .TRUE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_1d => grid%c4f
  grid%tail_statevars%streams(1) = 197132289 ! 0bc00001 
  grid%tail_statevars%streams(2) = 2097152 ! 00200000 
  grid%tail_statevars%sd1 = kds
  grid%tail_statevars%ed1 = kde
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
  grid%tail_statevars%ep1 = MIN( kde, kpe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = 1
  grid%tail_statevars%sp3 = 1
  grid%tail_statevars%ep3 = 1
  grid%tail_statevars%dimname1 = 'bottom_top_stag'
  grid%tail_statevars%dimname2 = ''
  grid%tail_statevars%dimname3 = ''
  ENDIF
ELSE
  ALLOCATE(grid%c4f(1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%c4f(1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pcb'))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pcb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pcb(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pcb(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pcb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pcb'
  grid%tail_statevars%DataName = 'PCB'
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
  grid%tail_statevars%rfield_2d => grid%pcb
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
  ALLOCATE(grid%pcb(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pcb(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pc_1').AND.(IAND(1,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pc_1: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pc_1(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_1(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_1=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pc_1'
  grid%tail_statevars%DataName = 'PC_1'
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
  grid%tail_statevars%rfield_2d => grid%pc_1
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
  ALLOCATE(grid%pc_1(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_1(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pc_2').AND.(IAND(2,tl).NE.0))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pc_2: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pc_2(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_2(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_2=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pc_2'
  grid%tail_statevars%DataName = 'PC_2'
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
  grid%tail_statevars%rfield_2d => grid%pc_2
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
  ALLOCATE(grid%pc_2(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_2(1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_bxs(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bxs(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_bxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_bxe(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bxe(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_bxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_bys(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bys(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_bys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_bye(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bye(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_bye=initial_data_value
ELSE
  ALLOCATE(grid%pc_bxs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bxs(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_bxe(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bxe(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_bys(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bys(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_bye(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_bye(1,1,1).  ')
  endif
ENDIF
IF(.TRUE..AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_btxs(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btxs(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_btxs=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em33-sm33+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_btxe(sm33:em33,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btxe(sm33:em33,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_btxe=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_btys(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btys(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_btys=initial_data_value
  num_bytes_allocated = num_bytes_allocated + &
(((em31-sm31+1)*(spec_bdy_width))) * RWORDSIZE
  ALLOCATE(grid%pc_btye(sm31:em31,1,spec_bdy_width),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btye(sm31:em31,1,spec_bdy_width). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pc_btye=initial_data_value
ELSE
  ALLOCATE(grid%pc_btxs(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btxs(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_btxe(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btxe(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_btys(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btys(1,1,1).  ')
  endif
  ALLOCATE(grid%pc_btye(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pc_btye(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%hybrid_opt=0
IF ( setinitval .EQ. 3 ) grid%etac=initial_data_value
IF ( setinitval .EQ. 3 ) grid%num_wif_levels=0
IF ( setinitval .EQ. 3 ) grid%wif_input_opt=0
IF(okay_to_alloc.AND.in_use_for_config(id,'qnwfa_gc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnwfa_gc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnwfa_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnwfa_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnwfa_gc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnwfa_gc'
  grid%tail_statevars%DataName = 'QNWFA'
  grid%tail_statevars%Description = 'water-friendly aerosol  num concentration'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qnwfa_gc
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%qnwfa_gc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnwfa_gc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnifa_gc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnifa_gc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnifa_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnifa_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnifa_gc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnifa_gc'
  grid%tail_statevars%DataName = 'QNIFA'
  grid%tail_statevars%Description = 'water-friendly aerosol  num concentration'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qnifa_gc
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%qnifa_gc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnifa_gc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qnbca_gc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qnbca_gc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qnbca_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnbca_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qnbca_gc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qnbca_gc'
  grid%tail_statevars%DataName = 'QNBCA'
  grid%tail_statevars%Description = 'black carbon   aerosol  num concentration'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qnbca_gc
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%qnbca_gc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qnbca_gc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_gc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_gc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_gc(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_gc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_gc'
  grid%tail_statevars%DataName = 'P_WIF'
  grid%tail_statevars%Description = 'Pressure for first guess aerosol fields from metgrid'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_gc
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_gc(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_gc(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_now').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_now: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_now=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_now'
  grid%tail_statevars%DataName = 'P_WIF_NOW'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Now'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_now
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_now(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_now(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_jan').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_jan: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_jan=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_jan'
  grid%tail_statevars%DataName = 'P_WIF_JAN'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Jan'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_jan
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_jan(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jan(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_feb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_feb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_feb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_feb'
  grid%tail_statevars%DataName = 'P_WIF_FEB'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Feb'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_feb
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_feb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_feb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_mar').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_mar: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_mar=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_mar'
  grid%tail_statevars%DataName = 'P_WIF_MAR'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Mar'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_mar
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_mar(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_mar(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_apr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_apr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_apr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_apr'
  grid%tail_statevars%DataName = 'P_WIF_APR'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Apr'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_apr
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_apr(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_apr(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_may').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_may: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_may=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_may'
  grid%tail_statevars%DataName = 'P_WIF_MAY'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols May'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_may
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_may(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_may(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_jun').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_jun: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_jun=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_jun'
  grid%tail_statevars%DataName = 'P_WIF_JUN'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Jun'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_jun
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_jun(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jun(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_jul').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_jul: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_jul=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_jul'
  grid%tail_statevars%DataName = 'P_WIF_JUL'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Jul'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_jul
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_jul(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_jul(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_aug').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_aug: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_aug=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_aug'
  grid%tail_statevars%DataName = 'P_WIF_AUG'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Aug'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_aug
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_aug(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_aug(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_sep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_sep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_sep=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_sep'
  grid%tail_statevars%DataName = 'P_WIF_SEP'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Sep'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_sep
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_sep(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_sep(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_oct').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_oct: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_oct=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_oct'
  grid%tail_statevars%DataName = 'P_WIF_OCT'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Oct'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_oct
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_oct(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_oct(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_nov').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_nov: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_nov=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_nov'
  grid%tail_statevars%DataName = 'P_WIF_NOV'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Nov'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_nov
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_nov(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_nov(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'p_wif_dec').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'p_wif_dec: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%p_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%p_wif_dec=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'p_wif_dec'
  grid%tail_statevars%DataName = 'P_WIF_DEC'
  grid%tail_statevars%Description = 'Pressure for Water Ice Friendly Aerosols Dec'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%p_wif_dec
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%p_wif_dec(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%p_wif_dec(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_now').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_now: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_now=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_now'
  grid%tail_statevars%DataName = 'W_WIF_NOW'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Now'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_now
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_now(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_now(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_jan').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_jan: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_jan=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_jan'
  grid%tail_statevars%DataName = 'W_WIF_JAN'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Jan'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_jan
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_jan(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jan(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_feb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_feb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_feb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_feb'
  grid%tail_statevars%DataName = 'W_WIF_FEB'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Feb'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_feb
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_feb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_feb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_mar').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_mar: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_mar=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_mar'
  grid%tail_statevars%DataName = 'W_WIF_MAR'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Mar'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_mar
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_mar(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_mar(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_apr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_apr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_apr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_apr'
  grid%tail_statevars%DataName = 'W_WIF_APR'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Apr'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_apr
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_apr(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_apr(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_may').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_may: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_may=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_may'
  grid%tail_statevars%DataName = 'W_WIF_MAY'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option May'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_may
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_may(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_may(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_jun').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_jun: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_jun=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_jun'
  grid%tail_statevars%DataName = 'W_WIF_JUN'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Jun'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_jun
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_jun(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jun(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_jul').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_jul: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_jul=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_jul'
  grid%tail_statevars%DataName = 'W_WIF_JUL'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Jul'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_jul
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_jul(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_jul(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_aug').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_aug: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_aug=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_aug'
  grid%tail_statevars%DataName = 'W_WIF_AUG'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Aug'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_aug
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_aug(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_aug(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_sep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_sep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_sep=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_sep'
  grid%tail_statevars%DataName = 'W_WIF_SEP'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Sep'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_sep
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_sep(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_sep(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_oct').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_oct: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_oct=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_oct'
  grid%tail_statevars%DataName = 'W_WIF_OCT'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Oct'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_oct
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_oct(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_oct(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_nov').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_nov: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_nov=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_nov'
  grid%tail_statevars%DataName = 'W_WIF_NOV'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Nov'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_nov
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_nov(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_nov(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'w_wif_dec').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'w_wif_dec: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%w_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%w_wif_dec=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'w_wif_dec'
  grid%tail_statevars%DataName = 'W_WIF_DEC'
  grid%tail_statevars%Description = 'Background Water Friendly Aerosol option Dec'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%w_wif_dec
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%w_wif_dec(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%w_wif_dec(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_now').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_now: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_now=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_now'
  grid%tail_statevars%DataName = 'I_WIF_NOW'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Now'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_now
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_now(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_now(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_jan').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_jan: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_jan=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_jan'
  grid%tail_statevars%DataName = 'I_WIF_JAN'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Jan'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_jan
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_jan(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jan(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_feb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_feb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_feb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_feb'
  grid%tail_statevars%DataName = 'I_WIF_FEB'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Feb'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_feb
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_feb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_feb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_mar').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_mar: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_mar=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_mar'
  grid%tail_statevars%DataName = 'I_WIF_MAR'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Mar'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_mar
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_mar(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_mar(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_apr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_apr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_apr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_apr'
  grid%tail_statevars%DataName = 'I_WIF_APR'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Apr'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_apr
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_apr(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_apr(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_may').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_may: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_may=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_may'
  grid%tail_statevars%DataName = 'I_WIF_MAY'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option May'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_may
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_may(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_may(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_jun').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_jun: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_jun=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_jun'
  grid%tail_statevars%DataName = 'I_WIF_JUN'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Jun'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_jun
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_jun(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jun(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_jul').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_jul: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_jul=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_jul'
  grid%tail_statevars%DataName = 'I_WIF_JUL'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Jul'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_jul
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_jul(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_jul(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_aug').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_aug: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_aug=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_aug'
  grid%tail_statevars%DataName = 'I_WIF_AUG'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Aug'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_aug
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_aug(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_aug(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_sep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_sep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_sep=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_sep'
  grid%tail_statevars%DataName = 'I_WIF_SEP'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Sep'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_sep
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_sep(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_sep(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_oct').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_oct: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_oct=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_oct'
  grid%tail_statevars%DataName = 'I_WIF_OCT'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Oct'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_oct
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_oct(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_oct(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_nov').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_nov: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_nov=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_nov'
  grid%tail_statevars%DataName = 'I_WIF_NOV'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Nov'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_nov
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_nov(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_nov(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'i_wif_dec').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'i_wif_dec: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%i_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%i_wif_dec=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'i_wif_dec'
  grid%tail_statevars%DataName = 'I_WIF_DEC'
  grid%tail_statevars%Description = 'Background Ice   Friendly Aerosol option Dec'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%i_wif_dec
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%i_wif_dec(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%i_wif_dec(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_now').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_now: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_now(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_now=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_now'
  grid%tail_statevars%DataName = 'B_WIF_NOW'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Now'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_now
  grid%tail_statevars%streams(1) = 0 ! 00000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_now(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_now(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_jan').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_jan: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jan(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_jan=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_jan'
  grid%tail_statevars%DataName = 'B_WIF_JAN'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Jan'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_jan
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_jan(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jan(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_feb').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_feb: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_feb(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_feb=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_feb'
  grid%tail_statevars%DataName = 'B_WIF_FEB'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Feb'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_feb
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_feb(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_feb(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_mar').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_mar: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_mar(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_mar=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_mar'
  grid%tail_statevars%DataName = 'B_WIF_MAR'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Mar'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_mar
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_mar(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_mar(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_apr').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_apr: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_apr(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_apr=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_apr'
  grid%tail_statevars%DataName = 'B_WIF_APR'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Apr'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_apr
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_apr(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_apr(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_may').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_may: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_may(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_may=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_may'
  grid%tail_statevars%DataName = 'B_WIF_MAY'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option May'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_may
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_may(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_may(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_jun').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_jun: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jun(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_jun=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_jun'
  grid%tail_statevars%DataName = 'B_WIF_JUN'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Jun'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_jun
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_jun(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jun(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_jul').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_jul: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jul(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_jul=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_jul'
  grid%tail_statevars%DataName = 'B_WIF_JUL'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Jul'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_jul
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_jul(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_jul(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_aug').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_aug: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_aug(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_aug=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_aug'
  grid%tail_statevars%DataName = 'B_WIF_AUG'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Aug'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_aug
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_aug(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_aug(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_sep').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_sep: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_sep(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_sep=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_sep'
  grid%tail_statevars%DataName = 'B_WIF_SEP'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Sep'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_sep
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_sep(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_sep(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_oct').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_oct: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_oct(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_oct=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_oct'
  grid%tail_statevars%DataName = 'B_WIF_OCT'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Oct'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_oct
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_oct(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_oct(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_nov').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_nov: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_nov(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_nov=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_nov'
  grid%tail_statevars%DataName = 'B_WIF_NOV'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Nov'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_nov
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_nov(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_nov(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'b_wif_dec').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((model_config_rec%num_wif_levels)-(1)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'b_wif_dec: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%b_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_dec(sm31:em31,1:model_config_rec%num_wif_levels,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%b_wif_dec=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'b_wif_dec'
  grid%tail_statevars%DataName = 'B_WIF_DEC'
  grid%tail_statevars%Description = 'Background Black Carbon Aerosol option Dec'
  grid%tail_statevars%Units = '  kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = 'Z'
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%b_wif_dec
  grid%tail_statevars%streams(1) = 67108864 ! 04000000 
  grid%tail_statevars%streams(2) = 0 ! 00000000 
  grid%tail_statevars%sd1 = ids
  grid%tail_statevars%ed1 = (ide-1)
  grid%tail_statevars%sd2 = 1
  grid%tail_statevars%ed2 = config_flags%num_wif_levels
  grid%tail_statevars%sd3 = jds
  grid%tail_statevars%ed3 = (jde-1)
  grid%tail_statevars%sm1 = ims
  grid%tail_statevars%em1 = ime
  grid%tail_statevars%sm2 = 1
  grid%tail_statevars%em2 = config_flags%num_wif_levels
  grid%tail_statevars%sm3 = jms
  grid%tail_statevars%em3 = jme
  grid%tail_statevars%sp1 = ips
  grid%tail_statevars%ep1 = MIN( (ide-1), ipe )
  grid%tail_statevars%sp2 = 1
  grid%tail_statevars%ep2 = config_flags%num_wif_levels
  grid%tail_statevars%sp3 = jps
  grid%tail_statevars%ep3 = MIN( (jde-1), jpe )
  grid%tail_statevars%subgrid_x = .FALSE.
  grid%tail_statevars%subgrid_y = .FALSE.
  grid%tail_statevars%dimname1 = 'west_east'
  grid%tail_statevars%dimname2 = 'num_wif_levels_stag'
  grid%tail_statevars%dimname3 = 'south_north'
  ENDIF
ELSE
  ALLOCATE(grid%b_wif_dec(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%b_wif_dec(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%diag_nwp2=0
IF(okay_to_alloc.AND.in_use_for_config(id,'sealevelp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'sealevelp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%sealevelp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sealevelp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%sealevelp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'sealevelp'
  grid%tail_statevars%DataName = 'SEALEVELP'
  grid%tail_statevars%Description = 'sea level pressure'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%sealevelp
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%sealevelp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%sealevelp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'temperature').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'temperature: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%temperature(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%temperature(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%temperature=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'temperature'
  grid%tail_statevars%DataName = 'TEMPERATURE'
  grid%tail_statevars%Description = 'sensible temperature'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%temperature
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%temperature(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%temperature(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'geoheight').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'geoheight: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%geoheight(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%geoheight(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%geoheight=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'geoheight'
  grid%tail_statevars%DataName = 'GEOHEIGHT'
  grid%tail_statevars%Description = 'geopotential height'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%geoheight
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%geoheight(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%geoheight(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'pressure').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'pressure: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%pressure(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pressure(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%pressure=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'pressure'
  grid%tail_statevars%DataName = 'PRESSURE'
  grid%tail_statevars%Description = 'atmospheric pressure'
  grid%tail_statevars%Units = 'Pa'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%pressure
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%pressure(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%pressure(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'umet').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'umet: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%umet(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%umet(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%umet=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'umet'
  grid%tail_statevars%DataName = 'UMET'
  grid%tail_statevars%Description = 'earth relative U at mass points'
  grid%tail_statevars%Units = 'm/s'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%umet
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%umet(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%umet(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'vmet').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'vmet: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%vmet(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmet(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%vmet=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'vmet'
  grid%tail_statevars%DataName = 'VMET'
  grid%tail_statevars%Description = 'earth relative V at mass points'
  grid%tail_statevars%Units = 'm/s'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%vmet
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%vmet(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%vmet(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'speed').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'speed: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%speed(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%speed(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%speed=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'speed'
  grid%tail_statevars%DataName = 'SPEED'
  grid%tail_statevars%Description = 'horizontal wind speed'
  grid%tail_statevars%Units = 'm/s'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%speed
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%speed(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%speed(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'dir').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'dir: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%dir(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dir(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%dir=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'dir'
  grid%tail_statevars%DataName = 'DIR'
  grid%tail_statevars%Description = 'wind direction, 0=northly, 270=westerly'
  grid%tail_statevars%Units = 'degrees'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%dir
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%dir(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%dir(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rain').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rain: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rain(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rain(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rain=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rain'
  grid%tail_statevars%DataName = 'RAIN'
  grid%tail_statevars%Description = 'total rainfall'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%rain
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%rain(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rain(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'liqrain').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'liqrain: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%liqrain(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%liqrain(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%liqrain=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'liqrain'
  grid%tail_statevars%DataName = 'LIQRAIN'
  grid%tail_statevars%Description = 'total liquid rainfall'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%liqrain
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%liqrain(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%liqrain(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tpw').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tpw: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tpw(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tpw(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tpw=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tpw'
  grid%tail_statevars%DataName = 'TPW'
  grid%tail_statevars%Description = 'total precipitable water'
  grid%tail_statevars%Units = 'mm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tpw
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%tpw(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tpw(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'potential_t').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'potential_t: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%potential_t(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%potential_t(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%potential_t=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'potential_t'
  grid%tail_statevars%DataName = 'POTENTIAL_T'
  grid%tail_statevars%Description = 'potential temperature'
  grid%tail_statevars%Units = 'K'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%potential_t
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%potential_t(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%potential_t(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'rh').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'rh: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%rh(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rh(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%rh=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'rh'
  grid%tail_statevars%DataName = 'RH'
  grid%tail_statevars%Description = 'relative humidity'
  grid%tail_statevars%Units = '%'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%rh
  grid%tail_statevars%streams(1) = 2 ! 00000002 
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
  ALLOCATE(grid%rh(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%rh(1,1,1).  ')
  endif
ENDIF
IF ( setinitval .EQ. 3 ) grid%solar_diagnostics=0
IF(okay_to_alloc.AND.in_use_for_config(id,'qc_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qc_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qc_tot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qc_tot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qc_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qc_tot'
  grid%tail_statevars%DataName = 'QC_TOT'
  grid%tail_statevars%Description = 'CLOUD WATER MIXING RATIO RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qc_tot
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
  ALLOCATE(grid%qc_tot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qc_tot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'qi_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em32)-(sm32)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'qi_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%qi_tot(sm31:em31,sm32:em32,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qi_tot(sm31:em31,sm32:em32,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%qi_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'qi_tot'
  grid%tail_statevars%DataName = 'QI_TOT'
  grid%tail_statevars%Description = 'ICE MIXING RATIO RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'kg kg-1'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XZY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 3
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_3d => grid%qi_tot
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
  ALLOCATE(grid%qi_tot(1,1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%qi_tot(1,1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'cldfrac2d').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'cldfrac2d: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%cldfrac2d(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfrac2d(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%cldfrac2d=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'cldfrac2d'
  grid%tail_statevars%DataName = 'CLDFRAC2D'
  grid%tail_statevars%Description = '2-D MAX CLOUD FRACTION'
  grid%tail_statevars%Units = '%'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%cldfrac2d
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
  ALLOCATE(grid%cldfrac2d(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%cldfrac2d(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wvp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wvp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wvp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wvp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wvp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wvp'
  grid%tail_statevars%DataName = 'WVP'
  grid%tail_statevars%Description = 'WATER VAPOR PATH'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%wvp
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
  ALLOCATE(grid%wvp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wvp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwp'
  grid%tail_statevars%DataName = 'LWP'
  grid%tail_statevars%Description = 'LIQUID CLOUD WATER PATH'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwp
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
  ALLOCATE(grid%lwp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iwp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iwp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iwp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iwp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iwp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iwp'
  grid%tail_statevars%DataName = 'IWP'
  grid%tail_statevars%Description = 'ICE CLOUD WATER PATH'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%iwp
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
  ALLOCATE(grid%iwp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iwp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'swp').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'swp: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%swp(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swp(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%swp=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'swp'
  grid%tail_statevars%DataName = 'SWP'
  grid%tail_statevars%Description = 'SNOW CLOUD WATER PATH'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%swp
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
  ALLOCATE(grid%swp(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%swp(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wp_sum').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wp_sum: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wp_sum(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wp_sum(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wp_sum=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wp_sum'
  grid%tail_statevars%DataName = 'WP_SUM'
  grid%tail_statevars%Description = 'SUM OF LWP+IWP+SWP'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%wp_sum
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
  ALLOCATE(grid%wp_sum(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wp_sum(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'lwp_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'lwp_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%lwp_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwp_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%lwp_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'lwp_tot'
  grid%tail_statevars%DataName = 'LWP_TOT'
  grid%tail_statevars%Description = 'LIQUID CLOUD WATER PATH RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%lwp_tot
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
  ALLOCATE(grid%lwp_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%lwp_tot(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'iwp_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'iwp_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%iwp_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iwp_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%iwp_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'iwp_tot'
  grid%tail_statevars%DataName = 'IWP_TOT'
  grid%tail_statevars%Description = 'ICE CLOUD WATER PATH RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%iwp_tot
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
  ALLOCATE(grid%iwp_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%iwp_tot(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'wp_tot_sum').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'wp_tot_sum: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%wp_tot_sum(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wp_tot_sum(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%wp_tot_sum=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'wp_tot_sum'
  grid%tail_statevars%DataName = 'WP_TOT_SUM'
  grid%tail_statevars%Description = 'SUM OF LWP+IWP+SWP RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'kg m-2'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%wp_tot_sum
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
  ALLOCATE(grid%wp_tot_sum(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%wp_tot_sum(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'re_qc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 're_qc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%re_qc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%re_qc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 're_qc'
  grid%tail_statevars%DataName = 'RE_QC'
  grid%tail_statevars%Description = 'MASS-WEIGHTED LIQUID CLOUD EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%re_qc
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
  ALLOCATE(grid%re_qc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'re_qi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 're_qi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%re_qi(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qi(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%re_qi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 're_qi'
  grid%tail_statevars%DataName = 'RE_QI'
  grid%tail_statevars%Description = 'MASS-WEIGHTED ICE EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%re_qi
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
  ALLOCATE(grid%re_qi(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qi(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'re_qs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 're_qs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%re_qs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%re_qs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 're_qs'
  grid%tail_statevars%DataName = 'RE_QS'
  grid%tail_statevars%Description = 'MASS-WEIGHTED SNOW EFFECTIVE RADIUS'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%re_qs
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
  ALLOCATE(grid%re_qs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'re_qc_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 're_qc_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%re_qc_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qc_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%re_qc_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 're_qc_tot'
  grid%tail_statevars%DataName = 'RE_QC_TOT'
  grid%tail_statevars%Description = 'MASS-WEIGHTED LIQUID CLOUD EFFECTIVE RADIUS RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%re_qc_tot
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
  ALLOCATE(grid%re_qc_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qc_tot(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'re_qi_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 're_qi_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%re_qi_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qi_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%re_qi_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 're_qi_tot'
  grid%tail_statevars%DataName = 'RE_QI_TOT'
  grid%tail_statevars%Description = 'MASS-WEIGHTED ICE EFFECTIVE RADIUS RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = 'm'
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%re_qi_tot
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
  ALLOCATE(grid%re_qi_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%re_qi_tot(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_qc').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_qc: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_qc(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qc(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_qc=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_qc'
  grid%tail_statevars%DataName = 'TAU_QC'
  grid%tail_statevars%Description = 'MASS-WEIGHTED LIQUID CLOUD OPTICAL THICKNESS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tau_qc
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
  ALLOCATE(grid%tau_qc(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qc(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_qi').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_qi: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_qi(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qi(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_qi=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_qi'
  grid%tail_statevars%DataName = 'TAU_QI'
  grid%tail_statevars%Description = 'MASS-WEIGHTED ICE OPTICAL THICKNESS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tau_qi
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
  ALLOCATE(grid%tau_qi(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qi(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_qs').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_qs: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_qs(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qs(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_qs=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_qs'
  grid%tail_statevars%DataName = 'TAU_QS'
  grid%tail_statevars%Description = 'MASS-WEIGHTED SNOW OPTICAL THICKNESS'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tau_qs
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
  ALLOCATE(grid%tau_qs(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qs(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_qc_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_qc_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_qc_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qc_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_qc_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_qc_tot'
  grid%tail_statevars%DataName = 'TAU_QC_TOT'
  grid%tail_statevars%Description = 'MASS-WEIGHTED LIQUID CLOUD OPTICAL THICKNESS RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tau_qc_tot
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
  ALLOCATE(grid%tau_qc_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qc_tot(1,1).  ')
  endif
ENDIF
IF(okay_to_alloc.AND.in_use_for_config(id,'tau_qi_tot').AND.(.NOT.grid%is_intermediate))THEN
  num_bytes_allocated = num_bytes_allocated + &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
  nba = &
((((em31)-(sm31)+1))*(((em33)-(sm33)+1))) * RWORDSIZE
#if ( SHOW_ALL_VARS_USED == 1 )
  WRITE(message_string,fmt='(a,i12)') 'tau_qi_tot: bytes = ',nba
  CALL wrf_message(message_string)
#endif
  ALLOCATE(grid%tau_qi_tot(sm31:em31,sm33:em33),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qi_tot(sm31:em31,sm33:em33). ')
  endif
  IF ( setinitval .EQ. 1 .OR. setinitval .EQ. 3 ) grid%tau_qi_tot=initial_data_value
  IF (.NOT.grid%is_intermediate) THEN
  ALLOCATE( grid%tail_statevars%next )
  grid%tail_statevars => grid%tail_statevars%next
  NULLIFY( grid%tail_statevars%next )
  grid%tail_statevars%VarName = 'tau_qi_tot'
  grid%tail_statevars%DataName = 'TAU_QI_TOT'
  grid%tail_statevars%Description = 'MASS-WEIGHTED ICE OPTICAL THICKNESS RESOLVED + UNRESOLVED'
  grid%tail_statevars%Units = ' '
  grid%tail_statevars%Type    = 'r'
  grid%tail_statevars%ProcOrient    = ' '
  grid%tail_statevars%MemoryOrder  = 'XY'
  grid%tail_statevars%Stagger      = ''
  grid%tail_statevars%Ntl     = 0
  grid%tail_statevars%Ndim    = 2
  grid%tail_statevars%Restart  = .FALSE.
  grid%tail_statevars%scalar_array = .FALSE.
  grid%tail_statevars%rfield_2d => grid%tau_qi_tot
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
  ALLOCATE(grid%tau_qi_tot(1,1),STAT=ierr)
  if (ierr.ne.0) then
    CALL wrf_error_fatal ( &
    'frame/module_domain.f: Failed to allocate grid%tau_qi_tot(1,1).  ')
  endif
ENDIF
END SUBROUTINE allocs_30
