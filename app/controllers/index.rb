get '/' do
  erb :index
end

post '/urls' do
  long_url = params[:url]
  short_url = rand(36**6).to_s(36)
  @link = Link.new(:long_url => long_url, :short_url => short_url,
                         :click_count => 0)

  if @link.save
    @short_link = "http://localhost:9393/" + @link[:short_url]
    erb :urls
  else
    erb :bad_page
  end

end


get '/:short_url' do
  link = Link.where(:short_url => params[:short_url]).first
  count = link[:click_count]
  Link.update(link[:id], :click_count => count + 1)
  redirect "http://#{link[:long_url]}"
end

