<cfparam name="form.required" default="false" />

<cftry>
	<cfset tmp = getSetting('required') />
	<cfcatch>
		<cfset setSettings(required=true) />
		<cfset persistSettings() />
	</cfcatch>
</cftry>

<cfscript>
	//handle settings form post
	if (structKeyExists(form, "submitted")){
		local.update = structNew();
		local.update.required = form.required;
		setSettings(argumentCollection=local.update);
		persistSettings();
		event.data.message.setstatus("success");
		event.data.message.setType("settings");
		event.data.message.settext("PostImage Settings Updated");
	}
</cfscript>

<form method="post" action="">
	<input type="hidden" name="submitted" value="true">
	<fieldset>
		<legend>Settings</legend>
		<p>
			<label for="required">Require Image:</label>
			<span class="field">
				<input type="checkbox" name="required" id="required" value="true" <cfif getSetting('required')>checked="checked" </cfif>/>
				<label for="required" style="font-weight:normal !important;"
				>Require an image attachment to publish (not required for drafts)</label>
			</span>
		</p>
		<input type="submit" value="Save Changes" />
	</fieldset>
</form>
