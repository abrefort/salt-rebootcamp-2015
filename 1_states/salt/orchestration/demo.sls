minion1:
  salt.state:
    - tgt: minion1
    - sls: orchestration.touch

minion2:
  salt.function:
    - name: cmd.run
    - tgt: minion2
    - arg:
       - sleep 3
    - require:
      - salt: minion1

minion3:
  salt.state:
    - tgt: minion3
    - sls: orchestration.touch
    - require:
      - salt: minion2
