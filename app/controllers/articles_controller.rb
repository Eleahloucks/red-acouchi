#CRUD plus list
class ArticlesController < ApplicationController
  #get articles returns a list of article in descending order from date published
  def index
    #payload is what my api sends back to the request
    #should contain my list of articles in desc order
    #Article.order(published_at: :desc)
    payload = [@article = Article.order(published_at: :desc)]
    render json: payload, status: :ok
  end

  def create
    #If the request contains a valid article:
    #     - Insert the article into the SQLite database.
    #     - Return the newly-created article's information in JSON format.

    #create saves to disk, new saves in memory
    @article = Article.new(permitted)
    #we want to check if it can saves because we will have validation tests
    if @article.save
      #save successfully
      #returns created article
      render json: @article, status: :created
    else
      #didn't save
      render nil, status: :unprocessable_entity
    end
  end

  def update
    render nil, status: :method_not_allowed
  end

  def destroy
    render nil, status: :method_not_allowed
  end

  private
    def permitted
          #all fields are permitted, id is not included in required bc it is automatically created
          params.permit(:title, :content, :author, :category, :published_at)
    end
end
