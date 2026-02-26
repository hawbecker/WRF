








MODULE module_firebrand_spotting

    USE, INTRINSIC :: IEEE_ARITHMETIC
    USE module_domain,       ONLY : get_ijk_from_grid, domain               
    USE module_configure,    ONLY : grid_config_rec_type                    
    USE module_symbols_util, ONLY : WRFU_TimeInterval, WRFU_TimeIntervalGet, WRFU_TimeIntervalSet
    USE MPI 

    IMPLICIT NONE

    PRIVATE
    PUBLIC firebrand_spotting_em_init, firebrand_spotting_em_driver, get_local_ijk


    

    
    
    
    
    
    
    
    
    

    
    
    

    INTEGER, PARAMETER :: dp = KIND(0.d0)      

    INTEGER, PARAMETER :: wrfdbg = 10    
    
    INTEGER, PARAMETER :: no_fuel_cat = 14
    INTEGER, PARAMETER :: nf_sb = 204          
    INTEGER, PARAMETER :: nfuelcats = 53       

    REAL,    PARAMETER :: grav = 9.80616_dp    
    REAL,    PARAMETER :: rdry = 287.04_dp     
    REAL,    PARAMETER :: p2jm = 100.0_dp      
    REAL,    PARAMETER :: rcd  = 0.45_dp       
    REAL,    PARAMETER :: rd   = 287.15_dp    
    REAL,    PARAMETER :: rv   = 461.6_dp
    REAL,    PARAMETER :: t0   = 300.0_dp
    REAL,    PARAMETER :: cp   = 7.0_dp*rd/2.0_dp
    REAL,    PARAMETER :: rcp  = rd/cp
    REAL,    PARAMETER :: p1000mb= 100000.0_dp
    REAL,    PARAMETER :: r1o3   = 1.0_dp/3.0_dp  
    REAL,    PARAMETER :: sboltz = 5.67E-5_dp     
    REAL,    PARAMETER :: emiss  = 0.9_dp         
    REAL,    PARAMETER :: cpw    = 1466.0_dp      
    REAL,    PARAMETER :: cpc    = 712.0_dp       
    REAL,    PARAMETER :: beta0  = 4.8E-7_dp      
    REAL,    PARAMETER :: s_coeff= 110.4_dp       
    REAL,    PARAMETER :: b_coeff= 1.458E-3_dp    
    REAL,    PARAMETER :: shmt   = 0.7_dp         
    REAL,    PARAMETER :: thcon  = 27.0_dp        

    
    
    REAL,    PARAMETER :: pr     = 0.7_dp         

    REAL,    PARAMETER :: NEGLIGIBLE = 10*EPSILON(1.0)
    REAL,    PARAMETER :: ZERO_dp = 0.0_dp 
    REAL,    PARAMETER :: dp05 = 0.5_dp
    REAL,    PARAMETER :: dp1 = 1.0_dp


    
    
    

    
    REAL, PARAMETER :: br_min_mass = EPSILON(dp1) 

    
    REAL, PARAMETER :: br_min_diam = 0.0000001_dp

    
    
    

    CHARACTER (LEN=200), SAVE     :: msg
    CHARACTER (LEN=256), SAVE     :: fmt
    CHARACTER (LEN=200), DIMENSION(10) :: amsg
    INTEGER, SAVE :: imsg 

    
    
    

    
    INTEGER, SAVE :: fs_array_maxsize   
    INTEGER, SAVE :: fs_gen_levels      
    INTEGER, SAVE :: fs_gen_lim 
    INTEGER, SAVE :: fs_gen_dt

    REAL,    SAVE :: firebrand_dens      
    REAL,    SAVE :: firebrand_dens_char 


    
    
    

    LOGICAL              :: this_is_ideal = .FALSE. 

    TYPE p_properties  
        REAL :: p_mass 
        REAL :: p_diam 
        REAL :: p_effd 
        REAL :: p_temp 
        REAL :: p_tvel 
    END TYPE p_properties

    
    
    
    

    
    
    
    
    INTEGER, SAVE :: ids, jds, ide, jde, kde      
    INTEGER, SAVE :: ims, jms, ime, jme, kms, kme 
    INTEGER, SAVE :: is, ie, js, je, ks, ke       
    INTEGER, SAVE :: ifps, jfps, ifpe, jfpe       

CONTAINS












    SUBROUTINE firebrand_spotting_em_init ( & 

        grid,      &
        cf,        &
        fs_p_id,     &
        fs_p_src,    &
        fs_p_dt,     &
        fs_p_x,      &
        fs_p_y,      &
        fs_p_z,      &
        fs_last_gen_dt,&
        fs_gen_idmax,  &
        fs_count_reset,&
        fs_p_mass, &  
        fs_p_diam, & 
        fs_p_effd,& 
        fs_p_temp, & 
        fs_p_tvel, &
        fs_count_landed_all,&
        fs_count_landed_hist,&
        fs_landing_mask,&
        fs_spotting_lkhd,&
        fs_frac_landed)


        USE module_firebrand_spotting_mpi,            ONLY: fs_mpi_init
        
        
        

        IMPLICIT NONE

        
        
        

        TYPE(domain),               INTENT(IN) :: grid 
        TYPE(grid_config_rec_type), INTENT(IN) :: cf   

        INTEGER,  INTENT(INOUT) :: fs_last_gen_dt, fs_gen_idmax
        LOGICAL,  INTENT(INOUT) :: fs_count_reset

        
        INTEGER,  INTENT(INOUT), DIMENSION(:)    :: fs_p_id, fs_p_dt, fs_p_src
        REAL,     INTENT(INOUT), DIMENSION(:)    :: fs_p_x, fs_p_y, fs_p_z 
        REAL,     INTENT(INOUT), DIMENSION(:)    :: fs_p_mass, fs_p_diam, fs_p_effd
        REAL,     INTENT(INOUT), DIMENSION(:)    :: fs_p_temp, fs_p_tvel
        REAL,     INTENT(INOUT), DIMENSION(ims:,jms:)  :: fs_count_landed_all, fs_count_landed_hist, fs_spotting_lkhd, fs_frac_landed
        INTEGER,  INTENT(INOUT), DIMENSION(ims:,jms:) :: fs_landing_mask

        

        
        

        fs_array_maxsize = cf%fs_array_maxsize
        fs_gen_levels    = cf%fs_firebrand_gen_levels
        fs_gen_lim       = cf%fs_firebrand_gen_lim
        fs_gen_dt        = cf%fs_firebrand_gen_dt

        fmt = '(A,1x,I6)' 
        WRITE (amsg(1),*)   'SPFire_init: fspotting_em_init'
        WRITE (amsg(2),fmt) 'SPFire_init:  firebrand limit =', fs_gen_lim
        WRITE (amsg(3),fmt) 'SPFire_init:               dt =', fs_gen_dt
        WRITE (amsg(4),fmt) 'SPFire_init: fs_array_maxsize =', fs_array_maxsize
        WRITE (amsg(5),fmt) 'SPFire_init:    fs_gen_levels =', fs_gen_levels
        DO imsg=1,5
            CALL wrf_debug (wrfdbg, TRIM(amsg(imsg)) )
        ENDDO

        
        
        
        

        CALL get_local_ijk(grid, & 
                           ifps=ifps, jfps=jfps, ifpe=ifpe, jfpe=jfpe, &
                           ids=ids, jds=jds, ide=ide, jde=jde, kde=kde, &
                           ims=ims, jms=jms, ime=ime, jme=jme, kms=kms, kme=kme, &
                           ips=is,  jps=js,  ipe=ie,  jpe=je,  kps=ks,  kpe=ke)        

        WRITE (msg,'(6(i6,1x))') is, ie, js, je, ks, ke
        CALL wrf_debug (wrfdbg, 'SPFire_init tile bounds: '//msg)

        WRITE (msg,'(6(i6,1x))') ims, ime, jms, jme, kms, kme
        CALL wrf_debug (wrfdbg, 'SPFire_init memory bounds: '//msg)

        WRITE (msg,'(4(i6,1x))') ifps, ifpe, jfps, jfpe
        CALL wrf_debug (wrfdbg, 'SPFire_init fire refined bounds: '//msg)


        
        
        
        fs_count_reset=.FALSE. 

        fs_last_gen_dt = 0
        fs_gen_idmax   = 0
        fs_p_id    = 0
        fs_p_dt    = 0
        fs_p_src   = 0
        fs_p_x     = 0.0_dp
        fs_p_y     = 0.0_dp
        fs_p_z     = 0.0_dp
        fs_p_mass  = 0.0_dp
        fs_p_diam  = 0.0_dp
        fs_p_effd  = 0.0_dp
        fs_p_temp  = 0.0_dp
        fs_p_tvel  = 0.0_dp

        fs_landing_mask(:,:) = 0
        fs_count_landed_all (:,:) = 0.0_dp
        fs_count_landed_hist(:,:) = 0.0_dp
        fs_spotting_lkhd(:,:) = 0.0_dp
        fs_frac_landed(:,:)   = 0.0_dp

        
        

        

        IF ( grid%this_is_an_ideal_run ) THEN

            this_is_ideal = .TRUE.
            CALL wrf_debug (wrfdbg, 'SPFire_init: Ideal Run detected' )

        ELSE

            this_is_ideal = .FALSE.
            CALL wrf_debug (wrfdbg, 'SPFire_init: Not an Ideal Run' )

        ENDIF


        CALL fs_mpi_init(grid)

    END SUBROUTINE firebrand_spotting_em_init





    PURE &
    FUNCTION order_val(arr, ord) 


        IMPLICIT NONE

        REAL,    INTENT(IN), DIMENSION(:) :: arr
        INTEGER, INTENT(IN) :: ord
        REAL    :: order_val
        INTEGER :: diff, besti, iord, i, error

        
        
        
        
        
        
        
        
        
        
        
        

        error = 2

        diff = SIZE(arr) -1
        besti = 1

        DO i=1,SIZE(arr)

            iord = COUNT(arr > arr(i))
            IF (ABS(ord - iord) <= diff) besti = i
            diff = MIN(diff, ABS(ord - iord))
            IF (diff <= error) EXIT
        ENDDO




        order_val = arr(besti)

END FUNCTION order_val






    PURE &
    FUNCTION fire2tile(fr_arr, dsx,dsy) RESULT(new_arr)

    
        IMPLICIT NONE

        REAL,    INTENT(IN), DIMENSION(ifps:ifpe,jfps:jfpe) :: fr_arr
        INTEGER, INTENT(IN)                 :: dsx, dsy
        REAL,    ALLOCATABLE,DIMENSION(:,:) :: new_arr
        INTEGER :: i, j
        INTEGER, DIMENSION(2)   :: fshp

        
        
        
        

        fshp = SHAPE(fr_arr)

        ALLOCATE(new_arr(1:fshp(1)/dsx, 1:fshp(2)/dsy))
        new_arr(:,:) = ZERO_dp

        new_arr(1:fshp(1)/dsx, 1:fshp(2)/dsy) = &
                          RESHAPE([((&
                          SUM(fr_arr(i:i+dsx-1,j:j+dsy-1)), &
                                     i=ifps,ifpe-1,dsx),    &
                                     j=jfps,jfpe-1,dsy)],   &
                          [fshp(1)/dsx,fshp(2)/dsy])
        
    END FUNCTION fire2tile






    ELEMENTAL FUNCTION fuel_spotting_risk(fuel_fgi, factor, fuel_mcg)


        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        IMPLICIT NONE

        REAL     :: fuel_spotting_risk
        REAL, INTENT(IN) :: factor
        REAL, INTENT(IN) :: fuel_fgi, fuel_mcg 
 
        fuel_spotting_risk = factor * (dp1 - MIN(dp1, fuel_mcg/fuel_fgi)) 

        END FUNCTION fuel_spotting_risk






    ELEMENTAL FUNCTION spotting_threat_factor(fcat)

        IMPLICIT NONE

        INTEGER, INTENT(IN)    :: fcat
        REAL,    DIMENSION(nfuelcats+1) :: factor
        REAL                            :: spotting_threat_factor
        
        
        
        

        
        

        factor(1)     =  1.0_dp 
        factor(2:13)  =  1.0_dp  
        factor(14)    =  ZERO_dp 
        factor(15:nfuelcats+1) =  1.0_dp  

        spotting_threat_factor = factor(fcat)
        
        

    END FUNCTION spotting_threat_factor




































































    ELEMENTAL FUNCTION get_fuel_cat(crosswalk, cat)


        

        IMPLICIT NONE

        INTEGER :: get_fuel_cat
        LOGICAL, INTENT(IN):: crosswalk
        REAL,    INTENT(IN):: cat

        INTEGER, DIMENSION(1:nf_sb) :: ksb 
        INTEGER :: i, icat
        

        icat = INT(cat)

        ksb = no_fuel_cat 

        
        ksb(1:13) = [(i, i=1, 13)]

        IF ( crosswalk ) THEN 

            ksb([101, 104, 107])=1        
            ksb(102)=2                    
            ksb(121:124) = 2              
            ksb([103,105,106,108,109])=3  
            ksb([145, 147])=4             
            ksb(142)=5                    
            ksb([141, 146])=6             
            ksb([143, 144, 148, 149])=7   
            ksb([181, 183, 184, 187])=8   
            ksb([182, 186, 188, 189])=9   
            ksb(161: 165)=10              
            ksb([185, 201])=11            
            ksb(202)=12                   
            ksb([203, 204])=13            

        ELSE 

            ksb(101:109) = [(i, i=15,23)] 
            ksb(121:124) = [(i, i=24,27)] 
            ksb(141:149) = [(i, i=28,36)] 
            ksb(161:165) = [(i, i=37,41)] 
            ksb(181:189) = [(i, i=42,50)] 
            ksb(201:204) = [(i, i=51,54)] 

        ENDIF

        get_fuel_cat = ksb(icat)

    END FUNCTION get_fuel_cat





    ELEMENTAL FUNCTION firebrand_gen_factor(fcat)

        IMPLICIT NONE

        REAL                :: firebrand_gen_factor
        INTEGER, INTENT(IN) :: fcat
        REAL,    DIMENSION(nfuelcats+1) :: factor

        
        
        
        

        
        

        factor(1:nfuelcats+1)=   1.0_dp 
        firebrand_gen_factor = factor(fcat)
        
    END FUNCTION firebrand_gen_factor















        








        








    ELEMENTAL FUNCTION firebrand_gen_potential(fuel_fgi, factor, fire_rate, fuel_mcg)


        
        

        IMPLICIT NONE

        REAL     :: firebrand_gen_potential
        REAL, INTENT(IN) :: factor, fire_rate
        REAL, INTENT(IN) :: fuel_fgi, fuel_mcg 
 
        firebrand_gen_potential = factor * fire_rate * fuel_fgi 

        END FUNCTION firebrand_gen_potential







    SUBROUTINE generate_firebrands( fs_p_id, fs_p_src, fs_p_dt, fs_p_z, fs_p_x, fs_p_y,   & 
                               release_i, release_j, release_k, &
                               release_dt, release_src, &
                               active_br, fs_gen_idmax, myprocid, &
                               release_prop, fs_p_prop)


        IMPLICIT NONE

        TYPE(p_properties), INTENT(IN), DIMENSION(:):: release_prop
        TYPE(p_properties), INTENT(OUT),DIMENSION(:):: fs_p_prop

        INTEGER, INTENT(INOUT), DIMENSION(:)   :: fs_p_id, fs_p_src, fs_p_dt
        REAL,    INTENT(INOUT), DIMENSION(:)   :: fs_p_z, fs_p_x, fs_p_y
        REAL,    INTENT(INOUT), DIMENSION(:)   :: release_i, release_j, release_k
        INTEGER, OPTIONAL, INTENT(IN), DIMENSION(:) :: release_dt, release_src
        INTEGER, INTENT(INOUT)  :: fs_gen_idmax
        INTEGER, INTENT(IN)     :: myprocid
        INTEGER, INTENT(OUT)    :: active_br

        LOGICAL :: release_true
        INTEGER :: br, ii
        REAL    :: rx, ry, rz
        INTEGER :: new_release
        LOGICAL, DIMENSION(fs_array_maxsize) :: flag_true 

        
        release_true = .FALSE.  
        flag_true = .FALSE.     

        active_br = 0           
        new_release = 0         

        
        active_br   = COUNT( fs_p_id > 0 ) 
        new_release = COUNT( (INT(release_i) > 0) .AND. (INT(release_j) > 0) ) 

        IF (new_release > 0 ) release_true = .TRUE. 

        IF ( .NOT. release_true) THEN             
            RETURN 
        ENDIF

        
        
        
        
        IF (active_br + new_release <= fs_array_maxsize) THEN

            
            
            

            
            WHERE(fs_p_id == 0) flag_true = .TRUE. 

            ii = active_br + 1 
            DO br=1, new_release

                
                IF ( .NOT. flag_true(ii) ) THEN 
                    CALL wrf_error_fatal3("<stdin>",711,&
'SPFire_generate_firebrands: Did not find free index to release brands! Did you pack fs_p_x, fs_p_y, fs_p_id, etc?') 
                ENDIF

                
                IF (INT(release_i(br)) == 0 .OR. &
                    INT(release_j(br)) == 0 ) &
                    CALL wrf_error_fatal3("<stdin>",718,&
'SPFire_generate_firebrands: release_ijk is zero! Positions cannot be zero.')

                IF (fs_gen_idmax + 10 >= HUGE(1)) fs_gen_idmax = 0

                
                fs_p_x(ii) = release_i(br)
                fs_p_y(ii) = release_j(br)
                fs_p_z(ii) = release_k(br)
                fs_p_id(ii) = fs_gen_idmax + 1              

                IF (.NOT. PRESENT(release_dt)) fs_p_dt(ii) = 0 
                IF (.NOT. PRESENT(release_src)) fs_p_src(ii) = myprocid + fs_p_id(ii)

                IF (PRESENT(release_dt)) fs_p_dt(ii) = release_dt(br)
                IF (PRESENT(release_src)) fs_p_src(ii) = release_src(br)

                fs_p_prop(ii)%p_mass  = release_prop(br)%p_mass
                fs_p_prop(ii)%p_diam  = release_prop(br)%p_diam
                fs_p_prop(ii)%p_effd = release_prop(br)%p_effd
                fs_p_prop(ii)%p_temp  = release_prop(br)%p_temp 
                fs_p_prop(ii)%p_tvel  = release_prop(br)%p_tvel 

                fs_gen_idmax = fs_p_id(ii)

                flag_true(ii) = .FALSE.
                ii = ii + 1

            ENDDO

            active_br = active_br + new_release
            release_i = ZERO_dp
            release_j = ZERO_dp
            release_k = ZERO_dp









        ENDIF


    END SUBROUTINE generate_firebrands








    PURE &
    FUNCTION hgt2k(xp, yp, hgt, z_at_w, znw)

    
    
    
    

        IMPLICIT NONE
        
        REAL,    INTENT(IN) :: hgt, xp, yp
        REAL,    INTENT(IN), DIMENSION(ims:,:,jms:) :: z_at_w
        REAL,    INTENT(IN), DIMENSION(:)         :: znw

        REAL    :: zdz, z_lower_at_p, z_upper_at_p, x0,y0
        REAL    :: hgt2k 
        INTEGER :: k, i, j

        
        
        
        
        
        
        
        
        

        x0 = xp - dp05
        y0 = yp - dp05

        i = FLOOR(x0) 
        j = FLOOR(y0)

        
        k = MINLOC(hgt - z_at_w(i,:,j), dim=1, &
                   mask=( hgt - z_at_w(i,:,j) >= 0.0_dp )) 

        z_lower_at_p = u_2d_interp(xp=x0, yp=y0, u_i0j0=z_at_w(i,  k,j), u_i0j1=z_at_w(i,  k,j+1),& 
                                                 u_i1j0=z_at_w(i+1,k,j), u_i1j1=z_at_w(i+1,k,j+1))

       z_upper_at_p = u_2d_interp(xp=x0, yp=y0, u_i0j0=z_at_w(i,  k+1,j), u_i0j1=z_at_w(i,  k+1,j+1),& 
                                                 u_i1j0=z_at_w(i+1,k+1,j), u_i1j1=z_at_w(i+1,k+1,j+1))

        zdz = (hgt - z_lower_at_p) / (z_upper_at_p-z_lower_at_p)
        hgt2k    = k + zdz
 
    END FUNCTION hgt2k







    PURE &
    SUBROUTINE releaseijk2atm (nij_2d, sr_x, sr_y, fcat, maxhgt_usr, pi, pj, pk, nij)


        IMPLICIT NONE

        INTEGER, INTENT(IN),  DIMENSION(:,:) :: nij_2d 
        INTEGER, INTENT(IN),  DIMENSION(:,:) :: fcat   
        INTEGER, INTENT(IN)   :: sr_x, sr_y
        REAL,    INTENT(IN)   :: maxhgt_usr

        REAL,    INTENT(INOUT), DIMENSION(:)   :: pj, pi, pk
        INTEGER, INTENT(INOUT), DIMENSION(:)   :: nij

        INTEGER, ALLOCATABLE, DIMENSION(:)   :: fpi,fpj
        INTEGER :: i, j, cnt

        
        
        
        
        
        

        cnt = COUNT(nij_2d > 0)

        pi(:) = ZERO_dp
        pj(:) = ZERO_dp
        pk(:) = ZERO_dp
        nij(:) = 0

        ALLOCATE(fpi(cnt), fpj(cnt))
        fpi(:) = 0
        fpj(:) = 0


        
        

        fpi = PACK(RESHAPE([( [(i, i=ifps, ifpe)], j=jfps, jfpe)], SHAPE(nij_2d)), mask=(nij_2d > 0))
        fpj = PACK(RESHAPE([( [(j, i=ifps, ifpe)], j=jfps, jfpe)], SHAPE(nij_2d)), mask=(nij_2d > 0))
        nij = PACK(nij_2d, mask=(nij_2d > 0))

        
        
        
        pi = fire2atm_ij(fpi, sr_x )
        pj = fire2atm_ij(fpj, sr_y )
        
        
        
        
        
        pk = maxhgt_usr
        

    END SUBROUTINE  releaseijk2atm






    ELEMENTAL FUNCTION fire2atm_ij (fp_ij, sr)






        IMPLICIT NONE

        REAL  :: fire2atm_ij
        INTEGER, INTENT(IN) :: fp_ij
        INTEGER, INTENT(IN) :: sr

        fire2atm_ij = ( dp1+ REAL(fp_ij - dp1)/REAL(sr) )












    END FUNCTION fire2atm_ij






    ELEMENTAL FUNCTION atm2fire_ij (pij, sr)




        IMPLICIT NONE

        INTEGER  :: atm2fire_ij
        INTEGER, INTENT(IN) :: pij
        INTEGER, INTENT(IN) :: sr

        atm2fire_ij = (pij - 1) * sr + 1
        



    END FUNCTION atm2fire_ij


















































































    SUBROUTINE prep_release_hgt(release_i, release_j, release_k, release_n, release_prop, levrand_seed, landhgt)


        
        
        
        

        IMPLICIT NONE

        TYPE(p_properties), INTENT(INOUT),   DIMENSION(:) :: release_prop
        REAL,          INTENT(INOUT), DIMENSION(:) :: release_i, release_j
        REAL,          INTENT(INOUT), DIMENSION(:) :: release_k
        INTEGER,       INTENT(IN),    DIMENSION(:) :: release_n
        INTEGER,       INTENT(IN) :: levrand_seed
        REAL,          INTENT(IN) :: landhgt

        INTEGER :: ii, kk, cnt                   
        INTEGER :: nseeds
        REAL    :: minhgt
        REAL,    ALLOCATABLE, DIMENSION(:) :: rand_arr, frachgt
        INTEGER, ALLOCATABLE, DIMENSION(:) :: seeds

        minhgt = dp1 + landhgt

        
        
        

        ALLOCATE(frachgt(fs_gen_levels))
        ALLOCATE(rand_arr(SIZE(release_n)*fs_gen_levels))

        IF (fs_gen_levels == 1) THEN
            frachgt(:) = dp1
        ELSE
            frachgt(:) = [( REAL(kk-1)*(dp1/REAL(fs_gen_levels-1)), kk=fs_gen_levels, 1, -1)]
        ENDIF

        IF (levrand_seed > 0) THEN

            nseeds = SIZE(rand_arr)
            CALL random_seed(size=nseeds)
            ALLOCATE(seeds(nseeds))
            seeds = [(( release_i(ii) * release_j(ii) * levrand_seed * kk, &
                        kk=1, fs_gen_levels), &
                        ii=1, SIZE(release_n))] 
            CALL random_seed(put = seeds)
            DEALLOCATE(seeds)
            CALL random_number(rand_arr)

        ENDIF


        ii = SIZE(release_n)+1           

        DO kk=2, fs_gen_levels 
        DO cnt=1,SIZE(release_n)         

                
                
                

                release_i(ii) = release_i(cnt)    
                release_j(ii) = release_j(cnt)
                IF (release_k(cnt) >= minhgt) THEN
                   release_k(ii) = ((release_k(cnt)-minhgt) * frachgt(kk)) + minhgt 
                
                IF (levrand_seed > 0) & 
                        release_k(ii) = ((release_k(cnt)-minhgt) * rand_arr(ii)) + minhgt
                ELSE
                   release_k(ii) = ((release_k(cnt)-dp1) * frachgt(kk)) + dp1 
                   IF (levrand_seed > 0) & 
                        release_k(ii) = ((release_k(cnt)-dp1) * rand_arr(ii)) + dp1
                ENDIF


                release_prop(ii)  = release_prop(cnt)

                

                

                

                ii = ii + 1 

            ENDDO
        ENDDO

        

    END SUBROUTINE prep_release_hgt






    FUNCTION firebrand_property(arr) RESULT(prop)


        IMPLICIT NONE

        TYPE (p_properties) :: prop
        REAL, INTENT(IN),  DIMENSION(:) :: arr
        REAL, PARAMETER :: pi    = 4.0_dp * ATAN (1.0_dp)
        
        prop%p_diam  = arr(1)   
        prop%p_effd  = arr(2)   
        prop%p_temp  = arr(3)   
        
        prop%p_tvel  = arr(4)   
        prop%p_mass  =  (firebrand_dens * pi * (prop%p_effd/1000.0_dp)**2)/6.0_dp  
 
    END FUNCTION firebrand_property







    FUNCTION idx_packed_1d(mask) RESULT(mask_idx)


        
        IMPLICIT NONE
        LOGICAL,  INTENT(IN),  DIMENSION(:) :: mask
        
        INTEGER, ALLOCATABLE, DIMENSION(:) :: mask_idx
        INTEGER :: nresets, ii

        nresets = COUNT(mask)
        ALLOCATE(mask_idx(nresets))
        mask_idx = PACK([(ii, ii=1,SIZE(mask))], mask)   

    END FUNCTION idx_packed_1d







    PURE &
    SUBROUTINE firebrand_physics(dt, hgt, loc_p, loc_t, loc_d, loc_w, fbprop)


        IMPLICIT NONE

        TYPE(p_properties), INTENT(INOUT) :: fbprop
        REAL, INTENT(IN)    :: loc_p, loc_t, loc_d, loc_w  
        REAL, INTENT(IN)    :: dt
        REAL, INTENT(INOUT) :: hgt
        

        
        
        


        

        
        CALL burnout(p_mass  = fbprop%p_mass,   & 
                     p_diam  = fbprop%p_diam,   & 
                     p_effd  = fbprop%p_effd,   & 
                     p_temp  = fbprop%p_temp,   & 
                     p_tvel  = fbprop%p_tvel,   & 
                     aird    = loc_d,    & 
                     pres    = loc_p,    & 
                     temp    = loc_t,    & 
                     loc_w   = loc_w,    & 
                     dt      = dt)





        
        
        

        CALL termvel(p_diam  = fbprop%p_diam, &
                     p_effd  = fbprop%p_effd,&
                     p_temp  = fbprop%p_temp, &
                     p_tvel  = fbprop%p_tvel, &
                     aird    = loc_d,  & 
                     pres    = loc_p,  & 
                     temp    = loc_t,  & 
                     dt      = dt,     & 
                     hgt     = hgt)      


        


        
        
        
        
        

    END SUBROUTINE firebrand_physics







     ELEMENTAL SUBROUTINE burnout(pres, aird, temp, loc_w, dt, p_mass, p_diam, p_effd, p_temp, p_tvel)










        IMPLICIT NONE

        REAL,         INTENT(IN)    :: pres, aird, temp, loc_w, dt
        REAL,         INTENT(INOUT) :: p_mass    
        REAL,         INTENT(INOUT) :: p_diam    
        REAL,         INTENT(INOUT) :: p_effd   
        REAL,         INTENT(INOUT) :: p_temp    
        REAL,         INTENT(IN)    :: p_tvel    

        
        
        

        REAL, PARAMETER :: pi    = 4.0_dp * ATAN (1.0_dp)

        REAL :: aird2, wind, gama
        REAL :: pdia, pedia
        REAL :: p_effd2, pdia_new4, reyn, beta, deff, dmvc, dmvc2
        REAL :: parta, partb, dtemp, nuss, hbar, fbvol, qcon, qrad, partc
        REAL :: pratio, cpmix

        p_mass = MAX(p_mass, EPSILON(dp1))
        
        
        
        aird2 = 1000.0_dp * pres / ( rd * p_temp )

        
        
        wind = ABS(loc_w - p_tvel)

        
        pdia = p_diam / 1000.0_dp

        
        pedia = p_effd / 1000.0_dp


        dmvc = (b_coeff * temp**1.5_dp) / (temp + s_coeff)


        dmvc2 = (b_coeff * p_temp**1.5_dp) / (p_temp + s_coeff)

        
        gama = ((dmvc / aird) + (dmvc2 / aird2))/2.0_dp

        
        reyn = wind * pdia / gama

        
        nuss = 2.0_dp + 0.6_dp * reyn**(dp05) * pr**(r1o3)

        
        hbar = nuss * thcon / pdia

        
        beta = beta0 + beta0 * (0.276_dp * reyn**(dp05) * shmt**(r1o3))


        
        


        
        parta = pdia**4 
        partb = SQRT(3.0_dp) * (beta**2) * (dt**2)
        pdia_new4 = parta - partb
        p_diam = pdia_new4**(0.25_dp)

        
        p_effd2 = (pedia**2) - beta * dt
        p_effd = SQRT(p_effd2)

        
        p_mass = (firebrand_dens * pi * p_effd2 * p_effd)/6.0_dp

        
        fbvol = p_mass / firebrand_dens

        
        qcon = hbar * (p_temp - temp)
        qrad = sboltz * emiss * (p_temp**4 - temp**4)
        pratio = p_effd / p_diam
        cpmix = (pratio * cpw) + ((1.0_dp - pratio) * cpc)
        partc = 6.0_dp / (p_mass * cpmix * p_diam)
        dtemp = dt * fbvol * partc * (qcon + qrad)
        p_temp = p_temp - dtemp






        
        p_diam = 1000.0_dp * p_diam
        p_effd = 1000.0_dp * p_effd

    END SUBROUTINE burnout







    ELEMENTAL  &
    SUBROUTINE termvel(p_diam, p_effd, p_tvel, p_temp, hgt, dt, pres, aird, temp)








        
 
        IMPLICIT NONE

        REAL, INTENT(IN) :: pres, aird, temp, dt
        REAL, INTENT(IN) :: p_diam    
        REAL, INTENT(IN) :: p_effd    
        REAL, INTENT(IN) :: p_temp    
        REAL, INTENT(INOUT):: hgt     
        REAL, INTENT(INOUT):: p_tvel  

        REAL    :: pbot, ptop, aird2, pdia, parta, partb
        REAL    :: drop, vt, pratio 

        

        
        aird2 = 1000.0_dp * pres / (rd * p_temp)

        
        pdia = p_diam /1000.0_dp
 
        
        pratio = p_effd / p_diam
        parta = ( (pratio*firebrand_dens) + ( (dp1-pratio) * firebrand_dens_char) ) *pdia*grav
        partb = 3.0_dp * ((aird + aird2) / 2.0_dp)*rcd

        pratio = MAX( MIN(HUGE(1.0),(parta / partb)), TINY(1.0)) 




        vt = SQRT(pratio) 
        
        
        drop = vt * ABS(dt)
        pbot = MAX(0.0_dp, hgt-drop)
        hgt  = pbot

        p_tvel=vt

    END SUBROUTINE termvel






    PURE  &
    SUBROUTINE get_local_met(xp, yp, zp, loc_p, loc_d, loc_t, p, t, d, ihs, jhs, ihe, jhe)


        
        
        
        
        

        

        IMPLICIT NONE

        
        INTEGER, INTENT(IN)  :: ihs, jhs, ihe, jhe  
        REAL,    INTENT(IN)  :: xp, yp, zp          
        REAL,    INTENT(OUT) :: loc_p, loc_t, loc_d 
        REAL,    INTENT(IN), DIMENSION(ims:,kms:,jms:):: p,t,d

        INTEGER :: i, j, k , kk
        REAL :: tmp1, tmp2, zph 

        k = FLOOR(zp)
        j = MIN(MAX(FLOOR(yp-dp05), jhs), jhe)
        i = MIN(MAX(FLOOR(xp-dp05), ihs), ihe)

        
        
        
        
        

        

        
        loc_p = u_3d_interp( x=xp-dp05, y=yp-dp05, z=zp, &
            u_i0j0_bot = p(i,  k, j),   u_i0j1_bot = p(i,  k, j+1),&
            u_i1j0_bot = p(i+1,k, j),   u_i1j1_bot = p(i+1,k, j+1),&
            u_i0j0_top = p(i,  k+1, j), u_i0j1_top = p(i,  k+1,j+1),&
            u_i1j0_top = p(i+1,k+1, j), u_i1j1_top = p(i+1,k+1,j+1))

        
        loc_t = u_3d_interp( x=xp-dp05, y=yp-dp05, z=zp, &
            u_i0j0_bot = t(i,  k, j),   u_i0j1_bot = t(i,  k, j+1),&
            u_i1j0_bot = t(i+1,k, j),   u_i1j1_bot = t(i+1,k, j+1),&
            u_i0j0_top = t(i,  k+1, j), u_i0j1_top = t(i,  k+1,j+1),&
            u_i1j0_top = t(i+1,k+1, j), u_i1j1_top = t(i+1,k+1,j+1))

        
        

        
        
        
        
        

        

        zph = zp - dp05
        k = MAX(1, FLOOR(zph))

        loc_d = u_3d_interp( x=xp-dp05, y=yp-dp05, z=zph, &
            u_i0j0_bot = d(i,  k, j),   u_i0j1_bot = d(i,  k, j+1),&
            u_i1j0_bot = d(i+1,k, j),   u_i1j1_bot = d(i+1,k, j+1),&
            u_i0j0_top = d(i,  k+1, j), u_i0j1_top = d(i,  k+1,j+1),&
            u_i1j0_top = d(i+1,k+1, j), u_i1j1_top = d(i+1,k+1,j+1))

        loc_d = loc_d * 1000.0_dp  

        
    END SUBROUTINE get_local_met








    SUBROUTINE firebrand_spotting_em_driver( &     

        cf,                    &
        grid,                  &
        fs_p_id,               &
        fs_p_src,              &
        fs_p_dt,               &
        fs_p_x,                &
        fs_p_y,                &
        fs_p_z,                &
        fs_gen_inst,           &
        fs_p_mass,             &  
        fs_p_diam,             & 
        fs_p_effd,             & 
        fs_p_temp,             & 
        fs_p_tvel,             & 
        fs_last_gen_dt,        &
        fs_gen_idmax,          &
        fs_fire_ROSdt,         &
        fs_fire_area,          &
        fs_count_landed_all,   &
        fs_count_landed_hist,  &
        fs_landing_mask,       &
        fs_spotting_lkhd,      &
        fs_frac_landed,        &
        fs_fuel_spotting_risk, &
        fs_count_reset)


        
        
        

        USE module_domain,            ONLY: domain_get_time_since_sim_start, &
                                            domain_clock_get, is_alarm_tstep
        USE module_domain_type,       ONLY: HISTORY_ALARM, restart_alarm, AUXHIST23_ALARM
        USE module_state_description, ONLY: p_qv, num_moist, param_first_scalar
        USE module_utility,           ONLY: WRFU_Alarm 
        USE module_firebrand_spotting_mpi,  ONLY: fs_mpi_init, &
                                            fs_mpi_sendbuff1_int,      &
                                            fs_mpi_sendbuff1_real,     &
                                            fs_mpi_recvbuff1_int,      &
                                            fs_mpi_recvbuff1_real,     &
                                            fs_mpi_nothing2send,       &
                                            fs_mpi_send2neighbors,     &
                                            fs_mpi_sendbuffsize,       &
                                            fs_mpi_sendbuff_int,       &
                                            fs_mpi_sendbuff_real,      &
                                            fs_mpi_recvbuffsize,       &
                                            fs_mpi_recvfrompatch_int,  &
                                            fs_mpi_recvfrompatch_real, &
                                            fs_mpi_sendbuff_real,      &
                                            fs_mpi_checkreceive,       &
                                            fs_mpi_recv
        USE module_firebrand_spotting_mpi,  ONLY: neighbors, my_id, task_id, mpiprocs,  &
                                            left_id, right_id, up_id, down_id, &
                                            upleft_id, upright_id, downleft_id, downright_id


        IMPLICIT NONE
        LOGICAL, EXTERNAL :: wrf_dm_on_monitor
        
        
        

        TYPE(domain),               INTENT(IN)    :: grid 
        TYPE (GRID_config_rec_type),INTENT(IN)    :: cf   

        
        
        

        LOGICAL, INTENT(INOUT)  :: fs_count_reset
        INTEGER, INTENT(INOUT)  :: fs_last_gen_dt, fs_gen_idmax

        
        INTEGER, INTENT(INOUT), DIMENSION(:)    :: fs_p_id, fs_p_src, fs_p_dt
        REAL,    INTENT(INOUT), DIMENSION(:)    :: fs_p_x, fs_p_y, fs_p_z 
        REAL,    INTENT(INOUT), DIMENSION(:)    :: fs_p_mass, fs_p_diam, fs_p_effd
        REAL,    INTENT(INOUT), DIMENSION(:)    :: fs_p_temp, fs_p_tvel
        REAL,    INTENT(INOUT), DIMENSION(ims:ime,jms:jme) :: fs_count_landed_all, fs_fire_area, fs_fuel_spotting_risk    
        REAL,    INTENT(INOUT), DIMENSION(ims:ime,jms:jme) :: fs_count_landed_hist, fs_spotting_lkhd, fs_frac_landed
        INTEGER, INTENT(INOUT), DIMENSION(ims:ime,jms:jme) :: fs_landing_mask, fs_gen_inst
        REAL,    INTENT(INOUT), DIMENSION(ifps:ifpe,jfps:jfpe)  :: fs_fire_ROSdt

        
        
        

        
        
        

        
        LOGICAL, DIMENSION(fs_array_maxsize) :: sparse_mask

        TYPE(p_properties), DIMENSION(fs_array_maxsize)   :: fs_p_prop

        
        REAL, DIMENSION(ims:ime, ks:ke, jms:jme):: w, z, p_hyd, dz8w, z_at_w 
        REAL, DIMENSION(ims:ime, ks:ke, jms:jme):: u, v, rho, th_phy         
        REAL, DIMENSION(ims:ime, ks:ke, jms:jme):: qtot, th8w, p_phy, p8w    
        REAL, DIMENSION(ims:ime, jms:jme)       :: msft, w1
        REAL, DIMENSION(ks:ke)                  :: znw
        REAL, ALLOCATABLE, DIMENSION(:)         :: xout, yout, zout 

        
        
        

        REAL,    ALLOCATABLE, DIMENSION(:,:) :: fuel_spotting_risk_fr, spotthreat_fr 

        
        LOGICAL, ALLOCATABLE, DIMENSION(:,:) :: landing_mask
        INTEGER, ALLOCATABLE, DIMENSION(:)   :: landing_cnt
        INTEGER, ALLOCATABLE, DIMENSION(:)   :: np_landed_cnt, np_nlanded  
        REAL,    ALLOCATABLE, DIMENSION(:)   :: np_landed_risk, np_frac_landed, np_lkhd 
        REAL,    ALLOCATABLE, DIMENSION(:)   :: landed_risk, recv_spot_lkhd, recv_frac_landed
        REAL,    ALLOCATABLE, DIMENSION(:)   :: tmp1
        INTEGER :: ndep, ndep_total
        

        REAL, DIMENSION(ims:ime, jms:jme) :: dt_sum_landed 
        LOGICAL, SAVE :: hist_flag = .FALSE.  

        
        
        

        INTEGER, ALLOCATABLE, DIMENSION(:)    :: np_Ngrdpts, loc_ij 
        REAL,    ALLOCATABLE, DIMENSION(:)    :: np_MeanPot 
        REAL,    ALLOCATABLE, DIMENSION(:,:)  :: RelPot, fcat_factor, fr_rate_dummy
        INTEGER, ALLOCATABLE, DIMENSION(:,:)  :: fcat_fr, n_rel_fr2d
        LOGICAL, ALLOCATABLE, DIMENSION(:,:)  :: rel_mask

        INTEGER :: Ngrdpts, Npts_total, relpts, rankpts 
        REAL    :: TotPot, MeanPot, PotThr, rel_ratio, cdf_coeff, LimPot

        
        TYPE(p_properties), ALLOCATABLE, DIMENSION(:)   :: release_prop
        REAL,          ALLOCATABLE, DIMENSION(:)   :: release_i, release_j, release_k
        INTEGER,       ALLOCATABLE, DIMENSION(:)   :: release_n

        
        
        

        
        

        INTEGER :: kk, pp, ii 
        INTEGER :: kk1, kk2, k_end
        INTEGER :: active_br, prior_br, nresets, idmax, firepts, nbr_sum
        REAL    :: rdx, rdy, dt, sr_xy 

        INTEGER :: firebrand_max_life_dt
        REAL    :: firebrand_land_hgt, firebrand_gen_maxhgt
        LOGICAL :: firebrand_gen_levrand
        REAL    :: firebrand_gen_prop_diam, firebrand_gen_prop_effd
        REAL    :: firebrand_gen_prop_temp, firebrand_gen_prop_tvel 
        INTEGER :: levrand_seed

        
        
        

        INTEGER, SAVE :: MasterId = 0
        INTEGER, SAVE :: ntiles = 0
        INTEGER, SAVE :: myprocid = 0
        LOGICAL, SAVE :: IamMaster = .FALSE. 

        INTEGER, ALLOCATABLE, DIMENSION(:) :: nbr_id, r_id, r_dt, r_src
        REAL,    ALLOCATABLE, DIMENSION(:) :: r_x, r_y, r_z

        
        REAL, ALLOCATABLE, DIMENSION(:) :: r_p_m,r_p_d,r_p_e,r_p_t,r_p_v
        TYPE(p_properties), ALLOCATABLE, DIMENSION(:) :: fb_mdetv


        
        
        

        REAL,  DIMENSION(ifps:ifpe,jfps:jfpe)  :: fmcg_2df        

        
        
        


        IF (mpiprocs == 0) & 
            CALL fs_mpi_init(grid) 

        ntiles = mpiprocs
        myprocid = my_id * 1000000
        IF ( wrf_dm_on_monitor() ) THEN 
            IamMaster = .TRUE. 
            MasterId = my_id
        ENDIF

        hist_flag = .FALSE. 
        IF ( Is_alarm_tstep(grid%domain_clock, grid%alarms(HISTORY_ALARM)) ) hist_flag = .TRUE. 
        
        IF (hist_flag) &
            CALL wrf_debug (wrfdbg, 'SPFire_driver: History output on next tstep')

        fs_last_gen_dt = fs_last_gen_dt + 1
        active_br = COUNT( fs_p_id > 0 )

        IF (grid%itimestep == 1) &
            fs_fire_ROSdt(ifps:ifpe,jfps:jfpe) =0.0_dp

        
        
        

        IF (fs_count_reset) THEN 

            fs_count_landed_hist(:,:)  = ZERO_dp
            fs_fuel_spotting_risk(:,:) = ZERO_dp
            fs_count_reset      = .FALSE.

            fs_gen_inst(is:ie,js:je) = 0
        ENDIF

        fs_landing_mask(ims:ime,jms:jme) = 0

        
        
        

        fs_p_prop%p_mass  = ZERO_dp
        fs_p_prop%p_diam  = ZERO_dp
        fs_p_prop%p_effd  = ZERO_dp
        fs_p_prop%p_temp  = ZERO_dp
        fs_p_prop%p_tvel  = ZERO_dp

        fs_p_prop(:active_br)%p_mass  = fs_p_mass(:active_br)
        fs_p_prop(:active_br)%p_diam  = fs_p_diam(:active_br)
        fs_p_prop(:active_br)%p_effd  = fs_p_effd(:active_br)
        fs_p_prop(:active_br)%p_temp  = fs_p_temp(:active_br) 
        fs_p_prop(:active_br)%p_tvel  = fs_p_tvel(:active_br) 

        
        
        

        firebrand_max_life_dt = cf%fs_firebrand_max_life_dt
        firebrand_land_hgt = cf%fs_firebrand_land_hgt
        firebrand_gen_maxhgt  = cf%fs_firebrand_gen_maxhgt
        firebrand_gen_levrand = cf%fs_firebrand_gen_levrand

        firebrand_gen_prop_diam = cf%fs_firebrand_gen_prop_diam
        firebrand_gen_prop_effd = cf%fs_firebrand_gen_prop_effd
        firebrand_gen_prop_temp = cf%fs_firebrand_gen_prop_temp
        firebrand_gen_prop_tvel = cf%fs_firebrand_gen_prop_tvel
        
        firebrand_dens      = cf%fs_firebrand_dens      
        firebrand_dens_char = cf%fs_firebrand_dens_char 

        
        
        

        
        
        

        firepts = 0
        
        fs_fire_ROSdt(ifps:ifpe, jfps:jfpe) = grid%burnt_area_dt(ifps:ifpe,jfps:jfpe)
        

        
        
        

        fmcg_2df(ifps:ifpe,jfps:jfpe) = grid%fmc_g(ifps:ifpe,jfps:jfpe)

        
        
        

        
        
        

        IF (fs_last_gen_dt >= fs_gen_dt) THEN  

            firepts = COUNT(fs_fire_ROSdt(ifps:ifpe,jfps:jfpe) > ZERO_dp)
            Ngrdpts = 0 

            LimPot = 0.000001_dp 
            MeanPot = ZERO_dp 

            IF (firepts > 0) THEN 




                
                
                

                ALLOCATE(fcat_fr(ifps:ifpe,jfps:jfpe), fcat_factor(ifps:ifpe,jfps:jfpe), RelPot(ifps:ifpe,jfps:jfpe))
                fcat_fr(:,:)  = 0
                RelPot(:,:) = ZERO_dp
                fcat_factor(:,:) = ZERO_dp

                fcat_fr(ifps:ifpe,jfps:jfpe) = RESHAPE(get_fuel_cat(crosswalk=grid%fuel_crosswalk, &
                                                                    cat=grid%nfuel_cat(ifps:ifpe,jfps:jfpe)), &
                                                       SHAPE(fcat_fr))

                fcat_factor(ifps:ifpe,jfps:jfpe)= firebrand_gen_factor(fcat_fr(ifps:ifpe,jfps:jfpe)) 

                RelPot(ifps:ifpe,jfps:jfpe) = RESHAPE(firebrand_gen_potential(&
                                                             fuel_fgi=grid%fgip(ifps:ifpe,jfps:jfpe), &
                                                             fuel_mcg=fmcg_2df(ifps:ifpe,jfps:jfpe), & 
                                                             
                                                             factor=fcat_factor(ifps:ifpe,jfps:jfpe),&
                                                             fire_rate=fs_fire_ROSdt(ifps:ifpe,jfps:jfpe)), &
                                                         SHAPE(fcat_fr)) 

                
                

                Ngrdpts= COUNT(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)

                
                
                
                IF (Ngrdpts > fs_gen_lim) THEN
                    LimPot = 10.0_dp * LimPot 
                    Ngrdpts= COUNT(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)

                    IF (Ngrdpts > fs_gen_lim) THEN
                        LimPot = 10.0_dp * LimPot 
                        Ngrdpts= COUNT(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)

                    ENDIF
                ENDIF




                WRITE (msg,'(1(i6,1x))') Ngrdpts
                CALL wrf_debug (wrfdbg, 'SPFire_rel Ngrdpts: '//msg)

                
                
                IF (Ngrdpts > fs_gen_lim) THEN

                    
                    

                    ALLOCATE(tmp1(Ngrdpts))
                    tmp1(1:Ngrdpts) = PACK(RelPot(ifps:ifpe,jfps:jfpe), &
                                mask=(RelPot(ifps:ifpe,jfps:jfpe) > LimPot))

                    
                    LimPot = order_val(tmp1, ORD=fs_gen_lim)
                    
                    DEALLOCATE(tmp1)




                    
                    

                    ALLOCATE(tmp1(COUNT(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)))
                    tmp1 = PACK(RelPot(ifps:ifpe,jfps:jfpe), &
                                mask=(RelPot(ifps:ifpe,jfps:jfpe) > LimPot))

                    MeanPot = order_val(tmp1, ORD=INT(REAL(SIZE(tmp1))/2.0))
                    
                    DEALLOCATE(tmp1)


                    
                    


                    Ngrdpts= COUNT(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)

                
                    
                ELSEIF (Ngrdpts > 0) THEN

                    
                    
                    MeanPot = order_val(PACK(RelPot(ifps:ifpe,jfps:jfpe), &
                                      mask=(RelPot(ifps:ifpe,jfps:jfpe) > LimPot)), &
                                      ORD=INT(dp05*Ngrdpts))




                ENDIF

                
                

                IF (Ngrdpts == 0) firepts = 0

                

            ENDIF 
            

            IF (.NOT. (IamMaster)) THEN


                
                CALL fs_mpi_sendbuff1_int(sendto=MasterId, nbr=Ngrdpts) 

                IF (Ngrdpts > 0) THEN
                    CALL fs_mpi_sendbuff1_real(sendto=MasterId, nbr=MeanPot) 


                ENDIF
            ENDIF

            
            
            

            
            
            

            IF (IamMaster) THEN                      

                CALL wrf_debug (wrfdbg, 'SPFire_rel_master --------------------------------------------------- ')                    
                
                

                Npts_total = 0
                PotThr = ZERO_dp 
                TotPot = ZERO_dp
                rel_ratio = ZERO_dp
                cdf_coeff = ZERO_dp

                
                ALLOCATE(np_Ngrdpts(ntiles)) 
                ALLOCATE(np_MeanPot(ntiles)) 
                np_MeanPot(:) = ZERO_dp
                np_Ngrdpts(:) = 0

                np_Ngrdpts(1) = Ngrdpts 
                np_MeanPot(1) = MeanPot

                
                


                DO kk=2, mpiprocs 
                    np_Ngrdpts(kk) = fs_mpi_recvbuff1_int(fromid=kk-1)  

                    IF (np_Ngrdpts(kk) > 0) THEN 
                        np_MeanPot(kk) = fs_mpi_recvbuff1_real(fromid=kk-1)


                    ENDIF
                ENDDO

                DO kk=1, ntiles 
                   TotPot = np_MeanPot(kk) * REAL(np_Ngrdpts(kk)) + TotPot 
                ENDDO

                
                

                Npts_total = SUM( np_Ngrdpts )
                IF ( Npts_total > 0) THEN 

                    TotPot = TotPot/(REAL(Npts_total))

                    
                    

                    
                    IF (Npts_total <= fs_gen_lim) THEN
                        PotThr = ZERO_dp 

                    
                    ELSE 
                        rel_ratio = REAL(fs_gen_lim)/(REAL(Npts_total))
                        cdf_coeff = (dp1 - rel_ratio)/rel_ratio
                        PotThr = cdf_coeff * TotPot
                    ENDIF




                    
                    


                    DO kk=2, mpiprocs 
                        IF (np_Ngrdpts(kk) > 0) THEN
                            CALL fs_mpi_sendbuff1_real(sendto=kk-1, nbr=PotThr)


                        ENDIF
                    ENDDO
                ENDIF 
                

            ENDIF 

            

            
            
            

            IF (Ngrdpts > 0) THEN

                
                

                IF (.NOT.(IamMaster)) THEN
                    PotThr = ZERO_dp 
                    PotThr = fs_mpi_recvbuff1_real(fromid=MasterId) 


                ENDIF

                
                



                ALLOCATE(n_rel_fr2d(ifps:ifpe, jfps:jfpe))
                n_rel_fr2d(ifps:ifpe, jfps:jfpe) = 0

                IF (PotThr > ZERO_dp) &
                    n_rel_fr2d(ifps:ifpe,jfps:jfpe) = n_rel_fr2d(ifps:ifpe,jfps:jfpe)  + &
                                                      UNPACK(SPREAD(1, DIM=1, NCOPIES=Ngrdpts), &
                                                                    mask=(RelPot(ifps:ifpe,jfps:jfpe) >= PotThr), FIELD=0)

                IF (PotThr == ZERO_dp) &
                    n_rel_fr2d(ifps:ifpe,jfps:jfpe) = n_rel_fr2d(ifps:ifpe,jfps:jfpe)  + &
                                                      UNPACK(SPREAD(1, DIM=1, NCOPIES=Ngrdpts), &
                                                                    mask=(fs_fire_ROSdt(ifps:ifpe,jfps:jfpe) > ZERO_dp), FIELD=0)

                
                

                relpts = COUNT(n_rel_fr2d(ifps:ifpe,jfps:jfpe)>0) 

                WRITE(msg, '(1(i8,1x))') relpts
                CALL wrf_debug (wrfdbg, 'SPFire_rel2fr relpts: '//msg)

                
                

                ALLOCATE(release_i(relpts*fs_gen_levels), &
                         release_j(relpts*fs_gen_levels), &
                         release_k(relpts*fs_gen_levels), &
                         release_n(relpts))

                release_i(:)  = 0.0_dp
                release_j(:)  = 0.0_dp
                release_k(:)  = 0.0_dp
                release_n(:)  = 0

                
                CALL releaseijk2atm(nij_2d=n_rel_fr2d(ifps:ifpe,jfps:jfpe), &
                                    fcat=fcat_fr(ifps:ifpe,jfps:jfpe), &
                                    maxhgt_usr = firebrand_gen_maxhgt, &
                                    sr_x=grid%sr_x, sr_y=grid%sr_y, &
                                    pi=release_i(1:relpts), &
                                    pj=release_j(1:relpts), &
                                    pk=release_k(1:relpts), & 
                                    nij=release_n)


                
                release_i(1:relpts) = release_i(1:relpts) + dp05/grid%sr_x
                release_j(1:relpts) = release_j(1:relpts) + dp05/grid%sr_y

                DO kk=1,relpts 

                    fs_gen_inst(INT(release_i(kk)),INT(release_j(kk))) = &
                        fs_gen_inst(INT(release_i(kk)),INT(release_j(kk))) + 1

                ENDDO
            
                CALL wrf_debug (wrfdbg, 'SPFire_rel2fr prep_release_hgt ---------------------------------------------')
                ALLOCATE(release_prop(relpts*fs_gen_levels))

                
                release_prop(1:relpts) = firebrand_property([firebrand_gen_prop_diam, &
                                                             firebrand_gen_prop_effd, &
                                                             firebrand_gen_prop_temp, &
                                                             firebrand_gen_prop_tvel])
                
                levrand_seed = 0 
                IF (firebrand_gen_levrand) levrand_seed = cf%fs_firebrand_gen_levrand_seed + 1 
                
                CALL prep_release_hgt( &
                                  release_i = release_i, &
                                  release_j = release_j, &
                                  release_k = release_k, & 
                                  release_n = release_n, &
                                  landhgt = firebrand_land_hgt, &
                                  release_prop=release_prop, &
                                  levrand_seed = levrand_seed * grid%itimestep) 

                prior_br = active_br
                idmax = fs_gen_idmax
            
                CALL wrf_debug (wrfdbg, 'SPFire_driver_call_generate_firebrands ----------------------------------------- ') 

                IF (active_br + COUNT( INT(release_i) > 0 )  > fs_array_maxsize) & 
                    CALL wrf_debug (wrfdbg, 'SPFire_driver_release: brand array is full, cannot release new brands') 
                
                CALL generate_firebrands(&
                    fs_p_id = fs_p_id, &
                    fs_p_src = fs_p_src, &
                    fs_p_dt = fs_p_dt, &
                    fs_p_z  = fs_p_z,  &
                    fs_p_x  = fs_p_x,  &
                    fs_p_y  = fs_p_y,  &
                    fs_p_prop   = fs_p_prop,    &
                    fs_gen_idmax= fs_gen_idmax, &
                    myprocid = myprocid,        &
                    release_prop= release_prop, &
                    release_i = release_i, &
                    release_j = release_j, &
                    release_k = release_k, &
                    active_br = active_br)

                
                
                

                WRITE (msg,'(i8)') active_br
                CALL wrf_debug (wrfdbg, 'SPFire_driver: Active brands: '// msg )

                IF (cf%trackember) THEN
                
                   DO kk=prior_br+1,active_br
                      WRITE (msg,'(3(i8,1x),i10,1x,8(f12.6,1x))') &
                           kk, fs_p_id(kk), fs_p_dt(kk),fs_p_src(kk), &
                           fs_p_x(kk), fs_p_y(kk), fs_p_z(kk), &
                           fs_p_mass(kk), fs_p_diam(kk), fs_p_effd(kk), &
                           fs_p_temp(kk), fs_p_tvel(kk)
                      CALL wrf_debug (0, 'SPFire p,id,dt,src,x,y,z,m,d,e,t,v: '//msg)
                   ENDDO
                ENDIF
                

                IF (active_br /= COUNT( fs_p_id > 0 ) ) CALL wrf_error_fatal3("<stdin>",2144,&
'SPFire_driver: Active brands do not match!')

            ENDIF 

            fs_fire_ROSdt(:, :) = ZERO_dp
            relpts = 0
            fs_last_gen_dt = 0 
            IF( ALLOCATED(fcat_fr))     DEALLOCATE(fcat_fr)
            IF( ALLOCATED(fcat_factor)) DEALLOCATE(fcat_factor)
            IF( ALLOCATED(RelPot))      DEALLOCATE(RelPot)
            IF( ALLOCATED(np_Ngrdpts))  DEALLOCATE(np_Ngrdpts)
            IF( ALLOCATED(np_MeanPot))  DEALLOCATE(np_MeanPot) 
            IF( ALLOCATED(n_rel_fr2d))  DEALLOCATE(n_rel_fr2d)
            IF( ALLOCATED(release_prop)) DEALLOCATE(release_prop)
        
        ENDIF 

        
        
        

        
        
        

        IF ((active_br == 0))  THEN

            CALL fs_mpi_nothing2send(sendto=left_id)
            CALL fs_mpi_nothing2send(sendto=right_id)
            CALL fs_mpi_nothing2send(sendto=up_id)
            CALL fs_mpi_nothing2send(sendto=down_id)

            CALL fs_mpi_nothing2send(sendto=upleft_id)
            CALL fs_mpi_nothing2send(sendto=upright_id)
            CALL fs_mpi_nothing2send(sendto=downleft_id)
            CALL fs_mpi_nothing2send(sendto=downright_id)


        ENDIF
        
        



        
        
        

        IF (active_br > 0) THEN 

            
            
            
            
            
            

            
            
            

            
            
            

            

            
            k_end = MIN( ke, kde-1 )
            ks = 1

            p_phy(ims:, ks:, jms:) = ZERO_dp
            th_phy(ims:, ks:, jms:) = ZERO_dp


            p_phy(ims:, ks:k_end, jms:) = grid%p(ims:ime,ks:k_end,jms:jme) + grid%pb(ims:ime,ks:k_end,jms:jme)
            th_phy(ims:, ks:, jms:) = grid%t_2(ims:ime,ks:k_end,jms:jme) + t0 

            
            
            IF ( ( grid%use_theta_m == 1 ) .AND. (P_Qv >= PARAM_FIRST_SCALAR) ) &
                th_phy = th_phy/(dp1 + Rv/Rd * grid%moist(ims:ime,ks:k_end,jms:jme,P_QV))
            
            
            z_at_w(ims:,ks:,jms:)= (grid%phb(ims:ime,ks:ke,jms:jme) + grid%ph_2(ims:ime,ks:ke,jms:jme))/grav 

            u(ims:, ks:, jms:) = grid%u_2(ims:ime,ks:ke,jms:jme) 
            v(ims:, ks:, jms:) = grid%v_2(ims:ime,ks:ke,jms:jme)             
            w(ims:, ks:, jms:) = grid%w_2(ims:ime,ks:ke,jms:jme) 

            msft(ims:,   jms:) = grid%msftx(ims:ime,    jms:jme) 

            znw = grid%znw
            DT  = grid%dt
            rdx = grid%rdx 
            rdy = grid%rdy
            
            
            

            p_hyd(ims:, ks:, jms:) = ZERO_dp
            dz8w(ims:, ks:, jms:) = ZERO_dp
            th8w(ims:, ks:, jms:) = ZERO_dp
            p8w(ims:, ks:, jms:) = ZERO_dp
            qtot(ims:, ks:, jms:) = ZERO_dp
            rho(ims:, ks:, jms:) = ZERO_dp
            z(ims:, ks:, jms:) = ZERO_dp

            dz8w(ims:,ks:ke-1,jms:) = z_at_w(:,2:,:)-z_at_w(:,:ke-1,:) 
            z(ims:,ks:ke-1,jms:) = dp05 * (z_at_w(:,2:,:) + z_at_w(:,:ke-1,:) )

            qtot(ims:, ks:k_end, jms:) = SUM(grid%moist(ims:ime,ks:k_end,jms:jme,PARAM_FIRST_SCALAR:num_moist),DIM=4)
            p_hyd(ims:, ke, jms:) = grid%p_top
            DO kk = ke-1, ks, -1
                p_hyd(:,kk,:) = p_hyd(:,kk+1,:) - &
                    (dp1 + qtot(:,kk,:)) * (grid%c1h(kk) * grid%muts(:,:) + grid%c2h(kk)) * grid%dnw(kk)
            ENDDO

            rho(ims:,ks:k_end,jms:) = (dp1/&
                                        (grid%al(ims:ime,ks:k_end,jms:jme)+grid%alb(ims:ime,ks:k_end,jms:jme)))&
                                        *(dp1+grid%moist(ims:ime,ks:k_end,jms:jme,P_QV))
            DO kk = 2, k_end
                th8w(ims:,kk,jms:) = grid%fnm(kk) * th_phy(:,kk,:) +  th_phy(:,kk-1,:) * grid%fnp(kk)
                p8w(ims:,kk,jms:)  = grid%fnm(kk) *  p_phy(:,kk,:) +   p_phy(:,kk-1,:) * grid%fnp(kk)
            ENDDO

            w1 = (z(:,1,:) - z(:,2,:)) 
            WHERE(NINT(w1*100.0) == 0 ) w1 = dp1
            w1 = (z_at_w(:,1,:) - z(:,2,:)) / w1

            th8w(:,1,:) = w1 * th_phy(:,1,:) + (dp1 - w1) * th_phy(:,2,:) 
            p8w(:,1,:)  = w1 *  p_phy(:,1,:) + (dp1 - w1) *  p_phy(:,2,:) 

            DO kk = 1, ke
                z_at_w(:,kk,:)= z_at_w(:,kk,:) - z_at_w(:,1,:)
            ENDDO

            
            

            
            
            

            CALL wrf_debug (wrfdbg, 'SPFire_driver begin transport ---------------------------------------------------- ')

            ALLOCATE(xout(active_br), &
                     yout(active_br), &
                     zout(active_br)) 

            CALL advect_xyz_m(grid=grid,           &
                            xp=  fs_p_x(:active_br), &
                            yp=  fs_p_y(:active_br), &
                            hgt= fs_p_z(:active_br), & 
                            dtp= fs_p_dt(:active_br),&
                            idp= fs_p_id(:active_br),&
                            znw= znw,      &
                            mf = rdx*msft, &
                            z_at_w=z_at_w, &
                            u= u,     &
                            v= v,     &
                            w= w,     &
                            dt=dt,    &
                            ims= ims,  &
                            jms= jms,  &
                            kms= ks,  &
                            phyd= p_hyd, & 
                            thet= th8w, &  
                            rho = rho,  &  
                            xout= xout, &
                            yout= yout, &
                            zout= zout, &
                            fs_p_prop=fs_p_prop(:active_br), &
                            land_hgt = firebrand_land_hgt,   &
                            start_mom3d_dt = cf%fs_firebrand_gen_mom3d_dt, &
                            msg = msg)


            IF (LEN(TRIM(msg)) > 1) &
                CALL wrf_debug (wrfdbg, 'SPFire_transp: '//msg)

            
            
            

            fs_p_x(:active_br) = xout
            fs_p_y(:active_br) = yout
            fs_p_z(:active_br) = zout
            fs_p_dt(:active_br)= fs_p_dt(:active_br) +1

            fs_p_mass(:active_br) = fs_p_prop(:active_br)%p_mass
            fs_p_diam(:active_br) = fs_p_prop(:active_br)%p_diam
            fs_p_effd(:active_br) = fs_p_prop(:active_br)%p_effd
            fs_p_temp(:active_br) = fs_p_prop(:active_br)%p_temp
            fs_p_tvel(:active_br) = fs_p_prop(:active_br)%p_tvel

            CALL wrf_debug (wrfdbg, 'SPFire_driver end transport   ---------------------------------------------------- ')

            
            
            

           
           
           

            WRITE (msg,'(2(i8,x))') active_br, COUNT( fs_p_id > 0 )
            CALL wrf_debug (wrfdbg, 'SPFire_driver: Active brands, id>0: '// msg )

            IF (cf%trackember) THEN
               DO kk=1,active_br
                  WRITE (msg,'(3(i8,1x),i10,1x,8(f12.6,1x))') &
                       kk, fs_p_id(kk), fs_p_dt(kk),fs_p_src(kk), &
                       fs_p_x(kk), fs_p_y(kk), fs_p_z(kk), &
                       fs_p_mass(kk), fs_p_diam(kk), fs_p_effd(kk), &
                       fs_p_temp(kk), fs_p_tvel(kk)
                  CALL wrf_debug (0, 'SPFire p,id,dt,src,x,y,z,m,d,e,t,v: '//msg)
               ENDDO
            ENDIF
            

            
            
            

            
            
            
            sparse_mask = .FALSE. 

            WHERE (IEEE_IS_NAN(fs_p_mass) .OR. IEEE_IS_NAN(fs_p_diam) .OR. &
                   IEEE_IS_NAN(fs_p_effd) .OR. IEEE_IS_NAN(fs_p_temp) .OR. &
                   IEEE_IS_NAN(fs_p_tvel)) fs_p_effd = ZERO_dp 


            
            
            
            nresets = 0
            CALL remove_br(& 
                           fs_p_id    = fs_p_id,     &
                           fs_p_x     = fs_p_x,      &
                           fs_p_y     = fs_p_y,      &
                           fs_p_z     = fs_p_z,      &
                           fs_p_dt    = fs_p_dt,     &
                           fs_p_effd  = fs_p_effd,   &
                           cnt        = nresets,     &
                           max_life_dt= firebrand_max_life_dt, &
                           land_hgt   = firebrand_land_hgt)
            WRITE (msg,'(i12)') nresets
            CALL wrf_debug (wrfdbg, 'SPFire_driver remove br: '//msg)


            
            
            

            dt_sum_landed(ims:, jms:) = ZERO_dp
            CALL deposit_br(& 
                           fs_p_id    = fs_p_id,      &
                           fs_p_x     = fs_p_x,       &
                           fs_p_y     = fs_p_y,       &
                           fs_p_z     = fs_p_z,       &
                           sum_fbrand = dt_sum_landed,&
                           land_hgt   = firebrand_land_hgt)

            
            fs_count_landed_all(is:ie, js:je)  = fs_count_landed_all(is:ie, js:je)  + dt_sum_landed(is:ie, js:je)
            fs_count_landed_hist(is:ie, js:je) = fs_count_landed_hist(is:ie, js:je) + dt_sum_landed(is:ie, js:je)
            WRITE (msg,'(2(i12,x))') COUNT(dt_sum_landed(is:ie, js:je) > 0), INT(SUM(dt_sum_landed(is:ie, js:je)))
            CALL wrf_debug (wrfdbg, 'SPFire_driver deposit br: '//msg)


            
            

            
            
            
            
            
            
            
            
            
            
            

            

            
            
            



            
            

            
            
            
            
            
            
            
            

            

            
            
            

            sparse_mask = .FALSE. 
            sparse_mask = (fs_p_id > 0 .AND. &
                          (FLOOR(fs_p_x) < is .OR. & 
                           FLOOR(fs_p_x) > ie .OR. & 
                           FLOOR(fs_p_y) > je .OR. & 
                           FLOOR(fs_p_y) < js ))     
                   

            WRITE (msg,'(i6)') COUNT(sparse_mask) 
            CALL wrf_debug (wrfdbg, 'SPFire_driver mpi send away: '//msg)

            
            
            

            CALL fs_mpi_send2neighbors(task_id=task_id,&
                    mask=sparse_mask,&
                    p_x  = fs_p_x,   &
                    p_y  = fs_p_y,   &
                    p_z  = fs_p_z,   &
                    p_id = fs_p_id,  &
                    p_src = fs_p_src,  &
                    p_dt = fs_p_dt,  &
                    fs_p_m = fs_p_mass, &
                    fs_p_d = fs_p_diam, &
                    fs_p_e = fs_p_effd, &
                    fs_p_t = fs_p_temp, &
                    fs_p_v = fs_p_tvel)
            
            
            


            
            WHERE(sparse_mask) fs_p_id= 0

        
        
        




            
            
            
            sparse_mask = .FALSE. 
            sparse_mask = (fs_p_id>0)
            fs_p_x  = PACK(fs_p_x,  sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_y  = PACK(fs_p_y,  sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_z  = PACK(fs_p_z,  sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_id = PACK(fs_p_id, sparse_mask, SPREAD(0,1,fs_array_maxsize) )
            fs_p_src = PACK(fs_p_src, sparse_mask, SPREAD(0,1,fs_array_maxsize) )
            fs_p_dt = PACK(fs_p_dt, sparse_mask, SPREAD(0,1,fs_array_maxsize) )
            fs_p_mass  = PACK(fs_p_mass , sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_diam  = PACK(fs_p_diam , sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_effd = PACK(fs_p_effd, sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_temp  = PACK(fs_p_temp , sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) )
            fs_p_tvel  = PACK(fs_p_tvel , sparse_mask, SPREAD(ZERO_dp,1,fs_array_maxsize) ) 
            
            active_br = COUNT( fs_p_id > 0 )

            WRITE (msg,'(1(i8,1x))') active_br
            CALL wrf_debug (wrfdbg, 'SPFire_driver pack AFTER mpi_send2neighbors active_br >>> '// msg)


        ENDIF

        
        
        
        IF (active_br /= COUNT( fs_p_id > 0 ) ) CALL wrf_error_fatal3("<stdin>",2530,&
'SPFire_driver: Active brands do not match!')

        
        



        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        IF ((hist_flag) .AND. (grid%itimestep > 1)) THEN

            fs_count_reset = .TRUE. 
            fs_frac_landed(ims:ime, jms:jme) = ZERO_dp
            fs_spotting_lkhd(ims:ime, jms:jme) = ZERO_dp

            
            

            ALLOCATE(landing_mask(ims:ime, jms:jme)) 
            landing_mask(ims:ime, jms:jme) = .FALSE. 
            landing_mask(is:ie, js:je) = (fs_count_landed_hist(is:ie, js:je) > 0)
            ndep = COUNT(landing_mask)

            
            
            fs_fire_area(is:ie,js:je)  = ZERO_dp
                fs_fire_area(is:ie, js:je) = fire2tile(fr_arr=grid%fire_area(ifps:ifpe,jfps:jfpe), &
                                                   dsx=grid%sr_x,dsy=grid%sr_y)




            IF (ndep > 0) THEN 

                landing_mask(ims:ime, jms:jme) = .FALSE. 
                landing_mask(is:ie, js:je) = ((fs_count_landed_hist(is:ie, js:je) > 0) .AND. &
                                          (fs_fire_area(is:ie, js:je) == ZERO_dp) )                       
                ndep = COUNT(landing_mask) 

                
                fs_landing_mask(is:ie, js:je) = UNPACK(SPREAD(1,DIM=1,NCOPIES=ndep), MASK=landing_mask(is:ie, js:je), FIELD=0)




                ALLOCATE(tmp1(ndep))
                tmp1 = PACK(fs_count_landed_hist(is:ie, js:je), landing_mask(is:ie, js:je)) 
                fs_count_landed_hist(is:ie, js:je) = ZERO_dp
                fs_count_landed_hist(is:ie, js:je) = UNPACK(tmp1, MASK=landing_mask(is:ie, js:je), FIELD=ZERO_dp)



                DEALLOCATE(tmp1)

                
                

                IF (ndep > 0) THEN 

                    
                    

                    ALLOCATE(fuel_spotting_risk_fr(ifps:ifpe,jfps:jfpe), &
                             spotthreat_fr(ifps:ifpe,jfps:jfpe))
                    fuel_spotting_risk_fr(:,:) = ZERO_dp
                    fs_fuel_spotting_risk(:,:) = ZERO_dp
                    spotthreat_fr(:,:) = ZERO_dp

                    IF (.NOT. ALLOCATED(fcat_fr)) THEN 
                        ALLOCATE(fcat_fr(ifps:ifpe,jfps:jfpe))
                        fcat_fr(:,:) = ZERO_dp                    
                        fcat_fr(ifps:ifpe,jfps:jfpe) = RESHAPE(&
                                                       get_fuel_cat(crosswalk=grid%fuel_crosswalk, &
                                                                    cat=grid%nfuel_cat(ifps:ifpe,jfps:jfpe)), &
                                                       SHAPE(fuel_spotting_risk_fr))
                    ENDIF
                    


                    spotthreat_fr(ifps:ifpe,jfps:jfpe)= spotting_threat_factor(fcat_fr(ifps:ifpe,jfps:jfpe)) 
                                                             
                                                             
                    


                    fuel_spotting_risk_fr(ifps:ifpe,jfps:jfpe) = RESHAPE(&
                                                        fuel_spotting_risk(&
                                                             fuel_fgi=grid%fgip(ifps:ifpe,jfps:jfpe), &
                                                             fuel_mcg=fmcg_2df(ifps:ifpe,jfps:jfpe), & 
                                                             
                                                             factor=spotthreat_fr(ifps:ifpe,jfps:jfpe)), &
                                                             SHAPE(fuel_spotting_risk_fr)) 

                    fs_fuel_spotting_risk(is:ie,js:je) = fire2tile(fr_arr=fuel_spotting_risk_fr(ifps:ifpe,jfps:jfpe), &
                                                         dsx=grid%sr_x,dsy=grid%sr_y)
                    DEALLOCATE(fcat_fr)

                    


                    
                    

                    ALLOCATE(landing_cnt(ndep), landed_risk(ndep), recv_spot_lkhd(ndep), recv_frac_landed(ndep))
                    landing_cnt = PACK(fs_count_landed_hist(is:ie,js:je), landing_mask(is:ie,js:je))
                    landed_risk = PACK(fs_fuel_spotting_risk(is:ie,js:je), landing_mask(is:ie,js:je))

                    IF (.NOT. (IamMaster)) THEN

                        CALL fs_mpi_sendbuffsize(sendto=MasterId, nbr=ndep) 
                        CALL fs_mpi_sendbuff_int(sendto=MasterId, bsz=ndep, buff=landing_cnt(1:ndep))
                        CALL fs_mpi_sendbuff_real(sendto=MasterId, bsz=ndep, buff=landed_risk(1:ndep))
                            
                    ENDIF
                ENDIF 
            ENDIF 

            

            IF ((ndep == 0) .AND. .NOT.(IamMaster)) &
                CALL fs_mpi_nothing2send(sendto=MasterId) 
            
            
            

            IF (IamMaster) THEN                      

                
                

                ALLOCATE(np_nlanded(ntiles)) 
                np_nlanded(:) = 0
                np_nlanded(1) = ndep 

                DO kk=2, mpiprocs 
                    np_nlanded(kk) = fs_mpi_recvbuffsize(fromid=kk-1)  


                ENDDO
                
                

                ndep_total = SUM(np_nlanded)

                IF ( ndep_total > 0) THEN 
                    ALLOCATE(np_landed_cnt(ndep_total), np_landed_risk(ndep_total))
                    IF (ndep > 0) THEN
                        np_landed_cnt(1:ndep) = landing_cnt
                        np_landed_risk(1:ndep)= landed_risk
                    ELSE 
                        np_landed_cnt(1) = ZERO_dp 
                        np_landed_risk(1)= ZERO_dp
                    ENDIF

                    
                    

                    kk1 = ndep + 1 

                    DO kk=2, mpiprocs 

                        IF (np_nlanded(kk) > 0) THEN 

                            kk2 = kk1 + np_nlanded(kk) -1                



                            np_landed_cnt(kk1:kk2) = fs_mpi_recvfrompatch_int(bsz=np_nlanded(kk), fromid=kk-1) 
                            np_landed_risk(kk1:kk2)= fs_mpi_recvfrompatch_real(bsz=np_nlanded(kk), fromid=kk-1)
                            kk1 = kk1 + np_nlanded(kk)
                        ENDIF
                    ENDDO

                    
                    

                    ALLOCATE(np_frac_landed(ndep_total), np_lkhd(ndep_total))
                    np_frac_landed(:) = ZERO_dp
                    np_lkhd(:) = ZERO_dp

                    np_frac_landed(1:ndep_total) = REAL(np_landed_cnt(1:ndep_total))/REAL(SUM(np_landed_cnt))
                    np_lkhd(1:ndep_total) = np_frac_landed(1:ndep_total) * np_landed_risk(1:ndep_total)
                    np_lkhd(1:ndep_total) = np_lkhd(1:ndep_total)/MAXVAL(np_lkhd)

                    


                    

                    
                    

                    kk1 = ndep + 1 

                    DO kk=2, mpiprocs 

                        IF (np_nlanded(kk) > 0) THEN 

                            kk2 = kk1 + np_nlanded(kk) -1                

                            CALL fs_mpi_sendbuff_real(sendto=kk-1, bsz=np_nlanded(kk), buff=np_frac_landed(kk1:kk2))
                            CALL fs_mpi_sendbuff_real(sendto=kk-1, bsz=np_nlanded(kk), buff=np_lkhd(kk1:kk2))

                            kk1 = kk1 + np_nlanded(kk)
                        ENDIF
                    ENDDO
                ENDIF 
                

            ENDIF 

            

            IF (.NOT.(IamMaster) .AND. (ndep > 0)) THEN

                recv_frac_landed = fs_mpi_recvfrompatch_real(bsz=ndep, fromid=MasterId) 
                fs_frac_landed(is:ie,js:je) = UNPACK(recv_frac_landed, MASK=landing_mask(is:ie,js:je), FIELD=ZERO_dp)

                recv_spot_lkhd = fs_mpi_recvfrompatch_real(bsz=ndep, fromid=MasterId) 
                fs_spotting_lkhd(is:ie,js:je) = UNPACK(recv_spot_lkhd, MASK=landing_mask(is:ie,js:je), FIELD=ZERO_dp)

            ENDIF

            IF ((IamMaster) .AND. (ndep > 0)) THEN

                fs_frac_landed(is:ie,js:je) = UNPACK(np_frac_landed(1:ndep), MASK=landing_mask(is:ie,js:je), FIELD=ZERO_dp)
                fs_spotting_lkhd(is:ie,js:je) = UNPACK(np_lkhd(1:ndep), MASK=landing_mask(is:ie,js:je), FIELD=ZERO_dp)

            ENDIF

        ENDIF 

        
        


        
        
        
        
        
        
        

        
        
        
        



        
        
        


        ALLOCATE(nbr_id(neighbors))
        nbr_id(:)=0
        nbr_id(:)=fs_mpi_checkreceive(task_list=task_id, np=neighbors)

        nbr_sum = SUM(nbr_id)
        IF (nbr_sum > 0) THEN 

            WRITE (msg,'(16(i4,1x))') ([task_id(ii), nbr_id(ii)], ii=1,neighbors)
            CALL wrf_debug (wrfdbg,  'SPFire_driver mpi_check_receive (taskID, N): '//msg)

            
            ALLOCATE(r_x(nbr_sum), r_y(nbr_sum), r_z(nbr_sum), r_id(nbr_sum), r_src(nbr_sum), r_dt(nbr_sum))
            r_id(:) = 0
            r_src(:) = 0
            r_dt(:) = 0
            r_x(:) = ZERO_dp
            r_y(:) = ZERO_dp
            r_z(:) = ZERO_dp

            
            ALLOCATE(r_p_m(nbr_sum), r_p_d(nbr_sum), r_p_e(nbr_sum), r_p_t(nbr_sum), r_p_v(nbr_sum))
            ALLOCATE(fb_mdetv(nbr_sum))

            CALL fs_mpi_recv(np_id=nbr_id, task_id=task_id, &
                                   r_x=r_x, r_y=r_y, r_z=r_z, &
                                   r_id=r_id, r_src=r_src, r_dt=r_dt, &
                                   r_p_m=r_p_m, &
                                   r_p_d=r_p_d, & 
                                   r_p_e=r_p_e, &
                                   r_p_t=r_p_t, & 
                                   r_p_v=r_p_v)

            
            
            fb_mdetv  = [(p_properties(r_p_m(kk), r_p_d(kk), r_p_e(kk), r_p_t(kk), r_p_v(kk)), kk=1,nbr_sum)]

            


            

            prior_br = active_br + 1 
            CALL generate_firebrands(&
                        fs_p_id = fs_p_id, &
                        fs_p_src = fs_p_src, &
                        fs_p_dt = fs_p_dt, &
                        fs_p_z  = fs_p_z,  &
                        fs_p_x  = fs_p_x,  &
                        fs_p_y  = fs_p_y,  &
                        fs_gen_idmax    = fs_gen_idmax,    &
                        myprocid = myprocid,        &
                        active_br   = active_br,   &
                        release_i = r_x, &
                        release_j = r_y, &
                        release_k = r_z, &
                        release_dt = r_dt, &
                        release_src = r_src, &
                        release_prop= fb_mdetv, & 
                        fs_p_prop   = fs_p_prop)

            WRITE (msg,'(2(i8,1x))') active_br, fs_gen_idmax
            CALL wrf_debug (wrfdbg, 'SPFire_driver mpi recv AFTER : ii, fs_gen_idmax >>> '// msg)

            fs_p_mass (prior_br:active_br) = r_p_m
            fs_p_diam (prior_br:active_br) = r_p_d
            fs_p_effd(prior_br:active_br) = r_p_e
            fs_p_temp (prior_br:active_br) = r_p_t
            fs_p_tvel (prior_br:active_br) = r_p_v

            


            

            DEALLOCATE(r_x, r_y, r_z, r_id, r_src, r_dt)
            
            DEALLOCATE(fb_mdetv)
            DEALLOCATE(r_p_m, r_p_d, r_p_e, r_p_t, r_p_v)

        

        ENDIF
        DEALLOCATE(nbr_id)
        
        
        
        
        
        

        hist_flag = .FALSE. 


    END SUBROUTINE firebrand_spotting_em_driver




    











    

    PURE &
    SUBROUTINE advect_xyz_m(grid, xp, yp, hgt, dtp, idp, &
                            u, v, w, dt, mf, z_at_w, znw, ims, jms, kms, &
                            phyd, thet, rho, &
                            xout, yout, zout, fs_p_prop, land_hgt, &
                            start_mom3d_dt, msg)


    
    

    
    
    
    
    
    
    
    

    

        IMPLICIT NONE

        TYPE(domain), INTENT(IN) :: grid 
        INTEGER, INTENT(IN)   :: ims, jms, kms, start_mom3d_dt
        REAL,    INTENT(IN)   :: dt
        REAL, INTENT(IN)      :: land_hgt
        REAL,    INTENT(IN),  DIMENSION(:) :: xp, yp, hgt 
        INTEGER, INTENT(IN),  DIMENSION(:) :: dtp, idp    
        REAL,    INTENT(IN),  DIMENSION(ims:, kms:, jms:) :: u, v, w, z_at_w
        REAL,    INTENT(IN),  DIMENSION(ims:, kms:, jms:) :: phyd, thet, rho
        REAL,    INTENT(IN),  DIMENSION(:) :: znw
        REAL,    INTENT(IN),  DIMENSION(ims:, jms:) :: mf 
        REAL,    INTENT(OUT), DIMENSION(:) :: xout, yout, zout
        TYPE(p_properties),INTENT(INOUT),DIMENSION(:):: fs_p_prop

        REAL,    DIMENSION(3) :: uvw2p 
        INTEGER :: pp, aux
        INTEGER :: hsz, ihs, jhs, ihe, jhe  
        REAL    :: xp_m0, yp_m0, zp_m0, zp0
        REAL    :: xp_m1, yp_m1, zp_m1, xp1, yp1, zp1
        REAL    :: xp_m2, yp_m2, zp_m2, xp2, yp2, zp2
        REAL    :: zp, wp, brz
        REAL    :: loc_p, loc_t, loc_d 
        CHARACTER (LEN=200), INTENT(OUT) :: msg

        WRITE(msg, '(a100)') ' ' 
    

        hsz = 4 
        ihs = is - hsz    
        jhs = js - hsz    
        ihe = ie -1 + hsz 
        jhe = je -1 + hsz 




        

        DO pp=1, SIZE(xp)






            
            
            
        
            xp_m0 = xp(pp) / mf(FLOOR(xp(pp)),FLOOR(yp(pp)))
            yp_m0 = yp(pp) / mf(FLOOR(xp(pp)),FLOOR(yp(pp)))
            zp_m0 = hgt(pp)

            
            zp0 = hgt2k(xp=xp(pp), yp=yp(pp), hgt=zp_m0, z_at_w=z_at_w, znw=znw)
            




            
            IF (zp_m0 <= land_hgt) THEN 


                xout(pp) = xp(pp)
                yout(pp) = yp(pp)
                zout(pp) = zp_m0
                CYCLE

            ENDIF

            
            

        
        
        
        

            
            
            
        
            uvw2p = uvw_3d_interp(x=xp(pp), y=yp(pp), z=zp0, u=u, v=v, w=w, ihs=ihs, jhs=jhs, ihe=ihe, jhe=jhe) 

            xp_m1 = uvw2p(1)*DT + xp_m0
            yp_m1 = uvw2p(2)*DT + yp_m0
            zp_m1 = uvw2p(3)*DT + zp_m0

            
            
            

            xp1 = xp_m1 * mf(FLOOR(xp(pp)),FLOOR(yp(pp))) 
            yp1 = yp_m1 * mf(FLOOR(xp(pp)),FLOOR(yp(pp)))

            IF((ABS(xp1-xp(pp)) > 2.0) .OR. (ABS(yp1-yp(pp)) > 2.0)) THEN
                WRITE (msg,'(2(i4,1x),7(f10.6,1x))') pp, dtp(pp), xp(pp), yp(pp), zp0, &
                                                     uvw2p(1), uvw2p(2), uvw2p(3), dt 
                zout(pp) = ZERO_dp   
                xout(pp) = ZERO_dp 
                yout(pp) = ZERO_dp 
                CYCLE
            ENDIF

            
            
            





            

            


            zp1 = hgt2k(xp=xp1, yp=yp1, hgt=zp_m1, z_at_w=z_at_w, znw=znw)
            wp = uvw2p(3)

            
            
            
            
            IF (FLOOR(xp1-dp05) < ihs .OR. FLOOR(xp1-dp05) +1 > ihe .OR. &
                FLOOR(yp1-dp05) < jhs .OR. FLOOR(yp1-dp05) +1 > jhe) THEN
                

                
                
                

                xout(pp) = xp1
                yout(pp) = yp1
                zout(pp) = zp_m1
                zp = zp1

            ELSE

            
            

                
                
                
        
                uvw2p = uvw_3d_interp(x=xp1, y=yp1, z=zp1, u=u, v=v, w=w, ihs=ihs, jhs=jhs, ihe=ihe, jhe=jhe) 




                xp_m2 = uvw2p(1)*DT + xp_m0
                yp_m2 = uvw2p(2)*DT + yp_m0
                zp_m2 = uvw2p(3)*DT + zp_m0

                xp2 = xp_m2 * mf(FLOOR(xp1),FLOOR(yp1))
                yp2 = yp_m2 * mf(FLOOR(xp1),FLOOR(yp1))
                
                IF((ABS(xp2-xp1) > 2.0) .OR. (ABS(yp2-yp1) > 2.0)) THEN
                    WRITE (msg,'(2(i4,1x),7(f10.6,1x))') pp, dtp(pp), xp1, yp1, zp1, &
                                                         uvw2p(1), uvw2p(2), uvw2p(3), dt 
                    zout(pp) = ZERO_dp   
                    xout(pp) = ZERO_dp 
                    yout(pp) = ZERO_dp 
                CYCLE
            ENDIF


                
                
                
            
                

                IF (FLOOR(xp2-dp05) < ihs .OR. FLOOR(xp2-dp05) +1 > ihe .OR. &
                    FLOOR(yp2-dp05) < jhs .OR. FLOOR(yp2-dp05) +1 > jhe) THEN
                    

                    
                    
                    

                    zp2 = hgt2k(xp=xp1, yp=yp1, hgt=zp_m2, z_at_w=z_at_w, znw=znw)

                ELSE

                    zp2 = hgt2k(xp=xp2, yp=yp2, hgt=zp_m2, z_at_w=z_at_w, znw=znw)
        
                ENDIF

            

                
                
                

                xp2 = (xp1 + xp2) * dp05 
                yp2 = (yp1 + yp2) * dp05 
                zp_m2 = (zp_m1 + zp_m2) * dp05
                zp2 = (zp1 + zp2) * dp05

                xout(pp) = xp2
                yout(pp) = yp2
                zout(pp) = zp_m2
                zp = zp2
                wp = (uvw2p(3) + wp) * dp05
                
            ENDIF

            
            
            




            
            
            

            loc_p = ZERO_dp
            loc_d = ZERO_dp
            loc_t = ZERO_dp

            IF (zout(pp) <= ZERO_dp) THEN
                fs_p_prop(pp) = p_properties(ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP)
                zout(pp) = ZERO_dp   
                CYCLE 
            ENDIF

            IF (IEEE_IS_NAN(zout(pp)) .OR. ABS(zout(pp)) > HUGE(1.0)) THEN
                fs_p_prop(pp) = p_properties(ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP)
                zout(pp) = ZERO_dp   
                xout(pp) = ZERO_dp 
                yout(pp) = ZERO_dp 

                CYCLE 
            ENDIF

            IF (dtp(pp) < start_mom3d_dt) THEN 
                

                CYCLE
            ENDIF

                        
            CALL get_local_met( xp  = xout(pp),   &
                                yp  = yout(pp),   &
                                zp  = zp,         &
                                ihs = ihs,  &
                                jhs = jhs,  &
                                ihe = ihe,  &
                                jhe = jhe,  &
                                p = phyd, & 
                                t = thet, & 
                                d = rho,  & 
                                loc_p = loc_p,    & 
                                loc_d = loc_d,    & 
                                loc_t = loc_t)      
            

            
            





            
            
            
                
            brz = zout(pp)
            CALL firebrand_physics(dt = dt,         &
                                     hgt = brz,  &
                                     loc_w = wp,      &
                                     loc_p = loc_p,   & 
                                     loc_t = loc_t,   & 
                                     loc_d = loc_d,   &     
                                     fbprop  = fs_p_prop(pp))
            
            IF (IEEE_IS_NAN(fs_p_prop(pp)%p_tvel)) THEN
                fs_p_prop(pp) = p_properties(ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP, ZERO_DP)
                zout(pp) = ZERO_dp



                    
            ELSE

                zout(pp) = brz

            ENDIF



        ENDDO

    END SUBROUTINE advect_xyz_m





PURE FUNCTION uvw_3d_interp(x, y, z, u, v, w, ihs, jhs, ihe, jhe)


    

    
    
    
    

    
    
    
    

    
    
    
    
    
    
    
    

    IMPLICIT NONE

    INTEGER, INTENT(IN)   :: ihs, jhs, ihe, jhe  
    REAL,    INTENT(IN)   :: x, y, z 
    REAL,    INTENT(IN), DIMENSION(ims:, 1:, jms:) :: u, v ,w
    REAL,    DIMENSION(3) :: uvw_3d_interp 
    REAL     :: tru, trv, trw, x0, y0, z0
    INTEGER  :: i, j, k, i0, j0, k0

    
    k = MAX(FLOOR(z), 1)
    j = FLOOR(y) 
    i = FLOOR(x) 

    
    
    
    
    
    

    x0 = x - dp05
    y0 = y - dp05
    z0 = z - dp05 

    i0 = FLOOR(x0) 
    j0 = FLOOR(y0) 
    k0 = MAX(1, FLOOR(z0))

    
    
    

    
    tru= u_3d_interp( x=x, y=y0, z=z0, &
        u_i0j0_bot=u(i, k0,   j0  ), u_i0j1_bot=u(i, k0,   j0+1), u_i1j0_bot=u(i+1, k0,   j0  ), u_i1j1_bot=u(i+1, k0,   j0+1), &
        u_i0j0_top=u(i, k0+1, j0  ), u_i0j1_top=u(i, k0+1, j0+1), u_i1j0_top=u(i+1, k0+1, j0  ), u_i1j1_top=u(i+1, k0+1, j0+1))

    
    trv= u_3d_interp( x=x0, y=y, z=z0, &
        u_i0j0_bot=v(i0, k0,   j  ), u_i0j1_bot=v(i0, k0,   j+1), u_i1j0_bot=v(i0+1, k0,   j  ), u_i1j1_bot=v(i0+1, k0,   j+1), &
        u_i0j0_top=v(i0, k0+1, j  ), u_i0j1_top=v(i0, k0+1, j+1), u_i1j0_top=v(i0+1, k0+1, j  ), u_i1j1_top=v(i0+1, k0+1, j+1))

    
    
    

    
    trw= u_3d_interp( x=x0, y=z, z=y, &
        u_i0j0_bot=w(i0, k,   j  ), u_i0j1_bot=w(i0, k+1, j  ), u_i1j0_bot=w(i0+1, k,   j  ), u_i1j1_bot=w(i0+1, k+1, j  ), &
        u_i0j0_top=w(i0, k,   j+1), u_i0j1_top=w(i0, k+1, j+1), u_i1j0_top=w(i0+1, k,   j+1), u_i1j1_top=w(i0+1, k+1, j+1)) 

    
    
    

    uvw_3d_interp = [tru, trv, trw]

END FUNCTION uvw_3d_interp





ELEMENTAL FUNCTION u_3d_interp(x, y, z, &
    u_i0j0_bot, u_i0j1_bot, u_i1j0_bot, u_i1j1_bot, &
    u_i0j0_top, u_i0j1_top, u_i1j0_top, u_i1j1_top )


    
    
    
    
    

    
    
    

    
    
    
    
    
    

    
    
    
    

    
    
    

    REAL, INTENT(IN)   :: x, y, z 
    REAL, INTENT(IN) :: u_i0j0_bot, u_i0j1_bot, u_i1j0_bot, u_i1j1_bot 
    REAL, INTENT(IN) :: u_i0j0_top, u_i0j1_top, u_i1j0_top, u_i1j1_top 
    REAL :: u_3d_interp

    REAL :: dbot, dtop, u_lower, u_upper
    INTEGER :: k, j, i

    
    
    

    
    k = MAX(1, FLOOR(z)) 

    
    
    

    dbot = z - REAL(k) 
    dtop = REAL(k+1) - z

    
    
    

    u_lower = u_2d_interp( u_i0j0=u_i0j0_bot, u_i0j1=u_i0j1_bot, &
                           u_i1j0=u_i1j0_bot, u_i1j1=u_i1j1_bot, xp=x, yp=y)
    u_upper = u_2d_interp( u_i0j0=u_i0j0_top, u_i0j1=u_i0j1_top, &
                           u_i1j0=u_i1j0_top, u_i1j1=u_i1j1_top, xp=x, yp=y)

    
    
    

    u_3d_interp = u_upper * dbot + & 
                  u_lower * dtop

    

END FUNCTION u_3d_interp







 ELEMENTAL FUNCTION u_2d_interp(u_i0j0, u_i0j1, u_i1j0, u_i1j1, xp, yp) 


    
    

    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    

    IMPLICIT NONE
    
    
    REAL,    INTENT(IN) :: xp, yp
    REAL,    INTENT(IN) :: u_i0j1, u_i0j0, u_i1j0, u_i1j1 
    REAL    :: u_2d_interp
    REAL    :: d_a, d_b, d_c, d_d      
    REAL    :: uu_a, uu_b, uu_c, uu_d  
    INTEGER :: i, j

    i = FLOOR(xp)
    j = FLOOR(yp)

    uu_a = u_i0j1 
    uu_b = u_i0j0 
    uu_c = u_i1j0 
    uu_d = u_i1j1 




    d_a = ABS( ( REAL(i+1) - xp ) * ( REAL(j  ) - yp ) )
    d_b = ABS( ( REAL(i+1) - xp ) * ( REAL(j+1) - yp ) )
    d_c = ABS( ( REAL(i  ) - xp ) * ( REAL(j+1) - yp ) )
    d_d = ABS( ( REAL(i  ) - xp ) * ( REAL(j  ) - yp ) )





   u_2d_interp = ( uu_a * d_a + &
               uu_b * d_b + &
               uu_c * d_c + &
               uu_d * d_d ) / &
               (d_a + d_b + d_c + d_d)

    


END FUNCTION u_2d_interp








PURE SUBROUTINE remove_br( fs_p_id, fs_p_x, fs_p_y, fs_p_z, fs_p_dt, fs_p_effd, cnt, max_life_dt, land_hgt)

    IMPLICIT NONE
    INTEGER, INTENT(INOUT), DIMENSION(:) :: fs_p_id
    INTEGER, INTENT(IN),    DIMENSION(:) :: fs_p_dt
    
    REAL,    INTENT(IN), DIMENSION(:) :: fs_p_x, fs_p_y, fs_p_z, fs_p_effd
    LOGICAL, DIMENSION(fs_array_maxsize) :: sparse_mask
    INTEGER, INTENT(OUT) :: cnt

    INTEGER, INTENT(IN) :: max_life_dt
    REAL, INTENT(IN)    :: land_hgt
    
    
    
    sparse_mask = .FALSE. 
    
    
    

    sparse_mask = ( fs_p_id > 0 .AND. &
                    (FLOOR(fs_p_x-dp05)   < ids .OR. FLOOR(fs_p_y-dp05)   < jds .OR. &
                     FLOOR(fs_p_x-dp05)+1 > ide .OR. FLOOR(fs_p_y-dp05)+1 > jde)) 
    
    
    

    
    
    

    sparse_mask = ( sparse_mask .OR. & 
                   (fs_p_id > 0 .AND. fs_p_dt > max_life_dt))

    
    
    

    
    

    
    
    

    sparse_mask = (sparse_mask .OR. & 
                   (fs_p_id > 0 .AND. ((fs_p_effd <= TINY(1.0) .AND. (fs_p_z > land_hgt)))))

    
    
    
    cnt = 0
    cnt = COUNT(sparse_mask)
    IF (cnt > 0) THEN

        WHERE(sparse_mask) fs_p_id = 0



        
    ENDIF
    
END SUBROUTINE remove_br






PURE SUBROUTINE deposit_br(fs_p_id, fs_p_x, fs_p_y, fs_p_z,  sum_fbrand, land_hgt)


    IMPLICIT NONE
    INTEGER, INTENT(INOUT), DIMENSION(:) :: fs_p_id
    REAL,    INTENT(INOUT), DIMENSION(ims:ime,jms:jme) :: sum_fbrand
    REAL,    INTENT(IN),    DIMENSION(:) :: fs_p_x, fs_p_y, fs_p_z
    REAL,    INTENT(IN)    :: land_hgt

    

    
    INTEGER, ALLOCATABLE, DIMENSION(:) :: rx, ry, rid
    LOGICAL, DIMENSION(fs_array_maxsize)    :: sparse_mask
    LOGICAL, DIMENSION(fs_array_maxsize)    :: bounds_mask
    
    INTEGER :: nresets
    INTEGER :: x, y, i0,k 
    


    sum_fbrand(:,:) = ZERO_dp

    
    
    

    sparse_mask = .FALSE. 
    bounds_mask = .FALSE. 

    
    bounds_mask = ((FLOOR(fs_p_x) >= is) .OR. &
                   (FLOOR(fs_p_x) <= ie) .OR. &
                   (FLOOR(fs_p_y) >= js) .OR. &
                   (FLOOR(fs_p_y) <= je))

    sparse_mask = ( bounds_mask .AND. (fs_p_id > 0 .AND. fs_p_z <= land_hgt))

    
    
    
    nresets = 0
    nresets = COUNT(sparse_mask)




    IF (nresets > 0) THEN

        
        
        

        ALLOCATE(rx(nresets),ry(nresets))

        
        rx(:) = 0
        ry(:) = 0

        rx(1:nresets) = FLOOR(PACK(fs_p_x, sparse_mask))
        ry(1:nresets) = FLOOR(PACK(fs_p_y, sparse_mask))

        
        
        

        DO k=1,nresets
            sum_fbrand(rx(k),ry(k)) = sum_fbrand(rx(k),ry(k)) + 1.0_dp
        ENDDO

        
        
        

        WHERE(sparse_mask) fs_p_id= 0
        



    ENDIF

END SUBROUTINE deposit_br







 
 
 


 
 
    SUBROUTINE get_local_ijk(grid, &
        ims, ime, jms, jme, kms, kme, &
        ips, ipe, jps, jpe, kps, kpe, &
        ifps, ifpe, jfps, jfpe,       &
        ifms, ifme, jfms, jfme,       &
        ids, ide, jds, jde, kds, kde, &
        m_idim,   m_jdim,   m_kdim,   &
        p_idim,   p_jdim,   p_kdim,   &
        d_idim,   d_jdim,   d_kdim)
        

        USE module_domain, ONLY: get_ijk_from_grid, get_ijk_from_subgrid

        IMPLICIT NONE

        TYPE(DOMAIN), INTENT(IN) :: grid 
        INTEGER,      INTENT(OUT), OPTIONAL :: ims, ime, jms, jme, kms, kme
        INTEGER,      INTENT(OUT), OPTIONAL :: ips, ipe, jps, jpe, kps, kpe
        INTEGER,      INTENT(OUT), OPTIONAL :: ifps, ifpe, jfps, jfpe
        INTEGER,      INTENT(OUT), OPTIONAL :: ifms, ifme, jfms, jfme
        INTEGER,      INTENT(OUT), OPTIONAL :: ids, ide, jds, jde, kds, kde
        INTEGER,      INTENT(OUT), OPTIONAL :: m_idim,   m_jdim,   m_kdim
        INTEGER,      INTENT(OUT), OPTIONAL :: p_idim,   p_jdim,   p_kdim
        INTEGER,      INTENT(OUT), OPTIONAL :: d_idim,   d_jdim,   d_kdim
        


        INTEGER :: iims, iime, jjms, jjme, kkms, kkme
        INTEGER :: iips, iipe, jjps, jjpe, kkps, kkpe
        INTEGER :: iids, iide, jjds, jjde, kkds, kkde

        INTEGER :: iifps, iifpe, jjfps, jjfpe, kkfps, kkfpe
        INTEGER :: iifms, iifme, jjfms, jjfme, kkfms, kkfme
        INTEGER :: iifds, iifde, jjfds, jjfde, kkfds, kkfde

        IF ((.NOT. PRESENT(ims)) .AND. &
            (.NOT. PRESENT(jms)) .AND. &
            (.NOT. PRESENT(kms)) .AND. &
            (.NOT. PRESENT(ime)) .AND. &
            (.NOT. PRESENT(jme)) .AND. &
            (.NOT. PRESENT(kme)) .AND. &
            
            (.NOT. PRESENT(ips)) .AND. &
            (.NOT. PRESENT(jps)) .AND. &
            (.NOT. PRESENT(kps)) .AND. &
            (.NOT. PRESENT(ipe)) .AND. &
            (.NOT. PRESENT(jpe)) .AND. &
            (.NOT. PRESENT(kpe)) .AND. &
            
            (.NOT. PRESENT(ifps)) .AND. &
            (.NOT. PRESENT(jfps)) .AND. &
            (.NOT. PRESENT(ifpe)) .AND. &
            (.NOT. PRESENT(jfpe)) .AND. &
            
            (.NOT. PRESENT(ifms)) .AND. &
            (.NOT. PRESENT(jfms)) .AND. &
            (.NOT. PRESENT(ifme)) .AND. &
            (.NOT. PRESENT(jfme)) .AND. &
            
            (.NOT. PRESENT(ids)) .AND. &
            (.NOT. PRESENT(jds)) .AND. &
            (.NOT. PRESENT(kds)) .AND. &
            (.NOT. PRESENT(ide)) .AND. &
            (.NOT. PRESENT(jde)) .AND. &
            (.NOT. PRESENT(kde)) .AND. &
            
            
            
            
            
            
            (.NOT. PRESENT(m_idim)) .AND. &
            (.NOT. PRESENT(m_jdim)) .AND. &
            (.NOT. PRESENT(m_kdim)) .AND. &
            (.NOT. PRESENT(p_idim)) .AND. &
            (.NOT. PRESENT(p_jdim)) .AND. &
            (.NOT. PRESENT(p_kdim)) .AND. &
            (.NOT. PRESENT(d_idim)) .AND. &
            (.NOT. PRESENT(d_jdim)) .AND. &
            (.NOT. PRESENT(d_kdim))) &
            
            CALL wrf_debug ( 1, 'get_local_ijk function is NOT requesting a result' )

        CALL get_ijk_from_grid (  grid ,        &
            iids, iide, jjds, jjde, kkds, kkde, &
            iims, iime, jjms, jjme, kkms, kkme, &
            iips, iipe, jjps, jjpe, kkps, kkpe)

        IF (PRESENT(ifps) .OR. &
            PRESENT(jfps) .OR. &
            PRESENT(ifpe) .OR. &
            PRESENT(jfpe) .OR. & 
            PRESENT(ifms) .OR. &
            PRESENT(jfms) .OR. &
            PRESENT(ifme) .OR. &
            PRESENT(jfme)) CALL get_ijk_from_subgrid(grid , &
                                    iifds, iifde, jjfds, jjfde, kkfds, kkfde, &
                                    iifms, iifme, jjfms, jjfme, kkfms, kkfme, &
                                    iifps, iifpe, jjfps, jjfpe, kkfps, kkfpe)
        

        IF (PRESENT(ims)) ims = iims
        IF (PRESENT(jms)) jms = jjms
        IF (PRESENT(kms)) kms = kkms
        IF (PRESENT(ime)) ime = iime
        IF (PRESENT(jme)) jme = jjme
        IF (PRESENT(kme)) kme = kkme

        IF (PRESENT(ips)) ips = iips
        IF (PRESENT(jps)) jps = jjps
        IF (PRESENT(kps)) kps = kkps
        IF (PRESENT(ipe)) ipe = iipe
        IF (PRESENT(jpe)) jpe = jjpe
        IF (PRESENT(kpe)) kpe = kkpe

        IF (PRESENT(ifps)) ifps = iifps
        IF (PRESENT(jfps)) jfps = jjfps
        IF (PRESENT(ifpe)) ifpe = iifpe
        IF (PRESENT(jfpe)) jfpe = jjfpe

        IF (PRESENT(ifms)) ifms = iifms
        IF (PRESENT(jfms)) jfms = jjfms
        IF (PRESENT(ifme)) ifme = iifme
        IF (PRESENT(jfme)) jfme = jjfme

        IF (PRESENT(ids)) ids = iids
        IF (PRESENT(jds)) jds = jjds
        IF (PRESENT(kds)) kds = kkds
        IF (PRESENT(ide)) ide = iide
        IF (PRESENT(jde)) jde = jjde
        IF (PRESENT(kde)) kde = kkde

        IF (PRESENT(m_idim))  m_idim = iime - iims  + 1
        IF (PRESENT(m_jdim))  m_jdim = jjme - jjms  + 1 
        IF (PRESENT(m_kdim))  m_kdim = kkme - kkms  + 1 
        IF (PRESENT(p_idim))  p_idim = iipe - iips  + 1 
        IF (PRESENT(p_jdim))  p_jdim = jjpe - jjps  + 1 
        IF (PRESENT(p_kdim))  p_kdim = kkpe - kkps  + 1 
        IF (PRESENT(d_idim))  d_idim = iide - iids  + 1 
        IF (PRESENT(d_jdim))  d_jdim = jjde - jjds  + 1 
        IF (PRESENT(d_kdim))  d_kdim = kkde - kkds  + 1 

        
        
        
        

        
        
        
        

    END SUBROUTINE get_local_ijk





    

END MODULE module_firebrand_spotting

