component extends="framework.one" {
    // copy this to your application root to use as your Application.cfc
    // or incorporate the logic below into your existing Application.cfc

    // you can provide a specific application name if you want:
    //this.name = hash( getBaseTemplatePath() );
    this.name = 'anansi';

    // any other application settings:
    this.sessionManagement = true;

    // set up per-application mappings as needed:
    this.mappings[ '/framework' ] = expandPath( '../../framework' );
    this.mappings[ '/anansi' ] = getDirectoryFromPath( getCurrentTemplatePath() );

	// FW/1 - configuration:
	variables.framework = {
		home = "main.default",
		trace = true,
		reloadApplicationOnEveryRequest=true
		,diLocations = [
                     "app/controllers","app/beans", "app/services" // to account for the variety of D/I locations in our examples
                    // that allows all our subsystems to automatically have their own bean factory with the base factory as parent
                ]
	};

	function setupApplication() {
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
		for (row in files) { 
			file = replaceNoCase(files.name,".cfc","");
			 local.helpers[file] = createObject("component",local.prefix&file);
		}
	
		application.helpers = local.helpers;
		variables.helpers = local.helpers;
	
		return local.helpers;
	}
}