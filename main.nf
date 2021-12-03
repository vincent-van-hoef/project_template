#!/usr/bin/env nextflow

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
    container 'bash:alpine3.14'

    input:
    file calcium from input_ch

    output:
    file 'no_lines.txt'

    script:
    """
    wc -l $calcium > no_lines.txt
    """        
}