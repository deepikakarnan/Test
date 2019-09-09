trigger LeadingCompetitor on Opportunity (before insert, before update) {

	for(Opportunity opp : Trigger.new) 
	{

		List<Decimal> competitorPrices = new List<Decimal>();
		competitorPrices.add(opp.Competitor_1_price__c);
		competitorPrices.add(opp.Competitor_2_price__c);
		competitorPrices.add(opp.Competitor_3_price__c);
		
		List<String> competitors = new List<String>();
		competitors.add(opp.Competitor_1__c);
		competitors.add(opp.Competitor_2__c);
		competitors.add(opp.Competitor_3__c);
		
		Decimal highestPrice;
		Integer highestPricePosition;
		for(Integer i=0 ; i < competitorPrices.size(); i++) 
		{
			Decimal currentPrice = competitorPrices.get(i);
			if(highestPrice == null || currentPrice > highestPrice)
			{
				highestPrice 				= currentPrice;
				highestPricePosition		= i;
			}

			opp.Leading_Competitor__c		= competitors.get(highestPricePosition);
			opp.Leading_Competitor_Price__c = highestPrice;
		}
	}


}