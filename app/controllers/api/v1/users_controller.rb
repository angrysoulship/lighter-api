# Comment
class Api::V1::UsersController < Api::V1::BaseController
  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def find_user
    @user = User.find(params[:id])
  end

  def login
    # user can login/signin in the app

    open_id = wechat_user.fetch("openid")

    print open_id

    @user = User.find_or_create_by(open_id: open_id)

    render json: {
      userId: @user.id,
      # hasUserInfo: @user.wechat_account.present?,
      currentUser: @user
    }
  end

  private

  def wechat_user
    wechat_params = {
      appId: ENV['WECHAT_APP_ID'],
      secret: ENV['WECHAT_APP_SECRET'],
      js_code: params[:code],
      grant_type: "authorization_code"
    }

    @wechat_response ||= RestClient.get(URL, params: wechat_params)

    p @wechat_response

    @wechat_user ||= JSON.parse(@wechat_response.body)
  end
end
