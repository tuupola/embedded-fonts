## FONTX2 fonts for embedded projects

This repository contains the classic public domain X Window System bitmap fonts in [FONTX2](http://elm-chan.org/docs/dosv/fontx_e.html) format. Both [C header files](X11/include/) and separate [binary files](X11/fontx2/) are provided.

The ISO 10646-1 source files were downloaded from [Dr Markus Kuhn's page](https://www.cl.cam.ac.uk/~mgk25/ucs-fonts.html). The 8-bit encoding variants were generated with the probided Makefile:

```
$ mkdir ucs-fonts
$ cd ucs-fonts
$ wget https://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts.tar.gz
$ wget https://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts-asian.tar.gz
$ tar -xzvf *.tar.gz
$ cd submission
$ make all-bdfs
```

To generate all files by yourself, first install [FONTX2 tools](https://github.com/tuupola/fontx2_tools).

```
$ git clone git@github.com:tuupola/fontx2_tools.git
$ cd fontx2_tools
$ make && make install
```

And then regenerate everything.

```
$ git clone https://github.com/tuupola/fonts
$ cd fonts
$ make
```
