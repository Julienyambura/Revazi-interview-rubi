class UploadsController < ApplicationController
  def new
  end

  def create
    model_photo = params[:model_photo]
    clothing_photo = params[:clothing_photo]

    if model_photo.blank? || clothing_photo.blank?
      flash[:error] = "Please upload both a model photo and a clothing photo."
      redirect_to root_path and return
    end

    begin
      # Process images with AI service
      ai_service = AiImageService.new
      results = ai_service.generate_images(model_photo, clothing_photo)

      @generated_images = results
      render :show
    rescue => e
      Rails.logger.error "AI processing error: #{e.message}"
      flash[:error] = "Error processing images: #{e.message}"
      redirect_to root_path
    end
  end

  def show
    # This will be handled by create action
  end
end

