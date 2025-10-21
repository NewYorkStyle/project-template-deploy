FROM nginx:alpine

# Копируем конфигурацию
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Создаем папку для статики
RUN mkdir -p /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]