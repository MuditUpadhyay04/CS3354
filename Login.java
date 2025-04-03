

import java.util.regex.Pattern;


public class Login {


    // Simulated database of valid usernames and passwords
    private static final String[][] validCredentials = {
            {"student1@utdallas.edu", "Pass123!"},
            {"student2@utdallas.edu", "Hello123@"},
            {"student3@utdallas.edu", "World456#"},
            {"student4@utdallas.edu", "UTD789$"},
            {"student5@utdallas.edu", "Dallas321%"},
            {"student6@utdallas.edu", "Secure987&"},
            {"student7@utdallas.edu", "Strong456*"},
            {"student8@utdallas.edu", "Alpha123+"},
            {"student9@utdallas.edu", "Beta456!"},
            {"student10@utdallas.edu", "Gamma789@"}
    };


    public static boolean isValidUsername(String username) {
        if (username == null || username.isEmpty()) {
            return false;
        }


        if (!username.endsWith("@utdallas.edu")) {
            return false;
        }


        if(username.length() < 8 || username.length() > 256) {
            return false;
        }


        return true;
    }


    public static boolean isValidPassword(String password) {
        if (password == null || password.isEmpty()) {
            return false;
        }


        if (password.length() < 8 || password.length() > 12) {
            return false;
        }


        String regex = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,12}$";
        Pattern pattern = Pattern.compile(regex);
        return pattern.matcher(password).matches();
    }


    public static boolean doesUserExist(String username) {
        for (String[] credentials : validCredentials) {
            if (credentials[0].equals(username)) {
                return true;
            }
        }
        return false;
    }


    public static boolean isPasswordCorrect(String username, String password) {
        for (String[] credentials : validCredentials) {
            if (credentials[0].equals(username) && credentials[1].equals(password)) {
                return true;
            }
        }
        return false;
    }


    public static String login(String username, String password) {
        if (!isValidUsername(username)) {
            return "Username cannot be null or empty.";
        }


        // Check for null or empty password first
        if (password == null || password.isEmpty()) {
            return "Password cannot be null or empty.";
        }


        if (!isValidPassword(password)) {
            return "Invalid password, please try again.";
        }




        if (!doesUserExist(username)) {
            return "Invalid username, please try again.";
        }


        if (!isPasswordCorrect(username, password)) {
            return "Invalid password, please try again.";
        }


        return "Login successful";
    }
}
