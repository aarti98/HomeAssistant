# Dockerfile
FROM python:3.8-slim-buster as builder

# installing a test software
# RUN apt-get update && apt-get install net-tools -y

# install nginx
# RUN apt-get update && apt-get install nginx vim -y --no-install-recommends
# RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#     && ln -sf /dev/stderr /var/log/nginx/error.log

# RUN apt-get -y install libcurl4-openssl-dev libssl-dev
# RUN apt-get -y install build-essential ca-certificates
# RUN apt-get -y install libx11-xcb1
# RUN apt-get -y install libgbm-dev
# RUN apt-get -y install assimp-utils
RUN apt-get update \
    && apt-get install net-tools -y  --no-install-recommends \
        git \
        net-tools \
        nginx \
        vim \
        libcurl4-openssl-dev \
        libssl-dev \
        build-essential \
        ca-certificates \
        libx11-xcb1 \
        libgbm-dev \
        assimp-utils \
        gconf-service \
        libasound2 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgcc1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        fonts-liberation \
        libappindicator1 \
        libnss3 \
        lsb-release \
        xdg-utils \
        wget \
        xvfb \
        x11vnc \
        x11-xkb-utils \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        x11-apps \
        libgbm-dev \
        libgdal-dev \
        libdbus-glib-1-dev \
        libgirepository1.0-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
# RUN apt-get install python3.8-dev libmysqlclient-dev
RUN mkdir -p /opt/app \
    && mkdir -p /opt/app/pip_cache \
    && mkdir -p /opt/app/home_assistant \
    && mkdir -p /opt/app/dae_tmp_files
COPY requirements.txt startup.sh /opt/app/
COPY .pip_cache /opt/app/pip_cache/
COPY . /opt/app/home_assistant/
WORKDIR /opt/app/
ENV PYTHONHTTPSVERIFY 0
RUN pip install -r requirements.txt --cache-dir /opt/app/pip_cache 
RUN chmod +x startup.sh 
RUN apt-get -y install wget 
RUN chown -R www-data:www-data /opt/app
RUN chmod -R 777 /opt/app 
# RUN chmod +x startup.sh
# RUN apt-get -y install wget
# RUN pip install -r requirements.txt --cache-dir /opt/app/pip_cache
# RUN pip3 install certifi
# RUN pip install git+https://github.com/narenchoudhary/django-indian-numbers#egg=django-indian-numbers --cache-dir /opt/app/pip_cache
# RUN chown -R www-data:www-data /opt/app
# RUN chmod -R 777 /opt/app
# RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}')
# start server
# EXPOSE 8000
STOPSIGNAL SIGTERM
# HEALTHCHECK CMD curl --fail http://localhost:8003/ || kill 1
# CMD ["/opt/app/startup.sh"]

CMD [ "python", "home_assistant/manage.py", "runserver" , "0.0.0.0:8000"]