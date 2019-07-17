<aura:application extends="force:slds">
    <aura:attribute name="searchRecord" type="sObject" default="{}"/>
    <c:custSearch objectAPIName="account" IconName="standard:account" selectedLookupRecord="{!v.searchRecord}" label="Account"/>
</aura:application>