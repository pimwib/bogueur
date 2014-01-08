project_type = :stand_alone

css_dir = "../"
http_path       = "/"
sass_dir        = "/"
images_dir      = "../../img"
javascripts_dir = "../../js"

# nested, expanded, compact, compressed
output_style = :compact

# :production, :development
environment = :production

line_comments = false

relative_assets = true

asset_cache_buster :none

sass_options = { :debug_info => false }