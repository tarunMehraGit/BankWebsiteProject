public class MapExample {
    Public MapExample(){
        Map<Integer,String> map1 = new Map<Integer,String>();
        
        map1.put(1,'Rahul');
        map1.put(2,'Abdul');
     	map1.put(3,'Lokesh');
        map1.put(4,'Himanshu');
        
     	System.debug(map1.get(1));
        System.debug(map1.get(2));
        System.debug(map1.get(3));
    }
}