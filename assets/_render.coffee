
###*
 * Execute render
 * @private
 * @param  {srting} path - path to resolve template
 * @param  {Object} locals   - locals
 * @return {Promise<html>}          return compiled HTML
###
# View cache
VIEW_CACHE = Symbol 'View cache'
_render = (app, templatePath, locals)-> @app[CACHE_SYMB].get(templatePath) locals





	settings = app.s
	viewCache = app[VIEW_CACHE]
	# resolve file content
	throw new Error 'path expected string' unless typeof templatePath is 'string'
	# check in cache
	renderFx	= viewCache?.get templatePath
	unless renderFx 
		# if add index
		filePath = if templatePath.endsWith '/' then templatePath += 'index' else templatePath 
			
		# get file string
		engines = settings[<%= settings.engines %>]
		# absolute path
		if path.isAbsolute filePath
			template = await _loadTemplateFileContent engines, filePath
		# relative to views
		else
			for v in settings[<%= settings.views %>]
				template = await _loadTemplateFileContent engines, (path.join v, filePath)
				if template.content
					break
		unless template.content
			throw new GError 501, "Missing template: #{filePath}"

		# compile template
		renderFx = template.module.compile template.content,
			pretty: settings[<%= settings.pretty %>]
			filename: template.path
		# cache
		viewCache?.set templatePath, renderFx
	# compile render fx
	renderFx locals

###*
 * Load template file content
 * @type {[type]}
###
_loadTemplateFileContent= (engines, filePath) ->
	result=
		content: null
		module: null
		path: null
	for ext, module of engines
		try
			fPath = if filePath.endsWith ext then filePath else filePath + ext
			result.content	= await fs.readFile fPath, 'utf8'
			result.module	= module
			result.path		= fPath
			break
		catch err
			if err and err.code is 'ENOENT'
				# file not found, go to next file
			else
				throw err
	result