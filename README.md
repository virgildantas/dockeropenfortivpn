### README.md

---

# VPN Container Project

## English

### Overview
This project offers a solution to establish VPN connections using a container, eliminating the need to install FortiClient on the local machine. It is particularly useful for:
- Users who experience issues with FortiClient.
- Individuals needing multiple VPNs connected to different locations simultaneously.

If Docker is not installed, you can install it by running the provided script:  
```bash
./Install_Docker.sh
```

After ensuring Docker is installed, follow the steps below to configure and run the VPN container.

---

### Configuration

1. **Edit the `vpn.config` file**:
    ```plaintext
    host = 0.0.0.0
    port = 443
    username = user.vpn
    password = password_change
    set-dns = 0
    pppd-use-peerdns = 0
    ```

    - **host**: VPN connection IP address.
    - **port**: Port used for the VPN connection.
    - **username**: VPN username.
    - **password**: VPN password.

2. **Build the Docker image**:
   ```bash
   docker compose build
   ```

3. **Run the container to establish the VPN**:
   ```bash
   docker compose up -d
   ```

---

### Multiple VPNs Setup

To connect to multiple VPNs simultaneously, modify the `docker-compose.yml` file by adding additional services like this:

```yaml
version: "3.7"

services:
  vpn01:
    container_name: vpn01
    build:
      context: .
      dockerfile: Dockerfile
    image: vpnbase
    environment:
      - VPNFILE=vpn01.config
    network_mode: "host"
    privileged: true
    volumes:
      - type: bind
        source: ./
        target: /root

  vpn02:
    container_name: vpn02
    build:
      context: .
      dockerfile: Dockerfile
    image: vpnbase
    environment:
      - VPNFILE=vpn02.config
    network_mode: "host"
    privileged: true
    volumes:
      - type: bind
        source: ./
        target: /root
```

After correctly pointing to the VPN files, build the image again:
```bash
docker compose build
```

To run only one VPN:
```bash
docker compose up -d vpn01
```

Or to run all configured VPNs at once:
```bash
docker compose up -d 
```

After running the container, check the local routing table to confirm the configured VPN routes are active.

---

---

## Português

### Visão Geral
Este projeto oferece uma solução para estabelecer conexões VPN utilizando um container, sem a necessidade de instalar o FortiClient na máquina local. É especialmente útil para:
- Usuários com problemas no FortiClient.
- Quem precisa conectar múltiplas VPNs a diferentes locais simultaneamente.

Caso o Docker não esteja instalado, execute o script abaixo para instalá-lo:  
```bash
./Install_Docker.sh
```

Após garantir que o Docker está instalado, siga os passos abaixo para configurar e rodar o container VPN.

---

### Configuração

1. **Edite o arquivo `vpn.config`**:
    ```plaintext
    host = 0.0.0.0
    port = 443
    username = user.vpn
    password = password_change
    set-dns = 0
    pppd-use-peerdns = 0
    ```

    - **host**: Endereço IP da conexão VPN.
    - **port**: Porta utilizada para a VPN.
    - **username**: Nome de usuário da VPN.
    - **password**: Senha da VPN.

2. **Gere a imagem Docker**:
   ```bash
   docker compose build
   ```

3. **Execute o container para fechar a VPN**:
   ```bash
   docker compose up -d
   ```

---

### Configuração de Múltiplas VPNs

Para conectar múltiplas VPNs simultaneamente, modifique o arquivo `docker-compose.yml` adicionando novos serviços conforme abaixo:

```yaml
version: "3.7"

services:
  vpn01:
    container_name: vpn01
    build:
      context: .
      dockerfile: Dockerfile
    image: vpnbase
    environment:
      - VPNFILE=vpn01.config
    network_mode: "host"
    privileged: true
    volumes:
      - type: bind
        source: ./
        target: /root

  vpn02:
    container_name: vpn02
    build:
      context: .
      dockerfile: Dockerfile
    image: vpnbase
    environment:
      - VPNFILE=vpn02.config
    network_mode: "host"
    privileged: true
    volumes:
      - type: bind
        source: ./
        target: /root
```

Após apontar os arquivos corretos, gere a imagem novamente:
```bash
docker compose build
```

Para rodar apenas uma VPN:
```bash
docker compose up -d vpn01
```

Ou para rodar todas as VPNs configuradas:
```bash
docker compose up -d
```

Depois de rodar o container, confira a **tabela de rotas** para verificar se as rotas da VPN estão configuradas.

---

Agora você tem uma solução prática para gerenciar várias VPNs simultaneamente usando Docker!