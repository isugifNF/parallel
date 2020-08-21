# isugifNF/parallel

```
----------------------------------------------------
                                    \\---------//       
      ___  ___        _   ___  ___    \\-----//        
       |  (___  |  | / _   |   |_       \-//         
      _|_  ___) |__| \_/  _|_  |        // \        
                                      //-----\\       
                                    //---------\\       
      isugifNF/parallel  v1.0.0       
    ----------------------------------------------------
```

[Genome Informatics Facility](https://gif.biotech.iastate.edu/) | [![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A519.10.0-brightgreen.svg)](https://www.nextflow.io/)

## Introduction

**isugifNF/parallelNF** is a [nextflow pipeline](https://www.nextflow.io/) performs similar operations to gnu parallel, xargs or a for loop.

The workflow requires two parameters `--input` and `--script`.

<details><summary>Usage Statement</summary>

```
Usage:
The typical command for running the pipeline is as follows:
nextflow run isugifNF/parallelNF --input 'command to list input files' --script 'command to run on each input file'

Mandatory arguments:

--input                       Command to list input files
--script                      Command to run on each input file

Optional arguments:
--outdir                      Output directory to place final BLAST output
--outFile                     regular expression pattern for your outfiles
--threads                      Number of CPUs to use during blast job [16]
--help                         This usage statement.
```

</details>

## Examples

It is important to use full paths which is why you will see `$PWD` used in all the examples

### 1) Checkpointed Untar for specific files

Using nextflow to untar specific files from an archive.  Notice how I had to escape the `$NF` in the awk command.

INPUT: In this example I am using the raw reads from a a Nanopore run I got back for green abalone (Green_13_SRE.tar)

* Using nextflow
```
nextflow run main.nf --input "tar -tvf $PWD/Green_13_SRE.tar |awk '(/\.fastq/ && /pass/)' | awk '{print \$NF}'" --script "tar -xvf $PWD/Green_13_SRE.tar" --threads 36
```
* Using xargs
```
tar -tvf $PWD/Green_13_SRE.tar |awk '(/\.fastq/ && /pass/)' | awk '{print $NF}' | xargs -I xx tar -xvf $PWD/Green_13_SRE.tar xx
```

There was actually very little speed up in this example as I believe the IO speed was limiting the writing. The benefit of nextflow however is that it checkpoints so if this got interupted I could just restart with the --resume function.

### 2) Fastqc on many fastq files

Here I use `ls` to identify all the fastq files I want to run fastqc in the `--input` and place the `fastqc` script in the `--script` parameter

```
nextflow run main.nf --input "ls $PWD/fastqfiles/*" --script "fastqc -t 36 -outdir $PWD/fastqcout" --threads 36 -profile condo
```

## Dependencies if running locally

Nextflow is written in groovy which requires java version 1.8 or greater (check version using `java -version`). But otherwise can be installed if you have a working linux command-line.

```
java -version
curl -s https://get.nextflow.io | bash

# Check to see if nextflow is created
ls -ltr nextflow
#> total 32
#> -rwx--x--x  1 username  staff    15K Aug 12 12:47 nextflow
```


## Credits

These scripts were originally written for use on Ceres and Condo HPCC by Andrew Severin ([@isugif](https://github.com/isugif))
