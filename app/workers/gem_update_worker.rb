class GemUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    #ruby_gems = params[:gem_name] ? RubyGem.where(name: params[:gem_name]) : RubyGem.all
    ruby_gems = RubyGem.all
    ruby_gems.each do |one_gem|
      one_gem.update_if_response_uri
    end
  end

end