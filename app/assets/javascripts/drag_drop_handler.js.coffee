class @DragDropHandler
  @uploadDraggedFile = (file, length) ->
    reader = new FileReader()
    reader.onerror = (evt) ->
      message
      switch evt.target.error.code
        when 1
          console.log file.name + " not found."
        when 2
          console.log file.name + " has changed on disk, please re-try."
        when 3
          console.log "Upload cancelled."
        when 4
          console.log "Cannot read " + file.name + "."
        when 5
          console.log "File too large for browser to upload."
    reader.onloadend = (evt) ->
      data = evt.target.result
      form = $('.file_form')[0]
      form_data = new FormData form
      form_data.append( 'document[file]', file )
      $.ajax({
        type: 'POST',
        url: '<%= root_url %>file/api/v1/documents.json',
        data: form_data,
        cache: false,
        contentType: false,
        crossDomain: true,
        processData: false,
        success: (response) ->
          console.log form_data   
        error: (response) ->
          console.log "error form" + form_data   
        })
    reader.readAsDataURL(file)
