# Project Deployment

Полная установка проекта с Docker Compose.

## Требования

- Docker
- Docker Compose

## Состав стека (Docker Compose)

| Сервис    | Назначение |
|-----------|------------|
| `nginx`   | Reverse proxy, статика, Allure на `:8888` |
| `frontend` | Образ фронтенда |
| `backend` | API; health на `3000/health` |
| `database` | PostgreSQL 15, порт **5432** |
| `redis`   | Redis 7 (AOF), порт **6379** |

Переменная `REDIS_URL` задаётся в `.env` (см. `.example.env`); для контейнеров backend используйте хост `redis`, как в шаблоне.

## Быстрый старт

1. Скопируйте `.example.env` в `.env` и при необходимости поправьте значения (в т.ч. `REDIS_URL`).

2. Клонируйте репозитории фронтенда и бэкенда:
```bash
# Рядом с этой папкой
git clone <frontend-repo-url> ../project-template-front
git clone <backend-repo-url> ../project-template-back
```