# Jupyter-PHP Docker Image

This uses the [Jupyter-PHP](https://github.com/Litipk/Jupyter-PHP)
project to load a PHP kernel in [Jupyter](http://jupyter.org/).

```bash
docker pull benramsey/jupyter-php
```

## Running Jupyter

Run the following command. It will print out a `127.0.0.1` address that
you may use to open the Jupyter notebooks in a browser.

```bash
docker run --rm -p 8888:8888 benramsey/jupyter-php:latest
```

To use and save notebooks on your host machine, connect a volume to
`/home/jovyan/work` in the container.

```bash
docker run --rm -p 8888:8888 -v "$PWD":/home/jovyan/work benramsey/jupyter-php:latest
```

To run the example notebooks from this repository:

```bash
git clone https://github.com/ramsey/jupyter-php-docker.git
cd jupyter-php-docker
docker run --rm -p 8888:8888 -v "$PWD/examples":/home/jovyan/work benramsey/jupyter-php:latest
```
