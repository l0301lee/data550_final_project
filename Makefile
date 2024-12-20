# Define the report output file
report/final_report.html: report/final_report.Rmd output_files
	Rscript -e "rmarkdown::render(here::here('report/final_report.Rmd'))"

# Define the output files required for the report
output_files: output/lung_data_clean.rds output/table1.html output/age_distribution.png output/model_summary.html

# Rule for each output file
output/lung_data_clean.rds:
	Rscript code/01_data_preprocessing.R

output/table1.html: output/lung_data_clean.rds
	Rscript code/02_descriptive_analysis.R

output/age_distribution.png: output/lung_data_clean.rds
	Rscript code/03_plot_age_distribution.R

output/model_summary.html: output/lung_data_clean.rds
	Rscript code/04_predictive_modeling.R

# Clean up generated files
.PHONY: clean
clean:
	rm -f output/* && rm -f report/final_report.html

# Install and restore R packages using renv
install:
	Rscript -e 'renv::restore()'

# Define the docker run command
docker_run:
	docker run --rm \
	    -v $(PWD)/report:/project/report \
	    l0301lee/final

