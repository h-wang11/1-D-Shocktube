      MODULE Chem
C     This module are used for CHEMIKIN and Transport initialization
C     Contains two subroutines:  chem_init ,  tran_init
      INTEGER :: LENI,LENR,LENC,IFLAG,LENIWK,LENRWK,LENCWK
      INTEGER :: MM,KK,II,NFIT,STATUS, LOUT
      LOGICAL :: KERR 
C     KERR   - Error flag; character length errors will result in KERR = .TRUE. | Data type - logical  
C             [ Used by Cklib.f\ CKSYMS ( CCKWRK, LOUT, KNAME, KERR ) ]
C             Returns the character strings of species names

C     STATUS,IFLAG = SUBROUTINEs Debug Info

C     For Cklib.f\ CKINDX ( ICKWRK, RCKWRK, MM, KK, II, NFIT )
C     Returns a group of indices defining the SIZE of the particular reaction mechanism 
C     Input:
C         ICKWRK - Array of integer workspace.                                                        | Data type - integer array
C                   Dimension ICKWRK(*) at least LENIWK.
C         RCKWRK - Array of real work space.                                                          | Data type - real array
C                   Dimension RCKWRK(*) at least LENRWK.
C     Output:
C         MM     - Total number of elements in mechanism.                                             | Data type - integer scalar
C         KK     - Total number of species in mechanism.                                              | Data type - integer scalar
C         II     - Total number of reactions in mechanism.                                            | Data type - integer scalar
C         NFIT   - number of coefficients in fits to thermodynamic data for one temperature range
C                  NFIT = number of coefficients in polynomial fits to CP/R  +  2.                    | Data type - integer scalar

C     For Cklib.f\ CKLEN ( LINC, LOUT, LENI, LENR, LENC, IFLAG )
C     Read File ¡¾ chem.bin ¡¿ 
C     Returns the lengths required for the work arrays
C     Input:
C         LINC  -  Logical file number for the binary file.               | Data type - integer scalar
C         LOUT  -  Output file for printed diagnostics.                   | Data type - integer scalar
C     Output:
C         LENI  -  Minimum length required for the integer work array.    | Data type - integer scalar
C         LENR  -  Minimum length required for the real work array.       | Data type - integer scalar
C         LENC  -  Minimum length required for the character work array.
C         IFLAG  - IFLAG=0 indicates successful reading of binary linking file; IFLAG>0 indicates error type. | Data type - integer

C     For Cklib.f\ CKINIT( LENIWK, LENRWK, LENCWK, LINC, LOUT, ICKWRK,RCKWRK, CCKWRK, IFLAG )
C     Reads the [Binary File] and creates the internal [WORK ARRAYs] ICKWRK, CCKWRK, and RCKWORK
C     CKINIT must be called before any other CHEMKIN subroutine is called
C     The work arrays must then be made available as [INPUT] to the other CHEMKIN subroutines.
C     Input:
C         LENIWK - Length of the integer work array, ICKWRK.      | Data type - integer scalar
C         LENCWK - Length of the character work array, CCKWRK.
C              The minimum length of CCKWRK(*) is MM + KK.        | Data type - integer scalar
C         LENRWK - Length of the real work array, RCKWORK.        | Data type - integer scalar
C         LINC  -  Logical file number for the binary file.       | Data type - integer scalar
C         LOUT  -  Output file for printed diagnostics.           | Data type - integer scalar
C     Output:
C         ICKWRK - Array of integer workspace.                    | Data type - integer array
C                   Dimension ICKWRK(*) at least LENIWK.
C         RCKWRK - Array of real work space.                      | Data type - real array
C                   Dimension RCKWRK(*) at least LENRWK.
C         CCKWRK - Array of character work space.                 | Data type - CHARACTER*16 array
C                   Dimension CCKWRK(*) at least LENCWK.


C     Array Definitions:
      CHARACTER*16,ALLOCATABLE    :: CWORK(:)
      REAL*8, ALLOCATABLE         :: RWORK(:)
      INTEGER,ALLOCATABLE         :: IWORK(:)
C     Output by Cklib.f\ CKINIT:
C                                 IWORK= ICKWRK || RWORK= RCKWRK || CWORK=CCKWRK, Workspaces from Chem.bin
C     Used after Cklib.f\ CKINDX:
C                                 SPNAME= Name of Species
C                                 ELNAME= Name of Elements    

      PARAMETER (LENIWK=4000,LENRWK=4000,LENCWK=4000)
C     Used by Cklib.f\ CKINIT
  
C     For Transport Initialization
C     Similar to Chemical Informations
      INTEGER                 :: LI, LR, LENIMC, LENRMC
C     Used by Tranlib.f\ MCLEN , read ¡¾ tran.bin ¡¿
 
      REAL*8, ALLOCATABLE     :: RMCWRK(:)      ! Transport Coefficients' workspece
      INTEGER, ALLOCATABLE    :: IMCWRK(:)
C     Output by Tranlib.f\ MCINIT , read ¡¾ tran.bin ¡¿

      PARAMETER (LENIMC=4000,LENRMC=4000)


C     *************************************************************************************

      CONTAINS
C     Internal Subroutines

C         Chemical Variables Initilization
          SUBROUTINE  CHEM_INIT    
C         INITIALIZE CHEMKIN	     
          USE Global
          IMPLICIT NONE
          INTEGER :: LINKCK   ! File Number of ¡¾chem.bin¡¿

          LINKCK =100
          OPEN (LINKCK, FORM='UNFORMATTED', STATUS='UNKNOWN',FILE='./0_CHEMIKIN/chem.bin') 
  
C         =============================INITIALIZE CHEMKIN=============================
          LOUT = 50			
C         CKLEN\CKINIT\CKINDX MUST BE CALLED
          CALL CKLEN  (LINKCK, LOUT, LENI, LENR, LENC,IFLAG)                              ! SIZE OF CK WORK SPACE
C         Extract Array Size Infomation from ¡¾chem.inp¡¿

          ALLOCATE( RWORK(LENR),IWORK(LENI),CWORK(LENC) )
          CALL CKINIT (LENIWK, LENRWK, LENCWK, LINKCK, LOUT, IWORK, RWORK, CWORK,IFLAG)   ! CK INITIALIZATION
C         Extract Chemical Infomation from ¡¾chem.inp¡¿

          CALL CKINDX (IWORK, RWORK, MM, KK, II, NFIT)
C         For Cklib.f\ CKINDX ( ICKWRK, RCKWRK, MM, KK, II, NFIT )
C         Returns a group of indices defining the SIZE of the particular reaction mechanism 

          !ALLOCATE( SPNAME(KK), Mlw(KK), Msf(KK), Mlf(KK) )
          !ALLOCATE( Gs(KK), H(KK), Cp(KK), Dfc(KK) )


          CLOSE (LINKCK)

          END SUBROUTINE CHEM_INIT
C     ************************************************************************************
C     ************************************************************************************

C         Transport Coefficients Initilization
          SUBROUTINE TRAN_INIT
          IMPLICIT NONE
          INTEGER :: LINKMC, LOUTMC

          LINKMC =150
          OPEN (LINKMC, FORM='UNFORMATTED', STATUS='UNKNOWN',FILE='./0_CHEMIKIN/tran.bin') 

C         =============================INITIALIZE Transport Coefficients=============================
          LOUTMC = 55
          CALL MCLEN (LINKMC, LOUTMC, LI, LR)
          ALLOCATE (IMCWRK(LI),RMCWRK(LR))
          CALL MCINIT (LINKMC, LOUTMC, LENIMC, LENRMC, IMCWRK, RMCWRK)

          CLOSE(LINKMC)  

          END SUBROUTINE TRAN_INIT

      END MODULE Chem