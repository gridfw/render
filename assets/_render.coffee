###*
 * Render views
###
<%
var i, ele, eles = ['App', 'Ctx']
for(i in eles){
	ele= eles[i];
%>
_renderGen<%=ele %>= (CACHE, viewsPath)->
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
			<% if(ele === 'App'){ %>
			return CACHE.get(path) locals
			<% } else { %>
			return @send await CACHE.get(path) locals
			<% } %>
		catch err
			err2= new Error "View Error at: #{path}\nCaused by: #{err}"
			err2.extra= err # cause by
			throw err2
<% } %>