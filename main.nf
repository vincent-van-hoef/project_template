#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
========================================================================================
    Template Example
========================================================================================
    Github : https://github.com/vincent-van-hoef/project_template
----------------------------------------------------------------------------------------
*/

 data = Channel.fromPath( params.input )
 rtar = Channel.fromPath( params.Rtar )
 rfun = channel.fromPath( params.Rfun )

 reportSrc = channel.fromPath( params.pubScripts ).collect()
 reportAssets = channel.fromPath( params.pubAssets ).collect()
 reportResults = channel.fromPath( params.pubResults )

/*
 *    PREPROCESS DATA
 */

 
 process checkLength {
    container 'ubuntu:22.04'
    publishDir "./results/length", mode: 'copy'

    input:
    path calcium

    output:
    path 'no_lines.txt'

    script:
    """
    wc -l $calcium > no_lines.txt
    """        
}

process createFigs {
    container 'rocker/verse:4.1'
    publishDir "./results/plots", mode: 'copy'
    publishDir "./src/results/plots", mode: 'symlink'

    input:
    path calcium
    path rtar
    path rfun

    output:
    path 'scatter.pdf', emit: analysis_results

    script:
    """
    Rscript -e 'install.packages("targets"); library("targets");tar_make()'
    """

}

process publishReport {
    container 'rocker/verse:4.1'
    publishDir "./", mode: 'copy', overwrite: true

    input:
    path analysis_results
    path reportResults
    path reportSrc
    path reportAssets

    output:
    path 'report/'

    script:
    """
    mkdir src
    mv *.Rmd *.yml style.css src/
    cd src/
    Rscript -e 'bookdown::render_book("index.Rmd")'
    mv report ../report
    """
}

workflow {
   checkLength(data)
   createFigs(data, rtar, rfun)
   publishReport(createFigs.out, reportSrc, reportAssets, reportResults)
}