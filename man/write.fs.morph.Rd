% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_fs_curv.R
\name{write.fs.morph}
\alias{write.fs.morph}
\title{Write morphometry data in a format derived from the given file name (the file extension).}
\usage{
write.fs.morph(filepath, data)
}
\arguments{
\item{filepath, }{string. The full file name. The format to use will be derived from the last characters, the suffix. Supported suffixes are "mgh" for MGH format, "mgz" for MGZ format, everything else will be treated as curv format.}

\item{data, }{numerical vector. The data to write.}
}
\value{
format, string. The format that was used to write the data. One of c("mgh", "mgz", "curv").
}
\description{
Given data and a morphometry file name, derive the proper format and write the file.
}
\seealso{
Other morphometry functions: \code{\link{fs.get.morph.file.ext.for.format}},
  \code{\link{fs.get.morph.file.format.from.filename}},
  \code{\link{read.fs.curv}}, \code{\link{read.fs.mgh}},
  \code{\link{read.fs.morph}},
  \code{\link{read.fs.weight}},
  \code{\link{write.fs.curv}}, \code{\link{write.fs.mgh}},
  \code{\link{write.fs.weight}}
}
\concept{morphometry functions}
