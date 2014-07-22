window.ProjectsIndex = ->
  loader = new ProjectsLoader()
  loader.load()

class ProjectsLoader

  constructor: ->
    this.$projectsList = $("#main")
    @projectsUrl = window.location

  _setCSFR: (xhr)->
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

  load: ->
    $.ajax(url: @projectsUrl, beforeSend: @_setCSFR)
      .done (data)=> this.$projectsList.html(data)
      .fail (data)=> @_showError(data)

  _showError: (data)->
    # TODO make error something nicer than an alert with more specific message
    window.alert("Sorry there was an error.")

