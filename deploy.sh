#!/bin/bash
set -e

# Устанавливаем права на сам скрипт если нужно
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

SERVICE=${1:-all}

echo "🚀 Starting deploy for: $SERVICE"

cd /home/deployer/project-template-deploy

# Обновляем deploy репозиторий
echo "📥 Updating deploy repository..."
git fetch origin
git reset --hard origin/master

case $SERVICE in
    "backend")
        echo "🔧 Deploying backend..."
        cd ../project-template-back
        git fetch origin
        git reset --hard origin/master
        cd ../project-template-deploy
        docker compose up -d --build backend
        ;;
    "frontend")
        echo "🎨 Deploying frontend..."
        cd ../project-template-front
        git fetch origin
        git reset --hard origin/master
        cd ../project-template-deploy
        docker compose up -d --build frontend
        ;;
    "all")
        echo "🔄 Deploying all services..."

        cd ../project-template-back && git fetch origin && git reset --hard origin/master && cd -
        cd ../project-template-front && git fetch origin && git reset --hard origin/master && cd -

        cd /home/deployer/project-template-deploy

        docker compose up -d --build
        ;;
    *)
        echo "❌ Unknown service: $SERVICE"
        echo "Usage: ./deploy.sh [backend|frontend|all]"
        exit 1
        ;;
esac

echo "✅ Deploy completed for: $SERVICE"
docker system prune -f