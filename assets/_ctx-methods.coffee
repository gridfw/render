# context render

###*
 * Render page
 * @param  {[type]} path [description]
 * @return {[type]}      [description]
###
CONTEXT_PROTO=
	# render
	render: (path, locals)->
		# locals
		if locals
			Object.setPrototypeOf locals, @locals
		else
			locals = _create @locals
		# render
		@send @app[CACHE_SYMB].get(path) locals
