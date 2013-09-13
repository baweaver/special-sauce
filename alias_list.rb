#!/usr/bin/ruby

`grep '^\W*alias ' ~/.zprofile`.each_line{ |line| puts line.chomp.gsub(/^\W*alias (.+)=".+"\W*#? ?(.+)?/,"#{$1}:\t#{$2 || 'No Definition'}") }
