CRAWLER_ENV = ENV['CRAWLER_ENV'] || 'development'
AREA = ENV['AREA_ENV'] || :cn

require 'rubygems'
require 'bundler'
Bundler.require(:default, CRAWLER_ENV)

$project_root = Pathname.new File.dirname(__FILE__)

load_paths = ['utils', 'items', 'middlewares', 'spiders'].map do |dir|
  $project_root.join('app', dir)
end

ActiveSupport::Dependencies.autoload_paths += load_paths

def start_ant
  spiders = Dir[$project_root.join('app', 'spiders', '*.rb')].map do |path|
    File.basename(path, '.rb').to_s.classify.constantize
  end
  spiders.each do |spiders|
    if CRAWLER_ENV != 'production'
      puts spiders.new.pipeline.map &:to_h
    else
      spiders.new.pipeline
    end
  end
end