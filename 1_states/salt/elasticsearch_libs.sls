python-pip:
  pkg.installed

elasticsearch:
  pip.installed:
    - require:
      - pkg: python-pip

jsonpickle:
  pip.installed:
    - require:
      - pkg: python-pip
