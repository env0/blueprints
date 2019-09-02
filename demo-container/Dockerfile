FROM nginx:alpine
COPY index.html /usr/share/nginx/html
COPY run.sh .

ENV CLIENT_NAME=Demo
ENV CLIENT_LOGO_URL=https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Logo_TV_2015.svg/1200px-Logo_TV_2015.svg.png

CMD ["./run.sh"]
