public class CustomerController {
    public List<Hotel_Customer__c> customerList{get;set;}
    public Hotel_Customer__c customer{get;set;}	
    public Id customerId{get;set;}
    public Id editId{get;set;}
    public Id viewId{get;set;}
    public Id cloneId{get;set;}
    public Boolean SaveAndNew{get;set;}
    public Boolean isEdit{get;set;}
    public Boolean isView{get;set;}
    public Boolean isClone{get;set;}
    public String searchName{get;set;}
    public String searchEmail{get;set;}
    public String searchPhone{get;set;}
    public String query;
    public CustomerController(){ 
        customerList = new List<Hotel_Customer__c>();
        customer=new Hotel_Customer__c();
        customerList = [SELECT First_Name__c,Last_Name__c,Gender__c,Full_Name__c,Address__c,City__c,Email__c,Phone__c,
                        Nationality__c,Is_Married__c FROM Hotel_Customer__c];
        init();   
    }
    public void init(){
        String query ='SELECT Id,First_Name__c,Last_Name__c,Gender__c,Address__c,Full_Name__c,City__c,Email__c,Phone__c,Nationality__c,Is_Married__c FROM Hotel_Customer__c ';
        String eId = ApexPages.currentPage().getParameters().get('editId');
        String vId = ApexPages.currentPage().getParameters().get('viewId');
        String cId = ApexPages.currentPage().getParameters().get('cloneId');
        if(!String.isBlank(eId)){
            isEdit=true;
            query += ' WHERE id =\''+eId+'\'';
            customer=database.query(query);	
        }
        else if(!String.isBlank(vId)){
            isView=true;
            query += ' WHERE id =\''+vId+'\'';
            customer=database.query(query);
        }
        else if(!String.isBlank(cId)){
            isEdit=true;
            SaveAndNew=true;
            query += ' WHERE id =\''+cId+'\'';
            customer=database.query(query);
        }
        else{
            isEdit=true;
            SaveAndNew=true;
        }
    }
    public PageReference save(){
        if(isClone==true){
            customer.id=null;
            PageReference save = new PageReference('/apex/all_customer');
            insert customer;
            save.setRedirect(true);
            return save;
        }
        SaveAndNew=true;
        upsert customer; 
        PageReference savePage = new PageReference('/apex/all_customer');
        savePage.setRedirect(true);
        customer=new Hotel_Customer__c();	
        return savePage;
    }
    public PageReference editRecord(){
        SaveAndNew=false;
        PageReference editPage = new PageReference('/apex/new_customer?editId='+editId);
        editPage.setRedirect(true);
        return editPage;
    }
    public PageReference viewRecord(){	
        PageReference viewPage = new PageReference('/apex/new_customer?viewId='+viewId);
        viewPage.setRedirect(true);
        return viewPage;
    }
    public PageReference deleteRecord(){
        customer.Id = customerId;	
        Delete customer;
        PageReference delPage = new PageReference('/apex/all_customer');
        delPage.setRedirect(true);
        return delPage;
    } 
    public PageReference cloneButton(){	
        System.debug('@@ Clone Id'+cloneId);
        PageReference clonePage = new PageReference('/apex/new_customer?cloneId='+cloneId);
        clonePage.setRedirect(true);
        return clonePage;
    }
    public PageReference saveAndNew(){
        insert customer;
        PageReference saveAndNewPage = new PageReference('/apex/new_customer');
        saveAndNewPage.setRedirect(true);
        return saveAndNewPage;
    }
    public PageReference back(){
        PageReference backPage = new PageReference('/apex/all_customer');
        backPage.setRedirect(true);
        return backPage;
        
    }
}