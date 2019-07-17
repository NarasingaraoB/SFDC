({
	getJsonFromURL : function() 	{
		var query=location.search.substr(1);
        console.log('..query..'+query);
        var result={};
        var parts=query.split("&");
        for(var i=0;i<parts.length;i++)
            {
                var itm=parts[i].split("=")
              console.log('......'+itm[0]); 
                console.log('......'+itm[1]); 
                result[itm[0]]=decodeURIComponent(itm[1]);
            }
        console.log('..query.split.'+parts);
        console.log('..result..'+result);
        return result;
	}
})