class RubyGem < ActiveRecord::Base
  require 'net/http'

  LAST_ADDED_URI = "https://rubygems.org/api/v1/activity/latest.json"
  LAST_UPDATED_URI = "https://rubygems.org/api/v1/activity/just_updated.json"

  def sync_date
    read_attribute(:sync_date).strftime('%d-%m-%Y') if read_attribute(:sync_date).present?
  end

  def update_if_change(new_version, new_date)
    if new_record? || version != new_version || sync_date != new_date
      update_attributes(version: new_version, sync_date: new_date)
    end
  end

  def gem_uri
    "https://rubygems.org/api/v1/gems/#{name}.json"
  end

  def response_uri?
    uri = URI.parse(gem_uri)
    response = Net::HTTP.get_response(uri)
    return response.code.to_i == 200
  end
end
