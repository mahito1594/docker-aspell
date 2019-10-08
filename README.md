# Run `aspell` on Docker

This builds an image which contains [GNU Aspell](http://aspell.net/); install GNU Aspell v.0.60.7(released July, 2019) on Alpin Linux v3.10.
The image include English, French and German dictionaries.

## Requirements
- [Docker](https://www.docker.com)

## Install
You can pull [Docker Hub](https://hub.docker.com/r/mahito1594/aspell):

``` shell
$ docker pull mahito1594/aspell
```

## Usage
### Interactive spellcheck
I want to use this image in CI as a proofreading helper(I will do it later).
Anyway, you can use this by giving `--entrypoint` option: if you are in the directory in which document you want to spellcheck is, for example

``` shell
$ docker run --rm -it -v $PWD:/work --entrypoint=/bin/sh mahito1594/aspell
/work #  aspell check --lang en --mode tex your-document.tex (in docker container)
```

or

``` shell
$ docker run --rm -it -v $PWD:/work mahito1594/aspell check --lang en --mode tex your-document.tex
```

Of course, you can combinate with `sort`, `uniq` and so on.

### Get a list of miss-spelled words
When you want to get a list of miss-spelled words, run, for example

``` shell
$ docker run --rm -i -v $PWD:/work mahito1594/aspell list --lang en --mode tex < your-document.tex
```

## Acknowledgement
- Docker
- GNU Aspell
