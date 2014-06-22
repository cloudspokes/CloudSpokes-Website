require 'members'
class MembersController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate

  def index
    @members = Members.get_members()
  end

  def new
    @member = User.new "ProfileId" => Profile.first.Id
  end

  def show
    params['id']
    @member_detail = Members.show_member(params['id'])
  end

  def create
    #User.create User.coerce_params(params[:user])
    #redirect_to users_path
    render :text => 'create a new member'
  end

end
