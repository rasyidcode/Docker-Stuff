# Bind mounts

The docs says bind mounts has been around since early days of Docker and also have limited functionality compared to volumes, but I don't care with what the limition is.

## Choose the -v or --mount flag

for me, it does almost the same thing, the only different thing is in the syntax and some directory creation stuff.

## Difference between -v and --mount behaviour

So the **-v** will create the directory if it does not exist on host machine but that directory has *root* permission. I have checked that like this:
```text
-rw-rw-r-- 1 rcd  rcd  2848 Agu  7 20:37 README.md
drwxrwxr-x 2 rcd  rcd  4096 Agu  7 19:30 target
drwxr-xr-x 2 root root 4096 Agu  7 20:04 target2
```
that *target2* directory is created by docker and it has **root** permission.

But the **--mount** will throw an error if we try to mount a directory that does not exist on the host machine.
```bash
docker run -it --name devtest3 --mount type=bind,source="$(pwd)"/target3,target=/app nginx:latest
```
that **target3** does not exist, and throwed something like this:
```text
er: Error response from daemon: invalid mount config for type "bind": bind source path does not exist: /home/rcd/My-Work/Docker-Stuff/bind-mount-example/target3.
```

## Start a container with a bind mount

**testing the --mount**
first thing first, I need a target directory with some sample file that has a hello world text, if we don't have the target dir, docker would not create it automatically just like the docs says.
```bash 
mkdir target
touch target/test.txt
echo "hello, world" >> target/test.txt
```
then, I run the following docker command:
```bash
docker run -d \
  -it \
  --name devtest \
  --mount type=bind,source="$(pwd)"/target,target=/app \
  nginx:latest
```
and the docs tells me to verify the mounts by looking into the "Mounts" section with the following commands:
```bash
docker inspect devtest
```
then I saw something like this:
```text
"Mounts": [
    {
        "Type": "bind",
        "Source": "/home/rcd/My-Work/Docker-Stuff/bind-mount-example/target",
        "Destination": "/app",
        "Mode": "",
        "RW": true,
        "Propagation": "rprivate"
    }
],
```
I don't really know what happend but I assume it mounted successfully. Then I tried doing something like this:
```bash
docker exec -it devtest cat /app/test.txt
```
then, it printed the "hello, world" text just like in the host machine, that's great. But what if we modify the file, I wonder what would happend.
```bash
echo "hello, world again" >> target/test.txt
docker exec -it devtest cat /app/test.txt
```
it reflected the changes from the host machine, that's cool.

so the **--mount** is great, but as the docs said it comes with the limitation, so far I don't know what the *limitation* he is talking about but it does the job done.

**testing the -v**
```bash
docker run -d \
    -it \
    --name devtest \
    -v "$(pwd)"/target:/app \
    nginx:latest
```
