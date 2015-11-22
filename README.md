#Docker image for Github Pages

## Usage

### To run gh page server:
        
        docker run --rm -it -v <some-path>/:/gh-pages -p 4000:4000  hyleung/gh-pages
