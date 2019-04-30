###*
 * Render views
###
_renderGenCtx= (CACHE, viewsPath, GError)->
	(path, locals)->
		try
			# locals
			if locals
				Object.setPrototypeOf locals, @locals
			else
				locals = _create @locals
			# resolve render function
			try
				# resolve with local param
				p1= Path.resolve viewsPath, @i18n.local, path
				renderFx= await CACHE.get p1
			catch err
				# resolve without local
				throw err unless err is 404 or !@i18n
				p2= Path.resolve viewsPath, path
				renderFx= await CACHE.get p2
			# render
			return @send renderFx locals
		catch err
			if err is 404
				throw new GError 500, "View not found at: #{p1}, #{p2}"
			else
				throw new GError 500, "View Error at: #{path}", err
_renderGenApp= (CACHE, viewsPath, GError)->
	(lang, path, locals)->
		try
			# locals
			if locals
				Object.setPrototypeOf locals, @locals
			else
				locals = _create @locals
			# resolve render function
			try
				# resolve with local param
				p1= Path.resolve viewsPath, lang, path
				renderFx= await CACHE.get p1
			catch err
				# resolve without local
				throw err unless err is 404
				p2= Path.resolve viewsPath, path
				renderFx= await CACHE.get p2
			# render
			return renderFx locals
		catch err
			if err is 404
				throw new GError 500, "View not found at: #{p1}, #{p2}"
			else
				throw new GError 500, "View Error at: #{path}", err