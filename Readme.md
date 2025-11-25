# SQL Geospatial Accidents Geneva Project 
## The data 
Data for this project comes from open source, official sources : 
- https://sitg.ge.ch/donnees/otc-accidents#additional-informations
Information de la Source : Système d'information du territoire à Genève
(SITG), imprimé et/ou extrait en date du 31.03.2025
- https://opendata.tpg.ch/explore/dataset/arrets/export/?disjunctive.arretcodelong&disjunctive.nomarret&disjunctive.commune&disjunctive.pays 
Source: Transports Publics Genevois (TPG), téléchargé le 22 nov 2025. 

Questions we investigate in this project:
- How do accidents distribute over time?
- How close are accidents to the nearest public transport stop?
- Which stops are most dangerous?

Tools: 
- PostgreSQL for database
- PostGIS extension for geospatial data queries
- SQL queries
