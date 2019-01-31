### default settings ###
_initSettings = <%= initSettings %>
	views:
		default: Path.resolve 'views'
		check: (value)->
			throw "Expected string" unless typeof value is 'string'
			Path.resolve value