###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'


#=include _render.coffee
#=include _methods.coffee

class Render
	constructor: (@app)->
		@enabled = on # the plugin is enabled
	###*
	 * Reload parser
	###
	reload: (settings)->
		# empty render cache
		#TODO
		app.debug 'VIEWS', 'Empty view cache'
		if appSettings[<%= settings.viewCache %>]
			if app[VIEW_CACHE]
				app[VIEW_CACHE].clear()
			else
				app[VIEW_CACHE] = new LRUCache
					max: appSettings[<%= settings.viewCacheMax %>]
		else
			app[VIEW_CACHE] = null
		# enable
		@enable()
		return
	###*
	 * destroy
	###
	destroy: ->
		return
	###*
	 * Disable, enable
	###
	disable: -> @destroy
	enable: ->
		return

module.exports = Render