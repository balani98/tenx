REM Start Zookeeper
title master
C:
cd C:/infosys-project/tenx/bin
java  -d64 -Xms256m -Xmx5212m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/logs/master_heapdump -XX:+ExitOnOutOfMemoryError -cp "ring-master.jar;/tenx/lib/;/tenx/lib/*" tenx.executor.ring.master.Master -config C:\\infosys-project\\tenx\\config\\nprep.properties
