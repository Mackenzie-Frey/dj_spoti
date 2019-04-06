App.current_song = App.cable.subscriptions.create("CurrentSongChannel", {
  connected: function() {
    console.log("Got here. Connected")


  },


  disconnected: function() {
  console.log("disconnected")

},


  received: function(data) {
    console.log("I got here. Received function")



  }
});
