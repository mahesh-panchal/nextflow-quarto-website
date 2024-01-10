include { QUARTO_RENDER as QUARTO_RENDER_R     } from "$projectDir/modules/quarto_render"
include { QUARTO_RENDER as QUARTO_RENDER_JULIA } from "$projectDir/modules/quarto_render"

workflow {
    ch_notebooks = Channel.fromPath( params.notebooks, checkIfExists: true )
        .branch { notebook ->
            r: notebook.text.contains('```{r}')
            julia: notebook.text.contains('```{julia}')
        }
    QUARTO_RENDER_R( ch_notebooks.r )
    QUARTO_RENDER_JULIA( ch_notebooks.julia )
}

