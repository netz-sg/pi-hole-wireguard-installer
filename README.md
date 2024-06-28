![Pi-hole Logo]([https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Pi-hole_logo.png/120px-Pi-hole_logo.png](https://upload.wikimedia.org/wikipedia/commons/0/00/Pi-hole_Logo.png))

# 🌐 Pi-hole und WireGuard Installer für Debian-basierte Cloud-Server

Dieses Skript installiert Pi-hole und WireGuard auf einem Debian-basierten Cloud-Server. Mit dieser Konfiguration können Sie sich über ein VPN mit dem Server verbinden, der Pi-hole als DNS-Server verwendet, um Werbung zu blockieren.

## 🚀 Voraussetzungen

- Debian-basierter Server (z.B. Debian, Ubuntu)
- Root-Zugriff auf den Server

## 🛠️ Installation

1. **Klonen Sie dieses Repository auf Ihren Server:**

    ```bash
    git clone https://github.com/netz-sg/pi-hole-wireguard-installer.git
    cd pi-hole-wireguard-installer
    ```

2. **Machen Sie das Skript ausführbar:**

    ```bash
    chmod +x install_pi-hole_wireguard.sh
    ```

3. **Führen Sie das Skript aus:**

    ```bash
    sudo ./install_pi-hole_wireguard.sh
    ```

Das Skript führt die folgenden Schritte aus:

1. Aktualisiert das System.
2. Installiert Pi-hole.
3. Installiert WireGuard und generiert die notwendigen Schlüssel.
4. Konfiguriert WireGuard, um den gesamten Verkehr über den Server zu leiten.
5. Aktiviert IP-Forwarding und konfiguriert iptables.
6. Startet den WireGuard-Dienst und aktiviert ihn beim Booten.
7. Erstellt eine Client-Konfigurationsdatei und zeigt einen QR-Code für die einfache Verbindung an.

## 🌐 Verwendung

Nach der Installation:

1. **Scannen Sie den angezeigten QR-Code mit Ihrem WireGuard-Client, um die VPN-Verbindung zu konfigurieren.**
2. **Verbinden Sie sich mit dem VPN.**
3. **Surfen Sie werbefrei im Internet!**

## 🔧 Fehlerbehebung

Sollten während der Installation oder Verwendung Probleme auftreten, überprüfen Sie die Logs und stellen Sie sicher, dass alle Schritte korrekt ausgeführt wurden. Bei Bedarf können Sie das Skript erneut ausführen oder sich an die Dokumentation von Pi-hole und WireGuard wenden.

## 📜 Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert. Weitere Informationen finden Sie in der `LICENSE`-Datei.

---

Mit ❤️ von [netz-sg](https://github.com/netz-sg)
