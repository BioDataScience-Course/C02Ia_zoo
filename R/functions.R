#' Extract Best Correlations
#'
#' @description
#' Extracts the n pairs of variables with the strongest correlations
#' from a Correlation object.
#'
#' @param x A `Correlation` object: a square numeric matrix of class
#'   `"Correlation"` (as returned, e.g., by [stats::cor()] with the class
#'   added), with matching row and column names identifying the variables.
#' @param n Integer. Number of pairs to return (default `5L`). Must be a
#'   single positive whole number.
#' @param sort Character. Sorting method: `"abs"` (absolute value, default),
#'   `"pos"` (strongest positive), or `"neg"` (strongest negative).
#'
#' @return A data.frame with columns `Var1`, `Var2`, and `Freq`
#'   representing the variable pairs and their correlation coefficients.
#'   `Var1` and `Var2` are character vectors (not factors). If fewer than
#'   `n` pairs are available, all available pairs are returned.
#'
#' @export
#' @importFrom collapse na_omit roworderv
#' @importFrom utils head
#'
#' @examples
#' cor_matrix <- cor(mtcars)
#' class(cor_matrix) <- c("Correlation", class(cor_matrix))
#' correlation_best(cor_matrix, n = 3, sort = "abs")
#'
correlation_best <- function(x, n = 5L, sort = c("abs", "pos", "neg")) {
  if (!inherits(x, "Correlation")) {
    stop("x must be a Correlation object")
  }
  if (!is.matrix(x) || !is.numeric(x)) {
    stop("x must be a numeric matrix")
  }
  if (nrow(x) != ncol(x)) {
    stop("x must be a square matrix")
  }
  if (is.null(rownames(x)) || is.null(colnames(x))) {
    stop("x must have row and column names identifying the variables")
  }
  if (!identical(rownames(x), colnames(x))) {
    stop("x row names and column names must match")
  }
  if (!is.numeric(n) || length(n) != 1 || is.na(n) || n != as.integer(n) ||
      n < 1) {
    stop("n must be a single positive whole number")
  }
  
  sort <- match.arg(sort, choices = c("abs", "pos", "neg"))
  
  x[lower.tri(x, diag = TRUE)] <- NA
  x <- as.data.frame(as.table(x), stringsAsFactors = FALSE)
  x <- collapse::na_omit(x, "Freq")
  
  res <- switch(
    sort,
    abs = {
      x$Freq_abs <- abs(x$Freq)
      x <- collapse::roworderv(x, "Freq_abs", decreasing = TRUE)
      x$Freq_abs <- NULL
      x
    },
    pos = {
      collapse::roworderv(x, "Freq", decreasing = TRUE)
    },
    neg = {
      collapse::roworderv(x, "Freq", decreasing = FALSE)
    }
  )
  
  res <- utils::head(res, as.integer(n))
  rownames(res) <- NULL
  res
}
