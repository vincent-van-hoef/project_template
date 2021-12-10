process publishReport {
    container 'vvanhoef/interactive_r:v1'
    afterScript 'mv ./publishing/report ./report/'
    publishDir "./", mode: 'copy', overwrite: true

    input:
    val done_ch
    path results
    path reportdir

    output:
    path './report'

    script:
    """
    cd publishing/
    Rscript -e 'bookdown::render_book("index.Rmd")'
    """
}