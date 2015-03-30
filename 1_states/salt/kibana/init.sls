kibana:
  user.present:
    - home: /var/tmp/kibana-{{ salt['pillar.get']('kibana:version') }}-linux-x64

  archive.extracted:
    - name: /var/tmp/
    - source: https://download.elasticsearch.org/kibana/kibana/kibana-{{ salt['pillar.get']('kibana:version') }}-linux-x64.tar.gz
    - source_hash: sha1=1b8914c62a606b7103295a4e3ab01ec40c9993ed
    - user: kibana
    - group: kibana
    - archive_format: tar
    - if_missing: /var/tmp/kibana-{{ salt['pillar.get']('kibana:version') }}-linux-x64/config/kibana.yml
    - require:
      - user: kibana

  service.running:
    - watch:
      - archive: kibana
    - require:
      - archive: kibana
      - file: /etc/init.d/kibana

/etc/init.d/kibana:
  file.managed:
    - source: salt://kibana/kibana-init.jinja2
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - require:
      - archive: kibana

/var/tmp/kibana-{{ salt['pillar.get']('kibana:version') }}-linux-x64/config/kibana.yml:
  file.replace:
    - pattern: 'elasticsearch_url: "http://localhost:9200"'
    - repl: 'elasticsearch_url: "http://elasticsearch:9200"'
    - require:
      - archive: kibana
    - watch_in:
      - service: kibana
