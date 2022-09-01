FROM 812206152185.dkr.ecr.us-west-2.amazonaws.com/latch-base:9a7d-main

# Install R
RUN apt install -y dirmngr apt-transport-https ca-certificates software-properties-common gnupg2
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian buster-cran40/'
RUN apt update
RUN apt install -y r-base build-essential
RUN apt-get install libcurl4-openssl-dev

# Install packages
RUN R -e "install.packages('Rcpp')"
RUN R -e "install.packages('curl')"
RUN R -e "install.packages('RCurl')"
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('S4Vectors', force = TRUE)"
RUN R -e "BiocManager::install('IRanges', force = TRUE)"
RUN R -e "BiocManager::install('XVector', force = TRUE)"
RUN R -e "BiocManager::install('GenomicRanges', force = TRUE)"
RUN R -e "BiocManager::install('Biobase', force = TRUE)"
RUN R -e "BiocManager::install('DelayedArray', force = TRUE)"
RUN R -e "BiocManager::install('BiocParallel', force= TRUE)"
RUN R -e "BiocManager::install('SingleCellExperiment', force = TRUE)"
RUN R -e "BiocManager::install('locfit', force = TRUE)"
RUN R -e "BiocManager::install('edgeR', force = TRUE)"
RUN R -e "BiocManager::install('rhdf5', force = TRUE)"
RUN R -e "BiocManager::install('DropletUtils', dependencies = TRUE); if (!library(DropletUtils, logical.return=T)) quit(status=10)"

# STOP HERE:
# The following lines are needed to ensure your build environement works
# correctly with latch.
COPY wf /root/wf
ARG tag
ENV FLYTE_INTERNAL_IMAGE $tag
RUN python3 -m pip install --upgrade latch
WORKDIR /root
