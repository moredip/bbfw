group :compile do
  guard 'coffeescript', input:'coffeescripts', output:'public/js'
  guard 'coffeescript', input:'spec', output:'public/spec'

  guard 'sass',
    :input => 'stylesheets',
    :output => 'public/css',
    :smart_partials => true,
    :load_paths => ['stylesheets']
    #:style => :compressed

end

group :auto_test do
  guard :shell, :run_on_all => false do
    watch %r{^public/.+$} do
      `rake spec`
    end
  end
end
