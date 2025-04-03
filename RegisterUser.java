public class RegisterUser {

    public static String register(String email, String password, String ageStr) {
        if (!isValidEmail(email)) {
            return "Invalid email";
        }
        if (!isValidPassword(password)) {
            return "Invalid password";
        }
        if (!isValidAge(ageStr)) {
            return "Invalid age";
        }
        return "Registration successful";
    }

    public static boolean isValidEmail(String email) {
        if (email == null || !email.endsWith("@utdallas.edu")) {
            return false;
        }

        int length = email.length();
        return length >= 8 && length <= 256;
    }

    public static boolean isValidPassword(String password) {
        if (password == null) return false;

        int length = password.length();
        if (length < 8 || length > 12) return false;

        // At least one special character (from common symbols)
        return password.matches(".*[!@#$%^&*(),.?\":{}|<>].*");
    }

    public static boolean isValidAge(String ageStr) {
        try {
            int age = Integer.parseInt(ageStr);
            return age >= 18 && age <= 65;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
