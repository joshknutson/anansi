component accessors=true {

	variables.locations = { };

    function init(  beanFactory ) {
        variables.helpers = application.helpers;
        variables.beanFactory = beanFactory;
		var location = "";
		
		// since services are cached location data we'll be persisted
		// ideally, this would be saved elsewhere, e.g. database
		
			if(!structkeyexists(variables,"location")){
				file = fileRead("occurrences.csv");
				occurrencesArray = helpers.utils.csvToArray(file);
				occurrencesArray.each(function(item, index) {
                    location = variables.beanFactory.getBean( "locationBean" );
                    location.setId(index);
					location.setLocality(item.locality);
                    location.setDecimalLongitude(item.DecimalLongitude);
                    location.setDecimalLatitude(item.DecimalLatitude);
                    
                    variables.locations[location.getId()] = location;
				});
			}
		// BEN
		variables.nextid = structcount(variables.locations)+1;
	
		return this;
    }

    function delete( id ) {
        structDelete( variables.location, id );
    }

    function get( id = "" ) {
        var result = "";
        if ( len( id ) && structKeyExists( variables.location, id ) ) {
            result = variables.locations[ id ];
        } else {
            result = variables.beanFactory.getBean( "locationBean" );
        }
        return result;
    }
	
	function list() {
        return variables.locations;
    }
	
    function save( location ) {
		var newId = 0;
		
        if ( len( location.getId() ) ) {
            variables.locations[ location.getId() ] = location;
        } else {
            // BEN
            lock type="exclusive" name="setNextID" timeout="10" throwontimeout="false" {
                newId = variables.nextId;
                variables.nextId = variables.nextId + 1;
            }
            // END BEN
            location.setId( newId );
            variables.locations[ newId ] = location;
        }
	}

}
