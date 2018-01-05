<cfparam name="args.title"                  field="page.title" editable="true" />
<cfparam name="args.empty_password"         field="reset_password.empty_password"         default="You must supply a new password." />
<cfparam name="args.passwords_do_not_match" field="reset_password.passwords_do_not_match" default="The passwords you supplied do not match." />
<cfparam name="args.unknown_error"          field="reset_password.unknown_error"          default="An unknown error occurred while attempting to reset your password. Please try again." />

<cfparam name="rc.message" default="" />
<cfparam name="rc.token"   default="" />

<cfoutput>
	<h1>#args.title#</h1>

	<cfswitch expression="#rc.message#">
        <cfcase value="EMPTY_PASSWORD">
            <div class="alert alert-danger" role="alert">#args.empty_password#</div>
        </cfcase>
        <cfcase value="PASSWORDS_DO_NOT_MATCH">
            <div class="alert alert-danger" role="alert">#args.passwords_do_not_match#</div>
        </cfcase>
        <cfcase value="PASSWORD_NOT_STRONG_ENOUGH">
            <div class="alert alert-danger" role="alert">The password must contain at least 1 uppercase, 1 number and 1 symbol.</div>
        </cfcase>
        <cfcase value="UNKNOWN_ERROR">
            <div class="alert alert-danger" role="alert">#args.unknown_error#</div>
        </cfcase>
    </cfswitch>

    <form action="#event.buildLink( linkTo="login.resetPasswordAction" )#" method="post" class="form form-horizontal">
    	<input type="hidden" name="token" value="#rc.token#" />

    	#renderForm(
    		  formName = "login.reset_password"
    		, context  = "website"
    	)#

		<button type="submit" class="btn btn-danger pull-left">#translateResource( uri="page-types.reset_password:submitButton.title" )#</button>

		<div class="form-group">
    		<p class="pull-right"><a href="#event.buildLink( page="login" )#">#translateResource( uri="page-types.reset_password:returnToLoginLink.title" )#</a></p>
    	</div>
    </form>
</cfoutput>