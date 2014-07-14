module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      options:
        bare: true
      compile:
        files:
          'release/index.js' : 'index.coffee'
    release:
      options:
        folder: './release'
        # github:
        #   repo: 'skrobul/periodic-read'
    copy:
      target:
        files: [
          { src: 'README.md', dest: 'release/README.md'}
          { src: 'LICENSE', dest: 'release/LICENSE' }
          { src: 'package.json', dest: 'release/package.json' }
        ]
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.loadNpmTasks 'grunt-release'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.registerTask 'newrelease', ['coffee', 'copy', 'release']
  grunt.registerTask 'default', ['coffee']
