public class MergeAttachmentController {
    public List<Account> accountList{get;set;}
    public List<allObjectWrapperClass> allWrapperList{get;set;}
    public String allObjectName{get;set;}
    public Boolean isallChecked{get;set;}
    //public Boolean isChecked{get;set;}
    public Boolean mergeButton{get;set;}
    public Boolean showList{get;set;}
    public Boolean showPopup{get;set;}
    public String popupObjects{get;set;}
    public List<allObjectWrapperClass> objectWrapperPopupList {get;set;}
    public MergeAttachmentController(){
        allWrapperList = new List<allObjectWrapperClass>();  
        objectWrapperPopupList = new List<allObjectWrapperClass>();
        //mergeButton = false;
        //showList=false;
    }
    public List<SelectOption> getOptionList(){
        //showList = true;
        List<SelectOption> sOptionList = new List<SelectOption>();
        sOptionList.add(new SelectOption('Account','Account'));
        sOptionList.add(new SelectOption('Contact','Contact'));
        //sOptionList.add(new SelectOption('Case','Case'));
        sOptionList.add(new SelectOption('Opportunity','Opportunity'));
        return sOptionList;
    }
    public void attachmentObjects(){
        //showList = true;
        if(allObjectName != Null){
            String query = 'SELECT id, (SELECT id, name, ContentType FROM Attachments WHERE ContentType in (\'image/jpeg\',\'image/jpg\',\'image/png\')) FROM '+ allObjectName;
            for(sObject sobj : Database.query(query)){	
                List<sObject> sList = sobj.getsObjects('Attachments');
                if(sList != NUll){
                    allObjectWrapperClass wrapperObj = new allObjectWrapperClass();
                    wrapperObj.objectName = sobj;
                    allWrapperList.add(wrapperObj);
                }
            }
        }else{
            allWrapperList = new List<allObjectWrapperClass>();
        }
    }
     public void allChecked(){
        for(allObjectWrapperClass obj : allWrapperList){
            obj.isChecked = isallChecked;
            if(isallChecked){
                //obj.isChecked = true;
                mergeButton = true;
            }else{
                obj.isChecked = false;
                mergeButton = false;
            }
        }
    }
    public void singleCheck(){
        isallChecked = true;
        mergeButton = false;
        for(allObjectWrapperClass obj : allWrapperList){
            if(obj.isChecked == false){
                 isallChecked = false;
               	 showPopup = false;
                 //isallChecked = true;
            }else{
                mergeButton = true;
            }
        }
   }
    public void showButton(){
        showPopup = true;
    }
    public void showDialog(){
        objectWrapperPopupList.clear();
        if(popupObjects != Null){
            String query = 'SELECT id ,name FROM '+popupObjects;
            for(sObject sObj : database.query(query)){
                 allObjectWrapperClass wrapperObj = new allObjectWrapperClass();
                 wrapperObj.objectName = sobj; 
                 objectWrapperPopupList.add(wrapperObj);
            }
        }
    }
    /*public void copyAttachment(){
        for(allObjectWrapperClass obj : allWrapperList){
            if(obj.isChecked || isallChecked){
                for(allObjectWrapperClass obj1 : objectWrapperPopupList){
                    if(obj1.showPopup){
                        for(Attachment att : database.query(query)){
                            Attachment attachmentObj = new Attachment();
                            attachmentObj.Name = att.Name;
                            attachmentObj.Body = att.Body;
                            attachment.ParentId = obj1.objectName.id;
                        }
                    }
                }
            }
        }
    }*/
    public class allObjectWrapperClass{
        /*public Account account{get;set;}
        public Contact contact{get;set;}
        public Case case1{get;set;}
        public Opportunity opportunity{get;set;}*/
        public sObject objectName{get;set;}
        public Boolean isChecked{get;set;}
    }
    /*public void SelectList(){
        if(ObjectName == 'Account'){
            for(Account acc : [SELECT Id, Name,
                               (select name, contentType
                                from Attachments where contentType = 'image/jpeg')
                               FROM Account]){
                                   if(acc.Attachments.size() > 0){
                                       allObjectWrapperClass accountObj = new allObjectWrapperClass();
                                       accountObj.account = acc;
                                       allWrapperList.add(accountObj);
                                   }
                               }
            showAccount = true;
            showContact = false;
            showCase = false;
            showOpportunity = false; 
        }
        else if(ObjectName == 'Contact'){
            allWrapperList.clear();
            for(Contact con : [select id, name,
                               (select name, contentType
                                From Attachments  where contentType = 'image/jpeg')
                               from Contact] ){
                                   if(con.Attachments.size() > 0){
                                       allObjectWrapperClass contactObj = new allObjectWrapperClass();
                                       contactObj.contact = con;
                                       allWrapperList.add(contactObj);
                                   }
                               }
            showContact = true;
            showAccount = false;
            showCase = false;
            showOpportunity = false; 
        }
        else if(ObjectName == 'Case'){
            allWrapperList.clear();
            for(Case caseObj : [select id, 
                                (select name, contentType
                                 From Attachments  where contentType = 'image/png')
                                from Case] ){
                                    if(caseObj.Attachments.size() > 0){
                                        allObjectWrapperClass caseObject = new allObjectWrapperClass();
                                        caseObject.case1 = caseObj;
                                        allWrapperList.add(caseObject);
                                    }
                                }
            showCase = true;
            showContact = false;
            showAccount = false;
            showOpportunity = false; 
        }
        else if(ObjectName == 'Opportunity'){
            allWrapperList.clear();
            for(Opportunity opp : [select id, 
                                   (select name, contentType
                                    From Attachments  where contentType = 'image/jpeg')
                                   from Opportunity] ){
                                       if(opp.Attachments.size() > 0){
                                           allObjectWrapperClass OppObject = new allObjectWrapperClass();
                                           OppObject.opportunity = opp;
                                           allWrapperList.add(OppObject);
                                       }
                                   }
            showOpportunity = true; 
            showCase = false;
            showContact = false;
            showAccount = false;
        }   
    }*/
    
}