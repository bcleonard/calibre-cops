# calibre-cops

This contains the docker file and all necessary files to build a docker container for COPS & Calibre.

COPS (Calibre OPDS (and HTML) PHP Server) (http://blog.slucas.fr/en/oss/calibre-opds-php-server) is a web-based light alternative to Calibre content server / Calibre2OPDS to serve ebooks (epub, mobi, pdf, ...).  

Calibre (https://calibre-ebook.com) is probably the best e-book management system out there.  This docker container will run the
server portion only.

This docker container builds upon the calibre (https://hub.docker.com/r/bcleonard/calibre) container.  It requires the calibre database (which the server builds) and is the front end.

This contains the docker file and all necessary files to build a docker container for calibre with cops

### Preperation

Before running the container, you'll need to have the following directories predefined on the container host:

```sh
library
addbooks
```

The library directory will hold your books & database.  addbooks will be used to add books to your library.  I used:

```sh
/home/books/data/library
/home/books/data/addbooks
```

for the instructions below.  Just make sure you create them prior to starting the container.

### To run the container:

```sh
docker run -d --name=calibre-cops -v /home/books/data:/data:Z -p 80:80 bcleonard/calibre-cops
```

### To access COPS:

```sh
http://<docker_host>/
```

### COPS Options:

I've added an environment variable called COPSLIBRARYNAME.  If you want to change the library name from "COPS" to something else, overwrite the variable by adding the following to your docker command line:

```sh
  --env COPSLIBARARYNAME="new_library_name"
```

I added this so you could run multiple contrainers on a single system and know which library you were viewing.

### Options

Please see the documentation for the calibre (https://hub.docker.com/r/bcleonard/calibre/) for information regarding all of the options for the container.

To list books in the library:

```sh
docker exec calibre-cops /scripts/list-books.sh
```

To remove books from the library:

```sh
docker exec calibre-cops /scripts/remove-books.sh -i <book_id>
```

### Notes/Caveats/Issues:

1.	Please see calibre (https://hub.docker.com/r/bcleonard/calibre/) for anything regarding the required container.
2.	For all options in the required container, substibute "--name=calibre-cops" for "--name="calibre"
3.      I recommend that you only pull versioned containers, not the latest.

