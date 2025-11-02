#!/bin/bash

# Para o script imediatamente se qualquer comando falhar
set -e

echo "➡️  Iniciando setup do ambiente Docker..."

# 1. Constrói as imagens (se necessário)
echo "📦 Construindo imagens Docker..."
docker compose build

# 2. Sobe o container do banco de dados em background
echo "🐘 Iniciando container do banco de dados..."
docker compose up -d db

# 3. Cria o banco de dados
echo "⚙️  Criando o banco de dados (db:create)..."
docker compose run --rm web ./bin/rails db:create # <--- MUDANÇA AQUI

# 4. Roda as migrações
echo "🏃 Rodando migrações (db:migrate)..."
docker compose run --rm web ./bin/rails db:migrate # <--- MUDANÇA AQUI

# 5. (Opcional) Popula o banco com dados de seed
# echo "🌱 Populando o banco (db:seed)..."
# docker compose run --rm web ./bin/rails db:seed

# 6. Para todos os containers
echo "🛑 Parando containers de setup..."
docker compose down

echo "✅ Setup concluído com sucesso!"
echo ""
echo "🚀 Para iniciar seu servidor, rode agora:"
echo "docker compose up"