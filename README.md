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
