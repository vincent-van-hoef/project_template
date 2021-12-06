# Aim

This repo contains a structured set of files that - in theory - should fit most support projects from start to finish; i.e. from raw data processing over analysis to final report. The main workflow is driven by Nextflow and thus allows for the combination of different tools and methods. The hard-coded support for containerized software also secures the reproducibility of the analysis.

# Usage

Click the "Use this template" button to start a new repo based on this example. Put raw data in the `data\raw` folder and modify the scripts as necessary (description of the different scripts below).

Running a completed or ongoing analysis is straightforward:

```
nextflow run main.nf
```


# Folder and File Description

* __main.nf__: Main Nextflow script; orchestrates the whole analysis. A minimal 
example is provided in the template repo.
* __nextflow.config__: Configuration file for the Nextflow run
* __project.config__: Project specific configuration; will be loaded after the nextflow.config.
* __data__: 
    - __raw__: Location of the raw data (data, script or symlink)
    - __db__: Location of extra data and metadata
* __libs__: extra libraries (optional)
* __modules__" Directory containing Nextflow DSL2 modules. For now, only contains a modules to run a bookdown report.
* __publishing__: Rmd files and .yml files describing and configuring the Bookdown report.
* __results__: Output folder for all results. These results should be structured using the publishDir commands in main.nf
* __scr__: Most of the time the main downstream analysis will be done in R. This folder contains the `_targets.R` and `myFunctions.R` scripts necessary to run a "workflow-based" R analysis. More info on {{targets}} can be found [here](https://books.ropensci.org/targets/).
* __docs__: Miscellaneous documentation

The last analysis process before the reporting step should contain `val true, emit: done_ch` in the output section. This will ensure that the reporting process will run **after** this step to keep the reporting up-to-date.

After running the publishReport module, an additonal `report` folder will be created containing the html files. This folder should be delivered to the User together with the `results` folder and be kept on the same relative level to ensure the figures in the report can be found.