#default:
#	mpif90 -o main.out main.f90 -I$(OPENCMISS_SDK_DIR) -L$(OPENCMISS_SDK_DIR) -lparmetis -lmetis

default:
	mpif90 -o main.out main.f90 $(OPENCMISS_SDK_DIR)/x86_64_linux/gnu-5.4-F5.4/mpich_release/release/lib/libparmetis-4.0.3.a $(OPENCMISS_SDK_DIR)/x86_64_linux/gnu-5.4-F5.4/mpich_release/release/lib/libmetis-5.1.a $(OPENCMISS_SDK_DIR)/x86_64_linux/gnu-5.4-F5.4/mpich_release/release/lib/libgklib.a -Wl,-rpath=$(OPENCMISS_SDK_DIR)/x86_64_linux/gnu-5.4-F5.4/mpich_release/release/lib

clean:
	rm -f *.o *.mod *.out
