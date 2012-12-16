use Rack::Static, 
  :urls => ["/js","/spec"],
  :root => "public"

run lambda { |env|
  [
    200, 
    { 'Content-Type'  => 'text/html' },
    File.open('public/index.html', File::RDONLY)
  ]
}
