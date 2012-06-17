class WidgetController < ApplicationController

  def show
    @content = render_to_string(:partial => 'widget/widget')
    render :layout => false
  end
end
