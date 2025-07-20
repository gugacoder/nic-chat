#!/bin/bash
# Este script mata todos os processos rodando nas portas 3000 e 8000.

echo "Tentando liberar a porta 3000..."
fuser -k 3000/tcp

echo "Tentando liberar a porta 8000..."
fuser -k 8000/tcp

echo "Script finalizado."
