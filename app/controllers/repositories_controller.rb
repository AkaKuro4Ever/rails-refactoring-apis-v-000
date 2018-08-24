# class RepositoriesController < ApplicationController
#   def index
#     github = GithubService.new
#     github.get_repos
#     response = Faraday.get_repos
#     @repos_array = JSON.parse(response.body)
#   end
#
#   def create
#     github = GithubService.new
#     github.create_repo(params[:name])
#     redirect_to '/'
#   end
# end
class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
