        !COMPILER-GENERATED INTERFACE MODULE: Thu Jan 15 19:33:42 2015
        MODULE EXTEND_PROJECTIONS_BY_AGE_mod
          INTERFACE 
            SUBROUTINE EXTEND_PROJECTIONS_BY_AGE(DM,DF,N)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: DM(1900:3500,0:180)
              REAL(KIND=8) :: DF(1900:3500,0:180)
            END SUBROUTINE EXTEND_PROJECTIONS_BY_AGE
          END INTERFACE 
        END MODULE EXTEND_PROJECTIONS_BY_AGE_mod
