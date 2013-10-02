class GemsController < ApplicationController

  require 'open-uri'

  def index
    @ruby_gems ||= RubyGem.page(params[:page]).per(10)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def last_update
    uri = params[:last_add] ? RubyGem::LAST_ADDED_URI : RubyGem::LAST_UPDATED_URI
    update_gems_by_uri(uri)
  end

  private

  def update_gems_by_uri(uri)
    @json_objects = JSON.parse(open(uri).read)
    today = Date.today
    @json_objects.each do |json|
      gem = RubyGem.find_or_create_by(name: json['name'])
      gem.update_if_change(json['version'], today)
    end
    redirect_to gems_url
  end
end
