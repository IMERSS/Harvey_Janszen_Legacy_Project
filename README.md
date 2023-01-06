---

# Living Data Rescue: Harvey Janszen Legacy Project

This repository contains data entry templates, digitization protocols, data processing scripts, and digitized data outputs for the field notes of Harvey Janszen (1946-2021)

## The three types of data entered & processed by these scripts and protocols:

1)  Observation-only occurrence data (in field journals)

2)  Field notes of collected specimens (in field journals)

3)  Digitized herbarium label data (on specimen photographs)

## Data Sources

1.  **Field Journals**

    -   HJ5 = Flora of Saturna (1973-1981)

    -   HJ7 = Journal ca. 1981-1996

    -   HJ8 = Journal ca. 1996-2000

    -   HJ9 = Unbound field notes ca. 1999-2003

    -   HJ27 = Field notes ca. 2003-2017

2.  **Collected specimens**

    -   Royal British Columbia Museum (RBCM) Herbarium (\~1263 specimens)

        -   Specimens labels

        -   Digitized collection label data in database

    -   University of British Columbia (UBC) Herbarium (\~ 50 specimens)

    -   \~ 65 specimens from later in Harvey's life to be accesseioned at the UBC Herbarium

## General workflow

DwC = Darwin Core occurrence data standards

GBIF = Global Biodiversity Information Facility

## ![A path diagram of this repository for the Harvey Janszen Legacy Project](img/LDP-Internship-map.png)

## Ultimate goals for this project

1.  **Published observation-only (occurrence) data to GBIF** *(potentially via Canadensys)*

2.  **Cleaned/ Reviewed Herbarium records** for Harvey's collections housed at the RBCM *(ultimately published to GBIF by the RBCM Herbarium)*

3.  **\~ 65 new specimens accessioned at the UBC Herbarium** *(ultimately published to GBIF by the UBC Herbarium)*

## Grouped Components

1.  **Observation-only occurrence data**

    *Data entry*

    -   [occ-data-entry-template](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/data/data_digitization/occurrence_data/1_raw_data/HJ-occ-entry-template.xlsx) (template to enter data)

    -   [1_raw_data](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/data/data_digitization/occurrence_data/1_raw_data) folder (houses the data entry files for respective journals)

    -   [occ-data-entry-protocol](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/protocols/occ-data-entry-protocol.Rmd) (follow this protocol to enter data)

    *Data processing*

    -   [post-entry-processing](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/protocols/post-entry-processing.Rmd) (follow this protocol to process entered data)

    -   [occ_data_processing](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/scripts/occ_data_processing) folder (contains scripts to process data iteratively)

    Output

    -   [CSV files of Darwin Core formatted occurrences found here](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/data/data_digitization/occurrence_data/darwin_core_data)

2.  **Collection data**

    *Data entry*

    -   [coll-data-entry-template](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/data/data_digitization/collection_data/1_raw_data/HJ-coll-entry%20template.xlsx) (template to enter data)

    -   [1_raw_data](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/data/data_digitization/collection_data/1_raw_data)folder (houses the data entry files for respective journals)

    -   [coll-data-entry-protocol](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/protocols/coll-data-entry-protocol.Rmd) (follow this protocol to enter data)

    *Data processing*

    -   [post-entry-processing](https://github.com/emench/Harvey_Janszen_Legacy_Project/blob/main/protocols/post-entry-processing.Rmd) (follow this protocol to process entered data)

    -   [coll_data_processing](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/scripts/coll_data_processing)folder (contains scripts to process data iteratively)

    Output

    -   [CSV files of Darwin Core formatted collection data found here](https://github.com/emench/Harvey_Janszen_Legacy_Project/tree/main/data/data_digitization/collection_data/darwin_core_data)
