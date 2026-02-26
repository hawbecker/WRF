MODULE module_fire_emis

    CONTAINS























    SUBROUTINE fire_emis_simple_plumerise(wif_fire_inj, aer_fire_emit_opt, z_at_mass, pblh, &
              nwfa, nbca, nocbb2d, nbcbb2d, dt_in, ids, ide, jds, jde, kds, kde, &
              ims, ime, jms, jme, kms, kme, its, ite, jts, jte, kts, kte)

      IMPLICIT NONE

      INTEGER                                   , INTENT(IN)    :: wif_fire_inj, aer_fire_emit_opt
      REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(IN)    :: z_at_mass
      REAL, DIMENSION(ims:ime, jms:jme)         , INTENT(IN)    :: pblh
      REAL, DIMENSION(ims:ime, kms:kme, jms:jme), INTENT(INOUT) :: nwfa, nbca
      REAL, DIMENSION(ims:ime, jms:jme)         , INTENT(IN)    :: nocbb2d, nbcbb2d
      REAL                                      , INTENT(IN)    :: dt_in
      INTEGER                                   , INTENT(IN)    :: ids, ide, jds, jde, kds, kde, &
                                                                   ims, ime, jms, jme, kms, kme, &
                                                                   its, ite, jts, jte, kts, kte

        
      INTEGER  :: i, j, k, i_start, i_end, j_start, j_end, k_inj
      REAL     :: noc_emit, nbc_emit

      i_start = its
      j_start = jts
      i_end   = MIN(ite, ide-1)
      j_end   = MIN(jte, jde-1)

        
      if (wif_fire_inj .eq. 0) then
        do j = j_start, j_end
          do i = i_start, i_end
            nwfa(i,kts,j) = nwfa(i,kts,j) + nocbb2d(i,j)*dt_in
            if (aer_fire_emit_opt .eq. 2) then
              nbca(i,kts,j) = nbca(i,kts,j) + nbcbb2d(i,j)*dt_in
            end if
          end do
        end do
        
      else if (wif_fire_inj .eq. 1) then
        do j = j_start, j_end
          do i = i_start, i_end
              
            k_inj = kts
            do while (z_at_mass(i,k_inj,j) .lt. pblh(i,j))
              k_inj = k_inj + 1
            end do
              
            noc_emit = (nocbb2d(i,j)*dt_in)/k_inj
              
            if (aer_fire_emit_opt .eq. 2) then
              nbc_emit = (nbcbb2d(i,j)*dt_in)/k_inj
            end if
              
            do k = kts, k_inj
              nwfa(i,k,j) = nwfa(i,k,j) + noc_emit
              if (aer_fire_emit_opt .eq. 2) then
                nbca(i,k,j) = nbca(i,k,j) + nbc_emit
              end if
            end do
          end do
        end do
        
      else
        call wrf_error_fatal3("<stdin>",88,&
'option wif_fire_inj = ', wif_fire_inj, ' does not exist. Please set =0 or =1')
      end if

    END SUBROUTINE fire_emis_simple_plumerise

END MODULE module_fire_emis
