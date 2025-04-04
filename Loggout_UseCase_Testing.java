
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;


class Loggout_UseCase_Testing {


    @Test
    void loggout_TC1() { // User is logged in (valid)
        assertEquals("Logout successful", Logout.loggout("123123123"));
    }


    @Test
    void loggout_TC2() { // User is not logged in(Invalid)
        assertEquals("No active session found", Logout.loggout("999999999"));
    }


    @Test
    void loggout_TC3() { // Session input is null(Exceptional)
        assertEquals("Invalid session", Logout.loggout(null));
    }

}








