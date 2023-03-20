public class SCHEDULE_QuarterlyAutoVisits  implements Schedulable {
    
    //execution date variable for tests and specific date schedule runs
	public Date execDate;

    //default constructor for schedule execution
    public SCHEDULE_QuarterlyAutoVisits(){
        execDate = System.today();
    }
    
    //for tests : allow more code coverage and functionality by allowing the schedule to be executed for specified dates
    public SCHEDULE_QuarterlyAutoVisits( Date intendedExecutionDate ){
        execDate = intendedExecutionDate;
    }

   public void execute(SchedulableContext SC) {
       //Check if the execution date is correct to determine if the batch should be executed or not
       if( execDate.day() == 1 
          	&& ( execDate.month() == 1 ||
                 execDate.month() == 4 ||
                 execDate.month() == 7 ||
                 execDate.month() == 10
               )    
       ){
           //execution date is 1 Jan (Start of Q3), 1 April (Start of Q4), 1 July (Start of Q1) or 1 Oct (Start of Q2)
           	BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits();
        	Database.executeBatch( b , 10);   
       
       }
        
   }      
    
}