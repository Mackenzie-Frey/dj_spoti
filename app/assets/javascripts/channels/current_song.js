App.current_song = App.cable.subscriptions.create("CurrentSongChannel", {
  connected: function() {
    console.log("connected")


  },


  disconnected: function() {,
  console.log("disconnected")

},


  received: function(data) {
    console.log("I got here. Received function")



  }
});
