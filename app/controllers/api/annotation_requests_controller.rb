class Api::AnnotationRequestsController < Api::ApiController
  include CaptchaHelper
  include ScaleHelper

  def show
    @annotation_request = AnnotationRequest.find_by_id!(params[:id])
  end

  def create
    if Rails.env.production? and not verify_captcha(params[:captcha], request.remote_ip.to_s)
      render json: { :error => { :captcha => ["Invalid Captcha"] } }, status: 400
      return
    end
    @annotation_request = AnnotationRequest.create!(annotation_request_params)
    resp = create_annotation_task(callback_url, @annotation_request.labels, image_url(@annotation_request.image))
    if resp.body["task_id"].blank?
      AnnotationResponse.create(:annotation_request => @annotation_request, :api_response => JSON.dump(resp.body))
    end
    @annotation_request.task_id = resp.body["task_id"]
    @annotation_request.save!
    render :show, status: 201
  end

  private

  def annotation_request_params
    params.permit(:image, :labels => [])
  end

  def callback_url
    URI.join(Rails.application.secrets.base_url, url_for(only_path: true, controller: '/callback', action: 'callback')).to_s
  end

  def image_url(image)
    URI.join(Rails.application.secrets.base_url, image.url).to_s
  end
end
