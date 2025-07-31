# Cyclodextrin-PFAS Simulations


This repository contains molecular dynamics (MD) simulation setups, scripts, and analysis tools to study the interactions between **α/β/γ‑cyclodextrins (ACD/BCD/GCD)** and various **PFAS or interferent molecules** (PFOS, SDS, TCAA).   The workflow is designed for **GROMACS + PLUMED** simulations with **free‑energy calculations** to assess binding and selectivity. <br />

## qMD4
This folder contains the .gro and .itp files for setting up cyclodextrins for simulation.   <br />

## interferents_gaff
This folder contains the .gro and .itp files for setting up interferents for simulation <br />

## system_cd 

This folder contains all relevant files for simulation of PFAS - Cyclodextrin systems. The folder is subdivided into subfolders containing the required scripts to assemble the simulations, equilibrate the systems and perform the molecular dynamics calculations.  <br />

## analysis

This folder contains the jupyter notebook and corresponding .py files for computing delta Gs and Kbs for any given system for your choice of grid and cutoff.


## 📂 Repository Structure
Cyclodextrin-PFAS_Simulations/
│
├── LICENSE              # MIT or chosen license
├── README.md            # Project documentation
│
├── analysis/            # Analysis scripts and notebooks
│   ├── KbdG_samplecalculations.ipynb  # Example free-energy/binding calc
│   ├── calculateFES.py                 # Compute free energy surfaces (FES)
│   └── process-traj-unbiased.sh        # Process raw MD trajectories
│
├── interferents_gaff/   # Force-field (GAFF) for interferent molecules
│   ├── TCAA.*           # Trichloroacetic acid (TCAA) inputs
│   ├── sds.*            # SDS inputs
│   ├── *.sh             # Box generation & parameter extraction scripts
│
├── qMD4/                # Cyclodextrin base parameter files
│   ├── acd.gro/top      # α-cyclodextrin
│   ├── bcd/...          # β-cyclodextrin with force-field files
│   ├── gcd.gro/top      # γ-cyclodextrin
│   ├── ions.itp, water-ffatoms.itp
│
└── system_cd/           # Full MD system setups for each host–guest pair
    ├── pfos-f-*         # PFOS with ACD, BCD, GCD
    ├── sds-f-*          # SDS with ACD, BCD, GCD
    ├── tcaa-f-*         # TCAA with ACD, BCD, GCD
    │   ├── *.gro/top/itp/mdp         # Structures & topology
    │   ├── plumed.dat               # Biasing/collective variable setup
    │   ├── taac-*.sbatch            # Cluster submission scripts
    │   ├── reweight*.sh             # Free-energy reweighting scripts


- **`*-f-acd`**, **`*-f-bcd`**, **`*-f-gcd`**: PFAS/interferent bound to α, β, γ‑cyclodextrin  
- **`*.mdp`**: Standard GROMACS input files for minimization, equilibration, and production runs  
- **`plumed*.dat`**: PLUMED inputs for biasing
- **`*.sbatch`**: SLURM job submission scripts for HPC execution  

---

Published work avaliable at DOI: 10.26434/chemrxiv-2024-6q6q5


