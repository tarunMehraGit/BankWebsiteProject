public class InlineShowAttachmentController {
    public List<Contact> contactList{get;set;}
    //public Contact contact;
    public InlineShowAttachmentController(ApexPages.StandardController controller){
        contactList = new List<Contact>();
        //Contact.Id = controller.getId();
        //contactList = [SELECT id,(Select id, name, contentType
                                  //from Attachments where ParentId =: controller.getId())
                                  //from Contact];
        for(Contact con : [SELECT id,(SELECT id, name, ContentType, ParentId
                                      FROM Attachments WHERE ContentType in ('image/jpeg','image/png','image/png')
                                      AND ParentId =: controller.getId())
                           			  from Contact]){
                               if(con.Attachments.size() > 0){
                                   contactList.add(con);
                               }
                           }
    }
}