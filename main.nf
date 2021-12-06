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
 results = channel.fromPath( params.outdir )
 reportdir = channel.fromPath( params.reportdir )

include { publishReport } from './modules/publishReport.nf'

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

    input:
    path calcium
    path rtar
    path rfun

    output:
    path 'scatter.pdf'
    val true, emit: done_ch

    script:
    """
    Rscript -e 'install.packages("targets"); library("targets");tar_make()'
    """

}

workflow {
   checkLength(data)
   createFigs(data, rtar, rfun)
   publishReport(createFigs.out.done_ch, results, reportdir)
}