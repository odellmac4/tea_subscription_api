class Api::V1::CustomersController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    
    if customer
      render json: CustomerSerializer.new(customer), status: :ok
    end
  end
end