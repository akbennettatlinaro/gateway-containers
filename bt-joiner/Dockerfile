FROM bitnami/minideb:unstable

RUN install_packages bluez wget

# BT 6lowpan joiner
RUN mkdir -p /etc/bluetooth/6lowpand/
VOLUME /etc/bluetooth/6lowpand
RUN wget --no-check-certificate https://raw.githubusercontent.com/linaro-technologies/iot-gateway-files/master/bluetooth_6lowpand.sh -O /usr/bin/bluetooth_6lowpand
RUN chmod +x /usr/bin/bluetooth_6lowpand

COPY start.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT ["/start.sh"]

# Default to dump joiner log
CMD tail -f /var/log/bluetooth_6lowpand.log
