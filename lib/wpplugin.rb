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

class WPPlugin

	VERSION = '0.1'

	def initialize
		command = ARGV.shift
		command = command.to_sm unless command.nil?
		object = ARGV.shift
		case command
			when :"--v", :"--version"
				info
			when :"--help", :"-h"
				exit_message "Usage: wpplugin\n       wpplugin [update|add|remove] {plugin-slug}\n       wpplugin update"
			when nil
				exit_message "IMPLEMENT nil"
			when :update, :upgrade
				if object.nil?
					send command
				else
					send command, object
				end
			else
				exit_error_message "Invalid command"
		end
	end

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
