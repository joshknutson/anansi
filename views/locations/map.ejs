i need location data to embed a huge map

add location

<script src="http://maps.google.com/maps/api/js?sensor=false&v=3.exp"
          type="text/javascript"></script>

<div id="map" class="col-12" style="height:500px"></div>

  <script type="text/javascript">
  google.maps.visualRefresh = true;

    var locations = [
      ['Bondi Beach', -33.890542, 151.274856, 4],
      ['Coogee Beach', -33.923036, 151.259052, 5],
      ['Cronulla Beach', -34.028249, 151.157507, 3],
      ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
      ['Maroubra Beach', -33.950198, 151.259302, 1]
    ];

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10,
      center: new google.maps.LatLng(31.935796,-109.212155),
      mapTypeId: google.maps.MapTypeId.TERRAIN,
      mapTypeControlOptions: {
		 style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
      }
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;

    for (i = 0; i < locations.length; i++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }
      })(marker, i));
    }
  </script>