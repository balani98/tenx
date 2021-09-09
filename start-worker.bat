REM Start Zookeeper
title worker
C:
cd C:/infosys-project/tenx/bin
java -d64 -Xms512m -Xmx1g -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/logs/worker_heapdump  -XX:+ExitOnOutOfMemoryError -cp "ring-worker.jar;/tenx/lib/;/tenx/lib/*" tenx.executor.ring.worker.Worker -config  C:\\infosys-project\\tenx\\config\\ring-nprep.properties , C:\\infosys-project\\tenx\\config\\nprep.properties