        !COMPILER-GENERATED INTERFACE MODULE: Tue Dec 22 18:51:28 2015
        MODULE GET_HLLEM_FLUX__genmod
          INTERFACE 
            SUBROUTINE GET_HLLEM_FLUX(RL,RR,UL,UR,PL,PR,MSF_L,MSF_R,G_)
              USE GLOBAL, ONLY :                                        &
     &          NS,                                                     &
     &          NS1,                                                    &
     &          NT
              REAL(KIND=8) :: RL
              REAL(KIND=8) :: RR
              REAL(KIND=8) :: UL
              REAL(KIND=8) :: UR
              REAL(KIND=8) :: PL
              REAL(KIND=8) :: PR
              REAL(KIND=8) :: MSF_L(NS)
              REAL(KIND=8) :: MSF_R(NS)
              REAL(KIND=8) :: G_(NT)
            END SUBROUTINE GET_HLLEM_FLUX
          END INTERFACE 
        END MODULE GET_HLLEM_FLUX__genmod
