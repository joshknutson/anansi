<!DOCTYPE html>
<html>
	<cfsilent>

<cfparam name="rc.message" default="#arrayNew(1)#">
</cfsilent>
<head>
<title>Anansi</title>
<base href="http://localhost/anansi/" />
<cfinclude template="_includes/meta.cfm" />
<cfinclude template="_includes/css.cfm" />
<cfinclude template="_includes/js.cfm" />
</head>
<body>
<cfoutput>
#view( 'site/header' )#
<div class="container" style="margin-top: 60px;">

	<div class="body-content">
			<!--- display any messages to the user --->
			<cfif not arrayIsEmpty(rc.message)>
				<cfloop array="#rc.message#" index="msg">
					<p>#msg#</p>
				</cfloop>
			</cfif>
			#body#
	</div>

	#view( 'site/footer' )#
	</cfoutput>

</div>

</body>
</html>