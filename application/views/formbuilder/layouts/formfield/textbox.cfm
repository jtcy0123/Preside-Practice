<cfparam name="args.renderedItem" type="string"  />
<cfparam name="args.label"        type="string"  />
<cfparam name="args.id"           type="string"  />
<cfparam name="args.error"        type="string" default=""  />
<cfparam name="args.mandatory"    type="boolean" default="false" />

<cfoutput>
	<div class="form-group">
		<label class="col-sm-offset-3 col-sm-6 center" for="#args.id#">
			#args.label#
			<cfif IsTrue( args.mandatory )>
				<em class="required" role="presentation">
					<sup>*</sup>
				</em>
			</cfif>
		</label>

		<div class="col-sm-offset-3 col-sm-6">
			<div class="clearfix">
				#args.renderedItem#
				<cfif Leln( Trim( args.error ) )>
					<label for="#args.id#" class="error">#args.error#</label>
				</cfif>
			</div>
		</div>
	</div>
</cfoutput>