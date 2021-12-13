#!/bin/bash
if [[ `id -u` -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
TIMESPATMP=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Running CVE-2021-44228 mitigation on $(pwd)"
echo "Log4j 2 Zero-day mitigation script (CVE-2021-44228)" | tee -a "log4j_mitigation_$TIMESPATMP.log"
JAR_FILES=$(find / -name '*.jar')
for JAR_FILE in $JAR_FILES
do
    echo "[-] Checking: $JAR_FILE" >> "log4j_mitigation_$TIMESPATMP.log"
    CONTAINS_JNDI_LOOKUP=$(unzip -l "$JAR_FILE" | grep "org/apache/logging/log4j/core/lookup/JndiLookup.class")
    if [ ! -z "$CONTAINS_JNDI_LOOKUP" ]; then
        echo "Found org/apache/logging/log4j/core/lookup/JndiLookup in $JAR_FILE" | tee -a "log4j_mitigation_$TIMESPATMP.log"
        fi
done