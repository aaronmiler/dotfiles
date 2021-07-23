require 'rake'

desc "install the dot files into user's home directory"
task :install do |t, args|
  replace_all = (ENV["FORCE"] == 'true') || false
  link_zsh_theme
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE id_dsa.pub miler.zsh-theme aaronmiler.itermcolors].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

task :install_theme do
 link_zsh_theme
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def link_zsh_theme
  file = "miler.zsh-theme"
  puts "linking ZSH theme"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.oh-my-zsh/themes/#{file}"}
end
