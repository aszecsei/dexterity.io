this.generateProjectCard = (title, description, open, edit, mdelete) ->
  return """
  <div class="col m12 l6">
    <div class="card small">
      <div class="card-content grey-text text-darken-4">
        <span class="card-title">#{title}</span>
        #{description}
      </div>
      <div class="card-action">
        <a href="#{open}">Open</a>
        <a href="#{edit}", data-turbolinks="false">Edit</a>
        <a href="#{mdelete}", data-turbolinks="false">Delete</a>
      </div>
    </div>
  </div>
  """
this.generateIssueCard = (title, description,category,sp,id) ->
  return """
  <div class="card" id ="#{id}">
    <div class="card-content grey-text text-darken-4">
      <span class="card-title">#{title}</span>
      <p>
        #{description}
      </p>
      <div class="chip">
        #{category}
      </div
      <div class="chip">
        SP #{sp}
      </div
    </div>
  </div>
  """