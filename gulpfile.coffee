gulp = require 'gulp'
watchify = require 'gulp-watchify'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
plumber = require 'gulp-plumber'
rename = require 'gulp-rename'

target =
  src: 'src/index.coffee'
  name: 'index.js'
  dest: ''
  bundleExternal: true
  detectGlobals: true

gulp.task 'default', ['build']

gulp.task 'build', watchify (watchify) ->
  gulp
    .src target.src
      .pipe plumber()
      .pipe watchify
        watch: watching
        extensions: ['.cjsx', '.coffee', '.js', '.json']
        debug: true
        transform: ['coffee-reactify']
        detectGlobals: target.detectGlobals
        bundleExternal: target.bundleExternal
      .pipe buffer()
      .pipe sourcemaps.init
        loadMaps: true
      .pipe rename(target.name)
      .pipe sourcemaps.write('./')
      .pipe gulp.dest(target.dest)

watching = false
gulp.task 'enable-watch-mode', -> watching = true
gulp.task 'watch', ['enable-watch-mode', 'build']
