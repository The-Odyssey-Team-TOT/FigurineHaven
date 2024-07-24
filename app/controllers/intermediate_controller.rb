class IntermediateController < ApplicationController
  skip_before_action :authenticate_user!, only: :transition
  def transition
  end
end
