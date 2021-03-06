# freesurferformats
GNU R package to read and write FreeSurfer neuroimaging file formats.

![Vis](./vignettes/rgl_brain_aparc.jpg?raw=true "An aparc brain atlas visualization, created with the fsbrain R package.")


[Supported formats](#supported-formats) | [Installation](#installation) | [Documentation](#documentation) | [License](#license) | [Citation](#citation) | [Development](#development)


## A note to end users

This low-level package provides file format readers for [FreeSurfer](http://freesurfer.net) neuroimaging data. Typically, you want to access not only individual files, but datasets of subjects stored in the standardized output structure of recon-all (your $SUBJECTS_DIR) when doing neuroimaging research. In that case, I recommend to use the high-level functions from the [fsbrain package](https://github.com/dfsp-spirit/fsbrain) instead of re-inventing the wheel. The *fsbrain* package is built on top of *freesurferformats* and provides functions for working with the data of your study, including visualization of results on brain meshes.


## Supported formats

You do **not** need to have FreeSurfer installed to use this package. It implements its own readers and writers for the following file formats:

* MGH/MGZ: FreeSurfer 4-dimensional brain images or arbitrary other data. Typically a single 3D brain MRI scan or a time series of scans, or morphometry data for brain surfaces. The format is named after the Massachusetts General Hospital, and the specs are given (rather implicitely) [here in the FreeSurfer wiki](https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/MghFormat). MGZ is just a gzipped version of MGH. An example file would be `mri/T1.mgz` (containing a 3D brain volume), but also `surf/lh.area.fwhm15.fsaverage.mgh` (containing surface data mapped to standard space). This format can be read and written. Reading and writing header data is also supported, and the ras2vox matrix is computed from the header data.

* FreeSurfer *curv* format: Morphometry data for a brain surface, one scalar per vertex. Could be the thickness or area of the cerebral cortex at each mesh vertex. Several versions of this format exist, the supported version is the new, binary one (the only one that is used in current FS versions). An example file would be `surf/lh.area`. This format can be read and written.

* FreeSurfer annotation file format: Contains a cortical parcellation. A cortical parcellation originates from a brain atlas and contains a label for each vertex of a surface that assigns this vertex to one of a set of atlas regions. The file format also contains a colortable, which assigns a color code to each atlas region. An example file would be `labels/lh.aparc.annot`. This format can be read and written.

* FreeSurfer surface file format: Contains a brain surface mesh. Such a mesh is defined by a list of vertices (each vertex is given by its x,y,z coords) and a list of faces (each face is given by three vertex indices). Currently only triangular meshes are implemented. An example file would be `surf/lh.white`. This format can be read and written.

* FreeSurfer label file format: Contains a list of vertices included in a label. A label is like a mask, and is typically used to describe the vertices which are part of a certain brain region. An example file would be `label/lh.cortex.label`. This format can be read and written.

* FreeSurfer color lookup table (LUT) file format: Contains a color lookup table in ASCII format. This LUT assigns names and  RGBA color values to a set of labels. LUT data can also be extracted from an annotation, and a set of labels and a LUT can be merged into an annotation. An example file would be `FREESURFER_HOME/FreeSurferColorLUT.txt`. This format can be read and written.

* FreeSurfer *weight* file format: Contains one value per listed vertex. In contrast to curv files, weight files contain values not for all vertices of a surface, but only for a (sub)set of vertices defined by their indices. The format is known as *weight* format, *paint* format, or simply *w* format. This format can be read and written.

* FreeSurfer *patch* file format: Contains a subset of a surface (a *surface patch*), given by the vertex indices (and the faces in the ASCII version). For each patch vertex, it also stores whether the vertex is part of the patch border. This format can be read and written.

The list reflects the development version.


## Installation


The package is on [CRAN](https://CRAN.R-project.org/package=freesurferformats), so you can simply:

```r
install.packages("freesurferformats")
```

[![](https://cranlogs.r-pkg.org/badges/freesurferformats)](https://CRAN.R-project.org/package=freesurferformats)


## Documentation

### Quick Usage

Before using any functions, of course load the package itself:

```r
library("freesurferformats")
```

Now you can call the following functions:


```r
read.fs.mgh()         # read volume or morphometry data from files in MGH or MGZ format, e.g., `mri/brain.mgz` or `surf/lh.area.fwhm10.fsaverage.mgh`.
read.fs.curv()        # read morphometry data from 'curv' format files like `surf/lh.area`
read.fs.morph()       # read any morphometry file (mgh/mgz/curv). The format is derived from the file extension.
read.fs.annot()       # read annotation data or brain atlas labels from files like `label/lh.aparc.annot`
read.fs.surface()     # read a surface mesh, like `surf/lh.white`
read.fs.label()       # read a label file, like `label/lh.cortex.label`
read.fs.colortable()  # read a color lookup table (LUT), like `$FREESURFER_HOME/FreeSurferColorLUT.txt`
read.fs.weight()      # read scalar data for a subset of vertices, defined by index. Known as `weight`, `paint` or simply `w` format.
read.fs.patch()       # read a surface patch, which is a part of a surface.

write.fs.mgh()        # write data with 1 to 4 dimensions to an MGH format file
write.fs.curv()       # write a data vector to a 'curv' format file
write.fs.morph()      # write any morphometry file (mgh/mgz/curv). The format is derived from the file extension.
write.fs.surface()    # write a surface mesh
write.fs.label()      # write a label file
write.fs.annot()      # write an annotation file
write.fs.colortable() # write a color lookup table (LUT)
write.fs.weight()     # write scalar vertex data in weight or w format
write.fs.patch()      # write a surface patch, which is a part of a surface.
```

The documentation is included in the package and not repeated on this website.

### Full Documentation

The documentation can be accessed from within an R session after you have loaded the *freesurferformats* package:

* Detailed vignettes with explanations and examples for the usage of all functions of the package are included, run `browseVignettes("freesurferformats")` to see them. You can also open the vignettes directly:
  * learn how to read neuroimaging data: `vignette("freesurferformats")` [read online at CRAN](https://cran.r-project.org/web/packages/freesurferformats/vignettes/freesurferformats.html)
  * learn how to write neuroimaging data: `vignette("freesurferformats_write")` [read online at CRAN](https://cran.r-project.org/web/packages/freesurferformats/vignettes/freesurferformats_write.html)
  * learn advanced header-based operations: `vignette("freesurferformats_header")` [read online at CRAN](https://cran.r-project.org/web/packages/freesurferformats/vignettes/freesurferformats_header.html)
* Help for a specific function can be accessed in the usual R manner: `?<function>`, where you replace `<function>` with a function name. Like this: `?read.fs.mgh`.
* Run `example(<function>)` to see a live demo that uses the function `<function>`. Like this: `example(read.fs.mgh)`.
* The [unit tests](./tests/testthat/) that come with this package are essentially a list of examples that illustrate how to use the functions.

### An example R session: Reading Bert's brain

One of the example subjects that comes with FreeSurfer is `bert`. The following example shows how to load Bert's brain. If you have FreeSurfer installed, you can start GNU R by typing `R` in your favourite terminal application and run the following commands:

```r
install.packages("freesurferformats")

# Load volume from file
library("freesurferformats")
berts_brain = paste(Sys.getenv("FREESURFER_HOME"), "/subjects/bert/mri/brain.mgz", sep="")
mgh = read.fs.mgh(berts_brain, with_header=TRUE);

# Inspect the header:
mgh$header$vox2ras_matrix
#     [,1] [,2] [,3]      [,4]
#[1,]   -1    0    0  133.3997
#[2,]    0    0    1 -110.0000
#[3,]    0   -1    0  128.0000
#[4,]    0    0    0    1.0000

# ...and the data:
mean(mgh$data)
#[1] 8.214322
dim(drop(mgh$data))
# [1] 256 256 256
```

If you do not have FreeSurfer installed and thus don't have Bert, replace `berts_brain` with the example brain that comes with freesurferformats:

```r
fsf_brain = system.file("extdata", "brain.mgz", package = "freesurferformats", mustWork = TRUE);
```

## License

The *freesurferformats* package is [free software](https://en.wikipedia.org/wiki/Free_software), published under the [MIT license](https://opensource.org/licenses/MIT).

Note: The file LICENSE in this repository is a CRAN license template only (as required by CRAN) and does not contain the full MIT  license text. See the file [LICENSE_FULL](./LICENSE_FULL) for the full license text.


## Citation

You can generate the citation for the version you use by typing the following command in R:

```
citation("freesurferformats")
```

This will ouput something like this (but for the version you actually used, which is important for reproducibility):
```
To cite package ‘freesurferformats’ in publications use:

  Tim Schäfer (2019). freesurferformats: Read and Write 'FreeSurfer'
  Neuroimaging File Formats. R package version 0.1.6.
  https://CRAN.R-project.org/package=freesurferformats

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {freesurferformats: Read and Write 'FreeSurfer' Neuroimaging File Formats},
    author = {Tim Schäfer},
    year = {2019},
    note = {R package version 0.1.6},
    url = {https://CRAN.R-project.org/package=freesurferformats},
    doi = {10.5281/zenodo.3540434},
    url = {https://dx.doi.org/10.5281/zenodo.3540434},
  }
```

The Digital Object Identifier (DOI) for *freesurferformats* is: [10.5281/zenodo.3540434](https://dx.doi.org/10.5281/zenodo.3540434)

Note that this DOI always points to the latest version, so be sure to still include the package version in the citation. 

## Development

### Installing the development version

You can install the latest development version directly from Github if you need features which have not been released yet. Use at your own risk though, development is currently happending on master and the chance of grabbing a broken version is real. Please run the tests before using the dev version (see the *Unit tests / CI* section below).

If you do not have `devtools` and related tools installed yet:

```r
install.packages(c("devtools", "knitr", "rmarkdown", "testthat"));
```

Then:

```r
devtools::install_github("dfsp-spirit/freesurferformats", build_vignettes=TRUE)
```

While the development versions may have new features, you should not consider their API stable. Wait for the next release if you are not fine with adapting your code to API changes later. If in doubt, do **not** use the dev version.


### Unit tests and Continuous integration


This package comes with [lots of unit tests](./tests/testthat/). To run them, in a clean R session:

```r
library(devtools)
library(freesurferformats)
devtools::check()
```

Continuous integration results:

[![Build Status](https://travis-ci.org/dfsp-spirit/freesurferformats.svg?branch=master)](https://travis-ci.org/dfsp-spirit/freesurferformats) Travis CI under Linux

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/dfsp-spirit/freesurferformats?branch=master&svg=true)](https://ci.appveyor.com/project/dfsp-spirit/freesurferformats) AppVeyor CI under Windows

The displayed status represents the development version. Don't worry if you are using the stable version from CRAN and CI is currently failing, development happens on master.

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). 

If you have any question, suggestion or comment on freesurferformats, please [open an issue](https://github.com/dfsp-spirit/freesurferformats/issues). If you want to contact me via email, please use the maintainer email address listed on the [CRAN webpage for freesurferformats](https://cran.r-project.org/package=freesurferformats).
