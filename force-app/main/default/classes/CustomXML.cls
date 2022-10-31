public class CustomXML {
    
    String xmlString;
 
    public CustomXML(){
     
        xmlString = '<Accounts> '+
            '<Account>' +
            '<Name>Varun kumar</Name>' +
            '<Email>kumar.varun@gmail.com</Email>' +
            '</Account>' +
            '<Account>' +
            '<Name>Rajeev Jain</Name>' +
            '<Email>jain.rajeev@gmail.com</Email>' +
            '</Account>'+
            '<Account>' +
            '<Name>Shubham Kumar</Name>' +
            '<Email>kumar.shubham@yahoo.com</Email>' +
            '</Account>' +
            '<Account>' +
            '<Name>Umesh Yadav</Name>' +
            '<Email>umesh.yadav11@gmail.com</Email>' +
            '</Account>'+
            '<Account>' +
            '<Name>Bhavesh Rajan</Name>' +
            '<Email>rajan.bhavesh@gmail.com</Email>' +
            '</Account>'+
            '</Accounts>';	 
        DOM.Document doc=new DOM.Document();
        List<Account> accountList = new List<Account>();
        doc.load(xmlString);
        DOM.XmlNode	rootNode = doc.getRootElement();
        for(DOM.XmlNode parent : rootNode.getChildElements()){
            Account account = new Account();
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
            accountList.add(account);
        }
        System.debug('AccountList : '+ accountList);
        try{
            if(accountList.size() > 0)
                INSERT accountList;
        }
        catch(exception e){
            system.debug(e.getMessage());
        }
        
    }
}