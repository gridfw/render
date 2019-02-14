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
			<% if(ele === 'App'){ %>
			GError = @Error
			<% } else { %>
			GError = @app.Error
			<% } %>
			if err is 404
				throw new GError 500, "View not found at: #{path}"
			else
				throw new GError 500, "View Error at: #{path}", err
<% } %>