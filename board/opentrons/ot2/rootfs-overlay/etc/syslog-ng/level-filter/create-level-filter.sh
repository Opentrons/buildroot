LOG_LEVEL_DIR=/var/lib/syslog-ng
LOG_LEVEL_FILE=${LOG_LEVEL_DIR}/min-level

if [ ! -f ${LOG_LEVEL_FILE} ]
then
    mkdir -p /var/lib/syslog-ng
    echo "debug" > /var/lib/syslog-ng/min-level
fi

level=$(cat ${LOG_LEVEL_FILE})

# The actual filter statement. This sets the minimum
# log level to what was in the level file
echo "level(${level}..emerg);"
