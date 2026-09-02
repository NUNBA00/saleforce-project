trigger ContentVersionRestrictionTrigger on ContentVersion (before insert) {
    for (ContentVersion cv : Trigger.new) {
        // Handle files with extensions
        if (cv.PathOnClient != null) {
            String filename = cv.PathOnClient.toLowerCase();

            // Extract the text after the last period safely
            Integer lastPeriodIndex = fileName.lastIndexOf('.');

            if (lastPeriodIndex != -1) {
                String ext = fileName.substring(lastPeriodIndex + 1);

            if (ext != 'pdf' && ext != 'docx' && ext != 'xlsx') {
                cv.addError('Upload Blocked: This system only accepts PDF, Word (.docx), and Excel (.xlsx) files.');
            }
        } 
        // Catch files uploaded without an extension at all
        else {
            cv.addError('Upload Blocked: Files must have a valid extension (.pdf, .docx, .xlsx).');
        }
    }
}
}