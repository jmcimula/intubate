\name{ntbt_survSplit}
\alias{ntbt_survSplit}
\title{Interface to survSplit for data science pipelines.}
\description{
  \code{ntbt_survSplit} is an interface to \code{survival::\link{survSplit}}
  (Split a survival data set at specified times) that can be used
  in a pipeline implemented by \code{magrittr}.}
\usage{
ntbt_survSplit(data, formula, ...)
}
\arguments{
  \item{data}{an data frame, tibble, list (or object coercible by as.data.frame to a data frame) containing the variables in the model.}
  \item{formula}{an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.}
  \item{...}{Other arguments passed to \code{\link{survSplit}}.}
}
\details{
  ntbt_survSplit reverses the order of \code{data} and \code{formula}, so it can be
  used in a pipeline. It then calls \code{\link{survSplit}}.
}
\value{
  Object returned by \code{\link{survSplit}}.
}
\author{
Roberto Bertolusso
}
\seealso{
  \code{\link{survSplit}}
}
\examples{
library(survival)

## Original function to interface
vet2 <- survSplit(Surv(time, status) ~., veteran,
                  cut = c(60, 120), episode = "timegroup")
coxph(Surv(tstart, time, status) ~ karno*strata(timegroup) +
                age + trt, data = vet2)

## The interface reverses the order of data and formula
vet2 <- ntbt_survSplit(veteran, Surv(time, status) ~.,
                       cut = c(60, 120), episode = "timegroup")
ntbt_coxph(data = vet2, Surv(tstart, time, status) ~
           karno*strata(timegroup) + age + trt)

## so it can be used easily in a pipeline.
library(magrittr)
veteran \%>\%
  ntbt_survSplit(Surv(time, status) ~.,
                 cut = c(60, 120),
                 episode = "timegroup") \%>\%
  ntbt_coxph(Surv(tstart, time, status) ~ 
             karno*strata(timegroup) + age + trt)
}
\keyword{intubate}
\keyword{magrittr}
\keyword{ntbt_survSplit}
\keyword{survSplit}
