#!/bin/bash
set -e
# Устанавливаем права на сам скрипт если нужно
if [ ! -x "$0" ]; then
    chmod +x "$0"
fi

SERVICE=${1:-all}

echo "🚀 Starting deploy for: $SERVICE"

cd /home/deployer/project-template-deploy

echo "📥 Updating deploy repository..."
git fetch origin
git reset --hard origin/master

case $SERVICE in
    "backend")
        echo "🔧 Deploying backend..."

        docker compose pull backend
        docker compose up -d backend
        ;;

    "frontend")
        echo "🎨 Deploying frontend..."

        docker compose pull frontend
        docker compose up -d frontend
        ;;

    "all")
        echo "🔄 Deploying all services..."

        docker compose pull
        docker compose up -d
        ;;

    *)
        echo "❌ Unknown service: $SERVICE"
        exit 1
        ;;
esac

echo "✅ Deploy completed for: $SERVICE"

docker system prune -f