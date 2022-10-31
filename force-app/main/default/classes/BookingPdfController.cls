public class BookingPdfController {
    public List<Booking__c> bookingList{get;set;} 
    public ID bookingId {get;set;}
 	public String pdfName {get;set;}
    public BookingPdfController(){
        bookingList = [SELECT Id, Status__c, Room__c, Check_In_Time__c, Amount__c , Check_Out_Time__c, Room__r.price__c,
                       Total_Hours__c, Customer__r.Full_Name__c
                       FROM Booking__c];
    }
    public pageReference savePdf(){
        //System.debug('Id !!' + bookingId);
        pageReference pdf = page.booking_Invoice;
        pdf.getParameters().put('Id',bookingId);  
        Blob data = pdf.getContentAsPDF();
        Attachment attachment = new  Attachment(ParentId = bookingId,
                                               body=data,
                                               name=bookingId+'.pdf');
        insert attachment;
        return pdf;
    }
}