import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class RegisterUser_UseCase_Testing {

    // All valid inputs
    @Test
    void register_TC1_Valid_All() {
        assertEquals("Registration successful", RegisterUser.register("student@utdallas.edu", "Pass@123", "25"));
    }

    // Invalid combinations (1 invalid, 2 valid)
    @Test
    void register_TC2_InvalidEmail() {
        assertEquals("Invalid email", RegisterUser.register("user@gmail.com", "Pass@123", "25"));
    }

    @Test
    void register_TC3_InvalidPassword() {
        assertEquals("Invalid password", RegisterUser.register("student@utdallas.edu", "password", "25"));
    }

    @Test
    void register_TC4_InvalidAge() {
        assertEquals("Invalid age", RegisterUser.register("student@utdallas.edu", "Pass@123", "17"));
    }

    // Exceptional combinations (1 exceptional, 2 valid)
    @Test
    void register_TC5_ExceptionalEmail_Null() {
        assertEquals("Invalid email", RegisterUser.register(null, "Pass@123", "25"));
    }

    @Test
    void register_TC6_ExceptionalPassword_Null() {
        assertEquals("Invalid password", RegisterUser.register("student@utdallas.edu", null, "25"));
    }

    @Test
    void register_TC7_ExceptionalAge_NonNumeric() {
        assertEquals("Invalid age", RegisterUser.register("student@utdallas.edu", "Pass@123", "twenty"));
    }
}
