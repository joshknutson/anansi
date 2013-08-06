component extends="frameworks.org.corfield.framework" {

	this.applicationroot = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings["/anansi"] = getDirectoryFromPath(getCurrentTemplatePath());
	this.name = 'anansi';
	this.sessionmanagement = true;
	// note: IsLocalHost on CF returns YES|NO which can't be passed to hibernate
	this.development = IsLocalHost( CGI.REMOTE_ADDR ) ? true : false;

	variables.framework = {
		cacheFileExists = !this.development
		, generateSES = false
		, maxNumContextsPreserved = 1
		, password = ""
		, reloadApplicationOnEveryRequest = this.development
	};


	function setupApplication() {
		// setup bean factory
		var beanfactory = new frameworks.org.corfield.ioc( "/anansi/app/models,/anansi/app/helpers", { singletonPattern = "(Service|Gateway)$" } );
		setBeanFactory( beanfactory );
		variables.helpers = getHelpers();

	}

	function getHelpers() {

		return setHelpers();

	}

	function setHelpers() {
		var local = {};
		var directory = expandpath("/anansi/app/helpers");
		var files = "";
		var file = "";
		var i = "";

		local.base_path = expandPath("\anansi") & "\";

		local.prefix = replace(replaceNoCase(directory,local.base_path,""),"\",".","all") & ".";


		files = DirectoryList(directory ,true ,"query" ,"*.cfc");
		local.helpers = {};


		for(i=0; i<files.recordcount; i++) {
			file = replaceNoCase(files.name,".cfc","");
			 local.helpers[file] = createObject("component",local.prefix&file);
		}

		application.helpers = local.helpers;
		variables.helpers = local.helpers;

		return local.helpers;
	}



}
	/*<cffunction name="setHelpers" access="public" output="false" returntype="any">

		<cfset var local = {} />
		<cfset var local = {} />
		<cfset var directory = expandPath("\resources/helpers") />
		<cfset var files = "" />
		<cfset var file = "" />
		<cfset var i = "" />

		<cfset local.base_path = expandPath("\par") & "\" />

		<cfset local.prefix = replace(replaceNoCase(directory,local.base_path,""),"\",".","all") & "." />

		<cfdirectory action="list" directory="#directory#" name="files" filter="*.cfc" />

		<cfset local.helpers = {} />

		<cfloop query="files">
			<cfset file = replaceNoCase(files.name,".cfc","") />
			<cfset local.helpers[file] = createObject("component",local.prefix&file) />
		</cfloop>

		<cfset application.helpers = local.helpers />
		<cfset variables.helpers = local.helpers />

		<cfreturn local.helpers />


	</cffunction>*/