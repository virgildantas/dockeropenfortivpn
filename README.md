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
    vpn.config:
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
   docker compose up
   ```

---

### Multiple VPNs

To connect to multiple VPNs simultaneously, copy the project folder, modify the `vpn.config` file, and adjust the image name in the `docker-compose.yml` file for each VPN configuration.

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
    vpn.config:
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

### Múltiplas VPNs

Para conectar múltiplas VPNs simultaneamente, copie a pasta do projeto, modifique o arquivo `vpn.config` e ajuste o nome da imagem no arquivo `docker-compose.yml` para cada configuração de VPN.

Após rodar o container, confira a tabela de rotas locais para verificar se as rotas da VPN estão configuradas.

---

This README provides clear instructions in both English and Portuguese, making the project accessible to a broader audience.