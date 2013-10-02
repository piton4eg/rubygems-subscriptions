class RubyGem < ActiveRecord::Base

  #attr_accessible :name, :version, :sync_date

  LAST_ADDED_URI = "https://rubygems.org/api/v1/activity/latest.json"
  LAST_UPDATED_URI = "https://rubygems.org/api/v1/activity/just_updated.json"
  GEM_URI = "/api/v1/gems/#{name}.json"

  def sync_date
    read_attribute(:sync_date).strftime('%d-%m-%Y') if read_attribute(:sync_date).present?
  end

  def update_if_change(new_version, new_date)
    if new_record? || version != new_version || sync_date != new_date
      update_attributes(version: new_version, sync_date: new_date)
    end
  end
end
