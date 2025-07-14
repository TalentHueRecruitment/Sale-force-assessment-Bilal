trigger OpportunityTrigger on Opportunity (
    after insert, after update, after delete, after undelete
) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            OpportunityRollupService.recalculateSalesByWoodType(Trigger.new);
        } else if (Trigger.isDelete) {
            OpportunityRollupService.recalculateSalesByWoodType(Trigger.old);
        }
    }
}