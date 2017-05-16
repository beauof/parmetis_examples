! minimum working example to decompose a single domain with 2x2 quadrilateral elements
!
! author: Andreas Hessenthaler
!
! compile:  make
! run:      mpirun -np 2 ./main.out
!
program test

    use mpi
    use iso_c_binding
    implicit none

    integer, allocatable        :: elmdist(:), eptr(:), eind(:)
    integer                     :: elmwgt(1)
    integer                     :: weight_flag, num_flag, ncon, number_of_common_nodes, number_parts
    real, allocatable           :: tp_weights(:)
    real                        :: ub_vec
    integer, allocatable        :: options(:)
    integer                     :: partition(4)
    integer                     :: number_edges_cut, communicator, edgecut
    integer                     :: nprocs, procid, ierr

    ! variables are initialized as if we ran the classicalfield_laplace_simple example
    ! for OpenCMISS-iron with commandline arguments 2 2 0 1
    
    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, procid, ierr)

    write(*,*) c_int,huge(c_int)
    write(*,*) "nprocs = ",nprocs,"| procid = ",procid,"| MPI_COMM_WORLD = ",MPI_COMM_WORLD

    weight_flag                 = 0
    num_flag                    = 0
    ncon                        = 1
    number_of_common_nodes      = 2
    number_parts                = 2
    ub_vec                      = 1.05

    allocate(elmdist(0:2), eptr(0:2), eind(0:7), tp_weights(1:2), options(0:2))

    elmdist(0)      = 0
    elmdist(1)      = 2
    elmdist(2)      = 4

    eptr(0)         = 0
    eptr(1)         = 4
    eptr(2)         = 8

    eind(0)         = 0
    eind(1)         = 1
    eind(2)         = 3
    eind(3)         = 4
    eind(4)         = 1
    eind(5)         = 2
    eind(6)         = 4
    eind(7)         = 5

    elmwgt(1)       = 1

    tp_weights(1)   = 0.5
    tp_weights(2)   = 0.5

    options(0)      = 1
    options(1)      = 7
    options(2)      = 9999

    partition(1)    = 0
    partition(2)    = 0
    partition(3)    = 0
    partition(4)    = 0
    
    edgecut         = 0

    call ParMETIS_V3_PartMeshKway(elmdist, eptr, eind, elmwgt, weight_flag, num_flag, &
    & ncon, number_of_common_nodes, number_parts, tp_weights, ub_vec, options, edgecut, partition, MPI_COMM_WORLD)

    write(*,*) "procid = ",procid,"| edgecut = ",edgecut
    write(*,*) "procid = ",procid,"| partition = ",partition

    deallocate(elmdist, eptr, eind, tp_weights)
    
    call MPI_FINALIZE(ierr)

end program
