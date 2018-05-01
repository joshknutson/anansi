<cfset local.locations = rc.data>

<script src="http://maps.google.com/maps/api/js?sensor=false&v=3.exp&key=AIzaSyB2U-5KqzkbyuCGlWZAxiVnGu4_i9bzDdo" type="text/javascript"></script>

<div id="map" class="col-12" style="height:500px"></div>
  <script>
  google.maps.visualRefresh = true;

    var locations = [
      ['Thrifty White Drug', 45.062093, -93.411633, 5],
      ['Bloomington, MN', 44.840400, -93.298059, 3],
      ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
      ['Maroubra Beach', -33.950198, 151.259302, 1]
      <cfoutput>
      <cfloop collection="#local.locations#" item="local.id">
        <cfif local.id lte 10000>
        <cfset local.item = local.locations[local.id]>
        <cfif local.id neq 0>,</cfif>['#jsstringformat(local.item.getlocality())#', #local.item.getdecimalLatitude()#, #local.item.getdecimalLongitude()#, #local.id#]
        </cfif>
      </cfloop>
    </cfoutput>
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