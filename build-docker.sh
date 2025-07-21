#!/bin/bash

# Build otimizado da imagem Docker do NIC Chat
echo "🔨 Iniciando build otimizado do NIC..."

# Captura o hash do commit atual
BUILD_HASH=$(git rev-parse HEAD)
echo "📌 Build hash: $BUILD_HASH"

# Define a tag da imagem
IMAGE_NAME="nic"
IMAGE_TAG="production"

# Executa o build
echo "🐳 Construindo imagem Docker..."
docker build \
  --build-arg BUILD_HASH=$BUILD_HASH \
  --build-arg USE_CUDA=false \
  --build-arg USE_OLLAMA=false \
  -t ${IMAGE_NAME}:${IMAGE_TAG} \
  -t ${IMAGE_NAME}:latest \
  .

# Verifica se o build foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "✅ Build concluído com sucesso!"
    echo "📦 Imagem gerada: ${IMAGE_NAME}:${IMAGE_TAG}"
    echo ""
    echo "Para executar o container:"
    echo "docker run -d \\"
    echo "  -p 8000:8000 \\"
    echo "  -v nic-data:/app/backend/data \\"
    echo "  --name nic \\"
    echo "  --restart always \\"
    echo "  ${IMAGE_NAME}:${IMAGE_TAG}"
else
    echo "❌ Erro durante o build!"
    exit 1
fi