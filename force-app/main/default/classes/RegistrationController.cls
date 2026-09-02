public with sharing class RegistrationController {
    @AuraEnabled
    public static void registerUser(Map<String,String> userData) {
        try {
            // Process data or map to a custom/standard Object.
            Contact newContact = new Contact(
                FirstName = userData.get('firstName'),
                LastName  = userData.get('lastName'),
                Email     = userData.get('email'),
                Phone     = userData.get('phoneNumber')
            );
            insert newContact; 
        } catch (Exception e) {
            throw new AuraHandledException('Registration failed: ' + e.getMessage());
        }
    }
}