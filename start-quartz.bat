REM Start Zookeeper
title quartz
C:
cd C:/infosys-project/tenx/bin
java -jar quartz-service.jar -config /tenx/config/ring-nprep.properties,/tenx/config/quartz.properties &