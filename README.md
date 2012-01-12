# WPPlugin

WPPlugin is a Ruby command line script to update and manage WordPress plugins. Useful for WordPress installs that are managed in a Git repository.

Available commands:

* `wpplugin` — lists the plugins with available updates
* `wpplugin add {plugin}` — installs the specified plugin
* `wpplugin remove {plugin}` — removes the specified plugin
* `wpplugin update|upgrade {plugin}` — updates a plugin to the latest stable version
* `wpplugin update|upgrade` — updates all plugins to the latest stable version

## Installation

To install wpplugin, use RubyGems:

```bash
sudo gem install wpplugin
```


## License & Copyright

WPPlugin is Copyright Mark Jaquith 2012, and is offered under the terms of the GNU General Public License, version 2, or any later version.