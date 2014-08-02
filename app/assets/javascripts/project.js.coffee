window.ProjectsShow = ->
  for streamEl in $(".stream")
    loader = new StreamLoader(streamEl)
    loader.load()

class StreamLoader

  constructor: (streamEl)->
    this.$el = $(streamEl)
    @streamElId = this.$el.attr('id')

  load: =>
    @_fetchStream()
      .done (data)=>
        this.$el.replaceWith(data)
        this.$el = $("##{@streamElId}")
      .fail (data)=> @_showError(data)
      .always => 
        this.$el.children('.stream-loading').hide()

  _setCSFR: (xhr)->
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

  _fetchStream: ->
    streamUrl = this.$el.attr("data-uri")
    return $.ajax(
      url: streamUrl,
      beforeSend: @_setCSFR 
    )

  _showError: (data)->
    # TODO make error something nicer than an alert with more specific message
    window.alert("Sorry there was an error.")

