console.log 'Foo-metrics'

opts = process.argv

if opts.length <= 2
  console.log 'You must specify a src parameter in order to start the analysis'
  return

src = opts[2]

console.log "Analyzing #{src} directory..."
