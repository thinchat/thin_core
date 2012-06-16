module ApplicationHelper
  def cp(path)
    "current" if current_page?(root_url)
  end
end
