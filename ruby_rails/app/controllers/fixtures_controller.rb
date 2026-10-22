require "base64"
require "json"

class FixturesController < ApplicationController
  # FX-BEGIN RB-V01
  def sqli
    @users = User.where("name = '#{params[:name]}'")
  end
  # FX-END RB-V01

  # FX-BEGIN RB-B01
  def sqli_safe
    @users = User.where(name: params[:name])
  end
  # FX-END RB-B01

  # FX-BEGIN RB-V02
  def cmd
    system("ls #{params[:dir]}")
  end
  # FX-END RB-V02

  # FX-BEGIN RB-B02
  def cmd_safe
    system("ls", "-l", "/srv/reports")
  end
  # FX-END RB-B02

  # FX-BEGIN RB-V03
  def go
    redirect_to params[:url]
  end
  # FX-END RB-V03

  # FX-BEGIN RB-B03
  def go_safe
    redirect_to root_path
  end
  # FX-END RB-B03

  # FX-BEGIN RB-V04
  def load_state
    @state = Marshal.load(Base64.decode64(params[:data]))
  end
  # FX-END RB-V04

  # FX-BEGIN RB-B04
  def load_state_safe
    @state = JSON.parse(params[:data])
  end
  # FX-END RB-B04

  # FX-BEGIN RB-V06
  def create_user
    @user = User.new(params.permit!)
    @user.save
  end
  # FX-END RB-V06

  # FX-BEGIN RB-B07
  def create_user_safe
    @user = User.new(params.require(:user).permit(:name, :email))
    @user.save
  end
  # FX-END RB-B07

  def show
  end
end
