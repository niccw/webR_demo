# Copy "Hello World" from `{shiny}`
system.file("examples", "01_hello", package="shiny") |>
  fs::dir_copy("myapp", overwrite = TRUE)

# Export myapp to webR
shinylive::export("myapp", "webR_site")

# Serve from R
#httpuv::runStaticServer("webR_site/")
