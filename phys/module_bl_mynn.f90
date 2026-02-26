













































































































































































































































MODULE module_bl_mynn

  use module_bl_mynn_common,only: &
        cp        , cpv       , cliq       , cice      , &
        p608      , ep_2      , ep_3       , gtr       , &
        grav      , g_inv     , karman     , p1000mb   , &
        rcp       , r_d       , r_v        , rk        , &
        rvovrd    , svp1      , svp2       , svp3      , &
        xlf       , xlv       , xls        , xlscp     , &
        xlvcp     , tv0       , tv1        , tref      , &
        zero      , half      , one        , two       , &
        onethird  , twothirds , tkmin      , t0c       , &
        tice      , kind_phys


  IMPLICIT NONE




  REAL, PARAMETER :: cphm_st=5.0, cphm_unst=16.0, &
                     cphh_st=5.0, cphh_unst=16.0


  REAL, PARAMETER ::  &
       &pr  =  0.74,  &
       &g1  =  0.235, &  
       &b1  = 24.0,   &
       &b2  = 15.0,   &  
       &c2  =  0.729, &  
       &c3  =  0.340, &  
       &c4  =  0.0,   &
       &c5  =  0.2,   &
       &a1  = b1*( 1.0-3.0*g1 )/6.0, &

       &c1  = g1 -1.0/( 3.0*a1*2.88449914061481660), &
       &a2  = a1*( g1-c1 )/( g1*pr ), &
       &g2  = b2/b1*( 1.0-c3 ) +2.0*a1/b1*( 3.0-2.0*c2 )

  REAL, PARAMETER :: &
       &cc2 =  1.0-c2, &
       &cc3 =  1.0-c3, &
       &e1c =  3.0*a2*b2*cc3, &
       &e2c =  9.0*a1*a2*cc2, &
       &e3c =  9.0*a2*a2*cc2*( 1.0-c5 ), &
       &e4c = 12.0*a1*a2*cc2, &
       &e5c =  6.0*a1*a1



  REAL, PARAMETER :: qmin=0.0, zmax=1.0, Sqfac=3.0



  REAL, PARAMETER :: gpw=5./3., qcgmin=1.e-8, qkemin=1.e-12
  REAL, PARAMETER :: tliq = 269. 


  REAL, PARAMETER :: rr2=0.7071068, rrp=0.3989423

  
  
  
  
  
  
  
  
  REAL, PARAMETER :: CKmod=1.

  
  
  
  REAL, PARAMETER :: scaleaware=1.

  
  
  INTEGER, PARAMETER :: bl_mynn_topdown = 0
  
  INTEGER, PARAMETER :: bl_mynn_edmf_dd = 0

  
  INTEGER, PARAMETER :: dheat_opt = 1

  
  LOGICAL, PARAMETER :: env_subs = .false.

  
  
  INTEGER, PARAMETER :: bl_mynn_stfunc = 1

  
  LOGICAL, PARAMETER :: debug_code = .false.
  INTEGER, PARAMETER :: idbg = 23 






  REAL, PARAMETER:: J0= .611583699E03
  REAL, PARAMETER:: J1= .444606896E02
  REAL, PARAMETER:: J2= .143177157E01
  REAL, PARAMETER:: J3= .264224321E-1
  REAL, PARAMETER:: J4= .299291081E-3
  REAL, PARAMETER:: J5= .203154182E-5
  REAL, PARAMETER:: J6= .702620698E-8
  REAL, PARAMETER:: J7= .379534310E-11
  REAL, PARAMETER:: J8=-.321582393E-13

  REAL, PARAMETER:: K0= .609868993E03
  REAL, PARAMETER:: K1= .499320233E02
  REAL, PARAMETER:: K2= .184672631E01
  REAL, PARAMETER:: K3= .402737184E-1
  REAL, PARAMETER:: K4= .565392987E-3
  REAL, PARAMETER:: K5= .521693933E-5
  REAL, PARAMETER:: K6= .307839583E-7
  REAL, PARAMETER:: K7= .105785160E-9
  REAL, PARAMETER:: K8= .161444444E-12


  
  INTEGER :: mynn_level


CONTAINS









  SUBROUTINE mynn_bl_driver(            &
       &initflag,restart,cycling,       &
       &delt,dz,dx,znt,                 &
       &u,v,w,th,sqv3d,sqc3d,sqi3d,     &
       &qnc,qni,                        &
       &qnwfa,qnifa,qnbca,ozone,        &
       &p,exner,rho,t3d,                &
       &xland,ts,qsfc,ps,               &
       &ust,ch,hfx,qfx,rmol,wspd,       &
       &uoce,voce,                      & 
       &qke,qke_adv,                    &
       &sh3d,sm3d,                      &
       &nchem,kdvel,ndvel,              & 
       &chem3d,vdep,                    &
       &frp,emis_ant_no,                &
       &mix_chem,enh_mix,               & 
       &rrfs_sd,smoke_dbg,              & 
       &tsq,qsq,cov,                    &
       &rublten,rvblten,rthblten,       &
       &rqvblten,rqcblten,rqiblten,     &
       &rqncblten,rqniblten,            &
       &rqnwfablten,rqnifablten,        &
       &rqnbcablten,dozone,             &
       &exch_h,exch_m,                  &
       &pblh,kpbl,                      & 
       &el_pbl,                         &
       &dqke,qwt,qshear,qbuoy,qdiss,    &
       &qc_bl,qi_bl,cldfra_bl,          &
       &bl_mynn_tkeadvect,              &
       &tke_budget,                     &
       &bl_mynn_cloudpdf,               &
       &bl_mynn_mixlength,              &
       &icloud_bl,                      &
       &closure,                        &
       &bl_mynn_edmf,                   &
       &bl_mynn_edmf_mom,               &
       &bl_mynn_edmf_tke,               &
       &bl_mynn_mixscalars,             &
       &bl_mynn_output,                 &
       &bl_mynn_cloudmix,bl_mynn_mixqt, &
       &edmf_a,edmf_w,edmf_qt,          &
       &edmf_thl,edmf_ent,edmf_qc,      &
       &sub_thl3D,sub_sqv3D,            &
       &det_thl3D,det_sqv3D,            &
       &nupdraft,maxMF,ktop_plume,      &
       &spp_pbl,pattern_spp_pbl,        &
       &rthraten,                       &
       &FLAG_QC,FLAG_QI,FLAG_QNC,       &
       &FLAG_QNI,FLAG_QNWFA,FLAG_QNIFA, &
       &FLAG_QNBCA,                     &
       &IDS,IDE,JDS,JDE,KDS,KDE,        &
       &IMS,IME,JMS,JME,KMS,KME,        &
       &ITS,ITE,JTS,JTE,KTS,KTE         )
    


    INTEGER, INTENT(in) :: initflag
    
    LOGICAL, INTENT(in) :: restart,cycling
    INTEGER, INTENT(in) :: tke_budget
    INTEGER, INTENT(in) :: bl_mynn_cloudpdf
    INTEGER, INTENT(in) :: bl_mynn_mixlength
    INTEGER, INTENT(in) :: bl_mynn_edmf
    LOGICAL, INTENT(in) :: bl_mynn_tkeadvect
    INTEGER, INTENT(in) :: bl_mynn_edmf_mom
    INTEGER, INTENT(in) :: bl_mynn_edmf_tke
    INTEGER, INTENT(in) :: bl_mynn_mixscalars
    INTEGER, INTENT(in) :: bl_mynn_output
    INTEGER, INTENT(in) :: bl_mynn_cloudmix
    INTEGER, INTENT(in) :: bl_mynn_mixqt
    INTEGER, INTENT(in) :: icloud_bl
    REAL,    INTENT(in) :: closure

    LOGICAL, INTENT(in) :: FLAG_QI,FLAG_QNI,FLAG_QC,FLAG_QNC,&
                           FLAG_QNWFA,FLAG_QNIFA,FLAG_QNBCA

    LOGICAL, INTENT(IN) :: mix_chem,enh_mix,rrfs_sd,smoke_dbg

    INTEGER, INTENT(in) :: &
         & IDS,IDE,JDS,JDE,KDS,KDE &
         &,IMS,IME,JMS,JME,KMS,KME &
         &,ITS,ITE,JTS,JTE,KTS,KTE







    
    REAL, INTENT(in) :: delt
    REAL, DIMENSION(IMS:IME), INTENT(in) :: dx
    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(in) :: dz,      &
         &u,v,w,th,sqv3D,p,exner,rho,t3d
    REAL, DIMENSION(IMS:IME,KMS:KME), OPTIONAL, INTENT(in):: &
         &sqc3D,sqi3D,qni,qnc,qnwfa,qnifa,qnbca
    REAL, DIMENSION(IMS:IME,KMS:KME), OPTIONAL, INTENT(in):: ozone
    REAL, DIMENSION(IMS:IME), INTENT(in) :: xland,ust,       &
         &ch,ts,qsfc,ps,hfx,qfx,wspd,uoce,voce,znt

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(inout) ::       &
         &qke,tsq,qsq,cov,qke_adv

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(inout) ::       &
         &rublten,rvblten,rthblten,rqvblten,rqcblten,        &
         &rqiblten,rqniblten,rqncblten,                      &
         &rqnwfablten,rqnifablten,rqnbcablten
    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(inout) :: dozone

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(in)    :: rthraten

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(out)   ::       &
         &exch_h,exch_m

   
   REAL, DIMENSION(IMS:IME,KMS:KME), OPTIONAL, INTENT(inout) :: &
         & edmf_a,edmf_w,edmf_qt,edmf_thl,edmf_ent,edmf_qc,  &
         & sub_thl3D,sub_sqv3D,det_thl3D,det_sqv3D




    REAL, DIMENSION(IMS:IME), INTENT(inout) :: pblh,rmol

    REAL, DIMENSION(IMS:IME) :: psig_bl,psig_shcu

    INTEGER,DIMENSION(IMS:IME),INTENT(INOUT) ::             &
         &kpbl,nupdraft,ktop_plume

    REAL, DIMENSION(IMS:IME), INTENT(OUT) ::                &
         &maxmf

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(inout) ::      &
         &el_pbl

    REAL, DIMENSION(IMS:IME,KMS:KME), optional, INTENT(out) :: &
         &qwt,qshear,qbuoy,qdiss,dqke
    
    
    REAL, DIMENSION(kts:kte) :: qwt1,qshear1,qbuoy1,qdiss1, &
         &dqke1,diss_heat

    REAL, DIMENSION(IMS:IME,KMS:KME), intent(out) :: Sh3D,Sm3D

    REAL, DIMENSION(IMS:IME,KMS:KME), INTENT(inout) ::      &
         &qc_bl,qi_bl,cldfra_bl
    REAL, DIMENSION(KTS:KTE) :: qc_bl1D,qi_bl1D,cldfra_bl1D,&
                    qc_bl1D_old,qi_bl1D_old,cldfra_bl1D_old


    INTEGER, INTENT(IN   ) ::   nchem, kdvel, ndvel
    REAL,    DIMENSION(ims:ime, kms:kme, nchem), INTENT(INOUT), optional :: chem3d
    REAL,    DIMENSION(ims:ime, ndvel),   INTENT(IN),   optional :: vdep
    REAL,    DIMENSION(ims:ime),     INTENT(IN),    optional :: frp,EMIS_ANT_NO
    
    REAL,    DIMENSION(kts:kte  ,nchem) :: chem1
    REAL,    DIMENSION(kts:kte+1,nchem) :: s_awchem1
    REAL,    DIMENSION(ndvel)           :: vd1
    INTEGER :: ic


    INTEGER :: ITF,JTF,KTF, IMD,JMD
    INTEGER :: i,j,k,kproblem
    REAL, DIMENSION(KTS:KTE) :: thl,thvl,tl,qv1,qc1,qi1,sqw,&
         &el, dfm, dfh, dfq, tcd, qcd, pdk, pdt, pdq, pdc,  &
         &vt, vq, sgm, thlsg, sqwsg
    REAL, DIMENSION(KTS:KTE) :: thetav,sh,sm,u1,v1,w1,p1,   &
         &ex1,dz1,th1,tk1,rho1,qke1,tsq1,qsq1,cov1,         &
         &sqv,sqi,sqc,du1,dv1,dth1,dqv1,dqc1,dqi1,ozone1,   &
         &k_m1,k_h1,qni1,dqni1,qnc1,dqnc1,qnwfa1,qnifa1,    &
         &qnbca1,dqnwfa1,dqnifa1,dqnbca1,dozone1

    
    REAL, DIMENSION(KTS:KTE) :: dth1mf,dqv1mf,dqc1mf,du1mf,dv1mf
    REAL, DIMENSION(KTS:KTE) :: edmf_a1,edmf_w1,edmf_qt1,   &
         &edmf_thl1,edmf_ent1,edmf_qc1
    REAL, DIMENSION(KTS:KTE) :: edmf_a_dd1,edmf_w_dd1,      &
         &edmf_qt_dd1,edmf_thl_dd1,                         &
         &edmf_ent_dd1,edmf_qc_dd1
    REAL, DIMENSION(KTS:KTE) :: sub_thl,sub_sqv,sub_u,sub_v,&
                        det_thl,det_sqv,det_sqc,det_u,det_v
    REAL,DIMENSION(KTS:KTE+1) :: s_aw1,s_awthl1,s_awqt1,    &
                  s_awqv1,s_awqc1,s_awu1,s_awv1,s_awqke1,   &
                  s_awqnc1,s_awqni1,s_awqnwfa1,s_awqnifa1,  &
                  s_awqnbca1
    REAL,DIMENSION(KTS:KTE+1) :: sd_aw1,sd_awthl1,sd_awqt1, &
                  sd_awqv1,sd_awqc1,sd_awu1,sd_awv1,sd_awqke1

    REAL, DIMENSION(KTS:KTE+1) :: zw
    REAL :: cpm,sqcg,flt,fltv,flq,flqv,flqc,pmz,phh,exnerg,zet,phi_m,&
          & afk,abk,ts_decay, qc_bl2, qi_bl2,                        &
          & th_sfc,ztop_plume,sqc9,sqi9,wsp

    
    REAL, DIMENSION(ITS:ITE) :: maxKHtopdown
    REAL, DIMENSION(KTS:KTE) :: KHtopdown,TKEprodTD

    LOGICAL :: INITIALIZE_QKE,problem

    
    INTEGER,  INTENT(IN)                                     ::spp_pbl
    REAL, DIMENSION( ims:ime, kms:kme), INTENT(IN),OPTIONAL  ::pattern_spp_pbl
    REAL, DIMENSION(KTS:KTE)                                 ::rstoch_col

    
    INTEGER :: nsub
    real    :: delt2


    if (debug_code) then 
      do i=its,ite
        problem = .false.
        do k=kts,kte
          wsp  = sqrt(u(i,k)**2 + v(i,k)**2)
          if (abs(hfx(i)) > 1200. .or. abs(qfx(i)) > 0.001 .or.         &
              wsp > 200. .or. t3d(i,k) > 360. .or. t3d(i,k) < 160. .or. &
              sqv3d(i,k)< 0.0 .or. sqc3d(i,k)< 0.0 ) then
             kproblem = k
             problem = .true.
             print*,"Incoming problem at: i=",i," k=1"
             print*," QFX=",qfx(i)," HFX=",hfx(i)
             print*," wsp=",wsp," T=",t3d(i,k)
             print*," qv=",sqv3d(i,k)," qc=",sqc3d(i,k)
             print*," u*=",ust(i)," wspd=",wspd(i)
             print*," xland=",xland(i)," ts=",ts(i)
             print*," z/L=",0.5*dz(i,1)*rmol(i)," ps=",ps(i)
             print*," znt=",znt(i)," dx=",dx(i)
          endif
        enddo
        if (problem) then
          print*,"===tk:",t3d(i,max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qv:",sqv3d(i,max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qc:",sqc3d(i,max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qi:",sqi3d(i,max(kproblem-3,1):min(kproblem+3,kte))
          print*,"====u:",u(i,max(kproblem-3,1):min(kproblem+3,kte))
          print*,"====v:",v(i,max(kproblem-3,1):min(kproblem+3,kte))
        endif
      enddo
    endif


    IMD=(IMS+IME)/2
    JMD=(JMS+JME)/2


    JTF=JTE
    ITF=ITE
    KTF=KTE

    IF (bl_mynn_output > 0) THEN 
       edmf_a(its:ite,kts:kte)=0.
       edmf_w(its:ite,kts:kte)=0.
       edmf_qt(its:ite,kts:kte)=0.
       edmf_thl(its:ite,kts:kte)=0.
       edmf_ent(its:ite,kts:kte)=0.
       edmf_qc(its:ite,kts:kte)=0.
       sub_thl3D(its:ite,kts:kte)=0.
       sub_sqv3D(its:ite,kts:kte)=0.
       det_thl3D(its:ite,kts:kte)=0.
       det_sqv3D(its:ite,kts:kte)=0.

       
       
       
       
       
       
    ENDIF
    ktop_plume(its:ite)=0   
    nupdraft(its:ite)=0     
    maxmf(its:ite)=0.
    maxKHtopdown(its:ite)=0.

    




    IF (initflag > 0 .and. .not.restart) THEN

       
       IF ( (restart .or. cycling)) THEN
          IF (MAXVAL(QKE(its:ite,kts)) < 0.0002) THEN
             INITIALIZE_QKE = .TRUE.
             
          ELSE
             INITIALIZE_QKE = .FALSE.
             
          ENDIF
       ELSE 
          INITIALIZE_QKE = .TRUE.
          
       ENDIF
 
       if (.not.restart .or. .not.cycling) THEN
         Sh3D(its:ite,kts:kte)=0.
         Sm3D(its:ite,kts:kte)=0.
         el_pbl(its:ite,kts:kte)=0.
         tsq(its:ite,kts:kte)=0.
         qsq(its:ite,kts:kte)=0.
         cov(its:ite,kts:kte)=0.
         cldfra_bl(its:ite,kts:kte)=0.
         qc_bl(its:ite,kts:kte)=0.
         qke(its:ite,kts:kte)=0.
       else
         qc_bl1D(kts:kte)=0.0
         qi_bl1D(kts:kte)=0.0
         cldfra_bl1D(kts:kte)=0.0
       end if
       dqc1(kts:kte)=0.0
       dqi1(kts:kte)=0.0
       dqni1(kts:kte)=0.0
       dqnc1(kts:kte)=0.0
       dqnwfa1(kts:kte)=0.0
       dqnifa1(kts:kte)=0.0
       dqnbca1(kts:kte)=0.0
       dozone1(kts:kte)=0.0
       qc_bl1D_old(kts:kte)=0.0
       cldfra_bl1D_old(kts:kte)=0.0
       edmf_a1(kts:kte)=0.0
       edmf_w1(kts:kte)=0.0
       edmf_qc1(kts:kte)=0.0
       edmf_a_dd1(kts:kte)=0.0
       edmf_w_dd1(kts:kte)=0.0
       edmf_qc_dd1(kts:kte)=0.0
       sgm(kts:kte)=0.0
       vt(kts:kte)=0.0
       vq(kts:kte)=0.0

       DO k=KTS,KTE
          DO i=ITS,ITF
             exch_m(i,k)=0.
             exch_h(i,k)=0.
          ENDDO
       ENDDO

       IF (tke_budget .eq. 1) THEN
          DO k=KTS,KTE
             DO i=ITS,ITF
                qWT(i,k)=0.
                qSHEAR(i,k)=0.
                qBUOY(i,k)=0.
                qDISS(i,k)=0.
                dqke(i,k)=0.
             ENDDO
          ENDDO
       ENDIF

       DO i=ITS,ITF
          DO k=KTS,KTE 
                dz1(k)=dz(i,k)
                u1(k) = u(i,k)
                v1(k) = v(i,k)
                w1(k) = w(i,k)
                th1(k)=th(i,k)
                tk1(k)=T3D(i,k)
                ex1(k)=exner(i,k)
                rho1(k)=rho(i,k)
                sqc(k)=sqc3D(i,k) 
                sqv(k)=sqv3D(i,k) 
                thetav(k)=th(i,k)*(1.+0.608*sqv(k))
                IF (icloud_bl > 0) THEN
                   CLDFRA_BL1D(k)=CLDFRA_BL(i,k)
                   QC_BL1D(k)=QC_BL(i,k)
                   QI_BL1D(k)=QI_BL(i,k)
                ENDIF
                IF (FLAG_QI ) THEN
                   sqi(k)=sqi3D(i,k) 
                   sqw(k)=sqv(k)+sqc(k)+sqi(k)
                   thl(k)=th1(k) - xlvcp/ex1(k)*sqc(k) &
                       &         - xlscp/ex1(k)*sqi(k)
                   
                   
                   
                   
                   
                   IF(sqc(k)<1e-6 .and. sqi(k)<1e-8 .and. CLDFRA_BL1D(k)>0.001)THEN
                      sqc9=QC_BL1D(k)*CLDFRA_BL1D(k)
                      sqi9=QI_BL1D(k)*CLDFRA_BL1D(k)
                   ELSE
                      sqc9=sqc(k)
                      sqi9=sqi(k)
                   ENDIF
                   thlsg(k)=th1(k) - xlvcp/ex1(k)*sqc9 &
                         &         - xlscp/ex1(k)*sqi9
                   sqwsg(k)=sqv(k)+sqc9+sqi9
                ELSE
                   sqi(k)=0.0
                   sqw(k)=sqv(k)+sqc(k)
                   thl(k)=th1(k)-xlvcp/ex1(k)*sqc(k)
                   
                   
                   
                   
                   IF(sqc(k)<1e-6 .and. CLDFRA_BL1D(k)>0.001)THEN
                            sqc9=QC_BL1D(k)*CLDFRA_BL1D(k)
                      sqi9=0.0
                   ELSE
                      sqc9=sqc(k)
                      sqi9=0.0
                   ENDIF
                   thlsg(k)=th1(k) - xlvcp/ex1(k)*sqc9 &
                         &         - xlscp/ex1(k)*sqi9
                   sqwsg(k)=sqv(k)+sqc9+sqi9
                ENDIF
                thvl(k)=thlsg(k)*(1.+0.61*sqv(k))

                IF (k==kts) THEN
                   zw(k)=0.
                ELSE
                   zw(k)=zw(k-1)+dz(i,k-1)
                ENDIF
                IF (INITIALIZE_QKE) THEN
                   
                   
                   
                   qke1(k)=5.*ust(i) * MAX((ust(i)*700. - zw(k))/(MAX(ust(i),0.01)*700.), 0.01)
                ELSE
                   qke1(k)=qke(i,k)
                ENDIF
                el(k)=el_pbl(i,k)
                sh(k)=Sh3D(i,k)
                sm(k)=Sm3D(i,k)
                tsq1(k)=tsq(i,k)
                qsq1(k)=qsq(i,k)
                cov1(k)=cov(i,k)
                if (spp_pbl==1) then
                    rstoch_col(k)=pattern_spp_pbl(i,k)
                else
                    rstoch_col(k)=0.0
                endif

             ENDDO

             zw(kte+1)=zw(kte)+dz(i,kte)


             CALL GET_PBLH(KTS,KTE,PBLH(i),thetav,&
               &  Qke1,zw,dz1,xland(i),KPBL(i))
             


             IF (scaleaware > 0.) THEN
                CALL SCALE_AWARE(dx(i),PBLH(i),Psig_bl(i),Psig_shcu(i))
             ELSE
                Psig_bl(i)=1.0
                Psig_shcu(i)=1.0
             ENDIF

             




             CALL mym_initialize (                & 
                  &kts,kte,xland(i),              &
                  &dz1, dx(i), zw,                &
                  &u1, v1, thl, sqv,              &
                  &thlsg, sqwsg,                  &
                  &PBLH(i), th1, thetav, sh, sm,  &
                  &ust(i), rmol(i),               &
                  &el, Qke1, Tsq1, Qsq1, Cov1,    &
                  &Psig_bl(i), cldfra_bl1D,       &
                  &bl_mynn_mixlength,             &
                  &edmf_w1,edmf_a1,               &
                  &INITIALIZE_QKE,                &
                  &spp_pbl,rstoch_col )

             IF (.not.restart) THEN
                
                DO k=KTS,KTE 
                   el_pbl(i,k)=el(k)
                   sh3d(i,k)=sh(k)
                   sm3d(i,k)=sm(k)
                   qke(i,k)=qke1(k)
                   tsq(i,k)=tsq1(k)
                   qsq(i,k)=qsq1(k)
                   cov(i,k)=cov1(k)
                ENDDO
                
                IF (bl_mynn_tkeadvect) THEN
                   DO k=KTS,KTE
                      qke_adv(i,k)=qke1(k)
                   ENDDO
                ENDIF
             ENDIF











       ENDDO 

    ENDIF 



    
    IF (bl_mynn_tkeadvect) THEN
       qke=qke_adv
    ENDIF

    DO i=ITS,ITF
       DO k=KTS,KTE 
            
             IF (tke_budget .eq. 1) THEN
                dqke(i,k)=qke(i,k)
             END IF
             IF (icloud_bl > 0) THEN
                CLDFRA_BL1D(k)=CLDFRA_BL(i,k)
                QC_BL1D(k)=QC_BL(i,k)
                QI_BL1D(k)=QI_BL(i,k)
                cldfra_bl1D_old(k)=cldfra_bl(i,k)
                qc_bl1D_old(k)=qc_bl(i,k)
                qi_bl1D_old(k)=qi_bl(i,k)
             else
                CLDFRA_BL1D(k)=0.0
                QC_BL1D(k)=0.0
                QI_BL1D(k)=0.0
                cldfra_bl1D_old(k)=0.0
                qc_bl1D_old(k)=0.0
                qi_bl1D_old(k)=0.0
             ENDIF
             dz1(k)= dz(i,k)
             u1(k) = u(i,k)
             v1(k) = v(i,k)
             w1(k) = w(i,k)
             th1(k)= th(i,k)
             tk1(k)=T3D(i,k)
             p1(k) = p(i,k)
             ex1(k)= exner(i,k)
             rho1(k)=rho(i,k)
             sqv(k)= sqv3D(i,k) 
             sqc(k)= sqc3D(i,k) 
             qv1(k)= sqv(k)/(1.-sqv(k))
             qc1(k)= sqc(k)/(1.-sqv(k))
             dqc1(k)=0.0
             dqi1(k)=0.0
             dqni1(k)=0.0
             dqnc1(k)=0.0
             dqnwfa1(k)=0.0
             dqnifa1(k)=0.0
             dqnbca1(k)=0.0
             dozone1(k)=0.0
             IF(FLAG_QI)THEN
                sqi(k)= sqi3D(i,k) 
                qi1(k)= sqi(k)/(1.-sqv(k))
                sqw(k)= sqv(k)+sqc(k)+sqi(k)
                thl(k)= th1(k) - xlvcp/ex1(k)*sqc(k) &
                     &         - xlscp/ex1(k)*sqi(k)
                
                
                
                
                
                IF(sqc(k)<1e-6 .and. sqi(k)<1e-8 .and. CLDFRA_BL1D(k)>0.001)THEN
                   sqc9=QC_BL1D(k)*CLDFRA_BL1D(k)
                   sqi9=QI_BL1D(k)*CLDFRA_BL1D(k)
                ELSE
                   sqc9=sqc(k)
                   sqi9=sqi(k)
                ENDIF
                thlsg(k)=th1(k) - xlvcp/ex1(k)*sqc9 &
                      &         - xlscp/ex1(k)*sqi9
                sqwsg(k)=sqv(k)+sqc9+sqi9
             ELSE
                qi1(k)=0.0
                sqi(k)=0.0
                sqw(k)= sqv(k)+sqc(k)
                thl(k)= th1(k)-xlvcp/ex1(k)*sqc(k)
                
                
                
                
                IF(sqc(k)<1e-6 .and. CLDFRA_BL1D(k)>0.001)THEN
                   sqc9=QC_BL1D(k)*CLDFRA_BL1D(k)
                   sqi9=QI_BL1D(k)*CLDFRA_BL1D(k)
                ELSE
                   sqc9=sqc(k)
                   sqi9=0.0
                ENDIF
                thlsg(k)=th1(k) - xlvcp/ex1(k)*sqc9 &
                      &         - xlscp/ex1(k)*sqi9 
            ENDIF
            thetav(k)=th1(k)*(1.+0.608*sqv(k))
            thvl(k)  =thlsg(k) *(1.+0.608*sqv(k))

             IF (FLAG_QNI ) THEN
                qni1(k)=qni(i,k)
             ELSE
                qni1(k)=0.0
             ENDIF
             IF (FLAG_QNC ) THEN
                qnc1(k)=qnc(i,k)
             ELSE
                qnc1(k)=0.0
             ENDIF
             IF (FLAG_QNWFA ) THEN
                qnwfa1(k)=qnwfa(i,k)
             ELSE
                qnwfa1(k)=0.0
             ENDIF
             IF (FLAG_QNIFA ) THEN
                qnifa1(k)=qnifa(i,k)
             ELSE
                qnifa1(k)=0.0
             ENDIF
             IF (FLAG_QNBCA .and. PRESENT(qnbca)) THEN
                qnbca1(k)=qnbca(i,k)
             ELSE
                qnbca1(k)=0.0
             ENDIF
             IF (PRESENT(ozone)) THEN
                ozone1(k)=ozone(i,k)
             ELSE
                ozone1(k)=0.0
             ENDIF
             el(k) = el_pbl(i,k)
             qke1(k)=qke(i,k)
             sh(k)  =sh3d(i,k)
             sm(k)  =sm3d(i,k)
             tsq1(k)=tsq(i,k)
             qsq1(k)=qsq(i,k)
             cov1(k)=cov(i,k)
             if (spp_pbl==1) then
                rstoch_col(k)=pattern_spp_pbl(i,k)
             else
                rstoch_col(k)=0.0
             endif

             
             edmf_a1(k)=0.0
             edmf_w1(k)=0.0
             edmf_qc1(k)=0.0
             s_aw1(k)=0.
             s_awthl1(k)=0.
             s_awqt1(k)=0.
             s_awqv1(k)=0.
             s_awqc1(k)=0.
             s_awu1(k)=0.
             s_awv1(k)=0.
             s_awqke1(k)=0.
             s_awqnc1(k)=0.
             s_awqni1(k)=0.
             s_awqnwfa1(k)=0.
             s_awqnifa1(k)=0.
             s_awqnbca1(k)=0.
             
             edmf_a_dd1(k)=0.0
             edmf_w_dd1(k)=0.0
             edmf_qc_dd1(k)=0.0
             sd_aw1(k)=0.
             sd_awthl1(k)=0.
             sd_awqt1(k)=0.
             sd_awqv1(k)=0.
             sd_awqc1(k)=0.
             sd_awu1(k)=0.
             sd_awv1(k)=0.
             sd_awqke1(k)=0.
             sub_thl(k)=0.
             sub_sqv(k)=0.
             sub_u(k)=0.
             sub_v(k)=0.
             det_thl(k)=0.
             det_sqv(k)=0.
             det_sqc(k)=0.
             det_u(k)=0.
             det_v(k)=0.

             IF (k==kts) THEN
                zw(k)=0.
             ELSE
                zw(k)=zw(k-1)+dz(i,k-1)
             ENDIF
          ENDDO 

          
             if  ( mix_chem ) then
                do ic = 1,ndvel
                   vd1(ic) = vdep(i,ic) 
                enddo
                do k = kts,kte
                   do ic = 1,nchem
                      chem1(k,ic) = chem3d(i,k,ic)
                      s_awchem1(k,ic)=0.
                   enddo
                enddo
             else
                do ic = 1,ndvel
                   vd1(ic) = 0. 
                enddo
                do k = kts,kte
                   do ic = 1,nchem
                      chem1(k,ic) = 0.
                      s_awchem1(k,ic)=0.
                   enddo
                enddo
             endif

          zw(kte+1)=zw(kte)+dz(i,kte)
          
          s_aw1(kte+1)=0.
          s_awthl1(kte+1)=0.
          s_awqt1(kte+1)=0.
          s_awqv1(kte+1)=0.
          s_awqc1(kte+1)=0.
          s_awu1(kte+1)=0.
          s_awv1(kte+1)=0.
          s_awqke1(kte+1)=0.
          s_awqnc1(kte+1)=0.
          s_awqni1(kte+1)=0.
          s_awqnwfa1(kte+1)=0.
          s_awqnifa1(kte+1)=0.
          s_awqnbca1(kte+1)=0.
          sd_aw1(kte+1)=0.
          sd_awthl1(kte+1)=0.
          sd_awqt1(kte+1)=0.
          sd_awqv1(kte+1)=0.
          sd_awqc1(kte+1)=0.
          sd_awu1(kte+1)=0.
          sd_awv1(kte+1)=0.
          sd_awqke1(kte+1)=0.
          IF ( mix_chem ) THEN
             DO ic = 1,nchem
                s_awchem1(kte+1,ic)=0.
             ENDDO
          ENDIF



          CALL GET_PBLH(KTS,KTE,PBLH(i),thetav,&
          & Qke1,zw,dz1,xland(i),KPBL(i))





          IF (scaleaware > 0.) THEN
             CALL SCALE_AWARE(dx(i),PBLH(i),Psig_bl(i),Psig_shcu(i))
          ELSE
             Psig_bl(i)=1.0
             Psig_shcu(i)=1.0
          ENDIF

          sqcg= 0.0   
          cpm=cp*(1.+0.84*qv1(kts))
          exnerg=(ps(i)/p1000mb)**rcp

          
          
          
          
          
          
          
          flqv   = qfx(i)/rho1(kts)
          flqc   = 0.0 
          th_sfc = ts(i)/ex1(kts)

          
          flq =flqv+flqc                  
          flt =hfx(i)/(rho1(kts)*cpm )-xlvcp*flqc/ex1(kts)  
          fltv=flt + flqv*p608*th_sfc     

          
          rmol(i) = -karman*gtr*fltv/max(ust(i)**3,1.0e-6)
          zet = 0.5*dz(i,kts)*rmol(i)
          zet = MAX(zet, -20.)
          zet = MIN(zet,  20.)
          
          if (bl_mynn_stfunc == 0) then
             
             if ( zet >= 0.0 ) then
                pmz = 1.0 + (cphm_st-1.0) * zet
                phh = 1.0 +  cphh_st      * zet
             else
                pmz = 1.0/    (1.0-cphm_unst*zet)**0.25 - zet
                phh = 1.0/SQRT(1.0-cphh_unst*zet)
             end if
          else
             
             phi_m = phim(zet)
             pmz   = phi_m - zet
             phh   = phih(zet)
          end if






          CALL  mym_condensation ( kts,kte,      &
               &dx(i),dz1,zw,xland(i),           &
               &thl,sqw,sqv,sqc,sqi,             &
               &p1,ex1,tsq1,qsq1,cov1,           &
               &Sh,el,bl_mynn_cloudpdf,          &
               &qc_bl1D,qi_bl1D,cldfra_bl1D,     &
               &PBLH(i),HFX(i),                  &
               &Vt, Vq, th1, sgm, rmol(i),       &
               &spp_pbl, rstoch_col              )




          IF (bl_mynn_topdown.eq.1)then
             CALL topdown_cloudrad(kts,kte,dz1,zw,          &
                &xland(i),kpbl(i),PBLH(i),                  &
                &sqc,sqi,sqw,thl,th1,ex1,p1,rho1,thetav,    &
                &cldfra_bl1D,rthraten(i,:),                 &
                &maxKHtopdown(i),KHtopdown,TKEprodTD        )
          ELSE
             maxKHtopdown(i)  = 0.0
             KHtopdown(kts:kte) = 0.0
             TKEprodTD(kts:kte) = 0.0
          ENDIF

          IF (bl_mynn_edmf > 0) THEN
            
            CALL DMP_mf(                          &
               &kts,kte,delt,zw,dz1,p1,rho1,      &
               &bl_mynn_edmf_mom,                 &
               &bl_mynn_edmf_tke,                 &
               &bl_mynn_mixscalars,               &
               &u1,v1,w1,th1,thl,thetav,tk1,      &
               &sqw,sqv,sqc,qke1,                 &
               &qnc1,qni1,qnwfa1,qnifa1,qnbca1,   &
               &ex1,Vt,Vq,sgm,                    &
               &ust(i),flt,fltv,flq,flqv,         &
               &PBLH(i),KPBL(i),DX(i),            &
               &xland(i),th_sfc,                  &
            
            
            
               & edmf_a1,edmf_w1,edmf_qt1,        &
               & edmf_thl1,edmf_ent1,edmf_qc1,    &
            
               & s_aw1,s_awthl1,s_awqt1,          &
               & s_awqv1,s_awqc1,                 &
               & s_awu1,s_awv1,s_awqke1,          &
               & s_awqnc1,s_awqni1,               &
               & s_awqnwfa1,s_awqnifa1,s_awqnbca1,&
               & sub_thl,sub_sqv,                 &
               & sub_u,sub_v,                     &
               & det_thl,det_sqv,det_sqc,         &
               & det_u,det_v,                     &
            
               & nchem,chem1,s_awchem1,           &
               & mix_chem,                        &
               & qc_bl1D,cldfra_bl1D,             &
               & qc_bl1D_old,cldfra_bl1D_old,     &
               & FLAG_QC,FLAG_QI,                 &
               & FLAG_QNC,FLAG_QNI,               &
               & FLAG_QNWFA,FLAG_QNIFA,FLAG_QNBCA,&
               & Psig_shcu(i),                    &
               & nupdraft(i),ktop_plume(i),       &
               & maxmf(i),ztop_plume,             &
               & spp_pbl,rstoch_col               )
          ENDIF

          IF (bl_mynn_edmf_dd == 1) THEN
            CALL DDMF_JPL(kts,kte,delt,zw,dz1,p1, &
              &u1,v1,th1,thl,thetav,tk1,          &
              sqw,sqv,sqc,rho1,ex1,               &
              &ust(i),flt,flq,                    &
              &PBLH(i),KPBL(i),                   &
              &edmf_a_dd1,edmf_w_dd1,edmf_qt_dd1, &
              &edmf_thl_dd1,edmf_ent_dd1,         &
              &edmf_qc_dd1,                       &
              &sd_aw1,sd_awthl1,sd_awqt1,         &
              &sd_awqv1,sd_awqc1,sd_awu1,sd_awv1, &
              &sd_awqke1,                         &
              &qc_bl1d,cldfra_bl1d,               &
              &rthraten(i,:)                      )
          ENDIF

          
          
          delt2 = delt 

          CALL mym_turbulence (                  & 
               &kts,kte,xland(i),closure,        &
               &dz1, DX(i), zw,                  &
               &u1, v1, thl, thetav, sqc, sqw,   &
               &thlsg, sqwsg,                    &
               &qke1, tsq1, qsq1, cov1,          &
               &vt, vq,                          &
               &rmol(i), flt, flq,               &
               &PBLH(i),th1,                     &
               &Sh,Sm,el,                        &
               &Dfm,Dfh,Dfq,                     &
               &Tcd,Qcd,Pdk,                     &
               &Pdt,Pdq,Pdc,                     &
               &qWT1,qSHEAR1,qBUOY1,qDISS1,      &
               &tke_budget,                      &
               &Psig_bl(i),Psig_shcu(i),         &
               &cldfra_bl1D,bl_mynn_mixlength,   &
               &edmf_w1,edmf_a1,                 &
               &TKEprodTD,                       &
               &spp_pbl,rstoch_col)




          CALL mym_predict (kts,kte,closure,     &
               &delt2, dz1,                      &
               &ust(i), flt, flq, pmz, phh,      &
               &el, dfq, rho1, pdk, pdt, pdq, pdc,&
               &Qke1, Tsq1, Qsq1, Cov1,          &
               &s_aw1, s_awqke1, bl_mynn_edmf_tke,&
               &qWT1, qDISS1,tke_budget          ) 

          if (dheat_opt > 0) then
             DO k=kts,kte-1
                
                diss_heat(k) = MIN(MAX(1.0*(qke1(k)**1.5)/(b1*MAX(0.5*(el(k)+el(k+1)),1.))/cp, 0.0),0.002)
                
                diss_heat(k) = diss_heat(k) * exp(-10000./MAX(p1(k),1.)) 
             ENDDO
             diss_heat(kte) = 0.
          else
             diss_heat(1:kte) = 0.
          endif



          CALL mynn_tendencies(kts,kte,i,        &
               &delt, dz1, rho1,                 &
               &u1, v1, th1, tk1, qv1,           &
               &qc1, qi1, qnc1, qni1,            &
               &ps(i), p1, ex1, thl,             &
               &sqv, sqc, sqi, sqw,              &
               &qnwfa1, qnifa1, qnbca1, ozone1,  &
               &ust(i),flt,flq,flqv,flqc,        &
               &wspd(i),uoce(i),voce(i),         &
               &tsq1, qsq1, cov1,                &
               &tcd, qcd,                        &
               &dfm, dfh, dfq,                   &
               &Du1, Dv1, Dth1, Dqv1,            &
               &Dqc1, Dqi1, Dqnc1, Dqni1,        &
               &Dqnwfa1, Dqnifa1, Dqnbca1,       &
               &Dozone1,                         &
               &diss_heat,                       &
               
               &s_aw1,s_awthl1,s_awqt1,          &
               &s_awqv1,s_awqc1,s_awu1,s_awv1,   &
               &s_awqnc1,s_awqni1,               &
               &s_awqnwfa1,s_awqnifa1,s_awqnbca1,&
               &sd_aw1,sd_awthl1,sd_awqt1,       &
               &sd_awqv1,sd_awqc1,               &
               sd_awu1,sd_awv1,                  &
               &sub_thl,sub_sqv,                 &
               &sub_u,sub_v,                     &
               &det_thl,det_sqv,det_sqc,         &
               &det_u,det_v,                     &
               &FLAG_QC,FLAG_QI,FLAG_QNC,        &
               &FLAG_QNI,FLAG_QNWFA,FLAG_QNIFA,  &
               &FLAG_QNBCA,                      &
               &cldfra_bl1d,                     &
               &bl_mynn_cloudmix,                &
               &bl_mynn_mixqt,                   &
               &bl_mynn_edmf,                    &
               &bl_mynn_edmf_mom,                &
               &bl_mynn_mixscalars               )


          IF ( mix_chem ) THEN
            IF ( rrfs_sd ) THEN 
             CALL mynn_mix_chem(kts,kte,i,       &
                  &delt, dz1, pblh(i),           &
                  &nchem, kdvel, ndvel,          &
                  &chem1, vd1,                   &
                  &rho1,flt,                     &
                  &tcd, qcd,                     &
                  &dfh,                          &
                  &s_aw1,s_awchem1,              &
                  &emis_ant_no(i),               &
                  &frp(i), rrfs_sd,              &
                  &enh_mix, smoke_dbg            )
             ELSE
              CALL mynn_mix_chem(kts,kte,i,       &
                   &delt, dz1, pblh(i),           &
                   &nchem, kdvel, ndvel,          &
                   &chem1, vd1,                   &
                   &rho1,flt,                     &
                   &tcd, qcd,                     &
                   &dfh,                          &
                   &s_aw1,s_awchem1,              &
                   &zero,                         &
                   &zero, rrfs_sd,                &
                   &enh_mix, smoke_dbg            )
             ENDIF
             DO ic = 1,nchem
                DO k = kts,kte
                   chem3d(i,k,ic) = max(1.e-12, chem1(k,ic))
                ENDDO
             ENDDO
          ENDIF
 
          CALL retrieve_exchange_coeffs(kts,kte,&
               &dfm, dfh, dz1, K_m1, K_h1)

          
          do k=kts,kte
             exch_m(i,k)=K_m1(k)
             exch_h(i,k)=K_h1(k)
             rublten(i,k)=du1(k)
             rvblten(i,k)=dv1(k)
             rthblten(i,k)=dth1(k)
             rqvblten(i,k)=dqv1(k)
             if (bl_mynn_cloudmix > 0) then
               if (present(sqc3D) .and. flag_qc) rqcblten(i,k)=dqc1(k)
               if (present(sqi3D) .and. flag_qi) rqiblten(i,k)=dqi1(k)
             else
               if (present(sqc3D) .and. flag_qc) rqcblten(i,k)=0.
               if (present(sqi3D) .and. flag_qi) rqiblten(i,k)=0.
             endif
             if (bl_mynn_cloudmix > 0 .and. bl_mynn_mixscalars > 0) then
               if (present(qnc) .and. flag_qnc) rqncblten(i,k)=dqnc1(k)
               if (present(qni) .and. flag_qni) rqniblten(i,k)=dqni1(k)
               if (present(qnwfa) .and. flag_qnwfa) rqnwfablten(i,k)=dqnwfa1(k)
               if (present(qnifa) .and. flag_qnifa) rqnifablten(i,k)=dqnifa1(k)
               if (present(qnbca) .and. flag_qnbca) rqnbcablten(i,k)=dqnbca1(k)
             else
               if (present(qnc) .and. flag_qnc) rqncblten(i,k)=0.
               if (present(qni) .and. flag_qni) rqniblten(i,k)=0.
               if (present(qnwfa) .and. flag_qnwfa) rqnwfablten(i,k)=0.
               if (present(qnifa) .and. flag_qnifa) rqnifablten(i,k)=0.
               if (present(qnbca) .and. flag_qnbca) rqnbcablten(i,k)=0.
             endif
             dozone(i,k)=dozone1(k)

             if (icloud_bl > 0) then
                qc_bl(i,k)=qc_bl1D(k)
                qi_bl(i,k)=qi_bl1D(k)
                cldfra_bl(i,k)=cldfra_bl1D(k)
             endif

             el_pbl(i,k)=el(k)
             qke(i,k)=qke1(k)
             tsq(i,k)=tsq1(k)
             qsq(i,k)=qsq1(k)
             cov(i,k)=cov1(k)
             sh3d(i,k)=sh(k)
             sm3d(i,k)=sm(k)
          enddo 

          if (tke_budget .eq. 1) then
             
             
             k=kts
             qSHEAR1(k)=4.*(ust(i)**3*phi_m/(karman*dz(i,k)))-qSHEAR1(k+1) 
             qBUOY1(k)=4.*(-ust(i)**3*zet/(karman*dz(i,k)))-qBUOY1(k+1) 
             
             do k = kts,kte-1
                qSHEAR(i,k)=0.5*(qSHEAR1(k)+qSHEAR1(k+1)) 
                qBUOY(i,k)=0.5*(qBUOY1(k)+qBUOY1(k+1)) 
                qWT(i,k)=qWT1(k)
                qDISS(i,k)=qDISS1(k)
                dqke(i,k)=(qke1(k)-dqke(i,k))*0.5/delt
             enddo
             
             k=kte
             qSHEAR(i,k)=0.
             qBUOY(i,k)=0.
             qWT(i,k)=0.
             qDISS(i,k)=0.
             dqke(i,k)=0.
          endif

          
          if (bl_mynn_output > 0) THEN 
             if (bl_mynn_edmf > 0) THEN
                DO k = kts,kte
                   edmf_a(i,k)=edmf_a1(k)
                   edmf_w(i,k)=edmf_w1(k)
                   edmf_qt(i,k)=edmf_qt1(k)
                   edmf_thl(i,k)=edmf_thl1(k)
                   edmf_ent(i,k)=edmf_ent1(k)
                   edmf_qc(i,k)=edmf_qc1(k)
                   sub_thl3D(i,k)=sub_thl(k)
                   sub_sqv3D(i,k)=sub_sqv(k)
                   det_thl3D(i,k)=det_thl(k)
                   det_sqv3D(i,k)=det_sqv(k)
                ENDDO
             endif










          ENDIF

          
          IF ( debug_code .and. (i .eq. idbg)) THEN
             IF ( ABS(QFX(i))>.001)print*,&
                "SUSPICIOUS VALUES AT: i=",i," QFX=",QFX(i)
             IF ( ABS(HFX(i))>1100.)print*,&
                "SUSPICIOUS VALUES AT: i=",i," HFX=",HFX(i)
             DO k = kts,kte
               IF ( sh(k) < 0. .OR. sh(k)> 200.)print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," sh=",sh(k)
               IF ( ABS(vt(k)) > 2.0 )print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," vt=",vt(k)
               IF ( ABS(vq(k)) > 7000.)print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," vq=",vq(k)
               IF ( qke(i,k) < -1. .OR. qke(i,k)> 200.)print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," qke=",qke(i,k)
               IF ( el_pbl(i,k) < 0. .OR. el_pbl(i,k)> 1500.)print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," el_pbl=",el_pbl(i,k)
               IF ( exch_m(i,k) < 0. .OR. exch_m(i,k)> 2000.)print*,&
                  "SUSPICIOUS VALUES AT: i,k=",i,k," exxch_m=",exch_m(i,k)
               IF (icloud_bl > 0) then
                  IF( cldfra_bl(i,k) < 0.0 .OR. cldfra_bl(i,k)> 1.)THEN
                  PRINT*,"SUSPICIOUS VALUES: CLDFRA_BL=",cldfra_bl(i,k)," qc_bl=",QC_BL(i,k)
                  ENDIF
               ENDIF

               
               
               
               
               
               
               
               
             ENDDO 
          ENDIF
          

          
          
          
          
          
          
          
          

    ENDDO 


    IF (bl_mynn_tkeadvect) THEN
       qke_adv=qke
    ENDIF



  END SUBROUTINE mynn_bl_driver




























































  SUBROUTINE  mym_initialize (                                & 
       &            kts,kte,xland,                            &
       &            dz, dx, zw,                               &
       &            u, v, thl, qw,                            &
       &            thlsg, qwsg,                              &

       &            zi, theta, thetav, sh, sm,                &
       &            ust, rmo, el,                             &
       &            Qke, Tsq, Qsq, Cov, Psig_bl, cldfra_bl1D, &
       &            bl_mynn_mixlength,                        &
       &            edmf_w1,edmf_a1,                          &
       &            INITIALIZE_QKE,                           &
       &            spp_pbl,rstoch_col)


    
    INTEGER, INTENT(IN)   :: kts,kte
    INTEGER, INTENT(IN)   :: bl_mynn_mixlength
    LOGICAL, INTENT(IN)   :: INITIALIZE_QKE

    REAL, INTENT(IN)   :: ust, rmo, Psig_bl, dx, xland
    REAL, DIMENSION(kts:kte), INTENT(in) :: dz
    REAL, DIMENSION(kts:kte+1), INTENT(in) :: zw
    REAL, DIMENSION(kts:kte), INTENT(in) :: u,v,thl,qw,cldfra_bl1D,&
                                          edmf_w1,edmf_a1
    REAL, DIMENSION(kts:kte), INTENT(out) :: tsq,qsq,cov
    REAL, DIMENSION(kts:kte), INTENT(inout) :: el,qke
    REAL, DIMENSION(kts:kte) :: &
         &ql,pdk,pdt,pdq,pdc,dtl,dqw,dtv,&
         &gm,gh,sm,sh,qkw,vt,vq
    INTEGER :: k,l,lmax
    REAL :: phm,vkz,elq,elv,b1l,b2l,pmz=1.,phh=1.,flt=0.,flq=0.,tmpq
    REAL :: zi
    REAL, DIMENSION(kts:kte) :: theta,thetav,thlsg,qwsg

    REAL, DIMENSION(kts:kte) :: rstoch_col
    INTEGER ::spp_pbl


    DO k = kts,kte
       ql(k) = 0.0
       vt(k) = 0.0
       vq(k) = 0.0
    END DO


    CALL mym_level2 ( kts,kte,                      &
         &            dz,                           &
         &            u, v, thl, thetav, qw,        &
         &            thlsg, qwsg,                  &
         &            ql, vt, vq,                   &
         &            dtl, dqw, dtv, gm, gh, sm, sh )



    el (kts) = 0.0
    IF (INITIALIZE_QKE) THEN
       
       qke(kts) = 1.5 * ust**2 * ( b1*pmz )**(2.0/3.0)
       DO k = kts+1,kte
          
          
          qke(k)=qke(kts)*MAX((ust*700. - zw(k))/(MAX(ust,0.01)*700.), 0.01)
       ENDDO
    ENDIF

    phm      = phh*b2 / ( b1*pmz )**(1.0/3.0)
    tsq(kts) = phm*( flt/ust )**2
    qsq(kts) = phm*( flq/ust )**2
    cov(kts) = phm*( flt/ust )*( flq/ust )

    DO k = kts+1,kte
       vkz = karman*zw(k)
       el (k) = vkz/( 1.0 + vkz/100.0 )


       tsq(k) = 0.0
       qsq(k) = 0.0
       cov(k) = 0.0
    END DO



    lmax = 5

    DO l = 1,lmax


       CALL mym_length (                          &
            &            kts,kte,xland,           &
            &            dz, dx, zw,              &
            &            rmo, flt, flq,           &
            &            vt, vq,                  &
            &            u, v, qke,               &
            &            dtv,                     &
            &            el,                      &
            &            zi,theta,                &
            &            qkw,Psig_bl,cldfra_bl1D, &
            &            bl_mynn_mixlength,       &
            &            edmf_w1,edmf_a1          )

       DO k = kts+1,kte
          elq = el(k)*qkw(k)
          pdk(k) = elq*( sm(k)*gm(k) + &
               &         sh(k)*gh(k) )
          pdt(k) = elq*  sh(k)*dtl(k)**2
          pdq(k) = elq*  sh(k)*dqw(k)**2
          pdc(k) = elq*  sh(k)*dtl(k)*dqw(k)
       END DO


       vkz = karman*0.5*dz(kts)
       elv = 0.5*( el(kts+1)+el(kts) ) /  vkz
       IF (INITIALIZE_QKE)THEN 
          
          qke(kts) = 1.0 * MAX(ust,0.02)**2 * ( b1*pmz*elv    )**(2.0/3.0) 
       ENDIF

       phm      = phh*b2 / ( b1*pmz/elv**2 )**(1.0/3.0)
       tsq(kts) = phm*( flt/ust )**2
       qsq(kts) = phm*( flq/ust )**2
       cov(kts) = phm*( flt/ust )*( flq/ust )

       DO k = kts+1,kte-1
          b1l = b1*0.25*( el(k+1)+el(k) )
          
          
          tmpq=MIN(MAX(b1l*( pdk(k+1)+pdk(k) ),qkemin),125.)

          IF (INITIALIZE_QKE)THEN
             qke(k) = tmpq**twothirds
          ENDIF

          IF ( qke(k) .LE. 0.0 ) THEN
             b2l = 0.0
          ELSE
             b2l = b2*( b1l/b1 ) / SQRT( qke(k) )
          END IF

          tsq(k) = b2l*( pdt(k+1)+pdt(k) )
          qsq(k) = b2l*( pdq(k+1)+pdq(k) )
          cov(k) = b2l*( pdc(k+1)+pdc(k) )
       END DO

    END DO






    IF (INITIALIZE_QKE)THEN
       qke(kts)=0.5*(qke(kts)+qke(kts+1))
       qke(kte)=qke(kte-1)
    ENDIF
    tsq(kte)=tsq(kte-1)
    qsq(kte)=qsq(kte-1)
    cov(kte)=cov(kte-1)




  END SUBROUTINE mym_initialize

  









































  SUBROUTINE  mym_level2 (kts,kte,                &
       &            dz,                           &
       &            u, v, thl, thetav, qw,        &
       &            thlsg, qwsg,                  &
       &            ql, vt, vq,                   &
       &            dtl, dqw, dtv, gm, gh, sm, sh )



    INTEGER, INTENT(IN)   :: kts,kte


    REAL, DIMENSION(kts:kte), INTENT(in) :: dz
    REAL, DIMENSION(kts:kte), INTENT(in) :: u,v,thl,qw,ql,vt,vq,&
                                            thetav,thlsg,qwsg
    REAL, DIMENSION(kts:kte), INTENT(out) :: &
         &dtl,dqw,dtv,gm,gh,sm,sh

    INTEGER :: k

    REAL :: rfc,f1,f2,rf1,rf2,smc,shc,&
         &ri1,ri2,ri3,ri4,duz,dtz,dqz,vtt,vqq,dtq,dzk,afk,abk,ri,rf

    REAL ::   a2fac






    rfc = g1/( g1+g2 )
    f1  = b1*( g1-c1 ) +3.0*a2*( 1.0    -c2 )*( 1.0-c5 ) &
    &                   +2.0*a1*( 3.0-2.0*c2 )
    f2  = b1*( g1+g2 ) -3.0*a1*( 1.0    -c2 )
    rf1 = b1*( g1-c1 )/f1
    rf2 = b1*  g1     /f2
    smc = a1 /a2*  f1/f2
    shc = 3.0*a2*( g1+g2 )

    ri1 = 0.5/smc
    ri2 = rf1*smc
    ri3 = 4.0*rf2*smc -2.0*ri2
    ri4 = ri2**2

    DO k = kts+1,kte
       dzk = 0.5  *( dz(k)+dz(k-1) )
       afk = dz(k)/( dz(k)+dz(k-1) )
       abk = 1.0 -afk
       duz = ( u(k)-u(k-1) )**2 +( v(k)-v(k-1) )**2
       duz =   duz                    /dzk**2
       dtz = ( thl(k)-thl(k-1) )/( dzk )
       
       
       dqz = ( qw(k)-qw(k-1) )/( dzk )
       
       

       vtt =  1.0 +vt(k)*abk +vt(k-1)*afk  
       vqq =  tv0 +vq(k)*abk +vq(k-1)*afk  
       dtq =  vtt*dtz +vqq*dqz
       
       

       dtl(k) =  dtz
       dqw(k) =  dqz
       dtv(k) =  dtq




       gm (k) =  duz
       gh (k) = -dtq*gtr


       ri = -gh(k)/MAX( duz, 1.0e-10 )

    
    IF (CKmod .eq. 1) THEN
       a2fac = 1./(1. + MAX(ri,0.0))
    ELSE
       a2fac = 1.
    ENDIF

       rfc = g1/( g1+g2 )
       f1  = b1*( g1-c1 ) +3.0*a2*a2fac *( 1.0    -c2 )*( 1.0-c5 ) &
    &                     +2.0*a1*( 3.0-2.0*c2 )
       f2  = b1*( g1+g2 ) -3.0*a1*( 1.0    -c2 )
       rf1 = b1*( g1-c1 )/f1
       rf2 = b1*  g1     /f2
       smc = a1 /(a2*a2fac)*  f1/f2
       shc = 3.0*(a2*a2fac)*( g1+g2 )

       ri1 = 0.5/smc
       ri2 = rf1*smc
       ri3 = 4.0*rf2*smc -2.0*ri2
       ri4 = ri2**2


       rf = MIN( ri1*( ri + ri2-SQRT(ri**2 - ri3*ri + ri4) ), rfc )

       sh (k) = shc*( rfc-rf )/( 1.0-rf )
       sm (k) = smc*( rf1-rf )/( rf2-rf ) * sh(k)
    END DO




  END SUBROUTINE mym_level2



















  SUBROUTINE  mym_length (                     & 
    &            kts,kte,xland,                &
    &            dz, dx, zw,                   &
    &            rmo, flt, flq,                &
    &            vt, vq,                       &
    &            u1, v1, qke,                  &
    &            dtv,                          &
    &            el,                           &
    &            zi, theta, qkw,               &
    &            Psig_bl, cldfra_bl1D,         &
    &            bl_mynn_mixlength,            &
    &            edmf_w1,edmf_a1               )
    


    INTEGER, INTENT(IN)   :: kts,kte


    INTEGER, INTENT(IN)   :: bl_mynn_mixlength
    REAL, DIMENSION(kts:kte), INTENT(in)   :: dz
    REAL, DIMENSION(kts:kte+1), INTENT(in) :: zw
    REAL, INTENT(in) :: rmo,flt,flq,Psig_bl,dx,xland
    REAL, DIMENSION(kts:kte), INTENT(IN)   :: u1,v1,qke,vt,vq,cldfra_bl1D,&
                                          edmf_w1,edmf_a1
    REAL, DIMENSION(kts:kte), INTENT(out)  :: qkw, el
    REAL, DIMENSION(kts:kte), INTENT(in)   :: dtv

    REAL :: elt,vsc

    REAL, DIMENSION(kts:kte), INTENT(IN) :: theta
    REAL, DIMENSION(kts:kte) :: qtke,elBLmin,elBLavg,thetaw
    REAL :: wt,wt2,zi,zi2,h1,h2,hs,elBLmin0,elBLavg0,cldavg

    
    
    REAL :: cns,   &   
            alp1,  &   
            alp2,  &   
            alp3,  &   
            alp4,  &   
            alp5,  &   
            alp6       

    
    
    
    
    REAL, PARAMETER :: minzi = 300.  
    REAL, PARAMETER :: maxdz = 750.  
                                     
                                     
    REAL, PARAMETER :: mindz = 300.  

    
    REAL, PARAMETER :: ZSLH = 100. 
    REAL, PARAMETER :: CSL = 2.    


    INTEGER :: i,j,k
    REAL :: afk,abk,zwk,zwk1,dzk,qdz,vflx,bv,tau_cloud,wstar,elb,els, &
            & elf,el_stab,el_mf,el_stab_mf,elb_mf,                    &
            & PBLH_PLUS_ENT,Uonset,Ugrid,wt_u,el_les
    REAL, PARAMETER :: ctau = 1000. 




    SELECT CASE(bl_mynn_mixlength)

      CASE (0) 

        cns  = 2.7
        alp1 = 0.23
        alp2 = 1.0
        alp3 = 5.0
        alp4 = 100.
        alp5 = 0.3

        
        zi2  = MIN(10000.,zw(kte-2))  
        h1=MAX(0.3*zi2,mindz)
        h1=MIN(h1,maxdz)         
        h2=h1/2.0                

        qkw(kts) = SQRT(MAX(qke(kts),1.0e-10))
        DO k = kts+1,kte
           afk = dz(k)/( dz(k)+dz(k-1) )
           abk = 1.0 -afk
           qkw(k) = SQRT(MAX(qke(k)*abk+qke(k-1)*afk,1.0e-3))
        END DO

        elt = 1.0e-5
        vsc = 1.0e-5        

        
        k = kts+1
        zwk = zw(k)
        DO WHILE (zwk .LE. zi2+h1)
           dzk = 0.5*( dz(k)+dz(k-1) )
           qdz = MAX( qkw(k)-qmin, 0.03 )*dzk
           elt = elt +qdz*zwk
           vsc = vsc +qdz
           k   = k+1
           zwk = zw(k)
        END DO

        elt =  alp1*elt/vsc
        vflx = ( vt(kts)+1.0 )*flt +( vq(kts)+tv0 )*flq
        vsc = ( gtr*elt*MAX( vflx, 0.0 ) )**(1.0/3.0)

        
        el(kts) = 0.0
        zwk1    = zw(kts+1)

        DO k = kts+1,kte
           zwk = zw(k)              

           
           IF ( dtv(k) .GT. 0.0 ) THEN
              bv  = SQRT( gtr*dtv(k) )
              elb = alp2*qkw(k) / bv &
                  &       *( 1.0 + alp3/alp2*&
                  &SQRT( vsc/( bv*elt ) ) )
              elf = alp2 * qkw(k)/bv

           ELSE
              elb = 1.0e10
              elf = elb
           ENDIF

           
           IF ( rmo .GT. 0.0 ) THEN
              els  = karman*zwk/(1.0+cns*MIN( zwk*rmo, zmax ))
           ELSE
              els  =  karman*zwk*( 1.0 - alp4* zwk*rmo )**0.2
           END IF

           
           
           

           wt=.5*TANH((zwk - (zi2+h1))/h2) + .5

           el(k) = MIN(elb/( elb/elt+elb/els+1.0 ),elf)

        END DO

      CASE (1) 

        ugrid = sqrt(u1(kts)**2 + v1(kts)**2)
        uonset= 15. 
        wt_u = (1.0 - min(max(ugrid - uonset, 0.0)/30.0, 0.5)) 
        cns  = 3.5
        alp1 = 0.22 
        alp2 = 0.25 
        alp3 = 2.0 * wt_u 
        alp4 = 5.0
        alp5 = 0.3
        alp6 = 50.

        
        zi2=MAX(zi,200.) 
        h1=MAX(0.3*zi2,200.)
        h1=MIN(h1,500.)          
        h2=h1/2.0                

        qtke(kts)=MAX(0.5*qke(kts), 0.01) 
        thetaw(kts)=theta(kts)            
        qkw(kts) = SQRT(MAX(qke(kts),1.0e-10))

        DO k = kts+1,kte
           afk = dz(k)/( dz(k)+dz(k-1) )
           abk = 1.0 -afk
           qkw(k) = SQRT(MAX(qke(k)*abk+qke(k-1)*afk,1.0e-3))
           qtke(k) = 0.5*(qkw(k)**2)     
           thetaw(k)= theta(k)*abk + theta(k-1)*afk
        END DO

        elt = 1.0e-5
        vsc = 1.0e-5

        
        k = kts+1
        zwk = zw(k)
        DO WHILE (zwk .LE. zi2+h1)
           dzk = 0.5*( dz(k)+dz(k-1) )
           qdz = min(max( qkw(k)-qmin, 0.03 ), 30.0)*dzk
           elt = elt +qdz*zwk
           vsc = vsc +qdz
           k   = k+1
           zwk = zw(k)
        END DO

        elt = MIN( MAX( alp1*elt/vsc, 10.), 400.)
        
        
        vflx = flt
        vsc = ( gtr*elt*MAX( vflx, 0.0 ) )**onethird

        
        el(kts) = 0.0
        zwk1    = zw(kts+1)              

        
        CALL boulac_length(kts,kte,zw,dz,qtke,thetaw,elBLmin,elBLavg)

        DO k = kts+1,kte
           zwk = zw(k)              

           
           IF ( dtv(k) .GT. 0.0 ) THEN
              bv  = max( sqrt( gtr*dtv(k) ), 0.001)
              elb = MAX(alp2*qkw(k),                          &
                  &    alp6*edmf_a1(k-1)*edmf_w1(k-1)) / bv   &
                  &  *( 1.0 + alp3*SQRT( vsc/(bv*elt) ) )
              elb = MIN(elb, zwk)
              elf = 0.65 * qkw(k)/bv
              elBLavg(k) = MAX(elBLavg(k), alp6*edmf_a1(k-1)*edmf_w1(k-1)/bv)
           ELSE
              elb = 1.0e10
              elf = elb
           ENDIF

           
           IF ( rmo .GT. 0.0 ) THEN
              els  = karman*zwk/(1.0+cns*MIN( zwk*rmo, zmax ))
           ELSE
              els  =  karman*zwk*( 1.0 - alp4* zwk*rmo )**0.2
           END IF

           
           wt=.5*TANH((zwk - (zi2+h1))/h2) + .5

           
           
           
           
           el(k) = SQRT( els**2/(1. + (els**2/elt**2) +(els**2/elb**2)))
           el(k) = MIN (el(k), elf)
           el(k) = el(k)*(1.-wt) + alp5*elBLavg(k)*wt

           
           el(k) = el(k)*Psig_bl

         END DO

      CASE (2) 

        Uonset = 3.5 + dz(kts)*0.1
        Ugrid  = sqrt(u1(kts)**2 + v1(kts)**2)
        cns  = 3.5 
        alp1 = 0.22 
        alp2 = 0.25 
        alp3 = 2.0  
        alp4 = 5.0
        alp5 = alp2 
        alp6 = 50.0 

        
        
        zi2=MAX(zi,    200.)
        
        
        h1=MAX(0.3*zi2,200.)
        h1=MIN(h1,500.)
        h2=h1*0.5                

        qtke(kts)=MAX(0.5*qke(kts),0.01) 
        qkw(kts) = SQRT(MAX(qke(kts),1.0e-4))

        DO k = kts+1,kte
           afk = dz(k)/( dz(k)+dz(k-1) )
           abk = 1.0 -afk
           qkw(k) = SQRT(MAX(qke(k)*abk+qke(k-1)*afk,1.0e-3))
           qtke(k) = 0.5*qkw(k)**2  
        END DO

        elt = 1.0e-5
        vsc = 1.0e-5

        
        PBLH_PLUS_ENT = MAX(zi+h1, 100.)
        k = kts+1
        zwk = zw(k)
        DO WHILE (zwk .LE. PBLH_PLUS_ENT)
           dzk = 0.5*( dz(k)+dz(k-1) )
           qdz = min(max( qkw(k)-qmin, 0.03 ), 30.0)*dzk
           elt = elt +qdz*zwk
           vsc = vsc +qdz
           k   = k+1
           zwk = zw(k)
        END DO

        elt = MIN( MAX(alp1*elt/vsc, 10.), 400.)
        
        
        vflx = flt
        vsc = ( gtr*elt*MAX( vflx, 0.0 ) )**onethird

        
        el(kts) = 0.0
        zwk1    = zw(kts+1)

        DO k = kts+1,kte
           zwk = zw(k)              
           dzk = 0.5*( dz(k)+dz(k-1) )
           cldavg = 0.5*(cldfra_bl1D(k-1)+cldfra_bl1D(k))

           
           IF ( dtv(k) .GT. 0.0 ) THEN
              
              bv  = MAX( SQRT( gtr*dtv(k) ), 0.001)  
              
              elb_mf = MAX(alp2*qkw(k),                    &
                  &    alp6*edmf_a1(k-1)*edmf_w1(k-1)) / bv    &
                  &  *( 1.0 + alp3*SQRT( vsc/( bv*elt ) ) )
              elb = MIN(MAX(alp5*qkw(k), alp6*edmf_a1(k)*edmf_w1(k))/bv, zwk)

              
              wstar = 1.25*(gtr*zi*MAX(vflx,1.0e-4))**onethird
              tau_cloud = MIN(MAX(ctau * wstar/grav, 30.), 150.)
              
              wt=.5*TANH((zwk - (zi2+h1))/h2) + .5
              tau_cloud = tau_cloud*(1.-wt) + 50.*wt
              elf = MIN(MAX(tau_cloud*SQRT(MIN(qtke(k),40.)), &
                  &         alp6*edmf_a1(k)*edmf_w1(k)/bv), zwk)

              
              
              
              
              
              

           ELSE
              
              
              
              
              
              
              
              
              
              
              
              wstar = 1.25*(gtr*zi*MAX(vflx,1.0e-4))**onethird
              tau_cloud = MIN(MAX(ctau * wstar/grav, 50.), 200.)
              
              wt=.5*TANH((zwk - (zi2+h1))/h2) + .5
              
              tau_cloud = tau_cloud*(1.-wt) + MAX(100.,dzk*0.25)*wt

              elb = MIN(tau_cloud*SQRT(MIN(qtke(k),40.)), zwk)
              
              elf = elb 
              elb_mf = elb
         END IF
         elf    = elf/(1. + (elf/800.))  
         elb_mf = MAX(elb_mf, 0.01) 

         
         IF ( rmo .GT. 0.0 ) THEN
            els  = karman*zwk/(1.0+cns*MIN( zwk*rmo, zmax ))
         ELSE
            els  =  karman*zwk*( 1.0 - alp4* zwk*rmo )**0.2
         END IF

         
         wt=.5*TANH((zwk - (zi2+h1))/h2) + .5

         
         el(k) = SQRT( els**2/(1. + (els**2/elt**2) +(els**2/elb_mf**2)))
         el(k) = el(k)*(1.-wt) + elf*wt

         
         el_les= MIN(els/(1. + (els/12.)), elb_mf)
         el(k) = el(k)*Psig_bl + (1.-Psig_bl)*el_les

       END DO

    END SELECT



  END SUBROUTINE mym_length














  SUBROUTINE boulac_length0(k,kts,kte,zw,dz,qtke,theta,lb1,lb2)

















     INTEGER, INTENT(IN) :: k,kts,kte
     REAL, DIMENSION(kts:kte), INTENT(IN) :: qtke,dz,theta
     REAL, INTENT(OUT) :: lb1,lb2
     REAL, DIMENSION(kts:kte+1), INTENT(IN) :: zw

     
     INTEGER :: izz, found
     REAL :: dlu,dld
     REAL :: dzt, zup, beta, zup_inf, bbb, tl, zdo, zdo_sup, zzz


     
     
     
     zup=0.
     dlu=zw(kte+1)-zw(k)-dz(k)*0.5
     zzz=0.
     zup_inf=0.
     beta=gtr           

     

     if (k .lt. kte) then      
        found = 0
        izz=k
        DO WHILE (found .EQ. 0)

           if (izz .lt. kte) then
              dzt=dz(izz)                   
              zup=zup-beta*theta(k)*dzt     
              
              zup=zup+beta*(theta(izz+1)+theta(izz))*dzt*0.5 
              zzz=zzz+dzt                   
              
              if (qtke(k).lt.zup .and. qtke(k).ge.zup_inf) then
                 bbb=(theta(izz+1)-theta(izz))/dzt
                 if (bbb .ne. 0.) then
                    
                    tl=(-beta*(theta(izz)-theta(k)) + &
                      & sqrt( max(0.,(beta*(theta(izz)-theta(k)))**2 + &
                      &       2.*bbb*beta*(qtke(k)-zup_inf))))/bbb/beta
                 else
                    if (theta(izz) .ne. theta(k))then
                       tl=(qtke(k)-zup_inf)/(beta*(theta(izz)-theta(k)))
                    else
                       tl=0.
                    endif
                 endif
                 dlu=zzz-dzt+tl
                 
                 found =1
              endif
              zup_inf=zup
              izz=izz+1
           ELSE
              found = 1
           ENDIF

        ENDDO

     endif

     
     
     
     zdo=0.
     zdo_sup=0.
     dld=zw(k)
     zzz=0.

     
     if (k .gt. kts) then  

        found = 0
        izz=k
        DO WHILE (found .EQ. 0)

           if (izz .gt. kts) then
              dzt=dz(izz-1)
              zdo=zdo+beta*theta(k)*dzt
              
              zdo=zdo-beta*(theta(izz-1)+theta(izz))*dzt*0.5
              zzz=zzz+dzt
              
              if (qtke(k).lt.zdo .and. qtke(k).ge.zdo_sup) then
                 bbb=(theta(izz)-theta(izz-1))/dzt
                 if (bbb .ne. 0.) then
                    tl=(beta*(theta(izz)-theta(k))+ &
                      & sqrt( max(0.,(beta*(theta(izz)-theta(k)))**2 + &
                      &       2.*bbb*beta*(qtke(k)-zdo_sup))))/bbb/beta
                 else
                    if (theta(izz) .ne. theta(k)) then
                       tl=(qtke(k)-zdo_sup)/(beta*(theta(izz)-theta(k)))
                    else
                       tl=0.
                    endif
                 endif
                 dld=zzz-dzt+tl
                 
                 found = 1
              endif
              zdo_sup=zdo
              izz=izz-1
           ELSE
              found = 1
           ENDIF
        ENDDO

     endif

     
     
     
     
     
     dld = min(dld,zw(k+1))
     lb1 = min(dlu,dld)     
     
     dlu=MAX(0.1,MIN(dlu,1000.))
     dld=MAX(0.1,MIN(dld,1000.))
     lb2 = sqrt(dlu*dld)    
     

     if (k .eq. kte) then
        lb1 = 0.
        lb2 = 0.
     endif
     
     

  END SUBROUTINE boulac_length0










  SUBROUTINE boulac_length(kts,kte,zw,dz,qtke,theta,lb1,lb2)








     INTEGER, INTENT(IN) :: kts,kte
     REAL, DIMENSION(kts:kte), INTENT(IN) :: qtke,dz,theta
     REAL, DIMENSION(kts:kte), INTENT(OUT) :: lb1,lb2
     REAL, DIMENSION(kts:kte+1), INTENT(IN) :: zw

     
     INTEGER :: iz, izz, found
     REAL, DIMENSION(kts:kte) :: dlu,dld
     REAL, PARAMETER :: Lmax=2000.  
     REAL :: dzt, zup, beta, zup_inf, bbb, tl, zdo, zdo_sup, zzz

     

     do iz=kts,kte

        
        
        
        zup=0.
        dlu(iz)=zw(kte+1)-zw(iz)-dz(iz)*0.5
        zzz=0.
        zup_inf=0.
        beta=gtr           

        

        if (iz .lt. kte) then      

          found = 0
          izz=iz
          DO WHILE (found .EQ. 0)

            if (izz .lt. kte) then
              dzt=dz(izz)                    
              zup=zup-beta*theta(iz)*dzt     
              
              zup=zup+beta*(theta(izz+1)+theta(izz))*dzt*0.5 
              zzz=zzz+dzt                   
              
              if (qtke(iz).lt.zup .and. qtke(iz).ge.zup_inf) then
                 bbb=(theta(izz+1)-theta(izz))/dzt
                 if (bbb .ne. 0.) then
                    
                    tl=(-beta*(theta(izz)-theta(iz)) + &
                      & sqrt( max(0.,(beta*(theta(izz)-theta(iz)))**2 + &
                      &       2.*bbb*beta*(qtke(iz)-zup_inf))))/bbb/beta
                 else
                    if (theta(izz) .ne. theta(iz))then
                       tl=(qtke(iz)-zup_inf)/(beta*(theta(izz)-theta(iz)))
                    else
                       tl=0.
                    endif
                 endif            
                 dlu(iz)=zzz-dzt+tl
                 
                 found =1
              endif
              zup_inf=zup
              izz=izz+1
             ELSE
              found = 1
            ENDIF

          ENDDO

        endif
                   
        
        
        
        zdo=0.
        zdo_sup=0.
        dld(iz)=zw(iz)
        zzz=0.

        
        if (iz .gt. kts) then  

          found = 0
          izz=iz       
          DO WHILE (found .EQ. 0) 

            if (izz .gt. kts) then
              dzt=dz(izz-1)
              zdo=zdo+beta*theta(iz)*dzt
              
              zdo=zdo-beta*(theta(izz-1)+theta(izz))*dzt*0.5
              zzz=zzz+dzt
              
              if (qtke(iz).lt.zdo .and. qtke(iz).ge.zdo_sup) then
                 bbb=(theta(izz)-theta(izz-1))/dzt
                 if (bbb .ne. 0.) then
                    tl=(beta*(theta(izz)-theta(iz))+ &
                      & sqrt( max(0.,(beta*(theta(izz)-theta(iz)))**2 + &
                      &       2.*bbb*beta*(qtke(iz)-zdo_sup))))/bbb/beta
                 else
                    if (theta(izz) .ne. theta(iz)) then
                       tl=(qtke(iz)-zdo_sup)/(beta*(theta(izz)-theta(iz)))
                    else
                       tl=0.
                    endif
                 endif            
                 dld(iz)=zzz-dzt+tl
                 
                 found = 1
              endif
              zdo_sup=zdo
              izz=izz-1
            ELSE
              found = 1
            ENDIF
          ENDDO

        endif

        
        
        
        
        
        dld(iz) = min(dld(iz),zw(iz+1))
        lb1(iz) = min(dlu(iz),dld(iz))     
        
        dlu(iz)=MAX(0.1,MIN(dlu(iz),1000.))
        dld(iz)=MAX(0.1,MIN(dld(iz),1000.))
        lb2(iz) = sqrt(dlu(iz)*dld(iz))    
        

        
        lb1(iz) = lb1(iz)/(1. + (lb1(iz)/Lmax))
        lb2(iz) = lb2(iz)/(1. + (lb2(iz)/Lmax))
 
        if (iz .eq. kte) then
           lb1(kte) = lb1(kte-1)
           lb2(kte) = lb2(kte-1)
        endif
        
        

     ENDDO
                   
  END SUBROUTINE boulac_length


















































  SUBROUTINE  mym_turbulence (                                &
    &            kts,kte,                                     &
    &            xland,closure,                               &
    &            dz, dx, zw,                                  &
    &            u, v, thl, thetav, ql, qw,                   &
    &            thlsg, qwsg,                                 &
    &            qke, tsq, qsq, cov,                          &
    &            vt, vq,                                      &
    &            rmo, flt, flq,                               &
    &            zi,theta,                                    &
    &            sh, sm,                                      &
    &            El,                                          &
    &            Dfm, Dfh, Dfq, Tcd, Qcd, Pdk, Pdt, Pdq, Pdc, &
    &		 qWT1D,qSHEAR1D,qBUOY1D,qDISS1D,              &
    &            tke_budget,                                  &
    &            Psig_bl,Psig_shcu,cldfra_bl1D,               &
    &            bl_mynn_mixlength,                           &
    &            edmf_w1,edmf_a1,                             &
    &            TKEprodTD,                                   &
    &            spp_pbl,rstoch_col)



    INTEGER, INTENT(IN)   :: kts,kte


    INTEGER, INTENT(IN)   :: bl_mynn_mixlength,tke_budget
    REAL, INTENT(IN)      :: closure
    REAL, DIMENSION(kts:kte), INTENT(in) :: dz
    REAL, DIMENSION(kts:kte+1), INTENT(in) :: zw
    REAL, INTENT(in) :: rmo,flt,flq,Psig_bl,Psig_shcu,dx,xland,zi
    REAL, DIMENSION(kts:kte), INTENT(in) :: u,v,thl,thetav,qw,& 
         &ql,vt,vq,qke,tsq,qsq,cov,cldfra_bl1D,edmf_w1,edmf_a1,&
         &TKEprodTD,thlsg,qwsg

    REAL, DIMENSION(kts:kte), INTENT(out) :: dfm,dfh,dfq,&
         &pdk,pdt,pdq,pdc,tcd,qcd,el

    REAL, DIMENSION(kts:kte), INTENT(inout) :: &
         qWT1D,qSHEAR1D,qBUOY1D,qDISS1D
    REAL :: q3sq_old,dlsq1,qWTP_old,qWTP_new
    REAL :: dudz,dvdz,dTdz,&
            upwp,vpwp,Tpwp

    REAL, DIMENSION(kts:kte) :: qkw,dtl,dqw,dtv,gm,gh,sm,sh

    INTEGER :: k

    REAL :: e6c,dzk,afk,abk,vtt,vqq,&
         &cw25,clow,cupp,gamt,gamq,smd,gamv,elq,elh

    REAL :: cldavg
    REAL, DIMENSION(kts:kte), INTENT(in) :: theta

    REAL ::  a2fac, duz, ri 

    REAL:: auh,aum,adh,adm,aeh,aem,Req,Rsl,Rsl2,&
           gmelq,sm20,sh20,sm25max,sh25max,sm25min,sh25min,&
           sm_pbl,sh_pbl,zi2,wt,slht,wtpr

    DOUBLE PRECISION  q2sq, t2sq, r2sq, c2sq, elsq, gmel, ghel
    DOUBLE PRECISION  q3sq, t3sq, r3sq, c3sq, dlsq, qdiv
    DOUBLE PRECISION  e1, e2, e3, e4, enum, eden, wden


    INTEGER,  INTENT(IN)                          ::    spp_pbl
    REAL, DIMENSION(KTS:KTE)                      ::    rstoch_col
    REAL :: Prnum, Prlim
    REAL, PARAMETER :: Prlimit = 5.0















    CALL mym_level2 (kts,kte,                   &
    &            dz,                            &
    &            u, v, thl, thetav, qw,         &
    &            thlsg, qwsg,                   &
    &            ql, vt, vq,                    &
    &            dtl, dqw, dtv, gm, gh, sm, sh  )

    CALL mym_length (                           &
    &            kts,kte,xland,                 &
    &            dz, dx, zw,                    &
    &            rmo, flt, flq,                 &
    &            vt, vq,                        &
    &            u, v, qke,                     &
    &            dtv,                           &
    &            el,                            &
    &            zi,theta,                      &
    &            qkw,Psig_bl,cldfra_bl1D,       &
    &            bl_mynn_mixlength,             &
    &            edmf_w1,edmf_a1                )


    DO k = kts+1,kte
       dzk = 0.5  *( dz(k)+dz(k-1) )
       afk = dz(k)/( dz(k)+dz(k-1) )
       abk = 1.0 -afk
       elsq = el (k)**2
       q3sq = qkw(k)**2
       q2sq = b1*elsq*( sm(k)*gm(k)+sh(k)*gh(k) )

       sh20 = MAX(sh(k), 1e-5)
       sm20 = MAX(sm(k), 1e-5)
       sh(k)= MAX(sh(k), 1e-5)

       
       duz = ( u(k)-u(k-1) )**2 +( v(k)-v(k-1) )**2
       duz =   duz                    /dzk**2
       
       ri = -gh(k)/MAX( duz, 1.0e-10 )
       IF (CKmod .eq. 1) THEN
          a2fac = 1./(1. + MAX(ri,0.0))
       ELSE
          a2fac = 1.
       ENDIF
       

       
       
       
       
       
       Prnum = MIN(0.76 + 4.0*MAX(ri,0.0), Prlimit)
       


       gmel = gm (k)*elsq
       ghel = gh (k)*elsq


       
       IF ( debug_code ) THEN
         IF (sh(k)<0.0 .OR. sm(k)<0.0) THEN
           print*,"MYNN; mym_turbulence 2.0; sh=",sh(k)," k=",k
           print*," gm=",gm(k)," gh=",gh(k)," sm=",sm(k)
           print*," q2sq=",q2sq," q3sq=",q3sq," q3/q2=",q3sq/q2sq
           print*," qke=",qke(k)," el=",el(k)," ri=",ri
           print*," PBLH=",zi," u=",u(k)," v=",v(k)
         ENDIF
       ENDIF





       dlsq =  elsq
       IF ( q3sq/dlsq .LT. -gh(k) ) q3sq = -dlsq*gh(k)

       IF ( q3sq .LT. q2sq ) THEN
          
          qdiv = SQRT( q3sq/q2sq )   

          
          
          
          
          
          
          
          
          
          
          
          
          

          
          sh(k) = sh(k) * qdiv
          sm(k) = sm(k) * qdiv
        
        
        
        
        
        
        
        
        

          
          
          
          
          
          
          e1   = q3sq - e1c*ghel*a2fac * qdiv**2
          e2   = q3sq - e2c*ghel*a2fac * qdiv**2
          e3   = e1   + e3c*ghel*a2fac**2 * qdiv**2
          e4   = e1   - e4c*ghel*a2fac * qdiv**2
          eden = e2*e4 + e3*e5c*gmel * qdiv**2
          eden = MAX( eden, 1.0d-20 )
          
          
          
          
       ELSE
          
          
          
          
          
          e1   = q3sq - e1c*ghel*a2fac
          e2   = q3sq - e2c*ghel*a2fac
          e3   = e1   + e3c*ghel*a2fac**2
          e4   = e1   - e4c*ghel*a2fac
          eden = e2*e4 + e3*e5c*gmel
          eden = MAX( eden, 1.0d-20 )

          qdiv = 1.0
          
          sm(k) = q3sq*a1*( e3-3.0*c1*e4       )/eden
        
          
          
          sh(k) = q3sq*(a2*a2fac)*( e2+3.0*c1*e5c*gmel )/eden
        

        
        
        
        
       END IF 

       
       gmelq    = MAX(gmel/q3sq, 1e-8)
       sm25max  = 4.  
       sh25max  = 4.  
       sm25min  = 0.0 
       sh25min  = 0.0 

       
       
       IF ( debug_code ) THEN
         IF ((sh(k)<sh25min .OR. sm(k)<sm25min .OR. &
              sh(k)>sh25max .OR. sm(k)>sm25max) ) THEN
           print*,"In mym_turbulence 2.5: k=",k
           print*," sm=",sm(k)," sh=",sh(k)
           print*," ri=",ri," Pr=",sm(k)/MAX(sh(k),1e-8)
           print*," gm=",gm(k)," gh=",gh(k)
           print*," q2sq=",q2sq," q3sq=",q3sq, q3sq/q2sq
           print*," qke=",qke(k)," el=",el(k)
           print*," PBLH=",zi," u=",u(k)," v=",v(k)
           print*," SMnum=",q3sq*a1*( e3-3.0*c1*e4)," SMdenom=",eden
           print*," SHnum=",q3sq*(a2*a2fac)*( e2+3.0*c1*e5c*gmel ),&
                  " SHdenom=",eden
         ENDIF
       ENDIF

       
       IF ( sh(k) > sh25max ) sh(k) = sh25max
       IF ( sh(k) < sh25min ) sh(k) = sh25min
       
       
       

       
       
       
       
       
       
       
       sm(k) = MIN(sm(k), Prlimit*Sh(k))


       IF ( closure .GE. 3.0 ) THEN
          t2sq = qdiv*b2*elsq*sh(k)*dtl(k)**2
          r2sq = qdiv*b2*elsq*sh(k)*dqw(k)**2
          c2sq = qdiv*b2*elsq*sh(k)*dtl(k)*dqw(k)
          t3sq = MAX( tsq(k)*abk+tsq(k-1)*afk, 0.0 )
          r3sq = MAX( qsq(k)*abk+qsq(k-1)*afk, 0.0 )
          c3sq =      cov(k)*abk+cov(k-1)*afk


          c3sq = SIGN( MIN( ABS(c3sq), SQRT(t3sq*r3sq) ), c3sq )

          vtt  = 1.0 +vt(k)*abk +vt(k-1)*afk
          vqq  = tv0 +vq(k)*abk +vq(k-1)*afk

          t2sq = vtt*t2sq +vqq*c2sq
          r2sq = vtt*c2sq +vqq*r2sq
          c2sq = MAX( vtt*t2sq+vqq*r2sq, 0.0d0 )
          t3sq = vtt*t3sq +vqq*c3sq
          r3sq = vtt*c3sq +vqq*r3sq
          c3sq = MAX( vtt*t3sq+vqq*r3sq, 0.0d0 )

          cw25 = e1*( e2 + 3.0*c1*e5c*gmel*qdiv**2 )/( 3.0*eden )


          dlsq =  elsq
          IF ( q3sq/dlsq .LT. -gh(k) ) q3sq = -dlsq*gh(k)



          
          auh = 27.*a1*((a2*a2fac)**2)*b2*(gtr)**2
          aum = 54.*(a1**2)*(a2*a2fac)*b2*c1*(gtr)
          adh = 9.*a1*((a2*a2fac)**2)*(12.*a1 + 3.*b2)*(gtr)**2
          adm = 18.*(a1**2)*(a2*a2fac)*(b2 - 3.*(a2*a2fac))*(gtr)

          aeh = (9.*a1*((a2*a2fac)**2)*b1 +9.*a1*((a2*a2fac)**2)* &
                (12.*a1 + 3.*b2))*(gtr)
          aem = 3.*a1*(a2*a2fac)*b1*(3.*(a2*a2fac) + 3.*b2*c1 + &
                (18.*a1*c1 - b2)) + &
                (18.)*(a1**2)*(a2*a2fac)*(b2 - 3.*(a2*a2fac))

          Req = -aeh/aem
          Rsl = (auh + aum*Req)/(3.*adh + 3.*adm*Req)
          
          Rsl = .12             
          Rsl2= 1.0 - 2.*Rsl    
          
          


          
          

          
          
          
          
          e2   = q3sq - e2c*ghel*a2fac * qdiv**2
          e3   = q3sq + e3c*ghel*a2fac**2 * qdiv**2
          e4   = q3sq - e4c*ghel*a2fac * qdiv**2
          eden = e2*e4  + e3 *e5c*gmel * qdiv**2

          
          
          
          wden = cc3*gtr**2 * dlsq**2/elsq * qdiv**2 &
               &        *( e2*e4c*a2fac - e3c*e5c*gmel*a2fac**2 * qdiv**2 )

          IF ( wden .NE. 0.0 ) THEN
             
             clow = q3sq*( 0.12-cw25 )*eden/wden
             cupp = q3sq*( 0.76-cw25 )*eden/wden
             
             

             IF ( wden .GT. 0.0 ) THEN
                c3sq  = MIN( MAX( c3sq, c2sq+clow ), c2sq+cupp )
             ELSE
                c3sq  = MAX( MIN( c3sq, c2sq+clow ), c2sq+cupp )
             END IF
          END IF

          e1   = e2 + e5c*gmel * qdiv**2
          eden = MAX( eden, 1.0d-20 )


          
          
          e6c  = 3.0*(a2*a2fac)*cc3*gtr * dlsq/elsq

          
          
          
          IF ( t2sq .GE. 0.0 ) THEN
             enum = MAX( qdiv*e6c*( t3sq-t2sq ), 0.0d0 )
          ELSE
             enum = MIN( qdiv*e6c*( t3sq-t2sq ), 0.0d0 )
          ENDIF
          gamt =-e1  *enum    /eden

          
          
          
          IF ( r2sq .GE. 0.0 ) THEN
             enum = MAX( qdiv*e6c*( r3sq-r2sq ), 0.0d0 )
          ELSE
             enum = MIN( qdiv*e6c*( r3sq-r2sq ), 0.0d0 )
          ENDIF
          gamq =-e1  *enum    /eden

          

          
          enum = MAX( qdiv*e6c*( c3sq-c2sq ), 0.0d0)

          
          
          smd  = dlsq*enum*gtr/eden * qdiv**2 * (e3c*a2fac**2 + &
               & e4c*a2fac)*a1/(a2*a2fac)

          gamv = e1  *enum*gtr/eden
          sm(k) = sm(k) +smd

          
          
          qdiv = 1.0

          
          IF ( debug_code ) THEN
            IF (sh(k)<-0.3 .OR. sm(k)<-0.3 .OR. &
              qke(k) < -0.1 .or. ABS(smd) .gt. 2.0) THEN
              print*," MYNN; mym_turbulence3.0; sh=",sh(k)," k=",k
              print*," gm=",gm(k)," gh=",gh(k)," sm=",sm(k)
              print*," q2sq=",q2sq," q3sq=",q3sq," q3/q2=",q3sq/q2sq
              print*," qke=",qke(k)," el=",el(k)," ri=",ri
              print*," PBLH=",zi," u=",u(k)," v=",v(k)
            ENDIF
          ENDIF



       ELSE

          gamt = 0.0
          gamq = 0.0
          gamv = 0.0
       END IF



       cldavg = 0.5*(cldfra_bl1D(k-1) + cldfra_bl1D(k))
       IF (edmf_a1(k) > 0.001 .OR. cldavg > 0.02) THEN
           
           sm(k) = MAX(sm(k), 0.03*MIN(10.*edmf_a1(k)*edmf_w1(k),1.0) )
           sh(k) = MAX(sh(k), 0.03*MIN(10.*edmf_a1(k)*edmf_w1(k),1.0) )
           
           sm(k) = MAX(sm(k), 0.05*MIN(cldavg,1.0) )
           sh(k) = MAX(sh(k), 0.05*MIN(cldavg,1.0) )
       ENDIF

       elq = el(k)*qkw(k)
       elh = elq*qdiv

       
       
       pdk(k) = elq*( sm(k)*gm(k)                &
            &        +sh(k)*gh(k)+gamv ) +       &
            &   TKEprodTD(k)
       pdt(k) = elh*( sh(k)*dtl(k)+gamt )*dtl(k)
       pdq(k) = elh*( sh(k)*dqw(k)+gamq )*dqw(k)
       pdc(k) = elh*( sh(k)*dtl(k)+gamt )        &
            &   *dqw(k)*0.5                      &
            & + elh*( sh(k)*dqw(k)+gamq )*dtl(k)*0.5

       
       tcd(k) = elq*gamt
       qcd(k) = elq*gamq

       
       dfm(k) = elq*sm(k) / dzk
       dfh(k) = elq*sh(k) / dzk



       dfq(k) =     dfm(k)


   IF (tke_budget .eq. 1) THEN
       









       


       
       
       qSHEAR1D(k) = elq*sm(k)*gm(k) 

       
       
       
       
       
       
       qBUOY1D(k) = elq*(sh(k)*gh(k)+gamv)+TKEprodTD(k) 

       
       
       
       
    ENDIF

    END DO


    dfm(kts) = 0.0
    dfh(kts) = 0.0
    dfq(kts) = 0.0
    tcd(kts) = 0.0
    qcd(kts) = 0.0

    tcd(kte) = 0.0
    qcd(kte) = 0.0


    DO k = kts,kte-1
       dzk = dz(k)
       tcd(k) = ( tcd(k+1)-tcd(k) )/( dzk )
       qcd(k) = ( qcd(k+1)-qcd(k) )/( dzk )
    END DO



    if (spp_pbl==1) then
       DO k = kts,kte
          dfm(k)= dfm(k) + dfm(k)* rstoch_col(k) * 1.5 * MAX(exp(-MAX(zw(k)-8000.,0.0)/2000.),0.001)
          dfh(k)= dfh(k) + dfh(k)* rstoch_col(k) * 1.5 * MAX(exp(-MAX(zw(k)-8000.,0.0)/2000.),0.001)
       END DO
    endif



  END SUBROUTINE mym_turbulence















































  SUBROUTINE  mym_predict (kts,kte,                                     &
       &            closure,                                            &
       &            delt,                                               &
       &            dz,                                                 &
       &            ust, flt, flq, pmz, phh,                            &
       &            el, dfq, rho,                                       &
       &            pdk, pdt, pdq, pdc,                                 &
       &            qke, tsq, qsq, cov,                                 &
       &            s_aw,s_awqke,bl_mynn_edmf_tke,                      &
       &            qWT1D, qDISS1D,tke_budget)  


    INTEGER, INTENT(IN) :: kts,kte    


    REAL, INTENT(IN)    :: closure
    INTEGER, INTENT(IN) :: bl_mynn_edmf_tke, tke_budget
    REAL, INTENT(IN)    :: delt
    REAL, DIMENSION(kts:kte), INTENT(IN) :: dz, dfq, el, rho
    REAL, DIMENSION(kts:kte), INTENT(INOUT) :: pdk, pdt, pdq, pdc
    REAL, INTENT(IN)    ::  flt, flq, ust, pmz, phh
    REAL, DIMENSION(kts:kte), INTENT(INOUT) :: qke,tsq, qsq, cov

    REAL, DIMENSION(kts:kte+1), INTENT(INOUT) :: s_awqke,s_aw
    
    
    REAL, DIMENSION(kts:kte), INTENT(OUT) :: qWT1D, qDISS1D  
    REAL, DIMENSION(kts:kte) :: tke_up,dzinv  
    
    
    INTEGER :: k
    REAL, DIMENSION(kts:kte) :: qkw, bp, rp, df3q
    REAL :: vkz,pdk1,phm,pdt1,pdq1,pdc1,b1l,b2l,onoff
    REAL, DIMENSION(kts:kte) :: dtz
    REAL, DIMENSION(kts:kte) :: a,b,c,d,x

    REAL, DIMENSION(kts:kte) :: rhoinv
    REAL, DIMENSION(kts:kte+1) :: rhoz,kqdz,kmdz

    
    IF (bl_mynn_edmf_tke == 0) THEN
       onoff=0.0
    ELSE
       onoff=1.0
    ENDIF


    vkz = karman*0.5*dz(kts)



    DO k = kts,kte

       qkw(k) = SQRT( MAX( qke(k), 0.0 ) )
       df3q(k)=Sqfac*dfq(k)
       dtz(k)=delt/dz(k)
    END DO


    
    
    rhoz(kts)  =rho(kts)
    rhoinv(kts)=1./rho(kts)
    kqdz(kts)  =rhoz(kts)*df3q(kts)
    kmdz(kts)  =rhoz(kts)*dfq(kts)
    DO k=kts+1,kte
       rhoz(k)  =(rho(k)*dz(k-1) + rho(k-1)*dz(k))/(dz(k-1)+dz(k))
       rhoz(k)  =  MAX(rhoz(k),1E-4)
       rhoinv(k)=1./MAX(rho(k),1E-4)
       kqdz(k)  = rhoz(k)*df3q(k) 
       kmdz(k)  = rhoz(k)*dfq(k)  
    ENDDO
    rhoz(kte+1)=rhoz(kte)
    kqdz(kte+1)=rhoz(kte+1)*df3q(kte)
    kmdz(kte+1)=rhoz(kte+1)*dfq(kte)

    
    DO k=kts+1,kte-1
       kqdz(k) = MAX(kqdz(k),  0.5* s_aw(k))
       kqdz(k) = MAX(kqdz(k), -0.5*(s_aw(k)-s_aw(k+1)))
       kmdz(k) = MAX(kmdz(k),  0.5* s_aw(k))
       kmdz(k) = MAX(kmdz(k), -0.5*(s_aw(k)-s_aw(k+1)))
    ENDDO


    pdk1 = 2.0*ust**3*pmz/( vkz )
    phm  = 2.0/ust   *phh/( vkz )
    pdt1 = phm*flt**2
    pdq1 = phm*flq**2
    pdc1 = phm*flt*flq


    pdk(kts) = pdk1 -pdk(kts+1)




    pdt(kts) = pdt(kts+1)
    pdq(kts) = pdq(kts+1)
    pdc(kts) = pdc(kts+1)



    DO k = kts,kte-1
       b1l = b1*0.5*( el(k+1)+el(k) )
       bp(k) = 2.*qkw(k) / b1l
       rp(k) = pdk(k+1) + pdk(k)
    END DO







    DO k=kts,kte-1











       a(k)=   - dtz(k)*kqdz(k)*rhoinv(k)                       &
           &   + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*onoff
       b(k)=1. + dtz(k)*(kqdz(k)+kqdz(k+1))*rhoinv(k)           &
           &   + 0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*onoff &
           &   + bp(k)*delt
       c(k)=   - dtz(k)*kqdz(k+1)*rhoinv(k)                     &
           &   - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*onoff
       d(k)=rp(k)*delt + qke(k)                                 &
           &   + dtz(k)*rhoinv(k)*(s_awqke(k)-s_awqke(k+1))*onoff
    ENDDO














    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qke(kte)


    CALL tridiag2(kte,a,b,c,d,x)

    DO k=kts,kte

       qke(k)=max(x(k), 1.e-4)
       qke(k)=min(qke(k), 150.)
    ENDDO
      
   

    IF (tke_budget .eq. 1) THEN
       
        tke_up=0.5*qke
        dzinv=1./dz
        k=kts
        qWT1D(k)=dzinv(k)*(                                    &
            &  (kqdz(k+1)*(tke_up(k+1)-tke_up(k))-kqdz(k)*tke_up(k)) &
            &  + 0.5*rhoinv(k)*(s_aw(k+1)*tke_up(k+1)          &
            &  +      (s_aw(k+1)-s_aw(k))*tke_up(k)            &
            &  +      (s_awqke(k)-s_awqke(k+1)))*onoff) 
        DO k=kts+1,kte-1
            qWT1D(k)=dzinv(k)*(                                &
            & (kqdz(k+1)*(tke_up(k+1)-tke_up(k))-kqdz(k)*(tke_up(k)-tke_up(k-1))) &
            &  + 0.5*rhoinv(k)*(s_aw(k+1)*tke_up(k+1)          &
            &  +      (s_aw(k+1)-s_aw(k))*tke_up(k)            &
            &  -                  s_aw(k)*tke_up(k-1)          &
            &  +      (s_awqke(k)-s_awqke(k+1)))*onoff) 
        ENDDO
        k=kte
        qWT1D(k)=dzinv(k)*(-kqdz(k)*(tke_up(k)-tke_up(k-1)) &
            &  + 0.5*rhoinv(k)*(-s_aw(k)*tke_up(k)-s_aw(k)*tke_up(k-1)+s_awqke(k))*onoff) 
        
        qDISS1D=bp*tke_up 
    END IF

   
    IF ( closure > 2.5 ) THEN

       
       DO k = kts,kte-1
          b2l   = b2*0.5*( el(k+1)+el(k) )
          bp(k) = 2.*qkw(k) / b2l
          rp(k) = pdq(k+1) + pdq(k)
       END DO

       
       
       
       
       

       
       DO k=kts,kte-1
          a(k)=   - dtz(k)*kmdz(k)*rhoinv(k)
          b(k)=1. + dtz(k)*(kmdz(k)+kmdz(k+1))*rhoinv(k) + bp(k)*delt
          c(k)=   - dtz(k)*kmdz(k+1)*rhoinv(k)
          d(k)=rp(k)*delt + qsq(k)
       ENDDO

       a(kte)=-1. 
       b(kte)=1.
       c(kte)=0.
       d(kte)=0.


    CALL tridiag2(kte,a,b,c,d,x)
       
       DO k=kts,kte
          
          qsq(k)=MAX(x(k),1e-17)
       ENDDO
    ELSE
       
       DO k = kts,kte-1
          IF ( qkw(k) .LE. 0.0 ) THEN
             b2l = 0.0
          ELSE
             b2l = b2*0.25*( el(k+1)+el(k) )/qkw(k)
          END IF
          qsq(k) = b2l*( pdq(k+1)+pdq(k) )
       END DO
       qsq(kte)=qsq(kte-1)
    END IF


    IF ( closure .GE. 3.0 ) THEN





       DO k = kts,kte-1
          b2l = b2*0.5*( el(k+1)+el(k) )
          bp(k) = 2.*qkw(k) / b2l
          rp(k) = pdt(k+1) + pdt(k) 
       END DO
       

       






       DO k=kts,kte-1
          
          
          
          

          a(k)=   - dtz(k)*kmdz(k)*rhoinv(k)
          b(k)=1. + dtz(k)*(kmdz(k)+kmdz(k+1))*rhoinv(k) + bp(k)*delt
          c(k)=   - dtz(k)*kmdz(k+1)*rhoinv(k)
          d(k)=rp(k)*delt + tsq(k)
       ENDDO








       a(kte)=-1. 
       b(kte)=1.
       c(kte)=0.
       d(kte)=0.
       

       CALL tridiag2(kte,a,b,c,d,x)

       DO k=kts,kte

           tsq(k)=x(k)
       ENDDO



       DO k = kts,kte-1
          b2l = b2*0.5*( el(k+1)+el(k) )
          bp(k) = 2.*qkw(k) / b2l
          rp(k) = pdc(k+1) + pdc(k) 
       END DO
       

       






       DO k=kts,kte-1
          
          
          
          

          a(k)=   - dtz(k)*kmdz(k)*rhoinv(k)
          b(k)=1. + dtz(k)*(kmdz(k)+kmdz(k+1))*rhoinv(k) + bp(k)*delt
          c(k)=   - dtz(k)*kmdz(k+1)*rhoinv(k)
          d(k)=rp(k)*delt + cov(k)
       ENDDO








       a(kte)=-1. 
       b(kte)=1.
       c(kte)=0.
       d(kte)=0.


    CALL tridiag2(kte,a,b,c,d,x)
       
       DO k=kts,kte

          cov(k)=x(k)
       ENDDO
       
    ELSE

       
       DO k = kts,kte-1
          IF ( qkw(k) .LE. 0.0 ) THEN
             b2l = 0.0
          ELSE
             b2l = b2*0.25*( el(k+1)+el(k) )/qkw(k)
          END IF

          tsq(k) = b2l*( pdt(k+1)+pdt(k) )
          cov(k) = b2l*( pdc(k+1)+pdc(k) )
       END DO
       
       tsq(kte)=tsq(kte-1)
       cov(kte)=cov(kte-1)
      
    END IF


  END SUBROUTINE mym_predict
  


































  SUBROUTINE  mym_condensation (kts,kte,   &
    &            dx, dz, zw, xland,        &
    &            thl, qw, qv, qc, qi,      &
    &            p,exner,                  &
    &            tsq, qsq, cov,            &
    &            Sh, el, bl_mynn_cloudpdf, &
    &            qc_bl1D, qi_bl1D,         &
    &            cldfra_bl1D,              &
    &            PBLH1,HFX1,               &
    &            Vt, Vq, th, sgm, rmo,     &
    &            spp_pbl,rstoch_col        )



    INTEGER, INTENT(IN)   :: kts,kte, bl_mynn_cloudpdf


    REAL, INTENT(IN)      :: dx,PBLH1,HFX1,rmo,xland
    REAL, DIMENSION(kts:kte), INTENT(IN) :: dz
    REAL, DIMENSION(kts:kte+1), INTENT(IN) :: zw
    REAL, DIMENSION(kts:kte), INTENT(IN) :: p,exner,thl,qw,qv,qc,qi, &
         &tsq, qsq, cov, th

    REAL, DIMENSION(kts:kte), INTENT(INOUT) :: vt,vq,sgm

    REAL, DIMENSION(kts:kte) :: alp,a,bet,b,ql,q1,RH
    REAL, DIMENSION(kts:kte), INTENT(OUT) :: qc_bl1D,qi_bl1D, &
                                             cldfra_bl1D
    DOUBLE PRECISION :: t3sq, r3sq, c3sq

    REAL :: qsl,esat,qsat,dqsl,cld0,q1k,qlk,eq1,qll,&
         &q2p,pt,rac,qt,t,xl,rsl,cpm,Fng,qww,alpha,beta,bb,&
         &ls,wt,cld_factor,fac_damp,liq_frac,ql_ice,ql_water,&
         &qmq,qsat_tk
    INTEGER :: i,j,k

    REAL :: erf

    
    REAL::dth,dtl,dqw,dzk,els
    REAL, DIMENSION(kts:kte), INTENT(IN) :: Sh,el

    
    REAL            :: zagl,damp,PBLH2
    REAL            :: cfmax

    
    REAL            :: theta1, theta2, ht1, ht2
    INTEGER         :: k_tropo


    INTEGER,  INTENT(IN)                          ::    spp_pbl
    REAL, DIMENSION(KTS:KTE)                      ::    rstoch_col
    REAL :: qw_pert






    DO k = kte-3, kts, -1
       theta1 = th(k)
       theta2 = th(k+2)
       ht1 = 44307.692 * (1.0 - (p(k)/101325.)**0.190)
       ht2 = 44307.692 * (1.0 - (p(k+2)/101325.)**0.190)
       if ( (((theta2-theta1)/(ht2-ht1)) .lt. 10./1500. ) .AND.       &
     &                       (ht1.lt.19000.) .and. (ht1.gt.4000.) ) then 
          goto 86
       endif
    ENDDO
 86   continue
    k_tropo = MAX(kts+2, k+2)

    zagl = 0.

    SELECT CASE(bl_mynn_cloudpdf)

      CASE (0) 

        DO k = kts,kte-1
           t  = th(k)*exner(k)











           
           esat = esat_blend(t)
           
           
           qsl=ep_2*esat/max(1.e-4,(p(k)-ep_3*esat))
           
           dqsl = qsl*ep_2*xlv/( r_d*t**2 )

           alp(k) = 1.0/( 1.0+dqsl*xlvcp )
           bet(k) = dqsl*exner(k)

           
           
           t3sq = MAX( tsq(k), 0.0 )
           r3sq = MAX( qsq(k), 0.0 )
           c3sq =      cov(k)
           c3sq = SIGN( MIN( ABS(c3sq), SQRT(t3sq*r3sq) ), c3sq )
           r3sq = r3sq +bet(k)**2*t3sq -2.0*bet(k)*c3sq
           
           qmq  = qw(k) -qsl
           
           sgm(k) = SQRT( MAX( r3sq, 1.0d-10 ))
           
           q1(k)   = qmq / sgm(k)
           
           cldfra_bl1D(k) = 0.5*( 1.0+erf( q1(k)*rr2 ) )

           q1k  = q1(k)
           eq1  = rrp*EXP( -0.5*q1k*q1k )
           qll  = MAX( cldfra_bl1D(k)*q1k + eq1, 0.0 )
           
           ql(k) = alp(k)*sgm(k)*qll
           
           liq_frac = min(1.0, max(0.0,(t-240.0)/29.0))
           qc_bl1D(k) = liq_frac*ql(k)
           qi_bl1D(k) = (1.0 - liq_frac)*ql(k)

           if(cldfra_bl1D(k)>0.01 .and. qc_bl1D(k)<1.E-6)qc_bl1D(k)=1.E-6
           if(cldfra_bl1D(k)>0.01 .and. qi_bl1D(k)<1.E-8)qi_bl1D(k)=1.E-8

           
           q2p = xlvcp/exner(k)
           pt = thl(k) +q2p*ql(k) 

           
           qt   = 1.0 +p608*qw(k) -(1.+p608)*(qc_bl1D(k)+qi_bl1D(k))*cldfra_bl1D(k)
           rac  = alp(k)*( cldfra_bl1D(K)-qll*eq1 )*( q2p*qt-(1.+p608)*pt )

           
           
           
           vt(k) =      qt-1.0 -rac*bet(k)
           vq(k) = p608*pt-tv0 +rac

        END DO

      CASE (1, -1) 
                       
        DO k = kts,kte-1
           t  = th(k)*exner(k)
           
           esat = esat_blend(t)
           
           
           qsl=ep_2*esat/max(1.e-4,(p(k)-ep_3*esat))
           
           dqsl = qsl*ep_2*xlv/( r_d*t**2 )

           alp(k) = 1.0/( 1.0+dqsl*xlvcp )
           bet(k) = dqsl*exner(k)

           if (k .eq. kts) then 
             dzk = 0.5*dz(k)
           else
             dzk = dz(k)
           end if
           dth = 0.5*(thl(k+1)+thl(k)) - 0.5*(thl(k)+thl(MAX(k-1,kts)))
           dqw = 0.5*(qw(k+1) + qw(k)) - 0.5*(qw(k) + qw(MAX(k-1,kts)))
           sgm(k) = SQRT( MAX( (alp(k)**2 * MAX(el(k)**2,0.1) * &
                             b2 * MAX(Sh(k),0.03))/4. * &
                      (dqw/dzk - bet(k)*(dth/dzk ))**2 , 1.0e-10) )
           qmq   = qw(k) -qsl
           q1(k) = qmq / sgm(k)
           cldfra_bl1D(K) = 0.5*( 1.0+erf( q1(k)*rr2 ) )


           
           
           q1k  = q1(k)
           eq1  = rrp*EXP( -0.5*q1k*q1k )
           qll  = MAX( cldfra_bl1D(K)*q1k + eq1, 0.0 )
           
           ql (k) = alp(k)*sgm(k)*qll
           liq_frac = min(1.0, max(0.0,(t-240.0)/29.0))
           qc_bl1D(k) = liq_frac*ql(k)
           qi_bl1D(k) = (1.0 - liq_frac)*ql(k)

           if(cldfra_bl1D(k)>0.01 .and. qc_bl1D(k)<1.E-6)qc_bl1D(k)=1.E-6
           if(cldfra_bl1D(k)>0.01 .and. qi_bl1D(k)<1.E-8)qi_bl1D(k)=1.E-8

           
           q2p = xlvcp/exner(k)
           pt = thl(k) +q2p*ql(k) 

           
           qt   = 1.0 +p608*qw(k) -(1.+p608)*(qc_bl1D(k)+qi_bl1D(k))*cldfra_bl1D(k)
           rac  = alp(k)*( cldfra_bl1D(K)-qll*eq1 )*( q2p*qt-(1.+p608)*pt )

           
           
           
           vt(k) =      qt-1.0 -rac*bet(k)
           vq(k) = p608*pt-tv0 +rac

        END DO

      CASE (2, -2)

        
        
        PBLH2=MAX(10.,PBLH1)
        zagl = 0.
        DO k = kts,kte-1
           zagl = zagl + dz(k)
           t  = th(k)*exner(k)

           xl = xl_blend(t)                  
           qsat_tk = qsat_blend(t,  p(k))    
           rh(k)=MAX(MIN(1.0,qw(k)/MAX(1.E-8,qsat_tk)),0.001)

           
           dqsl = qsat_tk*ep_2*xlv/( r_d*t**2 )
           alp(k) = 1.0/( 1.0+dqsl*xlvcp )
           bet(k) = dqsl*exner(k)
 
           rsl = xl*qsat_tk / (r_v*t**2)     
                                             
           cpm = cp + qw(k)*cpv              
           a(k) = 1./(1. + xl*rsl/cpm)       
           b(k) = a(k)*rsl                   

           
           qw_pert = qw(k) + qw(k)*0.5*rstoch_col(k)*real(spp_pbl)

           
           qmq    = qw_pert - qsat_tk          

           
           
           r3sq = MAX( qsq(k), 0.0 )
           
           sgm(k) = SQRT( r3sq )
           
           sgm(k) = MIN( sgm(k), qsat_tk*0.666 ) 
           sgm(k) = MAX( sgm(k), qsat_tk*0.035 ) 
                                                 
           q1(k) = qmq  / sgm(k)  
           q1k   = q1(k)          

           
           
           
           
           
           
           cldfra_bl1D(K) = max(0., min(1., 0.5+0.36*atan(1.8*(q1(k)+0.2))))

           
           
           
           IF (q1k < 0.) THEN        
              ql_water = sgm(k)*EXP(1.2*q1k-1)
              ql_ice   = sgm(k)*EXP(1.2*q1k-1.)
           ELSE IF (q1k > 2.) THEN   
              ql_water = sgm(k)*q1k
              ql_ice   = sgm(k)*q1k
           ELSE                      
              ql_water = sgm(k)*(EXP(-1.) + 0.66*q1k + 0.086*q1k**2)
              ql_ice   = sgm(k)*(EXP(-1.) + 0.66*q1k + 0.086*q1k**2)
           ENDIF

           
           if ( qc(k) > 1.e-6 ) ql_water = 0.5 * ( ql_water + qc(k) ) 
           
           
           

           if (cldfra_bl1D(k) < 0.01) then
              ql_ice   = 0.0
              ql_water = 0.0
              cldfra_bl1D(k) = 0.0
           endif

           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
             liq_frac = MIN(1.0, MAX(0.0, (t-tice)/(tliq-tice)))
           

           qc_bl1D(k) = liq_frac*ql_water       
           qi_bl1D(k) = (1.0-liq_frac)*ql_ice

           
           if (k .ge. k_tropo-1) then
              cldfra_bl1D(K) = 0.
              qc_bl1D(k)     = 0.
              qi_bl1D(k)     = 0.
           endif

           
           
           q1k=max(Q1(k),-2.0)

           
           
           
           
           
           
           
           
           
           
           
           
           IF (q1k .GE. 1.0) THEN
              Fng = 1.0
           ELSEIF (q1k .GE. -1.7 .AND. q1k .LT. 1.0) THEN
              Fng = EXP(-0.4*(q1k-1.0))
           ELSEIF (q1k .GE. -2.5 .AND. q1k .LT. -1.7) THEN
              Fng = 3.0 + EXP(-3.8*(q1k+1.7))
           ELSE
              Fng = MIN(23.9 + EXP(-1.6*(q1k+2.5)), 60.)
           ENDIF

           cfmax= min(cldfra_bl1D(k), 0.5)
           bb = b(k)*t/th(k) 
                             
                             
                             
                             
                             
           qww   = 1.+0.61*qw(k)
           alpha = 0.61*th(k)
           beta  = (th(k)/t)*(xl/cp) - 1.61*th(k)
           vt(k) = qww   - cfmax*beta*bb*Fng   - 1.
           vq(k) = alpha + cfmax*beta*a(k)*Fng - tv0
           
           
           
           
           

           
           fac_damp = min(zagl * 0.0025, 1.0)
           
           
           cld_factor = 1.0 + fac_damp*min((max(0.0, ( RH(k) - 0.92 )) / 0.145)**2, 0.4)
           cldfra_bl1D(K) = MIN( 1., cld_factor*cldfra_bl1D(K) )
        enddo

      END SELECT 

      
      IF (bl_mynn_cloudpdf .LT. 0) THEN
         DO k = kts,kte-1
            cldfra_bl1D(k) = 0.0
            qc_bl1D(k) = 0.0
            qi_bl1D(k) = 0.0
         END DO
      ENDIF

      ql(kte) = ql(kte-1)
      vt(kte) = vt(kte-1)
      vq(kte) = vq(kte-1)
      qc_bl1D(kte)=0.
      qi_bl1D(kte)=0.
      cldfra_bl1D(kte)=0.
    RETURN


  END SUBROUTINE mym_condensation





  SUBROUTINE mynn_tendencies(kts,kte,i,    &
       &delt,dz,rho,                       &
       &u,v,th,tk,qv,qc,qi,qnc,qni,        &
       &psfc,p,exner,                      &
       &thl,sqv,sqc,sqi,sqw,               &
       &qnwfa,qnifa,qnbca,ozone,           &
       &ust,flt,flq,flqv,flqc,wspd,        &
       &uoce,voce,                         &
       &tsq,qsq,cov,                       &
       &tcd,qcd,                           &
       &dfm,dfh,dfq,                       &
       &Du,Dv,Dth,Dqv,Dqc,Dqi,Dqnc,Dqni,   &
       &Dqnwfa,Dqnifa,Dqnbca,Dozone,       &
       &diss_heat,                         &
       &s_aw,s_awthl,s_awqt,s_awqv,s_awqc, &
       &s_awu,s_awv,                       &
       &s_awqnc,s_awqni,                   &
       &s_awqnwfa,s_awqnifa,s_awqnbca,     &
       &sd_aw,sd_awthl,sd_awqt,sd_awqv,    &
       &sd_awqc,sd_awu,sd_awv,             &
       &sub_thl,sub_sqv,                   &
       &sub_u,sub_v,                       &
       &det_thl,det_sqv,det_sqc,           &
       &det_u,det_v,                       &
       &FLAG_QC,FLAG_QI,FLAG_QNC,FLAG_QNI, &
       &FLAG_QNWFA,FLAG_QNIFA,FLAG_QNBCA,  &
       &cldfra_bl1d,                       &
       &bl_mynn_cloudmix,                  &
       &bl_mynn_mixqt,                     &
       &bl_mynn_edmf,                      &
       &bl_mynn_edmf_mom,                  &
       &bl_mynn_mixscalars                 )


    INTEGER, INTENT(in) :: kts,kte,i


    INTEGER, INTENT(in) :: bl_mynn_cloudmix,bl_mynn_mixqt,&
                           bl_mynn_edmf,bl_mynn_edmf_mom, &
                           bl_mynn_mixscalars
    LOGICAL, INTENT(IN) :: FLAG_QI,FLAG_QNI,FLAG_QC,FLAG_QNC,&
                           FLAG_QNWFA,FLAG_QNIFA,FLAG_QNBCA








    REAL, DIMENSION(kts:kte+1), INTENT(in) :: s_aw,s_awthl,s_awqt,&
         &s_awqnc,s_awqni,s_awqv,s_awqc,s_awu,s_awv,              &
         &s_awqnwfa,s_awqnifa,s_awqnbca,                          &
         &sd_aw,sd_awthl,sd_awqt,sd_awqv,sd_awqc,sd_awu,sd_awv

    REAL, DIMENSION(kts:kte), INTENT(in) :: sub_thl,sub_sqv,  &
         &sub_u,sub_v,det_thl,det_sqv,det_sqc,det_u,det_v
    REAL, DIMENSION(kts:kte), INTENT(in) :: u,v,th,tk,qv,qc,qi,qni,qnc,&
         &rho,p,exner,dfq,dz,tsq,qsq,cov,tcd,qcd,cldfra_bl1d,diss_heat
    REAL, DIMENSION(kts:kte), INTENT(inout) :: thl,sqw,sqv,sqc,sqi,&
         &qnwfa,qnifa,qnbca,ozone,dfm,dfh
    REAL, DIMENSION(kts:kte), INTENT(inout) :: du,dv,dth,dqv,dqc,dqi,&
         &dqni,dqnc,dqnwfa,dqnifa,dqnbca,dozone
    REAL, INTENT(IN) :: delt,ust,flt,flq,flqv,flqc,wspd,uoce,voce,&
         &psfc
    
    REAL ::wsp,wsp2,tk2,th2
    LOGICAL :: problem
    integer :: kproblem





    REAL, DIMENSION(kts:kte) :: dtz,dfhc,dfmc,delp
    REAL, DIMENSION(kts:kte) :: sqv2,sqc2,sqi2,sqw2,qni2,qnc2, & 
                                qnwfa2,qnifa2,qnbca2,ozone2
    REAL, DIMENSION(kts:kte) :: zfac,plumeKh,rhoinv
    REAL, DIMENSION(kts:kte) :: a,b,c,d,x
    REAL, DIMENSION(kts:kte+1) :: rhoz, & 
          &         khdz, kmdz
    REAL :: rhs,gfluxm,gfluxp,dztop,maxdfh,mindfh,maxcf,maxKh,zw
    REAL :: t,esat,qsl,onoff,kh,km,dzk,rhosfc
    REAL :: ustdrag,ustdiff,qvflux
    REAL :: th_new,portion_qc,portion_qi,condensate,qsat
    INTEGER :: k,kk

    
    
    REAL, PARAMETER :: nonloc = 1.0

    dztop=.5*(dz(kte)+dz(kte-1))

    
    
    
    IF (bl_mynn_edmf_mom == 0) THEN
       onoff=0.0
    ELSE
       onoff=1.0
    ENDIF

    
    
    rhosfc     = psfc/(R_d*(tk(kts)+p608*qv(kts)))
    dtz(kts)   =delt/dz(kts)
    rhoz(kts)  =rho(kts)
    rhoinv(kts)=1./rho(kts)
    khdz(kts)  =rhoz(kts)*dfh(kts)
    kmdz(kts)  =rhoz(kts)*dfm(kts)
    delp(kts)  = psfc - (p(kts+1)*dz(kts) + p(kts)*dz(kts+1))/(dz(kts)+dz(kts+1))
    DO k=kts+1,kte
       dtz(k)   =delt/dz(k)
       rhoz(k)  =(rho(k)*dz(k-1) + rho(k-1)*dz(k))/(dz(k-1)+dz(k))
       rhoz(k)  =  MAX(rhoz(k),1E-4)
       rhoinv(k)=1./MAX(rho(k),1E-4)
       dzk      = 0.5  *( dz(k)+dz(k-1) )
       khdz(k)  = rhoz(k)*dfh(k)
       kmdz(k)  = rhoz(k)*dfm(k)
    ENDDO
    DO k=kts+1,kte-1
       delp(k)  = (p(k)*dz(k-1) + p(k-1)*dz(k))/(dz(k)+dz(k-1)) - &
                  (p(k+1)*dz(k) + p(k)*dz(k+1))/(dz(k)+dz(k+1))
    ENDDO
    delp(kte)  =delp(kte-1)
    rhoz(kte+1)=rhoz(kte)
    khdz(kte+1)=rhoz(kte+1)*dfh(kte)
    kmdz(kte+1)=rhoz(kte+1)*dfm(kte)

    
    DO k=kts+1,kte-1
       khdz(k) = MAX(khdz(k),  0.5*s_aw(k))
       khdz(k) = MAX(khdz(k), -0.5*(s_aw(k)-s_aw(k+1)))
       kmdz(k) = MAX(kmdz(k),  0.5*s_aw(k))
       kmdz(k) = MAX(kmdz(k), -0.5*(s_aw(k)-s_aw(k+1)))
    ENDDO

    ustdrag = MIN(ust*ust,0.99)/wspd  
    ustdiff = MIN(ust*ust,0.01)/wspd  
    dth(kts:kte) = 0.0  





    k=kts









    a(k)=  -dtz(k)*kmdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(kmdz(k+1)+rhosfc*ust**2/wspd)*rhoinv(k) &
           & - 0.5*dtz(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff
    c(k)=  -dtz(k)*kmdz(k+1)*rhoinv(k) &
           & - 0.5*dtz(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff
    d(k)=u(k)  + dtz(k)*uoce*ust**2/wspd - dtz(k)*s_awu(k+1)*onoff - &
       & dtz(k)*rhoinv(k)*sd_awu(k+1)*onoff + sub_u(k)*delt + det_u(k)*delt









    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*kmdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*onoff + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)*onoff 
       b(k)=1.+dtz(k)*(kmdz(k)+kmdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*onoff + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))*onoff
       c(k)=  -dtz(k)*kmdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff
       d(k)=u(k) + dtz(k)*rhoinv(k)*(s_awu(k)-s_awu(k+1))*onoff + dtz(k)*rhoinv(k)*(sd_awu(k)-sd_awu(k+1))*onoff + &
           &    sub_u(k)*delt + det_u(k)*delt
    ENDDO














    a(kte)=0
    b(kte)=1.
    c(kte)=0.
    d(kte)=u(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte

       du(k)=(x(k)-u(k))/delt
    ENDDO





    k=kts









    a(k)=  -dtz(k)*kmdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(kmdz(k+1) + rhosfc*ust**2/wspd)*rhoinv(k) &
        &  - 0.5*dtz(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff
    c(k)=  -dtz(k)*kmdz(k+1)*rhoinv(k) - 0.5*dtz(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff
    d(k)=v(k)  + dtz(k)*voce*ust**2/wspd - dtz(k)*s_awv(k+1)*onoff - dtz(k)*rhoinv(k)*sd_awv(k+1)*onoff + &
       & sub_v(k)*delt + det_v(k)*delt









    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*kmdz(k)*rhoinv(k)   + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*onoff + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)*onoff
       b(k)=1.+dtz(k)*(kmdz(k)+kmdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*onoff + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))*onoff
       c(k)=  -dtz(k)*kmdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*onoff - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)*onoff 
       d(k)=v(k) + dtz(k)*rhoinv(k)*(s_awv(k)-s_awv(k+1))*onoff + dtz(k)*rhoinv(k)*(sd_awv(k)-sd_awv(k+1))*onoff + &
           &    sub_v(k)*delt + det_v(k)*delt
    ENDDO














    a(kte)=0
    b(kte)=1.
    c(kte)=0.
    d(kte)=v(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte

       dv(k)=(x(k)-v(k))/delt
    ENDDO




    k=kts


















    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    d(k)=thl(k)  + dtz(k)*rhosfc*flt*rhoinv(k) + tcd(k)*delt &
       & - dtz(k)*rhoinv(k)*s_awthl(k+1) -dtz(k)*rhoinv(k)*sd_awthl(k+1) + &
       & diss_heat(k)*delt + sub_thl(k)*delt + det_thl(k)*delt

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k) + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &   0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1)) + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
       d(k)=thl(k) + tcd(k)*delt + &
          & dtz(k)*rhoinv(k)*(s_awthl(k)-s_awthl(k+1)) + dtz(k)*rhoinv(k)*(sd_awthl(k)-sd_awthl(k+1)) + &
          &       diss_heat(k)*delt + &
          &       sub_thl(k)*delt + det_thl(k)*delt
    ENDDO















    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=thl(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       thl(k)=x(k)
    ENDDO

IF (bl_mynn_mixqt > 0) THEN
 
 
 
 
 
 

    k=kts















    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    d(k)=sqw(k)  + dtz(k)*rhosfc*flq*rhoinv(k) + qcd(k)*delt - dtz(k)*rhoinv(k)*s_awqt(k+1) - dtz(k)*rhoinv(k)*sd_awqt(k+1)

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k) + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1)) + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
       d(k)=sqw(k) + qcd(k)*delt + dtz(k)*rhoinv(k)*(s_awqt(k)-s_awqt(k+1)) + dtz(k)*rhoinv(k)*(sd_awqt(k)-sd_awqt(k+1))
    ENDDO













    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=sqw(kte)


    CALL tridiag2(kte,a,b,c,d,sqw2)





ELSE
    sqw2=sqw
ENDIF

IF (bl_mynn_mixqt == 0) THEN




  IF (bl_mynn_cloudmix > 0 .AND. FLAG_QC) THEN

    k=kts
















    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    d(k)=sqc(k)  + dtz(k)*rhosfc*flqc*rhoinv(k) + qcd(k)*delt &
       &  - dtz(k)*rhoinv(k)*s_awqc(k+1) - dtz(k)*rhoinv(k)*sd_awqc(k+1) + &
       &  det_sqc(k)*delt

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k) + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1)) + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
       d(k)=sqc(k) + qcd(k)*delt + dtz(k)*rhoinv(k)*(s_awqc(k)-s_awqc(k+1)) + dtz(k)*rhoinv(k)*(sd_awqc(k)-sd_awqc(k+1)) + &
          & det_sqc(k)*delt
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=sqc(kte)


    CALL tridiag2(kte,a,b,c,d,sqc2)





  ELSE
    
    sqc2=sqc
  ENDIF
ENDIF

IF (bl_mynn_mixqt == 0) THEN
  
  
  
  

    k=kts















    
    qvflux = flqv
    if (qvflux < 0.0) then
       
       qvflux = max(qvflux, (min(0.9*sqv(kts) - 1e-8, 0.0)/dtz(kts)))
    endif


    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
    d(k)=sqv(k)  + dtz(k)*rhosfc*qvflux*rhoinv(k) + qcd(k)*delt &
       &  - dtz(k)*rhoinv(k)*s_awqv(k+1) - dtz(k)*rhoinv(k)*sd_awqv(k+1) + &
       & sub_sqv(k)*delt + det_sqv(k)*delt

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k) + 0.5*dtz(k)*rhoinv(k)*sd_aw(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1)) + 0.5*dtz(k)*rhoinv(k)*(sd_aw(k)-sd_aw(k+1))
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1) - 0.5*dtz(k)*rhoinv(k)*sd_aw(k+1)
       d(k)=sqv(k) + qcd(k)*delt + dtz(k)*rhoinv(k)*(s_awqv(k)-s_awqv(k+1)) + dtz(k)*rhoinv(k)*(sd_awqv(k)-sd_awqv(k+1)) + &
          & sub_sqv(k)*delt + det_sqv(k)*delt
    ENDDO















    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=sqv(kte)


    CALL tridiag2(kte,a,b,c,d,sqv2)





ELSE
    sqv2=sqv
ENDIF




IF (bl_mynn_cloudmix > 0 .AND. FLAG_QI) THEN

    k=kts














    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)
    d(k)=sqi(k)

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k)
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)
       d(k)=sqi(k)
    ENDDO















    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=sqi(kte)


    CALL tridiag2(kte,a,b,c,d,sqi2)





ELSE
   sqi2=sqi
ENDIF




IF (bl_mynn_cloudmix > 0 .AND. FLAG_QNI .AND. &
      bl_mynn_mixscalars > 0) THEN

    k=kts

    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    d(k)=qni(k)  - dtz(k)*rhoinv(k)*s_awqni(k+1)*nonloc

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*nonloc
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*nonloc
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
       d(k)=qni(k) + dtz(k)*rhoinv(k)*(s_awqni(k)-s_awqni(k+1))*nonloc
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qni(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       qni2(k)=x(k)
    ENDDO

ELSE
    qni2=qni
ENDIF





  IF (bl_mynn_cloudmix > 0 .AND. FLAG_QNC .AND. &
      bl_mynn_mixscalars > 0) THEN

    k=kts

    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    d(k)=qnc(k)  - dtz(k)*rhoinv(k)*s_awqnc(k+1)*nonloc

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*nonloc
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*nonloc
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
       d(k)=qnc(k) + dtz(k)*rhoinv(k)*(s_awqnc(k)-s_awqnc(k+1))*nonloc
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qnc(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       qnc2(k)=x(k)
    ENDDO

ELSE
    qnc2=qnc
ENDIF




IF (bl_mynn_cloudmix > 0 .AND. FLAG_QNWFA .AND. &
      bl_mynn_mixscalars > 0) THEN

    k=kts

    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) - &
           &    0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    d(k)=qnwfa(k)  - dtz(k)*rhoinv(k)*s_awqnwfa(k+1)*nonloc

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*nonloc
       b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*nonloc
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
       d(k)=qnwfa(k) + dtz(k)*rhoinv(k)*(s_awqnwfa(k)-s_awqnwfa(k+1))*nonloc
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qnwfa(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       qnwfa2(k)=x(k)
    ENDDO

ELSE
    
    qnwfa2=qnwfa
ENDIF




IF (bl_mynn_cloudmix > 0 .AND. FLAG_QNIFA .AND. &
      bl_mynn_mixscalars > 0) THEN

   k=kts

    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) - &
           &    0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    d(k)=qnifa(k)  - dtz(k)*rhoinv(k)*s_awqnifa(k+1)*nonloc

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*nonloc
       b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*nonloc
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
       d(k)=qnifa(k) + dtz(k)*rhoinv(k)*(s_awqnifa(k)-s_awqnifa(k+1))*nonloc
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qnifa(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       qnifa2(k)=x(k)
    ENDDO

ELSE
    
    qnifa2=qnifa
ENDIF




IF (bl_mynn_cloudmix > 0 .AND. FLAG_QNBCA .AND. &
      bl_mynn_mixscalars > 0) THEN

   k=kts

    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) - &
           &    0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
    d(k)=qnbca(k)  - dtz(k)*rhoinv(k)*s_awqnbca(k+1)*nonloc

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)*nonloc
       b(k)=1.+dtz(k)*(khdz(k) + khdz(k+1))*rhoinv(k) + &
           &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))*nonloc
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)*nonloc
       d(k)=qnbca(k) + dtz(k)*rhoinv(k)*(s_awqnbca(k)-s_awqnbca(k+1))*nonloc
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=qnbca(kte)



    CALL tridiag3(kte,a,b,c,d,x)

    DO k=kts,kte
       
       qnbca2(k)=x(k)
    ENDDO

ELSE
    
    qnbca2=qnbca
ENDIF





    k=kts


    a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
    b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k)
    c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)
    d(k)=ozone(k)

    DO k=kts+1,kte-1
       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
       b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k)
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)
       d(k)=ozone(k)
    ENDDO


    a(kte)=0.
    b(kte)=1.
    c(kte)=0.
    d(kte)=ozone(kte)


    CALL tridiag2(kte,a,b,c,d,x)


    DO k=kts,kte
       
       dozone(k)=(x(k)-ozone(k))/delt
    ENDDO






   IF (bl_mynn_mixqt > 0) THEN 
      DO k=kts,kte
         
         th_new = thl(k) + xlvcp/exner(k)*sqc(k) &
           &             + xlscp/exner(k)*sqi(k)

         t  = th_new*exner(k)
         qsat = qsat_blend(t,p(k)) 
         
         
         
         
         

         IF (sqc(k) > 0.0 .or. sqi(k) > 0.0) THEN 
            sqv2(k) = MIN(sqw2(k),qsat)
            portion_qc = sqc(k)/(sqc(k) + sqi(k))
            portion_qi = sqi(k)/(sqc(k) + sqi(k))
            condensate = MAX(sqw2(k) - qsat, 0.0)
            sqc2(k) = condensate*portion_qc
            sqi2(k) = condensate*portion_qi
         ELSE                     
            sqv2(k) = sqw2(k)     
            sqi2(k) = 0.0         
            sqc2(k) = 0.0
         ENDIF
         
         
         
      ENDDO
   ENDIF


    
    
    
    DO k=kts,kte
       Dqv(k)=(sqv2(k)/(1.-sqv2(k)) - qv(k))/delt
       
    ENDDO

    IF (bl_mynn_cloudmix > 0) THEN
      
      
      
      
      IF (FLAG_QC) THEN
         DO k=kts,kte
            Dqc(k)=(sqc2(k)/(1.-sqv2(k)) - qc(k))/delt
            
         ENDDO
      ELSE
         DO k=kts,kte
           Dqc(k) = 0.
         ENDDO
      ENDIF

      
      
      
      IF (FLAG_QNC .AND. bl_mynn_mixscalars > 0) THEN
         DO k=kts,kte
           Dqnc(k) = (qnc2(k)-qnc(k))/delt
           
         ENDDO 
      ELSE
         DO k=kts,kte
           Dqnc(k) = 0.
         ENDDO
      ENDIF

      
      
      
      IF (FLAG_QI) THEN
         DO k=kts,kte
           Dqi(k)=(sqi2(k)/(1.-sqv2(k)) - qi(k))/delt
           
         ENDDO
      ELSE
         DO k=kts,kte
           Dqi(k) = 0.
         ENDDO
      ENDIF

      
      
      
      IF (FLAG_QNI .AND. bl_mynn_mixscalars > 0) THEN
         DO k=kts,kte
           Dqni(k)=(qni2(k)-qni(k))/delt
           
         ENDDO
      ELSE
         DO k=kts,kte
           Dqni(k)=0.
         ENDDO
      ENDIF
    ELSE 
      
      DO k=kts,kte
         Dqc(k)=0.
         Dqnc(k)=0.
         Dqi(k)=0.
         Dqni(k)=0.
      ENDDO
    ENDIF

    
    CALL moisture_check(kte, delt, delp, exner,  &
                        sqv2, sqc2, sqi2, thl,   &
                        dqv, dqc, dqi, dth )

    
    
    
    DO k=kts,kte
       IF(Dozone(k)*delt + ozone(k) < 0.) THEN
         Dozone(k)=-ozone(k)*0.99/delt
       ENDIF
    ENDDO

    
    
    
    IF (FLAG_QI) THEN
      DO k=kts,kte
         Dth(k)=(thl(k) + xlvcp/exner(k)*sqc2(k) &
           &            + xlscp/exner(k)*sqi2(k) &
           &            - th(k))/delt
         
         
         
         
         
      ENDDO
    ELSE
      DO k=kts,kte
         Dth(k)=(thl(k)+xlvcp/exner(k)*sqc2(k) - th(k))/delt
         
         
         
         
      ENDDO
    ENDIF

    
    
    
    IF (FLAG_QNWFA .AND. FLAG_QNIFA .AND. &
        bl_mynn_mixscalars > 0) THEN
       DO k=kts,kte
          
          
          
          Dqnwfa(k)=(qnwfa2(k) - qnwfa(k))/delt
          
          
          
          Dqnifa(k)=(qnifa2(k) - qnifa(k))/delt
          
          
          
          Dqnbca(k)=(qnbca2(k) - qnbca(k))/delt
       ENDDO
    ELSE
       DO k=kts,kte
          Dqnwfa(k)=0.
          Dqnifa(k)=0.
          Dqnbca(k)=0.
       ENDDO
    ENDIF

    
    
    
    
    
    

    if (debug_code) then
       problem = .false.
       do k=kts,kte
          wsp  = sqrt(u(k)**2 + v(k)**2)
          wsp2 = sqrt((u(k)+du(k)*delt)**2 + (v(k)+du(k)*delt)**2)
          th2  = th(k) + Dth(k)*delt
          tk2  = th2*exner(k)
          if (wsp2 > 200. .or. tk2 > 360. .or. tk2 < 160.) then
             problem = .true.
             print*,"Outgoing problem at: i=",i," k=",k
             print*," incoming wsp=",wsp," outgoing wsp=",wsp2
             print*," incoming T=",th(k)*exner(k),"outgoing T:",tk2
             print*," du=",du(k)*delt," dv=",dv(k)*delt," dth=",dth(k)*delt
             print*," km=",kmdz(k)*dz(k)," kh=",khdz(k)*dz(k)
             print*," u*=",ust," wspd=",wspd,"rhosfc=",rhosfc
             print*," LH=",flq*rhosfc*1004.," HFX=",flt*rhosfc*1004.
             print*," drag term=",ust**2/wspd*dtz(k)*rhosfc/rho(kts)
             kproblem = k
          endif
       enddo
       if (problem) then
          print*,"==thl:",thl(max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qv:",sqv2(max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qc:",sqc2(max(kproblem-3,1):min(kproblem+3,kte))
          print*,"===qi:",sqi2(max(kproblem-3,1):min(kproblem+3,kte))
          print*,"====u:",u(max(kproblem-3,1):min(kproblem+3,kte))
          print*,"====v:",v(max(kproblem-3,1):min(kproblem+3,kte))
       endif
    endif


  END SUBROUTINE mynn_tendencies


  SUBROUTINE moisture_check(kte, delt, dp, exner, &
                            qv, qc, qi, th,       &
                            dqv, dqc, dqi, dth )

  
  
  
  
  
  
  
  
  
  
  
  

    implicit none
    integer,  intent(in)     :: kte
    real, intent(in)         :: delt
    real, dimension(kte), intent(in)     :: dp, exner
    real, dimension(kte), intent(inout)  :: qv, qc, qi, th
    real, dimension(kte), intent(inout)  :: dqv, dqc, dqi, dth
    integer   k
    real ::  dqc2, dqi2, dqv2, sum, aa, dum
    real, parameter :: qvmin = 1e-20,   &
                       qcmin = 0.0,     &
                       qimin = 0.0

    do k = kte, 1, -1  
       dqc2 = max(0.0, qcmin-qc(k)) 
       dqi2 = max(0.0, qimin-qi(k)) 

       
       dqc(k) = dqc(k) +  dqc2/delt
       dqi(k) = dqi(k) +  dqi2/delt
       dqv(k) = dqv(k) - (dqc2+dqi2)/delt
       dth(k) = dth(k) + xlvcp/exner(k)*(dqc2/delt) + &
                         xlscp/exner(k)*(dqi2/delt)
       
       qc(k)  = qc(k)  +  dqc2
       qi(k)  = qi(k)  +  dqi2
       qv(k)  = qv(k)  -  dqc2 - dqi2
       th(k)  = th(k)  +  xlvcp/exner(k)*dqc2 + &
                          xlscp/exner(k)*dqi2

       
       dqv2   = max(0.0, qvmin-qv(k)) 
       dqv(k) = dqv(k) + dqv2/delt
       qv(k)  = qv(k)  + dqv2
       if( k .ne. 1 ) then
           qv(k-1)   = qv(k-1)  - dqv2*dp(k)/dp(k-1)
           dqv(k-1)  = dqv(k-1) - dqv2*dp(k)/dp(k-1)/delt
       endif
       qv(k) = max(qv(k),qvmin)
       qc(k) = max(qc(k),qcmin)
       qi(k) = max(qi(k),qimin)
    end do


    
    if( dqv2 .gt. 1.e-20 ) then
        sum = 0.0
        do k = 1, kte
           if( qv(k) .gt. 2.0*qvmin ) sum = sum + qv(k)*dp(k)
        enddo
        aa = dqv2*dp(1)/max(1.e-20,sum)
        if( aa .lt. 0.5 ) then
            do k = 1, kte
               if( qv(k) .gt. 2.0*qvmin ) then
                   dum    = aa*qv(k)
                   qv(k)  = qv(k) - dum
                   dqv(k) = dqv(k) - dum/delt
               endif
            enddo
        else
        

        endif
    endif

    return

  END SUBROUTINE moisture_check



  SUBROUTINE mynn_mix_chem(kts,kte,i,     &
       delt,dz,pblh,                      &
       nchem, kdvel, ndvel,               &
       chem1, vd1,                        &
       rho,                               &
       flt, tcd, qcd,                     &
       dfh,                               &
       s_aw, s_awchem,                    &
       emis_ant_no, frp, rrfs_sd,         &
       enh_mix, smoke_dbg                 )


    INTEGER, INTENT(in) :: kts,kte,i
    REAL, DIMENSION(kts:kte), INTENT(IN)    :: dfh,dz,tcd,qcd
    REAL, DIMENSION(kts:kte), INTENT(INOUT) :: rho
    REAL, INTENT(IN)    :: delt,flt,pblh
    INTEGER, INTENT(IN) :: nchem, kdvel, ndvel
    REAL, DIMENSION( kts:kte+1), INTENT(IN) :: s_aw
    REAL, DIMENSION( kts:kte, nchem ), INTENT(INOUT) :: chem1
    REAL, DIMENSION( kts:kte+1,nchem), INTENT(IN) :: s_awchem
    REAL, DIMENSION( ndvel ), INTENT(IN) :: vd1
    REAL, INTENT(IN) :: emis_ant_no,frp
    LOGICAL, INTENT(IN) :: rrfs_sd,enh_mix,smoke_dbg


    REAL, DIMENSION(kts:kte)     :: dtz
    REAL, DIMENSION(kts:kte) :: a,b,c,d,x
    REAL :: rhs,dztop
    REAL :: t,dzk
    REAL :: hght 
    REAL :: khdz_old, khdz_back
    INTEGER :: k,kk,kmaxfire                         
    INTEGER :: ic  
    
    INTEGER, SAVE :: icall

    REAL, DIMENSION(kts:kte) :: rhoinv
    REAL, DIMENSION(kts:kte+1) :: rhoz,khdz
    REAL, PARAMETER :: NO_threshold    = 10.0     
    REAL, PARAMETER :: frp_threshold   = 10.0     
    REAL, PARAMETER :: pblh_threshold  = 100.0

    dztop=.5*(dz(kte)+dz(kte-1))

    DO k=kts,kte
       dtz(k)=delt/dz(k)
    ENDDO

    
    
    rhoz(kts)  =rho(kts)
    rhoinv(kts)=1./rho(kts)
    khdz(kts)  =rhoz(kts)*dfh(kts)

    DO k=kts+1,kte
       rhoz(k)  =(rho(k)*dz(k-1) + rho(k-1)*dz(k))/(dz(k-1)+dz(k))
       rhoz(k)  =  MAX(rhoz(k),1E-4)
       rhoinv(k)=1./MAX(rho(k),1E-4)
       dzk      = 0.5  *( dz(k)+dz(k-1) )
       khdz(k)  = rhoz(k)*dfh(k)
    ENDDO
    rhoz(kte+1)=rhoz(kte)
    khdz(kte+1)=rhoz(kte+1)*dfh(kte)

    
    DO k=kts+1,kte-1
       khdz(k) = MAX(khdz(k),  0.5*s_aw(k))
       khdz(k) = MAX(khdz(k), -0.5*(s_aw(k)-s_aw(k+1)))
    ENDDO

    
    IF ( rrfs_sd .and. enh_mix ) THEN
       DO k=kts+1,kte-1
          khdz_old  = khdz(k)
          khdz_back = pblh * 0.15 / dz(k)
          
          IF ( pblh < pblh_threshold ) THEN
             IF ( emis_ant_no > NO_threshold ) THEN
                khdz(k) = MAX(1.1*khdz(k),sqrt((emis_ant_no / NO_threshold)) / dz(k) * rhoz(k)) 

             ENDIF
             IF ( frp > frp_threshold ) THEN
                kmaxfire = ceiling(log(frp))
                khdz(k) = MAX(1.1*khdz(k), (1. - k/(kmaxfire*2.)) * ((log(frp))**2.- 2.*log(frp)) / dz(k)*rhoz(k)) 

             ENDIF
          ENDIF
       ENDDO
    ENDIF

  
  
  

    DO ic = 1,nchem
       k=kts

       a(k)=  -dtz(k)*khdz(k)*rhoinv(k)
       b(k)=1.+dtz(k)*(khdz(k+1)+khdz(k))*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)
       c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k)           - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)
       d(k)=chem1(k,ic) & 
            & - dtz(k)*vd1(ic)*chem1(k,ic) &
            & - dtz(k)*rhoinv(k)*s_awchem(k+1,ic)

       DO k=kts+1,kte-1
          a(k)=  -dtz(k)*khdz(k)*rhoinv(k)     + 0.5*dtz(k)*rhoinv(k)*s_aw(k)
          b(k)=1.+dtz(k)*(khdz(k)+khdz(k+1))*rhoinv(k) + &
             &    0.5*dtz(k)*rhoinv(k)*(s_aw(k)-s_aw(k+1))
          c(k)=  -dtz(k)*khdz(k+1)*rhoinv(k) - 0.5*dtz(k)*rhoinv(k)*s_aw(k+1)
          d(k)=chem1(k,ic) + dtz(k)*rhoinv(k)*(s_awchem(k,ic)-s_awchem(k+1,ic))
       ENDDO

      
       a(kte)=0.
       b(kte)=1.
       c(kte)=0.
       d(kte)=chem1(kte,ic)

       CALL tridiag3(kte,a,b,c,d,x)

       DO k=kts,kte
          chem1(k,ic)=x(k)
       ENDDO
    ENDDO

  END SUBROUTINE mynn_mix_chem



  SUBROUTINE retrieve_exchange_coeffs(kts,kte,&
       &dfm,dfh,dz,K_m,K_h)



    INTEGER , INTENT(in) :: kts,kte

    REAL, DIMENSION(KtS:KtE), INTENT(in) :: dz,dfm,dfh

    REAL, DIMENSION(KtS:KtE), INTENT(out) :: K_m, K_h


    INTEGER :: k
    REAL :: dzk

    K_m(kts)=0.
    K_h(kts)=0.

    DO k=kts+1,kte
       dzk = 0.5  *( dz(k)+dz(k-1) )
       K_m(k)=dfm(k)*dzk
       K_h(k)=dfh(k)*dzk
    ENDDO

  END SUBROUTINE retrieve_exchange_coeffs



  SUBROUTINE tridiag(n,a,b,c,d)






    


    INTEGER, INTENT(in):: n
    REAL, DIMENSION(n), INTENT(in) :: a,b
    REAL, DIMENSION(n), INTENT(inout) :: c,d
    
    INTEGER :: i
    REAL :: p
    REAL, DIMENSION(n) :: q
    
    c(n)=0.
    q(1)=-c(1)/b(1)
    d(1)=d(1)/b(1)
    
    DO i=2,n
       p=1./(b(i)+a(i)*q(i-1))
       q(i)=-c(i)*p
       d(i)=(d(i)-a(i)*d(i-1))*p
    ENDDO
    
    DO i=n-1,1,-1
       d(i)=d(i)+q(i)*d(i+1)
    ENDDO

  END SUBROUTINE tridiag



      subroutine tridiag2(n,a,b,c,d,x)
      implicit none







        integer,intent(in) :: n
        real, dimension(n),intent(in) :: a,b,c,d
        real ,dimension(n),intent(out) :: x
        real ,dimension(n) :: cp,dp
        real :: m
        integer :: i

        
        cp(1) = c(1)/b(1)
        dp(1) = d(1)/b(1)
        
        do i = 2,n
           m = b(i)-cp(i-1)*a(i)
           cp(i) = c(i)/m
           dp(i) = (d(i)-dp(i-1)*a(i))/m
        enddo
        
        x(n) = dp(n)
        
        do i = n-1, 1, -1
           x(i) = dp(i)-cp(i)*x(i+1)
        end do

    end subroutine tridiag2


       subroutine tridiag3(kte,a,b,c,d,x)













       implicit none
        integer,intent(in)   :: kte
        integer, parameter   :: kts=1
        real, dimension(kte) :: a,b,c,d
        real ,dimension(kte),intent(out) :: x
        integer :: in




        do in=kte-1,kts,-1
         d(in)=d(in)-c(in)*d(in+1)/b(in+1)
         b(in)=b(in)-c(in)*a(in+1)/b(in+1)
        enddo

        do in=kts+1,kte
         d(in)=d(in)-a(in)*d(in-1)/b(in-1)
        enddo

        do in=kts,kte
         x(in)=d(in)/b(in)
        enddo

        return
        end subroutine tridiag3





















  SUBROUTINE GET_PBLH(KTS,KTE,zi,thetav1D,qke1D,zw1D,dz1D,landsea,kzi)

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    INTEGER,INTENT(IN) :: KTS,KTE


    REAL, INTENT(OUT) :: zi
    REAL, INTENT(IN) :: landsea
    REAL, DIMENSION(KTS:KTE), INTENT(IN) :: thetav1D, qke1D, dz1D
    REAL, DIMENSION(KTS:KTE+1), INTENT(IN) :: zw1D
    
    REAL ::  PBLH_TKE,qtke,qtkem1,wt,maxqke,TKEeps,minthv
    REAL :: delt_thv   
    REAL, PARAMETER :: sbl_lim  = 200. 
    REAL, PARAMETER :: sbl_damp = 400. 
    INTEGER :: I,J,K,kthv,ktke,kzi

    
    kzi = 2

    
    k = kts+1
    kthv = 1
    minthv = 9.E9
    DO WHILE (zw1D(k) .LE. 200.)
    
       IF (minthv > thetav1D(k)) then
           minthv = thetav1D(k)
           kthv = k
       ENDIF
       k = k+1
       
    ENDDO

    
    zi=0.
    k = kthv+1
    IF((landsea-1.5).GE.0)THEN
        
        delt_thv = 1.0
    ELSE
        
        delt_thv = 1.25
    ENDIF

    zi=0.
    k = kthv+1

    DO k=kts+1,kte-1
       IF (thetav1D(k) .GE. (minthv + delt_thv))THEN
          zi = zw1D(k) - dz1D(k-1)* &
             & MIN((thetav1D(k)-(minthv + delt_thv))/ &
             & MAX(thetav1D(k)-thetav1D(k-1),1E-6),1.0)
       ENDIF
       
       IF (k .EQ. kte-1) zi = zw1D(kts+1) 
       IF (zi .NE. 0.0) exit
    ENDDO
    

    
    
    
    
    ktke = 1
    maxqke = MAX(Qke1D(kts),0.)
    
    
    TKEeps = maxqke/40.
    TKEeps = MAX(TKEeps,0.02) 
    PBLH_TKE=0.

    k = ktke+1

    DO k=kts+1,kte-1
       
       qtke  =MAX(Qke1D(k)/2.,0.)      
       qtkem1=MAX(Qke1D(k-1)/2.,0.)
       IF (qtke .LE. TKEeps) THEN
           PBLH_TKE = zw1D(k) - dz1D(k-1)* &
             & MIN((TKEeps-qtke)/MAX(qtkem1-qtke, 1E-6), 1.0)
           
           PBLH_TKE = MAX(PBLH_TKE,zw1D(kts+1))
           
       ENDIF
       
       IF (k .EQ. kte-1) PBLH_TKE = zw1D(kts+1) 
       IF (PBLH_TKE .NE. 0.) exit
    ENDDO

    
    
    
    
    
    
    PBLH_TKE = MIN(PBLH_TKE,zi+350.)
    PBLH_TKE = MAX(PBLH_TKE,MAX(zi-350.,10.))

    wt=.5*TANH((zi - sbl_lim)/sbl_damp) + .5
    IF (maxqke <= 0.05) THEN
       
    ELSE
       
       zi=PBLH_TKE*(1.-wt) + zi*wt
    ENDIF

    
    DO k=kts+1,kte-1
       IF ( zw1D(k) >= zi) THEN
          kzi = k-1
          exit
       ENDIF
    ENDDO


  END SUBROUTINE GET_PBLH

  



















  SUBROUTINE DMP_mf(                            &
                 & kts,kte,dt,zw,dz,p,rho,      &
                 & momentum_opt,                &
                 & tke_opt,                     &
                 & scalar_opt,                  &
                 & u,v,w,th,thl,thv,tk,         &
                 & qt,qv,qc,qke,                &
                 & qnc,qni,qnwfa,qnifa,qnbca,   &
                 & exner,vt,vq,sgm,             &
                 & ust,flt,fltv,flq,flqv,       &
                 & pblh,kpbl,dx,landsea,ts,     &
            
                 & edmf_a,edmf_w,               &
                 & edmf_qt,edmf_thl,            &
                 & edmf_ent,edmf_qc,            &
            
                 & s_aw,s_awthl,s_awqt,         &
                 & s_awqv,s_awqc,               &
                 & s_awu,s_awv,s_awqke,         &
                 & s_awqnc,s_awqni,             &
                 & s_awqnwfa,s_awqnifa,         &
                 & s_awqnbca,                   &
                 & sub_thl,sub_sqv,             &
                 & sub_u,sub_v,                 &
                 & det_thl,det_sqv,det_sqc,     &
                 & det_u,det_v,                 &
            
                 & nchem,chem1,s_awchem,        &
                 & mix_chem,                    &
            
                 & qc_bl1d,cldfra_bl1d,         &
                 & qc_bl1D_old,cldfra_bl1D_old, &
            
                 & F_QC,F_QI,                   &
                 & F_QNC,F_QNI,                 &
                 & F_QNWFA,F_QNIFA,F_QNBCA,     &
                 & Psig_shcu,                   &
            
                 &nup2,ktop,maxmf,ztop,         &
            
                 &spp_pbl,rstoch_col            ) 

  
     INTEGER, INTENT(IN) :: KTS,KTE,KPBL,momentum_opt,tke_opt,scalar_opt



     INTEGER,  INTENT(IN)          :: spp_pbl
     REAL, DIMENSION(KTS:KTE)      :: rstoch_col

     REAL,DIMENSION(KTS:KTE), INTENT(IN) ::                            &
                   u,v,w,th,thl,tk,qt,qv,qc,                           &
                   exner,dz,THV,P,rho,qke,qnc,qni,qnwfa,qnifa,qnbca
     REAL,DIMENSION(KTS:KTE+1), INTENT(IN) :: zw    
     REAL, INTENT(IN) :: dt,ust,flt,fltv,flq,flqv,pblh,                &
                         dx,psig_shcu,landsea,ts
     LOGICAL, OPTIONAL :: f_qc,f_qi,f_qnc,f_qni,                       &
                   f_qnwfa,f_qnifa,f_qnbca

  
     REAL,DIMENSION(KTS:KTE), INTENT(OUT) :: edmf_a,edmf_w,            &
                      & edmf_qt,edmf_thl,edmf_ent,edmf_qc
     
     REAL,DIMENSION(KTS:KTE) :: edmf_th
  
     INTEGER, INTENT(OUT) :: nup2,ktop
     REAL, INTENT(OUT) :: maxmf,ztop
  
     REAL,DIMENSION(KTS:KTE+1) :: s_aw,s_awthl,s_awqt,                 &
                         s_awqv,s_awqc,s_awqnc,s_awqni,                &
                         s_awqnwfa,s_awqnifa,s_awqnbca,                &
                         s_awu,s_awv,s_awqke,s_aw2

     REAL,DIMENSION(KTS:KTE), INTENT(INOUT) :: qc_bl1d,cldfra_bl1d,    &
                                       qc_bl1d_old,cldfra_bl1d_old

    INTEGER, PARAMETER :: nup=10, debug_mf=0

  
  
  
     REAL,DIMENSION(KTS:KTE+1,1:NUP) :: UPW,UPTHL,UPQT,UPQC,UPQV,      &
                                        UPA,UPU,UPV,UPTHV,UPQKE,UPQNC, &
                                        UPQNI,UPQNWFA,UPQNIFA,UPQNBCA
  
     REAL,DIMENSION(KTS:KTE,1:NUP) :: ENT,ENTf
     INTEGER,DIMENSION(KTS:KTE,1:NUP) :: ENTi
  
     INTEGER :: K,I,k50
     REAL :: fltv2,wstar,qstar,thstar,sigmaW,sigmaQT,sigmaTH,z0,       &
             pwmin,pwmax,wmin,wmax,wlv,Psig_w,maxw,maxqc,wpbl
     REAL :: B,QTn,THLn,THVn,QCn,Un,Vn,QKEn,QNCn,QNIn,                 &
             QNWFAn,QNIFAn,QNBCAn,                                     &
             Wn2,Wn,EntEXP,EntEXM,EntW,BCOEFF,THVkm1,THVk,Pk,rho_int

  
     REAL,PARAMETER :: &
          &Wa=2./3.,   &
          &Wb=0.002,   &
          &Wc=1.5 
        
  
  
     REAL,PARAMETER :: &
         & L0=100.,    &
         & ENT0=0.1

  
     REAL, PARAMETER :: Atot = 0.10 
     REAL, PARAMETER :: lmax = 1000.
     REAL, PARAMETER :: dl   = 100. 
     REAL, PARAMETER :: dcut = 1.2  
     REAL ::  d            
          
          
     REAL :: cn,c,l,n,an2,hux,maxwidth,wspd_pbl,cloud_base,width_flx

  
     INTEGER, INTENT(IN) :: nchem
     REAL,DIMENSION(:, :) :: chem1
     REAL,DIMENSION(kts:kte+1, nchem) :: s_awchem
     REAL,DIMENSION(nchem) :: chemn
     REAL,DIMENSION(KTS:KTE+1,1:NUP, nchem) :: UPCHEM
     INTEGER :: ic
     REAL,DIMENSION(KTS:KTE+1, nchem) :: edmf_chem
     LOGICAL, INTENT(IN) :: mix_chem

  
   REAL :: ERF

   LOGICAL :: superadiabatic

  
   REAL,DIMENSION(KTS:KTE), INTENT(INOUT) :: vt, vq, sgm
   REAL :: sigq,xl,rsl,cpm,a,qmq,mf_cf,Aup,Q1,diffqt,qsat_tk,&
           Fng,qww,alpha,beta,bb,f,pt,t,q2p,b9,satvp,rhgrid, &
           Ac_mf,Ac_strat,qc_mf
   REAL, PARAMETER :: cf_thresh = 0.5 

  
   REAL,DIMENSION(KTS:KTE) :: exneri,dzi
   REAL :: THp, QTp, QCp, QCs, esat, qsl
   REAL :: csigma,acfac,ac_wsp,ac_cld

   
   INTEGER :: overshoot
   REAL :: bvf, Frz, dzp

   
   
   REAL :: adjustment, flx1
   REAL, PARAMETER :: fluxportion=0.75 
                                       

   
   REAL,DIMENSION(KTS:KTE) :: sub_thl,sub_sqv,sub_u,sub_v,    &  
                      det_thl,det_sqv,det_sqc,det_u,det_v,    &  
                 envm_a,envm_w,envm_thl,envm_sqv,envm_sqc,    &
                                       envm_u,envm_v  
   REAL,DIMENSION(KTS:KTE+1) ::  envi_a,envi_w        
   REAL :: temp,sublim,qc_ent,qv_ent,qt_ent,thl_ent,detrate,  &
           detrateUV,oow,exc_fac,aratio,detturb,qc_grid,qc_sgs,&
           qc_plume,exc_heat,exc_moist,tk_int
   REAL, PARAMETER :: Cdet   = 1./45.
   REAL, PARAMETER :: dzpmax = 300. 
   
   
   
   
   REAL, PARAMETER :: Csub=0.25

   
   REAL, PARAMETER :: pgfac = 0.00  
   REAL :: Uk,Ukm1,Vk,Vkm1,dxsa














  UPW=0.
  UPTHL=0.
  UPTHV=0.
  UPQT=0.
  UPA=0.
  UPU=0.
  UPV=0.
  UPQC=0.
  UPQV=0.
  UPQKE=0.
  UPQNC=0.
  UPQNI=0.
  UPQNWFA=0.
  UPQNIFA=0.
  UPQNBCA=0.
  IF ( mix_chem ) THEN
     UPCHEM(KTS:KTE+1,1:NUP,1:nchem)=0.0
  ENDIF

  ENT=0.001

  edmf_a  =0.
  edmf_w  =0.
  edmf_qt =0.
  edmf_thl=0.
  edmf_ent=0.
  edmf_qc =0.
  IF ( mix_chem ) THEN
     edmf_chem(kts:kte+1,1:nchem) = 0.0
  ENDIF


  s_aw=0.
  s_awthl=0.
  s_awqt=0.
  s_awqv=0.
  s_awqc=0.
  s_awu=0.
  s_awv=0.
  s_awqke=0.
  s_awqnc=0.
  s_awqni=0.
  s_awqnwfa=0.
  s_awqnifa=0.
  s_awqnbca=0.
  IF ( mix_chem ) THEN
     s_awchem(kts:kte+1,1:nchem) = 0.0
  ENDIF


  sub_thl = 0.
  sub_sqv = 0.
  sub_u = 0.
  sub_v = 0.
  det_thl = 0.
  det_sqv = 0.
  det_sqc = 0.
  det_u = 0.
  det_v = 0.

  
  
  k      = 1
  maxw   = 0.0
  cloud_base  = 9000.0

  DO k=1,kte-1
     IF(zw(k) > pblh + 500.) exit

     wpbl = w(k)
     IF(w(k) < 0.)wpbl = 2.*w(k)
     maxw = MAX(maxw,ABS(wpbl))

     
     IF(ZW(k)<=50.)k50=k

     
     qc_sgs = MAX(qc(k), qc_bl1d(k)*cldfra_bl1d(k))
     IF(qc_sgs> 1E-5 .AND. cloud_base == 9000.0)THEN
       cloud_base = 0.5*(ZW(k)+ZW(k+1))
     ENDIF

     
  ENDDO
  
  maxw = MAX(0.,maxw - 1.0)     
  Psig_w = MAX(0.0, 1.0 - maxw) 
  Psig_w = MIN(Psig_w, Psig_shcu)
  

  
  fltv2 = fltv
  IF(Psig_w == 0.0 .and. fltv > 0.0) fltv2 = -1.*fltv

  
  
  superadiabatic = .false.
  IF((landsea-1.5).GE.0)THEN
     hux = -0.001   
  ELSE
     hux = -0.005  
  ENDIF
  DO k=1,MAX(1,k50-1) 
    IF (k == 1) then
      IF ((th(k)-ts)/(0.5*dz(k)) < hux) THEN
        superadiabatic = .true.
      ELSE
        superadiabatic = .false.
        exit
      ENDIF
    ELSE
      IF ((th(k)-th(k-1))/(0.5*(dz(k)+dz(k-1))) < hux) THEN
        superadiabatic = .true.
      ELSE
        superadiabatic = .false.
        exit
      ENDIF
    ENDIF
  ENDDO

  
  
  
  
  
  
  
  
  
    NUP2 = max(1,min(NUP,INT(dx*dcut/dl)))
  
    maxwidth = 1.1*PBLH 
  
    maxwidth = MIN(maxwidth,0.5*cloud_base)
  
    wspd_pbl=SQRT(MAX(u(kts)**2 + v(kts)**2, 0.01))
    
  
    if ((landsea-1.5).LT.0) then  
      
      width_flx = MAX(MIN(1000.*(0.6*tanh((flt - 0.040)/0.03) + .5),1000.), 0.) 
    else                          
      width_flx = MAX(MIN(1000.*(0.6*tanh((flt - 0.003)/0.01) + .5),1000.), 0.)
    endif
    maxwidth = MIN(maxwidth,width_flx)
  
    NUP2 = MIN(MAX(INT((maxwidth - MOD(maxwidth,100.))/100), 0), NUP2)

  
  ktop = 0
  ztop = 0.0
  maxmf= 0.0

  IF ( fltv2 > 0.002 .AND. NUP2 .GE. 1 .AND. superadiabatic) then
    

    
    cn = 0.
    d=-1.9  
    
    do I=1,NUP 
       IF(I > NUP2) exit
       l  = dl*I                            
       cn = cn + l**d * (l*l)/(dx*dx) * dl  
    enddo
    C = Atot/cn   

    
    if ((landsea-1.5).LT.0) then  
       
       
       acfac = .5*tanh((fltv2 - 0.02)/0.05) + .5
    else                          
       acfac = .5*tanh((fltv2 - 0.01)/0.03) + .5
    endif
    
    
    ac_wsp = 1.0 - min(max(wspd_pbl - 20.0, 0.0), 10.0)/10.0
    
    ac_cld = min(cloud_base/1200., 1.0)
    acfac  = acfac * min(ac_wsp, ac_cld)

    
    An2 = 0.
    do I=1,NUP 
       IF(I > NUP2) exit
       l  = dl*I                            
       N  = C*l**d                          
       UPA(1,I) = N*l*l/(dx*dx) * dl        

       UPA(1,I) = UPA(1,I)*acfac
       An2 = An2 + UPA(1,I)                 
       
    end do

    
    z0=50.
    pwmin=0.1       
    pwmax=0.4       

    wstar=max(1.E-2,(gtr*fltv2*pblh)**(onethird))
    qstar=max(flq,1.0E-5)/wstar
    thstar=flt/wstar

    IF((landsea-1.5).GE.0)THEN
       csigma = 1.34   
    ELSE
       csigma = 1.34   
    ENDIF

    if (env_subs) then
       exc_fac = 0.0
    else
       if ((landsea-1.5).GE.0) then
         
         exc_fac = 0.58*4.0*min(cloud_base/1000., 1.0)
       else
         
         exc_fac = 0.58
       endif
    endif

    
    sigmaW =csigma*wstar*(z0/pblh)**(onethird)*(1 - 0.8*z0/pblh)
    sigmaQT=csigma*qstar*(z0/pblh)**(onethird)
    sigmaTH=csigma*thstar*(z0/pblh)**(onethird)

    
    
    wmin=MIN(sigmaW*pwmin,0.1)
    wmax=MIN(sigmaW*pwmax,0.5)

    
    DO I=1,NUP 
       IF(I > NUP2) exit
       wlv=wmin+(wmax-wmin)/NUP2*(i-1)

       
       UPW(1,I)=wmin + REAL(i)/REAL(NUP)*(wmax-wmin)
       

       UPU(1,I)=(U(KTS)*DZ(KTS+1)+U(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPV(1,I)=(V(KTS)*DZ(KTS+1)+V(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQC(1,I)=0.0
       

       exc_heat = exc_fac*UPW(1,I)*sigmaTH/sigmaW
       UPTHV(1,I)=(THV(KTS)*DZ(KTS+1)+THV(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1)) &
           &     + exc_heat

       UPTHL(1,I)=(THL(KTS)*DZ(KTS+1)+THL(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1)) &
           &     + exc_heat

       
       exc_moist=exc_fac*UPW(1,I)*sigmaQT/sigmaW
       








       UPQT(1,I)=(QT(KTS)*DZ(KTS+1)+QT(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))&
            &     +exc_moist

       UPQKE(1,I)=(QKE(KTS)*DZ(KTS+1)+QKE(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQNC(1,I)=(QNC(KTS)*DZ(KTS+1)+QNC(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQNI(1,I)=(QNI(KTS)*DZ(KTS+1)+QNI(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQNWFA(1,I)=(QNWFA(KTS)*DZ(KTS+1)+QNWFA(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQNIFA(1,I)=(QNIFA(KTS)*DZ(KTS+1)+QNIFA(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
       UPQNBCA(1,I)=(QNBCA(KTS)*DZ(KTS+1)+QNBCA(KTS+1)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
    ENDDO

    IF ( mix_chem ) THEN
      DO I=1,NUP 
        IF(I > NUP2) exit
        do ic = 1,nchem
          UPCHEM(1,I,ic)=(chem1(KTS,ic)*DZ(KTS+1)+chem1(KTS+1,ic)*DZ(KTS))/(DZ(KTS)+DZ(KTS+1))
        enddo
      ENDDO
    ENDIF

    
    DO k=kts,kte
       envm_thl(k)=THL(k)
       envm_sqv(k)=QV(k)
       envm_sqc(k)=QC(k)
       envm_u(k)=U(k)
       envm_v(k)=V(k)
    ENDDO

    
    dxsa = 1. - MIN(MAX((12000.0-dx)/(12000.0-3000.0), 0.), 1.)

    
    DO I=1,NUP 
       IF(I > NUP2) exit
       QCn = 0.
       overshoot = 0
       l  = dl*I                            
       DO k=KTS+1,KTE-1
          
          
          wmin = 0.3 + l*0.0005 
          ENT(k,i) = 0.33/(MIN(MAX(UPW(K-1,I),wmin),0.9)*l)

          
          
          
          

          
          ENT(k,i) = max(ENT(k,i),0.0003)
          

          
          IF(ZW(k) >= MIN(pblh+1500., 4000.))THEN
            ENT(k,i)=ENT(k,i) + (ZW(k)-MIN(pblh+1500.,4000.))*5.0E-6
          ENDIF

          
          ENT(k,i) = ENT(k,i) * (1.0 - rstoch_col(k))

          ENT(k,i) = min(ENT(k,i),0.9/(ZW(k+1)-ZW(k)))

          
          Uk  =(U(k)*DZ(k+1)+U(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
          Ukm1=(U(k-1)*DZ(k)+U(k)*DZ(k-1))/(DZ(k-1)+DZ(k))
          Vk  =(V(k)*DZ(k+1)+V(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
          Vkm1=(V(k-1)*DZ(k)+V(k)*DZ(k-1))/(DZ(k-1)+DZ(k))

          
          EntExp= ENT(K,I)*(ZW(k+1)-ZW(k))
          EntExm= EntExp*0.3333    
          QTn =UPQT(k-1,I) *(1.-EntExp) + QT(k)*EntExp
          THLn=UPTHL(k-1,I)*(1.-EntExp) + THL(k)*EntExp
          Un  =UPU(k-1,I)  *(1.-EntExm) + U(k)*EntExm + dxsa*pgfac*(Uk - Ukm1)
          Vn  =UPV(k-1,I)  *(1.-EntExm) + V(k)*EntExm + dxsa*pgfac*(Vk - Vkm1)
          QKEn=UPQKE(k-1,I)*(1.-EntExp) + QKE(k)*EntExp
          QNCn=UPQNC(k-1,I)*(1.-EntExp) + QNC(k)*EntExp
          QNIn=UPQNI(k-1,I)*(1.-EntExp) + QNI(k)*EntExp
          QNWFAn=UPQNWFA(k-1,I)*(1.-EntExp) + QNWFA(k)*EntExp
          QNIFAn=UPQNIFA(k-1,I)*(1.-EntExp) + QNIFA(k)*EntExp
          QNBCAn=UPQNBCA(k-1,I)*(1.-EntExp) + QNBCA(k)*EntExp

          
          
          qc_ent  = QCn
          qt_ent  = QTn
          thl_ent = THLn

          
          
          
          
          
          
          

          if ( mix_chem ) then
            do ic = 1,nchem
              
              
              
              chemn(ic)=UPCHEM(k-1,i,ic)*(1.-EntExp) + chem1(k,ic)*EntExp
            enddo
          endif

          
          Pk    =(P(k)*DZ(k+1)+P(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
          
          call condensation_edmf(QTn,THLn,Pk,ZW(k+1),THVn,QCn)

          
          THVk  =(THV(k)*DZ(k+1)+THV(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
          THVkm1=(THV(k-1)*DZ(k)+THV(k)*DZ(k-1))/(DZ(k-1)+DZ(k))


          B=grav*(THVn/THVk - 1.0)
          IF(B>0.)THEN
            BCOEFF = 0.15        
          ELSE
            BCOEFF = 0.2 
          ENDIF

          
          
          
          
          
          
          

          IF (UPW(K-1,I) < 0.2 ) THEN
             Wn = UPW(K-1,I) + (-2. * ENT(K,I) * UPW(K-1,I) + BCOEFF*B / MAX(UPW(K-1,I),0.2)) * MIN(ZW(k)-ZW(k-1), 250.)
          ELSE
             Wn = UPW(K-1,I) + (-2. * ENT(K,I) * UPW(K-1,I) + BCOEFF*B / UPW(K-1,I)) * MIN(ZW(k)-ZW(k-1), 250.)
          ENDIF
          
          
          IF(Wn > UPW(K-1,I) + MIN(1.25*(ZW(k)-ZW(k-1))/200., 2.0) ) THEN
             Wn = UPW(K-1,I) + MIN(1.25*(ZW(k)-ZW(k-1))/200., 2.0)
          ENDIF
          
          IF(Wn < UPW(K-1,I) - MIN(1.25*(ZW(k)-ZW(k-1))/200., 2.0) ) THEN
             Wn = UPW(K-1,I) - MIN(1.25*(ZW(k)-ZW(k-1))/200., 2.0)
          ENDIF
          Wn = MIN(MAX(Wn,0.0), 3.0)

          
          
          IF (k==kts+1 .AND. Wn == 0.) THEN
             NUP2=0
             exit
          ENDIF

          IF (debug_mf == 1) THEN
            IF (Wn .GE. 3.0) THEN
              
              print *," **** SUSPICIOUSLY LARGE W:"
              print *,' QCn:',QCn,' ENT=',ENT(k,i),' Nup2=',Nup2
              print *,'pblh:',pblh,' Wn:',Wn,' UPW(k-1)=',UPW(K-1,I)
              print *,'K=',k,' B=',B,' dz=',ZW(k)-ZW(k-1)
            ENDIF
          ENDIF

          
          IF (Wn <= 0.0 .AND. overshoot == 0) THEN
             overshoot = 1
             IF ( THVk-THVkm1 .GT. 0.0 ) THEN
                bvf = SQRT( gtr*(THVk-THVkm1)/dz(k) )
                
                Frz = UPW(K-1,I)/(bvf*dz(k))
                
                dzp = dz(k)*MAX(MIN(Frz,1.0),0.0) 
             ENDIF
          ELSE
             dzp = dz(k)
          ENDIF

          
          Wn=Wn*EXP(-MAX(ZW(k+1)-MIN(pblh+2000.,3500.),0.0)/1000.)

          
   
   
   

          
          
          
          aratio   = MIN(UPA(K-1,I)/(1.-UPA(K-1,I)), 0.5) 
          detturb  = 0.00008
          oow      = -0.060/MAX(1.0,(0.5*(Wn+UPW(K-1,I))))   
          detrate  = MIN(MAX(oow*(Wn-UPW(K-1,I))/dz(k), detturb), .0002) 
          detrateUV= MIN(MAX(oow*(Wn-UPW(K-1,I))/dz(k), detturb), .0001) 
          envm_thl(k)=envm_thl(k) + (0.5*(thl_ent + UPTHL(K-1,I)) - thl(k))*detrate*aratio*MIN(dzp,dzpmax)
          qv_ent = 0.5*(MAX(qt_ent-qc_ent,0.) + MAX(UPQT(K-1,I)-UPQC(K-1,I),0.))
          envm_sqv(k)=envm_sqv(k) + (qv_ent-QV(K))*detrate*aratio*MIN(dzp,dzpmax)
          IF (UPQC(K-1,I) > 1E-8) THEN
             IF (QC(K) > 1E-6) THEN
                qc_grid = QC(K)
             ELSE
                qc_grid = cldfra_bl1d(k)*qc_bl1d(K)
             ENDIF
             envm_sqc(k)=envm_sqc(k) + MAX(UPA(K-1,I)*0.5*(QCn + UPQC(K-1,I)) - qc_grid, 0.0)*detrate*aratio*MIN(dzp,dzpmax)
          ENDIF
          envm_u(k)  =envm_u(k)   + (0.5*(Un + UPU(K-1,I)) - U(K))*detrateUV*aratio*MIN(dzp,dzpmax)
          envm_v(k)  =envm_v(k)   + (0.5*(Vn + UPV(K-1,I)) - V(K))*detrateUV*aratio*MIN(dzp,dzpmax)

          IF (Wn > 0.) THEN
             
             UPW(K,I)=Wn  
             UPTHV(K,I)=THVn
             UPTHL(K,I)=THLn
             UPQT(K,I)=QTn
             UPQC(K,I)=QCn
             UPU(K,I)=Un
             UPV(K,I)=Vn
             UPQKE(K,I)=QKEn
             UPQNC(K,I)=QNCn
             UPQNI(K,I)=QNIn
             UPQNWFA(K,I)=QNWFAn
             UPQNIFA(K,I)=QNIFAn
             UPQNBCA(K,I)=QNBCAn
             UPA(K,I)=UPA(K-1,I)
             IF ( mix_chem ) THEN
               do ic = 1,nchem
                 UPCHEM(k,I,ic) = chemn(ic)
               enddo
             ENDIF
             ktop = MAX(ktop,k)
          ELSE
             exit  
          END IF
       ENDDO
       IF (debug_mf == 1) THEN
          IF (MAXVAL(UPW(:,I)) > 10.0 .OR. MINVAL(UPA(:,I)) < 0.0 .OR. &
              MAXVAL(UPA(:,I)) > Atot .OR. NUP2 > 10) THEN
             
             print *,'flq:',flq,' fltv:',fltv2,' Nup2=',Nup2
             print *,'pblh:',pblh,' wstar:',wstar,' ktop=',ktop
             print *,'sigmaW=',sigmaW,' sigmaTH=',sigmaTH,' sigmaQT=',sigmaQT
             
             print *,'u:',u
             print *,'v:',v
             print *,'thl:',thl
             print *,'UPA:',UPA(:,I)
             print *,'UPW:',UPW(:,I)
             print *,'UPTHL:',UPTHL(:,I)
             print *,'UPQT:',UPQT(:,I)
             print *,'ENT:',ENT(:,I)
          ENDIF
       ENDIF
    ENDDO
  ELSE
    
    NUP2=0.
  END IF 

  ktop=MIN(ktop,KTE-1)  
  IF (ktop == 0) THEN
     ztop = 0.0
  ELSE
     ztop=zw(ktop)
  ENDIF

  IF(nup2 > 0) THEN

    
    
    DO i=1,NUP 
      IF(I > NUP2) exit
      DO k=KTS,KTE-1
        IF(k > ktop) exit
        rho_int     = (rho(k)*DZ(k+1)+rho(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
        s_aw(k+1)   = s_aw(k+1)    + rho_int*UPA(K,i)*UPW(K,i)*Psig_w
        s_awthl(k+1)= s_awthl(k+1) + rho_int*UPA(K,i)*UPW(K,i)*UPTHL(K,i)*Psig_w
        s_awqt(k+1) = s_awqt(k+1)  + rho_int*UPA(K,i)*UPW(K,i)*UPQT(K,i)*Psig_w
        
        
        
        IF (qc(k) > 1e-12 .OR. qc(k+1) > 1e-12) then
          qc_plume = UPQC(K,i)
        ELSE
          qc_plume = 0.0
        ENDIF
        s_awqc(k+1) = s_awqc(k+1)  + rho_int*UPA(K,i)*UPW(K,i)*qc_plume*Psig_w
        IF (momentum_opt > 0) THEN
          s_awu(k+1)  = s_awu(k+1)   + rho_int*UPA(K,i)*UPW(K,i)*UPU(K,i)*Psig_w
          s_awv(k+1)  = s_awv(k+1)   + rho_int*UPA(K,i)*UPW(K,i)*UPV(K,i)*Psig_w
        ENDIF
        IF (tke_opt > 0) THEN
          s_awqke(k+1)= s_awqke(k+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQKE(K,i)*Psig_w
        ENDIF
        s_awqv(k+1) = s_awqt(k+1)  - s_awqc(k+1)
      ENDDO
    ENDDO

    IF ( mix_chem ) THEN
      DO k=KTS,KTE
        IF(k > KTOP) exit
        rho_int     = (rho(k)*DZ(k+1)+rho(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
        DO i=1,NUP 
          IF(I > NUP2) exit
          do ic = 1,nchem
            s_awchem(k+1,ic) = s_awchem(k+1,ic) + rho_int*UPA(K,i)*UPW(K,i)*UPCHEM(K,i,ic)*Psig_w
          enddo
        ENDDO
      ENDDO
    ENDIF

    IF (scalar_opt > 0) THEN
      DO k=KTS,KTE
        IF(k > KTOP) exit
        rho_int     = (rho(k)*DZ(k+1)+rho(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
        DO I=1,NUP 
          IF (I > NUP2) exit
          s_awqnc(k+1)= s_awqnc(K+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQNC(K,i)*Psig_w
          s_awqni(k+1)= s_awqni(K+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQNI(K,i)*Psig_w
          s_awqnwfa(k+1)= s_awqnwfa(K+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQNWFA(K,i)*Psig_w
          s_awqnifa(k+1)= s_awqnifa(K+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQNIFA(K,i)*Psig_w
          s_awqnbca(k+1)= s_awqnbca(K+1) + rho_int*UPA(K,i)*UPW(K,i)*UPQNBCA(K,i)*Psig_w
        ENDDO
      ENDDO
    ENDIF

    
    
    
    IF (s_aw(kts+1) /= 0.) THEN
       dzi(kts) = 0.5*(DZ(kts)+DZ(kts+1)) 
       flx1   = MAX(s_aw(kts+1)*(TH(kts)-TH(kts+1))/dzi(kts),1.0e-5)
    ELSE
       flx1 = 0.0
       
       
    ENDIF
    adjustment=1.0
    
    
    IF (flx1 > fluxportion*flt/dz(kts) .AND. flx1>0.0) THEN
       adjustment= fluxportion*flt/dz(kts)/flx1
       s_aw   = s_aw*adjustment
       s_awthl= s_awthl*adjustment
       s_awqt = s_awqt*adjustment
       s_awqc = s_awqc*adjustment
       s_awqv = s_awqv*adjustment
       s_awqnc= s_awqnc*adjustment
       s_awqni= s_awqni*adjustment
       s_awqnwfa= s_awqnwfa*adjustment
       s_awqnifa= s_awqnifa*adjustment
       s_awqnbca= s_awqnbca*adjustment
       IF (momentum_opt > 0) THEN
          s_awu  = s_awu*adjustment
          s_awv  = s_awv*adjustment
       ENDIF
       IF (tke_opt > 0) THEN
          s_awqke= s_awqke*adjustment
       ENDIF
       IF ( mix_chem ) THEN
          s_awchem = s_awchem*adjustment
       ENDIF
       UPA = UPA*adjustment
    ENDIF
    

    
    
    DO k=KTS,KTE-1
      IF(k > KTOP) exit
      rho_int     = (rho(k)*DZ(k+1)+rho(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
      DO I=1,NUP 
        IF(I > NUP2) exit
        edmf_a(K)  =edmf_a(K)  +UPA(K,i)
        edmf_w(K)  =edmf_w(K)  +rho_int*UPA(K,i)*UPW(K,i)
        edmf_qt(K) =edmf_qt(K) +rho_int*UPA(K,i)*UPQT(K,i)
        edmf_thl(K)=edmf_thl(K)+rho_int*UPA(K,i)*UPTHL(K,i)
        edmf_ent(K)=edmf_ent(K)+rho_int*UPA(K,i)*ENT(K,i)
        edmf_qc(K) =edmf_qc(K) +rho_int*UPA(K,i)*UPQC(K,i)
      ENDDO

      
      
      IF (edmf_a(k)>0.) THEN
        edmf_w(k)=edmf_w(k)/edmf_a(k)
        edmf_qt(k)=edmf_qt(k)/edmf_a(k)
        edmf_thl(k)=edmf_thl(k)/edmf_a(k)
        edmf_ent(k)=edmf_ent(k)/edmf_a(k)
        edmf_qc(k)=edmf_qc(k)/edmf_a(k)
        edmf_a(k)=edmf_a(k)*Psig_w

        
        IF(edmf_a(k)*edmf_w(k) > maxmf) maxmf = edmf_a(k)*edmf_w(k)
      ENDIF
    ENDDO 

    
    IF ( mix_chem ) THEN
      DO k=kts,kte-1
        IF(k > KTOP) exit
        rho_int     = (rho(k)*dz(k+1)+rho(k+1)*dz(k))/(dz(k+1)+dz(k))
        DO I=1,NUP 
          IF(I > NUP2) exit
          do ic = 1,nchem
            edmf_chem(k,ic) = edmf_chem(k,ic) + rho_int*UPA(K,I)*UPCHEM(k,i,ic)
          enddo
        ENDDO

        IF (edmf_a(k)>0.) THEN
          do ic = 1,nchem
            edmf_chem(k,ic) = edmf_chem(k,ic)/edmf_a(k)
          enddo
        ENDIF
      ENDDO 
    ENDIF

    
    
    IF (env_subs) THEN
       DO k=kts+1,kte-1
          
          
          
          
          envi_w(k) = onethird*(edmf_w(k-1)+edmf_w(k)+edmf_w(k+1))
          envi_a(k) = onethird*(edmf_a(k-1)+edmf_a(k)+edmf_a(k+1))*adjustment
       ENDDO
       
       envi_w(kts) = edmf_w(kts)
       envi_a(kts) = edmf_a(kts)
       
       envi_w(kte) = 0.0
       envi_a(kte) = edmf_a(kte)
       
       envi_w(kte+1) = 0.0
       envi_a(kte+1) = edmf_a(kte)
       
       
       
       IF (envi_w(kts) > 0.9*DZ(kts)/dt) THEN
          sublim = 0.9*DZ(kts)/dt/envi_w(kts)
       ELSE
          sublim = 1.0
       ENDIF
       
       DO k=kts,kte
          temp=envi_a(k)
          envi_a(k)=1.0-temp
          envi_w(k)=csub*sublim*envi_w(k)*temp/(1.-temp)
       ENDDO
       
       
       dzi(kts)    = 0.5*(dz(kts)+dz(kts+1))
       rho_int     = (rho(kts)*dz(kts+1)+rho(kts+1)*dz(kts))/(dz(kts+1)+dz(kts))
       sub_thl(kts)= 0.5*envi_w(kts)*envi_a(kts)*                               &
                     (rho(kts+1)*thl(kts+1)-rho(kts)*thl(kts))/dzi(kts)/rho_int
       sub_sqv(kts)= 0.5*envi_w(kts)*envi_a(kts)*                               &
                     (rho(kts+1)*qv(kts+1)-rho(kts)*qv(kts))/dzi(kts)/rho_int
       DO k=kts+1,kte-1
          dzi(k)    = 0.5*(dz(k)+dz(k+1))
          rho_int   = (rho(k)*dz(k+1)+rho(k+1)*dz(k))/(dz(k+1)+dz(k))
          sub_thl(k)= 0.5*(envi_w(k)+envi_w(k-1))*0.5*(envi_a(k)+envi_a(k-1)) * &
                      (rho(k+1)*thl(k+1)-rho(k)*thl(k))/dzi(k)/rho_int
          sub_sqv(k)= 0.5*(envi_w(k)+envi_w(k-1))*0.5*(envi_a(k)+envi_a(k-1)) * &
                      (rho(k+1)*qv(k+1)-rho(k)*qv(k))/dzi(k)/rho_int
       ENDDO

       DO k=KTS,KTE-1
          det_thl(k)=Cdet*(envm_thl(k)-thl(k))*envi_a(k)*Psig_w
          det_sqv(k)=Cdet*(envm_sqv(k)-qv(k))*envi_a(k)*Psig_w
          det_sqc(k)=Cdet*(envm_sqc(k)-qc(k))*envi_a(k)*Psig_w
       ENDDO

       IF (momentum_opt > 0) THEN
         rho_int     = (rho(kts)*dz(kts+1)+rho(kts+1)*dz(kts))/(dz(kts+1)+dz(kts))
         sub_u(kts)=0.5*envi_w(kts)*envi_a(kts)*                               &
                    (rho(kts+1)*u(kts+1)-rho(kts)*u(kts))/dzi(kts)/rho_int
         sub_v(kts)=0.5*envi_w(kts)*envi_a(kts)*                               &
                    (rho(kts+1)*v(kts+1)-rho(kts)*v(kts))/dzi(kts)/rho_int
         DO k=kts+1,kte-1
            rho_int   = (rho(k)*dz(k+1)+rho(k+1)*dz(k))/(dz(k+1)+dz(k))
            sub_u(k)=0.5*(envi_w(k)+envi_w(k-1))*0.5*(envi_a(k)+envi_a(k-1)) * &
                      (rho(k+1)*u(k+1)-rho(k)*u(k))/dzi(k)/rho_int
            sub_v(k)=0.5*(envi_w(k)+envi_w(k-1))*0.5*(envi_a(k)+envi_a(k-1)) * &
                      (rho(k+1)*v(k+1)-rho(k)*v(k))/dzi(k)/rho_int
         ENDDO

         DO k=KTS,KTE-1
           det_u(k) = Cdet*(envm_u(k)-u(k))*envi_a(k)*Psig_w
           det_v(k) = Cdet*(envm_v(k)-v(k))*envi_a(k)*Psig_w
         ENDDO
       ENDIF
    ENDIF 

    
    
    
    DO K=KTS,KTE-1
       exneri(k) = (exner(k)*DZ(k+1)+exner(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
       edmf_th(k)= edmf_thl(k) + xlvcp/exneri(k)*edmf_qc(K)
       dzi(k)    = 0.5*(DZ(k)+DZ(k+1))
    ENDDO




    DO K=KTS+1,KTE-2
       IF(k > KTOP) exit
         IF(0.5*(edmf_qc(k)+edmf_qc(k-1))>0.0)THEN
            
            Aup = (edmf_a(k)*dzi(k-1)+edmf_a(k-1)*dzi(k))/(dzi(k-1)+dzi(k))
            THp = (edmf_th(k)*dzi(k-1)+edmf_th(k-1)*dzi(k))/(dzi(k-1)+dzi(k))
            QTp = (edmf_qt(k)*dzi(k-1)+edmf_qt(k-1)*dzi(k))/(dzi(k-1)+dzi(k))
            

            
            esat = esat_blend(tk(k))
            
            qsl=ep_2*esat/max(1.e-7,(p(k)-ep_3*esat)) 

            
            IF (edmf_qc(k)>0.0 .AND. edmf_qc(k-1)>0.0)THEN
              QCp = (edmf_qc(k)*dzi(k-1)+edmf_qc(k-1)*dzi(k))/(dzi(k-1)+dzi(k))
            ELSE
              QCp = MAX(edmf_qc(k),edmf_qc(k-1))
            ENDIF

            
            xl = xl_blend(tk(k))                
            qsat_tk = qsat_blend(tk(k),p(k))    
                                                
            rsl = xl*qsat_tk / (r_v*tk(k)**2)   
                                                
            cpm = cp + qt(k)*cpv                
            a   = 1./(1. + xl*rsl/cpm)          
            b9  = a*rsl                         

            q2p  = xlvcp/exner(k)
            pt = thl(k) +q2p*QCp*Aup 
            bb = b9*tk(k)/pt 
                           
                           
                           
                           
                           
            qww   = 1.+0.61*qt(k)
            alpha = 0.61*pt
            beta  = pt*xl/(tk(k)*cp) - 1.61*pt
            

            
            if (a > 0.0) then
               f = MIN(1.0/a, 4.0)              
            else
               f = 1.0
            endif

            
            
            
            
            
            sigq = 10. * Aup * (QTp - qt(k)) 
            
            sigq = max(sigq, qsat_tk*0.02 )
            sigq = min(sigq, qsat_tk*0.25 )

            qmq = a * (qt(k) - qsat_tk)           
            Q1  = qmq/sigq                        

            if ((landsea-1.5).GE.0) then      
               
               
               
               mf_cf = min(max(0.5 + 0.36 * atan(1.55*Q1),0.01),0.6)
               mf_cf = max(mf_cf, 1.2 * Aup)
               mf_cf = min(mf_cf, 5.0 * Aup)
            else                              
               
               
               
               mf_cf = min(max(0.5 + 0.36 * atan(1.55*Q1),0.01),0.6)
               mf_cf = max(mf_cf, 1.75 * Aup)
               mf_cf = min(mf_cf, 5.0  * Aup)
            endif

            
            
            
            
            
            

            
            
            
            
            
            
            

            
            
            

            if ((landsea-1.5).GE.0) then     

               if (cldfra_bl1d(k) < cf_thresh) then
                  if (QCp * Aup > 5e-5) then
                     qc_bl1d(k) = 1.86 * (QCp * Aup) - 2.2e-5
                  else
                     qc_bl1d(k) = 1.18 * (QCp * Aup)
                  endif
                  if (mf_cf .ge. Aup) then
                    qc_bl1d(k) = qc_bl1d(k) / mf_cf
                  endif
                  cldfra_bl1d(k) = mf_cf
                  Ac_mf          = mf_cf
               endif
            else                             
               if (QCp * Aup > 5e-5) then
                  qc_bl1d(k) = 1.86 * (QCp * Aup) - 2.2e-5
               else
                  qc_bl1d(k) = 1.18 * (QCp * Aup)
               endif
               if (mf_cf .ge. Aup) then
                  qc_bl1d(k) = qc_bl1d(k) / mf_cf
               endif
               cldfra_bl1d(k) = mf_cf
               Ac_mf          = mf_cf
            endif

            
            
            
            
            
            if (cldfra_bl1d(k) < cf_thresh) then
               
                  Q1=max(Q1,-2.25)
               
               
               

               if (Q1 .ge. 1.0) then
                  Fng = 1.0
               elseif (Q1 .ge. -1.7 .and. Q1 .lt. 1.0) then
                  Fng = EXP(-0.4*(Q1-1.0))
               elseif (Q1 .ge. -2.5 .and. Q1 .lt. -1.7) then
                  Fng = 3.0 + EXP(-3.8*(Q1+1.7))
               else
                  Fng = min(23.9 + EXP(-1.6*(Q1+2.5)), 60.)
               endif

               
               vt(k) = qww   - (1.5*Aup)*beta*bb*Fng - 1.
               vq(k) = alpha + (1.5*Aup)*beta*a*Fng  - tv0
            endif
         endif
      enddo 

    ENDIF  

    
    IF (ktop > 0) THEN
      maxqc = maxval(edmf_qc(1:ktop)) 
      IF ( maxqc < 1.E-8) maxmf = -1.0*maxmf
    ENDIF




IF (edmf_w(1) > 4.0) THEN 

    print *,'flq:',flq,' fltv:',fltv2
    print *,'pblh:',pblh,' wstar:',wstar
    print *,'sigmaW=',sigmaW,' sigmaTH=',sigmaTH,' sigmaQT=',sigmaQT







 

















 

   print *,' edmf_a',edmf_a(1:14)
   print *,' edmf_w',edmf_w(1:14)
   print *,' edmf_qt:',edmf_qt(1:14)
   print *,' edmf_thl:',edmf_thl(1:14)
 
ENDIF 



END SUBROUTINE DMP_MF



subroutine condensation_edmf(QT,THL,P,zagl,THV,QC)



real,intent(in)   :: QT,THL,P,zagl
real,intent(out)  :: THV
real,intent(inout):: QC

integer :: niter,i
real :: diff,exn,t,th,qs,qcold









  niter=50

  diff=1.e-6

  EXN=(P/p1000mb)**rcp
  
  do i=1,NITER
     T=EXN*THL + xlvcp*QC
     QS=qsat_blend(T,P)
     QCOLD=QC
     QC=0.5*QC + 0.5*MAX((QT-QS),0.)
     if (abs(QC-QCOLD)<Diff) exit
  enddo

  T=EXN*THL + xlvcp*QC
  QS=qsat_blend(T,P)
  QC=max(QT-QS,0.)

  
  if(zagl < 100.)QC=0.

  
  THV=(THL+xlvcp*QC)*(1.+QT*(rvovrd-1.)-rvovrd*QC)







  
  
  


  


end subroutine condensation_edmf



subroutine condensation_edmf_r(QT,THL,P,zagl,THV,QC)




real,intent(in)   :: QT,THV,P,zagl
real,intent(out)  :: THL, QC

integer :: niter,i
real :: diff,exn,t,th,qs,qcold


  niter=50

  diff=2.e-5

  EXN=(P/p1000mb)**rcp
  
  T = THV*EXN
  
  

  QC=0.

  do i=1,NITER
     QCOLD = QC
     T = EXN*THV/(1.+QT*(rvovrd-1.)-rvovrd*QC)
     QS=qsat_blend(T,P)
     QC= MAX((QT-QS),0.)
     if (abs(QC-QCOLD)<Diff) exit
  enddo
  THL = (T - xlv/cp*QC)/EXN

end subroutine condensation_edmf_r








SUBROUTINE DDMF_JPL(kts,kte,dt,zw,dz,p,              &
              &u,v,th,thl,thv,tk,qt,qv,qc,           &
              &rho,exner,                            &
              &ust,wthl,wqt,pblh,kpbl,               &
              &edmf_a_dd,edmf_w_dd, edmf_qt_dd,      &
              &edmf_thl_dd,edmf_ent_dd,edmf_qc_dd,   &
              &sd_aw,sd_awthl,sd_awqt,               &
              &sd_awqv,sd_awqc,sd_awu,sd_awv,        &
              &sd_awqke,                             &
              &qc_bl1d,cldfra_bl1d,                  &
              &rthraten                              )

        INTEGER, INTENT(IN) :: KTS,KTE,KPBL
        REAL,DIMENSION(KTS:KTE), INTENT(IN) :: U,V,TH,THL,TK,QT,QV,QC,&
            THV,P,rho,exner,rthraten,dz
        
        REAL,DIMENSION(KTS:KTE+1), INTENT(IN) :: ZW
        REAL, INTENT(IN) :: DT,UST,WTHL,WQT,PBLH

  
        REAL,DIMENSION(KTS:KTE), INTENT(OUT) :: edmf_a_dd,edmf_w_dd,   &
                      & edmf_qt_dd,edmf_thl_dd, edmf_ent_dd,edmf_qc_dd

  
        REAL,DIMENSION(KTS:KTE+1) :: sd_aw, sd_awthl, sd_awqt, sd_awu, &
                            sd_awv, sd_awqc, sd_awqv, sd_awqke, sd_aw2

        REAL,DIMENSION(KTS:KTE), INTENT(IN) :: qc_bl1d, cldfra_bl1d

        INTEGER, PARAMETER :: NDOWN=5, debug_mf=0 
  
        INTEGER, DIMENSION(1:NDOWN) :: DD_initK
        REAL   , DIMENSION(1:NDOWN) :: randNum
  
        REAL,DIMENSION(KTS:KTE+1,1:NDOWN) :: DOWNW,DOWNTHL,DOWNQT,&
                    DOWNQC,DOWNA,DOWNU,DOWNV,DOWNTHV

  
        REAl,DIMENSION(KTS+1:KTE+1,1:NDOWN) :: ENT,ENTf
        INTEGER,DIMENSION(KTS+1:KTE+1,1:NDOWN) :: ENTi

  
        INTEGER :: K,I,ki, kminrad, qlTop, p700_ind, qlBase
        REAL :: wthv,wstar,qstar,thstar,sigmaW,sigmaQT,sigmaTH,z0, &
            pwmin,pwmax,wmin,wmax,wlv,wtv,went,mindownw
        REAL :: B,QTn,THLn,THVn,QCn,Un,Vn,QKEn,Wn2,Wn,THVk,Pk, &
                EntEXP,EntW, Beta_dm, EntExp_M, rho_int
        REAL :: jump_thetav, jump_qt, jump_thetal, &
                refTHL, refTHV, refQT
  
        REAL :: minrad,zminrad, radflux, F0, wst_rad, wst_dd
        logical :: cloudflg

        REAL :: sigq,xl,rsl,cpm,a,mf_cf,diffqt,&
               Fng,qww,alpha,beta,bb,f,pt,t,q2p,b9,satvp,rhgrid

  
        REAL,PARAMETER :: &
            &Wa=1., &
            &Wb=1.5,&
            &Z00=100.,&
            &BCOEFF=0.2
  
        REAL,PARAMETER :: &
        & L0=80,&
        & ENT0=0.2

   pwmin=-3. 
   pwmax=-1.

  
   DOWNW=0.
   DOWNTHL=0.
   DOWNTHV=0.
   DOWNQT=0.
   DOWNA=0.
   DOWNU=0.
   DOWNV=0.
   DOWNQC=0.
   ENT=0.
   DD_initK=0

   edmf_a_dd  =0.
   edmf_w_dd  =0.
   edmf_qt_dd =0.
   edmf_thl_dd=0.
   edmf_ent_dd=0.
   edmf_qc_dd =0.

   sd_aw=0.
   sd_awthl=0.
   sd_awqt=0.
   sd_awqv=0.
   sd_awqc=0.
   sd_awu=0.
   sd_awv=0.
   sd_awqke=0.

  
   cloudflg=.false.
   minrad=100.
   kminrad=kpbl
   zminrad=PBLH
   qlTop = 1 
   qlBase = 1
   wthv=wthl+svp1*wqt
   do k = MAX(3,kpbl-2),kpbl+3
      if (qc(k).gt. 1.e-6 .AND. cldfra_bl1D(k).gt.0.5) then
          cloudflg=.true. 
          qlTop = k       
      endif
   enddo

   do k = qlTop, kts, -1
      if (qc(k) .gt. 1E-6) then
         qlBase = k 
      endif
   enddo
   qlBase = (qlTop+qlBase)/2 



   do i=1,NDOWN
      
      
      DD_initK(i) = qlTop 
   enddo

   
   F0 = 0.
   do k = 1, qlTop 
      radflux = rthraten(k) * exner(k) 
      radflux = radflux * cp / grav * ( p(k) - p(k+1) ) 
      if ( radflux < 0.0 ) F0 = abs(radflux) + F0
   enddo
   F0 = max(F0, 1.0)
   
   if (cloudflg) then












      
      do i=1,NDOWN
         do k=kts+1,kte

            ENT(k,i) = 0.002
            ENT(k,i) = min(ENT(k,i),0.9/(ZW(k+1)-ZW(k)))
         enddo
      enddo

      
      p700_ind = MINLOC(ABS(p-70000),1)
      jump_thetav = thv(p700_ind) - thv(1) - (thv(p700_ind)-thv(qlTop+3))/(ZW(p700_ind)-ZW(qlTop+3))*(ZW(p700_ind)-ZW(qlTop))
      jump_qt = qc(p700_ind) + qv(p700_ind) - qc(1) - qv(1)
      jump_thetal = thl(p700_ind) - thl(1) - (thl(p700_ind)-thl(qlTop+3))/(ZW(p700_ind)-ZW(qlTop+3))*(ZW(p700_ind)-ZW(qlTop))

      refTHL = thl(qlTop) 
      refTHV = thv(qlTop) 
      refQT  = qt(qlTop)  

      
      wst_rad = ( grav * zw(qlTop) * F0 / (refTHL * rho(qlTop) * cp) ) ** (0.333)
      wst_rad = max(wst_rad, 0.1)
      wstar   = max(0.,(grav/thv(1)*wthv*pblh)**(onethird))
      went    = thv(1) / ( grav * jump_thetav * zw(qlTop) ) * &
                (0.15 * (wstar**3 + 5*ust**3) + 0.35 * wst_rad**3 )
      qstar  = abs(went*jump_qt/wst_rad)
      thstar = F0/rho(qlTop)/cp/wst_rad - went*jump_thetav/wst_rad
      
      wst_dd = (0.15 * (wstar**3 + 5*ust**3) + 0.35 * wst_rad**3 ) ** (0.333)

      print*,"qstar=",qstar," thstar=",thstar," wst_dd=",wst_dd
      print*,"F0=",F0," wst_rad=",wst_rad," jump_thv=",jump_thetav
      print*,"entrainment velocity=",went

      sigmaW  = 0.2*wst_dd  
      sigmaQT = 40  * qstar 
      sigmaTH = 1.0 * thstar

      wmin=sigmaW*pwmin
      wmax=sigmaW*pwmax
      

      do I=1,NDOWN 
         ki = DD_initK(I)

         wlv=wmin+(wmax-wmin)/REAL(NDOWN)*(i-1)
         wtv=wmin+(wmax-wmin)/REAL(NDOWN)*i

         
         DOWNW(ki,I)=wlv
         
         DOWNA(ki,I)=.1/REAL(NDOWN)
         DOWNU(ki,I)=(u(ki-1)*DZ(ki) + u(ki)*DZ(ki-1)) /(DZ(ki)+DZ(ki-1))
         DOWNV(ki,I)=(v(ki-1)*DZ(ki) + v(ki)*DZ(ki-1)) /(DZ(ki)+DZ(ki-1))

         




         refTHL = (thl(ki-1)*DZ(ki) + thl(ki)*DZ(ki-1)) /(DZ(ki)+DZ(ki-1))
         refTHV = (thv(ki-1)*DZ(ki) + thv(ki)*DZ(ki-1)) /(DZ(ki)+DZ(ki-1))
         refQT  = (qt(ki-1)*DZ(ki)  + qt(ki)*DZ(ki-1))  /(DZ(ki)+DZ(ki-1))

         
         DOWNQC(ki,I) = (qc(ki-1)*DZ(ki) + qc(ki)*DZ(ki-1)) /(DZ(ki)+DZ(ki-1))
         DOWNQT(ki,I) = refQT  
         DOWNTHV(ki,I)= refTHV + 0.01 *DOWNW(ki,I)*sigmaTH/sigmaW
         DOWNTHL(ki,I)= refTHL + 0.01 *DOWNW(ki,I)*sigmaTH/sigmaW

         





      enddo


      
      DO I=1,NDOWN
         
         DO k=DD_initK(I)-1,KTS+1,-1
            
            
            
            EntExp  =ENT(K,I)*dz(k)
            EntExp_M=ENT(K,I)*0.333*dz(k)

            QTn =DOWNQT(k+1,I) *(1.-EntExp) + QT(k)*EntExp
            THLn=DOWNTHL(k+1,I)*(1.-EntExp) + THL(k)*EntExp
            Un  =DOWNU(k+1,I)  *(1.-EntExp) + U(k)*EntExp_M
            Vn  =DOWNV(k+1,I)  *(1.-EntExp) + V(k)*EntExp_M
            






            
            Pk  =(P(k-1)*DZ(k)+P(k)*DZ(k-1))/(DZ(k)+DZ(k-1))
            call condensation_edmf(QTn,THLn,Pk,ZW(k),THVn,QCn)

            THVk  =(THV(k-1)*DZ(k)+THV(k)*DZ(k-1))/(DZ(k)+DZ(k-1))
            B=grav*(THVn/THVk - 1.0)



            EntW=EntExp






            mindownw = MIN(DOWNW(K+1,I),-0.2)
            Wn = DOWNW(K+1,I) + (-2.*ENT(K,I)*DOWNW(K+1,I) - &
                    BCOEFF*B/mindownw)*MIN(dz(k), 250.)

            
            
            IF (Wn < DOWNW(K+1,I) - MIN(1.25*dz(k)/200., 2.0))THEN
                Wn = DOWNW(K+1,I) - MIN(1.25*dz(k)/200., 2.0)
            ENDIF
            
            IF (Wn > DOWNW(K+1,I) + MIN(1.25*dz(k)/200., 2.0))THEN
                Wn = DOWNW(K+1,I) + MIN(1.25*dz(k)/200., 2.0)
            ENDIF
            Wn = MAX(MIN(Wn,0.0), -3.0)

            
            
            
            
            
            

            IF (Wn .lt. 0.) THEN 
               DOWNW(K,I)  = Wn 
               DOWNTHV(K,I)= THVn
               DOWNTHL(K,I)= THLn
               DOWNQT(K,I) = QTn
               DOWNQC(K,I) = QCn
               DOWNU(K,I)  = Un
               DOWNV(K,I)  = Vn
               DOWNA(K,I)  = DOWNA(K+1,I)
            ELSE
               
               if (DD_initK(I) - K .lt. 2) then
                  DOWNW(:,I)  = 0.0
                  DOWNTHV(:,I)= 0.0
                  DOWNTHL(:,I)= 0.0
                  DOWNQT(:,I) = 0.0
                  DOWNQC(:,I) = 0.0
                  DOWNU(:,I)  = 0.0
                  DOWNV(:,I)  = 0.0
               endif
               exit
            ENDIF
         ENDDO
      ENDDO
   endif 

   DOWNW(1,:) = 0. 
   DOWNA(1,:) = 0.

   
   
   DO k=qlTop,KTS,-1
      DO I=1,NDOWN
         IF (I > NDOWN) exit
         edmf_a_dd(K)  =edmf_a_dd(K)  +DOWNA(K-1,I)
         edmf_w_dd(K)  =edmf_w_dd(K)  +DOWNA(K-1,I)*DOWNW(K-1,I)
         edmf_qt_dd(K) =edmf_qt_dd(K) +DOWNA(K-1,I)*DOWNQT(K-1,I)
         edmf_thl_dd(K)=edmf_thl_dd(K)+DOWNA(K-1,I)*DOWNTHL(K-1,I)
         edmf_ent_dd(K)=edmf_ent_dd(K)+DOWNA(K-1,I)*ENT(K-1,I)
         edmf_qc_dd(K) =edmf_qc_dd(K) +DOWNA(K-1,I)*DOWNQC(K-1,I)
      ENDDO

      IF (edmf_a_dd(k) >0.) THEN
          edmf_w_dd(k)  =edmf_w_dd(k)  /edmf_a_dd(k)
          edmf_qt_dd(k) =edmf_qt_dd(k) /edmf_a_dd(k)
          edmf_thl_dd(k)=edmf_thl_dd(k)/edmf_a_dd(k)
          edmf_ent_dd(k)=edmf_ent_dd(k)/edmf_a_dd(k)
          edmf_qc_dd(k) =edmf_qc_dd(k) /edmf_a_dd(k)
      ENDIF
   ENDDO

   
   
   

   DO k=KTS,qlTop
      rho_int = (rho(k)*DZ(k+1)+rho(k+1)*DZ(k))/(DZ(k+1)+DZ(k))
      DO I=1,NDOWN
         sd_aw(k)   =sd_aw(k)   +rho_int*DOWNA(k,i)*DOWNW(k,i)
         sd_awthl(k)=sd_awthl(k)+rho_int*DOWNA(k,i)*DOWNW(k,i)*DOWNTHL(k,i)
         sd_awqt(k) =sd_awqt(k) +rho_int*DOWNA(k,i)*DOWNW(k,i)*DOWNQT(k,i)
         sd_awqc(k) =sd_awqc(k) +rho_int*DOWNA(k,i)*DOWNW(k,i)*DOWNQC(k,i)
         sd_awu(k)  =sd_awu(k)  +rho_int*DOWNA(k,i)*DOWNW(k,i)*DOWNU(k,i)
         sd_awv(k)  =sd_awv(k)  +rho_int*DOWNA(k,i)*DOWNW(k,i)*DOWNV(k,i)
      ENDDO
      sd_awqv(k) = sd_awqt(k)  - sd_awqc(k)
   ENDDO

END SUBROUTINE DDMF_JPL



SUBROUTINE SCALE_AWARE(dx,PBL1,Psig_bl,Psig_shcu)

    
    
    
    
    
    
    
    

    REAL,INTENT(IN) :: dx,PBL1
    REAL, INTENT(OUT) :: Psig_bl,Psig_shcu
    REAL :: dxdh

    Psig_bl=1.0
    Psig_shcu=1.0
    dxdh=MAX(2.5*dx,10.)/MIN(PBL1,3000.)
    
    
    
    
    
     
    
     Psig_bl= ((dxdh**2) + 0.106*(dxdh**0.667))/((dxdh**2) +0.066*(dxdh**0.667) + 0.071)

    
    dxdh=MAX(2.5*dx,10.)/MIN(PBL1+500.,3500.)
    
    
    

    
    
    


    
    

    
    


    
    

    
    


    
    
    
    Psig_shcu= ((dxdh**2) + 0.145*(dxdh**0.667))/((dxdh**2) +0.172*(dxdh**0.667) + 0.170)


    

    
    

    
    
    If(Psig_bl > 1.0) Psig_bl=1.0
    If(Psig_bl < 0.0) Psig_bl=0.0

    If(Psig_shcu > 1.0) Psig_shcu=1.0
    If(Psig_shcu < 0.0) Psig_shcu=0.0

  END SUBROUTINE SCALE_AWARE









  FUNCTION esat_blend(t) 

      IMPLICIT NONE
      
      REAL, INTENT(IN):: t
      REAL :: esat_blend,XC,ESL,ESI,chi

      XC=MAX(-80.,t - t0c) 




      IF (t .GE. t0c) THEN
          esat_blend = J0+XC*(J1+XC*(J2+XC*(J3+XC*(J4+XC*(J5+XC*(J6+XC*(J7+XC*J8))))))) 
      ELSE IF (t .LE. tice) THEN
          esat_blend = K0+XC*(K1+XC*(K2+XC*(K3+XC*(K4+XC*(K5+XC*(K6+XC*(K7+XC*K8)))))))
      ELSE
          ESL  = J0+XC*(J1+XC*(J2+XC*(J3+XC*(J4+XC*(J5+XC*(J6+XC*(J7+XC*J8)))))))
          ESI  = K0+XC*(K1+XC*(K2+XC*(K3+XC*(K4+XC*(K5+XC*(K6+XC*(K7+XC*K8)))))))
          chi  = (t0c - t)/(t0c - tice)
          esat_blend = (1.-chi)*ESL  + chi*ESI
      END IF

  END FUNCTION esat_blend







  FUNCTION qsat_blend(t, P, waterice)

      IMPLICIT NONE

      REAL, INTENT(IN):: t, P
      CHARACTER(LEN=1), OPTIONAL, INTENT(IN) :: waterice
      CHARACTER(LEN=1) :: wrt
      REAL :: qsat_blend,XC,ESL,ESI,RSLF,RSIF,chi

      IF ( .NOT. PRESENT(waterice) ) THEN 
          wrt = 'b'
      ELSE
          wrt = waterice
      ENDIF

      XC=MAX(-80.,t - t0c)

      IF ((t .GE. t0c) .OR. (wrt .EQ. 'w')) THEN
          ESL  = J0+XC*(J1+XC*(J2+XC*(J3+XC*(J4+XC*(J5+XC*(J6+XC*(J7+XC*J8))))))) 
          qsat_blend = 0.622*ESL/max(P-ESL, 1e-5) 

      ELSE IF (t .LE. tice) THEN
          ESI  = K0+XC*(K1+XC*(K2+XC*(K3+XC*(K4+XC*(K5+XC*(K6+XC*(K7+XC*K8)))))))
          qsat_blend = 0.622*ESI/max(P-ESI, 1e-5)
      ELSE
          ESL  = J0+XC*(J1+XC*(J2+XC*(J3+XC*(J4+XC*(J5+XC*(J6+XC*(J7+XC*J8)))))))
          ESI  = K0+XC*(K1+XC*(K2+XC*(K3+XC*(K4+XC*(K5+XC*(K6+XC*(K7+XC*K8)))))))
          RSLF = 0.622*ESL/max(P-ESL, 1e-5)
          RSIF = 0.622*ESI/max(P-ESI, 1e-5)

          chi  = (t0c - t)/(t0c - tice) 
         qsat_blend = (1.-chi)*RSLF + chi*RSIF
      END IF

  END FUNCTION qsat_blend








  FUNCTION xl_blend(t)

      IMPLICIT NONE

      REAL, INTENT(IN):: t
      REAL :: xl_blend,xlvt,xlst,chi
      

      IF (t .GE. t0c) THEN
          xl_blend = xlv + (cpv-cliq)*(t-t0c)  
      ELSE IF (t .LE. tice) THEN
          xl_blend = xls + (cpv-cice)*(t-t0c)  
      ELSE
          xlvt = xlv + (cpv-cliq)*(t-t0c)  
          xlst = xls + (cpv-cice)*(t-t0c)  

          chi  = (t0c - t)/(t0c - tice)
          xl_blend = (1.-chi)*xlvt + chi*xlst     
      END IF

  END FUNCTION xl_blend



  FUNCTION phim(zet)
     
     
     
     
     
     
      IMPLICIT NONE

      REAL, INTENT(IN):: zet
      REAL :: dummy_0,dummy_1,dummy_11,dummy_2,dummy_22,dummy_3,dummy_33,dummy_4,dummy_44,dummy_psi
      REAL, PARAMETER :: am_st=6.1, bm_st=2.5, rbm_st=1./bm_st
      REAL, PARAMETER :: ah_st=5.3, bh_st=1.1, rbh_st=1./bh_st
      REAL, PARAMETER :: am_unst=10., ah_unst=34.
      REAL :: phi_m,phim

      if ( zet >= 0.0 ) then
         dummy_0=1+zet**bm_st
         dummy_1=zet+dummy_0**(rbm_st)
         dummy_11=1+dummy_0**(rbm_st-1)*zet**(bm_st-1)
         dummy_2=(-am_st/dummy_1)*dummy_11
         phi_m = 1-zet*dummy_2
      else
         dummy_0 = (1.0-cphm_unst*zet)**0.25
         phi_m = 1./dummy_0
         dummy_psi = 2.*log(0.5*(1.+dummy_0))+log(0.5*(1.+dummy_0**2))-2.*atan(dummy_0)+1.570796

         dummy_0=(1.-am_unst*zet)          
         dummy_1=dummy_0**0.333333         
         dummy_11=-0.33333*am_unst*dummy_0**(-0.6666667) 
         dummy_2 = 0.33333*(dummy_1**2.+dummy_1+1.)      
         dummy_22 = 0.3333*dummy_11*(2.*dummy_1+1.)      
         dummy_3 = 0.57735*(2.*dummy_1+1.) 
         dummy_33 = 1.1547*dummy_11        
         dummy_4 = 1.5*log(dummy_2)-1.73205*atan(dummy_3)+1.813799364 
         dummy_44 = (1.5/dummy_2)*dummy_22-1.73205*dummy_33/(1.+dummy_3**2)

         dummy_0 = zet**2
         dummy_1 = 1./(1.+dummy_0) 
         dummy_11 = 2.*zet         
         dummy_2 = ((1-phi_m)/zet+dummy_11*dummy_4+dummy_0*dummy_44)*dummy_1
         dummy_22 = -dummy_11*(dummy_psi+dummy_0*dummy_4)*dummy_1**2

         phi_m = 1.-zet*(dummy_2+dummy_22)
      end if

      
      phim = phi_m

  END FUNCTION phim


  FUNCTION phih(zet)
    
    
    
    
    
    
      IMPLICIT NONE

      REAL, INTENT(IN):: zet
      REAL :: dummy_0,dummy_1,dummy_11,dummy_2,dummy_22,dummy_3,dummy_33,dummy_4,dummy_44,dummy_psi
      REAL, PARAMETER :: am_st=6.1, bm_st=2.5, rbm_st=1./bm_st
      REAL, PARAMETER :: ah_st=5.3, bh_st=1.1, rbh_st=1./bh_st
      REAL, PARAMETER :: am_unst=10., ah_unst=34.
      REAL :: phh,phih

      if ( zet >= 0.0 ) then
         dummy_0=1+zet**bh_st
         dummy_1=zet+dummy_0**(rbh_st)
         dummy_11=1+dummy_0**(rbh_st-1)*zet**(bh_st-1)
         dummy_2=(-ah_st/dummy_1)*dummy_11
         phih = 1-zet*dummy_2
      else
         dummy_0 = (1.0-cphh_unst*zet)**0.5
         phh = 1./dummy_0
         dummy_psi = 2.*log(0.5*(1.+dummy_0))

         dummy_0=(1.-ah_unst*zet)          
         dummy_1=dummy_0**0.333333         
         dummy_11=-0.33333*ah_unst*dummy_0**(-0.6666667) 
         dummy_2 = 0.33333*(dummy_1**2.+dummy_1+1.)      
         dummy_22 = 0.3333*dummy_11*(2.*dummy_1+1.)      
         dummy_3 = 0.57735*(2.*dummy_1+1.) 
         dummy_33 = 1.1547*dummy_11        
         dummy_4 = 1.5*log(dummy_2)-1.73205*atan(dummy_3)+1.813799364 
         dummy_44 = (1.5/dummy_2)*dummy_22-1.73205*dummy_33/(1.+dummy_3**2)

         dummy_0 = zet**2
         dummy_1 = 1./(1.+dummy_0)         
         dummy_11 = 2.*zet                 
         dummy_2 = ((1-phh)/zet+dummy_11*dummy_4+dummy_0*dummy_44)*dummy_1
         dummy_22 = -dummy_11*(dummy_psi+dummy_0*dummy_4)*dummy_1**2

         phih = 1.-zet*(dummy_2+dummy_22)
      end if

END FUNCTION phih

 SUBROUTINE topdown_cloudrad(kts,kte,dz1,zw,xland,kpbl,PBLH,  &
               &sqc,sqi,sqw,thl,th1,ex1,p1,rho1,thetav,       &
               &cldfra_bl1D,rthraten,                         &
               &maxKHtopdown,KHtopdown,TKEprodTD              )

    
    integer, intent(in) :: kte,kts
    real, dimension(kts:kte), intent(in) :: dz1,sqc,sqi,sqw,&
          thl,th1,ex1,p1,rho1,thetav,cldfra_bl1D,rthraten
    real, dimension(kts:kte+1), intent(in) :: zw
    real, intent(in) :: pblh,xland
    integer,intent(in) :: kpbl
    
    real, intent(out) :: maxKHtopdown
    real, dimension(kts:kte), intent(out) :: KHtopdown,TKEprodTD
    
    real, dimension(kts:kte) :: zfac,wscalek2,zfacent
    real :: bfx0,sflux,wm2,wm3,h1,h2,bfxpbl,dthvx,tmp1
    real :: temps,templ,zl1,wstar3_2
    real :: ent_eff,radsum,radflux,we,rcldb,rvls,minrad,zminrad
    real, parameter :: pfac =2.0, zfmin = 0.01, phifac=8.0
    integer :: k,kk,kminrad
    logical :: cloudflg

    cloudflg=.false.
    minrad=100.
    kminrad=kpbl
    zminrad=PBLH
    KHtopdown(kts:kte)=0.0
    TKEprodTD(kts:kte)=0.0
    maxKHtopdown=0.0

    
    DO kk = MAX(1,kpbl-2),kpbl+3
       if (sqc(kk).gt. 1.e-6 .OR. sqi(kk).gt. 1.e-6 .OR. &
           cldfra_bl1D(kk).gt.0.5) then
          cloudflg=.true.
       endif
       if (rthraten(kk) < minrad)then
          minrad=rthraten(kk)
          kminrad=kk
          zminrad=zw(kk) + 0.5*dz1(kk)
       endif
    ENDDO

    IF (MAX(kminrad,kpbl) < 2)cloudflg = .false.
    IF (cloudflg) THEN
       zl1 = dz1(kts)
       k = MAX(kpbl-1, kminrad-1)
       
       

       templ=thl(k)*ex1(k)
       
       rvls=100.*6.112*EXP(17.67*(templ-273.16)/(templ-29.65))*(ep_2/p1(k+1))
       temps=templ + (sqw(k)-rvls)/(cp/xlv  +  ep_2*xlv*rvls/(r_d*templ**2))
       rvls=100.*6.112*EXP(17.67*(temps-273.15)/(temps-29.65))*(ep_2/p1(k+1))
       rcldb=max(sqw(k)-rvls,0.)

       
       dthvx     = (thl(k+2) + th1(k+2)*p608*sqw(k+2)) &
                 - (thl(k)   + th1(k)  *p608*sqw(k))
       dthvx     = max(dthvx,0.1)
       tmp1      = xlvcp * rcldb/(ex1(k)*dthvx)
       
       
       ent_eff   = 0.2 + 0.2*8.*tmp1

       radsum=0.
       DO kk = MAX(1,kpbl-3),kpbl+3
          radflux=rthraten(kk)*ex1(kk)         
          radflux=radflux*cp/grav*(p1(kk)-p1(kk+1)) 
          if (radflux < 0.0 ) radsum=abs(radflux)+radsum
       ENDDO

       
       if ((xland-1.5).GE.0)THEN      
          radsum=MIN(radsum,90.0)
          bfx0 = max(radsum/rho1(k)/cp,0.)
       else                           
          radsum=MIN(0.25*radsum,30.0)
          bfx0 = max(radsum/rho1(k)/cp - max(sflux,0.0),0.)
       endif

       
       wm3    = grav/thetav(k)*bfx0*MIN(pblh,1500.) 
       wm2    = wm2 + wm3**h2
       bfxpbl = - ent_eff * bfx0
       dthvx  = max(thetav(k+1)-thetav(k),0.1)
       we     = max(bfxpbl/dthvx,-sqrt(wm3**h2))

       DO kk = kts,kpbl+3
          
          zfac(kk) = min(max((1.-(zw(kk+1)-zl1)/(zminrad-zl1)),zfmin),1.)
          zfacent(kk) = 10.*MAX((zminrad-zw(kk+1))/zminrad,0.0)*(1.-zfac(kk))**3

          
          wscalek2(kk) = (phifac*karman*wm3*(zfac(kk)))**h1
          
          KHtopdown(kk) = wscalek2(kk)*karman*(zminrad-zw(kk+1))*(1.-zfac(kk))**3 
          KHtopdown(kk) = MAX(KHtopdown(kk),0.0)


          
          
          TKEprodTD(kk)=2.*ent_eff*wm3/MAX(pblh,100.)*zfacent(kk)
          TKEprodTD(kk)= MAX(TKEprodTD(kk),0.0)
       ENDDO
    ENDIF 
    maxKHtopdown=MAXVAL(KHtopdown(:))

 END SUBROUTINE topdown_cloudrad




END MODULE module_bl_mynn
