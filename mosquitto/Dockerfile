FROM bitnami/minideb:unstable

RUN install_packages ca-certificates mosquitto

# Fix initial start failure so we can run the setup script
RUN touch /var/log/mosquitto/mosquitto.log
RUN chown mosquitto:mosquitto /var/log/mosquitto/mosquitto.log
RUN chmod 644 /var/log/mosquitto/mosquitto.log

EXPOSE 1883 8883

COPY start.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT ["/start.sh"]

# Default to dump service log
CMD tail -f /var/log/mosquitto/mosquitto.log
