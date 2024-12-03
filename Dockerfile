# Use a base image with R installed
FROM rocker/rstudio:latest AS base

# Set the working directory in the container
WORKDIR /project

# Copy the project files into the container
COPY . /project

# Install required system libraries
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    libfontconfig1-dev \ 
    libfreetype6-dev \    
    && apt-get clean

# Install R packages required for restoring the environment
RUN Rscript -e 'install.packages(c("renv"))'

# Restore R package dependencies with renv
RUN R -e 'renv::restore()'

# Set the default command to render the report
CMD ["Rscript", "-e", "rmarkdown::render('/project/report/final_report.Rmd')"]
