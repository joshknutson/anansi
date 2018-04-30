component accessors=true {

    property insectService;

    function init( fw ) {
        variables.fw = fw;
    }

    function default( rc ) {
        rc.message = ["Welcome to the Framework One insect Manager application demo!"];
        //rc.data = get(rc);
    }

    function delete( rc ) {
        variables.insectService.delete( rc.id );
        variables.fw.frameworkTrace( "deleted insect", rc.id );
        variables.fw.redirect( "insect.list" );
    }
	
    function edit( rc ) {
        rc.insect = variables.insectService.get( argumentCollection = rc );
    }

    function get( rc ) {
        
        rc.data = variables.insectService.get( rc.id );
    }

    function list( rc ) {
        rc.data = variables.insectService.list();
    }

    function save( rc ) {
        var insect = getinsectService().get( argumentCollection = rc );
        variables.fw.populate( cfc = insect, trim = true );
        variables.insectService.save( insect );
        variables.fw.frameworkTrace( "added insect", insect );
        variables.fw.redirect( "insects.list" );
    }

}
