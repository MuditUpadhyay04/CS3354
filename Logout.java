
import java.util.HashSet;


public class Logout {


    // Simulating active user sessions
    private static final HashSet<String> activeSessions = new HashSet<>();


    // Dummy data: Preload some active sessions
    static {
        activeSessions.add("123123123"); // Active session
        // "999999999" not added to simulate a logged-out session
    }


    public static String loggout(String sessionId) {
        if (sessionId == null || sessionId.isEmpty()) {
            return "Invalid session";
        }


        if (!activeSessions.contains(sessionId)) {
            return "No active session found";
        }


        activeSessions.remove(sessionId);
        return "Logout successful";
    }
}
