###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'
Path = require 'path'
Fs	= require 'mz/fs'

#=include _utils.coffee
#=include _settings.coffee
#=include _render.coffee
#=include _load-static-views.coffee


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
		@app.removeProperties 'Render', @fxes if @fxes
		return
	enable: ->
		app= @app
		# remove previous functions
		app.removeProperties @fxes if @fxes
		# generate functions
		render = _renderGenApp app.CACHE, app.s[<%= settings.views %>], app.Error
		ctxRender = _renderGenCtx app.CACHE, app.s[<%= settings.views %>], app.Error
		@fxes =
			App:
				render: render
				loadStaticViews: _loadStaticViews
			Context:
				render: ctxRender
		# append
		app.addProperties 'Render', @fxes
		return

module.exports = Render