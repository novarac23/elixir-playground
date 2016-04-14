defmodule Issues.GithubIssues do
  
  require Logger

  @user_agent  [ {"User-agent", "Elixir dave@pragprog.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{ body: body, status_code: 200 }}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end 
    {:ok, :jsx.decode(body)}
  end

  def handle_response({:ok, %{ body: body, status_code: _ }}) do
    Logger.error "There was an error"
    {:error, :jsx.decode(body)}
  end
end
