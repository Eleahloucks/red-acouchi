#CRUD plus list
class ArticlesController < ApplicationController

  # `GET /articles` -
  # Returns a JSON collection of all articles,
  # ordered by publishing date in descending order.
  def index
    #payload is what my api sends back to the request
    #should contain my list of articles in desc order
    show_all
  end

  #`GET /articles/<id>`
  #Returns an article with the given id in JSON format, if it exists.
  def show
    id = params[:id]
    if id.present?
      show_article(id)
    else
      show_all
    end
  end

  def show_all
    #create payload - unsure how to use it.
    payload = []
    Article.published_at_desc.each do |article|
      payload << article.public_attributes
    end
    render json: payload, status: :ok
  end

  #called only if there is an article id
  def show_article(id)
    #find article by id
    article = Article.find_by_id(id)
    #if article is found by id
    if article.present?
      #show articles in json with a 200 status ok
      render json: article.public_attributes, status: :ok
    else
      #if nothing is found show 404 error not found
      render nil, status: :not_found
    end
  end

  #`POST /articles`
  #If the request contains a valid article:
  #     - Insert the article into the SQLite database.
  #     - Return the newly-created article's information in JSON format.
  def create
    #create saves to disk, new saves in memory
    article = Article.new(permitted)
    #we want to check if it can saves because we will have validation tests
    if article.save
      #save successfully
      #returns created article
      render json: article.public_attributes, status: :created
    else
      #didn't save
      render nil, status: :unprocessable_entity
    end
  end

  #DELETE`, `PUT`, and `PATCH` requests to `/articles/<id>`
  # - Returns response code 405 because this public API does not allow articles to be deleted or modified.
  def update
    #put and patch - returns a 405
    render nil, status: :method_not_allowed
  end

  def destroy
    #delete - returns a 405
    render nil, status: :method_not_allowed
  end

  private
    def permitted
          #all fields are permitted, id is not included in required bc it is automatically created
          params.permit(:title, :content, :author, :category, :published_at)
    end
end
