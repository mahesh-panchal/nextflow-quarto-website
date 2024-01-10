process QUARTO_RENDER_PROJECT {
    input:
    path '_quarto.yml' // Project configuration
    path notebooks
    path cache, stageAs: '_freeze/*'

    script:
    """
    quarto render .
    """

    output:
    path "docs", optional: true
}