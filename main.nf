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
    publishDir "./report/results/plots", mode: 'symlink'

    input:
    path calcium
    path rtar
    path rfun

    output:
    path 'scatter.pdf'

    script:
    """
    Rscript -e 'install.packages("targets"); library("targets");tar_make()'
    """

}

process publishReport {
    container 'rocker/verse:4.1'
    publishDir "./report/", mode: 'copy'

    input:
    path '*'
    path reportSrc
    path reportAssets

    output:
    path '*.html'
    path 'style.css'
    path 'search_index.json'
    path 'libs/**'

    script:
    """
    Rscript -e 'bookdown::render_book("index.Rmd")'
    """
}

workflow {
   checkLength(data)
   createFigs(data, rtar, rfun)
   publishReport(createFigs.out, reportSrc, reportAssets)
}