class UsersController < ApplicationController
  def index
    @users_count = User.count
  end

  def charts
    promo_codes = User.pluck(:promo).uniq

    chart_data = promo_codes.map do |code|
      { name: code, data: User.where(promo: code).group_by_month(:created_at).count }
    end

    render json: chart_data
  end
end
