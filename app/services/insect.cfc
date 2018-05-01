component accessors=true {

	variables.insects = { };

    function init(  beanFactory ) {
        variables.helpers = application.helpers;
        variables.beanFactory = beanFactory;
		var insect = "";
		
		// since services are cached insect data we'll be persisted
		// ideally, this would be saved elsewhere, e.g. database
		
		if(fileExists("occurrences.csv")){
			if(!structkeyexists(variables,"insect")){
				file = fileRead("occurrences.csv");
				occurrencesArray = helpers.utils.csvToArray(file);
				occurrencesArray.each(function(item, index) {
					insect = variables.beanFactory.getBean( "insectBean" );
					insect.setId(index);
					insect.setFamily(item.family);
					insect.setScientificName(item.scientificName);
					insect.setLocality(item.locality);
                    insect.setDecimalLongitude(item.DecimalLongitude);
                    insect.setDecimalLatitude(item.DecimalLatitude);
					
					variables.insects[insect.getId()] = insect;
				});
			}
		}else{
			// FIRST
			insect = variables.beanFactory.getBean( "insectBean" );
			insect.setId("1");
			insect.setFamily("Dragonflies");
			insect.setScientificName("Stooge");
			
			variables.insects[insect.getId()] = insect;
			
			// SECOND
			insect = variables.beanFactory.getBean( "insectBean" );
			insect.setId("2");
			insect.setFamily("Bedbug");
			insect.setScientificName("Stooge");
			
			variables.insects[insect.getId()] = insect;
			
			// THIRD
			insect = variables.beanFactory.getBean( "insectBean" );
			insect.setId("3");
			insect.setFamily("Beetle");
			insect.setScientificName("Stooge");
			
			variables.insects[insect.getId()] = insect;
		}

		
		// BEN
		variables.nextid = structcount(variables.insects)+1;
	
		return this;
    }

    function delete( id ) {
        structDelete( variables.insects, id );
    }

    function get( id = "" ) {
        var result = "";
        if ( len( id ) && structKeyExists( variables.insects, id ) ) {
            result = variables.insects[ id ];
        } else {
            result = variables.beanFactory.getBean( "insectBean" );
        }
        return result;
    }
	
	function list() {
        return variables.insects;
    }
	
    function save( insect ) {
		var newId = 0;
		
        if ( len( insect.getId() ) ) {
            variables.insects[ insect.getId() ] = insect;
        } else {
            // BEN
            lock type="exclusive" name="setNextID" timeout="10" throwontimeout="false" {
                newId = variables.nextId;
                variables.nextId = variables.nextId + 1;
            }
            // END BEN
            insect.setId( newId );
            variables.insects[ newId ] = insect;
        }
	}

}
