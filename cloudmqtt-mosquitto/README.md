# Mosquitto for CloudMQTT

## Build the container

```
docker build -t cloudmqtt-mosquitto --force-rm -f Dockerfile<.arm64/.armhf> .
```

## Run the container

Create a local mosquitto config file containing the CloudMQTT credentials and channel info:

```
connection #cloudmqtt
address #url:#port
remote_username #username 
remote_password #password
try_private false
start_type automatic
bridge_attempt_unsubscribe false
notifications false
connection_messages true

# Device management subscriptions
topic iotdm-1/type/+/id/# in 1 "" ""

# Gateway notifications
topic iot-2/type/+/id/+/notify in 1 "" ""

# Commands and events
topic iot-2/type/+/id/+/cmd/+/fmt/+ in "" ""
topic iot-2/type/+/id/+/evt/+/fmt/+ out "" ""

# Device management publications
topic iotdevice-1/type/+/id/# out 1 "" ""
```

Then run the containiner volume mounting your mosquitto config file:

```
docker run --restart=always -d -t --net=host -v /path/to/mosquitto.conf:/etc/mosquitto/conf.d/mosquitto.conf --name cloudmqtt-mosquitto cloudmqtt-mosquitto
```

## Run the pre-built container

AMD64:

```
docker run --restart=always -d -t --net=host -v /path/to/mosquitto.conf:/etc/mosquitto/conf.d/mosquitto.conf --name cloudmqtt-mosquitto linarotechnologies/cloudmqtt-mosquitto
```

ARM64:

```
docker run --restart=always -d -t --net=host -v /path/to/mosquitto.conf:/etc/mosquitto/conf.d/mosquitto.conf --name cloudmqtt-mosquitto linarotechnologies/cloudmqtt-mosquitto:latest-arm64
```

ARMHF:

```
docker run --restart=always -d -t --net=host -v /path/to/mosquitto.conf:/etc/mosquitto/conf.d/mosquitto.conf --name cloudmqtt-mosquitto linarotechnologies/cloudmqtt-mosquitto:latest-armhf
```
