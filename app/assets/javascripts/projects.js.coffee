window.ProjectsIndex = ->
  loader = new ProjectsLoader()
  loader.load()

class ProjectsLoader

  constructor: ->
    this.$projectsList = $("#main")
    @projectsUrl = window.location

  load: ->
    $.ajax(url: @projectsUrl)
      .done (data)=> this.$projectsList.html(data)
      .fail (data)=> @_showError(data)

  _showError: (data)->
    # TODO make error something nicer than an alert with more specific message
    window.alert("Sorry there was an error.")

