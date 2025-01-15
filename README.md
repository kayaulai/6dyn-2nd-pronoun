# 6dyn-2nd-pronoun

## Content

The folders of this repository contain the following information:

-   `data`: Contains the raw data as well as the data in a processed form, both in CSV format.

-   `models`: Contains the model objects alongside fit criteria information in RDS format.

-   `output`: Contains the following information:

    -   Contingency tables generated from the data in CSV format

    -   Fixed and random effect estimates from the model in CSV format

    -   Visualisations of the model predictions in SVG format

-   `renv`: Contains reproducible environment information for the `renv` package.

-   `src`: Contains the source code in the Quarto `.qmd` format:

    -   The file starting with 01 is for preprocessing;

    -   The file starting with 02 is for data visualisation pre-modelling;

    -   The file starting with 03 fits the `brms` models and calculates information criteria;

    -   The file starting with 04 visualises the selected model in different ways.