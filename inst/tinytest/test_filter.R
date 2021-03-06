expect_equal(
  mtcars %>% filter(am == 1),
  mtcars[mtcars$am == 1, ],
  info = "Test single logical filter"
)

expect_equal(
  mtcars %>% filter(mpg > 28 & am == 1),
  mtcars[mtcars$mpg > 28 & mtcars$am == 1, ],
  info = "Test multiple logical filters; sep = &"
)

expect_equal(
  mtcars %>% filter(mpg > 28, am == 1),
  mtcars[mtcars$mpg > 28 & mtcars$am == 1, ],
  info = "Test multiple logical filters; sep = ,"
)

expect_equal(
  mtcars %>% filter(cyl == 4 | cyl == 8),
  mtcars[mtcars$cyl == 4 | mtcars$cyl == 8, ],
  info = "Test multiple logical filters; sep = |"
)

expect_equal(
  mtcars %>% filter(!(cyl %in% c(4, 6)), am != 0),
  mtcars[!(mtcars$cyl %in% c(4, 6)) & mtcars$am != 0, ],
  info = "Test multiple logical filters; negation"
)

expect_equal(
  {
    sp1 <- "virginica"
    filter(iris, Species == sp1)
  },
  iris[iris$Species == "virginica", ],
  info = "Test filters work with variable inputs"
)

expect_equal(
  {
    sp2 <- levels(iris$Species)
    lapply(sp2, function(x) {
      filter(iris, Species == x)
    })
  },
  {
    res <- split(iris, iris$Species)
    names(res) <- NULL
    res
  },
  info = "Test filter works in an anonymous function (#9)"
)

expect_equal(
  {
    sp3 <- unique(as.character(iris$Species))
    lapply(sp2, function(x) {
      filter(iris, Species == x)
    })
  },
  {
    res <- split(iris, iris$Species)
    names(res) <- NULL
    res
  },
  info = "Test filter works in an anonymous function; factors (#9)"
)

expect_equal(
  filter(.data = mtcars),
  mtcars,
  info = "filter() returns the input data if no parameters are given"
)

# Grouped Operations
expect_equal(
  mtcars %>% group_by(carb) %>% filter(any(mpg > 28)) %>% ungroup(),
  {
    rows <- rownames(mtcars)
    res <- do.call(rbind, unname(lapply(split(mtcars, mtcars$carb), function(x) x[any(x$mpg > 28), ])))
    res[rows[rows %in% rownames(res)], ]
  },
  info = "Test grouped filters"
)

expect_equal(
  mtcars %>% group_by(cyl, am) %>% filter(cyl %in% c(4, 8), .preserve = TRUE) %>% group_rows(),
  list(
    c(4L, 5L, 15L), c(1L, 12L, 13L, 14L, 20L, 21L, 22L, 25L), integer(0), integer(0),
    c(2L, 3L, 6L, 7L, 8L, 9L, 10L, 11L, 16L, 17L, 18L, 19L), 23:24
  ),
  info = ".preserve = TRUE returns the correct row indicies"
)

expect_equal(
  mtcars %>% group_by(cyl, am) %>% filter(cyl %in% c(4, 8), .preserve = FALSE) %>% group_rows(),
  list(
    c(4L, 5L, 15L), c(1L, 12L, 13L, 14L, 20L, 21L, 22L, 25L),
    c(2L, 3L, 6L, 7L, 8L, 9L, 10L, 11L, 16L, 17L, 18L, 19L), 23:24
  ),
  info = ".preserve = FALSE returns the correct row indicies"
)

# Errors

expect_error(
  filter(.data = mtcars, mpg > 20, am = 1),
  info = "Check for named arguments works"
)
