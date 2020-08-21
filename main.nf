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
      --outFile                     regular expression pattern for your outfiles
      --threads                      Number of CPUs to use during blast job [16]
      --help                         This usage statement.
     """
}

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


process inputScript {

  publishDir params.outdir, mode: 'copy', pattern: '*'

  input:
  val inFILE from inputFiles.splitText()
  //String fileContents = new File(inputFiles.splitText()).text

  output:
  println "process finished for inFILE"
  //path "*.txt"

  script:

  """
  $params.script $inFILE
  """
}




    def isuGIFHeader() {
        // Log colors ANSI codes
        c_reset = params.monochrome_logs ? '' : "\033[0m";
        c_dim = params.monochrome_logs ? '' : "\033[2m";
        c_black = params.monochrome_logs ? '' : "\033[1;90m";
        c_green = params.monochrome_logs ? '' : "\033[1;92m";
        c_yellow = params.monochrome_logs ? '' : "\033[1;93m";
        c_blue = params.monochrome_logs ? '' : "\033[1;94m";
        c_purple = params.monochrome_logs ? '' : "\033[1;95m";
        c_cyan = params.monochrome_logs ? '' : "\033[1;96m";
        c_white = params.monochrome_logs ? '' : "\033[1;97m";
        c_red = params.monochrome_logs ? '' :  "\033[1;91m";

        return """    -${c_dim}--------------------------------------------------${c_reset}-
        ${c_white}                                ${c_red   }\\\\------${c_yellow}---//       ${c_reset}
        ${c_white}  ___  ___        _   ___  ___  ${c_red   }  \\\\---${c_yellow}--//        ${c_reset}
        ${c_white}   |  (___  |  | / _   |   |_   ${c_red   }    \\-${c_yellow}//         ${c_reset}
        ${c_white}  _|_  ___) |__| \\_/  _|_  |    ${c_red  }    ${c_yellow}//${c_red  } \\        ${c_reset}
        ${c_white}                                ${c_red   }  ${c_yellow}//---${c_red  }--\\\\       ${c_reset}
        ${c_white}                                ${c_red   }${c_yellow}//------${c_red  }---\\\\       ${c_reset}
        ${c_cyan}  isugifNF/parallel  v${workflow.manifest.version}       ${c_reset}
        -${c_dim}--------------------------------------------------${c_reset}-
        """.stripIndent()
    }
