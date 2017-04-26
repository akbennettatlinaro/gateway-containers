#!/bin/sh

service mosquitto start

# Execute all the rest
exec "$@"
