



 module module_checkerror
 implicit none















































 private             
 public  checkerror  





  interface checkerror
    module procedure checkerror_single
    module procedure checkerror_double

  end interface

 contains




 subroutine checkerror_single(subroutine_name, param_id,i,k,j,input_real)
 use, intrinsic :: ieee_arithmetic
 implicit none
 character*(*),intent(in) :: subroutine_name
 character*(*),intent(in) :: param_id
 integer,intent(in) :: i,k,j  
 real(4),intent(in) :: input_real

 character(len=132) :: string

 select case(trim(param_id))
 case('temperature_K')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",92,&
'Terminate run.')
  endif

 case('temperature_degC')

  if(input_real < -274. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",105,&
'Terminate run.')
  endif

 case('pressure_Pa')

  if(input_real < 0. .or. input_real > 200000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",118,&
'Terminate run.')
  endif

 case('radiationflux_W/m2')

  if(input_real < -10000. .or. input_real > 10000. ) then  



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",131,&
'Terminate run.')
  endif

 case('condensate_g/m3')

  if(input_real < 0. .or. input_real > 10000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",144,&
'Terminate run.')
  endif

 case('condensate_kg/kg')

  if(input_real < 0. .or. input_real > 10000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",157,&
'Terminate run.') 
  endif

 case('aerosol_g/m3')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",170,&
'Terminate run.')
  endif

 case('aerosol_ug/kg')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",183,&
'Terminate run.')
  endif

 case('albedo')

  if(input_real < 0. .or. input_real > 1. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",196,&
'Terminate run.')
  endif

 case('emissivity')

  if(input_real < 0. .or. input_real > 1. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",209,&
'Terminate run.')
  endif


 case default


      write(string,*) 'MSG checkerror_float: There is no such param_id',trim(param_id)
      call wrf_message(string)
      call wrf_error_fatal3("<stdin>",219,&
'Terminate run.')
 end select


 if (abs(input_real) >= huge(input_real)) then
    write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' Infinity at grid(i,k,j) =',i,k,j
    call wrf_message(string)
    call wrf_error_fatal3("<stdin>",228,&
'Terminate run.')
 end if

 if (ieee_is_nan(input_real)) then
    write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' NaN at grid(i,k,j) =',i,k,j
    call wrf_message(string)
    call wrf_error_fatal3("<stdin>",236,&
'Terminate run.')
 end if

 end subroutine checkerror_single




 subroutine checkerror_double(subroutine_name, param_id,i,k,j,input_real)
 use, intrinsic :: ieee_arithmetic
 implicit none
 character*(*),intent(in) :: subroutine_name
 character*(*),intent(in) :: param_id
 integer,intent(in) :: i,k,j  
 real(8),intent(in) :: input_real

 character(len=132) :: string

 select case(trim(param_id))
 case('temperature_K')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",265,&
'Terminate run.')
  endif

 case('temperature_degC')

  if(input_real < -274. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",278,&
'Terminate run.')
  endif

 case('pressure_Pa')

  if(input_real < 0. .or. input_real > 200000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",291,&
'Terminate run.')
  endif

 case('radiationflux_W/m2')

  if(input_real < -10000. .or. input_real > 10000. ) then  



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",304,&
'Terminate run.')

  endif

 case('condensate_g/m3')

  if(input_real < 0. .or. input_real > 10000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",318,&
'Terminate run.')
  endif

 case('condensate_kg/kg')

  if(input_real < 0. .or. input_real > 10000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",331,&
'Terminate run.')
  endif

 case('aerosol_g/m3')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",344,&
'Terminate run.')
  endif

 case('aerosol_ug/kg')

  if(input_real < 0. .or. input_real > 1000. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",357,&
'Terminate run.')
  endif

 case('albedo')

  if(input_real < 0. .or. input_real > 1. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",370,&
'Terminate run.')
  endif

 case('emissivity')

  if(input_real < 0. .or. input_real > 1. ) then



       write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' out of range at grid(i,k,j) =',i,k,j
       call wrf_message(string)
       call wrf_error_fatal3("<stdin>",383,&
'Terminate run.')
  endif

 case default


      write(string,*) 'MSG checkerror_double: There is no such param_id',trim(param_id)
      call wrf_message(string)
       call wrf_error_fatal3("<stdin>",392,&
'Terminate run.')
 end select


 if (abs(input_real) >= huge(input_real)) then
    write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' Infinity at grid(i,k,j) =',i,k,j
    call wrf_message(string)
    call wrf_error_fatal3("<stdin>",401,&
'Terminate run.')
 end if

 if (ieee_is_nan(input_real)) then
    write(string,*) 'MSG '//trim(subroutine_name)//': '//trim(param_id)//' =',input_real,&
               ' NaN at grid(i,k,j) =',i,k,j
    call wrf_message(string)
    call wrf_error_fatal3("<stdin>",409,&
'Terminate run.')
 end if

 end subroutine checkerror_double




 end module module_checkerror



