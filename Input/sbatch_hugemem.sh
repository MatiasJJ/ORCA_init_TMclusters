#!/bin/bash -l

#SBATCH -p @jono			# parallel tai test
#SBATCH -n @core				# coret
#SBATCH -N @node				# nodet
#SBATCH -t @time			# time as hh:mm:ss
#SBATCH -J @jobname			# työn nimi sbatchissa
#SBATCH -e jobfile.err
#SBATCH -o jobfile.out
#SBATCH --mem-per-cpu=@memcpu		# requested memory per process in MB
#SBATCH --mail-type=END			# meilaa lopussa
#SBATCH --mail-user=matias.j.jaaskelainen@helsinki.fi

SDIR=`pwd`
echo "Submission directory is: $SDIR"
echo "The job ID assigned by the Batch system is: $SLURM_JOBID"
echo "Number of requested processes $SLURM_NPROCS"
echo "Did you include %pal nprocs $SLURM_NPROCS end in your input?"

scontrol show jobs $SLURM_JOB_ID | grep " NodeList" | cut -c 13-

export ORCATMPDIR=/tmp/$USER/$SLURM_JOB_ID
mkdir -p $ORCATMPDIR

module load orca-env/4.0.1.2
$USERAPPL/orca_4_0_1_2_linux_x86-64_openmpi202/orca @jobname.inp > @jobname.out
