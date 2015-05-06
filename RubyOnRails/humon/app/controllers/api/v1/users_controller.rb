class Api::V1::UsersController < ApiController
  def create
    @user = User.create(device_token: device_token)
  end

  def device_token
    request.headers["HTTP_TB_DEVICE_TOKEN"]
  end
end
