        !COMPILER-GENERATED INTERFACE MODULE: Thu Jan 15 20:00:05 2015
        MODULE EXTEND_MORTALITY_PROJECTIONS1_mod
          INTERFACE 
            SUBROUTINE EXTEND_MORTALITY_PROJECTIONS1(DM,DF,ITBEG,ITEND,N&
     &,I_REG_TYPE)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: DM(1900:3500,0:180)
              REAL(KIND=8) :: DF(1900:3500,0:180)
              INTEGER(KIND=4) :: ITBEG
              INTEGER(KIND=4) :: ITEND
              INTEGER(KIND=4) :: I_REG_TYPE
            END SUBROUTINE EXTEND_MORTALITY_PROJECTIONS1
          END INTERFACE 
        END MODULE EXTEND_MORTALITY_PROJECTIONS1_mod
