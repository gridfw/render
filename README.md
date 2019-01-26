# Gridfw-view-Render
Set of utilities to render your views

## Configuration:
Inside your config file (or any other configuration method), add the following:
```javascript
{
	plugins:{
		views:{
			require: 'gridfw-view-render'
			// add options here
		}
		// ... other plugins
	}
}
```

## Options:
We recommande to keep default values for all options (do not set any option). Keeping "convention over configuration" will keep your life easy ;)

### Pretty
Show the HTML, JSON, XML, ... in pretty format
By default: true in dev mode, false in production
Recommanded to keep default behaviour
```coffeescript
plugins:
	views:
		require: 'gridfw-view-render'
		pretty: false # @default: true in dev mode, false in production
# <!> The default behaviour is recommanded for most cases. Do not set this option.
```

### Engines:
A set of render engines.
By default we use pug as render engine.
The framework will guess the engine to use depending on existing files in your view directory.
You can override the set of engines with this option:

Example:
```coffeescript
plugins:
	views:
		require: 'gridfw-view-render'
		engines:
			# <extension> : <renderEngine>
			'pug': require('pug')
			'ejs': require('ejs')

```
You Can use your custom view render by implementing a "compile" method like other engines.

### dir:
String or List of strings
Contains paths to view directory inside your project

This options contains by default "./views". We recommande to keep this convention and put your views inside a "views" directory inside the root of your project instead of setting this option.

Example:
```coffeescript
plugins:
	views:
		require: 'gridfw-view-render'
		dir: 'path/to/views/'
		# or dir: ['path1/', 'path2/']
		# you can use relative or absolute paths
		# @default value: './views'

```