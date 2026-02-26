





MODULE rrtmg_aero_optical_util_module

  Integer      :: AERO_UTIL_LOG = 0

  private
  public :: aero_optical, aero_optical2, aero_optical_CS, AERO_UTIL_LOG

  interface ghintBH
    module procedure ghintBH_1, ghintBH_2, ghintBH_Odd
  end interface

  interface ghintBH_CS
    module procedure ghintBH_CS_even, ghintBH_CS_odd
  end interface

  Logical, Parameter :: Use_Odd_Quadrature = .True.
  Integer, Parameter :: Quadrature_Points = 3



  real, parameter :: ghxi_1(1) = 0.00000000000
  real, parameter :: ghwi_1(1) = 1.77245385091


  real, parameter :: ghxi_3(3) = (/ -1.22474487139,   &
                                     0.00000000000,   &
                                     1.22474487139 /)

  real, parameter :: ghwi_3(3) = (/ 0.295408975151,   &
                                    1.181635900000,   &
                                    0.295408975151 /)


  real(8), parameter :: ghxi_5(5) = (/ -2.02018287046d0,  &
                                       -0.958572464614d0, &
                                        0.00000000000d0,  &
                                        0.958572464614d0, &
                                        2.02018287046d0 /)

  real(8), parameter :: ghwi_5(5) = (/ 0.019953242059d0,   &
                                       0.393619323152d0,   &
                                       0.945308720483d0,   &
                                       0.393619323152d0,   &
                                       0.019953242059d0 /)



  real, parameter :: ghxi_9(9) = (/ -3.19099320178,  &
                                    -2.26658058453,  &
                                    -1.46855328922,  &
                                    -0.72355101875,  &
                                     0.00000000000,  &
                                     0.72355101875,  &
                                     1.46855328922,  &
                                     2.26658058453,  &
                                     3.19099320178 /)

  real, parameter :: ghwi_9(9) = (/ 3.96069772633E-5, &
                                    0.00494362428,    &
                                    0.08847452739,    &
                                    0.43265155900,    &
                                    0.72023521561,    &
                                    0.43265155900,    &
                                    0.08847452739,    &
                                    0.004943624275,   &
                                    3.96069772633E-5 /)

  contains


  subroutine getqext_BH (xx, crefin, qextalf, qscatalf, gscatalfg,SUCCESS)

    implicit none

    real, intent(in)     :: XX
    real, intent(out)    :: qextalf, qscatalf, gscatalfg
    complex, intent(in)  :: CREFIN
    logical, intent(out) :: success


    real( 8 ), parameter :: one_third = 1.0d0 / 3.0d0

    integer              :: NXX
    integer              :: nstop, modulus

    real :: QEXT, QSCA, QBACK, G_MIE, xx1

    real( 8 )    :: x
    complex( 8 ) :: refractive_index

    x = real( XX, 8 )
    refractive_index = dcmplx( real( CREFIN ), imag( CREFIN ) )

    modulus = int( abs( x * refractive_index ) )
    nstop = int( x + 4.0d0 * x**one_third + 2.0d0 )

    nxx = max( modulus, nstop ) + 15

    xx1 = 1.0 / XX

    CALL BHMIE_FLEXI (XX, NXX, NSTOP, CREFIN,QEXT,QSCA,QBACK,G_MIE, SUCCESS)

    qextalf   = QEXT * xx1
    qscatalf  = QSCA * xx1
    gscatalfg = qscatalf * G_MIE

  end subroutine getqext_bh


  SUBROUTINE BHMIE (X, REFREL, QQEXT, QQSCA, QBACK, GSCA, SUCCESS)




    implicit none 


       real, intent(in)    :: X        
       complex, intent(in) :: REFREL







    real,    intent(out) :: QQEXT, QQSCA, QBACK, GSCA
    logical, intent(out) :: SUCCESS
























    integer, parameter :: MXNANG=10, NMXX=600000   
    real*8, parameter  :: PII = 3.1415916536D0
    real*8, parameter  :: ONE = 1.0D0, TWO = 2.0D0


    integer    :: NANG
    integer    :: N,NSTOP,NMX,NN
    real*8     :: QSCA, QEXT, DX1, DXX1      
    real*8     :: CHI,CHI0,CHI1,DX,EN,P,PSI,PSI0,PSI1,XSTOP,YMOD               
    real*8     :: TWO_N_M_ONE, TWO_N_P_ONE, EN1, FACTOR
    complex*16 :: AN,AN1,BN,BN1,DREFRL,XI,XI1,Y, Y1, DREFRL1
    complex*16 :: D(NMXX), FAC1, FAC2
    complex*16 :: XBACK









































 



    SUCCESS = .TRUE.
    NANG = 2 



    DX = REAL( X, 8 )

    DX1  = ONE / DX
    DXX1 = DX1 * DX1
    DREFRL = DCMPLX( REFREL ) 
    DREFRL1 = ONE / DREFRL
    Y = DX * DREFRL
    Y1 = ONE / Y
    YMOD = ABS(Y)
 


    XSTOP = REAL( X + 4.0 * X**0.3333 + 2.0, 8)
    NMX  = INT( MAX(XSTOP,YMOD) ) + 15







    NSTOP = INT( XSTOP )
    FACTOR = 1.0D0
 
    IF (NMX .GT. NMXX) THEN
       WRITE(6,*)'Error: NMX > NMXX=',NMXX,' for |m|x=',YMOD
       SUCCESS = .FALSE.
       RETURN
    END IF





 


 
    D(NMX) = DCMPLX(0.0D0,0.0D0)
    NN = NMX - 1
    DO N = 1,NN
       EN  = REAL(NMX - N + 1, 8 )


       D(NMX-N) = ( EN * Y1 ) - (ONE / ( D(NMX-N+1) + EN * Y1)) 
    END DO
 


 
    PSI0 =  COS(DX)
    PSI1 =  SIN(DX)
    CHI0 = -SIN(DX)
    CHI1 =  PSI0
    XI1  =  DCMPLX(PSI1,-CHI1)
    QSCA =  0.0D0
    GSCA =  0.0D0
    QEXT =  0.0D0
    P    = -ONE
    XBACK = (0.0d0,0.0d0)


    DO N = 1,NSTOP
       EN        = REAL( N, 8)
       EN1       = ONE / EN
       TWO_N_M_ONE = TWO * EN - ONE




       PSI = TWO_N_M_ONE * PSI1 * DX1 - PSI0
       CHI = TWO_N_M_ONE * CHI1 * DX1 - CHI0
       XI  = DCMPLX(PSI,-CHI)
 


       FAC1 = D(N) * DREFRL1 + EN * DX1 
       AN   = (FAC1) * PSI - PSI1
       AN   = AN / ( (FAC1 )* XI - XI1 )
       FAC2 = ( DREFRL * D(N) + EN * DX1)
       BN   = ( FAC2) * PSI -PSI1
       BN   = BN / ((FAC2) * XI - XI1 )



       TWO_N_P_ONE = (TWO * EN + ONE)
       QEXT = QEXT + (TWO_N_P_ONE) * (REAL(AN) + REAL(BN) ) 
       QSCA = QSCA + (TWO_N_P_ONE) * ( ABS(AN)**2+ ABS(BN)**2 )
          

       FACTOR = -1.0d0 * FACTOR  
       XBACK = XBACK + (TWO_N_P_ONE) * factor * (AN - BN)
          

        GSCA = GSCA + REAL( ((TWO_N_P_ONE)/(EN * (EN + ONE))) *     &
              (REAL(AN)*REAL(BN)+IMAG(AN)*IMAG(BN)))

       IF (N .GT. 1)THEN
          GSCA = GSCA + REAL( (EN - EN1) *                         &
                 (REAL(AN1)*REAL(AN) + IMAG(AN1)*IMAG(AN) +  &
                  REAL(BN1)*REAL(BN) + IMAG(BN1)*IMAG(BN)))
       ENDIF


       AN1 = AN
       BN1 = BN


       PSI0 = PSI1
       PSI1 = PSI
       CHI0 = CHI1
       CHI1 = CHI
       XI1  = DCMPLX(PSI1,-CHI1)

    END DO   
 



    GSCA  = REAL( TWO / QSCA )  * GSCA



    QQSCA = REAL( TWO * QSCA * DXX1 )
    QQEXT = REAL( TWO * QEXT * DXX1 ) 
    QBACK = REAL( REAL ( 0.5d0 * XBACK * CONJG(XBACK), 8 ) * DXX1 )  

  END subroutine BHMIE


  subroutine aero_optical ( lamda_in, nmode, nr, ni, Vol,   &
                            dgn, sig, bext, bscat, g_bar,   &
                            success, modulus )
     





   IMPLICIT NONE

   real, intent(in)    :: lamda_in               
   INTEGER, intent(in) :: nmode                  
   real, intent(in)    :: nr( nmode), ni(nmode)  
                                                 
   real, intent(in)    :: Vol(nmode)             
   real, intent(in)    :: dgn(nmode)             
                                                 
   real, intent(in)    :: sig(nmode)             

   real, intent(in), optional :: modulus(nmode)  
      

   real, intent(out) :: bext    
   real, intent(out) :: bscat   
   real, intent(out) :: g_bar   
   logical, intent(out) :: success 

   INTEGER  :: j             

   real     :: beta_Sc, bsc  
 
   real     :: beta_Ex       
   real     :: G             
   real     :: sum_g
   real     :: LSIGX
   real     :: lamdam1       
   real     :: alphav        
   real     :: vfac
   real     :: modalph

   real, parameter :: pi = 3.14159265359
       
   Logical, Save :: Initialize = .True.












    lamdam1 = 1.0e6 / lamda_in   
    bext    = 0.0
    bscat   = 0.0
    sum_g   = 0.0
        
    DO j = 1, nmode


       LSIGX = log(sig(j))



       alphav =  pi * dgn(j) * exp(3.0 * LSIGX * LSIGX) * lamdam1

       if (present(modulus)) then
          modalph = alphav * modulus(j)   
       end if

       CALL ghintBH (nr(j), ni(j), alphav, LSIGX, beta_EX, beta_Sc, G, success)            




         
       vfac  =  Vol(j) * lamdam1 




       bext    = bext  + vfac * beta_Ex  
       bsc     = vfac * beta_Sc
       bscat   = bscat + bsc          
       sum_g   = sum_g + bsc * G

    END DO  
       


    g_bar = sum_g / bscat 

  END SUBROUTINE aero_optical


  subroutine ghintBH_1 (nr, ni, alfv, xlnsig, Qext_GH, Qscat_GH, g_gh, success) 






















 
    implicit none

    real, intent(in)     :: nr, ni     
    real, intent(in)     :: alfv       
    real, intent(in)     :: xlnsig     
    real, intent(out)    :: Qext_GH    
    real, intent(out)    :: Qscat_GH   
    real, intent(out)    :: g_GH       
    logical, intent(out) :: success    
      
    real    :: bext_P, bscat_P, babs_P, g_PCS, xlnsg2  
      
    real    :: aa1                
    real    :: alfaip, alfaim     
     

    real    :: qalfip_e, qalfim_e 
    real    :: qalfip_s, qalfim_s 
    real    :: gsalfp, gsalfm     
    integer :: IGH                


    real, parameter :: pi = 3.14159265
    real, parameter :: sqrtpi = 1.772454 
    real, parameter :: sqrtpi1 = 1.0 / sqrtpi 
    real, parameter :: sqrt2 = 1.414214 
    real, parameter :: three_pi_two = 3.0 * pi / 2.0 
    real, parameter :: const = three_pi_two * sqrtpi1 
      
    integer :: i
    complex :: crefin                  
    real    :: sum_e,sum_s, xi,wxi,xf
    real    :: sum_sg







    real, parameter :: ghxi_10(5) = (/ 0.342901327223705,     &
                                       1.036610829789514,     &
                                       1.756683649299882,     &
                                       2.532731674232790,     &
                                       3.436159118837738 /)

    real, parameter :: ghwi_10(5) = (/ 6.108626337353e-01,    &
                                       2.401386110823e-01,    &
                                       3.387439445548e-02,    &
                                       1.343645746781e-03,    &
                                       7.640432855233e-06 /)


    real, parameter :: ghxi_6(3) = (/ 0.436077411927617,      &
                                      1.335849074013597,      &
                                      2.350604973674492 /)

    real, parameter :: ghwi_6(3) = (/ 7.246295952244e-01,     &
                                      1.570673203229e-01,     &
                                      4.530009905509e-03 /)


    real, parameter :: ghxi_2(1) = (/ 0.707106781186548 /)

    real, parameter :: ghwi_2(1) = (/ 8.862269254528e-01 /)

    real    :: GHXI(5), GHWI(5) 
    integer :: NMAX             


    if ( alfv .le. 0.3) then
       xlnsg2 = xlnsig*xlnsig
       call pennfsb (nr,ni,alfv,xlnsg2,bext_P,bscat_P,babs_P,g_PCS)
       Qext_GH  = bext_P
       Qscat_GH = bscat_p
       g_GH     = g_PCS * exp(4.0 * xlnsg2) 
    else





       IGH=3 

       NMAX = 3

       if (nr .ge. 1.7) then 

          IGH = 5 
          NMAX = 5
       end if

       if ( alfv .gt. 20.0 .or. alfv .lt. 0.5 ) then
          IGH  = 1 
          NMAX = 1
       end if

       if (IGH == 1) then
          GHXI(1)    = ghxi_2(1)
          GHWI(1)    = ghwi_2(1)
       else if (IGH == 3) then
          do i = 1, NMAX
             GHXI(i) = ghxi_6(i)
             GHWI(i) = ghwi_6(i)
          end do 
       else
          do i = 1,NMAX
             GHXI(i) = ghxi_10(i)
             GHWI(i) = ghwi_10(i)
          end do  
       end if 
 

       crefin= cmplx(nr,ni)      


       aa1 = sqrt2 * xlnsig   
                                 





       sum_e  = 0.0
       sum_s  = 0.0
       sum_sg = 0.0

       do i = 1,NMAX
          xi      = GHXI(i)
          wxi     = GHWI(i)
          xf      = exp( xi * aa1 )
          alfaip  = alfv * xf
          alfaim  = alfv / xf 


          call getqext_BH (alfaip, crefin, qalfip_e, qalfip_s, gsalfp, success)
          call getqext_BH (alfaim, crefin, qalfim_e, qalfim_s, gsalfm, success)

          sum_e  = sum_e + wxi  * ( qalfip_e + qalfim_e ) 
          sum_s  = sum_s + wxi  * ( qalfip_s + qalfim_s ) 
          sum_sg = sum_sg + wxi * ( gsalfp + gsalfm ) 
       end do 

       g_GH     = sum_sg / sum_s 
       Qext_GH  = const * sum_e  
       Qscat_GH = const * sum_s  
    end if

  end subroutine ghintBH_1


  subroutine pennfsb (n, k, xx, lnsg2, bext, bscat, babs, g)





























    implicit none 

    real, intent(in)  :: n, k     
    real, intent(in)  :: xx       
    real, intent(in)  :: lnsg2    
    real, intent(out) :: bext     
    real, intent(out) :: bscat    
    real, intent(out) :: babs     
    real, intent(out) :: g        


    complex*16  :: m, m2,m4,m6,m21,m22 
    complex*16  :: P,Q,R,S,T,U,V,W
    complex*16  :: Qprime, Rprime,Sprime,Tprime
    complex*16  :: Uprime, Vprime, Wprime
    real*8      :: Qs, gQs, gpennCS
    real*8      :: P1,P2, Q1, Q2 , S2,V1, V2 
    real*8      :: P1SQ, P2SQ  
    real*8      :: y, y2, y3, y4, y6, y7,  y8, y9       
    real*8      :: x, x2, x3, x4, x6, x7,  x8, x9 
    real        :: mag, modalf

    real, parameter :: pi = 3.14159265358979324d0 
    real, parameter :: three_pi_two = 1.5d0 * pi

    real*8, parameter :: one = 1.0d0
    real*8, parameter :: two = 2.0d0
    real*8, parameter :: three = 3.0d0
    real*8, parameter :: four = 4.0d0
    real*8, parameter :: five = 5.0d0
    real*8, parameter :: six = 6.0d0
    real*8, parameter :: eight = 8.0d0
    real*8, parameter :: nine = 9.0d0
    real*8, parameter :: fifteen = 15.0d0
    real*8, parameter :: fortyfive = 45.0d0

    real*8, parameter :: twothrds = two / three
    real*8, parameter :: fourthirds = four / three
    real*8, parameter :: onefifteenth = one / fifteen
    real*8, parameter :: twofifteenths = two * onefifteenth

    real*8, parameter :: eightthirds = two * fourthirds
    real*8, parameter :: one_big = one / 31500.0d0
    real*8, parameter :: two_fortyfive = two / fortyfive
    real*8, parameter :: four_225 = four / 225.0d0 
    real*8, parameter :: one_210 = one / 210.0d0


    real*8, parameter :: nine_two = 4.5d0






    real*8            :: A,B,C,D,E, AA,BB,CC


    mag = sqrt( n * n + k * k )
    modalf = mag * xx
    y  = REAL( xx, 8 ) 

    y2 = y * y
    y3 = y2 * y
    y4 = y3 * y
    y6 = y3 * y3
    y7 = y3 * y4
    y8 = y4 * y4
    y9 = y6 * y3 





    x  = y 
    x2 = y2 * exp( two              * lnsg2)
    x3 = y3 * exp( nine_two         * lnsg2)
    x4 = y4 
    x6 = y6 
    x7 = y7 
    x8 = y8 
    x9 = y9 

        

    m = dcmplx(n,-k)

    m2 = m * m
    m4 = m2 * m2
    m6 = m2 * m4
    m21 = m2 - one
    m22 = m2 + two


    P = m21 / m22
    Q = (m2 - two ) / m22
    S = m21 / ( two * m2 + three)
    V = m21

    P1 = real(P)
    P2 = -aimag(P)
    P1SQ = P1 * P1
    P2SQ = P2 * P2

    Q1 = real(Q)
    Q2 = -aimag(Q)
    S2 = -aimag(S)
    V1 = real(V)
    v2 = -aimag(V)





    bext = REAL( four * P2 + ( 2.4d0 * (P1 * Q2 + P2 * Q1 ) +  twothrds * S2          &
         + twofifteenths * V2 ) * x2 + ( eightthirds * ( P1SQ - P2SQ ) ) * x3, 4 )



    bscat = REAL( eightthirds * ( P1SQ + P2SQ ) * x3 )








    R = (m6 + 20.0d0*m4 -200.0d0*m2 + 200.0d0) / m22**2
    T = m21 / ( ( 2.0d0 * M2 + 3.0d0) **2 )
    U = m21 / (3.0d0 * M2 + 4.0d0 )
    W = m21 * ( 2.0d0 * m2 - 5.0d0)


    Qprime = Q
    Rprime = 18.0d0 * R
    Sprime = 5.0d0 * S / P
    Tprime = 375.0d0 * T / P

    Vprime = V / P
    Wprime = 5.0d0 * W / P












      









    A = 1.0D0 * x4
    B = onefifteenth * real(Qprime) * x6 
    C = fourthirds * aimag(P) * x7
    D = one_big * ( 35.0d0 * abs(Qprime)**2                             &
        + 20.0d0 * real(Rprime) + 35.0d0 * abs(Vprime)**2               &
        + 21.0d0 * abs(Sprime)**2 ) * x8     
    E = two_fortyfive * aimag( Qprime * ( P - conjg(P) )) * x9   
    
    Qs = eightthirds * abs(P)**2 *( A + B + C + D + E )
    
    AA = (5.0d0 * Real(Vprime) + 3.0d0 * real(Sprime) ) * x6 
    BB = one_210 * ( 35.0d0 * real(Vprime*conjg(Qprime) )               &
         + 21.0d0 * real(Sprime * conjg(Qprime) )                       &
         + 10.0d0 * real(Wprime)- 6.0d0 * real(Tprime) ) * x8         
    CC = twothrds * ( 5.0d0 * aimag(Vprime * conjg(P) )                 &
         + 3.0d0 * aimag(Sprime * conjg(P) ) ) * x9    

    gQs = four_225 * abs(P)**2 * ( AA + BB + CC )
      

    g = REAL(gQs / Qs)

    bext  = three_pi_two * bext  
    bscat = three_pi_two * bscat 

    babs = bext - bscat
        
  end subroutine pennfsb




























  subroutine pennfsbLW (crefin, xx, lnsig, bext, bscat)

    implicit none 

    complex, intent(in)  :: crefin  
    real, intent(in)     :: xx 
    real, intent(in)     :: lnsig   
    real, intent(out)    :: bext  
    real, intent(out)    :: bscat 

    real*8      :: Qext, Qscat
    real*8      :: lnsg2

    complex*16  :: m, m2,m21,m22 
    complex*16  :: P,Q,S,V
    real*8      :: P1,P2, Q1, Q2 , S2,V1, V2 
    real*8      :: P1SQ, P2SQ  
    real*8      :: y, y2, y3
    real*8      ::    x2, x3 

    real*8, parameter :: one= 1.0d0
    real*8, parameter :: two = 2.0d0
    real*8, parameter :: three = 3.0d0
    real*8, parameter :: four = 4.0d0      
    real*8, parameter :: eight = 8.0d0
    real*8, parameter :: nine = 9.0d0      
    real*8, parameter :: fifteen = 15.0d0
    real*8, parameter :: twothrds = two/three
    real*8, parameter :: twofifteenths = two / fifteen
    real*8, parameter :: eightthirds = eight / three
    real*8, parameter :: nine_two = nine / two
 

    real, parameter :: pi = four*atan(one)
    real, parameter :: three_pi_two = 1.5d0 * pi






    lnsg2 = lnsig * lnsig
    y  = xx  
    y2 = y * y
    y3 = y * y2 
    x2 = y2 * exp( two      * lnsg2)
    x3 = y3 * exp( nine_two * lnsg2) 
             
    m= conjg(crefin) 
    m2 = m * m
    m21 = m2 - one
    m22 = m2 + two

      P = m21 / m22
      Q = (m2 - two ) / m22
      S = m21 / ( two * m2 + three)
      V = m21

      P1 = real(P)
      P2 = -aimag(P)
      P1SQ = P1 * P1
      P2SQ = P2 * P2

      Q1 = real(Q)
      Q2 = -aimag(Q)
      S2 = -aimag(S)
      V1 = real(V)
      v2 = -aimag(V)




      Qext = four * P2                                                  &
             + ( 2.4d0 * (P1 * Q2 + P2 * Q1 ) +  twothrds * S2          &
                       + twofifteenths * V2   ) * x2                    &
             + ( eightthirds * ( P1SQ - P2SQ ) ) * x3



      Qscat = eightthirds * ( P1SQ + P2SQ ) * x3


      bext  = three_pi_two * Qext  
      bscat = three_pi_two * Qscat 
         
  end subroutine pennfsbLW


  subroutine aero_optical2( lamda_in, crefin, Vol, dgn, &
                            sig, bext, bscat, gfac, success )


     





   IMPLICIT NONE


   real, intent(in)    :: lamda_in   
   complex, intent(in) :: crefin     
   real, intent(in)    :: Vol        
   real, intent(in)    :: dgn        
                                        
   real, intent(in)    :: sig        
      

   real, intent(out)    :: bext         
   real, intent(out)    :: bscat        
   real, intent(out)    :: gfac         
   logical, intent(out) :: success      
      


   real :: beta_Sc       
 
   real :: beta_Ex       
   real :: G             
   real :: sum_g
   real :: LSIGX
   real :: lamdam1       
   real :: alphav        
   real :: vfac
   real, parameter :: pi = 3.14159265359

    Logical, Save :: Initialize = .True.
       








    lamdam1 = 1.0e6 / lamda_in 
    bext  = 0.0
    bscat = 0.0
    sum_g = 0.0
    LSIGX = log(sig)
       


    alphav =  pi * dgn * exp(3.0 * LSIGX * LSIGX) * lamdam1
       
    If(Initialize .And. AERO_UTIL_LOG .GT. 0 )Then
       If( Use_Odd_Quadrature )then
           write(AERO_UTIL_LOG,99501)Quadrature_Points
       else
           write(AERO_UTIL_LOG,99504)
           Initialize = .False.
       End If
    End If

    If( Use_Odd_Quadrature )then
        CALL ghintBH (Initialize, crefin, alphav, LSIGX, beta_EX, beta_Sc, G, success)
    Else
        CALL ghintBH (crefin, alphav, LSIGX, beta_EX, beta_Sc, G, success)
    End If




         
    vfac  =  Vol * lamdam1         
    bext    = vfac * beta_Ex  
    bscat   = vfac * beta_Sc  
    gfac    = G
99501  Format(I2,' Quadrature Points for Volume Averaged Aerosol Optics')
99504  Format('Even Number Quadrature Points for Volume Averaged Aerosol Optics')
       
  END SUBROUTINE aero_optical2


  subroutine aero_optical_CS ( lamda_in, refcor,refshell, VOLCOR,   &
                               VOLSHELL, DGNCOR, DGNSHELL, SIG,     &
                               bext, bscat, gfac, succesS )
     






    IMPLICIT NONE

    real,intent(in)    :: lamda_in   
    complex,intent(in) :: refcor     
    complex,intent(in) :: refshell   
    real,intent(in)    ::  VOLCOR    
    real,intent(in)    ::  VOLSHELL  
    real,intent(in)    ::  DGNCOR    
                                     
    real,intent(in)    ::  DGNSHELL  
                                     
    real,intent(in)    ::  SIG       
      

    real,intent(out)     ::  bext      
    real,intent(out)     ::  bscat     
    real,intent(out)     ::  gfac      
    logical, intent(OUT) :: success    
      


    real    :: beta_Sc          
 
    real    :: beta_Ex          
    real    :: G                
    real    :: LSIGX
    real    :: XX, YY           
    real    :: expfac
    real    :: lamdam1          
    real    :: vfac
       
    Logical, Save :: Initialize = .True.

    real, parameter :: pi = 3.14159265359
       









    lamdam1 = 1.0e6 / lamda_in 
        

    LSIGX  = log(SIG)
    expfac = pi * exp(3.0 * LSIGX * LSIGX) * lamdam1
        


    XX =  DGNCOR * expfac                                       
    YY =  DGNSHELL * expfac
       
    If(Initialize .And. AERO_UTIL_LOG .GT. 0 )Then
       If( Use_Odd_Quadrature )then
           write(AERO_UTIL_LOG,99500)Quadrature_Points
       else
           write(AERO_UTIL_LOG,99502)
           Initialize = .False.
       End If
    End If
       
    If( Use_Odd_Quadrature )then
        CALL ghintBH_CS(Initialize,refcor,refshell,XX,YY,LSIGX,beta_EX,beta_Sc,G, success)
    Else
        CALL ghintBH_CS(refcor,refshell,XX,YY,LSIGX,beta_EX,beta_Sc,G, success)
    End If            






         
    vfac   =  (VOLCOR + VOLSHELL) * lamdam1         
    bext   = vfac * beta_Ex  
    bscat  = vfac * beta_Sc  
    gfac   = G
99500  Format(I2,' Quadrature Points for Core-Shell Aerosol Optics')
99502  Format('Even Number Quadrature Points for Core-Shell Aerosol Optics')

  END SUBROUTINE aero_optical_CS



  subroutine aero_optical_LW (lamda_in, crefin, Vol,   &
                              dgn, sig, bext, bscat )
     




   IMPLICIT NONE

   real, intent(in)    :: lamda_in      
                      
   complex, intent(in) ::  crefin  
   real, intent(in)    :: Vol 
   real, intent(in)    :: dgn 
                              
   real, intent(in)    :: sig 
      
      

   real, intent(out) :: bext  
   real, intent(out) :: bscat 
      
      

   real, parameter :: pi = 3.14159265359

   real :: lamda  
   real :: beta_Sc       
 
   real :: beta_Ex       
   real :: G             
   real :: VLX, DGX, SIGX, LSIGX
   real :: lamdam1 
   real :: alphav 
   real vfac

   logical :: success
       












    bext  = 0.0
    bscat = 0.0
       

    lamdam1 = 1.0e6 / lamda_in  
        
    VLX   = Vol
    DGX   = dgn
    SIGX  = sig 
    LSIGX = log(SIGX)
        


    alphav = pi * DGX * exp(3.0 * LSIGX * LSIGX) * lamdam1
    vfac   = VLX * lamdam1 
       
  
    if ( alphav .le. 0.3) then
       call pennfsbLW(crefin, alphav, LSIGX, beta_EX, beta_Sc)
       G = 0.0 
    else
       CALL ghintBH(crefin, alphav, LSIGX, beta_EX, beta_Sc, G, success)            
    end if 

    bext  = vfac * beta_Ex  
    bscat = vfac * beta_Sc

  END SUBROUTINE aero_optical_LW


  subroutine ghintBH_2 (crefin,alfv,xlnsig,Qext_GH,Qscat_GH,g_gh, success) 























    implicit none

    complex, intent(in) :: crefin     
    real, intent(in)    :: alfv       
    real, intent(in)    :: xlnsig     
    real, intent(out)   :: Qext_GH    
    real, intent(out)   :: Qscat_GH   
    real, intent(out)   :: g_GH       
    logical, intent(out) :: success   
       
    real    :: nr                 
    real    :: aa1                
    real    :: alfaip, alfaim     
     

    real    :: qalfip_e, qalfim_e 
    real    :: qalfip_s, qalfim_s 
    real    :: gsalfp, gsalfm     
    integer :: IGH                


    real, parameter :: pi = 3.14159265
    real, parameter :: sqrtpi = 1.772454 
    real, parameter :: sqrtpi1 = 1.0 / sqrtpi 
    real, parameter :: sqrt2 = 1.414214 
    real, parameter :: three_pi_two = 3.0 * pi / 2.0 
    real, parameter :: const = three_pi_two * sqrtpi1 
       
    integer ::  i
    real    ::  sum_e,sum_s, xi,wxi,xf
    real    ::  sum_sg







    real, parameter :: ghxi_10(5) = (/ 0.342901327223705,     &
                                       1.036610829789514,     &
                                       1.756683649299882,     &
                                       2.532731674232790,     &
                                       3.436159118837738 /)

    real, parameter :: ghwi_10(5) = (/ 6.108626337353e-01,    &
                                       2.401386110823e-01,    &
                                       3.387439445548e-02,    &
                                       1.343645746781e-03,    &
                                       7.640432855233e-06 /)


    real, parameter :: ghxi_6(3) = (/ 0.436077411927617,      &
                                      1.335849074013597,      &
                                      2.350604973674492 /)

    real, parameter :: ghwi_6(3) = (/ 7.246295952244e-01,     &
                                      1.570673203229e-01,     &
                                      4.530009905509e-03 /)


    real, parameter :: ghxi_2(1) = (/ 0.707106781186548 /)

    real, parameter :: ghwi_2(1) = (/ 8.862269254528e-01 /)

    real    :: GHXI(5), GHWI(5) 
    integer :: NMAX             






    nr = real(crefin)      

    IGH=3 

    NMAX = 3

    if (nr .ge. 1.7) then 

       IGH = 5 
       NMAX = 5
    end if

    if( alfv .gt. 20.0 .or. alfv .lt. 0.5 ) then
       IGH  = 1 
       NMAX = 1
    end if

    if (IGH == 1) then

       GHXI(1)    = ghxi_2(1)
       GHWI(1)    = ghwi_2(1)
    else if (IGH == 3) then
       do i = 1, NMAX
          GHXI(i) = ghxi_6(i)
          GHWI(i) = ghwi_6(i)
       end do 
    else
       do i = 1,NMAX
          GHXI(i) = ghxi_10(i)
          GHWI(i) = ghwi_10(i)
       end do  
    end if 
      

    aa1 = sqrt2 * xlnsig    
                            






    sum_e  = 0.0
    sum_s  = 0.0
    sum_sg = 0.0

    do i = 1,NMAX
       xi      = GHXI(i)
       wxi     = GHWI(i)
       xf      = exp( xi * aa1 )
       alfaip  = alfv * xf
       alfaim  = alfv / xf 


       call getqext_BH(alfaip,crefin,qalfip_e,qalfip_s, gsalfp, success)
       call getqext_BH(alfaim,crefin,qalfim_e,qalfim_s, gsalfm, success)

       sum_e  = sum_e + wxi  * ( qalfip_e + qalfim_e ) 
       sum_s  = sum_s + wxi  * ( qalfip_s + qalfim_s ) 
       sum_sg = sum_sg + wxi * ( gsalfp + gsalfm ) 

    end do 

    g_GH     = sum_sg / sum_s 
    Qext_GH  = const * sum_e  
    Qscat_GH = const * sum_s  

  end subroutine ghintBH_2


  subroutine ghintBH_CS_even (RCORE, RSHELL , XX, YY, xlnsig,  &                  
                              Qext_GH,Qscat_GH, g_gh, success)










       
















    implicit none
    complex, intent(in) :: RCORE      
    complex, intent(in) :: RSHELL     
    real, intent(in)    :: XX         
    real, intent(in)    :: YY         
    real, intent(in)    :: xlnsig     
    real, intent(out)   :: Qext_GH    
    real, intent(out)   :: Qscat_GH   
    real, intent(out)   :: g_GH       
    logical, intent(out) :: success   

    real    :: nr                     
    real    :: aa1                    
    real    :: XXP, XXM               
    real    :: YYP, YYM               
     

   real, parameter :: pi = 3.14159265
   real, parameter :: sqrtpi = 1.772454 
   real, parameter :: sqrtpi1 = 1.0 / sqrtpi 
   real, parameter :: sqrt2 = 1.414214 
   real, parameter :: three_pi_two = 3.0 * pi / 2.0 
   real, parameter ::  const = three_pi_two * sqrtpi1 
 

    real    :: qalfip_e, qalfim_e     
    real    :: qalfip_s, qalfim_s     
    real    :: gsalfp, gsalfm         
    integer :: IGH                    
    integer ::  i
    real    ::  sum_e,sum_s, xi,wxi,xf, temp
    real    ::  sum_sg







    real, parameter :: ghxi_10(5) = (/ 0.342901327223705,     &
                                       1.036610829789514,     &
                                       1.756683649299882,     &
                                       2.532731674232790,     &
                                       3.436159118837738 /)

    real, parameter :: ghwi_10(5) = (/ 6.108626337353e-01,    &
                                       2.401386110823e-01,    &
                                       3.387439445548e-02,    &
                                       1.343645746781e-03,    &
                                       7.640432855233e-06 /)


    real, parameter :: ghxi_6(3) = (/ 0.436077411927617,      &
                                      1.335849074013597,      &
                                      2.350604973674492 /)

    real, parameter :: ghwi_6(3) = (/ 7.246295952244e-01,     &
                                      1.570673203229e-01,     &
                                      4.530009905509e-03 /)


    real, parameter :: ghxi_2(1) = (/ 0.707106781186548 /)

    real, parameter :: ghwi_2(1) = (/ 8.862269254528e-01 /)

    real GHXI(5), GHWI(5) 
    integer NMAX 





    nr = real(RSHELL)      

    IGH=3 

    NMAX = 3

    if (nr .ge. 1.7) then 

       IGH = 5 
       NMAX = 5
    end if

    if ( XX .gt. 20.0 .or. XX .lt. 0.5 ) then
       IGH  = 1 
       NMAX = 1
    end if

    if (IGH == 1) then

       GHXI(1)    = ghxi_2(1)
       GHWI(1)    = ghwi_2(1)
    else if (IGH == 3) then
       do i = 1, NMAX
          GHXI(i) = ghxi_6(i)
          GHWI(i) = ghwi_6(i)
       end do 
    else
       do i = 1,NMAX
          GHXI(i) = ghxi_10(i)
          GHWI(i) = ghwi_10(i)
       end do  
    end if 


    aa1 = sqrt2 * xlnsig   
                           





    sum_e  = 0.0
    sum_s  = 0.0
    sum_sg = 0.0

    do i = 1,NMAX
       xi      = GHXI(i)
       wxi     = GHWI(i)
       xf      = exp( xi * aa1 )
       temp    = 1.0 / xf
       XXP     = XX * xf
       XXM     = XX * temp 
       YYP     = YY * xf
       YYM     = YY * temp 


       call getqsgBHCS(XXP,YYP,RCORE,RSHELL,qalfip_e,qalfip_s,gsalfp, success)
       call getqsgBHCS(XXM,YYM,RCORE,RSHELL,qalfim_e,qalfim_s,gsalfm, success)
       
       sum_e  = sum_e  + wxi  * ( qalfip_e + qalfim_e ) 
       sum_s  = sum_s  + wxi  * ( qalfip_s + qalfim_s ) 
       sum_sg = sum_sg + wxi  * ( gsalfp   + gsalfm   ) 
    end do 

    g_GH     = sum_sg / sum_s 
    Qext_GH  = const * sum_e  
    Qscat_GH = const * sum_s  

  end subroutine ghintBH_CS_even
      

  subroutine getqsgBHCS (XX,YY,RRFRL1,RRFRL2,qxtalf,qscalf,qsgalf, success)
    implicit none

    real, intent(in)    :: XX, YY
    real, intent(out)   :: qxtalf, qscalf, qsgalf
    complex, intent(in) :: RRFRL1,RRFRL2            
    logical, intent(out) :: success                 

    real    :: QEXT, QSCA, QBACK, G_MIE
    real    :: xx1
    character (len = 20) :: mystr1, mystr2, mystr3, mystr4

    xx1    = 1.0 / YY







    call BHCOAT (XX,YY,RRFRL1,RRFRL2,QEXT,QSCA,QBACK,G_MIE, SUCCESS)








    qxtalf = QEXT * xx1
    qscalf = QSCA * xx1
    qsgalf = qscalf * G_MIE 

  END subroutine getqsgBHCS


  SUBROUTINE BHCOAT (XX, YY, RRFRL1, RRFRL2, QQEXT, QQSCA, QBACK, GGSCA, SUCCESS)
      
    use complex_number_module

    implicit none 


     real, intent(in)    :: XX,YY             
     complex, intent(in) :: RRFRL1,RRFRL2     
     real, intent(out)   :: QQEXT,QQSCA,QBACK 
     real, intent(out)   :: GGSCA             
     logical,intent(out) :: success


     
     real*8, parameter     :: DEL = 1.0D-08  
     real*8, parameter     :: ONE = 1.0D0, TWO = 2.0D0 


     type(complex_number) :: II

     integer :: IFLAG,N,NSTOP

     character (len = 128) :: mystr




     
     real*8 :: CHI0Y,CHI1Y,CHIY,PSI0Y,PSI1Y,PSIY,QEXT,RN,QSCA,X,Y,YSTOP,GSCA
     real*8 :: TWO_N_M_ONE, TWO_N_P_ONE
     real*8 :: RY, RYY, RNRY, RN1, factor
       

     type(complex_number) :: AMESS1,AMESS2,AMESS3,AMESS4,AN,ANCAP,AN1, BN,BNCAP,BN1, BRACK,   &
                             CHI0X2,CHI0Y2,CHI1X2,CHI1Y2,CHIX2,CHIPX2,CHIPY2,CHIY2,CRACK,     &
                             D0X1,D0X2,D0Y2,D1X1,D1X2,D1Y2,DNBAR,GNBAR,                       &
                             REFREL,RFREL1,RFREL2, XBACK,XI0Y,XI1Y,XIY,                       &
                             X1,X2,Y2,RCX1, RCX2,RCY2, FAC1, FAC2
































 














     SUCCESS = .TRUE.      

     II = c_set(0.0D0, 1.0D0)



     write (mystr, *) xx, yy, real(RRFRL1), aimag(RRFRL1), real(RRFRL2), aimag(RRFRL2)
     read  (mystr, *) x,  y,  RFREL1, RFREL2



     RY     = ONE / Y
     RYY    = RY * RY




     x1     = c_mul(x, rfrel1)
     x2     = c_mul(x, rfrel2)
     y2     = c_mul(y, rfrel2)
     RCX1   = c_div(ONE, X1)
     RCX2   = c_div(ONE, X2)
     RCY2   = c_div(ONE, Y2)
     refrel = c_div(rfrel2, rfrel1)
     ystop  = y + 4.0 * y**0.3333 + 2.0
     nstop  = INT( ystop )






     d0x1   = c_div(c_cos(x1), c_sin(x1))
     d0x2   = c_div(c_cos(x2), c_sin(x2))
     d0y2   = c_div(c_cos(y2), c_sin(y2))

     psi0y  = cos(y)
     psi1y  = sin(y)
     chi0y  = -sin(y)
     chi1y  = cos(y)

     xi0y   = c_sub(psi0y, c_mul(chi0y, II))
     xi1y   = c_sub(psi1y, c_mul(chi1y, II))

     chi0y2 = c_mul(-1.0d0, c_SIN(y2))
     chi1y2 = c_COS(y2)
     chi0x2 = c_mul(-1.0d0, c_SIN(x2))
     chi1x2 = c_COS(x2)
     qsca   = 0.0d0
     qext   = 0.0d0
     GSCA   = 0.0d0
     xback  = c_set(0.0d0, 0.0d0)
     iflag  = 0
     factor = 1.0d0


     DO n = 1, nstop
        rn = REAL( n, 8 )
        RN1 = ONE / RN
        TWO_N_M_ONE = TWO * RN - ONE
        TWO_N_P_ONE = TWO * RN + ONE
        psiy = (TWO_N_M_ONE)*psi1y*RY - psi0y
        chiy = (TWO_N_M_ONE)*chi1y*RY - chi0y
        xiy  = c_sub(psiy, c_mul(chiy, II))
        d1y2 = c_sub(c_div(ONE, c_sub(c_mul(rn, RCY2), d0y2)), c_mul(rn, RCY2))

        IF (iflag .eq. 0) THEN


           d1x1   = c_sub(c_div(ONE, c_sub(c_mul(rn, RCX1), d0x1)), c_mul(rn, RCX1))
           d1x2   = c_sub(c_div(ONE, c_sub(c_mul(rn, RCX2), d0x2)), c_mul(rn, RCX2))

           chix2  = c_sub(c_mul(c_mul(TWO*rn - ONE, chi1x2), RCX2), chi0x2)
           chiy2  = c_sub(c_mul(c_mul(TWO*rn - ONE, chi1y2), RCY2), chi0y2)

           chipx2 = c_sub(chi1x2, c_mul(c_mul(rn, chix2), RCX2))
           chipy2 = c_sub(chi1y2, c_mul(c_mul(rn, chiy2), RCY2))

           ANCAP = c_sub(c_mul(c_mul(REFREL, D1X1), CHIX2), CHIPX2)
           ANCAP = c_mul(ANCAP, c_sub(c_mul(CHIX2, D1X2), CHIPX2))
           ANCAP = c_div(c_sub(c_mul(REFREL, D1X1), D1X2), ANCAP)

           brack  = c_mul(ancap, c_sub(c_mul(chiy2, d1y2), chipy2))

           bncap  = c_sub(c_mul(refrel, d1x2), d1x1)
           bncap  = c_div(bncap, c_sub(c_mul(refrel, chipx2), c_mul(d1x1, chix2)))
           bncap  = c_div(bncap, c_sub(c_mul(chix2, d1x2), chipx2))

           crack  = c_mul(bncap, c_sub(c_mul(chiy2, d1y2), chipy2))




           amess1 = c_mul(brack, chipy2)
           amess2 = c_mul(brack, chiy2)
           amess3 = c_mul(crack, chipy2)
           amess4 = c_mul(crack, chiy2)



           IF (c_ABS(amess1) .LE. del*c_ABS(d1y2)  .AND.                          &
              (c_ABS(amess2) .LE. del)             .AND.                          &
              (c_ABS(amess3) .LE. del*c_ABS(d1y2)) .AND.                          &
              (c_ABS(amess4) .LE. del)                ) THEN

              brack = c_set(0.0D0,0.0D0)
              crack = c_set(0.0D0,0.0D0)
              iflag = 1



          END IF 
        END IF 



        dnbar = c_sub(d1y2, c_mul(brack, chipy2))
        dnbar = c_div(dnbar, c_sub(ONE, c_mul(brack, chiy2)))
        gnbar = c_sub(d1y2, c_mul(crack, chipy2))
        gnbar = c_div(gnbar, c_sub(ONE, c_mul(crack, chiy2)))


        IF (N .GT. 1) THEN
           AN1 = an
           BN1 = bn
        END IF    

        RNRY = rn * RY 
        FAC1 = c_add(c_div(dnbar, rfrel2), RNRY)

        an = c_sub(c_mul(psiy, FAC1), psi1y)
        an = c_div(an, c_sub(c_mul(FAC1, xiy), xi1y))
        FAC2 = c_add(c_mul(rfrel2, gnbar), RNRY)
        bn = c_sub(c_mul(psiy, FAC2), psi1y)
        bn = c_div(bn, c_sub(c_mul(FAC2, xiy), xi1y))
      

        qsca  = qsca + (TWO_N_P_ONE) * (c_ABS(an)**2 + c_ABS(bn)**2)
      
        qext  = qext + TWO_N_P_ONE * (an%real_part + bn%real_part)
      
        FACTOR = FACTOR * (-1.0D0)
        XBACK = c_add(XBACK, c_mul(TWO_N_P_ONE * FACTOR, c_sub(AN, BN)))



        GSCA = GSCA + ((TWO_N_P_ONE)/(RN* (RN + ONE)))*                       &
               (an%real_part*bn%real_part + an%imag_part*bn%imag_part)
 
        IF (n .GT. 1) THEN
        
           GSCA = GSCA + (RN - RN1) *                                         &
                 (AN1%real_part*AN%real_part + AN1%imag_part*AN%imag_part +   &
                  BN1%real_part*BN%real_part + BN1%imag_part*BN%imag_part)
     
        END IF

        psi0y  = psi1y
        psi1y  = psiy
        chi0y  = chi1y
        chi1y  = chiy
        xi1y   = c_sub(psi1y, c_mul(chi1y, II))
        chi0x2 = chi1x2
        chi1x2 = chix2
        chi0y2 = chi1y2
        chi1y2 = chiy2
        d0x1   = d1x1
        d0x2   = d1x2
        d0y2   = d1y2
     END DO  
  


     GGSCA = REAL( TWO * GSCA / qsca )
     QQSCA = REAL( TWO * qsca * RYY )
     QQEXT = REAL( TWO * qext * RYY )

     QBACK = 0.5 * real((xback%real_part**2 + xback%imag_part**2) * RYY)

  end subroutine BHCOAT


  subroutine ghintBH_Odd (INIT, crefin,alfv,xlnsig,Qext_GH,Qscat_GH,g_gh, success ) 























    implicit none

    logical, intent(INOUT)        :: INIT       
    complex, intent(in)           :: crefin     
    real, intent(in)              :: alfv       
    real, intent(in)              :: xlnsig     
    real, intent(out)             :: Qext_GH    
    real, intent(out)             :: Qscat_GH   
    real, intent(out)             :: g_GH       
    logical, intent(out)          :: success    
       
    real    :: nr                 
    real    :: aa1                
    real    :: alfaip, alfaim     
     

    real    :: qalfip_e, qalfim_e 
    real    :: qalfip_s, qalfim_s 
    real    :: gsalfp, gsalfm     


    real, parameter :: pi = 3.14159265
    real, parameter :: sqrtpi = 1.772454 
    real, parameter :: sqrtpi1 = 1.0 / sqrtpi 
    real, parameter :: sqrt2 = 1.414214 
    real, parameter :: three_pi_two = 3.0 * pi / 2.0 
    real, parameter :: const = three_pi_two * sqrtpi1 
       
    integer ::  i
    real    ::  sum_e,sum_s, xi,wxi,xf
    real    ::  sum_sg

    real,    allocatable,  save  :: GHXI(:), GHWI(:) 
    integer, save  :: IGH                            
    integer, save  :: NMAX                           






    If( INIT )Then

       Select Case( Quadrature_Points )
         Case( 1,3,9 )
           IGH = Quadrature_Points
         Case Default
           IGH = 3
       End Select

       NMAX = Max( Int( IGH / 2 ), 0)

       If( Allocated( GHXI ) .Or. Allocated( GHWI ) )Then
           Success = .False.
           Return             
       End If
          
       Allocate( GHXI( NMAX + 1 ), GHWI( NMAX + 1 ) )
 
       Select Case ( IGH ) 
         Case ( 1 )
           GHXI(1)  = ghxi_1(1)
           GHWI(1)  = ghwi_1(1)
         Case ( 3 )
           do i = 1, NMAX + 1
             GHXI(i) = ghxi_3(i)
             GHWI(i) = ghwi_3(i)
           end do 
         Case ( 9 )
           do i = 1, NMAX + 1
             GHXI(i) = ghxi_9(i)
             GHWI(i) = ghwi_9(i)
           end do 
       end select 
          
       If( AERO_UTIL_LOG .GT. 0 )Then
           write(AERO_UTIL_LOG,*)'BHMIE: IGH,(NMAX + 1) = ',IGH,(NMAX + 1)
           do i = 1, NMAX + 1
             write(AERO_UTIL_LOG,*)'BHMIE: i, GHXI(i), GHWI(i) = ',i, GHXI(i), GHWI(i)
           end do
       End If
       
       INIT = .False.
    Else
       If( .Not. Allocated( GHXI ) .Or. .Not. Allocated( GHWI ) )Then
           Success = .False.
           Return             
       End If                
    End If 
 
    nr = real(crefin)      


    aa1 = sqrt2 * xlnsig    
                            







    xi      = 0.0
    wxi     = GHWI(NMAX+1)
    xf      = 1.0
    alfaip  = alfv


    call getqext_BH(alfaip,crefin,qalfip_e,qalfip_s, gsalfp, success)

    sum_e  = wxi * qalfip_e
    sum_s  = wxi * qalfip_s
    sum_sg = wxi * gsalfp


    do i = 1, NMAX
       xi      = GHXI(i)
       wxi     = GHWI(i)
       xf      = exp( xi * aa1 )
       alfaip  = alfv * xf
       alfaim  = alfv / xf 


       call getqext_BH(alfaip,crefin,qalfip_e,qalfip_s, gsalfp, success)
       call getqext_BH(alfaim,crefin,qalfim_e,qalfim_s, gsalfm, success)

       sum_e  = sum_e + wxi  * ( qalfip_e + qalfim_e ) 
       sum_s  = sum_s + wxi  * ( qalfip_s + qalfim_s ) 
       sum_sg = sum_sg + wxi * ( gsalfp + gsalfm ) 

    end do

    g_GH     = sum_sg / sum_s 
    Qext_GH  = const * sum_e  
    Qscat_GH = const * sum_s  

  end subroutine ghintBH_Odd


  subroutine ghintBH_CS_Odd (INIT, RCORE, RSHELL , XX, YY, xlnsig,  &                  
                             Qext_GH,Qscat_GH, g_gh, success)










       
















    implicit none

    logical, intent(inout) :: INIT       
    complex, intent(in)    :: RCORE      
    complex, intent(in)    :: RSHELL     
    real, intent(in)       :: XX         
    real, intent(in)       :: YY         
    real, intent(in)       :: xlnsig     
    real, intent(out)      :: Qext_GH    
    real, intent(out)      :: Qscat_GH   
    real, intent(out)      :: g_GH       
    logical, intent(out)   :: success   

    real    :: nr                     
    real    :: aa1                    
    real    :: XXP, XXM               
    real    :: YYP, YYM               
     

   real, parameter :: pi = 3.14159265
   real, parameter :: sqrtpi = 1.772454 
   real, parameter :: sqrtpi1 = 1.0 / sqrtpi 
   real, parameter :: sqrt2 = 1.414214 
   real, parameter :: three_pi_two = 3.0 * pi / 2.0 
   real, parameter ::  const = three_pi_two * sqrtpi1 
 

    real    :: qalfip_e, qalfim_e     
    real    :: qalfip_s, qalfim_s     
    real    :: gsalfp, gsalfm         
    integer ::  i
    real    ::  sum_e,sum_s, xi,wxi,xf, temp
    real    ::  sum_sg

    real,    allocatable,  save  :: GHXI(:), GHWI(:) 
    integer,               save  :: IGH              
    integer,               save  :: NMAX             





    If( INIT )Then

       Select Case( Quadrature_Points )
         Case( 1,3,9 )
           IGH = Quadrature_Points
         Case Default
           IGH = 3
       End Select
                 
       If( Allocated( GHXI ) .Or. Allocated( GHWI ) )Then
           Success = .False.
           Return             
       End If

       NMAX = Max( Int( IGH / 2 ), 0)
       
       Allocate( GHXI( NMAX + 1 ), GHWI( NMAX + 1 ) )

       Select Case ( IGH ) 
         Case ( 1 )
           GHXI(1)  = ghxi_1(1)
           GHWI(1)  = ghwi_1(1)
         Case ( 3 )
           do i = 1, NMAX + 1
             GHXI(i) = ghxi_3(i)
             GHWI(i) = ghwi_3(i)
           end do 
         Case ( 9 )
           do i = 1, NMAX + 1
             GHXI(i) = ghxi_9(i)
             GHWI(i) = ghwi_9(i)
           end do  
       end select 

       If( AERO_UTIL_LOG .GT. 0 )Then
           write(AERO_UTIL_LOG,*)'BHCoat: IGH,(NMAX + 1) = ',IGH,(NMAX + 1)
           do i = 1, NMAX + 1
             write(AERO_UTIL_LOG,*)'BHCoat: i, GHXI(i), GHWI(i) = ',i, GHXI(i), GHWI(i)
           end do
       End If
       
       INIT = .False.
          
    Else
       If( .Not. Allocated( GHXI ) .Or. .Not. Allocated( GHWI ) )Then
           Success = .False.
           Return             
       End If      
    End If 

    nr = real(RSHELL)      


    aa1 = sqrt2 * xlnsig   
                           








    xi      = 0.0
    wxi     = GHWI(NMAX+1)
    xf      = 1.0
    XXP     = XX
    YYP     = YY



    call getqsgBHCS(XXP,YYP,RCORE,RSHELL,qalfip_e,qalfip_s,gsalfp, success)
          
    sum_e  = wxi  * qalfip_e
    sum_s  = wxi  * qalfip_s
    sum_sg = wxi  * gsalfp   


    do i = 1, NMAX
       xi      = GHXI(i)
       wxi     = GHWI(i)
       xf      = exp( xi * aa1 )
       temp    = 1.0 / xf
       XXP     = XX * xf
       XXM     = XX * temp 
       YYP     = YY * xf
       YYM     = YY * temp 


       call getqsgBHCS(XXP,YYP,RCORE,RSHELL,qalfip_e,qalfip_s,gsalfp, success)
       call getqsgBHCS(XXM,YYM,RCORE,RSHELL,qalfim_e,qalfim_s,gsalfm, success)
          
       sum_e  = sum_e  + wxi  * ( qalfip_e + qalfim_e ) 
       sum_s  = sum_s  + wxi  * ( qalfip_s + qalfim_s ) 
       sum_sg = sum_sg + wxi  * ( gsalfp   + gsalfm   ) 
    end do 

    g_GH     = sum_sg / sum_s 
    Qext_GH  = const * sum_e  
    Qscat_GH = const * sum_s  

  end subroutine ghintBH_CS_Odd        


  SUBROUTINE BHMIE_FLEXI (X, NMX, NSTOP, REFREL, QQEXT, QQSCA, QBACK, GSCA, SUCCESS)




    implicit none 


    real,    intent(in) :: X        
    integer, intent(in) :: NMX      
    integer, intent(in) :: NSTOP    
    complex, intent(in) :: REFREL   







    real,    intent(out) :: QQEXT, QQSCA, QBACK, GSCA
    logical, intent(out) :: SUCCESS
























    integer, parameter    :: MXNANG=10, NMXX=150000   
    integer, parameter    :: NANG  = 2
    real*8, parameter     :: PII = 3.1415916536D0
    real*8, parameter     :: ONE = 1.0D0, TWO = 2.0D0
    complex*16, parameter :: COMPLEX_DZERO = (0.0D0,0.0D0)
    complex,    parameter :: COMPLEX_ZERO  = (0.0,0.0)


    integer    :: N, NN
    real*8     :: QSCA, QEXT, DX1, DXX1      
    real*8     :: CHI,CHI0,CHI1,DX,EN,P,PSI,PSI0,PSI1,XSTOP,YMOD               
    real*8     :: TWO_N_M_ONE, TWO_N_P_ONE, EN1, FACTOR
    complex*16 :: AN,AN1,BN,BN1,DREFRL,XI,XI1,Y, Y1, DREFRL1
    complex*16 :: D(NMX)
    complex*16 :: FAC1, FAC2
    complex*16 :: XBACK









































 



    SUCCESS = .TRUE.




    DX = REAL( X, 8 )

    DX1  = ONE / DX
    DXX1 = DX1 * DX1
    DREFRL = DCMPLX( REAL( REFREL ), IMAG( REFREL ) )
    DREFRL1 = ONE / DREFRL
    Y = DX * DREFRL
    Y1 = ONE / Y

 












    FACTOR = 1.0D0
 












 
    D(NMX) = COMPLEX_DZERO
    NN = NMX - 1
    DO N = 1,NN
       EN  = REAL( NMX - N + 1, 8 )


       D(NMX-N) = ( EN * Y1 ) - (ONE / ( D(NMX-N+1) + EN * Y1)) 
    END DO
 


 
    PSI0 =  COS(DX)
    PSI1 =  SIN(DX)
    CHI0 = -SIN(DX)
    CHI1 =  PSI0
    XI1  =  DCMPLX(PSI1,-CHI1)
    QSCA =  0.0D0
    GSCA =  0.0D0
    QEXT =  0.0D0
    P    = -ONE
    XBACK = COMPLEX_DZERO


    DO N = 1,NSTOP
       EN        = REAL( N, 8 )
       EN1       = ONE / EN
       TWO_N_M_ONE = TWO * EN - ONE




       PSI = TWO_N_M_ONE * PSI1 * DX1 - PSI0
       CHI = TWO_N_M_ONE * CHI1 * DX1 - CHI0
       XI  = DCMPLX(PSI,-CHI)
 


       FAC1 = D(N) * DREFRL1 + EN * DX1 
       AN   = (FAC1) * PSI - PSI1
       AN   = AN / ( (FAC1 )* XI - XI1 )
       FAC2 = ( DREFRL * D(N) + EN * DX1)
       BN   = ( FAC2) * PSI -PSI1
       BN   = BN / ((FAC2) * XI - XI1 )



       TWO_N_P_ONE = (TWO * EN + ONE)
       QEXT = QEXT + (TWO_N_P_ONE) * (REAL(AN) + REAL(BN) ) 
       QSCA = QSCA + (TWO_N_P_ONE) * ( ABS(AN)**2 + ABS(BN)**2 )
          

       FACTOR = -1.0d0 * FACTOR  
       XBACK = XBACK + (TWO_N_P_ONE) * factor * (AN - BN)
       

       
       GSCA = GSCA + REAL((TWO_N_P_ONE)/(EN * (EN + ONE)) *     &
              (REAL(AN)*REAL(BN)+IMAG(AN)*IMAG(BN)))

       IF (N .GT. 1)THEN
          GSCA = GSCA + REAL((EN - EN1) *                         &
                 (REAL(AN1)*REAL(AN) + IMAG(AN1)*IMAG(AN) +  &
                  REAL(BN1)*REAL(BN) + IMAG(BN1)*IMAG(BN)))
       ENDIF


       AN1 = AN
       BN1 = BN


       PSI0 = PSI1
       PSI1 = PSI
       CHI0 = CHI1
       CHI1 = CHI
       XI1  = DCMPLX(PSI1,-CHI1)

    END DO   
 



    GSCA  = REAL( TWO / QSCA ) * GSCA



    QQSCA = REAL( TWO * QSCA * DXX1 )
    QQEXT = REAL( TWO * QEXT * DXX1 )
    QBACK = REAL( REAL( 0.5D0 * XBACK * CONJG(XBACK), 8 ) * DXX1 ) 

  END subroutine BHMIE_FLEXI

END MODULE rrtmg_aero_optical_util_module




MODULE module_ra_rrtmg_sw_cmaq

contains


   Subroutine get_aerosol_Optics_RRTMG_SW ( ns, nmode,delta_z, INMASS_ws,     &
                                            INMASS_in, INMASS_ec, INMASS_ss,  &
                                            INMASS_h2o,  INDGN, INSIG,        &
                                            tauaer, waer, gaer )

















      use rrtmg_aero_optical_util_module

      implicit none     

      integer,intent(in) ::  ns      
                                     
      integer,intent(in) ::  nmode   
      real,intent(in)    ::  delta_z 





      real, intent(in) ::  INMASS_ws(nmode)   
      real, intent(in) ::  INMASS_in(nmode)   
      real, intent(in) ::  INMASS_ec(nmode)   
      real, intent(in) ::  INMASS_ss(nmode)   
      real, intent(in) ::  INMASS_h2o(nmode)  

      real, intent(in) ::  INDGN( nmode)      
      real, intent(in) ::  INSIG( nmode)      


      real, intent(out) ::  tauaer   
      real, intent(out) ::  waer     
      real, intent(out) ::  gaer     



      real    :: NR(nmode), NI(nmode)           
      complex :: refcor(nmode), refshell(nmode) 
      complex :: crefin(nmode)                  


      real :: DGNSHELL(nmode)    
      real :: DGNCORE (nmode)    
       

      real :: MVOL_ws(nmode)   
      real :: MVOL_in(nmode)   
      real :: MVOL_ec(nmode)   
      real :: MVOL_ss(nmode)   
      real :: MVOL_h2o(nmode)  


      real :: VOLCOR(nmode)    
      real :: VOLSHELL(nmode)  
                      
      integer :: m             
      real    :: bext          
      real    :: bscat         
      real    :: gfac          

      real    :: bextsum, bscatsum, bsgsum
 





      real, parameter ::  one3rd = 1.0 / 3.0 
      real  :: dfac      
                         
                         

      logical :: succesS



      real, parameter :: rhows = 1.8   

      real, parameter :: rhoin = 2.2   


      real, parameter :: rhoec = 1.8   

      real, parameter :: rhoh2o = 1.0  
       
      real, parameter :: rhoss = 2.2   



      real, parameter :: scalefactor = 1.0e-12


      real, parameter ::  cug2g = 1.0e-06


 
      real, parameter :: rhows1 = scalefactor / rhows    

      real, parameter :: rhoin1 = scalefactor /  rhoin   

      real, parameter :: rhoec1 = scalefactor / rhoec    

      real, parameter :: rhoh2o1 = scalefactor / rhoh2o  
       
      real, parameter :: rhoss1 = scalefactor / rhoss    

      integer,parameter ::  nspint_sw = 14 


      integer, parameter :: Band(nspint_sw) = (/ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 /)
      
      real, parameter :: LAMDA_SW(nspint_sw) = (/ 3.4615,  2.7885, 2.325,  2.046,  1.784,         &
                                                  1.4625,  1.2705, 1.0101, 0.7016, 0.53325,       &
                                                  0.38815, 0.299,  0.2316, 8.24 /) 
    















      real, parameter :: xnreal_ws(nspint_sw) = (/ 1.443, 1.420, 1.420, 1.420, 1.463, 1.510, 1.510,   &
                                                   1.520, 1.530, 1.530, 1.530, 1.530, 1.530, 1.710 /)
      real, parameter :: xnimag_ws(nspint_sw) = (/ 5.718E-3, 1.777E-2, 1.060E-2, 8.368E-3, 1.621E-2,  &
                                                   2.198E-2, 1.929E-2, 1.564E-2, 7.000E-3, 5.666E-3,  &
                                                   5.000E-3, 8.440E-3, 3.000E-2, 1.100E-1 /)


      real, parameter :: xnreal_ss(nspint_sw) = (/ 1.480, 1.534, 1.437, 1.448, 1.450, 1.462, 1.469,   &
                                                   1.470, 1.490, 1.500, 1.502, 1.510, 1.510, 1.510 /)

      real, parameter :: xnimag_ss(nspint_sw) = (/ 1.758E-3, 7.462E-3, 2.950E-3, 1.276E-3, 7.944E-4,  &
                                                   5.382E-4, 3.754E-4, 1.498E-4, 2.050E-7, 1.184E-8,  &
                                                   9.938E-8, 2.060E-6, 5.000E-6, 1.000E-2 /)


      real, parameter :: xnreal_in(nspint_sw) = (/ 1.272, 1.168, 1.208, 1.253, 1.329, 1.418, 1.456,   &
                                                   1.518, 1.530, 1.530, 1.530, 1.530, 1.530, 1.470 /)
      real, parameter :: xnimag_in(nspint_sw) = (/ 1.165E-2, 1.073E-2, 8.650E-3, 8.092E-3, 8.000E-3,  &
                                                   8.000E-3, 8.000E-3, 8.000E-3, 8.000E-3, 8.000E-3,  &
                                                   8.000E-3, 8.440E-3, 3.000E-2,9.000E-2 /)









































      real, parameter :: xnreal_ec(nspint_sw) = (/ 2.089, 2.014, 1.962, 1.950, 1.940, 1.930, 1.905,   &
                                                   1.870, 1.85,  1.85,  1.85,  1.85,  1.85,  2.589 /)
      real, parameter :: xnimag_ec(nspint_sw) = (/ 1.070, 0.939, 0.843, 0.784, 0.760, 0.749, 0.737,   &
                                                   0.726, 0.71,  0.71,  0.71,  0.71,  0.71,  1.771 /)	


      real, save :: xnreal_h2o(nspint_sw) = (/ 1.408, 1.324, 1.277, 1.302, 1.312, 1.321, 1.323,       &
                                               1.327, 1.331, 1.334, 1.340, 1.349, 1.362, 1.260 /)
      real, save :: xnimag_h2o(nspint_sw) = (/ 1.420E-2, 1.577E-1, 1.516E-3, 1.159E-3, 2.360E-4,      &
                                               1.713E-4, 2.425E-5, 3.125E-6, 3.405E-8, 1.639E-9,      &
                                               2.955E-9, 1.635E-8, 3.350E-8, 6.220E-2 /)


      
      bextsum  = 0.0
      bscatsum = 0.0
      bsgsum   = 0.0
      do m = 1, nmode



         MVOL_ws(m)  = rhows1  * INMASS_ws(m)
         MVOL_in(m)  = rhoin1  * INMASS_in(m)
         MVOL_ec(m)  = rhoec1  * INMASS_ec(m)
         MVOL_ss(m)  = rhoss1  * INMASS_ss(m)
         MVOL_h2o(m) = rhoh2o1 * INMASS_h2o(m)
      
         VOLSHELL(m) = MVOL_ws(m) + MVOL_in(m) + MVOL_ss(m) + MVOL_h2o(m)
         VOLCOR(m)   = MVOL_ec(m)


         if ( VOLCOR(m) .gt. 0.0 ) then




       

            dfac        = ( VOLCOR(m) / ( VOLSHELL(m) + VOLCOR(m) ) ) ** one3rd


            DGNSHELL(m) = INDGN(m)
            DGNCORE(M)  = dfac * INDGN(m)

         end if
        



         nr(m) = (MVOL_ws(m)  * xnreal_ws(ns) +              &
                  MVOL_in(m)  * xnreal_in(ns) +              &
                  MVOL_ss(m)  * xnreal_ss(ns) +              &

                  MVOL_h2o(m) * xnreal_h2o(ns)) / VOLSHELL(m)


         ni(m) = (MVOL_ws(m)  * xnimag_ws(ns) +              &
                  MVOL_in(m)  * xnimag_in(ns) +              &
                  MVOL_ss(m)  * xnimag_ss(ns) +              &

                  MVOL_h2o(m) * xnimag_h2o(ns)) / VOLSHELL(m)

         if ( VOLCOR(m) .gt. 0.0) then




            refcor(m)   = cmplx( xnreal_ec(ns), xnimag_ec(ns) ) 
            refshell(m) = cmplx(nr(m), ni(m) )

            CALL aero_optical_CS( LAMDA_SW(ns), refcor(m), refshell(m),   &
                                  VOLCOR(m),VOLSHELL(m), DGNCORE(m),      &
                                  DGNSHELL(m), INSIG(m),                  &                            
                                  bext, bscat, gfac, succesS )

         else if ( VOLSHELL(m) .gt. 0.0) then

            crefin(m) = cmplx(nr(m), ni(m) )

            CALL aero_optical2( LAMDA_SW(ns), crefin(m), VOLSHELL(m),     &
                                INDGN(m), INSIG(m),                       &
                                bext, bscat, gfac, success )
         else
            bext = 0.0
            bscat = 0.0
            gfac = 0.0
         end if       


         bextsum  = bextsum + bext
         bscatsum = bscatsum +bscat              
         bsgsum   = bsgsum + bscat * gfac




      end do 
           

      tauaer = bextsum * delta_z
      waer   = bscatsum / bextsum      
      gaer   = bsgsum / bscatsum

   end subroutine get_aerosol_Optics_RRTMG_SW

END MODULE module_ra_rrtmg_sw_cmaq
