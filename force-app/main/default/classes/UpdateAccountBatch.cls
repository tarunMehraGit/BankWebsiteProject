global class UpdateAccountBatch implements Database.Batchable<sOBject> {
    integer  i = 1;
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([Select Id,AnnualRevenue,Name,Rating,AccountNumber,Phone,Email__C from Account]);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> dataList){
        for(Account account : dataList){
            account.AnnualRevenue = 12000.00;
            if(account.Rating == 'Hot'){
                account.phone = '8545631210';
            }
            account.Email__c = 'test'+i+'@gmail.com';
            i++;
        }
        update dataList;
    }
    global void finish(Database.BatchableContext BC){
        AsyncApexJob apexJob = [SELECT Id, Status, ApexClassId, NumberOfErrors, CreatedDate, CompletedDate, JobType,
                                TotalJobItems, JobItemsProcessed, MethodName, ApexClass.Name
                                FROM AsyncApexJob
                                WHERE Id =: BC.getJobId()];
        
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        singleEmailMessage.setToAddresses(new List<String> {'mehratarun234@gmail.com'});
		singleEmailMessage.setSubject(apexJob.Status);   	
        String htmlBody = '';
         //open Body
        htmlBody = '<table border="1" style="border-collapse: collapse"><caption>Batch Class Details</caption><tr><th>Submitted Date</th><th>Job Type</th><th>Status</th><th>Total Batches</th><th>Batches Processed</th><th>Failures</th><th>Completion Date</th><th>Apex Class</th></tr>';
        
        DateTime  createddate= apexJob.CreatedDate;
        String jobType = apexJob.JobType;
        String Status = apexJob.Status;
        Integer totaljobItem = apexJob.TotalJobItems;
        Integer jobProcessed = apexJob.JobItemsProcessed;
        Integer NumberOfErrors = apexJob.NumberOfErrors;
        DateTime complitionDate = apexJob.CompletedDate;
        String apexClassName = apexJob.ApexClass.Name;
        String methodName = apexJob.MethodName;
		
        htmlBody += '<tr><td>' + createddate + '</td><td>' + jobType + '</td><td>' + Status + '</td><td>' + totaljobItem + '</td><td>' + jobProcessed + '</td><td>' + NumberOfErrors + '</td><td>' + complitionDate + '</td><td>' + apexClassName + '</td></tr>';
        htmlBody += '</table>';	
        singleEmailMessage.setHtmlBody(htmlBody);
        
        List<Messaging.Email> emails = new List<Messaging.Email>{singleEmailMessage};    
        Messaging.SendEmailResult[] result = Messaging.sendEmail(emails);
        
         if(result[0].success){
            System.debug('Email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
    }
}