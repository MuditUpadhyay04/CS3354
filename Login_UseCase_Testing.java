import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;


class Login_UseCase_Testing {


    @Test
    void login_TC1() {
        // Valid username and valid password
        assertEquals("Login successful", Login.login("student1@utdallas.edu", "Pass123!"));
    }


    @Test
    void login_TC2() {
        // Valid username and invalid password
        assertEquals("Invalid password, please try again.", Login.login("student1@utdallas.edu", "wrongpass"));
    }


    @Test
    void login_TC3() {
        // Valid username and exceptional password (e.g., null)
        assertEquals("Password cannot be null or empty.", Login.login("student1@utdallas.edu", null));
    }


    @Test
    void login_TC4() {
        // Invalid username and valid password
        assertEquals("Invalid username, please try again.", Login.login("invalidUser@utdallas.edu", "Pass123!"));
    }


    @Test
    void login_TC5() {
        // Exceptional username (e.g., null) and valid password
        assertEquals("Username cannot be null or empty.", Login.login(null, "Pass123!"));
    }
}
