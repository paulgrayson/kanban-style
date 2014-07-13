window.ProjectsShow = ->
  for streamEl in $(".stream")
    loader = new StreamLoader(streamEl)
    loader.load()

class StreamLoader

  constructor: (streamEl)->
    this.$el = $(streamEl)
    this.$loadingIndicator = this.$el.children('.stream-loading')

  load: ->
    @_showLoading()
    @_fetchStream()
      .done (data)=> this.$el.replaceWith(data)
      .fail (data)=> @_showError(data)

  _fetchStream: ->
    streamUrl = this.$el.attr("data-uri")
    return $.ajax(url: streamUrl)

  _showLoading: ->
    this.$loadingIndicator.show()

  _hideLoading: ->
    this.$loadingIndicator.hide()

  _showError: (data)->
    # TODO make error something nicer than an alert with more specific message
    window.alert("Sorry there was an error.")

