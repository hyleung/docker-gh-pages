#Docker image for Github Pages

This Docker image can be used to serve or export a [Jekyll](http://jekyllrb.com)-based [GitHub Pages](https://pages.github.com) site.

The image can be found [here](https://hub.docker.com/r/hyleung/gh-pages/) on Docker Hub.

To pull the image down:

    docker pull hyleung/gh-pages

## Usage
You'll use a volume mount (`-v`) to mount the Jekyll source director into the Docker container volume (`/gh-pages`) and run the container with either:

- `serve` (this is the default): start the Jekyll server
- `package` <some-base-path>: export the Jekyll site at `<some-base-path>` to `/gh-pages/export`

### To run Jekyll server:

    docker run --rm -it -v <some-path>/:/gh-pages -p 4000:4000  hyleung/gh-pages

### To export the site:

    docker run --rm -it <some-path>/:/gh-pages hyleung/gh-pages package /your/base/path  

## Docker-machine VMs

On OS X and (probably) Windows, the volume mount doesn't seem to trigger file system change notifications - which means Jekyll won't rebuild the site when you edit a file.

As a (admittedly crappy) workaround, you can try using [`docker-rsync`](https://github.com/synack/docker-rsync).

After installing `dockerRsync`:

SSH into your Docker VM:

    docker-machine ssh <env>

Create a place to rsync the docs into:

    mkdir /home/docker/gh-pages

On your host, start `docker-rsync` (probably in another terminal) *in* your `helix-docs` directory:

    docker-rsync <env> -dst /home/docker/gh-pages

SSH *back* into your Docker VM:

    docker-machine ssh <env>

Start the `gh-pages` container:

    docker run --rm -it -v /home/docker/gh-pages:/gh-pages -p 4000:4000 hyleung/gh-pages

*Note that you're mounting a volume from the **VM** into the container*.

If all goes well, `docker-rsync` will keep your local files in sync with `/home/docker/gh-pages`, which will trigger the Jekyll site rebuild process whenever you change a file.
