trigger CheckSecretInformation on Case (after insert, before update) 
{
		// create a collection containing each of our secret keywords
		String childCaseSub = 'warning : Parent Case may contain secret info';

		Set<String> secretKeywords = new Set<String>();
		secretKeywords.add('Credit Card');
		secretKeywords.add('Social Security');
		secretKeywords.add('passport');
		secretKeywords.add('Bodyweight');

		List<Case> caseWithSecretInfo = new List<Case>();

	for(Case myCase : Trigger.new) 
	{
		if (myCase.Subject != childCaseSub)
		for(String keyword : secretKeywords) 
		{
			if(myCase.Description != null && myCase.Description.contains(keyword))
			{
				caseWithSecretInfo.add(myCase);
				System.debug('secret key found Case ID' + myCase.ID + 'keyword :' +keyword);
				break;
			}
		}

		// if , create child case

		List<case> caseTocreate = new List<case>();
		for (Case caseWSInfo : caseWithSecretInfo)
		{
			System.debug('im here');
			Case childCase = new Case();
			childCase.subject = childCaseSub;
			childCase.ParentId = caseWSInfo.Id;
			childCase.IsEscalated = true;
			childCase.Priority = 'High';
			childCase.Description = 'At Least one of the following keywords were found' +secretKeywords;
			
			caseTocreate.add(childCase);
		}

			insert caseTocreate;

	}

}