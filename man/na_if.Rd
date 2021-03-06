% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/na_if.R
\name{na_if}
\alias{na_if}
\title{Convert values to NA}
\usage{
na_if(x, y)
}
\arguments{
\item{x}{The vector to modify.}

\item{y}{The value to replace with \code{NA}.}
}
\value{
A modified version of \code{x} that replaces any values that are equal to \code{y} with \code{NA}.
}
\description{
This is a translation of the SQL command \code{NULLIF}. It is useful if you want to convert an annoying value to \code{NA}.
}
\examples{
na_if(1:5, 5:1)

x <- c(1, -1, 0, 10)
100 / x
100 / na_if(x, 0)

y <- c("abc", "def", "", "ghi")
na_if(y, "")

# na_if() is particularly useful inside mutate(),
# and is meant for use with vectors rather than entire data.frames
mtcars \%>\%
  mutate(cyl = na_if(cyl, 6))

}
\seealso{
\code{\link[=coalesce]{coalesce()}} to replace missing values within subsequent \code{vector}(s) of value(s). \code{\link[=replace_na]{replace_na()}} to replace \code{NA} with
a value.

\code{\link[=replace_na]{replace_na()}} to replace \code{NA} with a value.

\code{\link[=recode]{recode()}} to more generally replace values.
}
