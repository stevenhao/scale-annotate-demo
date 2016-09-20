module ScaleHelper
  def create_annotation_task(callback_url, objects_to_annotate, attachment)
    @@connection.post '/v1/task/annotation', {
      :callback_url => callback_url,
      :objects_to_annotate => objects_to_annotate,
      :attachment => attachment,
      :attachment_type => "image",
      :instruction => "Annotate the specified objects",
      :urgency => "immediate"
    }
  end

  private

  def self.scale_base_url
    Rails.application.secrets.scale_base_url
  end
  
  @@connection = Faraday.new scale_base_url do |conn|
    conn.use Faraday::Response::Logger, Rails.logger
    conn.basic_auth Rails.application.secrets.scale_api_key, ''
    conn.request  :url_encoded
    conn.response :json, :content_type => /\bjson$/
    conn.adapter Faraday.default_adapter
  end
end
