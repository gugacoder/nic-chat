#!/bin/bash

if [ -n "$1" ]; then
  PORT=$1
  echo "Tentando liberar a porta $PORT..."
  fuser -k "$PORT"/tcp
else
  echo "Nenhuma porta especificada. Executando o procedimento padrão."
  echo "Tentando liberar a porta 3000..."
  fuser -k 3000/tcp

  echo "Tentando liberar a porta 8000..."
  fuser -k 8000/tcp
fi

echo "Script finalizado."