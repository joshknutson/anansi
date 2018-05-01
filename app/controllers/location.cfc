component accessors=true {

    property locationService;

    function init( fw ) {
        variables.fw = fw;
    }

    function default( rc ) {
        rc.data = variables.locationService.list();
    }

    function delete( rc ) {
        variables.locationService.delete( rc.id );
        variables.fw.frameworkTrace( "deleted location", rc.id );
        variables.fw.redirect( "location.list" );
    }
	
    function edit( rc ) {
        rc.location = variables.locationService.get( argumentCollection = rc );
    }

    function get( rc ) {
        
        rc.data = variables.locationService.get( rc.id );
    }

    function list( rc ) {
        rc.data = variables.locationService.list();
    }

    function save( rc ) {
        var location = getlocationService().get( argumentCollection = rc );
        variables.fw.populate( cfc = location, trim = true );
        variables.locationService.save( location );
        variables.fw.frameworkTrace( "added location", location );
        variables.fw.redirect( "locations.list" );
    }

}
