# Comment
class Api::V1::UsersController < Api::V1::BaseController
  URL = "https://api.weixin.qq.com/sns/jscode2session".freeze
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:show, :update]

  def index
    @users = User.all
  end

  def show
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

  def update
    # p params[:userinfo][:nickName]
    # p params[:userinfo][:gender].to_s
    # p params[:userinfo][:avatarUrl].class
    # @user.update(wechat_name: params[:userInfo][:nickName], wechat_avatar: params[:userInfo][:avatarUrl], gender: params[:userInfo][:gender].to_s)
    # p @user
    # p @user.valid?
    # p @user.errors
    @user.wechat_name = params[:userinfo][:nickName]
    @user.nickname = params[:userinfo][:nickName]
    @user.gender = params[:userinfo][:gender].to_s
    @user.wechat_avatar =  params[:userinfo][:avatarUrl]
    p @user.valid?
    p @user.errors
    p @user
    @user.save!
    render json: { currentUser: @user }
  end

  private

  def wechat_user
    wechat_params = {
      appId: Rails.application.credentials.wx_app_id,
      secret: Rails.application.credentials.wx_app_secret,
      js_code: params[:code],
      grant_type: "authorization_code"
    }

    @wechat_response ||= RestClient.get(URL, params: wechat_params)

    p @wechat_response.body.class
    p @wechat_response.body

    @wechat_user ||= JSON.parse(@wechat_response.body)
  end
end
