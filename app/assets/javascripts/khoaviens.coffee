# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', () ->
	if($("#khoavien_info").hasClass("row"))		
		$("#sinhviens").click ->			
			search("/sinhviens",{khoavien_id: $(this).attr("khoavien_id")},"#sinhvien_list","#show")
		$("#hocphans").click ->	
			search("/hocphans",{khoavien_id: $(this).attr("khoavien_id")},"#hocphan_list","#show")
		$("#giaoviens").click ->			
			search("/giaoviens",{khoavien_id: $(this).attr("khoavien_id")},"#giaovien_list","#show")			