@isTest
private class TestVerifyDate {
    
    static testMethod void testCheckDate(){
        //VerifyDate verifyDate = new VerifyDate();
        Date startDate = Date.newInstance(2015, 12, 15);
        Date endDate = Date.newInstance(2015, 12, 16);
        Date methodFirst = VerifyDate.CheckDates(startDate,endDate);
        System.assertEquals(endDate, methodFirst);
    }
    
    @isTest
    static  void TestDateWithin30Days() {
        Date day1 = Date.newInstance(2015, 1, 10);
        Date day2 = Date.newInstance(2015, 2, 17);
        Date date_res1 = VerifyDate.CheckDates(day1,day2);
        //system.debug(date_res1+' Run1: Date1: ' + day1+ 'Date2: ' + day2);
    }
    
    static testMethod void testSetEndOfMonthDate(){
        Date date1 = Date.parse('01/09/16'); 
        Date date2 = Date.parse('12/10/16');  
        Date dateexpected = Date.parse('30/09/16');
        
        Date date12 = VerifyDate.CheckDates(date1 , date2);
        System.assertEquals(dateexpected, date12); 
    }
}