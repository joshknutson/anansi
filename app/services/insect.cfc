component accessors=true {

	variables.insects = { };

    function init(  beanFactory ) {

        variables.beanFactory = beanFactory;
		var insect = "";
		
		// since services are cached insect data we'll be persisted
		// ideally, this would be saved elsewhere, e.g. database
		
		// FIRST
		insect = variables.beanFactory.getBean( "insectBean" );
		insect.setId("1");
		insect.setFirstName("Dragonflies");
		insect.setLastName("Stooge");
		
		variables.insects[insect.getId()] = insect;
		
		// SECOND
		insect = variables.beanFactory.getBean( "insectBean" );
		insect.setId("2");
		insect.setFirstName("Bedbug");
		insect.setLastName("Stooge");
		
		variables.insects[insect.getId()] = insect;
		
		// THIRD
		insect = variables.beanFactory.getBean( "insectBean" );
		insect.setId("3");
		insect.setFirstName("Beetle");
		insect.setLastName("Stooge");
		
		variables.insects[insect.getId()] = insect;
		
		// BEN
		variables.nextid = 4;
	
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
