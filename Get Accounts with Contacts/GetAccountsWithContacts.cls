public with sharing class GetAccountsWithContacts {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(Integer pageSize, Integer pageNumber) {
        Integer offsetSize = (pageNumber - 1) * pageSize;
        return [
            SELECT Id, Name, Phone, Type, Industry, Rating
            FROM Account
            ORDER BY Name
            LIMIT :pageSize OFFSET :offsetSize
        ];
    }

    @AuraEnabled
    public static List<Contact> getContactsByAccount(Id accountId) {
        if (accountId == null) return new List<Contact>();
        return [
            SELECT Id, FirstName, LastName, Email, Phone, Title, Department
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalAccountCount() {
        return [SELECT COUNT() FROM Account];
    }
}
