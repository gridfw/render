###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'
Path = require 'path'

#=include _utils.coffee
#=include _settings.coffee
#=include _render.coffee


class Render
	constructor: (@app)->
		@enabled = on # the plugin is enabled
		@fxes = null # functions
	###*
	 * Reload parser
	###
	reload: (settings)->
		# load settings
		_initSettings @app, settings
		# enable
		@enable()
		return
	###*
	 * destroy
	###
	destroy: -> @disable()
	###*
	 * Disable, enable
	###
	disable: ->
		@app.removeProperties @fxes if @fxes
		return
	enable: ->
		# remove previous functions
		@app.removeProperties @fxes if @fxes
		# generate functions
		render = _renderGen @app.CACHE, @s[<% settings.views %>]
		@fxes =
			Request:
				render: render
			Context:
				render: render
		# append
		@app.addProperties @fxes
		return

module.exports = Render