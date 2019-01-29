# context render

###*
 * Render page
 * @param  {[type]} path [description]
 * @return {[type]}      [description]
###
CONTEXT_PROTO.render = (path, locals)->
	if locals
		Object.setPrototypeOf locals, @locals
	else
		locals = _create @locals
	@app._render path, locals
	.then (html)=>
		# @contentType = 'text/html'
		@send html

APP_PROTO.render = (templatePath, locals)->
	Object.setPrototypeOf locals, @locals
	@_render path, locals



###*
 * Render HTML template
 * @param {string} path path to template
 * @param {Object} Locals [description]
 * @return {Promise<string>} will return the rendered HTML
###
GridFW::render= (templatePath, locals)->
	Object.setPrototypeOf locals, @locals
	@_render path, locals