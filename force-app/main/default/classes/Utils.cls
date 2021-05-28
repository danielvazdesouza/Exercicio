public with sharing class Utils {
    public Boolean validaCNPJ(String value){
        if (value.length() == 14) {
            return true;            
        } else {
            return false;
        }
    }

    public Boolean validaCPF(String value){
        if (value.length() == 11) {
            return true;            
        } else {
            return false;
        }
    }
}