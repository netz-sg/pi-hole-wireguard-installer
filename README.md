<img src="https://upload.wikimedia.org/wikipedia/commons/0/00/Pi-hole_Logo.png" alt="Pi-hole Logo" width="100"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Logo_of_WireGuard.svg/1200px-Logo_of_WireGuard.svg.png" alt="WireGuard Logo" width="100"/>
<img src="https://dqah5woojdp50.cloudfront.net/original/2X/5/5f2c1a30bf4aeec78ece52d64426ec606d9fee7d.png" alt="Caddy Logo" width="100"/>

# 🌐 Pi-hole und WireGuard Installer für Debian-basierte Cloud-Server

Dieses Skript installiert Pi-hole und WireGuard auf einem Debian-basierten Cloud-Server. Mit dieser Konfiguration kannst du dich über ein VPN mit dem Server verbinden, der Pi-hole als DNS-Server verwendet, um Werbung zu blockieren. Außerdem wird Caddy als Reverse Proxy verwendet, um das Pi-hole-Webinterface mit Let's Encrypt TLS-Zertifikaten abzusichern.

## 🚀 Voraussetzungen

- Debian-basierter Server (z.B. Debian, Ubuntu)
- Root-Zugriff auf den Server

## 🛠️ Installation

1. **Klonen dieses Repository auf deinen Server:**

    ```bash
    git clone https://github.com/netz-sg/pi-hole-wireguard-installer.git
    cd pi-hole-wireguard-installer
    ```

2. **Skript ausführbar machen:**

    ```bash
    chmod +x install_pi-hole_wireguard.sh
    ```

3. **Skript ausführen:**

    ```bash
    sudo ./install_pi-hole_wireguard.sh
    ```

Das Skript führt die folgenden Schritte aus:

1. **System wird aktualisiert.**
2. **Pi-hole wird installiert.**
3. **Pi-hole wird auf Port 8080 konfiguriert.**
4. **Caddy wird installiert und als Reverse Proxy konfiguriert, um das Pi-hole-Webinterface mit Let's Encrypt TLS-Zertifikaten abzusichern.**
5. **WireGuard wird installiert und die notwendigen Schlüssel werden generiert.**
6. **WireGuard wird konfiguriert, um den gesamten Verkehr über den Server zu leiten.**
7. **IP-Forwarding wird aktiviert und iptables wird konfiguriert.**
8. **Der WireGuard-Dienst wird gestartet und beim Booten aktiviert.**
9. **Eine Client-Konfigurationsdatei wird erstellt und ein QR-Code für die einfache Verbindung wird angezeigt.**

## 🌐 Verwendung

Nach der Installation:

1. **Scanne den angezeigten QR-Code mit deinem WireGuard-Client, um die VPN-Verbindung zu konfigurieren.**
2. **Verbinde dich mit dem VPN.**
3. **Surfe werbefrei im Internet!**

## 🔧 Fehlerbehebung

Sollten während der Installation oder Verwendung Probleme auftreten, überprüfe die Logs und stelle sicher, dass alle Schritte korrekt ausgeführt wurden. Bei Bedarf kannst du das Skript erneut ausführen oder dich an die Dokumentation von Pi-hole, WireGuard und Caddy wenden.

## 📜 Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert. Weitere Informationen findest du in der `LICENSE`-Datei.

---

Mit ❤️ von [netz-sg](https://github.com/netz-sg)
