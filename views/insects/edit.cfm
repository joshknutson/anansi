<cfset local.insect = rc.insect>

<h3>Insect Info</h3>
<cfoutput>
    <form class="familiar medium" method="post" action="index.cfm?action=insects.save">
	
<input type="hidden" name="id" value="#local.insect.getId()#">

#helpers.display.input(name="Family",value=local.insect.getFamily())#
#helpers.display.input(name="scientificName",value=local.insect.getscientificName())#
#helpers.display.input(name="locality",value=local.insect.getlocality())#
#helpers.display.input(name="decimalLatitude",value=local.insect.getdecimalLatitude())#
#helpers.display.input(name="decimalLongitude",value=local.insect.getdecimalLongitude())#
<div class="control">
    <button type="submit" class="btn btn-primary">Save Insect</button>
</div>


    </form>
</cfoutput>