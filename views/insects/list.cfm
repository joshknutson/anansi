<cfset local.insects = rc.data>

<link href="https://cdnjs.cloudflare.com/ajax/libs/clusterize.js/0.18.0/clusterize.min.css" media="screen, projection" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/clusterize.js/0.18.0/clusterize.min.js" type="text/javascript"></script>
<div class="clusterize">
    <table>
      <thead>
        <tr>
          <th>Insect</th>
        </tr>
      </thead>
    </table>
    <div id="scrollArea" class="clusterize-scroll">
      <table>
        <tbody id="contentArea" class="clusterize-content">
          <tr class="clusterize-no-data">
            <td>Loading data...</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <script>
    var data = [];
    <cfloop collection="#local.insects#" item="local.id">
      <cfset local.item = local.insects[local.id]>
    <cfoutput>data.push('<tr><td><a href="#buildURL('insects.edit&id=#local.id#')#">#local.item.getFirstName()#</a></td></tr>')</cfoutput>
    </cfloop>
var clusterize = new Clusterize({
  rows: data,
  scrollId: 'scrollArea',
  contentId: 'contentArea'
});
  </script>