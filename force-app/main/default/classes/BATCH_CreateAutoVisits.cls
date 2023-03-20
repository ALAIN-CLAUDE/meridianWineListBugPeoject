public class BATCH_CreateAutoVisits implements Database.Batchable<sObject>, Database.Stateful {
    
    //StartingPoint in case the batch is manually executed
    public Datetime initialStartDateTime;
    
    //Default constrctor
    public BATCH_CreateAutoVisits(){
        
    }
    
    //Constructor for inputStartDateTime
    public BATCH_CreateAutoVisits( DateTime inputStartDateTime ){
        
		initialStartDateTime = inputStartDateTime;	
        System.debug( 'Initial Start Date Time' + initialStartDateTime );
        
    }
    
    public BATCH_CreateAutoVisits( DateTime inputStartDateTime, Integer num ){
        
		initialStartDateTime = inputStartDateTime;
        testRandomInteger = num;
        
    }
    
    
    public integer testRandomInteger;
    //CurrentDates
    public static Integer currentYear = System.today().year();
    //public static DateTime currentDateTime = System.now ;
    
  
    
    //Q1 Variables
    public static DateTime q1StartTime = DateTime.newInstance(currentYear, 7, 1, 0, 0, 0);
    public static DateTime q1EndTime = DateTime.newInstance(currentYear, 10, 1, 0, 0, 0);
    
    //Q2 Variables
    public static DateTime q2StartTime = q1EndTime;
    public static DateTime q2EndTime = DateTime.newInstance(currentYear, 1, 1, 0, 0, 0);
    
    //Q3 Variables
    public static DateTime q3StartTime = q2EndTime;
    public static DateTime q3EndTime = DateTime.newInstance(currentYear, 4, 1, 0, 0, 0);

    //Q4 Variables
    public static DateTime q4StartTime = q3EndTime;
    public static DateTime q4EndTime = q1StartTime;     
    
    //Weeks
    public Date Week1StartDate = initialiseWeek1Start().date();
    
    public DateTime initialiseWeek1Start(){
        
        System.debug( 'Initial Start Date Time' + initialStartDateTime );
        
        if( initialStartDateTime != null ){
            if( initialStartDateTime >= q1StartTime && initialStartDateTime <= q1EndTime ){

                Week1StartDate = q1StartTime.date();

            }else if( initialStartDateTime >= q2StartTime && initialStartDateTime <= q2EndTime ){

                Week2StartDate = q2StartTime.date();

            }else if( initialStartDateTime >= q3StartTime && initialStartDateTime <= q3EndTime ){

                Week3StartDate = q3StartTime.date();

            }else if( initialStartDateTime >= q4StartTime && initialStartDateTime <= q4EndTime ){

                Week4StartDate = q4StartTime.date();

            }
            
        }else if( System.now() >= q1StartTime && System.now() <= q1EndTime ) {
            
            Week1StartDate = q1StartTime.date();
            
        }else if( System.now() >= q2StartTime && System.now() <= q2EndTime ){
            
            Week1StartDate = q2StartTime.date();
            
        }else if( System.now() >= q3StartTime && System.now() <= q3EndTime){
            
            Week1StartDate = q3StartTime.date();
            
        }else if( System.now() >= q4StartTime && System.now() <= q4EndTime ){
            
            Week1StartDate = q4StartTime.date();
            
        }
        
        return Week1StartDate;
    }
    
    
    public Date Week1EndDate = Week1StartDate + 6;
    
    public Date Week2StartDate = Week1EndDate + 1;
    public Date Week2EndDate = Week2StartDate + 6;
    
    public Date Week3StartDate = Week2EndDate + 1;
    public Date Week3EndDate = Week3StartDate + 6;
    
    public Date Week4StartDate = Week3EndDate + 1;
    public Date Week4EndDate = Week4StartDate + 6;
    
    public Date Week5StartDate = Week4EndDate + 1;
    public Date Week5EndDate = Week5StartDate + 6;
    
    public Date Week6StartDate = Week5EndDate + 1;
    public Date Week6EndDate = Week6StartDate + 6;
    
    public Date Week7StartDate = Week6EndDate + 1;
    public Date Week7EndDate = Week7StartDate + 6;
    
    public Date Week8StartDate = Week7EndDate + 1;
    public Date Week8EndDate = Week8StartDate + 6;
    
    public Date Week9StartDate = Week8EndDate + 1;
    public Date Week9EndDate = Week9StartDate + 6;
    
    public Date Week10StartDate = Week9EndDate + 1;
    public Date Week10EndDate = Week10StartDate + 6;
    
    public Date Week11StartDate = Week10EndDate + 1;
    public Date Week11EndDate = Week11StartDate + 6;
    
    public Date Week12StartDate = Week11EndDate + 1;
    public Date Week12EndDate = Week12StartDate + 6;  
    
    //ActionPlanTemplateVersion 
    public ActionPlanTemplateVersion templateVersion = getActionPlanTemplateVersion( 'Standard Visit Template' );
           
    public Database.QueryLocator start(Database.BatchableContext bc) {
                
        String query =  'SELECT Id, Name, Auto_Visit_Planned_Date_Time__c, Account.OwnerId, ' + 
            			'Preferred_Visit_Day__c, PreferredVisitHoursId, ' + 
            			'OwnerId, AccountId, RetailLocationGroupId, ' + 
            			'PrimaryContactId, OperatingHoursId, Description, ' +  
            			'LocationId, StoreType, Account.MWM_Grading__c ' +   
            			'FROM RetailStore WHERE Auto_Visit_Planned_Date_Time__c != Null ORDER BY Account.MWM_Grading__c ASC' ;
            
       	if(Test.isRunningTest()){
			
            query = 'SELECT Id, Name, Auto_Visit_Planned_Date_Time__c, Account.OwnerId, ' + 
            			'Preferred_Visit_Day__c, PreferredVisitHoursId, ' + 
            			'OwnerId, AccountId, RetailLocationGroupId, ' + 
            			'PrimaryContactId, OperatingHoursId, Description, ' +  
            			'LocationId, StoreType, Account.MWM_Grading__c ' +   
            			'FROM RetailStore WHERE Auto_Visit_Planned_Date_Time__c != Null ORDER BY Account.MWM_Grading__c ASC';
            
		}    
       
        try{
       		sendStartEmail();
        }catch ( Exception e){

            System.debug('Email could not be sent.');

        }
        
        
        return Database.getQueryLocator( query );
    }
    
    
    public void createVisitForWeek( RetailStore retailStore, Date iterativeDate, Date endDate ){
        
        Visit weekVisit = initialiseVisit( retailStore );
        
        Boolean weekVisitCreated = False;
        
        while( iterativeDate <= endDate && WeekVisitCreated == False ){
            
            if( DateTime.newInstance(iterativeDate.year(), iterativeDate.month(), iterativeDate.day(), 0, 0, 0).format('EEEE') 
               == retailstore.Auto_Visit_Planned_Date_Time__c.format('EEEE') ){
                   
                   weekVisit.PlannedVisitStartTime = DateTime.newInstance( iterativeDate.year(), iterativeDate.month(), 
                                                                           iterativeDate.day(), retailstore.Auto_Visit_Planned_Date_Time__c.hour(),
                                                                           retailstore.Auto_Visit_Planned_Date_Time__c.minute(), 
                                                                           retailstore.Auto_Visit_Planned_Date_Time__c.second() ) ;        
                   
                   weekVisitCreated = True; 
                   
               }
            
            iterativeDate = iterativeDate.addDays(1);
            
        }
        
        if( weekVisitCreated == true ){
            
            List<Visit> visitsForDay = [ SELECT PlannedVisitStartTime, Id, AccountId, Name, OwnerId, UserId, RetailStoreId, VisitorId, Account.OwnerId
                                           	FROM   Visit
                                           	WHERE  PlannedVisitStartTime != NULL
                                           		AND PlannedVisitStartTime >=: Datetime.newInstance(iterativeDate.year(), iterativeDate.month(), iterativeDate.day(), 0,0,1) 
                                                AND  PlannedVisitStartTime <=: Datetime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23,59,59)
                                         AND OwnerId =: retailStore.OwnerId 
                                          ];
            
            if( visitsForDay.size() < 13){
               
                List<Visit> visitsAtSameTime = [ SELECT PlannedVisitStartTime, Id, AccountId, Name, OwnerId, UserId, RetailStoreId, VisitorId, Account.OwnerId
                                            		FROM   Visit
                                                WHERE  PlannedVisitStartTime != NULL
                                                AND PlannedVisitStartTime >=: Datetime.newInstance(iterativeDate.year(), iterativeDate.month(), iterativeDate.day(), 0,0,1) 
                                                AND  PlannedVisitStartTime <=: Datetime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23,59,59)
                                                AND OwnerId =: retailStore.OwnerId 
                                                AND PlannedVisitStartTime =: weekVisit.PlannedVisitStartTime
                                           		];
                if(  visitsAtSameTime.isEmpty() == True ){
					
                    List<Visit> visitInWeek = [ SELECT PlannedVisitStartTime, Id, AccountId, Name, OwnerId, UserId, RetailStoreId, VisitorId, Account.OwnerId
                                            	  FROM Visit
                                                 WHERE PlannedVisitStartTime != NULL
                                                   AND PlannedVisitStartTime >=: Datetime.newInstance(iterativeDate.year(), iterativeDate.month(), iterativeDate.day(), 0,0,1) 
                                                   AND PlannedVisitStartTime <=: Datetime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23,59,59)
                                              	   AND RetailStoreId =: retailStore.Id];
                    
                    if(  visitInWeek.isEmpty() == True ){
                    
                        insert weekVisit;
                        
                        System.debug('Visit Created.');

                        
                        if( templateVersion != null ){
                            
                            ActionPlan ap = new ActionPlan();
                            ap.ActionPlanState = 'Not Started';
                            ap.ActionPlanTemplateVersionId = templateVersion.Id;
                            ap.ActionPlanType = 'Retail';
                            ap.IsUsingHolidayHours = True;
                            ap.Name = weekVisit.Name + ' Action Plan';
                            ap.OwnerId = weekVisit.OwnerId;
                            ap.StartDate = weekVisit.PlannedVisitStartTime.date();
                            ap.TargetId = weekVisit.id;
                            
                            insert ap;
                            
                            System.debug('Action plan Created.');
                        }
                        
                    }
                    
                }
                
            }else{
                
                System.debug('Visit not created');
                
            }
            
        }
        
    }    
    
    
    public void execute(Database.BatchableContext bc, List<RetailStore> scope){
        
        
        System.debug( 'Execute Initial Start Date Time' + initialStartDateTime );

        // process each batch of records
        List<Visit> visits = new List<Visit>();
        
        //Loop through retail stores
        for (RetailStore retailStore : scope) {
            
            //Check if the retail store Auto Visit Planned Date Time is populated  
            if( retailStore.Auto_Visit_Planned_Date_Time__c != null ){
             	//Retail store is populated
               
                //Check if the initial starttdatetime was populated be the nondefault constructor
                if( initialStartDateTime != null ){
                    //The non default  constructor was executed and the initialstartdatetime has a value
                    
                    
                    if( retailStore.Account.MWM_Grading__c == 'A+' ){
                        
                        //Week1
                        if( initialStartDateTime.date() >  Week1StartDate && initialStartDateTime.date() <=  Week1EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date() , Week1EndDate );
                        
                        }else if( initialStartDateTime.date() < Week1EndDate ){
                            
                            createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                            
                        }      
                        
                        //Week2
                        if( initialStartDateTime.date() >  Week2StartDate && initialStartDateTime.date() <=  Week2EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week2EndDate );
                        
                        }else if( initialStartDateTime.date() < Week2EndDate ){
                            
                        	createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                            
                        } 

                        //Week3
                        if( initialStartDateTime.date() >  Week3StartDate && initialStartDateTime.date() <=  Week3EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week3EndDate );
                        
                        }else if( initialStartDateTime.date() < Week3EndDate ){
                            
                            createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                            
                        }

                        //Week4
                        if( initialStartDateTime.date() >  Week4StartDate && initialStartDateTime.date() <=  Week4EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date() , Week4EndDate );
                        
                        }else if( initialStartDateTime.date() < Week4EndDate ){
                            
                        	createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                            
                        }

                        //Week5
                        if( initialStartDateTime.date() >  Week5StartDate && initialStartDateTime.date() <=  Week5EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week5EndDate );
                        
                        }else if( initialStartDateTime.date() < Week5EndDate ){
                            
                            createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                            
                        }

                        //Week6
                        if( initialStartDateTime.date() >  Week6StartDate && initialStartDateTime.date() <=  Week6EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week6EndDate );
                        
                        }else if( initialStartDateTime.date() < Week6EndDate ){
                            
                            createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                            
                        }

                        //Week7
                        if( initialStartDateTime.date() >  Week7StartDate && initialStartDateTime.date() <=  Week7EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week7EndDate );
                        
                        }else if( initialStartDateTime.date() < Week7EndDate ){
                            
                            createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                            
                        }

                        //Week8
                        if( initialStartDateTime.date() >  Week8StartDate && initialStartDateTime.date() <=  Week8EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week8EndDate );
                        
                        }else if( initialStartDateTime.date() < Week8EndDate ){
                            
                            createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                            
                        }

                        //Week9
                        if( initialStartDateTime.date() >  Week9StartDate && initialStartDateTime.date() <=  Week9EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week9EndDate );
                        
                        }else if( initialStartDateTime.date() < Week9EndDate ){
                            
                            createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                            
                        }

                        //Week10
                        if( initialStartDateTime.date() >  Week10StartDate && initialStartDateTime.date() <=  Week10EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week10EndDate );
                        
                        }else if( initialStartDateTime.date() < Week10EndDate ){
                            
                            createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                            
                        }

                        //Week11
                        if( initialStartDateTime.date() >  Week11StartDate && initialStartDateTime.date() <=  Week11EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week11EndDate );
                        
                        }else if( initialStartDateTime.date() < Week11EndDate ){
                            
                            createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                            
                        }

                        //Week12
                        if( initialStartDateTime.date() >  Week12StartDate && initialStartDateTime.date() <=  Week12EndDate ){
                           
                            createVisitForWeek( retailStore, initialStartDateTime.date(), Week12EndDate );
                        
                        }else if( initialStartDateTime.date() < Week12EndDate ){
                            
                            createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                            
                        }             

                        
                    }else if( retailStore.Account.MWM_Grading__c == 'A' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 2));
                        if( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){
                            
                            //Week1
                            if( initialStartDateTime.date() >  Week1StartDate && initialStartDateTime.date() <=  Week1EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week1EndDate );
                                
                            }else if( initialStartDateTime.date() < Week1EndDate ){
                                
                                createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                                
                            }                            
                            
                            //Week3
                            if( initialStartDateTime.date() >  Week3StartDate && initialStartDateTime.date() <=  Week3EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week3EndDate );
                                
                            }else if( initialStartDateTime.date() < Week3EndDate ){
                                
                                createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                                
                            } 
                            
                            //Week5
                            if( initialStartDateTime.date() >  Week5StartDate && initialStartDateTime.date() <=  Week5EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week5EndDate );
                                
                            }else if( initialStartDateTime.date() < Week5EndDate ){
                                
                                createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                                
                            }            
                            
                            //Week7
                            if( initialStartDateTime.date() >  Week7StartDate && initialStartDateTime.date() <=  Week7EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week7EndDate );
                                
                            }else if( initialStartDateTime.date() < Week7EndDate ){
                                
                                createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                                
                            }     
                            
                            //Week9
                            if( initialStartDateTime.date() >  Week9StartDate && initialStartDateTime.date() <=  Week9EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week9EndDate );
                                
                            }else if( initialStartDateTime.date() < Week9EndDate ){
                                
                                createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                                
                            }  
                            
                            //Week11
                            if( initialStartDateTime.date() >  Week11StartDate && initialStartDateTime.date() <=  Week11EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week11EndDate );
                                
                            }else if( initialStartDateTime.date() < Week11EndDate ){
                                
                                createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                                
                            }      
                            
                        }
                        
                        if( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 ) ) {
                            
                            //Week2
                            if( initialStartDateTime.date() >  Week2StartDate && initialStartDateTime.date() <=  Week2EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week2EndDate );
                                
                            }else if( initialStartDateTime.date() < Week2EndDate ){
                                
                                createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                                
                            }     
                            
                            //Week4
                            if( initialStartDateTime.date() >  Week4StartDate && initialStartDateTime.date() <=  Week4EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week4EndDate );
                                
                            }else if( initialStartDateTime.date() < Week4EndDate ){
                                
                                createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                                
                            }          
                            
                            //Week6
                            if( initialStartDateTime.date() >  Week6StartDate && initialStartDateTime.date() <=  Week6EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week6EndDate );
                                
                            }else if( initialStartDateTime.date() < Week6EndDate ){
                                
                                createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                                
                            }    
                            
                            //Week8
                            if( initialStartDateTime.date() >  Week8StartDate && initialStartDateTime.date() <=  Week8EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week8EndDate );
                                
                            }else if( initialStartDateTime.date() < Week8EndDate ){
                                
                                createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                                
                            }                            
                            //Week10
                            if( initialStartDateTime.date() >  Week10StartDate && initialStartDateTime.date() <=  Week10EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week10EndDate );
                                
                            }else if( initialStartDateTime.date() < Week10EndDate ){
                                
                                createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                                
                            } 
                            
                            //Week12
                            if( initialStartDateTime.date() >  Week12StartDate && initialStartDateTime.date() <=  Week12EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week12EndDate );
                                
                            }else if( initialStartDateTime.date() < Week12EndDate ){
                                
                                createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                                
                            }                                    
                        }
                        

                        
                    }else if( retailStore.Account.MWM_Grading__c == 'B' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 3));
                        if( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){      
                            
                            //Week1
                            if( initialStartDateTime.date() >  Week1StartDate && initialStartDateTime.date() <=  Week1EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week1EndDate );
                                
                            }else if( initialStartDateTime.date() < Week1EndDate ){
                                
                                createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                                
                            }
                            
                            //Week4
                            if( initialStartDateTime.date() >  Week4StartDate && initialStartDateTime.date() <=  Week4EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week4EndDate );
                                
                            }else if( initialStartDateTime.date() < Week4EndDate ){
                                
                                createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                                
                            }      
                            
                            //week7
                            if( initialStartDateTime.date() >  Week7StartDate && initialStartDateTime.date() <=  Week7EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week7EndDate );
                                
                            }else if( initialStartDateTime.date() < Week7EndDate ){
                                
                                createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                                
                            }        
                            
                            //Week10
                            if( initialStartDateTime.date() >  Week10StartDate && initialStartDateTime.date() <=  Week10EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week10EndDate );
                                
                            }else if( initialStartDateTime.date() < Week10EndDate ){
                                
                                createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                                
                            }                             
                        
                        }
                        
                        if( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 ) ){
                        	
                            //Week2
                            if( initialStartDateTime.date() >  Week2StartDate && initialStartDateTime.date() <=  Week2EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week2EndDate );
                                
                            }else if( initialStartDateTime.date() < Week2EndDate ){
                                
                                createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                                
                            }
                            
                            //Week5
                            if( initialStartDateTime.date() >  Week5StartDate && initialStartDateTime.date() <=  Week5EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week5EndDate );
                                
                            }else if( initialStartDateTime.date() < Week5EndDate ){
                                
                                createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                                
                            }
                            
                            //Week8
                            if( initialStartDateTime.date() >  Week8StartDate && initialStartDateTime.date() <=  Week8EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week8EndDate );
                                
                            }else if( initialStartDateTime.date() < Week8EndDate ){
                                
                                createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                                
                            }   
                            
                            //Week11
                            if( initialStartDateTime.date() >  Week11StartDate && initialStartDateTime.date() <=  Week11EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week11EndDate );
                                
                            }else if( initialStartDateTime.date() < Week11EndDate ){
                                
                                createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                                
                            }                            
                        
                        }
                        
                        if ( randomNumber == 2 || (test.isRunningTest() && testRandomInteger == 2 ) ){ 
                        
                            //Week3
                            if( initialStartDateTime.date() >  Week3StartDate && initialStartDateTime.date() <=  Week3EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week3EndDate );
                                
                            }else if( initialStartDateTime.date() < Week3EndDate ){
                                
                                createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                                
                            } 
                            
                            //Week6
                            if( initialStartDateTime.date() >  Week6StartDate && initialStartDateTime.date() <=  Week6EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week6EndDate );
                                
                            }else if( initialStartDateTime.date() < Week6EndDate ){
                                
                                createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                                
                            } 
                            
                            //Week9
                            if( initialStartDateTime.date() >  Week9StartDate && initialStartDateTime.date() <=  Week9EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week9EndDate );
                                
                            }else if( initialStartDateTime.date() < Week9EndDate ){
                                
                                createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                                
                            }     
                            
                            //Week12
                            if( initialStartDateTime.date() >  Week12StartDate && initialStartDateTime.date() <=  Week12EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week12EndDate );
                                
                            }else if( initialStartDateTime.date() < Week12EndDate ){
                                
                                createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                                
                            }                                
                        }
                        
                    }else if( retailStore.Account.MWM_Grading__c == 'C' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 6));
                        
                        if( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){
                        	
                            //Week1
                            if( initialStartDateTime.date() >  Week1StartDate && initialStartDateTime.date() <=  Week1EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week1EndDate );
                                
                            }else if( initialStartDateTime.date() < Week1EndDate ){
                                
                                createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                                
                            }         
                            
                            //Week7
                            createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                            
                        
                        }
                        
                        if( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 ) ){
                        
                            //Week2
                            if( initialStartDateTime.date() >  Week2StartDate && initialStartDateTime.date() <=  Week2EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week2EndDate );
                                
                            }else if( initialStartDateTime.date() < Week2EndDate ){
                                
                                createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                                
                            }
                            
                            //Week8
                            if( initialStartDateTime.date() >  Week8StartDate && initialStartDateTime.date() <=  Week8EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week8EndDate );
                                
                            }else if( initialStartDateTime.date() < Week8EndDate ){
                                
                                createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                                
                            }                            
                        
                        }
                        
                        if( randomNumber == 2 || (test.isRunningTest() && testRandomInteger == 2 ) ){    
                            
                            //Week3
                            if( initialStartDateTime.date() >  Week3StartDate && initialStartDateTime.date() <=  Week3EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week3EndDate );
                                
                            }else if( initialStartDateTime.date() < Week3EndDate ){
                                
                                createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                                
                            } 
                            
                            //Week9
                            if( initialStartDateTime.date() >  Week9StartDate && initialStartDateTime.date() <=  Week9EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week9EndDate );
                                
                            }else if( initialStartDateTime.date() < Week9EndDate ){
                                
                                createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                                
                            }                            
                   	    
                        }
                        
                        if( randomNumber == 3 || (test.isRunningTest() && testRandomInteger == 3 ) ){	
                        	
                            //Week4
                            if( initialStartDateTime.date() >  Week4StartDate && initialStartDateTime.date() <=  Week4EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date() , Week4EndDate );
                                
                            }else if( initialStartDateTime.date() < Week4EndDate ){
                                
                                createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                                
                            }   
                            
                            //Week10
                            if( initialStartDateTime.date() >  Week10StartDate && initialStartDateTime.date() <=  Week10EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week10EndDate );
                                
                            }else if( initialStartDateTime.date() < Week10EndDate ){
                                
                                createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                                
                            }                             
                        
                        }
                        
                        if( randomNumber == 4 || (test.isRunningTest() && testRandomInteger == 4 ) ){    
                        
                            //Week5
                            if( initialStartDateTime.date() >  Week5StartDate && initialStartDateTime.date() <=  Week5EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week5EndDate );
                                
                            }else if( initialStartDateTime.date() < Week5EndDate ){
                                
                                createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                                
                            }
                            
                            //Week11
                            if( initialStartDateTime.date() >  Week11StartDate && initialStartDateTime.date() <=  Week11EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week11EndDate );
                                
                            }else if( initialStartDateTime.date() < Week11EndDate ){
                                
                                createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                                
                            }                            
                        
                        }
                        
                        if ( randomNumber == 5 || (test.isRunningTest() && testRandomInteger == 5 ) ) {    
                         
                            //Week6
                            if( initialStartDateTime.date() >  Week6StartDate && initialStartDateTime.date() <=  Week6EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week6EndDate );
                                
                            }else if( initialStartDateTime.date() < Week6EndDate ){
                                
                                createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                                
                            }  
                            
                            //Week12
                            if( initialStartDateTime.date() >  Week12StartDate && initialStartDateTime.date() <=  Week12EndDate ){
                                
                                createVisitForWeek( retailStore, initialStartDateTime.date(), Week12EndDate );
                                
                            }else if( initialStartDateTime.date() < Week12EndDate ){
                                
                                createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                                
                            }      
                            
                        }
                        
                    }
                    
                    
                }else{
                    //Create visits asa normal
                    
                    if( retailStore.Account.MWM_Grading__c == 'A+' ){

                        createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                        createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                        createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                        createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                        createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                        createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                        createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                        createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                        createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                        createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                        createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                        createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );

                        
                    }else if( retailStore.Account.MWM_Grading__c == 'A' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 2));
                        If( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){
                            
                            createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                            createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                            createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                            createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                            createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                            createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                            
                        }
                        
                        if ( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 )){
                            
                            createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                            createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                            createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                            createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                            createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                            createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                                
                        }
                        

                        
                    }else if( retailStore.Account.MWM_Grading__c == 'B' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 3));
                        if( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){
                            createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                            createVisitForWeek( retailStore, Week4StartDate, Week4EndDate );
                            createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                            createVisitForWeek( retailStore, Week10StartDate, Week10EndDate ); 
                        
                        }
                        
                        if( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 )){
                        
                        	createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                        	createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                        	createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                            createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                        
                        }
                        
                        if(  randomNumber == 2 || (test.isRunningTest() && testRandomInteger == 2 ) ){ 
                        
                            createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                            createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                            createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                            createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );   
                        }
                        
                    }else if( retailStore.Account.MWM_Grading__c == 'C' ){
                        
                        Integer randomNumber = Integer.valueof((Math.random() * 6));
                        
                        if( randomNumber == 0 || (test.isRunningTest() && testRandomInteger == 0 ) ){
                        
                            createVisitForWeek( retailStore, Week1StartDate, Week1EndDate );
                            createVisitForWeek( retailStore, Week7StartDate, Week7EndDate );
                        
                        } 
                        
                        if( randomNumber == 1 || (test.isRunningTest() && testRandomInteger == 1 ) ){
                        
                            createVisitForWeek( retailStore, Week2StartDate, Week2EndDate );
                            createVisitForWeek( retailStore, Week8StartDate, Week8EndDate );
                        
                        }
                        
                        if( randomNumber == 2 || (test.isRunningTest() && testRandomInteger == 2 ) ){    
                            
                        	createVisitForWeek( retailStore, Week3StartDate, Week3EndDate );
                            createVisitForWeek( retailStore, Week9StartDate, Week9EndDate );
                   	    
                        }
                        
                        if( randomNumber == 3 || (test.isRunningTest() && testRandomInteger == 3 ) ){	
                        
                            createVisitForWeek( retailStore, Week4StartDate, Week6EndDate );
                            createVisitForWeek( retailStore, Week10StartDate, Week10EndDate );
                        
                        }
                        
                        if( randomNumber == 4 || (test.isRunningTest() && testRandomInteger == 4 ) ){    
                        
                            createVisitForWeek( retailStore, Week5StartDate, Week5EndDate );
                            createVisitForWeek( retailStore, Week11StartDate, Week11EndDate );
                        
                        }
                        
                        if( randomNumber == 5 || (test.isRunningTest() && testRandomInteger == 5 ) ){    
                         
                            createVisitForWeek( retailStore, Week6StartDate, Week6EndDate );
                            createVisitForWeek( retailStore, Week12StartDate, Week12EndDate );
                        
                        }
                    }
                        
                        
                    
                } //end else initialStartDateTime != null 
                
            }	
            
        } //for retail store	
        
    }//end execute
    
    public void finish(Database.BatchableContext bc){
        System.debug('The Batch execution for creating Visits for this quarter has completed.');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        try{
       		sendFinishEmail();
        }catch ( Exception e){
            System.debug('Email could not be sent.');
        }

    }
    

    public static void sendStartEmail(  ){
        //We instantiate our single email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {};
		List<Profile> userProfile = [select id from profile where Name='System Administrator'];
        // getting email template id
        for(User sysAdminUser :[Select id, Email from user where ProfileID IN:userProfile]) {   
        	toAddresses.add( sysAdminUser.Email ); 
        }        
           
       //Assign the TO address to our mail object
       mail.setToAddresses(toAddresses);

       // Specify the name used as the display name.
       mail.setSenderDisplayName('Meridian Wines');

       // Set the subject line for your email address.
       mail.setSubject('Autovisit - Batch Execution : ' + System.now() );

       // You can specify your plain text here
       mail.setPlainTextBody('Dear user, the batch execution for auto visit creation for this quarter has started. Kind Regards, Meridian Wines');

       //Specify any html - for example this will display a link in the email
       mail.setHtmlBody('<p>Dear User,</p> <br/> <p>The batch execution for auto visit creation has started. </p> <p>Kind regards, <br/> Meridian Wines </p>');

       // Send the email
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
        
    }
    
   	public static void sendFinishEmail( ){
        
        //We instantiate our single email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {};
		List<Profile> userProfile = [select id from profile where Name='System Administrator'];
        // getting email template id
        for(User sysAdminUser :[Select id, Email from user where ProfileID IN:userProfile]) {   
        	toAddresses.add( sysAdminUser.Email ); 
        }        

       // Specify the name used as the display name.
       mail.setSenderDisplayName('Meridian Wines');

       // Set the subject line for your email address.
       mail.setSubject('Autovisit - Batch Execution : ' + System.now() );

       // You can specify your plain text here
       mail.setPlainTextBody('Dear User, The batch execution for auto visit creation has been completed. Kindly review the created visits in the following link, https://meridianwines--partial.lightning.force.com/lightning/o/Visit/list?filterName=00B2X00000AU5nNUAT');

       //Specify any html - for example this will display a link in the email
       mail.setHtmlBody('<p>Dear User,</p> <p>The batch execution for auto visit creation has been completed. Kindly review the created visits in the following <a href=\'https://meridianwines--partial.lightning.force.com/lightning/o/Visit/list?filterName=00B2X00000AU5nNUAT\' >list view</a> </p><p>Kind regards,<br/>Meridian Wines</p>');

       // Send the email
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }    
    
    
    public static Visit initialiseVisit( RetailStore thisRetailStore ){
        
        Visit newVisit = new Visit();
        newVisit.AccountId = thisRetailStore.AccountId;
        newVisit.OwnerId = thisRetailStore.OwnerId;
        newVisit.PlaceId = thisRetailStore.Id;
        newVisit.Visit_Type__c = 'Audit'; 
                
        return newVisit;
            
    }
    
    public ActionPlanTemplateVersion getActionPlanTemplateVersion( String templateName ){
        
        List<ActionPlanTemplateVersion> templateVersions = new List<ActionPlanTemplateVersion>();
        
        if( Test.isRunningTest() == True ){ 
        	templateVersions = [SELECT Id, Name, ActionPlanTemplateId, Status 
                                                            FROM   ActionPlanTemplateVersion 
                                                            WHERE  Name =: templateName LIMIT 1 ];
        }else{
            
            templateVersions = [SELECT Id, Name, ActionPlanTemplateId, Status 
                                                            FROM   ActionPlanTemplateVersion 
                                                            WHERE  Name =: templateName 
                                                            AND    Status = 'Final' LIMIT 1 ];
        }
        
        
        
        System.debug('Action Plan Template: ' + templateVersion );
        
        
        //check if the list is empty
        if( templateVersions.isEmpty() == False ){
            //return the first item in the list    
            return templateVersions.get(0);
            
        }else{
            //return null if empty
            return null;
        }
        
        
    }
    
}