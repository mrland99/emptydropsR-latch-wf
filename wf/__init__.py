"""
Distinguishing cells from empty droplets in droplet-based single-cell RNA sequencing data.
"""

import subprocess
from latch import small_task, workflow
from latch.types import LatchFile, LatchDir

@small_task
def execute_Rscript(
    tenx_mtx_path: LatchFile, 
    out_dir: LatchDir,
    lower: int,
    ignore: int,
    ) -> LatchDir:

    # A reference to our output.
    local_out_dir = '/root/emptydrops_results'

    _emptydrops_cmd = [
        "Rscript",
        "/root/wf/run_emptydrops.R",
        tenx_mtx_path.local_path,
        local_out_dir,
        str(lower),
        str(ignore),
    ]
    subprocess.run(_emptydrops_cmd)
    return LatchDir(local_out_dir, out_dir.remote_path)


@workflow
def run_emptydrops(
    tenx_mtx_path: LatchFile,
    out_dir: LatchDir,
    lower: int = 100,
    ignore: int = 0
    ) -> LatchDir:
    """Description...

    EmptyDrops
    ----

    Distinguish between droplets containing cells and ambient RNA in a droplet-based single-cell RNA sequencing experiment.

    The manuscript can be found [here](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1662-y)

    Other Notes:
      - The input is a `.mtx` file of genes (rows) x cells (cols).

    __metadata__:
        display_name: emptyDropsR
        author:
            name:
            email:
            github: 
        repository:
        license:
            id: MIT

    Args:

        tenx_mtx_path:
          Sparse read count (.mtx) file from 10x output. Should be genes (rows) x cells (cols).

          __metadata__:
            display_name: 10x_mtx_file

        out_dir:
            Folder to write outputs of emptyDropsR. 

          __metadata__:
            display_name: out_dir
        
        lower:
          A numeric scalar specifying the lower bound on the total UMI count, at or below
           which all barcodes are assumed to correspond to empty droplets.

          __metadata__:
            display_name: lower

        ignore:
          A numeric scalar specifying the lower bound on the total UMI count, at or below which barcodes will be ignored.
          This differs from the `lower` argument in that the ignored barcodes are not necessarily used to compute the ambient profile.
         Users can interpret `ignore` as the minimum total count required for a barcode to be considered as a potential cell. 
         In contrast, `lower` is the maximum total count below which all barcodes are assumed to be empty droplets.

          __metadata__:
            display_name: ignore

        


    """
    return execute_Rscript(
        tenx_mtx_path = tenx_mtx_path,
        out_dir = out_dir,
        lower = lower, 
        ignore = ignore
)
