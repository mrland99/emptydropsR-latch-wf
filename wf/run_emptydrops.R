library(DropletUtils)
library(Matrix)
library(rhdf5)

run_emptydrops <- function(in_mtx_path, out_dir, lower, ignore) {
    # matrix should be genes (rows) x cells (cols)
    mtx <- readMM(in_mtx_path)
    set.seed(5)
    dir.create(out_dir, showWarnings = FALSE)
    out <- emptyDrops(mtx, lower = lower, ignore = ignore)
    df <- as.data.frame(out)
    h5write(df, file = file.path(out_dir, "output.h5"), name = "output")
    h5write(out@metadata, file = file.path(out_dir, "metadata.h5"), name = "metadata")
}

args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 4)

run_emptydrops(
    args[1], # in_mtx_path
    args[2], # out_dir
    args[3], # lower
    args[4]  # ignore
    )