module ApplicationHelper
  def paperclip_url(asset)
    File.join(ENV["RAILS_RELATIVE_URL_ROOT"] || "", asset.url)
  end
end
