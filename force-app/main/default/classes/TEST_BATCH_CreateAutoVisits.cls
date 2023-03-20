@isTest
public class TEST_BATCH_CreateAutoVisits {
    
    @testSetup static void retalStoreSetup() {
        
        List<Account> newAccs = new List<Account>();
        
        ActionPlanTemplate actPlanTemp = new ActionPlantemplate();
        actPlanTemp.Name = 'Standard Visit Template' ;
        actPlanTemp.TargetEntityType = 'Visit' ;
        actPlanTemp.IsAdHocItemCreationEnabled = True;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorggdlsfjy.com');

        System.runAs(u) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId());         
        
            Account accMWMAPlus = new Account();
            accMWMAPlus.Name = 'Test Account 1';
            accMWMAPlus.Billing_Street__c = '1 Account Street';
            accMWMAPlus.MWM_Grading__c = 'A+';
            accMWMAPlus.OwnerId = u.Id; 
           
            System.debug( 'OwnerId: ' + accMWMAPlus.OwnerId );
            
            newAccs.add( accMWMAPlus);
            
            Account accMWMA = new Account();
            accMWMA.Name = 'MWM A Account';
            accMWMA.Billing_Street__c = 'A Account Street';
            accMWMA.MWM_Grading__c = 'A';
            
            newAccs.add( accMWMA );
            
            Account accMWMB = new Account();
            accMWMB.Name = 'MWM B Account';
            accMWMB.Billing_Street__c = 'B Account Street';
            accMWMB.MWM_Grading__c = 'B';
            
            newAccs.add( accMWMB );
            
            Account accMWMC = new Account();
            accMWMC.Name = 'MWM C Test Account';
            accMWMC.Billing_Street__c = 'C Account Street';
            accMWMC.MWM_Grading__c = 'C';
            
            newAccs.add( accMWMC );
            
            insert newAccs;
            
            List<RetailStore> newRetailStores = new List<RetailStore>();		
            
            RetailStore rsMWMAPlus1 = new RetailStore();
            rsMWMAPlus1.AccountId  =  accMWMAPlus.Id;
            rsMWMAPlus1.Name = 'A Plus 1 Retail Store';
            rsMWMAPlus1.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            
            newRetailStores.add( rsMWMAPlus1 );
            
            RetailStore rsMWMAPlus2 = new RetailStore();
            rsMWMAPlus2.AccountId  =  accMWMAPlus.Id;
            rsMWMAPlus2.Name = 'A Plus 2 Retail Store';
            rsMWMAPlus2.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            newRetailStores.add( rsMWMAPlus2 );
            
            
            RetailStore rsMWMA = new RetailStore();
            rsMWMA.AccountId  =  accMWMA.Id;
            rsMWMA.Name = 'A Retail Store';
            rsMWMA.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            newRetailStores.add( rsMWMA );            
            
            RetailStore rsMWMB = new RetailStore();
            rsMWMB.AccountId  =  accMWMB.Id;
            rsMWMB.Name = 'B Retail Store';
            rsMWMB.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            newRetailStores.add( rsMWMB );
            
            RetailStore rsMWMC = new RetailStore();
            rsMWMC.AccountId  =  accMWMC.Id;
            rsMWMC.Name = 'C Retail Store';
            rsMWMC.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            newRetailStores.add( rsMWMC );
            
            RetailStore rsMWMD = new RetailStore();
            rsMWMD.AccountId  =  accMWMAPlus.Id;
            rsMWMD.Name = '1 Account Street';
            rsMWMD.Auto_Visit_Planned_Date_Time__c = Datetime.newInstanceGmt(System.today().year(), 1, 1, 12, 0, 0);
            newRetailStores.add( rsMWMD );
            
            insert newRetailStores;
        
        }
        
	}
    
	@isTest
    public static void testVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits(  );
        Database.executeBatch( b , 10);
    }
    
    @isTest
    public static void testManuallyRunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now() );
        Database.executeBatch( b , 10);
    }
    
    @isTest
    public static void testManuallyRunQ1VisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( DateTime.newInstance(System.today().year(), 7, 1, 0, 0, 0) );
        Database.executeBatch( b , 10);
    }
    
    @isTest
    public static void testManuallyRunQ2VisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( DateTime.newInstance(System.today().year(), 10, 1, 0, 0, 0) );
        Database.executeBatch( b , 10);
    }
    
    @isTest
    public static void testManuallyRunQ3VisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( DateTime.newInstance(System.today().year(), 1, 1, 0, 0, 0) );
        Database.executeBatch( b , 10);
    }
    
    @isTest
    public static void testManuallyRunQ4VisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( DateTime.newInstance(System.today().year(), 4, 1, 0, 0, 0) );
        Database.executeBatch( b , 10);
    }
    
    @isTest
        public static void testRand0RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 0 );
        Database.executeBatch( b , 10);
            
    }
    
    @isTest
        public static void testRand1RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 1 );
        Database.executeBatch( b , 10);
            
    }
    
    @isTest
        public static void testRand2RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 2 );
        Database.executeBatch( b , 10);
            
    }    
    
    @isTest
        public static void testRand3RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 3 );
        Database.executeBatch( b , 10);
            
    } 
    
    @isTest
        public static void testRand4RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 4 );
        Database.executeBatch( b , 10);
            
    }    
    
    @isTest
        public static void testRand5RunVisitsCreation(){
        
        BATCH_CreateAutoVisits b = new BATCH_CreateAutoVisits( System.now(), 5 );
        Database.executeBatch( b , 10);
            
    } 
    
    
}