openjdk-7-jre-headless:
  pkg.installed

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.0.deb
    - require:
      - pkg: openjdk-7-jre-headless
  service.running:
    - require:
      - pkg: elasticsearch
