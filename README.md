ST558 Project 2
================
Noel Hilliard
July 3, 2020

  - [Introduction Online News Popularity
    Data](#introduction-online-news-popularity-data)
  - [Analysis](#analysis)

Project Objective: The goal is to create models for predicting the
`shares` variable from the dataset. You will create two models: a linear
regression model and a non-linear model (each of your choice). You will
use the parameter functionality of markdown to automatically generate an
analysis report for each `weekday_is_*` variable (so you’ll end up with
seven total outputted documents).

    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output MondayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS MondayAnalysis.md --to html4 --from gfm --output MondayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output TuesdayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS TuesdayAnalysis.md --to html4 --from gfm --output TuesdayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output WednesdayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS WednesdayAnalysis.md --to html4 --from gfm --output WednesdayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output ThursdayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS ThursdayAnalysis.md --to html4 --from gfm --output ThursdayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output FridayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS FridayAnalysis.md --to html4 --from gfm --output FridayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output SaturdayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS SaturdayAnalysis.md --to html4 --from gfm --output SaturdayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW 
    ##   |                                                                              |                                                                      |   0%  |                                                                              |.                                                                     |   2%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...                                                                   |   4%
    ## label: rmarkdown params (with options) 
    ## List of 3
    ##  $ echo   : logi FALSE
    ##  $ eval   : logi FALSE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |....                                                                  |   6%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......                                                                |   9%
    ## label: rmarkdown automation (with options) 
    ## List of 2
    ##  $ eval: logi FALSE
    ##  $ echo: logi FALSE
    ## 
    ##   |                                                                              |.......                                                               |  11%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........                                                             |  13%
    ## label: libraries (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |..........                                                            |  15%
    ##    inline R code fragments
    ## 
    ##   |                                                                              |............                                                          |  17%
    ## label: read/filter data (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |.............                                                         |  19%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............                                                       |  21%
    ## label: select variables (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................                                                      |  23%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................                                                    |  26%
    ## label: train/test data (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................                                                   |  28%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.....................                                                 |  30%
    ## label: histogram (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |......................                                                |  32%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |........................                                              |  34%
    ## label: bar plot (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |.........................                                             |  36%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...........................                                           |  38%
    ## label: shares_group count (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |............................                                          |  40%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..............................                                        |  43%
    ## label: shares summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...............................                                       |  45%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.................................                                     |  47%
    ## label: TrainStatSum function (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..................................                                    |  49%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |....................................                                  |  51%
    ## label: above 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.....................................                                 |  53%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.......................................                               |  55%
    ## label: below 1400 stat summary (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |........................................                              |  57%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..........................................                            |  60%
    ## label: bagged tree  (with options) 
    ## List of 2
    ##  $ echo   : logi TRUE
    ##  $ message: logi FALSE
    ## 
    ##   |                                                                              |...........................................                           |  62%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.............................................                         |  64%
    ## label: predict bag tree  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |..............................................                        |  66%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |................................................                      |  68%
    ## label: bag fit info  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.................................................                     |  70%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...................................................                   |  72%
    ## label: bag table  (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |....................................................                  |  74%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |......................................................                |  77%
    ## label: bag misclass (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.......................................................               |  79%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |.........................................................             |  81%
    ## label: correlation (with options) 
    ## List of 1
    ##  $ echo: logi TRUE

    ##   |                                                                              |..........................................................            |  83%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |............................................................          |  85%
    ## label: mlr (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |.............................................................         |  87%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |...............................................................       |  89%
    ## label: compare fit (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |................................................................      |  91%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................    |  94%
    ## label: fit stats (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |...................................................................   |  96%
    ##   ordinary text without R code
    ## 
    ##   |                                                                              |..................................................................... |  98%
    ## label: compare rmse Test (with options) 
    ## List of 1
    ##  $ echo: logi TRUE
    ## 
    ##   |                                                                              |......................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS READMEtemplate.utf8.md --to gfm --from markdown+autolink_bare_uris+tex_math_single_backslash --output SundayAnalysis.md --standalone --table-of-contents --toc-depth 3 --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\default.md" 
    ## "C:/Program Files/RStudio/bin/pandoc/pandoc" +RTS -K512m -RTS SundayAnalysis.md --to html4 --from gfm --output SundayAnalysis.html --standalone --self-contained --highlight-style pygments --template "C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\PREVIE~1.HTM" --variable "github-markdown-css:C:\PROGRA~1\R\R-36~1.3\library\RMARKD~1\RMARKD~1\TEMPLA~1\GITHUB~1\RESOUR~1\github.css" --email-obfuscation none --metadata pagetitle=PREVIEW

    ## [1] "S:/ST558/Homeworks/Project 2/ST558 Project 2/MondayAnalysis.md"   
    ## [2] "S:/ST558/Homeworks/Project 2/ST558 Project 2/TuesdayAnalysis.md"  
    ## [3] "S:/ST558/Homeworks/Project 2/ST558 Project 2/WednesdayAnalysis.md"
    ## [4] "S:/ST558/Homeworks/Project 2/ST558 Project 2/ThursdayAnalysis.md" 
    ## [5] "S:/ST558/Homeworks/Project 2/ST558 Project 2/FridayAnalysis.md"   
    ## [6] "S:/ST558/Homeworks/Project 2/ST558 Project 2/SaturdayAnalysis.md" 
    ## [7] "S:/ST558/Homeworks/Project 2/ST558 Project 2/SundayAnalysis.md"

# Introduction Online News Popularity Data

The data used for this analysis was obtained from the [UCI Machine
Learning
Reposititory](https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity).
The data set summarizes a set of features about articles published by
Mashable over a two year period. The purpose of this analysis is to
predict the number of shares in social networks using select features
from the data set. Two types of methods will be used to predict the
`shares`. The first model discussed is a bagged tree model. For this
analysis, the `shares` were divided into two groups (\< 1400 and \>=
1400) to create a binary classification problem. The second model
discussed is linear regression. Both types of models were trained/tuned
using the training data set and then then predictions were made using
the test data set.

# Analysis

The full data set contained data for all days of the week.

  - The analysis for [Monday is available here.](MondayAnalysis.md)

  - The analysis for [Tuesday is available here.](TuesdayAnalysis.md)

  - The analysis for [Wednesday is available
    here.](WednesdayAnalysis.md)

  - The analysis for [Thursday is available here.](ThursdayAnalysis.md)

  - The analysis for [Friday is available here.](FridayAnalysis.md)

  - The analysis for [Saturday is available here.](SaturdayAnalysis.md)

  - The analysis for [Sunday is available here.](SundayAnalysis.md)
