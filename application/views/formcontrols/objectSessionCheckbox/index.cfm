<cfscript>
    inputName      = args.name            ?: "";
    inputId        = args.id              ?: "";
    inputClass     = args.class           ?: "";
    values         = args.values          ?: "";
    defaultValue   = args.defaultValue    ?: "";
    extraClasses   = args.extraClasses    ?: "";
    values         = args.values          ?: "";
    labels         = len( args.labels )   ?  args.labels : args.values;
    defaultOptionLabel = args.defaultOptionLabel ?: "Please select";
    required           = args.required           ?: "false";
    disable            = args.disable            ?: "false";
    multiple           = args.multiple           ?: "false";

    if ( IsSimpleValue( values ) ) { values = ListToArray( values ); }
    if ( IsSimpleValue( labels ) ) { labels = ListToArray( labels ); }

    value  = event.getValue( name=inputName, defaultValue=defaultValue );
    if ( not IsSimpleValue( value ) ) {
        value = "";
    }

    value = HtmlEditFormat( value );
    valueFound = false;
    event.include("ext-custom-chosen");
</cfscript>

<cfoutput>
    <select
        id="#inputId#"
        name="#inputName#"
        class="form-control #extraClasses# custom-select"
        tabindex="#getNextTabIndex()#"
        <cfif required>required</cfif> <cfif disable >disabled="disabled"</cfif>
        <cfif IsBoolean( multiple ) && multiple>multiple="#multiple#"</cfif>
    >
        <option value="">#defaultOptionLabel#</option>
        <cfloop array="#values#" index="i" item="selectValue">
            <option
                value="#HtmlEditFormat( selectValue )#"
                <cfif value EQ selectValue > selected="selected"</cfif>
                <!--- <cfif arraylen(dataInfo) gte i and len(dataInfo[i]) > data-info="#dataInfo[i]#"</cfif>
                <cfif arraylen(dataInfo2) gte i and len(dataInfo2[i]) > data-info-2="#dataInfo2[i]#"</cfif> --->
            >
                #HtmlEditFormat(  labels[i] ?: ""  )#
            </option>
        </cfloop>
    </select>
    <cfloop array="#values#" index="i" item="selectValue">
        <cfset checked    = ListFindNoCase( value, selectValue ) />
        <cfset valueFound = valueFound || checked />
        <cfset elementId  = inputId & "_" & i />

        <div class="checkbox">
            <label>
                <input type="checkbox" id="#elementId#" name="#inputName#" value="#HtmlEditFormat( selectValue )#" class="#inputClass# #extraClasses#" tabindex="#getNextTabIndex()#" <cfif checked>checked</cfif>>
                #HtmlEditFormat( translateResource( labels[i] ?: "", labels[i] ?: "" ) )#
            </label>
        </div>
    </cfloop>
    <label for="#inputName#" class="error"></label>
    <input type="hidden" name="evid" value="#rc.evid?:""#">
</cfoutput>