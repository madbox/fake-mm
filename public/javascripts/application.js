// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    // global events
    $('#global-progress').bind('ajaxStart', function(){ $(this).fadeIn(); });
    $('#global-progress').bind('ajaxStop', function(){ $(this).fadeOut(); });
})