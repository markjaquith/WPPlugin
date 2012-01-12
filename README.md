# WPPlugin

WPPlugin is a Ruby command line script to update and manage WordPress plugins. Useful for WordPress installs that are managed in a Git repository.

**As of version 0.1, you must run it from your `plugins` or `mu-plugins` directory.**

Available commands:

* `wpplugin add {plugin}` — installs the specified plugin
* `wpplugin remove {plugin}` — removes the specified plugin
* `wpplugin update {plugin}` — updates a plugin to the latest stable version
* `wpplugin update` — updates all plugins to the latest stable version

## Installation

To install WPPlugin, use RubyGems:

```bash
sudo gem install wpplugin
```

**As of version 0.1, you must have the `wget` and `unzip` commands available on your system.**

## License & Copyright

WPPlugin is Copyright Mark Jaquith 2012, and is offered under the terms of the GNU General Public License, version 2, or any later version.