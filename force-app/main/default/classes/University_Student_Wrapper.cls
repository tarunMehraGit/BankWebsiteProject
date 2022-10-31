public class University_Student_Wrapper {
	
    public String course;
    public integer duration;
    public List<Student> studentList;
    
    public University_Student_Wrapper(){
        course = 'Electronics';
        duration = 12;
        Student stds = new Student();
        stds.Name = 'Dev';
        stds.Age = 29;
        
        List<Student> studentList = new List<Student>();
        studentList.add(stds);
        
        System.debug('List : '+studentList);
        System.debug('Course : '+course);
        System.debug('duration : '+duration);
        System.debug('Name : '+stds.Name);
        System.debug('Age : '+stds.Age);
    }
    
    public University_Student_Wrapper(String courseName,integer courseDuration,String sName, integer sAge){
        this.course = courseName;
        this.duration = courseDuration;
        student st = new student();
        st.Name = sName;
        st.Age = sAge;
        
        System.debug('@@Course : '+course);
        System.debug('@@duration : '+duration);
        System.debug('@@Name : '+st.Name);
        System.debug('@@Age : '+st.Age);
    }
    public void AssignValue(String courseName,integer courseDuration,String sName, integer sAge){
        this.course = courseName;
        this.duration = courseDuration;
        Student sts = new Student();
        sts.Name = sName;
        sts.Age = sAge;
        
        System.debug('@@Course : '+course);
        System.debug('@@duration : '+duration);
        System.debug('@@Name : '+sts.Name);
        System.debug('@@Age : '+sts.Age);
    }
    
    public class Student{
        
        public String Name;
        public integer Age;
    }
}