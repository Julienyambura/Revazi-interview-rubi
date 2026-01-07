require 'httparty'
require 'base64'

class AiImageService
  include HTTParty

  def initialize
    @api_key = ENV['REPLICATE_API_TOKEN'] || ENV['OPENAI_API_KEY']
    @use_mock = @api_key.blank?
  end

  def generate_images(model_photo, clothing_photo)
    if @use_mock
      generate_mock_images(model_photo, clothing_photo)
    else
      generate_real_images(model_photo, clothing_photo)
    end
  end

  private

  def generate_real_images(model_photo, clothing_photo)
    if ENV['REPLICATE_API_TOKEN']
      generate_with_replicate(model_photo, clothing_photo)
    elsif ENV['OPENAI_API_KEY']
      generate_with_openai(model_photo, clothing_photo)
    else
      generate_mock_images(model_photo, clothing_photo)
    end
  end

  def generate_with_replicate(model_photo, clothing_photo)
    model_data = process_image(model_photo)
    clothing_data = process_image(clothing_photo)
    
    # TODO: Implement Replicate API integration
    generate_mock_images(model_photo, clothing_photo)
  end

  def generate_with_openai(model_photo, clothing_photo)
    # TODO: Implement OpenAI integration
    generate_mock_images(model_photo, clothing_photo)
  end

  def generate_mock_images(model_photo, clothing_photo)
    model_img = process_image(model_photo)
    clothing_img = process_image(clothing_photo)

    {
      enhanced_product: create_mock_image(clothing_img, "enhanced"),
      model_wearing: create_mock_image(model_img, "wearing"),
      product_back: create_mock_image(clothing_img, "back"),
      model_wearing_back: create_mock_image(model_img, "wearing_back")
    }
  end

  def process_image(uploaded_file)
    uploaded_file.rewind if uploaded_file.respond_to?(:rewind)
    uploaded_file.read
  end

  def create_mock_image(original_data, type)
    {
      data: original_data,
      base64: Base64.strict_encode64(original_data),
      content_type: 'image/jpeg',
      filename: "#{type}_#{Time.now.to_i}.jpg"
    }
  end
end

