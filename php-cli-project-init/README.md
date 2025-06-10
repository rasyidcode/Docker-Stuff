# project-installer

## How to build

```bash
$ docker build . -t slim4-oauth2-demo-project-installer
```

## How to run

```bash
$ docker run -it --rm -v ${PWD}:/srv/project -w /srv/project slim4-oauth2-demo-project-installer composer init
```
