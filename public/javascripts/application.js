// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    // global events
    $('#global-progress').bind('ajaxStart', function(){ $(this).fadeIn(); });
    $('#global-progress').bind('ajaxStop', function(){ $(this).fadeOut(); });

    // selector

    $( ".selectable" ).selectable({
	stop: function() {
	    var result = '';
	    $( ".ui-selected", this ).each(function() {
		result += ' ' + $( this ).data('role');
	    });

            $.ajax({
	        type: "post",
	        url: "/users/" + $('#user-profile').data('user-id') + "/set_roles",
	        data: "roles=" + result,
	        dataType: 'script'
            });

	}
    });

})