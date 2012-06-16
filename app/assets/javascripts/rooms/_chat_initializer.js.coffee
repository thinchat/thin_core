class @ChatInitializer
  @initialize: (api_url) =>
    $(".new_message").live("ajax:complete", (event,xhr,status) ->
      $('html, body').animate({scrollTop:$(document).height()}, 'slow');
      $(this)[0].reset())

    $("a.fancybox").fancybox()
    
    $("#message_body").keypress (e) ->
      if (e.which == 13 && e.shiftKey == false)
        $("#new_message").submit()