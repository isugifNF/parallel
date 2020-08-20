#! /usr/bin/env nextflow

/*************************************
 nextflow parallel
 *************************************/

 def helpMessage() {
     log.info isuGIFHeader()
     log.info """
      Usage:
      The typical command for running the pipeline is as follows:
      nextflow run isugifNF/parallelNF --input 'command to list input files' --script 'command to run on each input file'

      Mandatory arguments:

      --input                       Command to list input files
      --script                      Command to run on each input file

      Optional arguments:
      --outdir                      Output directory to place final BLAST output
      --threads                      Number of CPUs to use during blast job [16]
      --help                         This usage statement.
     """

     // Show help message
     if (params.help) {
         helpMessage()
         exit 0
     }

process createInput {

  output:
  stdout into inputFiles

  script:
  """
  $params.input
  """
}

process runScript {

  publishDir params.outdir

  input:
  file inputFile from inputFiles

  output:
  println "process finished for $inputFile"

  script:
  """
  $params.script
  """

}
