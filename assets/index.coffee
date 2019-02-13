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
		app= @app
		# remove previous functions
		app.removeProperties @fxes if @fxes
		# generate functions
		render = _renderGenApp app.CACHE, app.s[<%= settings.views %>]
		ctxRender = _renderGenCtx app.CACHE, app.s[<%= settings.views %>]
		@fxes =
			App:
				render: render
			Context:
				render: ctxRender
		# append
		app.addProperties @fxes
		return

module.exports = Render