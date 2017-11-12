#= require generators
describe "Card Generator", ->

  it "should return a card", ->
    card = generateProjectCard("Title", "Desc", "#", "#", "#" )
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
          <a href="#", data-turbolinks="false">Edit</a>
          <a href="#", data-turbolinks="false">Delete</a>
        </div>
      </div>
    </div>
    """)