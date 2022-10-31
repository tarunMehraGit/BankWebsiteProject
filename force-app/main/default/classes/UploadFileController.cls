public with sharing class UploadFileController {
    
    @AuraEnabled
    public static list<Account> loadData(String uploadData) {
        System.debug('Value : '+uploadData);
        List<Account> accountList = new List<Account>();
       	DOM.Document doc=new DOM.Document();
        //List<Account> accountList = new List<Account>();
        doc.load(uploadData);
        DOM.XmlNode	rootNode = doc.getRootElement();
        System.debug('Load : '+rootNode);
       /* if ( contentDocument != null ) {
            
            ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocument ];
           // List < String > records = contentVersionObj.VersionData.toString().split( '\n' );
            for(DOM.XmlNode parent : rootNode.getChildElements()){
                Account accountObj = new Account();
                //List<String> xmlData =  records[i].split(',');
                for(DOM.XmlNode child : parent.getChildElements()){
                    if(child.getName() == 'Name'){
                    System.debug('Name : '+child.getText());
                    account.Name = child.getText();
                }
                if(child.getName() == 'Email'){
                    System.debug('Email : '+child.getText());
                    account.Email__c = child.getText();
                }	
                    
                }
                accountList.add(accountObj);
                //System.debug('Data : '+xmlData);
                //accountObj.Name = xmlData[0];
                //accountObj.Email__c = xmlData[1];
                
            }
            try{
                if(accountList.size() > 0){
                    insert accountList;
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            } 
        } */
        return accountList;
    } 
}