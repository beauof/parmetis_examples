default:
	mpif90 -o main.out main.f90 -I$(OPENCMISS_SDK_DIR) -L$(OPENCMISS_SDK_DIR) -lparmetis -lmetis

clean:
	rm -f *.o *.mod *.out
