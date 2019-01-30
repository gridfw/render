# attributes abreviations
<%
const create = 'c',
	onRemove= 'r',
	cache = 'q',
	currentTimeout= 't',
	bytes = 'b', //# Total size in bytes
	length= 'l' //# nbr of items inside cache
%>

### CACHE ###
class Cache
	###*
	 * Cache
	 * @param {Number} settings.size - aproximative cache max size in bytes
	 * @param  {number} settings.timeout - timeout in ms
	 * @param {function} onRemove - callback when removing an antity
	 * @param {function} create - create an antity
	 * @return {[type]}          [description]
	###
	constructor: (settings)->
		settings ?= _create null
		@<%=create %> = settings.create
		@<%=onRemove %> = settings.onRemove
		# cache object
		# key: [lastStep, nbrUsed, approximativeFileSize]
		@<%=cache %> = _create null
		@<%=bytes %>= 0
		@<%=length %>= 0

		@maxSize = settings.maxSize || 0
		@interval = settings.interval || default_interval
	# 
	# clear all data
	clear: ->
		@<%=bytes %>= 0
		@<%=length %>= 0
	# get an antity from cache
	get: (key)->
		value = @<%=create %> key
		# inc cache
		ele = @<%=cache %>[key]
		if ele
			ele[0] ++
			ele[1] = @<%=currentTimeout %>
		# return
		return value

### getters ###
Object.defineProperties Cache.prototype,
	length: get: -> @<%=length %>
	bytes: get: -> @<%=bytes %>
###*
 * Get fx when cache is disabled
###
_getCacheDisabled = (key)->
	# get value
	value = @<%=create %> key
	# remvoe from cache
	@<%=onRemove %> key
	# return value
	return value
###*
 * Get fx when cache is enabled
 * @type {[type]}
###
_getCacheEnabled = (key)->
	# get value
	value = @<%=create %> key
	# caching process
	unit = @<%=cache %>[key]
	if unit
		unit[0] = 0 # refresh step
		++unit[1] # inc nbr used
	else
		unit= @<%=cache %>[key] = [0, 1, 0]
		++@<%=length %>
		# look for file size
		fs.stat key, (err, stats)->
			if stats
				@<%=bytes %> += (unit[2] = stats.size)
	# return value
	return value
