#!/bin/bash
# gerado pelo chat GPT
# by ChatGPT
# Função para detectar o sistema operacional
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo $ID
    else
        echo "Sistema operacional não identificado."
        exit 1
    fi
}

# Função para instalar o Docker em sistemas Debian/Ubuntu/Pop!_OS
install_docker_debian() {
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/$1/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$1 $(lsb_release -cs) stable"
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}

# Função para instalar o Docker em CentOS
install_docker_centos() {
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Função para instalar o Docker em Fedora
install_docker_fedora() {
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Detecta o sistema operacional e instala o Docker
OS=$(detect_os)
case $OS in
    ubuntu|pop|debian)
        echo "Sistema identificado: $OS. Instalando Docker..."
        install_docker_debian $OS
        ;;
    centos)
        echo "Sistema identificado: CentOS. Instalando Docker..."
        install_docker_centos
        ;;
    fedora)
        echo "Sistema identificado: Fedora. Instalando Docker..."
        install_docker_fedora
        ;;
    *)
        echo "Sistema operacional $OS não é suportado por este script."
        exit 1
        ;;
esac

# Adiciona o usuário atual ao grupo docker
echo "Adicionando o usuário $(whoami) ao grupo docker..."
sudo usermod -aG docker $(whoami)

# Exibe uma mensagem final de instrução
echo "Instalação concluída! Faça logout e login novamente para executar o Docker sem sudo."
