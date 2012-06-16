module SearchesHelper

  def query_path(query)
    "#{root_url}search/api/v1/search?query=#{query}"
  end
end
