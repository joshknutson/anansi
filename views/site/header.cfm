<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		</button>
		<a href="?action=main" class="navbar-brand">Anansi</a>

		<div class="nav-collapse collapse">
		<ul class="nav navbar-nav">
			<cfset links = "locations,insects,vegetation,setup" />
		<cfoutput>
		<cfloop list="#links#" index="i">
			<cfset classes = [] />
			<cfif listfirst(rc.action,".") eq i>
				<cfset arrayAppend(classes,"active")/>
			</cfif>

			<li class="#arrayToList(classes," ")#"><a href="?action=#i#" title="#i#">#i#</a></li>
		</cfloop>
		</cfoutput>
		</ul>
		</div><!--/.nav-collapse -->
	</div>
</div>