<script type="text/javascript">
$(function(){
	$("#postImage_value").keyup(function(){
		var u = $(this).val();
		$("#postImage_preview").attr('src', u);
	});
});
</script>
<cfoutput>
	<fieldset id="customFieldsFieldset" class="">
		<legend>Post Header Image</legend>
		<img src="#local.postImage#" id="postImage_preview" width="350" alt="You still need to attach an image..." />
		<br/>
		<input type="text" name="postImage_value" id="postImage_value" placeholder="http://" value="#local.postImage#" size="80" />
		<br/>
		<a href="files.cfm" target="_blank">Upload Images here</a>
	</fieldset>
</cfoutput>
