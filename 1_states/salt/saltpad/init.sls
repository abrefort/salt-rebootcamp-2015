salt-api:
  pkg.installed: []
  service.running:
    - require:
      - pkg: salt-api
      - file: /etc/salt/master

saltweb:
  user.present:
    - password: {{ salt['pillar.get']('saltpad:saltweb_password') }}

https://github.com/tinyclues/saltpad.git:
  git.latest:
    - target: /var/tmp/saltpad
    - user: saltweb
    - require:
      - user: saltweb

/var/tmp/saltpad/saltpad/local_settings.py:
  file.managed:
    - contents: HOST = "0.0.0.0"

python-pip:
  pkg.installed

saltpad_requirements:
  pip.installed:
    - requirements: /var/tmp/saltpad/requirements.txt
    - require:
      - pkg: python-pip
      - git: https://github.com/tinyclues/saltpad.git

/etc/salt/master:
  file.append:
    - text: |
        rest_cherrypy:
          port: 8000
          host: 127.0.0.1
          disable_ssl: true

        external_auth:
          pam:
            saltweb:
                - .*
                - '@runner'
                - '@wheel'
