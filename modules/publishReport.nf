process publishReport {
    container 'rocker/verse:4.1'
    publishDir "./", mode: 'copy', overwrite: true

    input:
    val done_ch
    path $params.outdir
    path reportSrc
    path $params.assets

    output:
    path 'report/'

    script:
    """
    mkdir src
    mv *.Rmd *.yml style.css src/
    cd src/
    Rscript -e 'bookdown::render_book("index.Rmd")'
    mv report ../report
    """
}