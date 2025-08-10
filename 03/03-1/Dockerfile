FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo '<!DOCTYPE html>\
<html lang="ru">\
<head>\
    <meta charset="UTF-8">\
    <meta name="viewport" content="width=device-width, initial-scale=1.0">\
    <title>Hello world!</title>\
    <style>\
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f0f0f0; }\
        .container { background: white; padding: 50px; border-radius: 10px; display: inline-block; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }\
        h1 { color: #333; margin-bottom: 20px; }\
        p { color: #666; font-size: 18px; }\
    </style>\
</head>\
<body>\
    <div class="container">\
        <h1>You are welcome!</h1>\
        <p><strong>Family </strong> Lytvynenko</p>\
        <p><strong>Name </strong> Artem</p>\
    </div>\
</body>\
</html>' > /var/www/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
