###*
 * Render views
###
<%
var i, ele, eles = ['App', 'Ctx']
for(i in eles){
	ele= eles[i];
%>
_renderGen<%=ele %>= (CACHE, viewsPath, GError)->
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
				throw err unless err is 404 or !ctx.i18n
				p2= Path.resolve viewsPath, path
				renderFx= await CACHE.get p2
			# render
			<% if(ele === 'App'){ %>
			return renderFx locals
			<% } else { %>
			return @send renderFx locals
			<% } %>
		catch err
			if err is 404
				throw new GError 500, "View not found at: #{p1}, #{p2}"
			else
				throw new GError 500, "View Error at: #{path}", err
<% } %>