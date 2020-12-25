FROM jupyter/minimal-notebook:latest

USER root

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y curl php8.0-ast php8.0-bcmath php8.0-bz2 php8.0-cli php8.0-curl php8.0-gmp php8.0-intl php8.0-mbstring php8.0-mysql php8.0-pgsql php8.0-readline php8.0-sqlite3 php8.0-zip php8.0-zmq \
    && apt-get remove -y software-properties-common \
    && apt-get autoremove -y

COPY memory.ini /etc/php/8.0/cli/conf.d/05-memory.ini
COPY composer-install.sh /usr/local/bin/composer-install.sh

# Install Composer as the jovyan user
USER $NB_UID

RUN composer-install.sh

# Switch back to root to move Composer to its proper location
USER root
RUN mv composer.phar /usr/local/bin/composer \
    && rm /usr/local/bin/composer-install.sh

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install PHP kernel for Jupyter
RUN mkdir -p /home/jovyan/.jupyter-php/pkgs \
    && mkdir -p /opt/conda/share/jupyter/kernels/jupyter-php \
    && composer init \
        --no-interaction \
        --name='jupyter/php-instance' \
        --type=project \
        --working-dir="/home/jovyan/.jupyter-php/pkgs" \
        --require='litipk/jupyter-php=0.*' \
    && composer update \
        --no-interaction \
        --no-progress \
        --prefer-dist \
        --optimize-autoloader \
        --working-dir="/home/jovyan/.jupyter-php/pkgs"

COPY kernel.json /opt/conda/share/jupyter/kernels/jupyter-php/kernel.json