# Rendering a Quarto project under Nextflow

Figuring out how to render a Quarto project from pieces under Nextflow.

## How to

1. Make your own project configuration. See [assets/quarto_project_config](assets/quarto_project_config.yml).
2. Send your notebooks through the correct processes/containers/environments.
3. Pass caches to the final process and rerender project as a whole. 

## Yet to explore

- Can one use dynamic directives to set the container based on notebook text (and a groovy switch expression)?