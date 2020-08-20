# isugifNF/parallelNF

```
----------------------------------------------------
                                    \\---------//       
      ___  ___        _   ___  ___    \\-----//        
       |  (___  |  | / _   |   |_       \-//         
      _|_  ___) |__| \_/  _|_  |        // \        
                                      //-----\\       
                                    //---------\\       
      isugifNF/blast  v1.0.0       
    ----------------------------------------------------
```

[Genome Informatics Facility](https://gif.biotech.iastate.edu/) | [![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A519.10.0-brightgreen.svg)](https://www.nextflow.io/)

### Introduction

**isugifNF/parallelNF** is a [nextflow pipeline](https://www.nextflow.io/) performs similar operations to gnu parallel, xargs or a for loop.

The workflow requires two parameters `--input` and `--script`.

<details><summary>Usage Statement</summary>



</details>

### Dependencies if running locally

Nextflow is written in groovy which requires java version 1.8 or greater (check version using `java -version`). But otherwise can be installed if you have a working linux command-line.

```
java -version
curl -s https://get.nextflow.io | bash

# Check to see if nextflow is created
ls -ltr nextflow
#> total 32
#> -rwx--x--x  1 username  staff    15K Aug 12 12:47 nextflow
```


### Credits

These scripts were originally written for use on Ceres and Condo HPCC by Andrew Severin ([@isugif](https://github.com/isugif))
