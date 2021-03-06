#GPL 2.0  http://www.gnu.org/licenses/gpl-2.0.html
#Zabbix CLI Tool and associated files
#Copyright (C) 2009,2010 Andrew Nelson nelsonab(at)red-tux(dot)net
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

##########################################
# Subversion information
# $Id$
# $Revision$
##########################################

require 'rexml/document'

class CommandHelp


  def self.setup(language)
    @file = File.new(ZABCON_PATH+"/libs/help.xml")

    @doc=REXML::Document.new(@file).elements["//help[@language='#{language}']"]

    EnvVars.instance.register_notifier("language",self.method(:language=))

  end

  def self.language=(language)
    @file.rewind
    @doc=REXML::Document.new(@file).elements["//help[@language='#{language}']"]
  end

  def self.get(sym)
    item=@doc.elements["//item[@command='#{sym.to_s}']"]
    if item.nil?
      "Help not available for internal command: #{sym.to_s}"
    else
      item.text
    end
  end

end
