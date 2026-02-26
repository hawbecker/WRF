

    MODULE module_scpm_jdm

    USE module_model_constants    

    USE module_dm


    CONTAINS



    SUBROUTINE force_down_meso_pblh( m_pblh, pblh,                        &
                                     ids, ide, jds, jde, kds, kde,        &
                                     ims, ime, jms, jme, kms, kme,        &
                                     its, ite, jts, jte, kts, kte         )






    IMPLICIT NONE

    INTEGER, INTENT( IN )  &
    :: ids, ide, jds, jde, kds, kde,  &
       ims, ime, jms, jme, kms, kme,  &
       its, ite, jts, jte, kts, kte

    REAL , DIMENSION( ims:ime, jms:jme ), INTENT( IN  ) :: pblh
    REAL , DIMENSION( ims:ime, jms:jme ), INTENT( OUT ) :: m_pblh
    INTEGER :: itimestep
    INTEGER :: i,j


    DO j = jts, jte
       DO i = its, ite

          m_pblh(i,j) = pblh(i,j)

       END DO
    END DO



    END SUBROUTINE force_down_meso_pblh



    SUBROUTINE calc_scpm_jdm_t( les_pert_opt,                      &
                                nb, sb, eb, wb,                    &
                                m_pblh_opt,                        &
                                prttms, prtdt, prtnk,              &
                                prtz, prtseed, pert_t,             &
                                mpblh,                             &
                                t, u, v, rdz,                      &
                                dx, dt,                            &
                                ids, ide, jds, jde, kds, kde,      &
                                ims, ime, jms, jme, kms, kme,      &
                                its, ite, jts, jte, kts, kte       )



    IMPLICIT NONE

    INCLUDE 'mpif.h'

    INTEGER, INTENT( IN    )  &
    :: ids, ide, jds, jde, kds, kde,  &
       ims, ime, jms, jme, kms, kme,  &
       its, ite, jts, jte, kts, kte

    REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT( INOUT ) :: t         
    REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT( INOUT ) :: pert_t    
    REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT( IN    ) :: u         
    REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT( IN    ) :: v         
    REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), INTENT( IN    ) :: rdz       
    REAL, DIMENSION( ims:ime, jms:jme ),          INTENT( IN    ) :: mpblh    
    REAL, DIMENSION( kms:kme ),                   INTENT( INOUT ) :: prttms    
    REAL, DIMENSION( kms:kme ),                   INTENT( INOUT ) :: prtdt     

    INTEGER, DIMENSION( kms:kme ),                INTENT( INOUT ) :: prtseed   

    INTEGER, INTENT( IN    ) :: les_pert_opt        
    INTEGER, INTENT( IN    ) :: nb, sb, eb, wb      
    INTEGER, INTENT( IN    ) :: m_pblh_opt          
    REAL,    INTENT( INOUT ) :: prtz                
    INTEGER, INTENT( INOUT ) :: prtnk               
    REAL,    INTENT( IN    ) :: dt                  
    REAL,    INTENT( IN    ) :: dx                  

    REAL, DIMENSION( its:ite, kts:kte, jts:jte ) :: z  
    REAL, DIMENSION( its:ite, jts:jte ) :: pblh        

    INTEGER :: i, j, k, big_k, slab_k, m            
    INTEGER :: i_start, i_end, j_start, j_end       
    INTEGER :: north, south, east, west             
    INTEGER :: i_seed                               
    INTEGER :: seedsum                              
    INTEGER :: ngc_h, ngc_v                         
    INTEGER :: ni, nj                               
    INTEGER :: ncells_h
    INTEGER :: n_slabs_k                            
    INTEGER :: k_slab_start, k_slab_end             
    INTEGER :: nsew                                 
    INTEGER :: k_geo                                
    REAL    :: h_geo                                
    REAL    :: ugeosum, vgeosum
    REAL    :: ugeolbsum, vgeolbsum
    REAL    :: ugeolbavg, vgeolbavg, wsgeolbavg
    REAL    :: uslabsum, vslabsum 
    REAL    :: uslablbsum, vslablbsum
    REAL    :: uslablbavg, vslablbavg, wsslablbavg  
    REAL    :: anglelbavg 
    REAL    :: num_pts_in_sum                       
    REAL    :: tpertmag                             
    REAL    :: dz                                   
    REAL    :: pblh_def 
    REAL    :: sf                                  
    REAL    :: sf2 
    REAL    :: ek_opt = 0.20                        
    REAL    :: pio2 = piconst/2.0
    REAL    :: pio4 = piconst/4.0    
    REAL    :: max_pblh, max_pert_z
    REAL    :: min_slab_z
    REAl    :: sca_fac = 1.0
    REAL    :: lambda
    INTEGER :: idum, jdum


    REAL    :: counter

    INTEGER, dimension( : ), allocatable :: seed              
    REAL, dimension( :, : ), allocatable :: pxs,pxe,pys,pye   

    INTEGER :: ierr
    INTEGER :: tag
    INTEGER :: master
    INTEGER :: status(MPI_STATUS_SIZE)

    master = 0
    tag    = 0




    ngc_h = 8      
    ngc_v = 1      
    ncells_h = 3   

    n_slabs_k = kde/ngc_v

    pblh_def  = 50.0 

    

    lambda = 0.875

    DO slab_k = 1, n_slabs_k     

       prttms(slab_k) = prttms(slab_k) + dt

       


       IF ( prttms(slab_k) .GE. prtdt(slab_k) ) THEN 

          prttms(slab_k) = dt

          prtdt(slab_k) = 300.0 

          print*,'Computing new perturbations, slab_k = ',slab_k

          

          i_start = its
          i_end   = MIN(ite,ide)
          j_start = jts
          j_end   = MIN(jte,jde)

          IF (m_pblh_opt .EQ. 0 ) THEN 

             DO j=j_start, j_end
                DO i=i_start, i_end
                   pblh(i,j) = pblh_def
                END DO
             END DO

          ENDIF

          IF (m_pblh_opt .EQ. 1 ) THEN 

             DO j=j_start, j_end
                DO i=i_start, i_end
                   pblh(i,j) = MAX(mpblh(i,j),pblh_def)
                END DO
             END DO

          ENDIF

          

          DO j=j_start, j_end
             DO i=i_start, i_end
                z(i,kts,j)= 1.0/rdz(i,kts,j)
                DO k=kts+1,kde-1  
                   z(i,k,j) = z(i,k-1,j) + 1.0/rdz(i,k,j)
                END DO
             END DO
          END DO

          k_slab_start = MIN( (slab_k - 1)*ngc_v + 1,kde-1 )         
          k_slab_end = MIN( k_slab_start + ngc_v - 1, kde-1 )  

          max_pblh = MAXVAL( pblh(i_start:i_end,j_start:j_end) )        
          min_slab_z = MINVAL(z(i_start:i_end,k_slab_start,j_start:j_end))





          idum = 1
          jdum = 1


          CALL wrf_dm_maxval_real(max_pblh,idum,jdum)

          CALL wrf_dm_minval_real(min_slab_z,idum,jdum)






          max_pert_z = max_pblh 


           IF ( min_slab_z .LE. max_pert_z ) THEN  

             


             

             h_geo = 1.10*max_pblh

             ugeosum = 0.0
             vgeosum = 0.0
             uslabsum = 0.0
             vslabsum = 0.0
             num_pts_in_sum = 0.0




             DO j=j_start, j_end

                DO i=i_start, i_end

                   DO k=kts,kde-2

                      IF ( ( z(i,k,j) .LE. h_geo ) .AND. ( z(i,k+1,j) .GT. h_geo ) )  k_geo = k

                   END DO

                   ugeosum = ugeosum + u(i,k_geo,j)
                   vgeosum = vgeosum + v(i,k_geo,j)
                   uslabsum = uslabsum + u(i,k_slab_end,j)
                   vslabsum = vslabsum + v(i,k_slab_end,j)

                   num_pts_in_sum = num_pts_in_sum + 1.0

                END DO

             END DO













             ugeolbsum  = wrf_dm_sum_real(ugeosum)

             vgeolbsum  = wrf_dm_sum_real(vgeosum)

             uslablbsum  = wrf_dm_sum_real(uslabsum)

             vslablbsum  = wrf_dm_sum_real(vslabsum)

             counter = wrf_dm_sum_real(num_pts_in_sum)




             ugeolbavg = ugeolbsum/counter

             vgeolbavg = vgeolbsum/counter

             uslablbavg = uslablbsum/counter

             vslablbavg = vslablbsum/counter


             wsgeolbavg = sqrt( ugeolbavg*ugeolbavg + vgeolbavg*vgeolbavg )

             wsslablbavg = sqrt( uslablbavg*uslablbavg + vslablbavg*vslablbavg )


             anglelbavg = atan( abs( uslablbavg )/abs( vslablbavg ) )

             IF (anglelbavg .GT. pio4 ) anglelbavg = pio2 - anglelbavg 







             north = nb
             east = sb
             south = eb
             west = wb

             IF ( (nb + sb + eb + wb ) .EQ. 0 ) THEN 
                IF ( vgeolbsum .LT. 0.0 ) north = 1
                IF ( vgeolbsum .GT. 0.0 ) south = 1
                IF ( ugeolbsum .LT. 0.0 ) east =  1
                IF ( ugeolbsum .GT. 0.0 ) west = 1
             END IF

             
             
             
             



             
             
             
             
             
             
             
             
             
             
             
             
             
             
             




             nsew = 0
             IF  ( (west + east) .EQ. 2) nsew = 1
             IF  ( (north + south) .EQ. 2) nsew = 1
             IF  ( (north + south + east + west) .EQ. 1) nsew = 1
             IF  ( (north + south + east + west) .EQ. 4) nsew = 1
             IF  ( (north + south + east + west) .EQ. 3) nsew = 0

             IF (wsslablbavg .EQ. 0.0) THEN 

                print*,'something wrong in calc_scpm_jdm_t'
                STOP

             ENDIF

             tpertmag = sca_fac*(wsgeolbavg*wsgeolbavg)/(ek_opt*cp)





             

             prtdt(slab_k) = (lambda/cos(anglelbavg))*ngc_h*ncells_h*dx/wsslablbavg








             

             ni = (ide-1)/ngc_h 
             nj = (jde-1)/ngc_h  



             

             ALLOCATE( pxs(1:nj,1:ncells_h) )
             ALLOCATE( pxe(1:nj,1:ncells_h) )
             ALLOCATE( pys(1:ni,1:ncells_h) )
             ALLOCATE( pye(1:ni,1:ncells_h) )

             CALL RANDOM_SEED(size=i_seed)  

             ALLOCATE( seed(1:i_seed) )     


             IF ( mytask .EQ. master ) THEN

                seedsum = 0                     
                DO k = 1,i_seed             
                   seed(k) = prtseed(k)
                   seedsum = seedsum + seed(k)
                END DO

                IF (seedsum .EQ. 0 ) THEN       

                   print*,'calling random seed for first time'   
                   CALL RANDOM_SEED(get=seed)

                ENDIF

             ENDIF

             CALL MPI_BCAST(seed,i_seed,MPI_REAL,master,MPI_COMM_WORLD,ierr) 



             CALL RANDOM_SEED(put=seed) 

             CALL RANDOM_NUMBER(pxs)
             CALL RANDOM_NUMBER(pxe)
             CALL RANDOM_NUMBER(pys)
             CALL RANDOM_NUMBER(pye)

             

             IF ( mytask .EQ. master ) THEN

                CALL RANDOM_SEED(get=seed)

                DO k = 1,i_seed
                   prtseed(k) = seed(k)
                ENDDO

             ENDIF



             
             
             
             
             
             
             

             sf = 1.0
             

             IF ( west .EQ. 1 ) THEN

                IF (its .LE. ids + ngc_h*ncells_h) THEN 

                   DO j = MAX(jts,jds + ngc_h*ncells_h*(west - south - nsew)), MIN(jte,jde - 1 - ngc_h*ncells_h*(west - north - nsew))



                      DO i = its, MIN(ite, ide-1)



                         m = (i-1)/ngc_h+1

                         IF ( m .LE. ncells_h ) THEN

                            DO k = k_slab_start, k_slab_end

                               pert_t(i,k,j) =  (pxs(((j-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag 

                               t(i,k,j) = t(i,k,j) + (pxs(((j-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                            END DO 

                         ENDIF

                      END DO 

                   END DO

                ENDIF

             ENDIF

             IF ( east .EQ. 1 ) THEN

                IF (ite .GE. ide - 1 - ngc_h*ncells_h) THEN 

                   DO j = MAX(jts,jds + ngc_h*ncells_h*(east - south - nsew)), MIN(jte,jde - 1 - ngc_h*ncells_h*(east - north - nsew))

                      DO i = MIN(ite, ide-1), its, -1

                         m = (ide-i-1)/ngc_h+1

                         IF ( m .LE. ncells_h ) THEN

                            DO k = k_slab_start, k_slab_end





                               pert_t(i,k,j) = (pxe(((j-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                               t(i,k,j) = t(i,k,j) + (pxe(((j-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                            END DO 

                         ENDIF

                      END DO 

                   END DO 

                ENDIF

             ENDIF

             IF ( south .EQ. 1 ) THEN

                IF (jts .LE. jds + ngc_h*ncells_h) THEN 

                   DO i = MAX(its,ids + ngc_h*ncells_h*(south - west - nsew)), MIN(ite,ide - 1 - ngc_h*ncells_h*(south - east - nsew))

                      DO j = jts, MIN(jte, jde-1)

                         m = (j-1)/ngc_h+1

                         IF ( m .LE. ncells_h ) THEN

                            DO k = k_slab_start, k_slab_end




                               pert_t(i,k,j) = (pys(((i-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                               t(i,k,j) = t(i,k,j) + (pys(((i-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                            END DO 

                         ENDIF

                      END DO 

                   END DO 

                ENDIF

             ENDIF

             IF ( north .EQ. 1 ) THEN

                IF (jte .GE. jde - 1 - ngc_h*ncells_h) THEN 

                   DO i = MAX(its,ids + ngc_h*ncells_h*(north - west - nsew)), MIN(ite,ide - 1 - ngc_h*ncells_h*(north - east - nsew))

                      DO j = MIN(jte, jde-1),jts,-1

                         m = (jde-j-1)/ngc_h+1

                         IF ( m .LE. ncells_h ) THEN

                            DO k = k_slab_start, k_slab_end

                               pert_t(i,k,j) = (pye(((i-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                               t(i,k,j) = t(i,k,j) + (pye(((i-1)/ngc_h+1),m)-0.5)*sf*2.0*tpertmag

                            END DO 

                         ENDIF

                      END DO 

                   END DO 

                ENDIF

             ENDIF

             DEALLOCATE(seed)

             DEALLOCATE( pxs )
             DEALLOCATE( pxe )
             DEALLOCATE( pys )
             DEALLOCATE( pye )

200          CONTINUE




          END IF 





       END IF 



    END DO 

    
    
    
    
    
    

    




END SUBROUTINE calc_scpm_jdm_t









    END MODULE module_scpm_jdm



