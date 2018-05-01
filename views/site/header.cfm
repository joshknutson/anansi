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
		<cfset links = "location,insects.list,vegetation,setup" />
		<cfoutput>
		<cfloop list="#links#" index="i">
			<cfset classes = [] />
			<cfif listfirst(rc.action,".") eq i>
				<cfset arrayAppend(classes,"active")/>
			</cfif>

			<li class="#arrayToList(classes," ")#"><a href="#buildURL(i)#" title="#i#">#listfirst(i,".")#</a></li>
		</cfloop>
		</cfoutput>
		</ul>

		<form class="navbar-form form-inline pull-right">
            <input type="email" placeholder="Email">
            <input type="password" placeholder="Password">
            <button type="submit" class="btn">Sign in</button>
          </form>
		</div><!--/.nav-collapse -->
	</div>
</div>