@isTest
global class AnimalsHttpCalloutMock implements System.HttpCalloutMock{
	global System.HttpResponse respond(System.HttpRequest req)
    {
        HttpResponse response=new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
		response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(200);

        return response;
    }
}