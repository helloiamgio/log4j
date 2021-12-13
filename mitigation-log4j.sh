#!/bin/bash
TIMESPATMP=$(date "+%Y.%m.%d-%H.%M.%S")
TIMESPTAMP=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Running CVE-2021-44228 mitigation on $(pwd)"
echo "Log4j 2 Zero-day mitigation script (CVE-2021-44228)" | tee -a "log4j_mitigation_$TIMESPATMP.log"
echo "Log4j 2 Zero-day mitigation script (CVE-2021-44228)" | tee -a "log4j_mitigation_$TIMESPTAMP.log"
JAR_FILES=$(find . -name '*.jar')
for JAR_FILE in $JAR_FILES
do
    echo "[-] Checking: $JAR_FILE" >> "log4j_mitigation_$TIMESPATMP.log"
    echo "[-] Checking: $JAR_FILE" >> "log4j_mitigation_$TIMESPTAMP.log"
    CONTAINS_JNDI_LOOKUP=$(unzip -l "$JAR_FILE" | grep "org/apache/logging/log4j/core/lookup/JndiLookup.class")
    if [ ! -z "$CONTAINS_JNDI_LOOKUP" ]; then
        echo "Found org/apache/logging/log4j/core/lookup/JndiLookup in: $JAR_FILE" >> "log4j_mitigation_$TIMESPATMP.log"
        echo "Removing org/apache/logging/log4j/core/lookup/JndiLookup from $JAR_FILE" | tee -a "log4j_mitigation_$TIMESPATMP.log"
        zip -d "$JAR_FILE" org/apache/logging/log4j/core/lookup/JndiLookup.class  2>&1 >>  "log4j_mitigation_$TIMESPATMP.log"
    if [ -n "$CONTAINS_JNDI_LOOKUP" ]; then
        echo "Found org/apache/logging/log4j/core/lookup/JndiLookup in: $JAR_FILE" >> "log4j_mitigation_$TIMESPTAMP.log"
        echo "Removing org/apache/logging/log4j/core/lookup/JndiLookup from $JAR_FILE" | tee -a "log4j_mitigation_$TIMESPTAMP.log"
        zip -d "$JAR_FILE" org/apache/logging/log4j/core/lookup/JndiLookup.class >>  "log4j_mitigation_$TIMESPTAMP.log" 2>&1
    fi
done