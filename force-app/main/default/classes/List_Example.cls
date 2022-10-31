public class List_Example {
    public List_Example(){
        List<String> nameList = new List<String>();
        nameList.add('Tarun');
        nameList.add('Varun');
        nameList.add('Rahul');
        nameList.add('David');
        nameList.add('Praveen');
        
        System.debug(nameList.get(0));
        System.debug(nameList.get(1));
        System.debug(nameList.get(2));
        System.debug(nameList.get(3));
        System.debug(nameList.get(4));
        
        System.debug('Size Of List Elements : '+nameList.size());
        
      	nameList.add(1,'Satveer');
        for(String name : nameList){
            System.debug('@'+name);
        }
        System.debug('Size Of List : '+nameList.size());
        List<String> copyNameList = new List<String>(nameList);
        
        for(String copyName : copyNameList){
            System.debug('Copy Name '+copyName);
        } 
        
        List<String> srNo = new List<String>();
        
        srNo.add('1');
        
        srNo.addAll(nameList);
       	System.debug('Add All : '+srNo);
        // srNo.clear()
        //System.debug('Remove : '+srNo);
       	
       	System.debug('Contains : '+nameList.contains('Tarun'));    
    }
}