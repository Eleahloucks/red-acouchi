#CRUD plus list
class ArticlesController < ApplicationController
  #get articles returns a list of article in descending order from date published
  def index
    #payload is what my api sends back to the request
    #should contain my list of articles in desc order
    payload = []
    render json: payload, status: :ok
  end
end
