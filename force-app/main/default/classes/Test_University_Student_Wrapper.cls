@isTest
public class Test_University_Student_Wrapper {
	
    @isTest
    public static void createData(){
        University_Student_Wrapper uni = new University_Student_Wrapper();
        uni.course = 'MCA';
        uni.duration = 2;
    
    	University_Student_Wrapper.Student unis = new University_Student_Wrapper.Student();
		unis.Name = 'Rajesh';
		unis.Age = 25;        
    }
    
    @isTest
    public static void testMethod1(){
        test.startTest();
        University_Student_Wrapper uni = new University_Student_Wrapper();
        System.assertEquals('Electronics', uni.course);
        test.stopTest();
    }
    
    @isTest
    public static void testMethod2(){
        test.startTest();
       	University_Student_Wrapper uni = new University_Student_Wrapper('BCA',3,'Ravi',25);
        uni.AssignValue('BCA',3,'Ravi',25);
        System.assertEquals('BCA', uni.course);
        test.stopTest();
    }
    
}