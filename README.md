# LTD IoT Gateway Containers

## Quick start

On a fresh image (capable of running docker), run the following commands to bootstrap your LTD IoT Gateway environment:

### Bluetooth LE 6LoWPAN Joiner

```
docker run --restart=always -d -t --privileged --net=host --tmpfs=/run:rw,mode=755 --tmpfs=/run/lock --name bt-joiner linarotechnologies/bt-joiner:latest-arm64
```

### Tinyproxy (IPv6 -> IPv4)

Use *--add-host* to specify the local address of the hawkBit container:

```
docker run --restart=always -d -t --net=host --add-host=gitci.com:192.168.1.10 --name tinyproxy linarotechnologies/tinyproxy:latest-arm64
```

### Mosquitto MQTT Broker

Brokering MQTT data from an IoT device to an apporpriate data system can be done using a pre-built mosquitto broker.  Though you can run any number of brokers, you would want to change the expost port before trying to run multiple brokers.  It's typical that you would run one of these containers on your gateway.

#### IBM Bluemix Mosquitto

Create the authentication keys file:

```
$ cat ~/ibm-bluemix-mosquitto.env
BLUEMIX_AUTHKEY=a-org-authkey
BLUEMIX_AUTHTOKEN=auth-token
BLUEMIX_ORG=bluemix-org
GW_DEVICE_TYPE=hikey
```

Start the container:

```
docker run --restart=always -d -t --net=host --env-file=/home/linaro/ibm-bluemix-mosquitto.env --name ibm-bluemix-mosquitto linarotechnologies/ibm-bluemix-mosquitto:latest-arm64
```

#### Generic Mosquitto broker

Create a local mosquitto configuration file:

```
$ cat ~/mqtt-broker.conf
connection #connection-name
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

Start the container:

```
docker run --restart=always -d -t --net=host -v /home/linaro/mosquitto.conf:/etc/mosquitto/conf.d/mosquitto.conf --name mosquitto linarotechnologies/mosquitto:latest-arm64
```
