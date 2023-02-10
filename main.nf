#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
 * Defines some parameters in order to specify the refence genomes
 * and read pairs by using the command line options
 */
params.reads 		= '/proj/sens2021600/orig_results/fastq/*_R{1,2}.fastq.gz'
params.targetbed 	= '/proj/sens2021600/SMS-5975-21-met_bc/data/db/Target_2104PD005-V1_Lablife_Nordic_Customized_Pan_Cancer_405_Panel_2.bed'
params.genomeBase 	= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Sequence/BWAIndex/human_g1k_v37_decoy.fasta"
params.outdir 		= "/proj/sens2021600/nobackup/results"
params.metadata 	= '/proj/sens2021600/SMS-5975-21-met_bc/data/db/Additional_info_tCelemics_20210819.csv'
params.metadata_all 	= '/proj/sens2021600/SMS-5975-21-met_bc/data/db/CTC_MBC_primär_db_master_20211203_label.xlsx'
params.legend 	= '/proj/sens2021600/SMS-5975-21-met_bc/data/db/nanostring_legend.csv'
params.nstring 	= '/proj/sens2021600/SMS-5975-21-met_bc/data/db/Report360.csv'

params.fasta 		= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Sequence/WholeGenomeFasta/human_g1k_v37_decoy.fasta"
params.fastafai 	= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Sequence/WholeGenomeFasta/human_g1k_v37_decoy.fasta.fai"
params.fastadict 	= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Sequence/WholeGenomeFasta/human_g1k_v37_decoy.dict"
params.dbsnp 		= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/dbsnp_138.b37.vcf"
params.dbsnpidx 	= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/dbsnp_138.b37.vcf.idx"
params.kg 		= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/1000G_phase1.indels.b37.vcf"
params.kgidx 		= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/1000G_phase1.indels.b37.vcf.idx"
params.mills 		= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/Mills_and_1000G_gold_standard.indels.b37.vcf"
params.millsidx 	= "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GATKBundle/Mills_and_1000G_gold_standard.indels.b37.vcf.idx"
params.pon		= "/proj/sens2021600/SMS-5975-21-met_bc/data/db/somatic-b37-Mutect2-exome-panel.vcf"
params.ponindex		= "/proj/sens2021600/SMS-5975-21-met_bc/data/db/somatic-b37-Mutect2-exome-panel.vcf.idx"
params.cosmic		= "/proj/sens2021600/SMS-5975-21-met_bc/data/db/CosmicCodingMuts_hg19_target.recode.vcf"
params.cosmic_rda	= "/proj/sens2021600/SMS-5975-21-met_bc/data/db/COSMIC.rda"

params.germlineResource = "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GermlineResource/gnomAD.r2.1.1.GRCh37.PASS.AC.AF.only.vcf.gz"
params.germlineResourceIndex = "/sw/data/iGenomes/Homo_sapiens/GATK/GRCh37/Annotation/GermlineResource/gnomAD.r2.1.1.GRCh37.PASS.AC.AF.only.vcf.gz.tbi"
params.db 		= "GRCh37.75"

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