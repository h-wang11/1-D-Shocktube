        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:23 2015
        MODULE POLFIT__genmod
          INTERFACE 
            SUBROUTINE POLFIT(N,X,Y,W,MAXDEG,NDEG,EPS,R,IERR,A)
              INTEGER(KIND=4) :: N
              REAL(KIND=4) :: X(*)
              REAL(KIND=4) :: Y(*)
              REAL(KIND=4) :: W(*)
              INTEGER(KIND=4) :: MAXDEG
              INTEGER(KIND=4) :: NDEG
              REAL(KIND=4) :: EPS
              REAL(KIND=4) :: R(*)
              INTEGER(KIND=4) :: IERR
              REAL(KIND=4) :: A(*)
            END SUBROUTINE POLFIT
          END INTERFACE 
        END MODULE POLFIT__genmod
