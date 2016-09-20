class CallbackController < ApplicationController
  def callback
    if request.headers["scale-callback-auth"] != Rails.application.secrets.scale_callback_key
      render :nothing => true, :status => 401
      return
    end
    if params["task_id"].strip.length == 0
      render :nothing => true, :status => 404
      return
    end
    @annotation_request = AnnotationRequest.find_by_task_id!(params["task_id"])
    AnnotationResponse.create(:annotation_request => @annotation_request, :api_response => request.raw_post)
    render :nothing => true, :status => 200
  end
end
