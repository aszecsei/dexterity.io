#= require projects
describe "Projects Controller", ->
  it "should set the projects controller", ->
    expect(app.projects).to.be.an('object')
    expect(app.projects).to.respondTo('index')