process QUARTO_RENDER_PAGE {
    input:
    path '_quarto.yml' // Project configuration
    path notebook

    script:
    """
    quarto render $notebook
    """

    output:
    path notebook                      , emit: notebook
    path "_freeze/${notebook.baseName}", emit: cache     , optional: true
}