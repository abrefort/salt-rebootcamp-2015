ec2_states:
  archive.extracted:
    - name: /srv/
    - source: salt://1_states.tar.gz
    - user: root
    - group: root
    - archive_format: tar
    - if_missing: /srv/salt

salt_ppa:
  pkgrepo.managed:
    - ppa: saltstack/salt
    - require_in:
      - pkg: salt-master
      - pkg: salt-minion
      - pkg: salt-cloud
      - pkg: salt-ssh

salt-master:
  pkg.installed

/etc/salt/minion:
  file.managed:
    - contents: |
        master: 127.0.0.1
        id: master
    - require:
      - pkg: salt-master

salt-minion:
  pkg.installed:
    - require:
      - pkg: salt-master
      - file: /etc/salt/minion

salt-cloud:
  pkg.installed

salt-ssh:
  pkg.installed

/etc/salt/cloud.profiles:
  file.managed:
    - source: salt://master/cloud.profiles.jinja2
    - template: jinja
    - require:
      - pkg: salt-cloud

/etc/salt/cloud.providers:
  file.managed:
    - source: salt://master/cloud.providers.jinja2
    - template: jinja
    - require:
      - pkg: salt-cloud

/root/minions-map.yml:
  file.managed:
    - source: salt://master/minions-map.yml

{{ salt['pillar.get']('salt-demo:ssh:keypath') }}:
  file.managed:
    - mode: 0400
    - contents_pillar: salt-demo:ssh:key
