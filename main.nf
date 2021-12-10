#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
========================================================================================
    Template Example
    Github : https://github.com/vincent-van-hoef/project_template
========================================================================================
*/

// Input raw data
 data = Channel.fromPath( params.input )

 // Specify directories
 rtar       = Channel.fromPath( params.rtar )
 rfun       = Channel.fromPath( params.rfun )
 dash       = Channel.fromPath( params.dashboard )
 results    = Channel.fromPath( params.outdir )
 reportdir  = Channel.fromPath( params.reportdir )

// Include the publishing module.
include { publishReport } from './modules/publishReport.nf'

/*
 *    PREPROCESS DATA
 */

 
 process checkLength {
    container 'ubuntu:22.04'
    publishDir "${params.outdir}/length", mode: 'copy'

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
    container 'vvanhoef/interactive_r:v1'
    publishDir "${params.outdir}/plots", mode: 'copy'

    input:
    path calcium
    path rtar
    path rfun
    path dash

    output:
    path 'scatter.pdf'
    val true, emit: done_ch

    script:
    """
    Rscript -e 'install.packages(c("targets", "tarchetypes")); targets::tar_make()'
    """

}

workflow {
   checkLength(data)
   createFigs(data, rtar, rfun, dash)
   publishReport(createFigs.out.done_ch, results, reportdir)
}