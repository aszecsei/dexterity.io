#= require generators
describe "Card Generator", ->

  it "should return a card", ->
    card = generateProjectCard("Title", "Desc", "#", "#", "#","2" )
    expect( card ).to.be.a('string');
    expect( card ).to.eq("""
    <div class="col m12 l6">
      <div class="card small">
        <div class="card-content grey-text text-darken-4">
          <span class="card-title">Title</span>
          Desc
        </div>
        <div class="card-action">
          <a href="#">Open</a>
          <a class="editbtn modal-trigger" data-turbolinks="false" data="2" href="#">Edit</a>
          <a class="deletebtn modal-trigger" data-turbolinks="false" data="2" href="#">Delete</a>
        </div>
      </div>
    </div>
    """)