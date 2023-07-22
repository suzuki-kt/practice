class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: %i[ index show edit update destroy logout]
  before_action :forbid_login_user, only: %i[login login_form new create]
  before_action :ensure_correct_user, only: %i[edit update destroy ]


  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @posts = @user.posts.order(created_at: "desc")
    @tab = "post"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|

      if @user.save
        image = params[:user][:image]
        if image
          @user.image_name = "#{@user.id}.jpg"
          @user.save
          File.binwrite("public/user_images/#{@user.image_name}", image.read)
        end
        session[:user_id] = @user.id
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    image = params[:user][:image]
    respond_to do |format|
      if @user.update(user_params)
        if image
          @user.update(image_name: "#{@user.id}.jpg")
          File.binwrite("public/user_images/#{@user.image_name}", image.read)
        end
        format.html { redirect_to user_url(@user), notice: "ユーザー情報を更新しました" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    session[:id] = nil

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to @user, notice: "ログインしました"
    else
      redirect_to request.referer, notice: "メールアドレスまたはパスワードが間違っています"
    end
  end
    


  def logout
    session[:user_id] = nil
    redirect_to login_url, notice: "ログアウトしました"
  end


  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :profile)
    end


end
