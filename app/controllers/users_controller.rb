class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    users = User.all
    message = {'usuarios' => users, 'total'=> users.count}.to_json
    render json: message, status: :ok
  end

  # GET /users/1
  # GET /users/1.json
  #def show
    #render json: @user
  #end

  def show
    if User.exists?(id:params[:id])
      user = User.find(params[:id])
      render json: user
    else
      render json: {error: "Usuario no encontrado"}, status:404
    end
  end

  # POST /users
  # POST /users.json
  def create
    if params[:id].present?
      render json: {error: "No se puede crear usuario con id"}, status: 400
    else
      user = User.new(user_params)
      if user.save
        render json: user, status: 201
      else
        render json: { errors: user.errors}, status: 422
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if User.exists?(id:params[:id])
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    else
      render json: {error: "Usuario no encontrado"}, status:404
    end
  end

  def set_user
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      @user = nil
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:nombre, :apellido, :usuario, :twitter)
  end

end