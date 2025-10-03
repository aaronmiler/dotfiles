require 'rake'

desc "install the dot files into user's home directory"
task :install do |t, args|
  replace_all = (ENV["FORCE"] == "true") || false
  link_zsh_theme
  link_ghostty_config
  dotfiles = %w[ gemrc nvimrc pryrc vimrc zshrc ]
  dotfiles.each do |file|
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
  # Link the global Gitignore file
  `git config --global core.excludesfile "~/.gitignore"`
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

def link_ghostty_config
  file = "ghostty_config"
  puts "linking Ghostty config"
  system %Q(mkdir -p ~/.config/ghostty)
  system %Q{ln -s "$PWD/#{file}" "$HOME/.config/ghostty/config"}
end
