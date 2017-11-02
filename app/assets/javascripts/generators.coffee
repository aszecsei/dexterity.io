this.generateProjectCard = (title, description, open, edit, mdelete) ->
  return """
  <div class="col m12 l6">
    <div class="card small">
      <div class="card-content grey-text text-darken-4">
        <span class="card-title">#{title}</span>
        #{description}
      </div>
      <div class="card-action">
        <a href="#{open}", data-turbolinks="false">Open</a>
        <a href="#{edit}, data-turbolinks="false">Edit</a>
        <a href="#{mdelete}, data-turbolinks="false">Delete</a>
      </div>
    </div>
  </div>
  """