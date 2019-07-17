public with sharing class  autoCompleteSearch {

    public String selectedMovie { get; set; }

    public String searchTerm { get; set; }
    
    @RemoteAction
    public static List<City__c> searchMovie(String searchTerm) {
        System.debug('Movie Name is: '+searchTerm );
        List<City__c> cities = Database.query('Select Id, Name from City__c where name like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'');
        return cities;
    }
}