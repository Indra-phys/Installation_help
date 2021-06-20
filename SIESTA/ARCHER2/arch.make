# Created by: Indrajit Maity
# This is for: ARCHER2
# email: i.maity@imperial.ac.uk
# -----------------------------

# Siesta architechture
SIESTA_ARCH=

# Options to build serial/mpi/hybrid with additional
# external libraries included
# Use these symbols to request particular features
# To turn on, set '=1'. Else not used.

# MPI build
WITH_MPI = 1 
WITH_NETCDF=
WITH_GRID_SP=
#
LIBS_CPLUS=-lstdc++ 

# By default ARCHER2 provides:
# BLAS, LAPACK, CBLAS, LAPACKE, BLACS, ScaLAPACK
# cray-libsci is the default module loaded
COMP_LIBS =   

# Define compiler names and flags
# ARCHER2 has ftn the fortran compiler.
FC_PARALLEL=ftn
FC_SERIAL=ftn
FPP = 

# The -O2 optimization is reasonable
# > -O2 can be really aggressive
# -fallow-argument-mismatch is to suppress errors into
# warnings; They are safe to ignore.
FFLAGS = -g -O2 -fPIC -ftree-vectorize -fallow-argument-mismatch
FFLAGS_DEBUG= -g -O1

# 
RANLIB=echo

# This variable should contain any libraries you wish to link
LIBS=$(SCALAPACK_LIBS) $(BLACS_LIBS) $(LAPACK_LIBS) $(BLAS_LIBS) $(NETCDF_LIBS)

# MPI or serial
ifdef WITH_MPI
 FC=$(FC_PARALLEL)
 MPI_INTERFACE=libmpi_f90.a
 MPI_INCLUDE=.      
 FPPFLAGS_MPI=-DMPI -DMPI_TIMING
 LIBS +=$(SCALAPACK_LIBS)
else
 FC=$(FC_SERIAL)
 LIBS += $(LAPACK_LIBS) $(COMP_LIBS)
endif


SYS=nag
FPPFLAGS += $(FPPFLAGS_MPI)

# Rules
#---------------------------------------------
.F.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS)  $(FPPFLAGS) $<
.f.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS)   $<
.F90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS)  $(FPPFLAGS) $<
.f90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS)   $<
