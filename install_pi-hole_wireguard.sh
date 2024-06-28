#!/bin/bash

# Farben für die Ausgabe definieren
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# SGNetz ASCII-Art
echo -e "${GREEN}
  _____ _____ _   _ _   _ _______ 
 / ____|_   _| \\ | | \\ | |__   __|
| (___   | | |  \\| |  \\| |  | |   
 \\___ \\  | | | . \` | . \` |  | |   
 ____) |_| |_| |\\  | |\\  |  | |   
|_____/|_____|_| \\_|_| \\_|  |_|   
${NC}"
echo -e "${GREEN}✨ Willkommen zu SGNetz! ✨${NC}"
echo -e "${GREEN}Beginn der Installation von Pi-hole und WireGuard...${NC}"

# Update und Upgrade des Systems
echo -e "${GREEN}System wird aktualisiert...${NC}"
sudo apt-get update && sudo apt-get upgrade -y

# Installation von Pi-hole
echo -e "${GREEN}Pi-hole wird installiert...${NC}"
curl -sSL https://install.pi-hole.net | bash

# Pi-hole auf Port 8080 konfigurieren
echo -e "${GREEN}Konfiguration von Pi-hole auf Port 8080...${NC}"
sudo sed -i 's/80/8080/g' /etc/lighttpd/lighttpd.conf
sudo systemctl restart lighttpd

# Installation von Caddy
echo -e "${GREEN}Caddy wird installiert...${NC}"
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /usr/share/keyrings/caddy-archive-keyring.gpg >/dev/null
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get update
sudo apt-get install caddy

# Benutzer nach der Domain und E-Mail-Adresse fragen
echo -e "${GREEN}Bitte geben Sie die Domain für das Pi-hole Webinterface an (z.B. example.com):${NC}"
read DOMAIN
echo -e "${GREEN}Bitte geben Sie Ihre E-Mail-Adresse für Let's Encrypt an:${NC}"
read EMAIL

# Caddyfile konfigurieren
echo -e "${GREEN}Konfiguration von Caddy für die Domain ${DOMAIN}...${NC}"
sudo bash -c "cat <<EOT > /etc/caddy/Caddyfile
{
    email ${EMAIL}
}

${DOMAIN} {
    reverse_proxy localhost:8080
}
EOT"

# Caddy-Dienst neu starten
sudo systemctl restart caddy

# Installation von WireGuard
echo -e "${GREEN}WireGuard wird installiert...${NC}"
sudo apt-get install wireguard qrencode -y

# WireGuard Verzeichnis erstellen und in das Verzeichnis wechseln
sudo mkdir -p /etc/wireguard
cd /etc/wireguard

# WireGuard-Schlüssel generieren
echo -e "${GREEN}WireGuard-Schlüssel werden generiert...${NC}"
umask 077
wg genkey | tee server_privatekey | wg pubkey > server_publickey

SERVER_PRIVATE_KEY=$(cat server_privatekey)
SERVER_PUBLIC_KEY=$(cat server_publickey)

# Client-Schlüssel generieren
wg genkey | tee client_privatekey | wg pubkey > client_publickey

CLIENT_PRIVATE_KEY=$(cat client_privatekey)
CLIENT_PUBLIC_KEY=$(cat client_publickey)

# Server-IP ermitteln
SERVER_IP=$(curl -s ifconfig.me)

# Server-Konfiguration erstellen
SERVER_CONF="[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = $SERVER_PRIVATE_KEY
DNS = 127.0.0.1

[Peer]
PublicKey = $CLIENT_PUBLIC_KEY
AllowedIPs = 10.0.0.2/32
"
echo "$SERVER_CONF" | sudo tee /etc/wireguard/wg0.conf

# Client-Konfiguration erstellen
CLIENT_CONF="[Interface]
PrivateKey = $CLIENT_PRIVATE_KEY
Address = 10.0.0.2/24
DNS = 10.0.0.1

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_IP:51820
AllowedIPs = 0.0.0.0/0
"
echo "$CLIENT_CONF" | sudo tee /etc/wireguard/client.conf

# IP-Forwarding aktivieren
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p

# iptables konfigurieren, um den Verkehr über das VPN zu leiten
echo -e "${GREEN}Konfiguration von iptables...${NC}"
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables/rules.v4"

# WireGuard-Dienst starten und aktivieren
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0

# QR-Code für die Client-Konfiguration generieren und anzeigen
echo -e "${GREEN}Client-Konfiguration wird erstellt und QR-Code generiert...${NC}"
qrencode -t ansiutf8 < /etc/wireguard/client.conf

echo -e "${GREEN}Installation abgeschlossen! Verbinden Sie sich mit Ihrem VPN, um werbefrei zu surfen.${NC}"
