% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_fs_mgh.R
\name{guess.filename.is.gzipped}
\alias{guess.filename.is.gzipped}
\title{Guess whether a file is gzipped.}
\usage{
guess.filename.is.gzipped(filepath, gz_extensions = c(".gz", ".mgz"))
}
\arguments{
\item{filepath}{string. Path to a file.}

\item{gz_extensions}{list of strings. A list of suffixes that is considered indicative for the file being gzipped. Defaults to c(".gz", ".mgz"). Case does not matter.}
}
\value{
logical, whether this function thinks the file is gzipped.
}
\description{
Guess whether a file is gzipped, based on the file extension.
}
\keyword{internal}
