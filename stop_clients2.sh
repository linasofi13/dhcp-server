#!/bin/bash

# Detener y eliminar contenedores
sudo docker stop dhcp_server dhcp_relay dhcp_client1 dhcp_client2 dhcp_client3
sudo docker rm dhcp_server dhcp_relay dhcp_client1 dhcp_client2 dhcp_client3

# Eliminar redes
sudo docker network rm dhcp_net_a dhcp_net_b
