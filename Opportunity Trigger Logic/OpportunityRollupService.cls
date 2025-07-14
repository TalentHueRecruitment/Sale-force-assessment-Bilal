public class OpportunityRollupService {
    public static void recalculateSalesByWoodType(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : opportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }

        if (accountIds.isEmpty()) return;

        // Aggregate total amounts by Account and Wood Type
        List<AggregateResult> groupedResults = [
            SELECT AccountId, Wood_Type__c, SUM(Amount) total
            FROM Opportunity
            WHERE AccountId IN :accountIds AND IsDeleted = FALSE
            GROUP BY AccountId, Wood_Type__c
        ];

        // Map<AccountId, Map<WoodType, Amount>>
        Map<Id, Map<String, Decimal>> rollupMap = new Map<Id, Map<String, Decimal>>();

        for (AggregateResult ar : groupedResults) {
            Id accId = (Id) ar.get('AccountId');
            String woodType = (String) ar.get('Wood_Type__c');
            Decimal total = (Decimal) ar.get('total');

            if (!rollupMap.containsKey(accId)) {
                rollupMap.put(accId, new Map<String, Decimal>{ 'Standard' => 0, 'Recycled' => 0 });
            }

            if (woodType != null && rollupMap.get(accId).containsKey(woodType)) {
                rollupMap.get(accId).put(woodType, total);
            }
        }

        // Prepare account updates
        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : rollupMap.keySet()) {
            Map<String, Decimal> woodTotals = rollupMap.get(accId);

            Account acc = new Account(
                Id = accId,
                Total_Sales_Standard__c = woodTotals.get('Standard'),
                Total_Sales_Recycled__c = woodTotals.get('Recycled')
            );

            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
