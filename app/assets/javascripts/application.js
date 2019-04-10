// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require turbolinks
//= require_tree
//= require jquery
//= require jquery_ujs

//= require_tree ./channels
// require_tree .

var counter = 1;
function addInput(divName){
  var newdiv = document.createElement('div');
  newdiv.innerHTML = "Phone Number" + `<br><input type='text' name='ph_number${counter}' >`;
  document.getElementById(divName).appendChild(newdiv);
  window.scrollTo(0,document.body.scrollHeight);
  counter++;
}

function myFunction() {
  var myForm = document.getElementById('endParty');
 var result = confirm("Are you sure you want to kick all party animals out of this party?");
   if (result) {
      myForm.submit();
   }else {
     event.preventDefault();
   }

};

function djSpoti(partyId, token) {
  window.onSpotifyWebPlaybackSDKReady = () => {
    // let token = '<%= current_user.access_token %>';
    // const partyId = '<%= current_party.identifier %>';
    // const device_id = '23af457167a615683a6ff6194ce955ccaf34622f'
    const player = new Spotify.Player({
      name: 'DJ Spoti',
      getOAuthToken: cb => { cb(token); }
    });
     // Error handling
    player.addListener('initialization_error', ({ message }) => { console.error(message); });
    player.addListener('authentication_error', ({ message }) => { console.error(message); });
    player.addListener('account_error', ({ message }) => { console.error(message); });
    player.addListener('playback_error', ({ message }) => { console.error(message); });

     // Playback status updates
     player.addListener('player_state_changed', state => {
        // broadcast
        $('#current-track').attr('src', state.track_window.current_track.album.images[0].url);
        $('#current-track-name').text(state.track_window.current_track.album.name);
        $('#current-track-artist').text(state.track_window.current_track.artists[0].name);
        $('#current-track-album').text(state.track_window.current_track.name);
        console.log(state);
        fetch(`api/v1/parties/${partyId}/player_state_changed`)

      .then(response => response.json())
      .then(data => console.log('made call'+ JSON.stringify(data)))

    });

     // Ready
    player.addListener('ready', data => {
      console.log('Ready with Device ID', data.device_id);
      play(data.device_id);
    });
     // Not Ready
    player.addListener('not_ready', ({ device_id }) => {
      console.log('Device ID has gone offline', device_id);
    });
     // Connect to the player!
    player.connect();
     // Play the song!
     console.log("playing")
    function play(device_id) {
      var url = `https://api.spotify.com/v1/me/player/play?device_id=${device_id}`
      var myHeaders = new Headers({});
      myHeaders.append("Content-Type", "application/json");
      myHeaders.append("Authorization", `Bearer ${token}`);
      trackList = {
        "uris": [
        "spotify:track:46O6QtxuzX3iZn9hMXoeqo",
        "spotify:track:3SZRNr41jBk5SPS2TCBMmL",
        "spotify:track:2Y0iGXY6m6immVb2ktbseM"
        ]};
      var myInit = {
        method: 'PUT',
        headers: myHeaders,
        body: JSON.stringify(trackList)
      };
      fetch(url, myInit).then(function(response){
        if(response.ok) {
          console.log(response);
          return response.blob();
        }
      });
    };
  };
};

// $(document).ready(function() {
//   $('#endParty').click(function() {
//     var myForm = $('#endParty');
//     confirm("Are you sure you want to kick all party animals out of this party?");
//     if (result) {
//        myForm.submit();
//     }else {
//       event.preventDefault();
//       window.location="/dashboard";
//     }
//   });
// });
