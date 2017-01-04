require 'thor'
require 'fileutils'

class FluteCLI < Thor
  desc "new NAME", "create project"
  def new(name)
    dirs = [
      'tmp',
      'log',
      'config',
      'lib',
      'app',
      'app/utils',
    ]
    create_dir(name, dirs)
    FileUtils.touch "#{name}/tmp/.keep"
    FileUtils.touch "#{name}/log/.keep"

    copy_template 'Gemfile', "#{name}/Gemfile"
    copy_template 'main.rb', "#{name}/main.rb"
    copy_template 'Rakefile', "#{name}/Rakefile"

    FileUtils.cp_r template_path('items'), "#{name}/app/items"
    FileUtils.cp_r template_path('spiders'), "#{name}/app/spiders"
    FileUtils.cp_r template_path('middlewares'), "#{name}/app/middlewares"

    puts "cd #{name}"
    puts "bundle install"
    puts "rake start"
  end

  private
  def create_dir(project_name, dirs)
    Dir.mkdir(project_name)
    dirs.each {|dir|
      Dir.mkdir "#{project_name}/#{dir}"      
    }
  end

  def copy_template(name, dest)
    FileUtils.cp template_path(name), dest
  end

  def template_path(name)
    File.expand_path("../template/#{name}", File.dirname(__FILE__))
  end
end

FluteCLI.start(ARGV)