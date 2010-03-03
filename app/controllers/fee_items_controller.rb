class FeeItemsController < ApplicationController
  # System Log stuff added

  def new
    @fee_item = (params[:tag]+"FeeItem").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def create

    respond_to do |format|
      format.js
    end
  end

  def edit

    respond_to do |format|
      format.js
    end
  end

  def update

    respond_to do |format|
      format.js
    end
  end

  def destroy

    respond_to do |format|
      format.js
    end
  end

  def retrieve

    respond_to do |format|
      format.js
    end
  end
end
