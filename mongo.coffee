# Server-side Code
mongoose = require("mongoose")
mongoose.connect("mongodb://localhost/local")
schema = new mongoose.Schema x: Number, y: Number, text: String, color: Number, visible: type: Boolean, default: true
Note = mongoose.model("Note",schema)
