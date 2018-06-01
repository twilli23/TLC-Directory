class Admin::UsersController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'
  include Forms

  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @email_addresses = EmailAddress.where(user_id: @user.id)
    @addresses = Address.where(user_id: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
    @user.profile = @user.build_profile
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new user_params
    @user.assign_profile_params profile_params 
    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end

    # @user = User.new user_params
    # respond_to do |format|
    #   if @user.save
    #     @user.build_profile profile_params
    #     @user.save
    #     # format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     # format.json { render :show, status: :created, location: @user }
    #     format.html { redirect_to new_optional_item_path(user_id: @user.id), notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user.build_profile profile_params
      if @user.update user_params
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      success_str = 'User was successfully destroyed.'
      format.html { redirect_to users_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :last_name, :first_name, :middle_name, :status, :role, :visible, profile: [:title, :department, :biography, :research_interests])
    end

    def profile_params
      params.require(:profile).permit(:title, :department, :biography, :research_interests)
    end

end
