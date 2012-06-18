class @UploadHandler
  @initialize: ->
    $('.file_upload').click ->
      form = $('.file_form')[0]
      data = new FormData form
      console.log data
      console.log form
      $.ajax({
        type: 'POST',
        url: '<%= root_url %>file/api/v1/documents.json',
        data: data,
        cache: false,
        contentType: false,
        crossDomain: true,
        processData: false,
        success: (response) ->
          "succeeded" 
        error: (response) ->
          console.log 'file is ' + data   
        })
      $('.file').attr({ value: '' })
