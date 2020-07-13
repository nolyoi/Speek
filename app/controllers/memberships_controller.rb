# frozen_string_literal: true

class MembershipsController < ApplicationController
  def edit
    @membership = CommunityMembership.find(params[:id])
  end

  def update
    @membership = CommunityMembership.find(params[:id])
    if @membership.update_attributes(membership_params)
      flash[:success] = 'CommunityMembership was successfully updated'
      redirect_to community_member_permissions_path(@membership.community)
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:community_membership).permit(:role)
  end
end
