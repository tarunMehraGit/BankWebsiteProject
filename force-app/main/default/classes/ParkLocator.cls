public class ParkLocator  {
	
    public static List<String> country(String ctry){
        ParkService.ParksImplPort parkService = new ParkService.ParksImplPort();
      	return parkService.byCountry(ctry);
    }
}