MODULE module_ieva_em

  USE module_bc
  USE module_model_constants
  USE module_wrf_error
  
  REAL(KIND=8), PARAMETER :: eps        = 1.0d-08
  REAL,         PARAMETER :: alpha_max  = 1.1
  REAL,         PARAMETER :: alpha_min  = 0.8

CONTAINS

LOGICAL FUNCTION CHK_IEVA( config_flags, rk_step )

   IMPLICIT NONE

   TYPE(grid_config_rec_type), INTENT(IN) :: config_flags
   INTEGER,                    INTENT(IN) :: rk_step

   INTEGER :: zadvect_implicit
   INTEGER :: rk_order

   rk_order         = config_flags%rk_ord
   zadvect_implicit = config_flags%zadvect_implicit

   CHK_IEVA = .FALSE.










 
   IF( zadvect_implicit .gt. 0 .and. rk_step .eq. rk_order ) THEN  
       CHK_IEVA = .TRUE.
   ENDIF

RETURN
END FUNCTION CHK_IEVA





SUBROUTINE WW_SPLIT(wwE, wwI,                         &
                    u, v, ww,                         &
                    mut, rdnw, msfty,                 &
                    c1f, c2f,                         &
                    rdx, rdy, msfux, msfuy,           &
                    msfvx, msfvy, dt,                 &
                    config_flags, rk_step,            &
                    ids, ide, jds, jde, kds, kde,     &
                    ims, ime, jms, jme, kms, kme,     &
                    its, ite, jts, jte, kts, kte )
                     
   TYPE( grid_config_rec_type ) ,   INTENT(IN   ) :: config_flags

   INTEGER ,          INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                       ims, ime, jms, jme, kms, kme, &
                                       its, ite, jts, jte, kts, kte, &
                                       rk_step

   REAL, DIMENSION( ims:ime, kms:kme , jms:jme ), INTENT(IN   ) ::   u, v, ww

   REAL, DIMENSION( ims:ime, kms:kme , jms:jme ), INTENT(INOUT) ::  wwE, wwI

   REAL, DIMENSION( ims:ime, jms:jme ), INTENT(IN   ) :: mut

   REAL, DIMENSION( kms:kme ), INTENT(IN   ) :: rdnw 
   REAL, DIMENSION( kms:kme ), INTENT(IN   ) :: c1f, c2f

   REAL, INTENT(IN)    :: dt
   REAL, INTENT(IN)    :: rdx, rdy
   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux, msfuy
   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfvx, msfvy, msfty



   REAL(KIND=4)    :: cr, cx, cy, c0, c2d, cw_max2, cw_min, cw, cff, rdz
   INTEGER         :: i, j, k, ii, jj, i_start, i_end, j_start, j_end, ktf
   LOGICAL         :: print_flag = .true.
   SAVE            :: print_flag
   LOGICAL         :: degrade_xs, degrade_ys, degrade_xe, degrade_ye
   





   REAL, PARAMETER :: cmnx_ratio = alpha_min/alpha_max
   REAL, PARAMETER :: cutoff     = 2.0 - cmnx_ratio
   REAL, PARAMETER :: r4cmx      = 1.0/(4.0 - 4.0*cmnx_ratio )
   REAL, PARAMETER :: Ceps       = 0.9

   LOGICAL         :: ieva










   ieva = CHK_IEVA(config_flags, rk_step)




   ktf     = kte
   i_start = its-1
   i_end   = MIN(ite,ide-1)+1
   j_start = jts-1
   j_end   = MIN(jte,jde-1)+1





   IF( print_flag .and. ieva ) THEN
     write(wrf_err_message,*) '-- BEGIN WW_SPLIT INFO ----------------------------------------'
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'RK_STEP ##', rk_step
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'IMS:IME     /  JME:JME     ', ims, ime, jms, jme
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'ISTART:IEND / JSTART:JEND  ', i_start,i_end,j_start,j_end
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'KMS:KME     /   KDS:KDE    KTS:KTE   ', kms,kme,kds,kde,kts,kte
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) '----------------------------------------'
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'WW_SPLIT:  ZADVECT_IMPLICT = ', config_flags%zadvect_implicit
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'WW_SPLIT:  IEVA = ', ieva
     CALL wrf_debug( 0, wrf_err_message )
     IF( config_flags%zadvect_implicit > 1 ) THEN
       write(wrf_err_message,*) 'WW_SPLIT:  WARNING: IEVA IS CONFIG TO ONLY RUN ON LAST RK-substep'
       CALL wrf_debug( 0, wrf_err_message )
     ENDIF
     write(wrf_err_message,*) 'WW_SPLIT:  dt = ', dt
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) 'WW_SPLIT:  alpha_max/min = ', alpha_max, alpha_min
     CALL wrf_debug( 0, wrf_err_message )
     write(wrf_err_message,*) '-- END WW_SPLIT INFO ----------------------------------------'
     CALL wrf_debug( 0, wrf_err_message )
     print_flag = .false.
   ENDIF




   IF( ieva ) THEN   
   









     DO j = j_start, j_end
       DO k = kts+1, ktf-1
         DO i = i_start, i_end
           wwE(i,k,j) = 0.
           wwI(i,k,j) = 0.
         ENDDO
       ENDDO
     ENDDO



     DO j = j_start, j_end
       DO i = i_start,i_end
       
         wwE(i,1,j) = ww(i,    1,j)
         wwI(i,1,j) = 0.0
         
         wwE(i,ktf,j) = ww(i,ktf,j)
         wwI(i,ktf,j) = 0.0

       ENDDO
     ENDDO
       
     DO j = j_start, j_end
       
       DO k = 2, ktf-1

         DO i = i_start,i_end
         





























           cx = 0.25*rdx*(u(i+1,k,j  ) + u(i,k,j) + u(i+1,k-1,j  ) + u(i,k-1,j)) 
           cy = 0.25*rdy*(v(i,  k,j+1) + v(i,k,j) + v(i  ,k-1,j+1) + v(i,k-1,j)) 
           
           cw_max = max(alpha_max - dt*Ceps*sqrt(cx**2 + cy**2),0.0)       

           cr     = ww(i,k,j) * dt * rdnw(k) / (c1f(k)*mut(i,j)+c2f(k))    
         
           IF( cw_max > 0.0 ) THEN
                      
             wfrac   = 1.0   
      
             cw_max2 = cw_max**2
             cw_min  = cw_max*cmnx_ratio
             cw      = abs(cr)
      
             if ( cw < cw_min ) then
               cff = cw_max2
             elseif ( cw < cutoff*cw_min ) then
               cff = cw_max2 + r4cmx*(cw-cw_min)**2
             else
               cff = cw_max*cw
             endif
        
             wfrac = cw_max2 / cff
             wfrac = amax1(amin1(wfrac, 1.0), 0.0)

             wwE(i,k,j) = ww(i,k,j) * wfrac
             wwI(i,k,j) = ww(i,k,j) * (1.0 - wfrac)














                
           ELSE   
                  












             
             wwE(i,k,j) = 0.0
             wwI(i,k,j) = ww(i,k,j)
       
           ENDIF

         ENDDO
       ENDDO
     ENDDO
     
   ELSE  

     DO j = j_start, j_end
       DO k = kts, ktf
         DO i = i_start,i_end
           wwE(i,k,j) = ww(i,k,j)
           wwI(i,k,j) = 0.0
         ENDDO
       ENDDO
     ENDDO
   
   ENDIF
















RETURN
END SUBROUTINE WW_SPLIT
 
 
 SUBROUTINE TRIDIAG2D(a, b, c, r, bb, is, ie, istart, iend, ks, ke, kstart, kend)







     
    integer,                              intent(in)    :: is, ie, ks, ke, istart, iend, kstart, kend
    real(kind=8), dimension(is:ie,ks:ke), intent(in)    :: a, b, c, r
    real(kind=8), dimension(is:ie,ks:ke), intent(inout) :: bb





    real(kind=8), dimension(ks:ke) :: gam
    real(kind=8), dimension(is:ie) :: bet
    integer                        :: i, k



    DO i = istart, iend   
     
      bet(i) = b(i,kstart)  
           
    ENDDO











    DO i = istart, iend

       bb(i,kstart) = r(i,kstart)/bet(i)

       DO k = kstart+1, kend

         gam(k) = c(i,k-1) / bet(i)
         bet(i) = b(i,k) - a(i,k) * gam(k)

         bb(i,k) = ( r(i,k) - a(i,k) * bb(i,k-1) ) / bet(i)

       ENDDO

       DO k = kend-1, kstart, -1

         bb(i,k) = bb(i,k) - gam(k+1) * bb(i,k+1)

       ENDDO

     ENDDO

 END SUBROUTINE TRIDIAG2D

 SUBROUTINE TRIDIAG(a, b, c, r, bb, ks, ke, kstart, kend)







    IMPLICIT NONE
    
    integer,                        intent(in)  :: ks, ke, kstart, kend
    real(kind=4), dimension(ks:ke), intent(in ) :: a, b, c, r
    real(kind=4), dimension(ks:ke), intent(out) :: bb
    
    
    
    
      
    real(kind=4), dimension(size(b,1)) :: gam
    real(kind=4)                       :: bet
    integer                            :: k
    
    bet = b(kstart)
     
    bb(kstart) = r(kstart)/bet
 
    DO k = kstart+1, kend
       
      gam(k) = c(k-1) / bet
      bet    = b(k) - a(k) * gam(k)
      
      bb(k) = ( r(k) - a(k) * bb(k-1) ) / bet
   
    ENDDO

    DO k = kend-1, kstart, -1
      bb(k) = bb(k) - gam(k+1) * bb(k+1)
    ENDDO
     
END SUBROUTINE TRIDIAG



SUBROUTINE CALC_MUT_NEW( u, v, c1h, c2h,                     &
                         mut_old, muu, muv, mut_new,         &
                         dt, rdx, rdy, msftx, msfty,         &
                         msfux, msfuy, msfvx, msfvx_inv,     &
                         msfvy, rdnw,                        &
                         ids, ide, jds, jde, kds, kde,       &
                         ims, ime, jms, jme, kms, kme,       &
                         its, ite, jts, jte, kts, kte    )

   IMPLICIT NONE

   


   INTEGER ,    INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                 ims, ime, jms, jme, kms, kme, &
                                 its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: u, v
   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN   ) :: mut_old, muu, muv, &
                                                            msftx, msfty, &
                                                            msfux, msfuy, &
                                                            msfvx, msfvy, &
                                                            msfvx_inv
   REAL , DIMENSION( kms:kme ) , INTENT(IN   ) :: rdnw
   REAL , DIMENSION( kms:kme ) , INTENT(IN   ) :: c1h, c2h
   
   REAL , DIMENSION( ims:ime, jms:jme ) , INTENT(OUT  ) :: mut_new
   REAL , INTENT(IN)  :: dt, rdx, rdy
   
   
   
   INTEGER :: i, j, k, ktf, i_start, i_end, j_start, j_end
   REAL , DIMENSION( its-1:ite ) :: dmdt
   REAL , DIMENSION( its-1:ite, kts:kte ) :: divv
   REAL :: bigerr









    ktf=MIN(kte,kde-1)  

    i_start = its-1
    i_end   = MIN(ite,ide-1)
    j_start = jts-1
    j_end   = MIN(jte,jde-1)


    DO j = j_start, j_end

      DO i = i_start, i_end
        dmdt(i) = 0.
      ENDDO



























      DO k=kts,ktf
        DO i = i_start, i_end

        divv(i,k) = (msftx(i,j) / rdnw(k)) *                                                                        &
            (rdx*((c1h(k)*muu(i+1,j)+c2h(k))*u(i+1,k,j)/msfuy(i+1,j)-(c1h(k)*muu(i,j)+c2h(k))*u(i,k,j)/msfuy(i,j))  &
            +rdy*((c1h(k)*muv(i,j+1)+c2h(k))*v(i,k,j+1)*msfvx_inv(i,j+1)-(c1h(k)*muv(i,j)+c2h(k))*v(i,k,j)*msfvx_inv(i,j)) )
                                  
        dmdt(i) = dmdt(i) + divv(i,k)

       ENDDO
      ENDDO










      DO i = i_start, i_end

         mut_new(i,j) = mut_old(i,j) - dt*dmdt(i)











      ENDDO   
    
    ENDDO     


RETURN
END SUBROUTINE CALC_MUT_NEW


SUBROUTINE advect_ph_implicit( ph, pho, tendency, phb,        &
                               ru, rv, wwE, wwI, w,           &
                               c1, c2,                        &
                               mut, config_flags,             &
                               msfux, msfuy, msfvx, msfvy,    &
                               msftx, msfty,                  &
                               fzm, fzp,                      &
                               dt_rk,                         &
                               rdx, rdy, rdzw,                &
                               ids, ide, jds, jde, kds, kde,  &
                               ims, ime, jms, jme, kms, kme,  &
                               its, ite, jts, jte, kts, kte  )

   IMPLICIT NONE
   
   
   
   TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: ph,    &
                                                                      pho,   &
                                                                      phb,   &
                                                                      ru,    &
                                                                      rv,    &
                                                                      wwI,   &
                                                                      wwE,   &
                                                                      w

   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN   ) :: mut
   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: tendency

   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux,  &
                                                                    msfuy,  &
                                                                    msfvx,  &
                                                                    msfvy,  &
                                                                    msftx,  &
                                                                    msfty

   REAL , DIMENSION( kms:kme ) ,                 INTENT(IN   ) :: fzm,  &
                                                                  fzp,  &
                                                                  rdzw, &
                                                                  c1,   &
                                                                  c2

   REAL ,                                        INTENT(IN   ) :: rdx,  &
                                                                  rdy
   REAL ,                                        INTENT(IN   ) :: dt_rk

   
   
   INTEGER :: i, j, k, itf, jtf, ktf
   INTEGER :: i_start, i_end, j_start, j_end
   INTEGER :: i_start_f, i_end_f, j_start_f, j_end_f
   INTEGER :: jmin, jmax, jp, jm, imin, imax, im, ip
   REAL    :: wiL, wiR, wiC, weL, weR, dz

   REAL(KIND=8), DIMENSION(its:ite,kts:kte) :: at, bt, ct, rt, bb
   REAL(KIND=8), DIMENSION(its:ite)         :: btmp(ims:ime)
   
   LOGICAL :: specified
   INTEGER :: iup, jup, kup, idn, jdn, kdn, kp1, km1, valid_ik

   ktf     = kte-1
   i_start = its
   i_end   = MIN(ite,ide-1)
   j_start = jts
   j_end   = MIN(jte,jde-1)




   DO j = j_start, j_end
 
     DO k = kts+1, ktf
       DO i = i_start, i_end






         wiC     = 0.5*wwI(i,k,j)*(rdzw(k-1)+rdzw(k)) * msfty(i,j) / (c1(k)*mut(i,j)+c2(k))
         at(i,k) = - dt_rk*max(wiC,0.0)
         ct(i,k) =   dt_rk*min(wiC,0.0)
         btmp(i) =   - at(i,k) - ct(i,k)







      


         bt(i,k) =   1.0 + btmp(i)





       



         rt(i,k) = tendency(i,k,j) * dt_rk * msfty(i,j) / (c1(k)*mut(i,j)+c2(k))        &


                 - at(i,k)*pho(i,k-1,j) -     btmp(i)*pho(i,k,j) - ct(i,k)*pho(i,k+1,j) &
                 - at(i,k)*phb(i,k-1,j) -     btmp(i)*phb(i,k,j) - ct(i,k)*phb(i,k+1,j)  











       ENDDO
     ENDDO

     CALL tridiag2D(at, bt, ct, rt, bb, its, ite, i_start, i_end, kts, kte, kts+1, ktf) 

     DO k = kts+1, ktf
       DO i = i_start, i_end
     
         tendency(i,k,j) = sngl(bb(i,k)) * (c1(k)*mut(i,j)+c2(k)) / dt_rk / msfty(i,j)
       
       ENDDO
     ENDDO
   
   ENDDO
    
   
RETURN
END SUBROUTINE advect_ph_implicit


SUBROUTINE advect_s_implicit( s, s_old, tendency,            &
                              ru, rv, rom,                   &
                              c1, c2,                        &
                              mut_old, mut, mut_new,         &
                              config_flags,                  &
                              msfux, msfuy, msfvx, msfvy,    &
                              msftx, msfty,                  &
                              fzm, fzp,                      &
                              dt_rk,                         &
                              rdx, rdy, rdzw,                &
                              ids, ide, jds, jde, kds, kde,  &
                              ims, ime, jms, jme, kms, kme,  &
                              its, ite, jts, jte, kts, kte  )

   IMPLICIT NONE
   
   
   
   TYPE(grid_config_rec_type), INTENT(IN) :: config_flags

   INTEGER ,                   INTENT(IN) :: ids, ide, jds, jde, kds, kde, &
                                             ims, ime, jms, jme, kms, kme, &
                                             its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN) :: s,     &
                                                                   s_old, &
                                                                   ru,    &
                                                                   rv,    &
                                                                   rom







   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN) :: mut, mut_old, mut_new


   
   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: tendency

   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux,  &
                                                                    msfuy,  &
                                                                    msfvx,  &
                                                                    msfvy,  &
                                                                    msftx,  &
                                                                    msfty

   REAL , DIMENSION( kms:kme ) ,                 INTENT(IN   ) :: fzm,  &
                                                                  fzp,  &
                                                                  rdzw, &
                                                                  c1,   &
                                                                  c2

   REAL ,                                        INTENT(IN   ) :: rdx,  &
                                                                  rdy
   REAL ,                                        INTENT(IN   ) :: dt_rk


   
   INTEGER :: i, j, k, itf, jtf, ktf
   INTEGER :: i_start, i_end, j_start, j_end
   INTEGER :: i_start_f, i_end_f, j_start_f, j_end_f
   INTEGER :: jmin, jmax, jp, jm, imin, imax, im, ip
   INTEGER :: jp1, jp0, jtmp

   INTEGER :: horz_order, vert_order

   REAL    :: mrdx, mrdy, ub, vb, uw, vw, dvm, dvp, wiL, wiR, dz

   REAL(KIND=8), DIMENSION(its:ite,kts:kte) :: at, bt, ct, rt, bb   
   REAL(KIND=8), DIMENSION(its:ite)         :: btmp
   
   INTEGER :: iup, jup, kup, idn, jdn, kdn, kp1, km1
   INTEGER :: valid_ik, skip



   ktf     = MIN(kte,kde-1)
   


   i_start = its
   i_end   = MIN(ite,ide-1)
   j_start = jts
   j_end   = MIN(jte,jde-1)



   DO j = j_start, j_end
     
     DO k = kts, ktf

       km1 = k - 1
       kp1 = k + 1
       IF( k .eq. ktf ) kp1 = ktf
       IF( k .eq. kts ) km1 = kts

       DO i = i_start, i_end

         
       
         wiL   = rom(i,k,  j) * rdzw(k) / (c1(k)*mut_new(i,j)+c2(k))
         wiR   = rom(i,k+1,j) * rdzw(k) / (c1(k)*mut_new(i,j)+c2(k))

         at(i,k) = - dt_rk*max(wiL,0.0)
         ct(i,k) =   dt_rk*min(wiR,0.0)
         btmp(i) =   dt_rk*(max(wiR,0.0) - min(wiL,0.0))
         bt(i,k) = 1.0 + btmp(i)
         rt(i,k) = dt_rk*tendency(i,k,j)  &
                   - (c1(k)*mut_old(i,j)+c2(k))*(at(i,k)*s_old(i,km1,j) + btmp(i)*s_old(i,k,j) + ct(i,k)*s_old(i,kp1,j))
       ENDDO
     ENDDO
      
     CALL tridiag2D(at, bt, ct, rt, bb, its, ite, i_start, i_end, kts, kte, kts, ktf) 

     DO k = kts, ktf
       DO i = i_start, i_end

         
     
         tendency(i,k,j) = sngl(bb(i,k)) / dt_rk
       
       ENDDO
     ENDDO
       
   ENDDO  

RETURN
END SUBROUTINE advect_s_implicit


SUBROUTINE advect_u_implicit( u, u_old, tendency,            &
                              ru, rv, rom,                   &
                              c1, c2,                        &
                              muu_old, muu, muu_new,         &
                              config_flags,                  &
                              msfux, msfuy, msfvx, msfvy,    &
                              msftx, msfty,                  &
                              fzm, fzp,                      &
                              dt_rk,                         &
                              rdx, rdy, rdzw,                &
                              ids, ide, jds, jde, kds, kde,  &
                              ims, ime, jms, jme, kms, kme,  &
                              its, ite, jts, jte, kts, kte  )

   IMPLICIT NONE
   

   
   TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: u,     &
                                                                      u_old, &
                                                                      ru,    &
                                                                      rv,    &
                                                                      rom








   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN) :: muu, muu_old, muu_new



   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: tendency

   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux,  &
                                                                    msfuy,  &
                                                                    msfvx,  &
                                                                    msfvy,  &
                                                                    msftx,  &
                                                                    msfty

   REAL , DIMENSION( kms:kme ) ,                 INTENT(IN   ) :: fzm,  &
                                                                  fzp,  &
                                                                  rdzw, &
                                                                  c1,   &
                                                                  c2

   REAL ,                                        INTENT(IN   ) :: rdx,  &
                                                                  rdy
   REAL ,                                        INTENT(IN   ) :: dt_rk

   
   
   INTEGER :: i, j, k, itf, jtf, ktf
   INTEGER :: i_start, i_end, j_start, j_end
   INTEGER :: i_start_f, i_end_f, j_start_f, j_end_f
   INTEGER :: jmin, jmax, jp, jm, imin, imax, im, ip
   INTEGER :: jp1, jp0, jtmp

   INTEGER :: horz_order, vert_order

   REAL    :: wiL, wiR, dz
   
   REAL(KIND=8), DIMENSION(its:ite,kts:kte) :: at, bt, ct, rt, bb
   REAL(KIND=8), DIMENSION(its:ite)         :: btmp
      
   LOGICAL :: specified
   INTEGER :: iup, jup, kup, idn, jdn, kdn, kp1, km1
   INTEGER :: valid_ik

   ktf     = MIN(kte,kde-1)
   


   specified = .false.
   if(config_flags%specified .or. config_flags%nested) specified = .true.

   i_start = its
   i_end   = ite
   j_start = jts
   j_end   = min(jte,jde-1)




   IF ( config_flags%open_ys .or. specified ) i_start = MAX(ids+1,its)
   IF ( config_flags%open_ye .or. specified ) i_end   = MIN(ide-1,ite)
   IF ( config_flags%periodic_x ) i_start = its
   IF ( config_flags%periodic_x ) i_end = ite
       


   DO j = j_start, j_end
   
     DO k = kts, ktf
      
       km1 = k - 1
       kp1 = k + 1
       IF( k .eq. ktf ) kp1 = ktf
       IF( k .eq. kts ) km1 = kts

       DO i = i_start, i_end


         wiL   = 0.5*(rom(i-1,k,  j)+rom(i,k,  j)) * rdzw(k) * msfuy(i,j) / (c1(k)*muu_new(i,j)+c2(k)) 
         wiR   = 0.5*(rom(i-1,k+1,j)+rom(i,k+1,j)) * rdzw(k) * msfuy(i,j) / (c1(k)*muu_new(i,j)+c2(k)) 
       
         at(i,k) = - dt_rk*max(wiL,0.0)
         ct(i,k) =   dt_rk*min(wiR,0.0) 
         btmp(i) =   dt_rk*(max(wiR,0.0) - min(wiL,0.0)) 
         bt(i,k) = 1.0 + btmp(i)
         rt(i,k) = dt_rk*tendency(i,k,j)*msfuy(i,j)  &
                 - (c1(k)*muu_old(i,j)+c2(k))*(at(i,k)*u_old(i,km1,j) + btmp(i)*u_old(i,k,j) + ct(i,k)*u_old(i,kp1,j))
       
       ENDDO
     ENDDO
   
     CALL tridiag2D(at, bt, ct, rt, bb, its, ite, i_start, i_end, kts, kte, kts, ktf) 

     DO k = kts, ktf
       DO i = i_start, i_end
     
         tendency(i,k,j) = sngl(bb(i,k)) / dt_rk / msfuy(i,j)
                
       ENDDO
     ENDDO
        
   ENDDO 
    
RETURN
END SUBROUTINE advect_u_implicit


SUBROUTINE advect_v_implicit( v, v_old, tendency,            &
                              ru, rv, rom,                   &
                              c1, c2,                        &
                              muv_old, muv, muv_new,         &
                              config_flags,                  &
                              msfux, msfuy, msfvx, msfvy,    &
                              msftx, msfty,                  &
                              fzm, fzp,                      &
                              dt_rk,                         &
                              rdx, rdy, rdzw,                &
                              ids, ide, jds, jde, kds, kde,  &
                              ims, ime, jms, jme, kms, kme,  &
                              its, ite, jts, jte, kts, kte  )

   IMPLICIT NONE
   
   
   
   TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: v,     &
                                                                      v_old, &
                                                                      ru,    &
                                                                      rv,    &
                                                                      rom








   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN) :: muv, muv_old, muv_new



   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: tendency

   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux,  &
                                                                    msfuy,  &
                                                                    msfvx,  &
                                                                    msfvy,  &
                                                                    msftx,  &
                                                                    msfty

   REAL , DIMENSION( kms:kme ) ,                 INTENT(IN   ) :: fzm,  &
                                                                  fzp,  &
                                                                  rdzw, &
                                                                  c1,   &
                                                                  c2

   REAL ,                                        INTENT(IN   ) :: rdx,  &
                                                                  rdy
   REAL ,                                        INTENT(IN   ) :: dt_rk


   
   INTEGER :: i, j, k, itf, jtf, ktf
   INTEGER :: i_start, i_end, j_start, j_end
   INTEGER :: i_start_f, i_end_f, j_start_f, j_end_f
   INTEGER :: jmin, jmax, jp, jm, imin, imax, im, ip
   INTEGER :: jp1, jp0, jtmp

   INTEGER :: horz_order, vert_order

   REAL    :: mrdx, mrdy, ub, vb, uw, vw, dvm, dvp, wiL, wiR, dz

   REAL(KIND=8), DIMENSION(its:ite,kts:kte) :: at, bt, ct, rt, bb
   REAL(KIND=8), DIMENSION(its:ite)         :: btmp
   
   LOGICAL :: specified
   INTEGER :: iup, jup, kup, idn, jdn, kdn, kp1, km1
   INTEGER :: valid_ik
   
   ktf     = MIN(kte,kde-1)
   

   
   specified = .false.
   if(config_flags%specified .or. config_flags%nested) specified = .true.

   i_start = its
   i_end   = MIN(ite,ide-1)
   j_start = jts
   j_end   = jte



   IF ( config_flags%open_ys .or. specified .or. config_flags%polar ) j_start = MAX(jds+1,jts)
   IF ( config_flags%open_ye .or. specified .or. config_flags%polar ) j_end   = MIN(jde-1,jte)
 


   DO j = j_start, j_end
   
     DO k = kts, ktf
     
       km1 = k - 1
       kp1 = k + 1
       IF( k .eq. ktf ) kp1 = ktf
       IF( k .eq. kts ) km1 = kts

       DO i = i_start, i_end
     

         wiL   = 0.5*(rom(i,k,  j-1)+rom(i,k,  j)) * rdzw(k) * msfvy(i,j) / (c1(k)*muv_new(i,j)+c2(k)) 
         wiR   = 0.5*(rom(i,k+1,j-1)+rom(i,k+1,j)) * rdzw(k) * msfvy(i,j) / (c1(k)*muv_new(i,j)+c2(k))
       
         at(i,k) = - dt_rk*max(wiL,0.0)
         ct(i,k) =   dt_rk*min(wiR,0.0)
         btmp(i) =   dt_rk*(max(wiR,0.0) - min(wiL,0.0))
         bt(i,k) = 1.0 + btmp(i)
         rt(i,k) = dt_rk*tendency(i,k,j) * msfvx(i,j) &
                 - (c1(k)*muv_old(i,j)+c2(k))*(at(i,k)*v_old(i,km1,j) + btmp(i)*v_old(i,k,j) + ct(i,k)*v_old(i,kp1,j))
       
       ENDDO
     ENDDO
      
     CALL tridiag2D(at, bt, ct, rt, bb, its, ite, i_start, i_end, kts, kte, kts, ktf) 

     DO k = kts, ktf
       DO i = i_start, i_end
     
       tendency(i,k,j) = sngl(bb(i,k)) / dt_rk / msfvx(i,j)
       
       ENDDO     
     ENDDO
          
   ENDDO
    
RETURN
END SUBROUTINE advect_v_implicit



SUBROUTINE advect_w_implicit( w, w_old, tendency,            &
                              utend, vtend, ht, rom,         &
                              ph_new, ph_old, ph_tend,       &
                              c1, c2,                        &
                              cf1, cf2, cf3,                 &
                              mut_old, mut, mut_new,         &
                              config_flags,                  &                              
                              msfux, msfuy, msfvx, msfvy,    &
                              msftx, msfty,                  &
                              fzm, fzp,                      &
                              dt_rk,                         &
                              rdx, rdy, rdzu,                &
                              ids, ide, jds, jde, kds, kde,  &
                              ims, ime, jms, jme, kms, kme,  &
                              its, ite, jts, jte, kts, kte  )

   IMPLICIT NONE
   

   
   TYPE(grid_config_rec_type), INTENT(IN   ) :: config_flags

   INTEGER ,                 INTENT(IN   ) :: ids, ide, jds, jde, kds, kde, &
                                              ims, ime, jms, jme, kms, kme, &
                                              its, ite, jts, jte, kts, kte

   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(IN   ) :: w,     &
                                                                      w_old, &
                                                                      utend, &
                                                                      vtend, &
                                                                     ph_old, &
                                                                     ph_new, &
                                                                    ph_tend, &
                                                                      rom








   REAL , DIMENSION( ims:ime , jms:jme ) , INTENT(IN) :: mut, mut_old, mut_new


   
   REAL , DIMENSION( ims:ime , kms:kme , jms:jme ) , INTENT(INOUT) :: tendency

   REAL , DIMENSION( ims:ime , jms:jme ) ,         INTENT(IN   ) :: msfux,  &
                                                                    msfuy,  &
                                                                    msfvx,  &
                                                                    msfvy,  &
                                                                    msftx,  &
                                                                    msfty,  &
                                                                    ht

   REAL , DIMENSION( kms:kme ) ,                 INTENT(IN   ) :: fzm,  &
                                                                  fzp,  &
                                                                  rdzu, &
                                                                  c1,   &
                                                                  c2
                                                                  
   REAL ,                                        INTENT(IN   ) :: rdx,  &
                                                                  rdy,  &
                                                                  cf1,  &
                                                                  cf2,  &
                                                                  cf3
                                                                  
   REAL ,                                        INTENT(IN   ) :: dt_rk


   
   INTEGER :: i, j, k, itf, jtf, ktf
   INTEGER :: i_start, i_end, j_start, j_end
   INTEGER :: i_start_f, i_end_f, j_start_f, j_end_f
   REAL    :: wiL, wiR, dz, dw

   REAL(KIND=8), DIMENSION(its:ite,kts:kte) :: at, bt, ct, rt, bb
   REAL(KIND=8), DIMENSION(its:ite)         :: btmp
   
   LOGICAL :: specified
   INTEGER :: iup, jup, kup, idn, jdn, kdn, kp1, km1
   INTEGER :: valid_ik
   
   ktf     = MIN(kte,kde-1)
   i_start = its
   i_end   = MIN(ite,ide-1)
   j_start = jts
   j_end   = MIN(jte,jde-1)
  


   DO j = j_start, j_end
   
     DO k = kts+1, ktf
       DO i = i_start, i_end


         wiL   = 0.5*(rom(i,k-1,j)+rom(i,k,j)) * rdzu(k) * msfty(i,j) / (c1(k)*mut_new(i,j)+c2(k)) 
         wiR   = 0.5*(rom(i,k+1,j)+rom(i,k,j)) * rdzu(k) * msfty(i,j) / (c1(k)*mut_new(i,j)+c2(k))

         at(i,k) = - dt_rk*max(wiL,0.0)
         ct(i,k) =   dt_rk*min(wiR,0.0) 
         btmp(i) =   dt_rk*(max(wiR,0.0) - min(wiL,0.0)) 
         bt(i,k) =   1.0 + btmp(i)
         rt(i,k) = dt_rk*tendency(i,k,j) * msfty(i,j)  &
                 - (c1(k)*mut_old(i,j)+c2(k))*(at(i,k)*w_old(i,k-1,j) + btmp(i)*w_old(i,k,j) + ct(i,k)*w_old(i,k+1,j))
       



        IF( k == kts+1 ) THEN
         dw =  msfty(i,j)*.5*rdy*(                                       &
                           (ht(i,j+1)-ht(i,j  ))                         &
          *(cf1*vtend(i,1,j+1)+cf2*vtend(i,2,j+1)+cf3*vtend(i,3,j+1))    &
                          +(ht(i,j  )-ht(i,j-1))                         &
          *(cf1*vtend(i,1,j  )+cf2*vtend(i,2,j  )+cf3*vtend(i,3,j  ))  ) &
                 +msftx(i,j)*.5*rdx*(                                    &
                           (ht(i+1,j)-ht(i,j  ))                         &
          *(cf1*utend(i+1,1,j)+cf2*utend(i+1,2,j)+cf3*utend(i+1,3,j))    &
                          +(ht(i,j  )-ht(i-1,j))                         &
          *(cf1*utend(i  ,1,j)+cf2*utend(i  ,2,j)+cf3*utend(i  ,3,j))  )

          rt(i,k) = rt(i,k) - (c1(k)*mut(i,j)+c2(k))*at(i,k)*dt_rk*dw       
        ENDIF


       
        IF( k == ktf ) THEN    
          dw = msfty(i,j)*(  (ph_new(i,k+1,j)-ph_old(i,k+1,j))/dt_rk     &
                            - ph_tend(i,k+1,j)/(c1(k)*mut(i,j)+c2(k))/g) 

          rt(i,k)   = rt(i,k) - (c1(k)*mut(i,j)+c2(k))*ct(i,k) * (dw - w_old(i,k+1,j))
        ENDIF

       ENDDO
     ENDDO

     CALL tridiag2D(at, bt, ct, rt, bb, its, ite, i_start, i_end, kts, kte, kts+1, ktf) 

     DO k = kts+1, ktf
       DO i = i_start, i_end
     
         tendency(i,k,j) = sngl(bb(i,k)) / dt_rk / msfty(i,j)
                         
       ENDDO
     ENDDO
     
   ENDDO
    
RETURN
END SUBROUTINE advect_w_implicit

END MODULE module_ieva_em


