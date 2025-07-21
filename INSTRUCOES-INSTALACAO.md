# NIC Chat - Instruções de Instalação

## Para Windows

### 1. Instale o Docker
- Baixe o Docker Desktop: https://docs.docker.com/desktop/install/windows-install/
- Execute o instalador e reinicie o computador quando solicitado

### 2. Carregue a imagem do NIC
- Abra o PowerShell ou Prompt de Comando
- Navegue até onde baixou o arquivo (exemplo: `cd Downloads`)
- Execute:
```
docker load < nic-20240121.tar.gz
```

### 3. Execute o NIC
```
docker run -d -p 8000:8000 --name nic --restart always nic:production
```

### 4. Acesse o NIC
Abra o navegador e acesse: http://localhost:8000

---

## Para Linux/Mac

### 1. Instale o Docker
```bash
# Linux
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Mac
# Baixe em: https://docs.docker.com/desktop/install/mac-install/
```

### 2. Carregue a imagem
```bash
docker load < nic-20240121.tar.gz
```

### 3. Execute o NIC
```bash
docker run -d -p 8000:8000 --name nic --restart always nic:production
```

### 4. Acesse
http://localhost:8000

---

## Comandos Úteis

**Parar o NIC:**
```
docker stop nic
```

**Iniciar o NIC:**
```
docker start nic
```

**Ver logs:**
```
docker logs nic
```

**Remover completamente:**
```
docker stop nic
docker rm nic
```

## Requisitos Mínimos
- 4GB de RAM
- 10GB de espaço em disco
- Windows 10/11, Ubuntu 20.04+, ou macOS 10.15+

## Suporte
Em caso de dúvidas, entre em contato com o suporte.