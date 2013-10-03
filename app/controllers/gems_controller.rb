class GemsController < ApplicationController

  before_filter :current_date, only: [:updating, :update_gems_by_uri]
  before_filter :current_page, only: [:download, :updating]

  require 'open-uri'

  def index
    @ruby_gems ||= RubyGem.page(params[:page]).per(10)
  end

  def download
    uri = params[:last_add] ? RubyGem::LAST_ADDED_URI : RubyGem::LAST_UPDATED_URI
    update_gems_by_uri(uri)
    redirect_to root_url(page: @page)
  end

  def updating
    #ruby_gems = params[:gem_name] ? RubyGem.where(name: params[:gem_name]) : RubyGem.all
    #ruby_gems.each do |gem|
    RubyGem.where(name: 'rails').each do |gem|
      if gem.response_uri?
        json = JSON.parse(open(gem.gem_uri).read)
        gem.update_if_change(json['version'], @today)
      end
    end
    redirect_to root_url(page: @page)
  end

  private

  def current_date
    @today = Date.today
  end

  def current_page
    @page = params[:page] || 1
  end

  def update_gems_by_uri(uri)
    @json_objects = JSON.parse(open(uri).read)
    @json_objects.each do |json|
      gem = RubyGem.find_or_create_by(name: json['name'])
      gem.update_if_change(json['version'], @today)
    end
  end
end
