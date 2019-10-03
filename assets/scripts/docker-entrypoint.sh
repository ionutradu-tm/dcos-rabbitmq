#!/bin/bash
set -eu

# Build rabbitmqh node shortname
export APP_SHORTNAME="${MESOS_TASK_ID//./-}"
export RABBITMQ_NODENAME="rabbit@$APP_SHORTNAME"

case ${1} in
    app:start)
	rm -rf /var/run/supervisor.sock
	exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
    ;;
  app:help)
    echo "Available options:"
    echo " app:start        - Starts the application (default)"
    echo " app:help         - Displays the help"
    echo " [command]        - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac