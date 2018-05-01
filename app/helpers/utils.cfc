<cfcomponent output="false" hint="This component provides some basic utility helper functions">

    <!------>
    
    <cffunction name="csvToQuery" access="public" output="false" returntype="query">
		<cfargument name="file_path" type="string" required="false" />
		<cfargument name="column_names" type="string" required="false" default="" hint="Pass the column names if you do not already have it in the CSV file" />
		<cfargument name="file_content" type="string" required="false" hint="optionally pass in the contents of the file directly" />
		<cfargument name="setAllTypesToVarchar" type="boolean" default="false" />
		<cfargument name="delimiter" required="false" default="," hint="tab = chr(9),comma = (,), others probably" />
		<cfargument name="FileCharset" required="false" default="" hint="passes along to reading the file" />

		<cfset var local = {} />

		<!--- allow the option of passing in the file_content directly --->
		<cfif structKeyExists(arguments, "file_content")>
			<cfset local.file_content = arguments.file_content />
		<cfelseif arguments.FileCharset neq "">
			<cfset local.file_content = fileRead(arguments.file_path,arguments.FileCharset) />
		<cfelse>
			<cfset local.file_content = fileRead(arguments.file_path) />
		</cfif>

		<cfset local.delimiter = arguments.delimiter />
		<cfset local.qualifier = """" />
		<cfset local.lineDelimiter = chr(10) />
		<cfset local.file_content = trim(local.file_content.ReplaceAll("\r?\n", local.lineDelimiter)) />
		<cfset local.delimiters = local.file_content.ReplaceAll("[^\#arguments.delimiter#\#local.lineDelimiter#]+","").ToCharArray() />
		<cfset local.file_content = (" " & local.file_content) />
		<cfset local.file_content = local.file_content.ReplaceAll("([\#arguments.delimiter#\#local.lineDelimiter#]{1})", "$1 ") />
		<cfset local.tokens = local.file_content.Split("[\#arguments.delimiter#\#local.lineDelimiter#]{1}") />
		<cfset local.rowIndex = 1 />
		<cfset local.isInValue = false />
		<cfset local.rows = [] />
		<cfset arrayAppend(local.rows, arrayNew(1)) />

		<cfloop from="1" to="#count(local.tokens)#" index="local.tokenIndex">

			<cfset local.fieldIndex = count(local.rows[local.rowIndex]) />

			<cfset local.token = local.tokens[local.tokenIndex].ReplaceFirst("^.{1}", "") />

			<cfif len(local.qualifier)>

				<cfif local.isInValue>

					<cfset local.token = local.token.ReplaceAll("\#local.qualifier#{2}", "{QUALIFIER}") />

					<cfset local.rows[local.rowIndex][local.fieldIndex] = (local.rows[local.rowIndex][local.fieldIndex] & local.delimiters[local.tokenIndex - 1] & local.token) />

					<cfif (right(local.token, 1) eq local.qualifier)>

						<cfset local.rows[local.rowIndex][local.fieldIndex] = local.rows[local.rowIndex][local.fieldIndex].ReplaceFirst(".{1}$", "") />

						<cfset local.isInValue = false />

					</cfif>

				<cfelse>

					<cfif (left(local.token, 1) eq local.qualifier)>

						<cfset local.token = local.token.ReplaceFirst("^.{1}", "") />

						<cfset local.token = local.token.ReplaceAll("\#local.qualifier#{2}", "{QUALIFIER}") />

						<cfif (right(local.token, 1) eq local.qualifier)>

							<cfset arrayAppend(local.rows[local.rowIndex], local.token.ReplaceFirst(".{1}$", "")) />

						<cfelse>

							<cfset local.isInValue = true />

							<cfset arrayAppend(local.rows[local.rowIndex], local.token) />

						</cfif>

					<cfelse>

						<cfset arrayAppend(local.rows[local.rowIndex], local.token) />

					</cfif>


				</cfif>

				<cfset local.rows[local.rowIndex][count(local.rows[local.rowIndex])] = replace(local.rows[local.rowIndex][count(local.rows[local.rowIndex])], "{QUALIFIER}", local.qualifier, "all") />

			<cfelse>

				<cfset arrayAppend(local.rows[local.rowIndex], local.token) />

			</cfif>

			<cfif ((not local.isInValue) and (local.tokenIndex lt count(local.tokens)) and (local.delimiters[local.tokenIndex] eq local.lineDelimiter))>

				<cfset arrayAppend(local.rows, arrayNew(1)) />

				<cfset local.rowIndex = (local.rowIndex + 1) />

			</cfif>

		</cfloop>

		<cfset local.columns = {} />

		<cfif arguments.column_names eq "">
			<cfset local.columns.struct = {} />
			<cfset local.columns.array = [] />

			<cfset local.rowCount = arrayLen(local.rows) />

			<cfloop from="1" to="#local.rowCount#" index="local.rowIndex">

				<cfif local.rowIndex gt 1 and local.rowIndex lte local.rowCount>
					<cfset queryAddRow(local.query) />
				</cfif>

				<cfloop from="1" to="#count(local.rows[local.rowIndex])#" index="local.fieldIndex">

					<cfset local.value = trim(javaCast("string", local.rows[local.rowIndex][local.fieldIndex])) />

					<cfif local.rowIndex eq 1>

						<!--- Added to prevent errors on empty column headers --->
						<cfif local.value neq "">
							<cfset local.value = replaceNoCase(local.value, " ", "_", "all") />
							<cfset local.value = replaceNoCase(local.value, "/", "_", "all") />
							<cfset local.value = replaceNoCase(local.value, "\", "_", "all") />
							<cfset local.value = replaceNoCase(local.value, chr(34), "", "all") />
							<cfset local.value = helpers.string.dehumanize(local.value) />
							<cfif isNumeric(left(local.value,1))>
								<cfset local.value = '_' & local.value />
							</cfif>

							<cfset local.columns.struct[local.fieldIndex] = local.value />
							<cfset arrayAppend(local.columns.array, local.value) />
						</cfif>

					<cfelseif local.rowIndex lte local.rowCount>

						<!--- Added to prevent errors on empty column headers --->
						<cfif local.value neq "" and structKeyExists(local.columns.struct, local.fieldIndex)>
							<cfset querySetCell(local.query, local.columns.struct[local.fieldIndex], local.value) />
						</cfif>

					</cfif>

				</cfloop>

				<cfif local.rowIndex eq 1>

					<!--- added to prevent issues with query of queries --->
					<cfif arguments.setAllTypesToVarchar>
						<cfset local.types = "" />

						<cfloop from="1" to="#arrayLen(local.columns.array)#" index="local.i">
							<cfset local.types = listAppend(local.types, "cf_sql_varchar") />
						</cfloop>

						<cfset local.query = queryNew(arrayToList(local.columns.array), local.types) />
					<cfelse>
						<cfset local.query = queryNew(arrayToList(local.columns.array)) />
					</cfif>
				</cfif>

			</cfloop>
		<cfelse>
			<cfset local.rowCount = count(local.rows) />

			<!--- added to prevent issues with query of queries --->
			<cfif arguments.setAllTypesToVarchar>
				<cfset local.types = "" />

				<cfloop from="1" to="#listLen(arguments.column_names)#" index="local.i">
					<cfset local.types = listAppend(local.types, "cf_sql_varchar") />
				</cfloop>

				<cfset local.query = queryNew(arguments.column_names, local.types) />
			<cfelse>
				<cfset local.query = queryNew(arguments.column_names) />
			</cfif>

			<cfset local.columns.array = listToArray(arguments.column_names) />

			<cfloop from="1" to="#local.rowCount#" index="local.rowIndex">

				<cfif local.rowIndex lte local.rowCount>
					<cfset queryAddRow(local.query) />
				</cfif>

				<cfloop from="1" to="#count(local.rows[local.rowIndex])#" index="local.fieldIndex">

					<cfset local.value = trim(javaCast("string", local.rows[local.rowIndex][local.fieldIndex])) />

					<cfif local.rowIndex lte local.rowCount>

						<cftry>
							<cfset querySetCell(local.query, local.columns.array[local.fieldIndex], local.value) />

							<cfcatch>
							</cfcatch>
						</cftry>

					</cfif>

				</cfloop>

			</cfloop>
		</cfif>

		<cfreturn local.query />

    </cffunction>
    
    <!------>

    <cffunction name="csvToArray" access="public" output="false" returntype="array">
		<cfargument name="strCSV" required="true" />
		<cfargument name="columnList" required="false" default="" hint="column_1,column_2,column_3,..." />

		<cfset var local = {} />

		<cfset local.loopCount = 0 />
		<cfset local.columnHeaderValues = true />
		<cfset local.columnArray = arrayNew(1) />

		<!--- Trim data values. --->
		<cfset local.strCSV = trim(arguments.strCSV) />

		<!--- Get the regular expression to match the tokens. --->
		<cfset local.strRegEx = ("(""(?:[^""]|"""")*""|[^"",\r\n]*)" & "(,|\r\n?|\n)?") />

		<!--- Create a compiled Java regular expression pattern object based on the pattern above. --->
		<cfset local.objPattern = createObject("java","java.util.regex.Pattern").Compile(javaCast( "string",local.strRegEx)) />

		<!--- Get the pattern matcher for our target text (the CSV data).  This will allows us to iterate over all the data fields. --->
		<cfset local.objMatcher = objPattern.Matcher(javaCast("string",local.strCSV)) />

		<!--- Create an array to hold the CSV data. We are going to create an array of arrays in which each nested array represents a row in the CSV data file. --->
		<cfset local.arrData = arrayNew(1) />

		<!--- Start off with a new struct for the new data. --->
		<cfset local.arrayStruct = {} />

		<!--- Use the Java pattern matcher to iterate over each of the CSV data fields using the regular expression defined above.
 			Each match will have at least the field value and possibly an optional trailing delimiter. --->
		<cfloop condition="local.objMatcher.Find()">
			<cfset local.loopCount++ />
			<!--- Get the field token value. --->
			<cfset local.value = local.objMatcher.group(javaCast("int",1)) />

			<!--- Remove the field qualifiers (if any). --->
			<cfset local.value = local.value.replaceAll(javaCast("string","^""|""$"),javaCast("string","")) />

			<!--- Unesacepe embedded qualifiers (if any). --->
			<cfset local.value = local.value.replaceAll(javaCast("string","(""){2}"),javaCast("string","$1")) />

			<!--- If building the Column Header else add to struct --->
			<cfif local.columnHeaderValues eq true>
				<!--- Create a Column Array position for each csv column --->
				<cfset arrayAppend(local.columnArray,'') />

				<!--- If column list was passed in or column header matches what was passed in, set new struct key and add struct key to column array at position --->
				<cfif arguments.columnList eq '' or listFindNoCase(arguments.columnList,local.value) gt 0>
					<cfset local.arrayStruct[local.value] = '' />
					<cfset local.columnArray[local.loopCount] = local.value />
				</cfif>
			<cfelse>
				<!--- Add the field value to the struct. --->
				<cfif arrayLen(local.columnArray) gte local.loopCount and local.columnArray[local.loopCount] neq ''>
					<cfset local.arrayStruct[local.columnArray[local.loopCount]] = local.value />
				</cfif>
			</cfif>

			<!--- Get the delimiter. If no delimiter group was matched, this will destroy the variable. --->
			<cfset local.delimiter = local.objMatcher.group(javaCast("int",2)) />

			<!--- Check for delimiter. --->
			<cfif structKeyExists(local,"delimiter")>
				<!--- Check to see if we need to start a new array to hold the next row of data. Need to do this if the delimiter found is NOT a field delimiter. --->
				<cfif (local.delimiter NEQ ",")>
					<!--- Re-Start loop counter.  Append this row sturct to the return array.  Empty Struct For Next Set of Values --->
					<cfset local.loopCount = 0 />
					<cfif local.columnHeaderValues neq true>
						<cfset arrayAppend(local.arrData,duplicate(local.arrayStruct)) />
						<cfset local.arrayStruct = structEmpty(local.arrayStruct) />
					</cfif>
					<cfset local.columnHeaderValues = false />
				</cfif>
			<cfelse>
				<!--- If there is no delimiter, then we are done parsing the CSV file data. Break out rather than just ending the loop to make sure we don't get any extra data. --->
				<cfset arrayAppend(local.arrData,duplicate(local.arrayStruct)) />
				<cfbreak />
			</cfif>
		</cfloop>

		<cfreturn local.arrData />

    </cffunction>
    
    <!------>

    <cffunction name="structEmpty" access="public" output="false" returntype="struct">
		<cfargument name="structToEmpty" required="true" />

		<cfset var item = '' />

		<cfloop collection="#arguments.structToEmpty#" item="item">
			<cfset arguments.sturctToEmpty[item] = '' />
		</cfloop>

		<cfreturn arguments.structToEmpty />

    </cffunction>
    
    <!------>

</cfcomponent>