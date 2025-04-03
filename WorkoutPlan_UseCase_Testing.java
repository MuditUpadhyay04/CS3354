
import org.junit.jupiter.api.Test;
import java.util.Arrays;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;


class WorkoutPlan_UseCase_Testing {
    @Test
    void createWorkoutPlan_TC1() {
        // Valid split and valid exercises (one from each muscle group)
        List<String> exercises = Arrays.asList("Bench Press", "Bicep Curl", "Triceps Extension", "Pull-Up", "Overhead Press", "Squat");
        assertEquals("Workout plan created successfully!", WorkoutPlan.createWorkoutPlan("Push/Pull/Legs", exercises));
    }


    @Test
    void createWorkoutPlan_TC2() {
        // Valid split and invalid exercises
        List<String> exercises = Arrays.asList("Bench Press", "Invalid Exercise");
        assertEquals("Invalid exercise(s) detected. Please choose valid exercises.", WorkoutPlan.createWorkoutPlan("Push/Pull/Legs", exercises));
    }


    @Test
    void createWorkoutPlan_TC3() {
        // Valid split and exceptional exercises
        assertEquals("Exercises cannot be null or empty.", WorkoutPlan.createWorkoutPlan("Push/Pull/Legs", null));
    }


    @Test
    void createWorkoutPlan_TC4() {
        // Invalid split and valid exercises
        List<String> exercises = Arrays.asList("Bench Press", "Bicep Curl", "Triceps Extension", "Pull-Up", "Overhead Press", "Squat");
        assertEquals("Invalid split. Please choose from: [Push/Pull/Legs, Bro, Upper/Lower]", WorkoutPlan.createWorkoutPlan("Invalid Split", exercises));
    }


    @Test
    void createWorkoutPlan_TC5() {
        // Exceptional split and valid exercises
        List<String> exercises = Arrays.asList("Bench Press", "Bicep Curl", "Triceps Extension", "Pull-Up", "Overhead Press", "Squat");
        assertEquals("Split cannot be null or empty.", WorkoutPlan.createWorkoutPlan(null, exercises));
    }
}












