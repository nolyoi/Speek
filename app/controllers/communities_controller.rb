# frozen_string_literal: true

class CommunitiesController < ApplicationController
  include CommunitiesHelper
  before_action :set_community, only: [:show, :edit, :update, :destroy, :join, :leave]

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.all
  end

  # GET /communities/1
  # GET /communities/1.json
  def show; end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit; end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    membership = CommunityMembership.new(community_id: @community.id, user_id: current_user.id)
    if membership.save
      flash[:success] = "You are now a member of #{@community.name}!"
      redirect_to community_path(@community)
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
    end
  end

  def leave
    membership = current_user.community_memberships.find_by(community_id: @community.ids)
    if membership.destroy
      flash[:success] = "You have successfully left #{@community.name}!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Sorry, something went wrong. Please try again."
      redirect_to community_path(@community)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def community_params
    params.require(:community).permit(:name, :description, :post_id, :admin_id)
  end
end
