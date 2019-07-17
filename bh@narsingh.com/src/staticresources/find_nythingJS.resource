(function( $, undefined ) {
   $('ul.tbs_u_list li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.tbs_u_list li').removeClass('current');
        $('.tbs-content').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
    });                   
});