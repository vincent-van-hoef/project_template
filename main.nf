#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Include modules
include { multiqc; 
	multiqc as multiqc_trim } from './modules/modules.nf'


workflow {

	// Collect the fastq files and the metadata
	fastq = Channel
    		.fromFilePairs( params.reads )
    		.ifEmpty( "Cannot find any reads matching: ${params.reads}" )
	metadata = Channel.fromPath( params.metadata ).splitCsv( sep : ";" )

}