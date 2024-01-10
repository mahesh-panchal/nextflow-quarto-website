include { QUARTO_RENDER_PAGE as QUARTO_RENDER_PAGE_R     } from "$projectDir/modules/quarto_render_page"
include { QUARTO_RENDER_PAGE as QUARTO_RENDER_PAGE_JULIA } from "$projectDir/modules/quarto_render_page"
include { QUARTO_RENDER_PROJECT                          } from "$projectDir/modules/quarto_render_project"

workflow {
    ch_quarto_config = Channel.fromPath ( params.quarto_config, checkIfExists: true ).collect()
    ch_notebooks = Channel.fromPath ( params.notebooks, checkIfExists: true )
        .branch { notebook ->
            r: notebook.text.contains('```{r}')
            julia: notebook.text.contains('```{julia}')
        }
    QUARTO_RENDER_PAGE_R ( 
        ch_quarto_config, 
        ch_notebooks.r 
    )
    QUARTO_RENDER_PAGE_JULIA ( 
        ch_quarto_config, 
        ch_notebooks.julia 
    )

    project_notebooks = QUARTO_RENDER_PAGE_R.out.notebook
        .mix( QUARTO_RENDER_PAGE_JULIA.out.notebook )

    project_caches = QUARTO_RENDER_PAGE_R.out.cache
        .mix( QUARTO_RENDER_PAGE_JULIA.out.cache )

    QUARTO_RENDER_PROJECT (
        ch_quarto_config,
        project_notebooks.collect(),
        project_caches.collect()
    )

}

