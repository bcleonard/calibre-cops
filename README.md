# calibre

This contains the docker file and all necessary files to build a docker container for calibre with cops

### Preperation
Before running the container, you'll need to have the following directories predefined on the container host:
```sh
library
addbooks
```
The library directory will hold your books & database.  addbooks will be used to add books to your library on a periodic basis.  I used:
```sh
/data/library
/data/addbooks
```
for the instructions below.  Just make sure you create it prior to starting the container.
### To run the container:
```sh
docker run -v /data:/data -p 8080:8080 bcleonard/calibre-cops
```
### Notes:

