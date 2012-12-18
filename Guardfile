group :compile do
  guard 'coffeescript', input:'coffeescripts', output:'public/js'
  guard 'coffeescript', input:'spec', output:'public/spec'
end

group :auto_test do
  guard :shell, :run_on_all => false do
    watch %r{^public/.+$} do
      `rake spec`
    end
  end
end
