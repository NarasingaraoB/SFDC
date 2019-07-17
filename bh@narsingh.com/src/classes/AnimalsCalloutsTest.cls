@isTest
public class AnimalsCalloutsTest {
@isTest static void testGetCallout()
{
    StaticResourceCalloutMock mock=new StaticResourceCalloutMock();
    mock.setStaticResource('GetAnimalResource');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
   System.Test.setMock(HttpCalloutMock.class, mock);
    HttpResponse result= AnimalsCallouts.makeGetCallout();
    System.assertNotEquals(null, result);
    System.assertEquals(200, result.getStatusCode());
    Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(result.getBody());
    List<Object> animals=(List<Object>)results.get('animals');
    system.assertEquals(3, animals.size());
}
@isTest static void testPostCallout()
{
    system.Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
    HttpResponse response=AnimalsCallouts.makePostCallout();
    String contentType=response.getHeader('Content-Type');
    System.assert(contentType=='application/json');
    String actualValue=response.getBody();
    System.debug(response.getBody());
    String expectedValue='{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
    System.assertEquals(expectedValue, actualValue);
    System.assertEquals(200, response.getStatusCode());
}
}