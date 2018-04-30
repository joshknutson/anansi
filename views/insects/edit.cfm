<cfset local.insect = rc.insect>

<h3>Insect Info</h3>
<cfoutput>
    <form class="familiar medium" method="post" action="index.cfm?action=insects.save">
	
<input type="hidden" name="id" value="#local.insect.getId()#">

#helpers.display.input(name="Name",value=local.insect.getFirstName())#
<div class="control">
    <button type="submit" class="btn btn-primary">Save Insect</button>
</div>


    </form>
</cfoutput>