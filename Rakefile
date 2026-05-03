require 'rake'

desc "install the dot files into user's home directory"
task :install do |t, args|
  replace_all = (ENV["FORCE"] == "true") || false
  link_zsh_theme
  link_ghostty_config
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE id_dsa.pub miler.zsh-theme ghostty_config].include? file

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
  ghostty_dir = File.join(ENV['HOME'], '.config', 'ghostty')
  ghostty_config = File.join(ghostty_dir, 'config')

  unless Dir.exist?(ghostty_dir)
    puts "creating #{ghostty_dir}"
    system %Q{mkdir -p "#{ghostty_dir}"}
  end

  if File.exist?(ghostty_config) || File.symlink?(ghostty_config)
    puts "removing existing ghostty config"
    system %Q{rm "#{ghostty_config}"}
  end

  puts "linking ghostty config"
  system %Q{ln -s "$PWD/ghostty_config" "#{ghostty_config}"}
end
