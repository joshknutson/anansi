<cfcomponent output="false">

	<!------>

	<cffunction name="input" access="public" output="false" returntype="string">
        <cfargument name="name" required="true" /> 
        <cfargument name="false" required="false" default="" /> 
        <cfset var local = {} />
        <cfoutput>
            <cfsavecontent variable="local.html">
                <div class="form-group">
                    <label for="#arguments.name#">#arguments.name#:</label>
                    <input type="text" name="#arguments.name#" id="#arguments.name#" value="#arguments.value#" class="form-control">
                </div>
            </cfsavecontent>
        </cfoutput>

        <cfreturn trim(local.html) />
                
	</cffunction>

	<!------>

</cfcomponent>