###*
 * Load static views
###
_JS_FILE = /\.js$/i
_loadStaticViews = (prefix, path)->
	# resolve abs path
	path2 = Path.resolve viewsPath, path
	# check if this view exists
	unless path2.endsWith '/'
		tmpPath = if _JS_FILE.test path2 then path2 else path2 + '.js'
		stats = await Fs.stat tmpPath
		if stats.isFile()
			_AddController this, prefix, path2

	# check if it is a directory
	stats = await Fs.stat path2
	if stats.isDirectory()
		queue = [path2, prefix]
		i = 0
		while i < queue.length
			path2 = queue[i++]
			prefix= queue[i++]
			files = await fs.readdir path2, withFileTypes: yes
			for file in files
				fileName= file.name
				filePath= Path.join path2, fileName
				fileUri= Path.join prefix, fileName
				if file.isDirectory()
					queue.push filePath, fileUri
				else if file.isFile() and _JS_FILE.test fileName
					_AddController this, fileUri, filePath
	return

_AddController = (app, uri, viewPath)->
	app.on 'GET', uri, -> viewPath
	return