###*
 * Render views
###
_renderGen= (CACHE, viewsPath)->
	(path, locals)->
		try
			# resolve abs path
			path = Path.resolve viewsPath, path
			# locals
			if locals
				Object.setPrototypeOf locals, @locals
			else
				locals = _create @locals
			# render
			return CACHE.get(path) locals
		catch err
			err2= new Error "View Error at: #{path}\nCaused by: #{err}"
			err2.extra= err # cause by
			throw err2
	