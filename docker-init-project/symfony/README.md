# symfony

## Build image

```bash
docker build . -t symfony-installer
```

## Init project

```bash
docker run -it --rm -v ${PWD}:/app -w /app symfony-installer bash -c "symfony new demo --no-git"
```

## Init project with spesific version

```bash
docker run -it --rm -v ${PWD}:/app -w /app symfony-installer bash -c "symfony new demo --version=7.1.* --no-git"
```

## Init project with webapp feature

```bash
docker run -it --rm -v ${PWD}:/app -w /app symfony-installer bash -c "symfony new demo --version=7.1.* --no-git --webapp"
```
