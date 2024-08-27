FROM nginx:latest

RUN apt-get update && apt-get install -y wget

COPY ./demo-app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]