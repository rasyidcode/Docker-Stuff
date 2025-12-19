# Laravel Installer

Simple docker image to install laravel project.

## How to build

```bash
docker build . -t laravel-installer
```

## How to initialized a Laravel project with the image

```bash
cd /path/to/init/laravel/app
docker run -it --rm -v $PWD:/app -w /app laravel-installer bash # go to inside the container to run laravel command
laravel new example-app
exit
cd example-app
```