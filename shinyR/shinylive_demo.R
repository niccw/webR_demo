# Copy "Hello World" from `{shiny}`
system.file("examples", "01_hello", package="shiny") |>
  fs::dir_copy("myapp", overwrite = TRUE)

# Export myapp to webR
shinylive::export("myapp", "webR_site")

# Export myapp to webR
shinylive::export("app_uploader", "webR_site_uploader")

# Serve from R
#httpuv::runStaticServer("webR_site/")
#httpuv::runStaticServer("webR_site_uploader/")