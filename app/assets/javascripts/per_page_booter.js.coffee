# On document ready run function corresponding to page's controller and action
# Inspects body tag for data attribute page e.g. <body data-page="ProjectsShow">
# In this example, the function ProjectsShow is called when the page is ready
# ProjectsShow corresponds to controller: projects and action: show

ready = ->
  page = $('body').data('page')
  window[page]() if "function" == typeof window[page]

$(document).ready(ready)
$(document).on('page:load', ready)
      
