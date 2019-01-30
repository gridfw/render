###
# APP METHODS
###

###*
 * Render HTML template
 * @param {string} path path to template
 * @param {Object} Locals [description]
 * @return {Promise<string>} will return the rendered HTML
###
APP_PROTO=
	render = (templatePath, locals)->
		Object.setPrototypeOf locals, @locals
		@[CACHE_SYMB].get(templatePath) locals

