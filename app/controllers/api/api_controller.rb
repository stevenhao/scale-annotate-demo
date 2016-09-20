class Api::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { :error => "not found"}, status: 404
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { :error => exception.record.errors }, status: 422
  end
end
