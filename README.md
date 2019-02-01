# Gridfw-view-Render
Set of utilities to render your views

## Configuration:
Inside your config file (or any other configuration method), add the following:
```javascript
{
	plugins:{
		render:{
			require: 'gridfw-view-render'
			// add options here
		}
		// ... other plugins
	}
}
```

The plugin expects all views are precompiled (This for performance purpose).
To compile your views, see Gridfw-compiler for more information on how to do it.

## Supported engines:
You need to precompile your views. @see Gridfw-compiler for supported render engines.
We support: pug, ejs, template, ...
You can add your custom render too.

## Options:
We recommande to keep default values for all options (do not set any option). Keeping "convention over configuration" will keep your life easy ;)

### dir:
String or List of strings
Contains paths to views directory inside your project

This options contains by default "./views". We recommande to keep this convention and put your views inside it.

Example:
```coffeescript
plugins:
	render:
		require: 'gridfw-view-render'
		dir: 'path/to/views/'
		# or dir: ['path1/', 'path2/']
		# you can use relative or absolute paths
		# @default value: './views'

```

### cache
By default, this is set to "false" in dev mode.
In production mode, the app will do the best to fit available memory and have maxumum of performance. You maybe will not need to change this.