# emptydropsR-latch-wf
----
### Summary
EmptydropsR is a statistical method that distinguishes between droplets containing cells and ambient RNA in a droplet-based single-cell RNA sequencing experiment. It identifies real cells by detecting significant deviations from the expression profile of the ambient solution.

### Input
This version of the workflow is designed to take 10X's raw feature `matrix.mtx` as input. In other words, the input is a `.mtx` file of genes (rows) x cells (cols).

### Output
This workflow outputs two files:
- `metadata.h5:` stores values of arguments (inputs to emptydropsR) during run time.
- `output.h5:` returns a `LogProb`, `PValue`, and `FDR` that should be used by the user to filter out emptydrops.
  
More information can be found here: https://rdrr.io/github/MarioniLab/DropletUtils/man/emptyDrops.html

### Additional References
The manuscript can be found here: https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1662-y

The source code can be found here: https://github.com/MarioniLab/DropletUtils
