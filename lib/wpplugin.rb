#
# WPPlugin - Command line tool for WordPress plugin updates and management
#
# Copyright 2012 by Mark Jaquith
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

require 'fileutils'
require 'pathname'

class WPPlugin

	VERSION = '0.2beta2'

	def initialize
		command = ARGV.shift
		command = command.to_sym unless command.nil?
		plugin = ARGV.shift
		plugin = plugin.dup.to_str unless plugin.nil?
		if !plugin.nil?
			plugin.downcase
			plugin.gsub! ".", ""
			plugin.gsub! "/", ""
			plugin.gsub! " ", ""
		end
		plugin = nil if !plugin.nil? and plugin.empty?
		case command
			when :"--v", :"--version"
				info
			when nil, :"--help", :"-h"
				exit_message "Usage: wpplugin update\n       wpplugin [update|add|remove] {plugin-slug}"
			when :add, :remove, :install, :delete, :uninstall
				exit_error_message "You must provide a plugin slug" if plugin.nil?
				send command, plugin
			when :update, :upgrade
				if plugin.nil?
					update_all
				else
					update plugin
				end
			else
				exit_error_message "Invalid command"
		end
	end

	def update plugin
		remove_files plugin
		add plugin
		`svn status #{plugin} 2>/dev/null | grep '\!' | awk '{print $2;}' | xargs svn rm`
	end

	def update_all
		plugins = Pathname.glob("*/readme.txt").map { |i| i.dirname.to_s }.each do |plugin|
			update plugin
		end
	end

	def add plugin
		# If the directory exists, do an update instead
		if File.directory? plugin
			update plugin
			return
		end
		uri = "http://downloads.wordpress.org/plugin/#{plugin}.latest-stable.zip"
		`wget -O #{plugin}.zip #{uri} > /dev/null 2>&1`
		`unzip #{plugin}.zip > /dev/null 2>&1`
		`rm #{plugin}.zip > /dev/null 2>&1`
		`svn add --force #{plugin} > /dev/null 2>&1`
		`git add --all #{plugin} > /dev/null 2>&1`
	end

	alias :install :add

	def remove_files plugin
		FileUtils.rm_rf plugin if File.directory? plugin
	end

	def remove plugin
		remove_files plugin
		`svn rm #{plugin} > /dev/null 2>&1`
		`git rm -r #{plugin} > /dev/null 2>&1`
	end

	alias :delete    :remove
	alias :uninstall :remove

	def info
		puts "WPPlugin #{self.class::VERSION}"
	end

	def debug message
		puts message if @debug
	end

	def exit_message message
		puts message
		exit
	end

	def exit_error_message message
		exit_message '[ERROR] ' + message
	end

end
