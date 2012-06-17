module ApplicationHelper
  def current_path_check(path)
    "current" if current_page?(root_url)
  end
end
