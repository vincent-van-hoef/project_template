#!/usr/bin/env nextflow

/*
========================================================================================
    Template Example
========================================================================================
    Github : https://github.com/vincent-van-hoef/project_template
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    PREPROCESS DATA
========================================================================================
*/

input = Channel.fromPath( './data/raw/*.csv' )

process lines {
    container 'bash:alpine3.14'

    input:
    file calcium from input

    output:
    file 'no_lines.txt'

    """
    wc -l $calcium > no_lines.txt
    """        
}