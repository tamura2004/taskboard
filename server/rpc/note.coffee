# Server-side Code
mongoose = require("mongoose")
mongoose.connect("mongodb://localhost/local")
schema = new mongoose.Schema
  x: Number
  y: Number
  text: String
  color: Number
  visible:
    type: Boolean
    default: true

Note = mongoose.model("Note",schema)
# note = new Note x: 100, y: 200, text:"hoge", color:2
# note.save()

# Define actions which can be called from the client using ss.rpc('demo.ACTIONNAME', param1, param2...)
exports.actions = (req, res, ss) ->

  # Example of pre-loading sessions into req.session using internal middleware
  req.use('session')

  # Uncomment line below to use the middleware defined in server/middleware/example
  #req.use('example.authenticated')

  sendMessage: (message) ->
    if message && message.length > 0            # Check for blank messages
      ss.publish.all('newMessage', message)     # Broadcast the message to everyone
      res(true)                                 # Confirm it was sent to the originating client
    else
      res(false)

  find: (cond) ->
    Note.find cond, (err,docs) ->
      if err
        console.log err
      else
        res JSON.stringify docs

  create: (options) ->
    note = new Note options
    note.save()
    ss.publish.all "create", JSON.stringify note

  remove: (id) ->
    console.log id
    Note.findByIdAndUpdate id, visible:false, (err,note) ->
      ss.publish.all "remove", id

  update: (id,update) ->
    console.log id
    console.log update
    Note.findByIdAndUpdate id, update, (err,note) ->
      ss.publish.all "update", JSON.stringify note
