process QUARTO_RENDER {
    input:
    path notebook

    script:
    """
    quarto render $notebook
    """

    output:
    path "*.html", emit: html
}