#!/bin/bash

echo "🚀 NIC - Preparação para Publicação"
echo "===================================="

# 1. Faz o build da imagem
echo ""
echo "📦 Passo 1: Construindo a imagem..."
./build-docker.sh

if [ $? -ne 0 ]; then
    echo "❌ Erro no build! Abortando..."
    exit 1
fi

# 2. Exporta a imagem para arquivo
echo ""
echo "💾 Passo 2: Exportando imagem para arquivo..."
FILENAME="nic-$(date +%Y%m%d).tar.gz"
docker save nic:production | gzip > $FILENAME

if [ $? -eq 0 ]; then
    # Calcula o tamanho do arquivo
    SIZE=$(du -h $FILENAME | cut -f1)
    
    echo ""
    echo "✅ Imagem exportada com sucesso!"
    echo "📁 Arquivo: $FILENAME"
    echo "📏 Tamanho: $SIZE"
    echo ""
    echo "📤 Próximos passos:"
    echo "1. Faça upload do arquivo '$FILENAME' para seu site"
    echo "2. Compartilhe o link de download com seus clientes"
    echo ""
    echo "📝 Instruções para seus clientes:"
    echo "-----------------------------------"
    echo "1. Baixe o arquivo $FILENAME"
    echo "2. Instale o Docker: https://docs.docker.com/get-docker/"
    echo "3. Carregue a imagem: docker load < $FILENAME"
    echo "4. Execute: docker run -d -p 8000:8000 --name nic nic:production"
    echo "5. Acesse: http://localhost:8000"
else
    echo "❌ Erro ao exportar a imagem!"
    exit 1
fi