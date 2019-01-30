###*
 * Gridfw 
 * @copyright khalid RAFIK 2019
###
'use strict'

CACHE_SYMB = Symbol 'view cache'
_DEFAULT_SETTINGS=
	maxSize: 20 * 2**10 # 20M
	timeout: 10 * 60 * 1000 # 10min

#=include _utils.coffee
#=include _render.coffee
#=include _ctx-methods.coffee
#=include _app-methods.coffee

# CACHE
#=include _cache.coffee

class Render
	constructor: (@app)->
		@enabled = on # the plugin is enabled
		# cache
		@app[CACHE_SYMB] ?= new Cache
			# when removing item from cache
			onRemove: (key)-> delete require.cache[require.resolve key]
			# create element if not already in cache
			create: (key)-> require key
	###*
	 * Reload parser
	###
	reload: (settings)->
		settings ?= _DEFAULT_SETTINGS
		# empty render cache
		app.debug 'VIEWS', 'Empty view cache'
		cache = @app[CACHE_SYMB]
		cache.clear()
		# cache params
		cache.maxSize = 0 # 0 means cache disabled
		cache.timeout = 0 # 0 means no timeout
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
		@app.removeProperties
			Request: REQUEST_PROTO
			Context: CONTEXT_PROTO
		return
	enable: ->
		@app.addProperties
			Request: REQUEST_PROTO
			Context: CONTEXT_PROTO
		return

module.exports = Render