@isTest
public class TEST_SCHEDULE_QuarterlyAutoVisits {
    
    public static String CRON_EXP = '0 1 0 1 1/1 ? *';

    @isTest 
    public static void testScheduleDefaultDate(){
        
        Test.startTest();
        
        System.schedule('testBasicScheduledAutoVisitsDefault',
      	TEST_SCHEDULE_QuarterlyAutoVisits.CRON_EXP, 
        new SCHEDULE_QuarterlyAutoVisits());
        
        Test.stopTest();

    }
    
	@isTest 
    public static void testScheduleQ1(){
        
        Test.startTest();
        
        System.schedule('testBasicScheduledAutoVisitsQ1',
      	TEST_SCHEDULE_QuarterlyAutoVisits.CRON_EXP, 
        new SCHEDULE_QuarterlyAutoVisits( Date.newInstance(2022, 7, 1)));
        
        Test.stopTest();

    }
    
    @isTest 
    public static void testScheduleQ2(){
        
        Test.startTest();
        
        System.schedule('testBasicScheduledAutoVisitsQ2',
      	TEST_SCHEDULE_QuarterlyAutoVisits.CRON_EXP, 
        new SCHEDULE_QuarterlyAutoVisits( Date.newInstance(2022, 10, 1)));
        
        Test.stopTest();

    }
    
    @isTest 
    public static void testScheduleQ3(){
        
        Test.startTest();
        
        System.schedule('testBasicScheduledAutoVisitsQ3',
      	TEST_SCHEDULE_QuarterlyAutoVisits.CRON_EXP, 
        new SCHEDULE_QuarterlyAutoVisits( Date.newInstance(2022, 1, 1)));
        
        Test.stopTest();

    }
    
    @isTest 
    public static void testScheduleQ4(){
        
        Test.startTest();
        
        System.schedule('testBasicScheduledAutoVisitsQ4',
      	TEST_SCHEDULE_QuarterlyAutoVisits.CRON_EXP, 
        new SCHEDULE_QuarterlyAutoVisits( Date.newInstance(2022, 4, 1)));
        
        Test.stopTest();

    }
}