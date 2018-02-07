class FiguresController < ApplicationController

  get '/figures/new' do

    erb :'/figures/new'
  end

  post '/figures/new' do
    title = []
    landmarks = []
    titles = params["figure"]["title_ids"]
    landmarks = params["figure"]["landmark_ids"]
    @fig = Figure.new(name: params["figure"]["name"])
    if params["title"]["name"] != ""
      title = Title.find_or_create_by(name: params["title"]["name"])
      title.save
      if titles == nil
        titles = []
      end
      titles << title.id
    end
    if params["landmark"]["name"] != ""
      mark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      mark.save
      if landmarks == nil
        landmarks = []
      end
      landmarks << mark.id
    end
    @fig.title_ids = titles
    @fig.landmark_ids = landmarks
    @fig.save

    redirect :'/figures'
  end

  get '/figures' do
    @figures = Figure.all

    erb :'/figures/show'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    erb :'/figures/figure'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])

    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params["figure"]["name"]
    title = []
    landmarks = []
    titles = params["figure"]["title_ids"]
    landmarks = params["figure"]["landmark_ids"]
    if params["title"]["name"] != ""
      title = Title.find_or_create_by(name: params["title"]["name"])
      title.save
      if titles == nil
        titles = []
      end
      titles << title.id
    end
    if params["landmark"]["name"] != ""
      mark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      mark.save
      if landmarks == nil
        landmarks = []
      end
      landmarks << mark.id
    end
    @figure.title_ids = titles
    @figure.landmark_ids = landmarks
    @figure.save
    redirect :"/figures/#{@figure.id}"
  end

end
