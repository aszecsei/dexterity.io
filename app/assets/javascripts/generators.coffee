this.generateProjectCard = (title, description, open, edit, mdelete,id) ->
  return """
  <div class="col m12 l6">
    <div class="card small">
      <div class="card-content grey-text text-darken-4">
        <span class="card-title">#{title}</span>
        #{description}
      </div>
      <div class="card-action">
        <a href="#{open}">Open</a>
        <a class="editbtn modal-trigger" data-turbolinks="false" data="#{id}" href="#{edit}">Edit</a>
        <a class="deletebtn modal-trigger" data-turbolinks="false" data="#{id}" href="#{mdelete}">Delete</a>
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