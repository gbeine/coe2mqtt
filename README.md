# coe2mqtt - A CAN over Ethernet2MQTT Bridge allowing bidirectional message transfer

This project provides a virtual CMI device like the CMI from [Technische Alternative](https://help.ta.co.at/DE/CMIHELP/coe____can_over_ethernet_.htm).
It allows bidirectional message transfer between CAN bus via [CoE](https://wiki.ta.co.at/CAN_over_Ethernet_(CoE)) and MQTT. 

## Installation

### Installation using Docker

```
docker run -it --rm --name coe2mqtt -v coe2mqtt.conf:/etc/coe2mqtt.conf docker.io/gbeine/coe2mqtt
```

## Configuration

The configuration is located in `/etc/coe2mqtt.conf`.

Each configuration option is also available as command line argument.

- copy `coe2mqtt.conf.example`
- configure as you like

| option               | default              | arguments               | comment                                                                                |
|----------------------|----------------------|-------------------------|----------------------------------------------------------------------------------------|
| `mqtt_host`          | 'localhost'          | `-m`, `--mqtt_host`     | The hostname of the MQTT server.                                                       |
| `mqtt_port`          | 1883                 | `--mqtt_port`           | The port of the MQTT server.                                                           |
| `mqtt_keepalive`     | 30                   | `--mqtt_keepalive`      | The keep alive interval for the MQTT server connection in seconds.                     |
| `mqtt_clientid`      | 'coe2mqtt'           | `--mqtt_clientid`       | The clientid to send to the MQTT server.                                               |
| `mqtt_user`          | -                    | `-u`, `--mqtt_user`     | The username for the MQTT server connection.                                           |
| `mqtt_password`      | -                    | `-p`, `--mqtt_password` | The password for the MQTT server connection.                                           |
| `mqtt_topic`         | 'bus/can'            | `-t`, `--mqtt_topic`    | The topic to publish MQTT message.                                                     |
| `mqtt_tls`           | -                    | `--mqtt_tls`            | Use SSL/TLS encryption for MQTT connection.                                            |
| `mqtt_tls_version`   | 'TLSv1.2'            | `--mqtt_tls_version`    | The TLS version to use for MQTT. One of TLSv1, TLSv1.1, TLSv1.2.                       |
| `mqtt_verify_mode`   | 'CERT_REQUIRED'      | `--mqtt_verify_mode`    | The SSL certificate verification mode. One of CERT_NONE, CERT_OPTIONAL, CERT_REQUIRED. |
| `mqtt_ssl_ca_path`   | -                    | `--mqtt_ssl_ca_path`    | The SSL certificate authority file to verify the MQTT server.                          |
| `mqtt_tls_no_verify` | -                    | `--mqtt_tls_no_verify`  | Do not verify SSL/TLS constraints like hostname.                                       |
| `coe_version`        | 2                    | `--coe_version`         | The CoE version to use. Currently, only V2 is supported.                               |
| `coe_bind_ip`        | -                    | `--coe_bind_ip`         | The address to listen on for CoE packages.                                             |
| `coe_bind_port`      | 5442                 | `--coe_bind_port`       | The port to listen on for CoE packages.                                                |
| `coe_peer_ip`        | -                    | `--coe_peer_ip`         | The peer address to send CoE packages.                                                 |
| `coe_peer_port`      | 5442                 | `--coe_peer_port`       | The peer's port to send CoE packages.                                                  |
| `timestamp`          | -                    | `-z`, `--timestamp`     | Publish timestamps for all topics, e.g. for monitoring purposes.                       |
| `verbose`            | -                    | `-v`, `--verbose`       | Be verbose while running.                                                              |
| -                    | '/etc/coe2mqtt.conf' | `-c`, `--config`        | The path to the config file.                                                           |
| `mqtt_subscribe`     | see below            | -                       | The configuration for the MQTT topics for forward to the CAN bus.                      |

### CAN Items

You need to configure the MQTT topics to listen for messages.
These messages will be forwarded to the CAN bus.
For each address, the CAN datatype must be specified.
The list is available with the [python-can-coe](https://c0d3.sh/smarthome/python-can-coe) package.

The list (in order of the CoEType enum in [coe](https://c0d3.sh/smarthome/python-can-coe/src/branch/main/coe/coe.py)):

- CELSIUS, temperature in degree Celsius
- WATTSM2, watts per square meter
- LITERSH, liters per hour
- SECONDS 
- MINUTES 
- LITERSP, liters per pulse
- KELVIN, temperature in degree Kelvin
- PERCENT 
- KILOWATT 
- MWHRS, megawatthours
- KWHRS, kilowatthours
- VOLTS
- MILLIAMP, milliampere
- HOURS
- DAYS
- PULSES
- KILOOHM
- KMH, kilometers per hour
- HERTZ
- LITERSM, liters per minute
- BAR

For digital addresses, use always "NONE" as a placeholder.

```
    ...
    "mqtt_subscribe": {
        "node2/analog1": "CELSIUS",
        "node22/digital10": "NONE",
        "node10/analog3": "LITERSH",
        ...
    }
    ...
```

## Support

I have not the time (yet) to provide professional support for this project.
But feel free to submit issues and PRs, I'll check for it and honor your contributions.

## License

The whole project is licensed under BSD-3-Clause license. Stay fair.
