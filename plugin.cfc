<cfcomponent extends="BasePlugin">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />

		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/fusiongrokker/plugins/PostImage") />

		<cfset variables.customFieldKey = "postImage-v1" />

		<!--- set default preferences --->
		<cfset initSettings(
			required = true
		)/>

		<cfreturn this/>
	</cffunction>

	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "PostImage plugin activated. <a href='generic_settings.cfm?event=PostImage-settings&amp;owner=PostImage&amp;selected=PostImage-settings'>Configure it?</a>"/>
	</cffunction>
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "PostImage plugin de-activated. I hope you know what you're doing..."/>
	</cffunction>

	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<!--- no asynchronous events for this plugin --->
		<cfreturn />
	</cffunction>

	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

		<cfset var local = StructNew() />

		<cfswitch expression="#arguments.event.name#">

			<cfcase value="settingsNav">
				<!--- add our settings link --->
				<cfset local.link = structnew() />
				<cfset local.link.owner = "PostImage">
				<cfset local.link.page = "settings" />
				<cfset local.link.title = "PostImage" />
				<cfset local.link.eventName = "PostImage-settings" />
				<cfset arguments.event.addLink(local.link)>
			</cfcase>

			<cfcase value="PostImage-settings">
				<!--- render settings page --->
				<cfsavecontent variable="local.content">
					<cfoutput>
						<cfinclude template="settings.cfm">
					</cfoutput>
				</cfsavecontent>
				<cfset local.data = arguments.event.data />
				<cfset local.data.message.setTitle("PostImage settings") />
				<cfset local.data.message.setData(local.content) />
			</cfcase>

			<cfcase value="beforeAdminPostFormEnd">

				<cfset local.assetPath = getAdminAssetPath() & "ajax/proxy.cfm" />
				<cfsavecontent variable="local.content">
					<cfsilent>
						<cfset local.entryId = arguments.event.item.id />
						<cfif structKeyExists(request, "plugin_PostImage_RawData")>
							<cfset local.postImage = request.plugin_PostImage_RawData />
						<cfelse>
							<cfset local.postImage = "" />
						</cfif>
					</cfsilent>
					<cfinclude template="postForm.cfm">
				</cfsavecontent>
				<cfset arguments.event.setOutputData(arguments.event.getOutputData() & local.content) />

			</cfcase>

			<cfcase value="beforeAdminPostFormDisplay">
				<!--- use this event to hide related entries data from the user in the "custom fields" section... no reason for its raw data to show up --->
				<cfif arguments.event.item.customFieldExists(variables.customFieldKey)>
					<cfset request.plugin_PostImage_RawData = arguments.event.item.getCustomField(variables.customFieldKey).value />
					<cfset arguments.event.item.removeCustomField(variables.customFieldKey) />
				</cfif>
			</cfcase>

			<cfcase value="beforePostAdd,beforePostUpdate">
				<!--- if status is published, and setting "required"=true, don't allow this save (image required) --->
				<cfif getSetting("required") eq true && len(trim(arguments.event.data.rawdata.postImage_value)) eq 0>
					<cfif arguments.event.data.newItem.getStatus() eq "published">
						<cfset arguments.event.message.setStatus("error") />
						<cfset arguments.event.message.setTitle("Post Image is required to publish") />
						<cfset arguments.event.message.setText("Post Image is required to publish") />
						<cfset arguments.event.setContinueProcess(false) />
					<cfelse>
						<!--- draft, allow it to continue --->
						<cfset arguments.event.data.post.setCustomField(variables.customFieldKey, "PostImage", "") />
					</cfif>
				<cfelse>
					<!--- save the photo url as the custom field value for this entry --->
					<cfset arguments.event.data.post.setCustomField(variables.customFieldKey, "PostImage", arguments.event.data.rawdata.postImage_value) />
				</cfif>
			</cfcase>

		</cfswitch>

		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>
