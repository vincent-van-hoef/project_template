#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
========================================================================================
    Template Example
========================================================================================
    Github : https://github.com/vincent-van-hoef/project_template
----------------------------------------------------------------------------------------
*/

/*
 *    PREPROCESS DATA
 */

input_ch = Channel.fromPath( params.input )

process checkLength {
    container 'ubuntu:22.04'

    input:
    path calcium

    output:
    path 'no_lines.txt'

    script:
    """
    wc -l $calcium > no_lines.txt
    """        
}

workflow {
   data = Channel.fromPath( params.input ) 
   checkLength(data)
}