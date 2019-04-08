App.current_song = App.cable.subscriptions.create("CurrentSongChannel", {
  connected: function() {
    console.log("Got here. Connected");


  },


  disconnected: function() {
  console.log("disconnected");

},


  received: function(data) {
    console.log("Received function");
    var song = $('#song-playing');
		song.append(data['song']);
    console.log("")

    // App.messages.send({song: data})
    // console.log("song I received ")
    // console.log(data.party_identifier)



  }
});
