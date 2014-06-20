module.exports = (grunt) ->

	pkg = grunt.file.readJSON('package.json')

	dependencies = Object.keys(pkg.devDependencies).filter (o) ->
		/^grunt-.+/.test(o)

	for dep in dependencies
		grunt.loadNpmTasks(dep)

	grunt.initConfig
		watch:
			coffee:
				files: 'angular-social-links.coffee'
				tasks: ['coffee:compile']

		coffee:
			compile:
				expand: true,
				flatten: true,
				cwd: "#{__dirname}/",
				src: ['angular-social-links.coffee'],
				dest: '.',
				ext: '.js'

		bump:
			options:
				files: [
					'package.json',
					'bower.json'
				]
				commit: true
				commitMessage: 'bump version to %VERSION%'
				commitFiles: [
					'package.json',
					'bower.json'
				]
				createTag: false
				tagName: '%VERSION%'
				push: false

